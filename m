Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB83B7B70;
	Wed, 16 Sep 2026 03:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529098; cv=none; b=J6dmkN1KmQ8MuP2PtnYTZ2T6llk9gPQgqWgtROJH5veDXD4XTapDuK5zO/l9Xewq5SCGiiS7+UzjBeKHpzKSeMk0aDYsniAfS8OnBYPHJD/24Ukad1FPAyuhpUTO2b9qhIMSxd/ZoWaqf3Uozu3iS79SSpCf0wIZWrsydjTmZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529098; c=relaxed/simple;
	bh=E86tN22/K+HeBlTbVmZcHbD38nvcSu04QMpPK2iR/dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujXQsNOjwGfDAENlpAXrrXQzDMsFd66MAjA3BonHcE64e7q50m73oxgJZVnpXjj7aaLG6Hh92XoJUCQ0yPaMD5TKmpvaLsZoIzWvwx9+UVlIL1raewGejwW5FC2F1Qtkw32P2cLTieanZ9bKfpkL7EdKX6C/UwGzJ0GlayqU7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=jaBTnaCX; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kuK/NGW6; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="jaBTnaCX";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kuK/NGW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529094;
	bh=E86tN22/K+HeBlTbVmZcHbD38nvcSu04QMpPK2iR/dw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jaBTnaCX+Hj4WacRXZIrlm17qopqqZlGHHqG1XbKOh3jA3Wa+tKN9d0pyRRU6qXNO
	 hBYvHjiGRXma7qFg0IuMPjOouGFd0ItXQIciFk7SWS8PJTPcsRrZbNTVrH+6om5gp7
	 kDWe+9yYUcReAOkbaxs0FkifREXe95+x3pVge4PNqwEQkziTkcA8BZQVQcfHdwSjXm
	 F4gxQqtvOcfCDQAqwvI3Jw3iZZ3lJGH33UYmkU9CNcPUNSbqWjdnWeddEo0sPtfJ/W
	 XlhLzvrdMVAYrp3NCDI6o5fISI+IU6SrnUJ4xwGw+ZyG/dvMxpOtWfo62u7FVB0hIu
	 3SrRt59v7lBsw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 6A9363FA6E; Wed, 16 Sep 2026 03:24:54 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529093;
	bh=E86tN22/K+HeBlTbVmZcHbD38nvcSu04QMpPK2iR/dw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kuK/NGW6XyuhXf5VgNEcQ8cJaMcOGmkDFW2fk6lk5VHeAfq11xvzPxa6JV6yY2EAa
	 U8nP3jn4DpUj3DHiw0kU/5KwKLOJhfKN4TkfQwAgY8GopJ1s5fKxtRPtCEukHuqwPb
	 TiLF5FFfVMB5HnljTtPwVcfWatHQsYFrclSEOblTxoQezyQedg2+fxdnKxyh9WID6j
	 Fo7xDH9SRmMCrwAuNJPZwH0bfac/YYvkKHmKOCHXxdOb3QEewdtPYMKliLFcO4qqfj
	 TFdKKglYGS1vRWMHIovywHhlyluy8jmtdKO8GXxE3QuvYoJJ04U9B1kp+eBgYLZreJ
	 F2gj7F+VHSe+Q==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0C18B3FA6F;
	Wed, 16 Sep 2026 03:24:48 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:07 +0200
Subject: [PATCH net-next v12 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-8-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2

Configure phylink to work with the PHYs in the AX88197A controllers
and provide ethtool get/set eee operations calling into phylink.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/ax88179a_devices.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 785919e14e861e5e44a67a7407690a0cd8ddb180..6bf1ac17aa1d5abfc854eb3ac0896c69875ea0d7 100644
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

