Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EC3F54A7;
	Sun,  4 Oct 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092378; cv=none; b=VUDspGWrtMvjW/HfEeEnDUQMrwECxE3+n3sJRpURPEA/HB16d/+DvMPCNC/gUSIyo9vUwG2p3eR74Aaf/o+9/OdCl/sVZOHBwCi4S/mQAQN9VJ7YHwgR0FY+LkdBtykGcPmsALrWj1p704d50jA5tpgGaqZsm2hQq6eVzZmT4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092378; c=relaxed/simple;
	bh=X1+nHvOHtkK7mjBKLXDH9k0umrY3SWlubplmHeRjPRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=az/0iqmhVGzsdfF3/R7HgjdLE9mNE5DjuYTj1fvwziKQksEypKWYLmKkzRhGfAcQik/qLZUUbpdTPm9jyX6UQ4lVQhbb455ixHMfDdzibj8+gXH/qXCSC8JEs1B3ymqvcQYAPBIrRBp0cX4ZxJp+lt3/qIWOAszpd7DqIHtRG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=At+khGJi; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=YwPTiEb3; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="At+khGJi";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="YwPTiEb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092365;
	bh=X1+nHvOHtkK7mjBKLXDH9k0umrY3SWlubplmHeRjPRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=At+khGJiH56Fco44QFp8laeKwqMCetchAjkS/k1c3ZaQydP0qin831yFyiasZqP+m
	 5DPn9Pv92wsjO3aJkXDK+JplCo1mK2ZGG5Kq09eg8Ueb7xmx15GDAyhr+8QDd3WpGy
	 8ky3VqnG7ZnEzOCDbldeOX99J8jxuGrCLRyeZsyp8m84BsDjXngjEMH5g7XbZ2R1Z8
	 Ll/d4QsQrt22+pgDKRbbSIDzkLD62ODWgBKtBuoM1QhdLJJqeWFObQ84L9xK1FhMHP
	 MLoH+OT0pjCg2RTCoQVSYor7AFvLTrSMGnEEYdGV5q5ejruGE/rSwGC/G5+kU9SjVw
	 fiVzJVBHC/UQQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5C82F48366; Sun,  4 Oct 2026 05:39:25 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092348;
	bh=X1+nHvOHtkK7mjBKLXDH9k0umrY3SWlubplmHeRjPRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YwPTiEb3LJ72FMn78fTcwfOaT9aUKavMyox9GiC1fV7mCogHPkvPVcSF2o+NgDx5m
	 LA9pKpywjvHtZ9CJqX75Rg+nspAo9vE8BDj6jvTPrcqSYiBdQzKuy7kwjZvYp2ADqn
	 +HkYYbmlhJYf0MzEqh7g6wGu3rABqVnGfZnrwAfjjVkuL5/JoPACmCFGUNsuuhY5jn
	 lq68yisWtT6KZDcN3pv194oF0EGoOMYirg758g3S4IBV3mOkWYHB6+EUjxovrUxrmq
	 t8n5KM+pg20LvM02E15MfwSX3QIsON2V+1VefFpn7350Jo2krNqXjEi9eMArjR+QBC
	 xMfINWNGwOjeA==
Received: from AMDDesktop.lan (p5dd1ef42.dip0.t-ipconnect.de [93.209.239.66])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0F76148354;
	Sun,  4 Oct 2026 05:39:08 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 04 Oct 2026 07:39:11 +0200
Subject: [PATCH net-next v16 07/13] ax88179_178a: Add VLAN offload support
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-ax88179a-v16-7-2a9ae4e68f7b@birger-koblitz.de>
References: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
In-Reply-To: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
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

