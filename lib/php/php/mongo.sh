# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

generate_mongo_ini() {
  
  # Report back to the user
  report_mongo_settings
  
  nos_template \
    "php/php.d/mongo.ini.mustache" \
    "$(nos_etc_dir)/php.prod.d/mongo.ini" \
    "$(mongo_ini_payload)"
}

generate_dev_mongo_ini() {
  nos_template \
    "php/php.d/mongo.ini.mustache" \
    "$(nos_etc_dir)/php.dev.d/mongo.ini" \
    "$(mongo_ini_payload)"
}

report_mongo_settings() {
  nos_print_bullet_sub "Native long: $(mongo_native_long)"
  nos_print_bullet_sub "Allow empty keys: $(mongo_allow_empty_keys)"
  nos_print_bullet_sub "Cmd: $(mongo_cmd)"
  nos_print_bullet_sub "Long as object: $(mongo_long_as_object)"  
}

mongo_ini_payload() {
  cat <<-END
{
  "mongo_native_long": "$(mongo_native_long)",
  "mongo_allow_empty_keys": "$(mongo_allow_empty_keys)",
  "mongo_cmd": "$(mongo_cmd)",
  "mongo_long_as_object": "$(mongo_long_as_object)"
}
END
}

mongo_native_long() {
  # boxfile mongo_native_long
  _mongo_native_long=$(nos_validate "$(nos_payload config_mongo_native_long)" "integer" "1")
  echo "$_mongo_native_long"
}

mongo_allow_empty_keys() {
  # boxfile mongo_allow_empty_keys
  _mongo_allow_empty_keys=$(nos_validate "$(nos_payload config_mongo_allow_empty_keys)" "integer" "0")
  echo "$_mongo_allow_empty_keys"
}

mongo_cmd() {
  # boxfile mongo_cmd
  _mongo_cmd=$(nos_validate "$(nos_payload config_mongo_cmd)" "string" "\$")
  echo "$_mongo_cmd"
}

mongo_long_as_object() {
  # boxfile mongo_long_as_object
  _mongo_long_as_object=$(nos_validate "$(nos_payload config_mongo_long_as_object)" "integer" "0")
  echo "$_mongo_long_as_object"
}
