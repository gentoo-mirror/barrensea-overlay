EAPI=8

inherit unpacker desktop xdg-utils

DESCRIPTION="Multi-platform auto-proxy client, supporting Sing-box, X-ray, TUIC, Hysteria, Reality, Trojan, SSH etc. It’s an open-source, secure and ad-free."
MYPN="hiddify"
HOMEPAGE="hiddify.com
https://github.com/hiddify/hiddify-app
"
SRC_URI="https://ghproxy.net/https://github.com/${MYPN}/${MYPN}-app/releases/download/v${PV}/${MYPN^}-Debian-x64.deb -> ${MYPN}.deb"
KEYWORDS="amd64"
LICENSE="Hiddify"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="
"
S="${WORKDIR}"
src_unpack() {
	unpack_deb ${DISTDIR}/${MYPN}.deb
}

src_install() {
	dodir /opt
	cp -a ${S}/usr/share/hiddify ${ED}/opt/ || die
	rm -rf  ${S}/usr/share/hiddify || die
	cp ${FILESDIR}/hiddify.desktop ${S}/usr/share/applications/hiddify.desktop ||die
	dodir /
	cp -a ${S}/* ${ED}/ ||die
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
