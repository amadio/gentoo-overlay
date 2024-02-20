# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
# CMAKE_MAKEFILE_GENERATOR=emake
DOCS_BUILDER="doxygen"
DOCS_DEPEND="
	media-gfx/graphviz
	virtual/latex-base
	python? ( dev-python/sphinx )
"

inherit cmake python-single-r1 tmpfiles

DESCRIPTION="EOS Open Storage"
HOMEPAGE="https://eos-web.web.cern.ch/eos-web/"

LICENSE="GPL-3+"
SLOT="0"
IUSE="debug doc http macaroons python scitokens server systemd test"

RESTRICT="!test? ( test )"

if [[ ${PV} =~ "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cern-eos/eos.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://storage-ci.web.cern.ch/storage-ci/eos/diopside/tarball/${P}-1.tar.gz"
	S="${S}-1"
fi

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"

CDEPEND="
	app-arch/bzip2
	app-arch/lz4
	app-arch/zstd
	dev-cpp/abseil-cpp
	dev-cpp/sparsehash
	dev-libs/isa-l
	dev-libs/isa-l_crypto
	dev-libs/jsoncpp
	dev-libs/jemalloc
	dev-libs/libevent
	dev-libs/libfmt
	dev-libs/libxml2:2=
	dev-libs/openssl:0=
	dev-libs/protobuf
	dev-libs/rocksdb:0=
	dev-libs/xxhash
	net-libs/cppzmq
	net-libs/libmicrohttpd
	>=net-libs/xrootd-5.6[fuse,http?,kerberos,macaroons?,scitokens?,server?,systemd?]
	sys-apps/attr
	sys-apps/help2man
	sys-fs/fuse:0=
	sys-fs/fuse:3=
	sys-fs/squashfs-tools
	sys-fs/xfsprogs
	sys-libs/binutils-libs
	sys-libs/ncurses
	sys-libs/readline
	sys-libs/zlib
	dev-libs/elfutils
	net-libs/zeromq
	virtual/libcrypt:=
	${PYTHON_DEPS}
	server? (
		dev-cpp/folly
		net-libs/grpc
		net-nds/openldap
	)
	scitokens? ( dev-cpp/scitokens-cpp )
	systemd? ( sys-apps/systemd )
"
DEPEND="${CDEPEND}"

BDEPEND="
	${CDEPEND}
	test? (
		dev-cpp/benchmark
		dev-cpp/gtest
	)
"

RDEPEND="${CDEPEND}"

# These are XRootD plugins to be loaded at runtime,
# so they intentionally do not have an SONAME set.
QA_SONAME="
	/usr/lib.*/libEos.*-5\.so
	/usr/lib.*/libXrd.*-5\.so
	/usr/lib.*/libEosAuthOfs\.so
	/usr/lib.*/libEosFstHttp\.so
	/usr/lib.*/libEosFstOss\.so
	/usr/lib.*/libEosNsQuarkdb\.so
"

pkg_setup() {
	use python && python_setup
}

src_prepare() {
	rm -rf common/fmt
	rm -rf namespace/ns_quarkdb/qclient/src/fmt
	rm -rf quarkdb/deps/qclient/src/fmt
	sed -i -e '/find_program(CCACHE_FOUND ccache)/d' CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DASAN=OFF
		-DTSAN=OFF
		-DCOVERAGE=OFF
		-DBUILD_MANPAGES=$(usex doc)
		-DBUILD_XRDCL_RAIN_PLUGIN=$(usex server)
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DCMAKE_INSTALL_MANDIR="share/man"
		-DUSE_SYSTEM_GBENCH=ON
		-DUSE_SYSTEM_GTEST=ON
		-DSTACK_DETAILS_AUTO_DETECT=ON
		-DSTACK_DETAILS_BACKTRACE_SYMBOL=$(usex debug)
		-DSTACK_DETAILS_BFD=ON
		-DSTACK_DETAILS_DW=ON
		-DSTACK_WALKING_BACKTRACE=ON
		-DSTACK_WALKING_UNWIND=ON
		-DPython3_EXECUTABLE="${PYTHON}"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	fowners daemon:daemon /etc/xrd.cf.{auth,fed,fst,global-mq,mgm,mq,prefix,quarkdb,sync}
	fowners daemon:daemon /etc/eosarchived.conf
	fowners daemon:daemon /etc/eos.keytab
	fowners daemon:daemon /etc/eos.client.keytab
	fowners daemon:daemon /etc/sysconfig/eos_env.example
	fowners daemon:daemon /etc/sysconfig/eosarchived_env
	fowners -R daemon:daemon /etc/eos
	fowners -R daemon:daemon /var/eos
	fowners -R daemon:daemon /var/cache/eos
	fowners -R daemon:daemon /var/log/eos
	fowners -R daemon:daemon /var/run/eos

	keepdir /var/eos
	keepdir /var/{cache,log,run,share,www}/eos
	docompress -x /usr/share/man/man1
	einstalldocs
}

pkg_postinst() {
	tmpfiles_process eosd.conf
	tmpfiles_process eos-fusex-core.conf
}
