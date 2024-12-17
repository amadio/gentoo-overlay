# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Task scheduling and blocked algorithms for parallel processing"
HOMEPAGE="
	https://www.dask.org/
	https://github.com/dask/dask-expr/
	https://pypi.org/project/dask-expr/
"
SRC_URI="
	https://github.com/dask/dask-expr/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/versioneer[${PYTHON_USEDEP}]
"

EPYTEST_XDIST=1
distutils_enable_tests pytest
