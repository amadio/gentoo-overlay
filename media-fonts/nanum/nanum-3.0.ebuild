# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

DESCRIPTION="The Nanum Korean fonts distributed by Naver"
HOMEPAGE="http://hangeul.naver.com/2014/nanum"
SRC_URI="http://cdn.naver.com/naver/NanumFont/fontfiles/NanumFont_OTF_ALL.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="binchecks strip"

DEPEND="app-arch/unzip"
RDEPEND=""

FONT_SUFFIX="otf"
S="${WORKDIR}"
FONT_S="${S}"
