# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="Mathematica's Fonts for MathML"
HOMEPAGE="http://support.wolfram.com/technotes/latestfonts.en.html"
SRC_URI="http://support.wolfram.com/kb/data/uploads/2014/08/TrueType.zip"

LICENSE="WRI-EULA"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RESTRICT="mirror strip binchecks"
S=${WORKDIR}

src_install() {
	FONT_S="${S}"/TrueType FONT_SUFFIX="ttf" font_src_install
}
