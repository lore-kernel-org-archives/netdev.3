Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428474DBD63;
	Thu,  6 Aug 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044983; cv=none; b=Ky0l1w0T7Rg1krQRAFuttq0WRrdRU+hd6ZTaxGNzs/SZBm+PPmUwUarN+ag7PqxHGt6xOdvjgKlhWognNYptBeo0+u+/pJCUBdP3FPULNjWzq6sjxqneTpzJxXTD+K2RJlBAoq4uSvC6zArMdajVTnTisR0fdMxAXhyAuB/kuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044983; c=relaxed/simple;
	bh=fYybDrrd1qNBlTREkdbKIfFsC0F+JymUVVxZMKrAGHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8+JzviLRgRgjKTB3bKj+QEUNP0U0Z4V7JTJpdJm/hpemNRgEbMMBV7Cy1Aq2zMOxwu1fFJpjYOe0n4jxNuMlz1Q7wYFice7o2uAdVZDdRS0brV18kw2K+jfvTvw3W9IvrwMautE1Nsw4L5mZloMFSbR+/XVGAZ7ItjxSeBP9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QzdoLGq2; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=M3f7E0LP; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QzdoLGq2";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="M3f7E0LP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044980;
	bh=fYybDrrd1qNBlTREkdbKIfFsC0F+JymUVVxZMKrAGHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QzdoLGq2pk3xEjJoKbaXHP1w+KqnaqhcZJ9rpSB6yyWi74LklOJEfQI9us1Sbarjc
	 Hjhs+YSj9j6SVjSGAXKo4SXk409SbN4ttRxXL7eEb9IKzJxUkSLjs1uISOhR1wr/k8
	 eaZ93YSmm1fOc/Jmus9gPy2X4p0b0lQXx6pAMR0KCluh1GrJCjtvyQPAqWSolI24bW
	 b3m72VmIOVfF3pUfbhiV9Wn43vqAfmc+WibYx0kqgUL9sqAM0VirrHiiG8mPAWAkSX
	 D01QJHn2VsMIAtIIUn9CKMU+dC8UKm4HPFJ+YPMbFU9BoWlRnpofX3F3Dei57UyZid
	 /i2nAu8FVpzgQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A592F4970E; Thu,  6 Aug 2026 19:36:20 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044969;
	bh=fYybDrrd1qNBlTREkdbKIfFsC0F+JymUVVxZMKrAGHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M3f7E0LPpAYtKuULLhPt0S4lu80KKbvmF/p24wfnQROuOeBtcSiSfHmY6ZSzLVGjC
	 HT2KOIBbPjc5ar8nVI80Uz9PRE0tUMT1cGqJ00S7LRtHtd8onyFXpq2AFITKRAPPAt
	 Zz4WjaXtVMQXXZ9FZSvvopZ6AtXRctuUsnGv5RdhvOKWYaYfUH5P0HXt7ev73dAZlq
	 LqhcF8mTsput4BbvEoDiUozA7bQxeEMv0YaNDH/KuVm2WoVQu5wQoRtMRdvUfO8OSp
	 EBOOPYECtA0pFwq/1zx9XRsX2XudU9Mqv2woN/8pi6Axk1mBEHXa0hzxsNJOGumWTU
	 GTQUm0Hm4Us5Q==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id DC4E7496F2;
	Thu,  6 Aug 2026 19:36:08 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 06 Aug 2026 21:36:05 +0200
Subject: [PATCH net-next v6 07/13] ax88179_178a: Add VLAN offload support
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ax88179a-v6-7-fde7414619e6@birger-koblitz.de>
References: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
In-Reply-To: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

The AX88179A-based chips support VLAN offload. Add configuration
support in netdev_ops. Features supported are:
NETIF_F_HW_VLAN_CTAG_TX, NETIF_F_HW_VLAN_CTAG_RX
and NETIF_F_HW_VLAN_CTAG_FILTER.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_lib.c      |   2 +
 drivers/net/usb/ax88179a_devices.c | 102 +++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 34350ba3b96b94bc82072a578802a91ebffd7a6a..9d6df9d5c61c841965e9f7fa4b1075561b7f9c50 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -355,6 +355,7 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
 {
 	u8 tmp;
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data = dev->driver_priv;
 	netdev_features_t changed = net->features ^ features;
 
 	if (changed & NETIF_F_IP_CSUM) {
@@ -374,6 +375,7 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
 		tmp ^= AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
 		       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
 		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
+		data->rx_checksum = !!(features & NETIF_F_RXCSUM);
 	}
 
 	return 0;
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 45cb182b2bb111bb7e974b4633f098ab876fe02b..f981a631dbbd1231ea8e1de0db215fbe5256e6d7 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -229,6 +229,62 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
+static int ax88179a_vlan_rx_kill_vid(struct net_device *net, __be16 proto, u16 vid)
+{
+	struct usbnet *dev = netdev_priv(net);
+	u8 vlan_ctrl;
+	u16 reg16;
+	u8 reg8;
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+	vlan_ctrl = reg8;
+
+	/* Address */
+	reg8 = (vid / 16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS, 1, 1, &reg8);
+
+	/* Data */
+	reg8 = vlan_ctrl | AX_VLAN_CONTROL_RD;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+	reg16 &= ~(1 << (vid % 16));
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+
+	reg8 = vlan_ctrl | AX_VLAN_CONTROL_WE;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+
+	return 0;
+}
+
+static int ax88179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
+{
+	struct usbnet *dev = netdev_priv(net);
+	u8 vlan_ctrl;
+	u16 reg16;
+	u8 reg8;
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+	vlan_ctrl = reg8;
+
+	/* Address */
+	reg8 = (vid / 16);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS, 1, 1, &reg8);
+
+	/* Data */
+	reg8 = vlan_ctrl | AX_VLAN_CONTROL_RD;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+
+	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+	reg16 |= (1 << (vid % 16));
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+
+	reg8 = vlan_ctrl | AX_VLAN_CONTROL_WE;
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+
+	return 0;
+}
+
 static void ax88179a_mdio_unregister(struct ax88179_data *data)
 {
 	mdiobus_unregister(data->mdio);
@@ -488,6 +544,49 @@ static int ax88179a_init_mdio(struct usbnet *dev)
 	return ret;
 }
 
+static int ax88179a_set_features(struct net_device *net, netdev_features_t features)
+{
+	struct usbnet *dev = netdev_priv(net);
+	netdev_features_t changed;
+	int ret;
+	u8 tmp;
+
+	changed = net->features ^ features;
+
+	ret = ax88179_set_features(net, features);
+	if (ret)
+		return ret;
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
+		tmp ^= AX_VLAN_CONTROL_VFE;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
+		if (features & NETIF_F_HW_VLAN_CTAG_FILTER) {
+			for (int i = 0; i < 256; i++) {
+				u16 tmp16 = 0;
+				/* Address */
+				tmp = i;
+				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS,
+						  1, 1, &tmp);
+				/* Data */
+				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0,
+						  2, 2, &tmp16);
+				tmp = AX_VLAN_CONTROL_WE;
+				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL,
+						  1, 1, &tmp);
+			}
+		}
+	}
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
+		tmp ^= AX_VLAN_CONTROL_VSO;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_open		= usbnet_open,
 	.ndo_stop		= usbnet_stop,
@@ -498,6 +597,9 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= usbnet_mii_ioctl,
+	.ndo_set_features	= ax88179a_set_features,
+	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,
 };
 
 static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)

-- 
2.47.3

