Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0924372EDD;
	Sat, 10 Oct 2026 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608088; cv=none; b=oq3TpwUPt/QisVPOqBvBbgt9DhETOvFe1Vgy+djWmd28pkXiE1/3yH7cvAsAPlpWCgwlYuT4C7efZXbyI+yiBH3Z4k5fyQrnMcan5Asd0DOTqky+9iroKGLDFaoL3tZcfrs8ldKqi03HAOwUF8XzmzVT05D5ot5Zf1XNrdhjXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608088; c=relaxed/simple;
	bh=Q0JBHsoXOE0rcjBzburvk9Dhq9vEVC5K5ZbvCLUZ7po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRF0lopDLgIZcEWMnoDLOYmmDX0jwqyB3s7TIVp/iMNtCRfuU2y/FYZ9KBYw2qnAHBiZ35+k9mzUvIZaPFSs1ac9Q9zkHzpFeGBKmnEQjLNN/sFYtcVWM2g0We2LehJqnHgtPcjNGux0XLrhR9n/cqrvuwGNvqeynlQ3R/b3+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=x2NmAwzU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pHTQX7OK; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="x2NmAwzU";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pHTQX7OK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608084;
	bh=Q0JBHsoXOE0rcjBzburvk9Dhq9vEVC5K5ZbvCLUZ7po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=x2NmAwzUX88Br5rui1BTNWm/cGUpE7lgFLHLuUcWjlOXWY2lOYkkaNRyYjTxbBjlW
	 XAzqcA7RpvBBsMp7aCEblpk/W7PfspDbc8vfXwTT9ZyGEtK/9jyDoxp+y2z0K1n6kX
	 SoFoP7J6aHF/sBu9ysjIYXFD6/5keC5EcJ6AnunUDQuSMc/knty2/peumVo37C/21k
	 x3mM/t6DPnn/l5yAleiEO/DI2m8+Y4AsqRBlG3hbrwvKshQJXEBgJPvkfup/iYIfDt
	 0aauaTz2NF7rutvIzqxp70atXBd1Ge2hOKK1igd+X/fT5FSfwZoAugA6DubBmGqwXT
	 /Zm0MxGRtYM8w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 82A3F475E5; Sat, 10 Oct 2026 04:54:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608072;
	bh=Q0JBHsoXOE0rcjBzburvk9Dhq9vEVC5K5ZbvCLUZ7po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pHTQX7OK3h0wB5Fzr7R+7EaYRpvUf6pd2hfTgId+kHlCdewpXrhYmNFKkFlnzeuJ3
	 3JV5H//uVrSxerjWci08eCrfvJ5z7iejS4ooSc6eUUFaKhbtvONf5GzvswDnzy50Xn
	 66ubSA3jGwLKIN2WeCh6mZPYA6Voe9sGAskBns6cd/6JhdxGURfWJeb7OMy5g7c13U
	 1nN4hy/Te34xX8kzrElC08j2Rg+JVFBmNiHp4n3RbxdkdioQ+V0ZDcpiAyVcrreqiC
	 3qAKYoL8rEGd0QTUZnmYjxUuKYh924VOvmEiS0xhq51ofvqc1EcQD2YfINroBRXpL8
	 2pdNhxlQr9zuA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id DA72C4756D;
	Sat, 10 Oct 2026 04:54:31 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 10 Oct 2026 06:54:30 +0200
Subject: [PATCH net-next v19 08/13] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ax88179a-v19-8-7475173cfb56@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
In-Reply-To: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
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
 drivers/net/usb/ax88179_lib.c      | 16 +++++++++++-----
 drivers/net/usb/ax88179a_devices.c |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index a314db4c9766679568a036f98acf868784835865..b4b00c8b4b62320471e13ae34a1fed5d02e80441 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -321,16 +321,21 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
 void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = dev->driver_priv;
 	u8 *m_filter = ((u8 *)dev->data);
+	struct ax88179_data *data;
+	u16 rxctl = 0;
+
+	data = dev->driver_priv;
 
-	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
+	rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
+	if (data->ip_align)
+		rxctl |= AX_RX_CTL_IPE;
 
 	if (net->flags & IFF_PROMISC) {
-		data->rxctl |= AX_RX_CTL_PRO;
+		rxctl |= AX_RX_CTL_PRO;
 	} else if (net->flags & IFF_ALLMULTI ||
 		   netdev_mc_count(net) > AX_MAX_MCAST) {
-		data->rxctl |= AX_RX_CTL_AMALL;
+		rxctl |= AX_RX_CTL_AMALL;
 	} else if (netdev_mc_empty(net)) {
 		/* just broadcast and directed */
 	} else {
@@ -351,9 +356,10 @@ void ax88179_set_multicast(struct net_device *net)
 					AX_MCAST_FLTSIZE, AX_MCAST_FLTSIZE,
 					m_filter);
 
-		data->rxctl |= AX_RX_CTL_AM;
+		rxctl |= AX_RX_CTL_AM;
 	}
 
+	WRITE_ONCE(data->rxctl, rxctl);
 	ax88179_write_cmd_async(dev, AX_ACCESS_MAC, AX_RX_CTL,
 				2, 2, &data->rxctl);
 }
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 4207d2cc2b865e5780b3c7f5ba2645a6242df477..a6b0a3f47118c46db38d483792c083510aa2641a 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -678,6 +678,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

