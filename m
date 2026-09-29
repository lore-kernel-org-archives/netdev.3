Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749143935C;
	Tue, 29 Sep 2026 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651971; cv=none; b=RuzJOR12kDKEqheTamjDWE5xlwrhHsgahOETtILwVlG/U7jd0dKaj8m0IRwKH3hFPdWRRI+A/gsMvbODF3EpNTn8xrmlATPElbcI4+zMxU/EJGsDBH4bWXQC7vnKDKynqP6wPEW/AnZVJY3gkDVUAVcrAjZ/5s/DrYqwQbjxHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651971; c=relaxed/simple;
	bh=u9VXc9S//nuNIIsDhxbeO6zYd6QGTnX0KP6xK7MtocY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c0yk1nXok47yJ0buyRDRwQ1UUDzWyzKVtarMFrqAU0IUqyd/pxwdMRnz/t8+rTzuynKEJLYz7TMggT2M5zKWHLpW8rHt3enNgznSgsOlyNoNfF1YIzNti2ungVIhpCrlGH8FGJEFlhnebnUuvkos0JuIYFI5YtBl1Eocag+iDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ImvqYy+M; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=w/ch51bz; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ImvqYy+M";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="w/ch51bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651958;
	bh=u9VXc9S//nuNIIsDhxbeO6zYd6QGTnX0KP6xK7MtocY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ImvqYy+MwuSKjZL6Zb55jY16rONpMoJYOeYf/kncqBAth7f6wDWZZca8b7mdj1qMu
	 p9o9VUiG4yPvT+4BK3xRF+KEo1OaNo88JXMWdgAg0iv/MzY63UuG2etUgN5K4+S4cD
	 GpMb36dA0O0B2OebdkMZu1JA7bmg/UeDGG4lF024tUSs6wbMXxLyiENOxnrW0ZWZFN
	 ReFPqPOyL6AWB9pXLDn7YOF65ar1gzXwawMwAhKC0KdN479FGFj+MKTsjnkpn3RbJ+
	 9H9MDtnneX6DVqv7knkqj63X39MuKgYPvbBdBfJrTxlyvQTnaDATxCs9VoOyVC6uKz
	 bp8veL0fdxzUw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C530C4226B; Tue, 29 Sep 2026 03:19:18 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651940;
	bh=u9VXc9S//nuNIIsDhxbeO6zYd6QGTnX0KP6xK7MtocY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=w/ch51bzugUbLkx5Kdn4G6hw0hOwwTpWI++3fdfIqaMNXF/0dqlP8gDOqe+fW5ynn
	 aWBbTfyPWxMkyxu5pju5BA+SKr61TIKMDbEpkgocYIOjXQ2QrAUGPv8rN4RCsvjx3o
	 MiAiWe/wPnLKU57STu/bbV9/0pydi6AhhRGlR6ECrL93NGcquYShzuhnbRIvUvFDBg
	 8yzaTsuFwUc5UDNZY9fdtD9MV+yMF8pXzsvleYv+W9GGjQ333FEnm4llumJbCzPL4+
	 o6mGD52NXcYeqGE3HNa3nacy6Q3OtLfpZKxVBgWSgrFNS/AgBxn/X5yt68XZq/nVoq
	 QxmmlyqB7O4rQ==
Received: from AMDDesktop.lan (p5dd1eaf2.dip0.t-ipconnect.de [93.209.234.242])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3758342263;
	Tue, 29 Sep 2026 03:19:00 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 29 Sep 2026 05:18:57 +0200
Subject: [PATCH net-next v14 09/14] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-ax88179a-v14-9-a1f2249e42ea@birger-koblitz.de>
References: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
In-Reply-To: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

Add support for conditionally setting the ip_alignement flag
AX_RX_CTL_IPE in AX_RX_CTL and make sure that AX_RX_CTL_DROPCRCERR
is also set to be consistent with the initial configuration in
ax88179_reset()

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_lib.c      | 8 ++++++--
 drivers/net/usb/ax88179a_devices.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 53ccfc5d56c24eff102fc94f631d50d2d2ec1abd..6ec662780483e94f9606f05f253106b8a6856d43 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -321,10 +321,14 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
 void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = dev->driver_priv;
 	u8 *m_filter = ((u8 *)dev->data);
+	struct ax88179_data *data;
+
+	data = dev->driver_priv;
 
-	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
+	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
+	if (data->ip_align)
+		data->rxctl |= AX_RX_CTL_IPE;
 
 	if (net->flags & IFF_PROMISC) {
 		data->rxctl |= AX_RX_CTL_PRO;
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index febb4b0ef12895414f9bdea916315d6d48246ab8..53ae62f2c3b06a613e118a7f05ff63213c048e3a 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -661,6 +661,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

