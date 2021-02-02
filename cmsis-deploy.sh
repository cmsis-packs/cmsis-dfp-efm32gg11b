#!/bin/bash

name=cmsis-dfp-efm32gg11b
vendor=SiliconLabs
version=2.7.0
source_url=https://www.silabs.com/documents/public/cmsis-packs/$vendor.GeckoPlatform_EFM32GG11B_DFP.$version.pack

build_dir='cmsis_build'
deploy_dir='cmsis_deploy'

prepare() {
    echo "preparing..." 
    
    if [ -z "$build_dir" ]
    then
        echo " var\$build_dir is empty"
        exit
    fi

    if [ -z "$deploy_dir" ]
    then
        echo "var \$deploy_dir is empty"
        exit
    fi
    
    mkdir -p $build_dir
    mkdir -p $deploy_dir

    if [ "$(ls -A $build_dir)" ]; then
        echo "Directory $build_dir is not Empty"
        echo "Running \"rm -rf $build_dir/*\""
        rm -rf $build_dir/*
    fi

    if [ "$(ls -A $deploy_dir)" ]; then
        echo "Directory $deploy_dir is not Empty"
        echo "Running \"rm -rf $deploy_dir/*\""
        rm -rf $deploy_dir/*
    fi

    touch $build_dir/version

    echo $version >> $build_dir/version
}

download() {
    echo "downloading..."
    curl -L -o $build_dir/pack-src.pack $source_url
}

extract() {
    echo "extracting..."
    unzip $build_dir/pack-src.pack -d $build_dir
}

deploy() {
    echo "deploying..."
    cp -r $build_dir/Device $deploy_dir
    cp -r $build_dir/Documents $deploy_dir
    cp -r $build_dir/Flash $deploy_dir
    cp -r $build_dir/SVD $deploy_dir
}

prepare
download
extract
deploy
