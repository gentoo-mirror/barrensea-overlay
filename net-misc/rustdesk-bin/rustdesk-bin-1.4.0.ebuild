EAPI=8

inherit unpacker desktop xdg-utils

DESCRIPTION="An open-source remote desktop application designed for self-hosting, as an alternative to TeamViewer"
MYPN="rustdesk"
HOMEPAGE="rustdesk.com
https://github.com/rustdesk/rustdesk"
SRC_URI="https://github.com/${MYPN}/${MYPN}/releases/download/${PV}/${MYPN}-${PV}-x86_64.deb -> ${MYPN}.deb"
KEYWORDS="amd64"
LICENSE="AGPL-3"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="
	x11-misc/xdotool
"
S="${WORKDIR}"
src_unpack() {
	unpack_deb ${DISTDIR}/${MYPN}.deb
}

src_install() {
	dodir /opt
	cp -a ${S}/usr/share/${MYPN} ${ED}/opt/ ||die
	rm -rf ${S}/usr/share/${MYPN} ||die
	sed -i 's/Exec=rustdesk/Exec=\/opt\/rustdesk\/rustdesk/g' ${S}/usr/share/applications/* ||die
	dodir /
	cp -a ${S}/* ${ED}/ || die
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
