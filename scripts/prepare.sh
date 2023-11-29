#!/bin/bash
# You should modify this script to prepare the folder structure for external project source codes
# The source code must be in ocp/external/external_id/version/source folder
# get command line arguments
version=${1:-"4.0.3"}
external_id=${2:-"parmetis"}
download=${3:-"nodownload"}

# prepare necessary variables
# http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz
url="http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/$external_id-$version.tar.gz"
# older version url is http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/OLD/parmetis-4.0a3.tar.gz
dir="ocp/external/$external_id/$version/source"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
gz_file="$external_id-v$version.tar.gz"
# move to the root of the external repository
cd $script_dir/..

# start the script
if [ "$download" == "download" ]; then
  rm -rf *.tar.gz
  # wget -cO - $url > $gz_file
  wget -O $gz_file $url
  echo "Download $external_id $version"
fi
rm -rf ocp
echo "Remove previous ocp folder"
mkdir -p "$dir"
echo "Create ocp folder structure"
tar -xzf $gz_file -C $dir --strip-components=1
echo "Extract files to ocp folder"
cp -r configurations "$dir/.."
echo "Copy all configurations to ocp folder"
cp -r cmake "$dir/.."
echo "Copy all cmake files to ocp folder"
cp ocp.yml "$dir/.."
echo "Copy ocp.yml to ocp folder"

# move back to the folder where you started
cd -
