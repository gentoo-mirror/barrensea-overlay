EAPI=8
inherit unpacker desktop xdg-utils
DESCRIPTION="Launcher for the Steam software distribution service
 Steam is a software distribution service with an online store, automated
 installation, automatic updates, achievements, SteamCloud synchronized
 savegame and screenshot functionality, and many social features."
HOMEPAGE="https://store.steampowered.com/"
SRC_URI="https://repo.steampowered.com/steam/archive/precise/${PN}-launcher_${PV}_amd64.deb -> ${PN}.deb"
LICENSE="GPL-2"
SLOT="0"
IUSE="+ebuild +rime"
DOCS="README.org"
KEYWORDS="~amd64"
RDEPEND="
	net-misc/curl
	sys-apps/dbus
"

src_unpack() {
	unpack_deb ${DISTDIR}/${PN}.deb
}
S="${WORKDIR}"
src_install() {
	dodir /lib/udev/rules.d/
	cp -a ${S}/lib/udev/rules.d/* ${ED}/lib/udev/rules.d/ || die
	dodir /opt/steam
	cp -a ${S}/usr/lib/steam/* ${ED}/opt/steam
	dodir /usr/share
	sed -i 's/\/usr\/bin\/steam/\/opt\/steam\/bin_steam.sh/' ${S}/usr/share/applications/steam.desktop
	cp -a ${S}/usr/share/* ${ED}/usr/share/
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
