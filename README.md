# OpenCAX+ External Template

This is a template repository for external dependencies of the OpenCAX+ projects.

External dependencies are used for both toolkits or starters of the OpenCAX+ SDK.

## Learn how to create the external project for OpenCAX+

Read our tutorial or watch the tutorial video (both coming soon).

## Things that you need to modify

- [ ] This README.md file, also remember to add the workflow badge
- [ ] The workflow yml files, change the name of workflow
- [ ] The ocp.yml file
- [ ] scripts/prepare.sh
- [ ] scripts/install.sh
- [ ] Create any new configurations build and install script in the config folder
- [ ] Create new cmake file for each corresponding configuration

## Things you need to check before publish the external project

- [ ] run the prepare.sh script locally, is the external project's source code resides in ocp/external/external_id/version/source?
- [ ] does the ocp/external/external_id/version folder also contains a ocp.yml file and any build configuration folders that you want?
- [ ] run the ocp/external/external_id/version/config/$config.sh script locally, is the build cache files put into ocp/external/external_id/version/build/$config folder, and the install files put into ocp/external/external_id/version/install/$config folder?
- [ ] run the External Build workflow

## Some rules
### For external projects
1. Structure of the compressed source code must be resides in ocp/external/external_id/version/source. The ocp.yml file should be copied to ocp/external/external_id/version folder.
2. Must use tar.xz to compress the ocp folder
3. The install script must install compiled software to configuration subdirectory under ocp/external/external_id/version/install folder.

### For developers
1. You should create a release and tag once a new version or configuration of the external project is added.
2. You should be aware that scripts maybe used by multiple versions and configurations, so be careful when you modify any existing scripts. 

## Folder structure explained
- scripts, useful scripts but won't be included into the distributed compress file.
    - prepare.sh, to prepare the folder structure for external source. It must located in ocp/external/external_id/version/source
    - publish.sh, to xz compress the external source code and publish to OSS bucket. This should only to be used by the OpenCAX+ runner.
    - install.sh, 
- configurations, contains specific build configuration scripts to install different build configuration of the source code. You must put any build files into a build subfolder, and all install files into the install subfolder.
- cmake, contains the dependency cmake file for each configuration. You just put the find_package() commands or any necessary preparation before others to use this package in each of the cmake file.

## The ocp.yml file

For explanation of the ocp.yml file, please read the comment in itself and check the ocp.schema.json file for all the rules.