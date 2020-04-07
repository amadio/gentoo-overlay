# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Experimental range library for C++11/14/17"
HOMEPAGE="https://ericniebler.github.io/range-v3"
SRC_URI="https://github.com/ericniebler/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0 UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"
