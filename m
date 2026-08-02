Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541EE3B7B70;
	Sun,  2 Aug 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688367; cv=none; b=ED+hbIJSsly02qwK9l7bPs3zViFL5BGYW6ZOYu8m+geIf7smM22tKZqJc31KxS7K7Fe8jkafhOouHezykT03Mc6Xgf93phmICPyvnmepoezsUstj0X77rysbPYuNSp5BTYVtkBagByc8AzwY27e2iFl7AR6tF71ceaPJ+3sHhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688367; c=relaxed/simple;
	bh=1lJvFkHqBAbikIFSPVhUOr7FYSC+jKTFRQ//f0Az/DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdhlOelJwMUheHffS/JMsRo715CIgAyhzUo5p2h8Fz1zIW4LAbz0+UFBd6uOfzxANGK3nIaY+hKM1LFtCfq2qQHySLGnXGH+7hJKHyup6qGLThct5/gvG9Q2s1MQbe3wjmN43lPWQQHcweVDiIbULVcMIusWooTvy7GlXsBCgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=AjfyQy73; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=MtwKdvAt; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="AjfyQy73";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="MtwKdvAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688362;
	bh=1lJvFkHqBAbikIFSPVhUOr7FYSC+jKTFRQ//f0Az/DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AjfyQy73KrRMDUG/DJVcgkJNSUantkbWlQ4u8xkpC7I5cnYoxONjaQLbSogXz33GU
	 AI8YsRs9RBucfWoS+Zfoxkt9SBxmApJe5FTsNjtDSFjnc7f9+TzHZ8goGGn7g66Dpa
	 QXJy33yTRfdEFAfR8B4kIZV7mF3saLIfOPX4e4BTpMu6jmN+ADp2b6qH5BWXKPiEc+
	 8ParRm7x79HtQ7VUDKyXXDJTmJFcm0cVnAhKY4ahAR4n1+l4OQP6bOubwyF6BD2aNf
	 e/D6CR3GAz/wYLc6WwYwtlC4HruOAzcaK2nUVnP7/eBzvy5xSgPfueNsEMfZhBiV/G
	 3y81QsAEda5bw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9A0C44964D; Sun,  2 Aug 2026 16:32:42 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688354;
	bh=1lJvFkHqBAbikIFSPVhUOr7FYSC+jKTFRQ//f0Az/DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MtwKdvAtI9mWwlm8mOCvZSaOcXlpGrSnRriwObCMdFLt8qTMTdSHEn7pcIB9qa8I3
	 byRWlV7nr3GWNm7f8e3HGyu5Ah+Z+mPeX24uPxux2PaH7eqTBm+80m43HbuOgvNIFM
	 vA0q2/eoYJmcrC/PAUlQz8llIH25YkTU8bEJRfIuQlvLK5cvathHMceU2xJjm44vvi
	 TaRyYxMVdXDIuBQSwfzkZe8sYM+2sQ2bs+mRX1sFZqNnIGzGoYHhs6FqtB4hJrnTJr
	 BtF0iRpCLuGJ/gNawelFdnMvu2fh6umKzdbHx1irYOY3ccMyGajiWwxPvXKO8WfGd5
	 lr2ZR9WizwkBQ==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4C6E649643;
	Sun,  2 Aug 2026 16:32:34 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:32:04 +0200
Subject: [PATCH net-next v5 06/13] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-6-dcb9fea4acd4@birger-koblitz.de>
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

Configure phylink to work with the PHYs in the AX88197A controllers
and provide ethtool get/set eee operations calling into phylink.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 22c7d1a4501dc052ebb16e06dff86e70c00c8381..be07effc20c3df0bad294f591b7150b78b0b5020 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -209,6 +209,20 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
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
@@ -218,6 +232,8 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_eeprom_len		= ax88179a_get_eeprom_len,
 	.get_eeprom		= ax88179_get_eeprom,
 	.set_eeprom		= ax88179_set_eeprom,
+	.get_eee		= ax88179a_get_eee,
+	.set_eee		= ax88179a_set_eee,
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
@@ -420,10 +436,18 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
 	else
 		data->phylink_config.mac_capabilities |= MAC_1000 | MAC_2500FD;
 
+	if (!data->is_ax88772d) {
+		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
+		data->phylink_config.eee_enabled_default = true;
+	}
 	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 		  data->phylink_config.supported_interfaces);
 	phy_if_mode = PHY_INTERFACE_MODE_INTERNAL;
 
+	memcpy(data->phylink_config.lpi_interfaces,
+	       data->phylink_config.supported_interfaces,
+	       sizeof(data->phylink_config.lpi_interfaces));
+
 	phylink = phylink_create(&data->phylink_config, dev->net->dev.fwnode,
 				 phy_if_mode, &ax88179a_phylink_mac_ops);
 	if (IS_ERR(phylink))

-- 
2.47.3

