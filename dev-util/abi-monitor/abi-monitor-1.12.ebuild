# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Monitor new versions of a software library"
HOMEPAGE="https://github.com/lvc/abi-monitor"
SRC_URI="https://github.com/lvc/abi-monitor/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

RDEPEND="
	dev-libs/elfutils
	dev-util/vtable-dumper
	net-misc/curl
	net-misc/wget
	virtual/perl-Data-Dumper
"
DEPEND="dev-lang/perl"

src_compile() {
	:
}

src_install() {
	dodir /usr
	perl Makefile.pl -install -prefix "${EPREFIX}/usr" -destdir "${D}" || die
	einstalldocs
}
