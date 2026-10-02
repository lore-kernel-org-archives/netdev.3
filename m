Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C036998A;
	Fri,  2 Oct 2026 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916507; cv=none; b=UlM6IUjI4KWCOj10f3FutE9G5KLLcpVplY9gXvCakVkumkerq3aCAebovtfkbTLHffmtQHb8+ij3wMmC6d+s3qC6FfKHoEmIgpzxgKBZq0DL7Rz0y0ITNP2IRDxxJQOO9IkfaOivX6bBLigTV2QHH73TsXakf+4M7CPDYuvFWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916507; c=relaxed/simple;
	bh=u9VXc9S//nuNIIsDhxbeO6zYd6QGTnX0KP6xK7MtocY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLG3Gi52HJ56aFSiGXwkjJhb52dnlWqxfqJ51/KvqH+AOMzeIbEBhDeAO9g+zEYwqsH8RUkh5ovu8yfyiq5Tu8LhHszXrRutF9NwTwrrHVtcS00Jnt8JPNRFnDORdFB+sOzZXm8ADdpoFpb7GQTTwaQA/Ry0DiJNJ9qyy2QwUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xxF5fn+O; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VOu50w5k; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xxF5fn+O";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="VOu50w5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916493;
	bh=u9VXc9S//nuNIIsDhxbeO6zYd6QGTnX0KP6xK7MtocY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xxF5fn+OIqXAY3b7Zgfp2SKgQRWrFzBcvbYd4zoiWsR7AnrbT3yzHtOhgqJaoVSZ6
	 aFsJl8UljWcZID+6zRTOz/mWmdEDaj8rjgl5L7vzV/zGAmeQ+uQdxpeRrYl2J0qSZN
	 0YGCMeeWc0FXMCnw5VZWPn29SMLp+ClaUCjpbwl+uEjiccoOInSffvmnvVqIH8aC4e
	 Z+0mVlXfzGhFolhlC+A6ps0RHxBlsw5mf3ODtiSYGjdIw3wWIlNFZLEj/bMIuztvPM
	 OYmHHNwL3iwhxN9nveRwiWAAwwKBF1+G7S7bEVV4d8hZj4cZWgQ5B+AoSQSYswrMNn
	 mAr853XtDh9Ng==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 47F04481FD; Fri,  2 Oct 2026 04:48:13 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916479;
	bh=u9VXc9S//nuNIIsDhxbeO6zYd6QGTnX0KP6xK7MtocY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VOu50w5k6C2mG0ob4IYkan/BKoMUOQLc4VWG5RlRIRfhuK843vVAYbYO/9c7F6mjI
	 Xtq496wZ49Da7RSeb6taY5/xBaauT9PJgEu3hOMetW7QY9+Kw/75WzUyihbbw9J8BE
	 Zm9DJu+V4jMMrMwvS3v/APpdkaZ8Xu4+G2xyw+vRdRZ6udqaPQrvMc2PRNeWjatsG+
	 Xx8D2Sl7wAOLHfsOs+2XlFmLkuLFWtA4AB5f9bqtdqCBJvoCtGsD2rzscBy2WuTsOV
	 XAmh2uqdFH4yUFgz/4AAnw0cKtmYd9uEZx8UJgd5/1W/+a1IwAxXV0eqttaB8W82M1
	 r3TOk46MFAb8Q==
Received: from AMDDesktop.lan (p5798b2cf.dip0.t-ipconnect.de [87.152.178.207])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 72D4647E41;
	Fri,  2 Oct 2026 04:47:59 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 02 Oct 2026 06:47:52 +0200
Subject: [PATCH net-next v15 08/13] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-ax88179a-v15-8-131d9286fcd7@birger-koblitz.de>
References: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
In-Reply-To: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
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

