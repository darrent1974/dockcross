#!/usr/bin/env bash

set -ex
set -o pipefail

if ! command -v curl &> /dev/null; then
	echo >&2 'error: "curl" not found!'
	exit 1
fi

if [[ "${CUDA_VERSION}" == "" ]]; then
  echo >&2 'error: CUDA_VERSION env. variable must be set to a non-empty value'
  exit 1
else if [[ "${CUDA_VERSION}" == "8.0" ]]; then 
	echo >&2 'installing ' ${CUDA_VERSION}
	
	url=https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-rhel6-8-0-local-ga2-8.0.61-1.x86_64-rpm
	echo "Downloading $url"
	curl -# -LO $url	
	
	rpm -i cuda-repo-rhel6-8-0-local-ga2-8.0.61-1.x86_64.rpm
	yum clean all
	yum install cuda
	export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}	
else
	echo >&2 'error: Unsupported CUDA Version' ${CUDA_VERSION}
  	exit 1	
fi

