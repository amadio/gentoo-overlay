# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Interoperable Global Trust Federation (IGTF) CA Certificates"
HOMEPAGE="https://igtf.net"
SRC_URI="https://dist.igtf.net/distribution/igtf/${PV}/igtf-policy-installation-bundle-${PV}.tar.gz"

S="${WORKDIR}/igtf-policy-installation-bundle-${PV}/"

LICENSE="CC-BY-3.0"
SLOT="0"

KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86 ~arm64-macos ~x64-macos"

src_configure() {
	./configure
}

src_compile() {
	: # empty
}

src_install() {
	make prefix="${ED}/etc/grid-security/certificates" install-classic
}
