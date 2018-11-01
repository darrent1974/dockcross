#!/usr/bin/env bash

set -ex
set -o pipefail

cd /tmp	

if [[ "${CUDA_VERSION}" == "" ]]; then
  echo >&2 'error: CUDA_VERSION env. variable must be set to a non-empty value'
  exit 1
elif [[ "${CUDA_VERSION}" == "8.0" ]]; then 
	echo "installing ${CUDA_VERSION}"
	
	url=https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
	
	echo "Downloading $url"
	wget -q $url	
	
	sh cuda_8.0.61_375.26_linux-run --silent --toolkit --verbose

	export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}	
	export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64 ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
else
	echo >&2 'error: Unsupported CUDA Version' ${CUDA_VERSION}
  	exit 1	
fi

