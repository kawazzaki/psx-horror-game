shader_type spatial;
render_mode depth_prepass_alpha, cull_disabled;
// إذا لاحظت مشاكل شفافية جرّب: render_mode depth_draw_always, cull_disabled

// اللون الأساسي
uniform vec4 albedo : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform sampler2D texture_albedo : hint_default_white;

// إعدادات التوهج
uniform vec4 emission_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float emission_amount : hint_range(0,10) = 2.0;

// خامة الذوبان (عادة Noise)
uniform sampler2D dissolve_texture;
uniform float burn_size : hint_range(0,2) = 0.1;
uniform float dissolve_amount : hint_range(0,1) = 0.0;

void fragment() {
    // قراءة لون + ألفا من صورة الـ PNG
    vec4 albedo_tex = texture(texture_albedo, UV);
    ALBEDO = albedo.rgb * albedo_tex.rgb;

    // أخذ قيمة noise من خامة الذوبان
    float sample = texture(dissolve_texture, UV).r;

    // حساب التوهج على الحواف
    float emission_value = 1.0 - smoothstep(dissolve_amount, dissolve_amount + burn_size, sample);
    EMISSION = emission_value * emission_amount * emission_color.rgb;

    // الشفافية (ألفا من الصورة × تأثير الذوبان)
    float dissolve_alpha = smoothstep(dissolve_amount - burn_size, dissolve_amount, sample);
    ALPHA = albedo_tex.a * dissolve_alpha;
}
