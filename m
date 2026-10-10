Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51E369219;
	Sat, 10 Oct 2026 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608087; cv=none; b=udbOlkKvPAxtnAnlG8AO0ZX/y/rEyli183wNjG97ZOUbXkrFaGhCg9UvyrzDJ79p8M9PINvlsKyNOXqR0HbNhOEa2l6XOITo/TFWctoD8/8UDvlviP5IMsptt0AfsKTPjOcFVloWE42I6KY3C872TXitNA9qLVMoKOKihQyaB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608087; c=relaxed/simple;
	bh=hM3oF5K1hZslFyqDR7TTdamJtF9O4stBo/mf2SjKeiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mi/rT3Ct9yvbiXscp9+CG3i/mFbZtPZ3WbsdN9/AA0UQujV5Hgc2S3w3t6rDk+av7RCA2y/RN4uCbdQaVSF5hk3uJkTLDFwSYs6kAJbr+hNRf3Kw0n8O6+u6FRiNVyiskxtS5RRJjhvErRM0t757Q7l6Mu1O4GFqfeECyzi8pXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KVUZfs18; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Y+Y+VHkq; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KVUZfs18";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Y+Y+VHkq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608083;
	bh=hM3oF5K1hZslFyqDR7TTdamJtF9O4stBo/mf2SjKeiE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KVUZfs18Zjhq4xGaZkrq1K0j8MbXiUCD5zbsrawLtiD2tBAc9WhigWf79KeQ6cqAp
	 eLYAFqNsSpQWy8izKq2mZH1Sl84WpteeHjngRjew3Fg05MVj4AAeX3vOGbpnQS7YrP
	 VRBJo6B43otvMgCz0h44wjKcow7H/v0EGE8OIzCaTAHh4M6Da3Q0E2Ax2ZunWCJD8T
	 0jh/olfJjRWSVQOfrPJZBNTU3f8YadaqGcKuSjAyCBLRton4OVixJVYxQOuKBCeSPX
	 iDR8qV60OKMZyELYwm7BHZjudf1hqFu9L4ta120UxEEqNQ/bWPpXoaGm5dpZrarI1I
	 hc2btC/opVb3g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E803F475D3; Sat, 10 Oct 2026 04:54:43 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608071;
	bh=hM3oF5K1hZslFyqDR7TTdamJtF9O4stBo/mf2SjKeiE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y+Y+VHkq9XGeSi9GcsgiODUUGf9QrF50yXHWfLD9qyqYnON+G+uf71YqWU64J021G
	 qx4RSAj2sb97PUcc1Kniv4CDpCnnEcNavh5jqQQFTf9HQt60GV5Mx2DihUXMnNiZcU
	 X0l4Uo996EWjp4USpAsTt4kSD3L/W1cZw++HozSCzCeIWpKnqyjWpgwLUo27aQe3pr
	 OpgN/DtAWebeWU26JAsPwXV+wlFKxB/74LLnGRPSReDvQnfa/JEol99IfUR+RJbJob
	 R/jbFZIT+J9lSlBzlnaXW/Fwo7Xw/5KUkCR7ndSQq+ddF8NeSnfdtrkpHuJnGYwh8X
	 96fkst0BhOpAw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 68A9147597;
	Sat, 10 Oct 2026 04:54:31 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 10 Oct 2026 06:54:29 +0200
Subject: [PATCH net-next v19 07/13] ax88179_178a: Add VLAN offload support
 for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ax88179a-v19-7-7475173cfb56@birger-koblitz.de>
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

The AX88179A-based chips support VLAN offload. Add configuration
support in netdev_ops. Features supported are:
NETIF_F_HW_VLAN_CTAG_TX, NETIF_F_HW_VLAN_CTAG_RX
and NETIF_F_HW_VLAN_CTAG_FILTER.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Error-checking fixes Suggested-by: Jianhui Xu <neuromoments@gmail.com>
---
 drivers/net/usb/ax88179a_devices.c | 158 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 272e92365683247b42a5fd25013c728a9c1af711..4207d2cc2b865e5780b3c7f5ba2645a6242df477 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -258,6 +258,88 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
+static int ax88179a_vlan_rx_kill_vid(struct net_device *net, __be16 proto, u16 vid)
+{
+	struct usbnet *dev = netdev_priv(net);
+	u16 reg16 = 0;
+	u8 vlan_ctrl;
+	int ret = 0;
+	u8 reg8 = 0;
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
@@ -517,6 +599,75 @@ static int ax88179a_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
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
+			u8 vlan_state = 0;
+
+			ret = ax88179_read_cmd(dev, AX_ACCESS_MAC,
+					       AX88179A_VLAN_ID_CONTROL, 1, 1, &vlan_state);
+			if (ret < 0)
+				return ret;
+
+			for (int i = 0; i < 256; i++) {
+				/* Address */
+				tmp = i;
+				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS,
+						  1, 1, &tmp);
+				/* Data */
+				ax88179_write_u16(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0,
+						  2, 0);
+				/* Write-Execute */
+				ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL,
+						 1, vlan_state | AX_VLAN_CONTROL_WE);
+			}
+			vlan_state |= AX_VLAN_CONTROL_VFE;
+			ret = ax88179_write_cmd(dev, AX_ACCESS_MAC,
+						AX88179A_VLAN_ID_CONTROL, 1, 1, &vlan_state);
+			if (ret < 0)
+				return ret;
+		} else {
+			ret = ax88179_read_cmd(dev, AX_ACCESS_MAC,
+					       AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
+			if (ret < 0)
+				return ret;
+			tmp &= ~AX_VLAN_CONTROL_VFE;
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
+		if (features & NETIF_F_HW_VLAN_CTAG_RX)
+			tmp |= AX_VLAN_CONTROL_VSO;
+		else
+			tmp &= ~AX_VLAN_CONTROL_VSO;
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
@@ -527,6 +678,9 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+	.ndo_set_features	= ax88179a_set_features,
+	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,
 };
 
 static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
@@ -612,9 +766,11 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
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

