# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit  unpacker desktop xdg-utils

DESCRIPTION="A turn-based survival game set in a post-apocalyptic world"
HOMEPAGE="https://cataclysmdda.org
	https://github.com/CleverRaven/Cataclysm-DDA"
KEYWORDS="amd64"
_PN="cataclysm-dda"
_PV="0.H"
SRC_URI="https://mirrors.tuna.tsinghua.edu.cn/debian/pool/main/c/${_PN}/${_PN}-curses_0.H-1_amd64.deb -> curses.deb
		 https://mirrors.tuna.tsinghua.edu.cn/debian/pool/main/c/${_PN}/${_PN}-data_0.H-1_all.deb -> data.deb
	 https://mirrors.tuna.tsinghua.edu.cn/debian/pool/main/c/cataclysm-dda/cataclysm-dda-sdl_0.H-1_amd64.deb -> sdl.deb
	 "
LICENSE="CC-BY-SA-3.0 Apache-2.0 CC-BY-SA-4.0 MIT OFL-1.1 Unicode-3.0"
SLOT="0h"
RDEPEND="
	sys-libs/zlib
	sys-libs/ncurses
	media-libs/libsdl2[video]
	media-libs/sdl2-image[png]
	media-libs/sdl2-ttf[harfbuzz]
	media-libs/libsdl2[sound]
	media-libs/sdl2-mixer[vorbis]
	media-fonts/unifont
	media-fonts/terminus-font
	"

DEPEND="${RDEPEND}"
S=${WORKDIR}

src_unpack() {
	unpack_deb ${DISTDIR}/curses.deb ||die
	unpack_deb ${DISTDIR}/data.deb ||die
	unpack_deb ${DISTDIR}/sdl.deb ||die
}
src_install() {
	dodir /usr/share/games
	dodir /usr/games
	dodir /
	rm ${S}/usr/share/games/cataclysm-dda/font/Terminus.ttf
	rm ${S}/usr/share/games/cataclysm-dda/font/unifont.ttf
	sed -i "s/Exec=.*/Exec=\/usr\/games\/cataclysm-tiles/" ${S}/usr/share/applications/org.cataclysmdda.CataclysmDDA.desktop
	cp -a ${S}/* ${ED}/ ||die
	dosym /usr/share/fonts/terminus/ter-u32n.otb /usr/share/games/cataclysm-dda/font/Terminus.ttf
	dosym /usr/share/fonts/unifont/unifont.ttf /usr/share/games/cataclysm-dda/font/unifont.ttf
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

}
