# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

DESCRIPTION="Mathematica's Fonts for MathML"
HOMEPAGE="http://www.wolfram.com/mathematica"
SRC_URI="http://support.wolfram.com/kb/data/uploads/2014/08/TrueType.zip -> ${P}.zip"

LICENSE="WRI-EULA"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86 ~x86-linux"
IUSE=""

RESTRICT="binchecks mirror strip"

S="${WORKDIR}"
FONT_S="${S}"/TrueType
FONT_SUFFIX="ttf"
