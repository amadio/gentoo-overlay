# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake

inherit cmake git-r3

DESCRIPTION="Toolkit for simulation of passage of particles through matter"
HOMEPAGE="https://geant4.cern.ch/"
EGIT_REPO_URI="ssh://git@gitlab.cern.ch:7999/geant4/geant4-dev.git"

LICENSE="geant4"
SLOT="4"
#KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="c++11 c++14 +c++17 dawn examples freetype gdml geant3 hdf5
	inventor motif opengl qt5 raytracerx static-libs test threads vrml"

RESTRICT="!test? ( test )"

REQUIRED_USE="^^ ( c++11 c++14 c++17 )"

RDEPEND="
	dev-libs/expat
	dawn? ( media-gfx/dawn )
	gdml? ( dev-libs/xerces-c )
	hdf5? ( sci-libs/hdf5[threads?] )
	inventor? ( media-libs/SoXt )
	motif? ( x11-libs/motif:0 )
	opengl? ( virtual/opengl )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtprintsupport:5
		dev-qt/qtwidgets:5
		opengl? ( dev-qt/qtopengl:5 )
	)
	raytracerx? (
		x11-libs/libX11
		x11-libs/libXmu
	)"

HTML_DOCS="ReleaseNotes/ReleaseNotes$(ver_cut 1-3).html"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DATADIR="${EPREFIX}/usr/share/geant4"
		-DGEANT4_BUILD_CXXSTD=$((usev c++11 || usev c++14 || usev c++17) | cut -c4-)
		-DGEANT4_BUILD_MULTITHREADED=$(usex threads)
		-DGEANT4_BUILD_TLS_MODEL=$(usex threads global-dynamic initial-exec)
		-DGEANT4_BUILD_TESTS=$(usex test)
		-DGEANT4_ENABLE_TESTING=$(usex test)
		-DGEANT4_INSTALL_DATA=OFF
		-DGEANT4_INSTALL_DATADIR="${EPREFIX}/usr/share/geant4/data"
		-DGEANT4_INSTALL_EXAMPLES=$(usex examples)
		-DGEANT4_USE_FREETYPE=$(usex freetype)
		-DGEANT4_USE_G3TOG4=$(usex geant3)
		-DGEANT4_USE_GDML=$(usex gdml)
		-DGEANT4_USE_INVENTOR=$(usex inventor)
		-DGEANT4_USE_NETWORKDAWN=$(usex dawn)
		-DGEANT4_USE_NETWORKVRML=$(usex vrml)
		-DGEANT4_USE_OPENGL_X11=$(usex opengl)
		-DGEANT4_USE_QT=$(usex qt5)
		-DGEANT4_USE_RAYTRACER_X11=$(usex raytracerx)
		-DGEANT4_USE_SYSTEM_CLHEP=OFF
		-DGEANT4_USE_SYSTEM_EXPAT=ON
		-DGEANT4_USE_SYSTEM_ZLIB=ON
		-DGEANT4_USE_WT=OFF
		-DGEANT4_USE_XM=$(usex motif)
		-DBUILD_STATIC_LIBS=$(usex static-libs)
		${EXTRA_ECONF}
	)
	if use inventor; then
		mycmakeargs+=(
			-DINVENTOR_INCLUDE_DIR="$(coin-config --includedir)"
			-DINVENTOR_SOXT_INCLUDE_DIR="$(coin-config --includedir)"
		)
	fi
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm "${ED}"/usr/bin/*.{sh,csh} || die "failed to remove obsolete shell scripts"
	einstalldocs
}
