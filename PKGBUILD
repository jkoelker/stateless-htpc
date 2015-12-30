# Maintainer: Jason Kölker <jason@koelker.net>

pkgname=stateless-htpc
pkgver=0.1
pkgrel=0
pkgdesc="Systemd configurations to support a stateless htpc"
arch=('x86_64' 'i686')
url="https://github.com/jkoelker/stateless-htpc"
license=('GPL')
depends=('systemd' 'nfs-utils' 'xorg-server' 'xorg-xinit' 'steam')
source=("https://github.com/jkoelker/$pkgname/archive/v$pkgver.tar.gz")
sha256sums=('a226aa248e0429899d8ceaeb121f261772a15fdfff3c348b64e0290602a2bae0')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"
    make DESTDIR="${pkgdir}" install
}
