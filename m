Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585643BBFC9;
	Sun,  2 Aug 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688367; cv=none; b=YndHEx4MXwVlWLPkZ0Oh0QxvmHxfhcA+dcvygR8ZxjWbDoAfpd6td4LLUpmj6mbow3G6GFm1Rxy2kh4FGolYOqOSF7AMXT4g15TZs2fgbXPHdAaF6LpDh7I2G372t1gQqa47KGwbmLmwiqHjJVI9MTgkUEPI1mmCuwXe+Hn8N8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688367; c=relaxed/simple;
	bh=iMBg19JSHRh1Ay47H58z14LCpuFncHmvXc2BwnB9/f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IjfV+TKwjkO3nHSNxytWNWkwGnmsPzXWZhMSCBFMYuvkQ3shzHnciZK0q4Yf/6wvWt6NcSHgteZwc0TZZrD8eMRtVWaGoM3ujybu9vInhsU0voH40jvcxpB1ir2RXLUdSFBoK8rMW07dTnW8jaIa6ZVVpuplhXJb4LDaS7HSUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ukPjAGFb; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Cxwq5yYF; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ukPjAGFb";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Cxwq5yYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688363;
	bh=iMBg19JSHRh1Ay47H58z14LCpuFncHmvXc2BwnB9/f8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ukPjAGFbSRS0zV0DdEAqQsO7TJ/CTU0uBNpUDUOpZVDwZVm+QSgaVvF0hJ9+ZQCJo
	 bs5mSvBtUMDtmEXK5cdC+7/DiZX5fHCW4lUtlZBeKaIOzFrpQGZSVFXATf1XoNAcb1
	 fBKep0S/o0vW7yLiBuVuD5IiGB/RAm1Ywx0XVcatMk9zUItfWmtpSEYHjh3D3tRj0w
	 bZhTP5fXGyetDF6zHgH/GGxVjFkuipNfF+hyxASKQRQYajarbuxWahWC94UwfCPgtS
	 dlU7WUqOj4bFJTFeaYYFEp66Tj/d+qBlcOATxl4HLmvjsM8CQnJE9V+d0uQ8QIfgKR
	 nnEBK+igWnIag==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9A6F849665; Sun,  2 Aug 2026 16:32:43 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688355;
	bh=iMBg19JSHRh1Ay47H58z14LCpuFncHmvXc2BwnB9/f8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cxwq5yYFNc177byuUlUJl2N3cH6A3GHXNmIlSyxAkiuTt6pAEb1f+w7phu9L/1VXe
	 awiyuuW4NB5Zsc3qSxfmanMw5QyAjtnQf2aW6QecrMMdEN1XQG7hePfby6ULID+Ay2
	 B/JhwnTCJxjWVZQ0ksPCW5iB6Lg+HMvfhsKZV+buu33BbLLTxCVS+yW/bPUXzY7EWD
	 uMrnifGBoCNNsw3HNFp6tRpP5t8sJev0gTTR2a4Ecsh/83Tv96W/h+14Bz8uRN+fIn
	 P/9GGKj8gnXxi/RUw85UT7CxMCpFaFAJyzjFQasA51n1p3LAZPF++frU6Lk2AKCgoF
	 Wi7N2ua6cf4VA==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D804D4964B;
	Sun,  2 Aug 2026 16:32:34 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:32:05 +0200
Subject: [PATCH net-next v5 07/13] ax88179_178a: Add VLAN offload support
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-7-dcb9fea4acd4@birger-koblitz.de>
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

The AX88179A-based chips support VLAN offload. Add configuration
support in netdev_ops. Features supported are:
NETIF_F_HW_VLAN_CTAG_TX, NETIF_F_HW_VLAN_CTAG_RX
and NETIF_F_HW_VLAN_CTAG_FILTER.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
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
index be07effc20c3df0bad294f591b7150b78b0b5020..213eb974b7da576bb6546532ce45716055da1de0 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -242,6 +242,62 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
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
@@ -487,6 +543,49 @@ static int ax88179a_init_mdio(struct usbnet *dev)
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
@@ -497,6 +596,9 @@ static const struct net_device_ops ax88179a_netdev_ops = {
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

