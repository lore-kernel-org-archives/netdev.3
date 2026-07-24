Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5153ACA74;
	Fri, 24 Jul 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878625; cv=none; b=iy1uM3WMf/QaZlWAANOep6eoFLPM8tMEmNX7BJQzEuC0XTETWk+9LUiULRb25m2VPtvIMUviWjJeWUDUTLPv6u4WxvmtwSlH/Lmhmh5eoS3QhEysEQf/tF1kbFpkCuDKDZhI9u8id2QB80EfRsyLaZWxC2fjzRnkoH7Ul6dN9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878625; c=relaxed/simple;
	bh=SJu3YoTrHaAOpYFmFiAizjE7y2zKCL5FZ7+EZ/ARztE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8CtF5WMSZrSWDShHYxf3+CHOUhxv+4rSB2zFZpJN9Ps1tsz7ana0bx0zgXZ6kHHpLrzg0q1KPkgXmETXaevHwYpxG6yMG7AqMbj+EPSR7xr+iYxzhPZ1OjSk1o21pU1tk2PxtdslZsi2o7xOJJ2suTekCY8JAPBQkNRVVSf22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=s5mAHjmG; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=20i/B+Gm; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="s5mAHjmG";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="20i/B+Gm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878622;
	bh=SJu3YoTrHaAOpYFmFiAizjE7y2zKCL5FZ7+EZ/ARztE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s5mAHjmGyRMgmnCEsXR/smopi2VQ1Mr6eX+z3EK4qpa8CMBAOgEZj3wr7qG5VsGBO
	 Iidk3iuD80q9fjq0RAq62Be3kJeBE0ZB6k6sCwuzZrxHLL2wEzA5i71yWf4Y2LEXh+
	 Ox3Jz3+w3gZUaa0CANO1aLRNWvGfJYGD7SsKg8yy1774WFqzC6AJQ/GJ0wJdAZ9EFp
	 U+iVsRnO5B1fi14bWjcCB8wm9U1fHzVaAGcRkmY6+LpU0xN45fbqgevrdEj0DOUniR
	 nzxUJVhZf70KMczp0y36uH8l0TniZTeGS01qlHflCczm6RA8qSS/HMhcmVhsHnyfpq
	 Jz5iMVSDHTAQQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 15C464932E; Fri, 24 Jul 2026 07:37:02 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878609;
	bh=SJu3YoTrHaAOpYFmFiAizjE7y2zKCL5FZ7+EZ/ARztE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=20i/B+GmbM2uZy9hHkOOoM1EBlz6RpsB7Rf4CpOHDVKCOqmFMpxwWAbfz3UdEztBv
	 PTikcfH7Zowv93nqJn/CTawl/gL3cpmRF/mR9OKB4OiqMBWfoij3cb9SvjVBJ0FhlG
	 xmECqyXrvbHuWi8qQk1ln2ETgA66JOdhmooPvdpJcjYxIQ5l74vxdapRXU6QOjMikc
	 TqR+OAzIiOejM065WfOMa5+jXTlGW+5Xq6s+pt9aNkgqLWpi99GCClP4meFwm4PamO
	 22WTzrH5CG4BZsC/GfOLMWrPOzG/4AijTPmGLLmnLW1W286FjOuuSBKsxpgCYVn2bF
	 vIucN4y1qQn/A==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 260A049367;
	Fri, 24 Jul 2026 07:36:49 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:52 +0200
Subject: [PATCH net-next v3 09/13] ax88179_178a: Add VLAN offload support
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-9-bdde4f905883@birger-koblitz.de>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
In-Reply-To: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX88179A-based chips support VLAN offload. Add configuration
support in netdev_ops. Features supported are:
NETIF_F_HW_VLAN_CTAG_TX, NETIF_F_HW_VLAN_CTAG_RX
and NETIF_F_HW_VLAN_CTAG_FILTER.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 87 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index cc9a3ef4fa03ac36f89f78d2909a84d9b11d336c..d8617dad5990f38d39b4569a6347e219856c6f2a 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1202,6 +1202,62 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
+static int ax179a_vlan_rx_kill_vid(struct net_device *net, __be16 proto, u16 vid)
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
+static int ax179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
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
 static void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -1247,6 +1303,7 @@ ax88179_set_features(struct net_device *net, netdev_features_t features)
 {
 	u8 tmp;
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data = dev->driver_priv;
 	netdev_features_t changed = net->features ^ features;
 
 	if (changed & NETIF_F_IP_CSUM) {
@@ -1266,6 +1323,34 @@ ax88179_set_features(struct net_device *net, netdev_features_t features)
 		tmp ^= AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
 		       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
 		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
+		data->rx_checksum = !!(features & NETIF_F_RXCSUM);
+	}
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
 	}
 
 	return 0;
@@ -1333,6 +1418,8 @@ static const struct net_device_ops ax88179_netdev_ops = {
 	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179_set_features,
+	.ndo_vlan_rx_add_vid	= ax179a_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= ax179a_vlan_rx_kill_vid,
 };
 
 static int ax88179_check_eeprom(struct usbnet *dev)

-- 
2.47.3

