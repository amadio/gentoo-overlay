# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

DESCRIPTION="Comic Neue is a modern Comic Sans substitute"
HOMEPAGE="http://comicneue.com"
SRC_URI="${HOMEPAGE}/${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos"

DEPEND="app-arch/unzip"
RDEPEND=""

DOCS="FONTLOG.txt Booklet-ComicNeue.pdf"
FONT_SUFFIX="otf"

FONT_S="${S}/OTF"

src_install() {
	font_src_install
}
