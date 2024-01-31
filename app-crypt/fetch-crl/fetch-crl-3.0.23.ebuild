# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Certificate Revocation List retrieval tool"
HOMEPAGE="https://wiki.nikhef.nl/grid/FetchCRL3"
SRC_URI="https://dl.igtf.net/distribution/util/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/openssl:0=
	virtual/perl-File-Temp
	virtual/perl-Sys-Syslog
"
RDEPEND="${DEPEND}"

src_compile() {
	return
}

src_install() {
	emake install CACHE="${ED}/var/cache" ETC="${ED}/etc" PREFIX="${ED}/usr"
	rm -rf "${ED}/var"
}
