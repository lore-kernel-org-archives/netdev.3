Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6261511E8E;
	Fri,  4 Sep 2026 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542936; cv=none; b=HtYkR2BNo28JxjTfeIPNQY60HlkZwhpxPFli0Ma11g/inRt4X0JSLmoM2MHhBsn0IwbxNuojYIvHsHSnKgkU8PwQKnguCohh2NwhTBnYj5xhZYF2pSVx3najLU/e+ESFHbd4fiKjK3MU9tSuYP7/65cxLsydhc7X238kYTKnzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542936; c=relaxed/simple;
	bh=DYQ5FadnmebGGMb6Bks7wdwfAyGxWSvvxyI2Nb/glRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uvpV+RTEbT6ruZ6SXPYu8Z55fhgTJCey3CX7th4XPZvP74ULAQqmNH/PKYtfn53+xIordIlk06QzVvzW4rlJUxsjakbbbHI2aSNk67p5JP/T4f4aTbQ3HL569VE643kOCY6l7ZjbIPlf7MMWVv194qIWbXBuBrmPNbEYyqUJcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=dFrKa6v7; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=O9dxqq4T; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="dFrKa6v7";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="O9dxqq4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542925;
	bh=DYQ5FadnmebGGMb6Bks7wdwfAyGxWSvvxyI2Nb/glRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dFrKa6v7C1ep0TwmYfwOOflLRKan4PkJBsj2oP1+uAczPzVkznxNgGSvmnXPUrbXD
	 RfQBJCxCUgsGVPFpgSFXn15+D5liaR3SD3SaztqD8XQPYq+XPT3ikFWcpBvW8H1Hi2
	 +9fIzcaBKZE7H7fNHoQwSjO/u2fSLjL2OMkgwEEdcNDXdXxiZQcMdWKeUvxHauF76w
	 ezRTEI3qiVkvt0wFip35t/BqbiRSguFkUc0XJnzYpogpQ6PFOD5NeDudxqzS+CXhaK
	 hZP1DoAv4SHhzqqJjkc5DxcrvHpHLnEhjvOlyqVGmI9gj7JSgJtMSMcIWvAvaNpkGP
	 8uCTPaBPIYrzw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id DD86A3F104; Fri,  4 Sep 2026 17:28:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542916;
	bh=DYQ5FadnmebGGMb6Bks7wdwfAyGxWSvvxyI2Nb/glRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O9dxqq4Tje14Pvgbcbclxum2w5IJ0BogHe9etnPn8p2M7QFuNvylTs71Xr9bB25cb
	 i9j7UYWpnHPAc53Sjo54zsM7hiLaj1yrFBw3EYb8Dhw4a7hM5HGFIV3B91MF+yZ3p0
	 +XnHHk8OmVgT6EIrN7l5ZMaBv6LXlm5wJNd1sHdZJy07hzfE11lMrMXJa+TvgplkU0
	 PJlkV0QjI9TN6i3GvNPhWi/L1adWB9n2hWy02DJl0wR6INz6dWiYHki+hh3CcaLzP+
	 +WF9RAfKVnL6pk1tScIP08GjQHOtqwiPPGLbHPusZdK/LQTDr0d1+2EINlzSYXCl6u
	 6yh0wKQ/VY9qA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D9BFD3F101;
	Fri,  4 Sep 2026 17:28:35 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:33 +0200
Subject: [PATCH net-next v10 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-8-b5e60eca7690@birger-koblitz.de>
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

Configure phylink to work with the PHYs in the AX88197A controllers
and provide ethtool get/set eee operations calling into phylink.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 6cd9bd6197280e8cf56295b8de4f6a19112092c5..6a5381ebc245697d1633f198b940ebe78bb7c628 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -206,6 +206,20 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
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
@@ -215,6 +229,8 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_eeprom_len		= ax88179a_get_eeprom_len,
 	.get_eeprom		= ax88179_get_eeprom,
 	.set_eeprom		= ax88179_set_eeprom,
+	.get_eee		= ax88179a_get_eee,
+	.set_eee		= ax88179a_set_eee,
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
@@ -440,6 +456,10 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
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

