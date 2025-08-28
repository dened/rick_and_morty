#version 460 core

#include "common/common.glsl"
#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;        // время с момента старта анимации
uniform sampler2D uTex;

out vec4 oColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uResolution;

    // Длительность анимации в секундах
    float duration = 3.5;
    float progress = clamp(uTime / duration, 0.0, 1.0);

    // Сглаживаем кривую прогресса для более мягкого начала и конца
    progress = progress * progress * (3.0 - 2.0 * progress);

    // Генерируем "карту шума", которая определит порядок рассыпания пикселей.
    // Пиксели с меньшим значением шума начнут рассыпаться раньше.
    float noise = (hash_2d(uv * vec2(15.0, 45.0)) + 1.0) * 0.5;

    // Если прогресс анимации еще не достиг "порога" для этого пикселя,
    // рисуем его без изменений.
    if (progress < noise) {
        oColor = texture(uTex, uv);
        return;
    }

    // Этот пиксель "рассыпается".
    // Вычисляем, насколько далеко зашел процесс рассыпания для этого пикселя (от 0.0 до 1.0).
    // Это значение будет управлять смещением и затуханием частицы.
    float dissolve_progress = (progress - noise) / (1.0 - noise);
    dissolve_progress = pow(dissolve_progress, 2.0); // Ускоряем в начале

    // Смещение частицы (эффект гравитации и легкого ветра).
    vec2 offset = vec2(0.0);
    offset.y += dissolve_progress * dissolve_progress * 0.4; // Ускоренное падение вниз

    // Добавляем немного горизонтальной "турбулентности".
    float turbulence = (hash_2d(uv * 12.3) * 2.0 - 1.0) * 0.03;
    offset.x += turbulence * dissolve_progress;

    // Сэмплируем цвет в смещенной позиции, чтобы частица "двигалась".
    vec4 texColor = texture(uTex, uv + offset);

    // Частица становится полностью прозрачной к концу своего пути.
    float alpha = 1.0 - dissolve_progress;
    alpha = pow(alpha, 3.0); // Затухание становится резче к концу.

    // Корректировка для premultiplied alpha, чтобы избежать темных артефактов
    // на краях прозрачных текстур.
    if (texColor.a > 0.0) {
        texColor.rgb /= texColor.a;
    }
    oColor = vec4(texColor.rgb, texColor.a * alpha);
    oColor.rgb *= oColor.a;
}
