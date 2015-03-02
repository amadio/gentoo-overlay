# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit latex-package

DESCRIPTION="LaTeX package that facilitates expressive syntax highlighting in using the powerful Pygments library"
HOMEPAGE="https://github.com/gpoore/minted"
SRC_URI="http://mirrors.ctan.org/macros/latex/contrib/${PN}.zip -> ${PN}-v${PV}.zip"

SLOT="0"
LICENSE="LPPL-1.3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="
	dev-texlive/texlive-latexextra
	dev-python/pygments"

S="${WORKDIR}/${PN}"/

src_install() {
	latex-package_src_install
	dodoc README
}
