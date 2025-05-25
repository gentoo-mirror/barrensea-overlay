EAPI=8
inherit desktop xdg-utils
DESCRIPTION="A Minecraft Launcher which is multi-functional, cross-platform and popular"
HOMEPAGE="https://hmcl.huangyuhui.net
https://github.com/HMCL-dev/HMCL
"
SRC_URI="https://ghproxy.net/https://github.com/${PN}-dev/${PN}/releases/download/release-${PV}/HMCL-${PV}.sh -> ${PN}.sh"
KEYWORDS="amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="
	virtual/jre
"
S="${WORKDIR}"

src_install() {
	dodir /opt/hmcl
	cp ${DISTDIR}/${PN}.sh ${ED}/opt/hmcl/${PN}.sh

	cp ${FILESDIR}/icon.png ${ED}/opt/hmcl/icon.png
	dodir /usr/share/applications
	cp ${FILESDIR}/hmcl.desktop ${ED}/usr/share/applications/hmcl.desktop
	fperms +x /opt/hmcl/${PN}.sh
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
