Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453D3B995D;
	Thu,  8 Oct 2026 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431491; cv=none; b=ezBpXss3/IE2A1+PpShKD8EQbEbQZTOamkUTxWcFVCfiWcyCp8hHxkBueGRxnAU7I49Leg7O0sf7j6qRcGubLnyDS0dC+Ac/KdVnpPC4Yzm0pgTC3PY+Nx845s6mU+cdpNjKhLi68UzZRj5+0C+h2QsRwdBTD+HVbU8HlqzVXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431491; c=relaxed/simple;
	bh=ygB07SbFyDLDYEaACBlPVDhQb2HgQZEEEfnljP7c7I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUfvavk5Jfq3/MDDy/x59gkR8dt8W66GsZIKKy/bAUWoTU393xA1KCY+eMUpoQrD4au8LPdNL5m+xD/zmq3H1rw+3JNJx3iS2qjzL4InesZOafF64xO784+dM/UoNrSFsx5rNNcijbVHYKuuCLw2iqvyxRxf9Q6zzvArM2uqP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2848+FcC; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CF83a7vW; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2848+FcC";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CF83a7vW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431488;
	bh=ygB07SbFyDLDYEaACBlPVDhQb2HgQZEEEfnljP7c7I0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=2848+FcCcqRKgRW7OPK9DPLhB3eCk4rYI+SdkK5F2uEf1WZVXXFwbd1aW394FJ4x3
	 XdtrBzVlIo4+9vDN9tSb6CiY06LE1oM3F3EfwRdjZ+C8HZA3Vktrx9GzZASbIlKU3g
	 1vVcbfdldmZWfDxL26XcVXgEE9ApHKsEGod19Y0wlFaBitqmMENcHc/wky41asStCi
	 7MNoGOG7CbUl6iIFdVovRe2IqvVk0ENauTs+pH3l2QTSPmLidtmqdJ5hP8UwwMoUiL
	 Qq+1Ciq4BiO1oEce8Woif6af+B3b8NyiVrlRRmTeUqCD4W29G75XOuC1bId+HvaO54
	 QUMIhJqgTN9dg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9ECB24719A; Thu,  8 Oct 2026 03:51:28 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431477;
	bh=ygB07SbFyDLDYEaACBlPVDhQb2HgQZEEEfnljP7c7I0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CF83a7vW3Dcna73zsmvLdBDbTPM4f6oze7fV1JGVT/u6Qx0wDKRcXNI/ZPZd0C+Ub
	 NLOlann8PhnSusNp5bXN7U4n+rn91EaXuDyj8srSD19C5zsx7/sEIT/NpMK4O2Ml2l
	 L+nc3NvVZYE0j8+tMNy9QEbJQZlVH2FuV1jij6S4D/VkLI9LoEf/+oAdFky/uoqy/w
	 6kSzDHl7rP0jrXxXDVqaQQtdXxXSS5PmjbNCSUr6N3TLjv6pFf7i+yntj96lAI7j3a
	 AmZPUP6VaSBmZ9lWmhhUXpf5IU60+uuxPlD6eLKLTJpr1fPmHzq2xUNAc8uQoxyojF
	 0pOYeX6eiGH+Q==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4DA2441186;
	Thu,  8 Oct 2026 03:51:17 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 08 Oct 2026 05:51:12 +0200
Subject: [PATCH net-next v18 06/13] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ax88179a-v18-6-6fa1d4c40422@birger-koblitz.de>
References: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
In-Reply-To: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2

Configure phylink to work with the PHYs in the AX88179A controllers
and provide ethtool get/set eee operations calling into phylink.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/ax88179a_devices.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 692ede39c9e9a0cf546733c8d0f71a199385eb6f..c41d9c2dc737a3bbebd4dd969de244ba7a4b3a11 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -225,6 +225,20 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
 		return AX88179A_EEPROM_LEN;
 }
 
+static int ax88179a_get_eee(struct net_device *net, struct ethtool_keee *edata)
+{
+	struct ax88179_data *ax179_data = netdev2data(net);
+
+	return phylink_ethtool_get_eee(ax179_data->phylink, edata);
+}
+
+static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
+{
+	struct ax88179_data *ax179_data = netdev2data(net);
+
+	return phylink_ethtool_set_eee(ax179_data->phylink, edata);
+}
+
 static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
@@ -234,6 +248,8 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_eeprom_len		= ax88179a_get_eeprom_len,
 	.get_eeprom		= ax88179_get_eeprom,
 	.set_eeprom		= ax88179_set_eeprom,
+	.get_eee		= ax88179a_get_eee,
+	.set_eee		= ax88179a_set_eee,
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_link_ksettings	= ax88179a_get_link_ksettings,
 	.set_link_ksettings	= ax88179a_set_link_ksettings,
@@ -451,6 +467,10 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
 		phy_if_mode = PHY_INTERFACE_MODE_SGMII;
 	}
 
+	memcpy(data->phylink_config.lpi_interfaces,
+	       data->phylink_config.supported_interfaces,
+	       sizeof(data->phylink_config.lpi_interfaces));
+
 	phylink = phylink_create(&data->phylink_config, dev->net->dev.fwnode,
 				 phy_if_mode, &ax88179a_phylink_mac_ops);
 	if (IS_ERR(phylink))

-- 
2.47.3

