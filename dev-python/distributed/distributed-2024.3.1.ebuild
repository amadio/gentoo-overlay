# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A library for distributed computation"
HOMEPAGE="
	https://distributed.dask.org/
	https://github.com/dask/distributed/
	https://pypi.org/project/distributed/
"
SRC_URI="
	https://github.com/dask/distributed/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"

RDEPEND="
	>=dev-python/click-8.1[${PYTHON_USEDEP}]
	>=dev-python/cloudpickle-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/dask-2024.3.1[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10.3[${PYTHON_USEDEP}]
	>=dev-python/locket-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.7.2[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3.1[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-2.0.5[${PYTHON_USEDEP}]
	>=dev-python/tblib-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/toolz-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/tornado-6.0.4[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.24.3[${PYTHON_USEDEP}]
	>=dev-python/zict-3.0.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-metadata-4.13.0[${PYTHON_USEDEP}]
	' 3.{10..11})
"
BDEPEND="
	dev-python/toolz[${PYTHON_USEDEP}]
	>=dev-python/versioneer-0.28[${PYTHON_USEDEP}]
	test? (
		dev-libs/apache-arrow[parquet,snappy]
		dev-python/dask-expr[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/numexpr[${PYTHON_USEDEP}]
		dev-python/pyarrow[parquet,${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
}

python_test() {
	local EPYTEST_DESELECT=(
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p pytest_rerunfailures -m "not network" -o xfail_strict=False
}
