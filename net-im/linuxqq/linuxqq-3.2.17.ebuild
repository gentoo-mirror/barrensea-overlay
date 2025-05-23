EAPI=8

inherit unpacker desktop xdg-utils

DESCRIPTION="The new version of the official linux-qq"
MYPN="QQ"
HOMEPAGE="https://im.qq.com/linuxqq/index.shtml"
SRC_URI="https://dldir1.qq.com/qqfile/qq/QQNT/Linux/${MYPN}_${PV}_250519_amd64_01.deb -> qq.deb"
VER="202519"
KEYWORDS="amd64"
LICENSE="Tencent"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="
	virtual/krb5
"
S="${WORKDIR}"
src_unpack() {
	:
}

src_install() {
	dodir /
	unpack_deb ${DISTDIR}/qq.deb
	mv "${S}/usr/share/applications/qq.desktop" "${S}/usr/share/applications/QQ.desktop" || die
	cp -a ${S}/* ${ED}/
	cd ${S}
	gzip -d usr/share/doc/linuxqq/changelog.gz || die
	dodoc usr/share/doc/linuxqq/changelog
	rm -rf ${ED}/usr/share/doc/linuxqq/
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
