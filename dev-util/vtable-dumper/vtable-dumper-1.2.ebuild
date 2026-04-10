# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Visualize ABI changes timeline of a C/C++ software library"
HOMEPAGE="https://github.com/lvc/vtable-dumper"
SRC_URI="https://github.com/lvc/vtable-dumper/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/elfutils
"

DEPEND="dev-lang/perl"

src_compile() {
	:
}

src_install() {
	default
	einstalldocs
}
