# Maintainer: Jason Kölker <jason@koelker.net>

pkgname=stateless-htpc
pkgver=0.1
pkgrel=0
pkgdesc="Systemd configurations to support a stateless htpc"
arch=('x86_64' 'i686')
url="https://github.com/jkoelker/stateless-htpc"
license=('GPL')
depends=('dhclient', 'dracut', 'systemd' 'nfs-utils' 'xorg-server' 'xorg-xinit' 'steam' 'xterm')
source=("https://github.com/jkoelker/$pkgname/archive/v$pkgver.tar.gz")
sha256sums=('307cda79906169f953a356c2fe753d82a11d3f8f843663d42fb9b91254b412c6')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"
    make DESTDIR="${pkgdir}" install
}
