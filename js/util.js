// 配列をHashMapに変換
const r_id_key_charge_types = Object.fromEntries(this.o_model.r_reserve_charge_types.map(o => [o.i_charge_type_for_course_cd, o.s_charge_type_name]));