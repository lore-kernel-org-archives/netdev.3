Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3834AD4CB;
	Wed,  2 Sep 2026 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368261; cv=none; b=p8dsKlQCL3cyMDfzun+5zAsUHYaZheIN52Za5wqwjja8u+ZysYcEapLpSBiybK6QQmDkjsy24bfpZQCA0hsDSfd9YVwXd1L6cCuJnbTrg80K/SbVqcD597lXFeslnU9moR4kKPos5MXUNKZAI15sg4Wl5yB/0oC9JyagAoLKkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368261; c=relaxed/simple;
	bh=RZ+iISAI0kSIfPmjtYrWzUR6lzVMkiJxvjHF2fuivoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BvqLSPawLM3fzPny6IGVLQaNNigXwTdUdeokkFD51NUvJuhFhCBPFwNVj11VIx2k9LrHDAI/SAsZouaQZKMpgotfaHVb0AQqFaFC1f6SoCDUfOaRBdXn62JIKhWN32DFT5Sf+dg9w89WVVtQgXICNAKdb1AYe6qBVVMnJ/BBndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=HUfrXaZ2; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0SMzNaJr; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="HUfrXaZ2";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0SMzNaJr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368257;
	bh=RZ+iISAI0kSIfPmjtYrWzUR6lzVMkiJxvjHF2fuivoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HUfrXaZ2ifUv/uipCHCB4dV+sSWPJUUyYWJpzFCDkre12aRqV2WbXLewj2HG6bn19
	 mOlUNTrbDsJFC66/jU0LgTF21iJg+tuRoVuG12pRwECq5AtfleMX3WSIjEuyPE00Op
	 Z4Sn3bXv5p1ywy3HFSNlbZbwkSzdc/UtMGFgJcXr9Q6MynqghOG2tXcv9hyYi9j0/k
	 TjIt9zqBiH5tunfsWtv4CevaFfjfYcOxKpGmtXck29JqnWkIN/2CD+23pbmhaY+1WD
	 EPCO6Keh4YVwzXtceiWK28VvR1id9VyUJmj0ZDvPgNmNL9aTic9uGkDp/ZqQ3qL4P4
	 eyTcgQdC0MCrg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 467FA3EF33; Wed,  2 Sep 2026 16:57:37 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368246;
	bh=RZ+iISAI0kSIfPmjtYrWzUR6lzVMkiJxvjHF2fuivoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0SMzNaJr6jkSxtYaMoHNBmGiRiLZqhxOX3HBknt+9W0qfmWA8IMiAO4xt/0pRIVR4
	 v0ZEP9q9dlunzfHlag3rwUAf+CKqOInJCGFU/fOZaFPhY30N7oVC3CUkfRxmfDeG/2
	 LjtbVdWB6pbCuIRS+BZP0rkrm97Oh77JddBwGODmkncE0Wzng0MRINOBzwsyomf3oj
	 rGdfpP3UW7c7D1MQrikPURT8h0wOwxDyligQDu6bGM1B7OreU5MD28xqP2LLlZqgA6
	 W6Y40cvQlO7sarao78XMWzgJDvsfiGVWVZY7XYvunelavcRo8fcg6qPfyD8P3lLSpo
	 Es0KVVc+cU7lA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 113073EF01;
	Wed,  2 Sep 2026 16:57:26 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:23 +0200
Subject: [PATCH net-next v9 09/15] ax88179_178a: Add VLAN offload support
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-9-8e6d7710a2ae@birger-koblitz.de>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
In-Reply-To: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
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
index ea36aef3d3e45ee4f84362a1b87628a12a355bbf..3324069e90fc352048817963f27a49ed3872b348 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -346,6 +346,7 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
 {
 	u8 tmp;
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data = dev->driver_priv;
 	netdev_features_t changed = net->features ^ features;
 
 	if (changed & NETIF_F_IP_CSUM) {
@@ -365,6 +366,7 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
 		tmp ^= AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
 		       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
 		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
+		data->rx_checksum = !!(features & NETIF_F_RXCSUM);
 	}
 
 	return 0;
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 966e86a007fab2e73756af52eb66ae654c7e09e4..4e51b2ec2d1dc2def852b407fdc736a4dc676461 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -237,6 +237,62 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
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
@@ -497,6 +553,49 @@ static int ax88179a_init_mdio(struct usbnet *dev)
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
@@ -507,6 +606,9 @@ static const struct net_device_ops ax88179a_netdev_ops = {
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

