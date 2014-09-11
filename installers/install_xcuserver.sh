#!/bin/bash

function print_and_do_command {
  echo "-> $ $@"
  $@
}

function print_and_do_command_exit_on_error {
  print_and_do_command $@
  if [ $? -ne 0 ]; then
    echo " [!] Failed!"
    exit 1
  fi
}

bitrise_tools_dir="${HOME}/bitrise/tools"
xcuserver_base_dir="${bitrise_tools_dir}/xcuserver"
xcuserver_install_script_path="${xcuserver_base_dir}/_scripts/install_launchctl_plist_for_current_user.sh"

echo " (i) xcuserver_base_dir: ${xcuserver_base_dir}"
echo " (i) xcuserver_install_script_path: ${xcuserver_install_script_path}"

print_and_do_command_exit_on_error mkdir -p "${bitrise_tools_dir}"
print_and_do_command_exit_on_error git clone https://github.com/bitrise-io/xcodebuild-unittest-miniserver.git "${xcuserver_base_dir}"
print_and_do_command_exit_on_error bash "${xcuserver_install_script_path}"

echo " (i) XCUServer Success"

echo
echo " (!) To activate XCUServer you have to do a restart, or load it with launchctl from a GUI user!"
echo