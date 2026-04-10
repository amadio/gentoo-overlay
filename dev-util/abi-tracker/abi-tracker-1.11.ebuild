# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Visualize ABI changes timeline of a C/C++ software library"
HOMEPAGE="https://github.com/lvc/abi-tracker"
SRC_URI="https://github.com/lvc/abi-tracker/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/elfutils
	dev-util/abi-monitor
	dev-util/vtable-dumper
	dev-util/abi-compliance-checker
"
BDEPEND="dev-lang/perl"

src_compile() {
	:
}

src_install() {
	dodir /usr
	perl Makefile.pl -install -prefix "${EPREFIX}/usr" -destdir "${D}" || die
	einstalldocs
}
