# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils linux-info bash-completion-r1

MYP=${PN}-${PV/_p/-fix}

DESCRIPTION="HTTP read-only file system for distributing software"
HOMEPAGE="http://cernvm.cern.ch/portal/filesystem"
SRC_URI="https://github.com/cvmfs/${PN}/archive/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"

CDEPEND="
	dev-cpp/sparsehash
	dev-db/sqlite:3=
	dev-libs/leveldb:0=
	dev-libs/openssl:0
	net-libs/pacparser:0=
	net-misc/curl:0[adns]
	sys-apps/attr
	sys-fs/fuse:0=
	sys-libs/libcap:0=
	sys-libs/zlib:0=
"

RDEPEND="${CDEPEND}
	app-admin/sudo
	net-fs/autofs
"

DEPEND="${CDEPEND}
	virtual/pkgconfig
"

PATCHES=(
		"${FILESDIR}"/${P}-xattr.patch
		"${FILESDIR}"/${P}-builtins.patch
		"${FILESDIR}"/${P}-find-package.patch
)

S="${WORKDIR}/${PN}-${MYP}"

src_prepare() {
	cmake-utils_src_prepare
	# gentoo stuff
	sed -i -e 's/COPYING//' CMakeLists.txt || die
	rm bootstrap.sh || die
	sed -e "s:cvmfs-\${CernVM-FS_VERSION_STRING}:${PF}:" \
		-i CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILTIN_EXTERNALS=OFF
		-DBUILD_CVMFS=ON
		-DBUILD_DOCUMENTATION=OFF
		-DBUILD_GEOAPI=OFF
		-DBUILD_LIBCVMFS_CACHE=OFF
		-DBUILD_LIBCVMFS=OFF
		-DBUILD_PRELOADER=OFF
		-DBUILD_RECEIVER=OFF
		-DBUILD_SERVER=OFF
		-DINSTALL_BASH_COMPLETION=OFF
		-DINSTALL_MOUNT_SCRIPTS=ON
		-DINSTALL_PUBLIC_KEYS=ON
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	use bash-completion && \
		newbashcomp cvmfs/bash_completion/cvmfs.bash_completion cvmfs
	dodoc doc/*.md
}

pkg_config() {
	einfo "Setting up CernVM-FS client"
	cvmfs_config setup
	einfo "Now edit ${EROOT%/}/etc/cvmfs/default.local"
	einfo "and restart the autofs service"
}
