EAPI=8

DESCRIPTION="Linux Kernel with cjkpatch"
HOMEPAGE="https://github.com/barrensea/barrensea-overlay"
SRC_URI="https://mirrors.tuna.tsinghua.edu.cn/kernel/v6.x/linux-${PV}.tar.xz
https://ghproxy.net/https://github.com/donjuanplatinum/notes/blob/main/config
cjkpatch? (
https://ghproxy.net/https://github.com/bigshans/cjktty-patches/blob/master/cjktty-add-cjk32x32-font-data.patch
)
cjkpatch? (
https://ghproxy.net/https://github.com/bigshans/cjktty-patches/blob/master/v6.x/cjktty-6.9.patch
)
"

inherit toolchain-funcs kernel-build

KV_FULL="${PV}-barrensea"
LICENSE="GPL-2"
IUSE="+cjkpatch +source -debug"
SLOT=0
KEYWORDS="amd64 ~arm arm64 ~hppa ~loong ~ppc ppc64 ~riscv ~sparc x86"
BDEPEND="
	app-alternatives/bc
	app-alternatives/lex
	dev-util/pahole
	virtual/libelf
	app-alternatives/yacc
	app-crypt/sbsigntools
	sys-kernel/dracut
"
PDEPEND="
	sys-kernel/linux-firmware
"
S=${WORKDIR}/linux-${PV}

src_prepare() {
	cd ${S}
	if use cjkpatch ; then
		cp ${DISTDIR}/*.patch ${S}/
		patch -Np1 <cjktty-6.9.patch ||die
		patch -Np1 <cjktty-add-cjk32x32-font-data.patch ||die
	fi
	cp ${DISTDIR}/config ${S}/.config || die
	kernel-build_merge_configs
	default
}