The AX88179A-based chips support VLAN offload. Add configuration
support in netdev_ops. Features supported are:
NETIF_F_HW_VLAN_CTAG_TX, NETIF_F_HW_VLAN_CTAG_RX
and NETIF_F_HW_VLAN_CTAG_FILTER.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Error-checking fixes Suggested-by: Jianhui Xu <neuromoments@gmail.com>
---
 drivers/net/usb/ax88179a_devices.c | 141 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index e2ea9724433929d4cbfba0597787ddcb84dacf98..9d84a678172c9c8fe9918dc034944e6a7c89446c 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -258,6 +258,88 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
+static int ax88179a_vlan_rx_kill_vid(struct net_device *net, __be16 proto, u16 vid)
+{
+	struct usbnet *dev = netdev_priv(net);
+	u8 vlan_ctrl;
+	int ret = 0;
+	u16 reg16;
+	u8 reg8;
+
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+	if (ret < 0)
+		return ret;
+	vlan_ctrl = reg8;
+
+	/* Address */
+	reg8 = (vid / 16);
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS, 1, 1, &reg8);
+	if (ret < 0)
+		return ret;
+
+	/* Data */
+	reg8 = vlan_ctrl | AX_VLAN_CONTROL_RD;
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+	if (ret < 0)
+		return ret;
+
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+	if (ret < 0)
+		return ret;
+	reg16 &= ~(1 << (vid % 16));
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+	if (ret < 0)
+		return ret;
+
+	reg8 = vlan_ctrl | AX_VLAN_CONTROL_WE;
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ax88179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
+{
+	struct usbnet *dev = netdev_priv(net);
+	u8 vlan_ctrl;
+	int ret = 0;
+	u16 reg16;
+	u8 reg8;
+
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+	if (ret < 0)
+		return ret;
+	vlan_ctrl = reg8;
+
+	/* Address */
+	reg8 = (vid / 16);
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS, 1, 1, &reg8);
+	if (ret < 0)
+		return ret;
+
+	/* Data */
+	reg8 = vlan_ctrl | AX_VLAN_CONTROL_RD;
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+	if (ret < 0)
+		return ret;
+
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+	if (ret < 0)
+		return ret;
+	reg16 |= (1 << (vid % 16));
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+	if (ret < 0)
+		return ret;
+
+	reg8 = vlan_ctrl | AX_VLAN_CONTROL_WE;
+	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static void ax88179a_mdio_unregister(struct ax88179_data *data)
 {
 	mdiobus_unregister(data->mdio);
@@ -517,6 +599,58 @@ static int ax88179a_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
 	return phylink_mii_ioctl(data->phylink, rq, cmd);
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
+		if (features & NETIF_F_HW_VLAN_CTAG_FILTER) {
+			for (int i = 0; i < 256; i++) {
+				/* Address */
+				tmp = i;
+				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS,
+						  1, 1, &tmp);
+				/* Data */
+				ax88179_write_u16(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0,
+						  2, 0);
+				ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL,
+						 1, AX_VLAN_CONTROL_WE);
+			}
+			ret = ax88179_read_cmd(dev, AX_ACCESS_MAC,
+					       AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
+			if (ret < 0)
+				return ret;
+			tmp ^= AX_VLAN_CONTROL_VFE;
+			ret = ax88179_write_cmd(dev, AX_ACCESS_MAC,
+						AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
+		ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL,
+				       1, 1, &tmp);
+		if (ret < 0)
+			return ret;
+		tmp ^= AX_VLAN_CONTROL_VSO;
+		ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL,
+					1, 1, &tmp);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
 static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_open		= usbnet_open,
 	.ndo_stop		= usbnet_stop,
@@ -527,6 +661,9 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+	.ndo_set_features	= ax88179a_set_features,
+	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,
 };
 
 static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
@@ -611,9 +748,11 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
 		dev->mii.supports_gmii = 1;
 
 	dev->net->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
-			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO;
+			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO |
+			      NETIF_F_HW_VLAN_CTAG_TX;
 
 	dev->net->hw_features |= dev->net->features;
+	dev->net->hw_features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	dev->net->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM |
 				  NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO;

-- 
2.47.3

