Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062751476C;
	Fri,  4 Sep 2026 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542937; cv=none; b=kts86lt0fm5Lr5ASj5QFmzehyPir1GznOPITE6qulCi7bYs5vPSdJYjmh9pg08MlOF4ZRamrneWAQTST8NrkHD2x+5LONFPzekYsfbjbB3Sas74Qkmb46i7TUhCCeCFEMWjJyaBnbAHYvx9byoTsyFcw8xgE3dW1nZtxDnHVjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542937; c=relaxed/simple;
	bh=wlYvlqMeNeN1YEtfU+bl3W3gyW5Xl0ZDMWtm6GNrP6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjzPZCRJzsynI0vhHffrjfv9IS5NceRCYcZ/HSWk5W7bZYEfq68iKhFDfyFvQlDPtW1Fv6LvwgfEk4cohvrB2aEwd1A/5s5D9lEbjvSpf2TS1Nc62huCI6z7ydtZOHC+3W2J/dgChto0SpM/S9fPYeLnBesEospUrSZsgj67rzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=K/tl9T1i; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=s9M6dtl+; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="K/tl9T1i";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="s9M6dtl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542926;
	bh=wlYvlqMeNeN1YEtfU+bl3W3gyW5Xl0ZDMWtm6GNrP6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K/tl9T1i9CFunj7f3OzOmjwl6vbBI1VG8k8R3irTPqiZsAilxTbaaMMhBNue/qm1u
	 dMsibfcxz9MBKqpb1m1UWSkGhpvp8XFPLeVxhlSrO7nVwHfNjU926+3Wa7IIxpUYRz
	 X98dbLqJItrbUwyE2NaUR+96v7pH3gExKQiy+1axYk4uquTjD/Om8fe5E8ol+Betkl
	 8wLGXykZd15l4ui4pKpiQ1LjTrqtKgo3lWh4OHD+Nqf1tD1e+W4Zay7gq8hU4+wl4I
	 pOFDElaBpQGwuBxspkVnpRFZuQ1JFob/fFwKUK2InvMK54OvzBUVXEPu1xgsfNpR7C
	 vCDAB0v51spKQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E73803F0F8; Fri,  4 Sep 2026 17:28:46 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542916;
	bh=wlYvlqMeNeN1YEtfU+bl3W3gyW5Xl0ZDMWtm6GNrP6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s9M6dtl+wel+n0Eu+gYR6wjA5iCJCZvNhDyS41P4AbreQN8aZFjP+ytajj4ZqHyQ9
	 lah/sKF3NKeWx+Lk/zBsdDIZ4AOTf29ulm6XhFBKWiSGTfY+wy9Y1BImdEff+kyPjL
	 3USYiEJpqiYp2rVB2kSSQoOZJO+HqrhJF8cCj0h41zZ/FIyy2i9RNuM8bKBy1tB0/P
	 /K0ErDzXpxw2ssby/d/+DP48OmlxAhLX7VnMSf2pYUH3KjIiZD3Dmo1plcZkouRHxZ
	 xAwwbAxOzr2c746AU2XfLpBBriE4HTcpzlbhSlOzvUvwguT0M95u3MEioNZrocnlfy
	 c7Qou88QGfp1Q==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 456CD3F0D7;
	Fri,  4 Sep 2026 17:28:36 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:34 +0200
Subject: [PATCH net-next v10 09/15] ax88179_178a: Add VLAN offload support
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-9-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
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
index 6a5381ebc245697d1633f198b940ebe78bb7c628..12885a4936223def82e4b85951a566cbb64d2193 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -239,6 +239,62 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
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
@@ -499,6 +555,49 @@ static int ax88179a_init_mdio(struct usbnet *dev)
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
@@ -509,6 +608,9 @@ static const struct net_device_ops ax88179a_netdev_ops = {
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

