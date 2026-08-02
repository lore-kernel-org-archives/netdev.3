Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35513BE646;
	Sun,  2 Aug 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688368; cv=none; b=artcA0oP3NDgZesoXg3lJik2gAGUXktOnW7VtHi5jORiOBdIN7c1rC2zoc+u+d3Z/rAzJB1X8ii5rUlVHs2Wj8Y18SxoQjswSfAcKohaSIsXO5thNkkucbz1jbPk/cjXdUzeJA/Sy3u4yyt769RtZr6nazaIJl6uKw0GTEtaMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688368; c=relaxed/simple;
	bh=xoHH9cUOLWL2L7ppRswu4lHeGWC0NZSts6QDXgqPs/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBZBA/CQPrdKk5aORAKcajN5MKO2mUDpGOr5K9r8xzoxLmpN4GrrIu9FH7SI/qXtgA5q6CL/jrYnV8oEs5UH/Jz11gclGCS5srN2eUQvoghYz6h54rSDE4prTYDuRLYvKIFyhH5Ghc4Bh5/h8mBZ90NG7lIVLWOJK/t4Bj8aLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=W8POj3pf; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=th8UZkVb; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="W8POj3pf";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="th8UZkVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688364;
	bh=xoHH9cUOLWL2L7ppRswu4lHeGWC0NZSts6QDXgqPs/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W8POj3pfNZ9SNIVs7fz0BaTri09CcOjxkZBxdKZDnl31/1xojxX6xfaAjKZp0nej6
	 rhUrAEqhS67ErkfL7kOONYLffS+NMK8/c3HBRtAqXwn+fJI45wGLELDedm8WUWKfWN
	 BDUt/u4kcUl1kz9Jkracjk1irUELJ3dVmA+pJq86KLj5ZREyqqbkhgrY3wLnUpA+1D
	 hYyJuu7QFTSIAB1Ke/MJEvM9WQy9y9VFd/vdK7AW5nMSplQMDYaBNenM3UjWY30xCF
	 hVBD4FtaiHZOCBOw/akGwQZrW8xocKKLaBL4Y2H2fogGp+Gtm9vlFbaHVHqiZSeM5L
	 TeaTDiVKRh7Rw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 20EBE4965E; Sun,  2 Aug 2026 16:32:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688355;
	bh=xoHH9cUOLWL2L7ppRswu4lHeGWC0NZSts6QDXgqPs/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=th8UZkVb4eEa1m2g8+CFHDbAYgXAZxHXRdr+2HO9AHTEMURiFaFgziECtSlUfpiNR
	 0QR7Y3smGeIksjfTQpjj+G9sTVbFecgquH4e3EonoLSf1+cGihPezjp/3zunuRUqI+
	 ZejRfPb1iNLYsdge4BMWnzAuYXW14CGOIGQRuNN/HtVIuHTJg8+W6IXw4NohPAemT2
	 kdHVNYaGQBFSjSIA6Xc544U7wRMjzU7qBZQPoOYEDyOiQJr2tG+ZOKlzUFVIe++WJq
	 5Wlh22KpLJjUf+Lf5gfA8vsvjO/RLiEtOacVwFG7oCXO1Cf3RE8w3g2tiBicM9Isew
	 A6UhTgB6tjyHg==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 71E464964C;
	Sun,  2 Aug 2026 16:32:35 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:32:06 +0200
Subject: [PATCH net-next v5 08/13] ax88179_178a: Add AX179A/AX279 multicast
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-8-dcb9fea4acd4@birger-koblitz.de>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
In-Reply-To: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
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
index 9d6df9d5c61c841965e9f7fa4b1075561b7f9c50..7a8c12027b9fcf7141694952528861e986d065ad 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -314,10 +314,14 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
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
index 213eb974b7da576bb6546532ce45716055da1de0..70d0780ae5bcd9339dc456fffacdea86a4bf39a9 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -596,6 +596,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= usbnet_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

