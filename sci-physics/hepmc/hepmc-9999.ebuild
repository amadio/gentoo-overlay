# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

MYP=HepMC-${PV}

DESCRIPTION="Event Record for Monte Carlo Generators"
HOMEPAGE="https://savannah.cern.ch/projects/hepmc/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="http://git.cern.ch/pub/hepmc3"
	EGIT_COMMIT="alpha5.0"
else
	SRC_URI="http://lcgapp.cern.ch/project/simu/HepMC/download/${MYP}.tar.gz"
	S="${WORKDIR}/${MYP}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="cm doc examples gev static-libs test"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen dev-tex/floatflt )"

DOCS=( ChangeLog )

src_prepare() {
	sed -i -e '/add_subdirectory(doc)/d' CMakeLists.txt
	# CMake doc building broken
	# gentoo doc directory
	#sed -i \
	#	-e "s:share/HepMC/doc:share/doc/${PF}:" \
	#	doc/CMakeLists.txt || die

	# gentoo examples directory
	sed -i \
		-e "s:share/HepMC:share/doc/${PF}:" \
		$(find examples -name CMakeLists.txt) || die

	if [[ ${PV} != 9999 ]]; then
		# respect user's flags
		sed -i \
			-e "s/-O -ansi -pedantic -Wall//g" \
			cmake/Modules/HepMCVariables.cmake || die

		# gentoo libdir love
		sed -i \
			-e '/DESTINATION/s/lib/lib${LIB_SUFFIX}/g' \
			{src,fio}/CMakeLists.txt || die

		if ! use static-libs; then
			sed -i \
				-e '/(HepMC\(fio\|\)S/d' \
				-e '/TARGETS/s/HepMC\(fio\|\)S//' \
				{src,fio}/CMakeLists.txt || die
		fi
	fi

	# remove targets if use flags not set
	use examples || sed -i -e '/add_subdirectory(examples)/d' CMakeLists.txt
	use test || sed -i -e '/add_subdirectory(test)/d' CMakeLists.txt
}

src_configure() {
	# use MeV over GeV and mm over cm
	local length_conf="MM"
	use cm && length_conf="CM"
	local momentum_conf="MEV"
	use gev && momentum_conf="GEV"
	mycmakeargs+=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-Dlength=${length_conf}
		-Dmomentum=${momentum_conf}
	)
	cmake-utils_src_configure

	cd ../${P}_build
	#sed -i -e '/touch_nocreate/d' rootIO/CMakeFiles/HepMCrootIO.dir/build.make || die
	cp ../${P}/rootIO/include/rootIO_Classes.hh rootIO/rootIO_Classes.h || die
}

src_compile() {
	cmake-utils_src_compile
	if use doc; then
		cd doc
		./buildDoc.sh || die
		./buildDoxygen.sh || die
	fi
}

src_install() {
	cmake-utils_src_install
	use doc && dodoc doc/*.pdf && dohtml -r doc/html/*
}
