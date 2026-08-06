Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C34D90A1;
	Thu,  6 Aug 2026 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044982; cv=none; b=WfSJQ6XtCZRhGB0hUYC6DjmFt39qkPEcxgkQRWxVIVw46FGuThpCGsuHGBGnkDXvlSQFeutPn4XOOSXfDpVBhfOLgC1+jzdsGRXL1AZRLqwShlnJz5F9I4z3ju94JqFqZYURUFB3Jk9F6G1GeaXjEpBq/ol6fkHaEVMjfePYMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044982; c=relaxed/simple;
	bh=iwkOWinRkBFoZqwG21WPVQt6YNoDMnM0s9WBZoXCTXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amHNHp1n983IwcKzEZiV3BTm/tI6d+6I1tz/WUJQT6Jt7NSqMboqHlNZp2m4yDFmq0gAOKgATL7V1uCi8qi8gyjpwqCMX/yA4cW0GfANUQAzlbE3ZgYRMnIMeG77Bp5yylyD7bVCRNPvomRkJ3hScchx4X1PdUeeyLaJ9h8ONJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DbM7qP75; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=YUKxUGpA; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DbM7qP75";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="YUKxUGpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044978;
	bh=iwkOWinRkBFoZqwG21WPVQt6YNoDMnM0s9WBZoXCTXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DbM7qP75z2PgjAlaIt0OmbcFK67K3c6EHtN12Z+fgfHTB62Wvqu85i3ngnu4hvePt
	 KHaeBT1DgREoi79WwpvsWymBGKBN7VHB3CyySwnCv975WEEpV1aXBbE1eBOJZCN4jm
	 ONr8g/CMMAtcgp+/otdvk2S6BSiLr7Z/nLrp8Q0DLCuLvQwaY/q8uylAQIYNnjS3S8
	 /sCoQwP1Jjs1EK1F3g7ggdNnFmybt/lrSBlisO5xzV6PIFPAhslg1k5C5JxauiCz0A
	 hfZWteMtixB8PFs1toVtTy+rnV7cdObYbj49rRZ2pWpc8OQikaM0bvh83ZNIGIK0uS
	 OA12e1Hwk7jeA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EAFF1496FE; Thu,  6 Aug 2026 19:36:18 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044968;
	bh=iwkOWinRkBFoZqwG21WPVQt6YNoDMnM0s9WBZoXCTXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YUKxUGpAQT/JNCeavnHdZHRZ+PR5EpbbwgtnsDAoIRJVxbJsz6mMzcA7wVozr8tVc
	 Hafmt7XdUVbWGf10HZstBQ+4gSWRwSQyppqBX6r2LFukHsnZFVjnjSxIGQIYoC8oF9
	 g9FjUZbgAd/dnsLEk0BRUWhObe10nMJK8M9K2pFoYFSbK4T4UE+pYDpJmUpcZq824o
	 d4pwnl6tpxV9tftiZi06HwFtkUpMtoNz8FK5+ZJ2dr4kFLZkioZhs4CdOffIr2r/zL
	 LnsN3+0cyaFAaV1lR82ysSdEgzKEhV0Gz0NClbsa6rbQsLxV6/sHYFLxbneXcaCCj3
	 gR2rUxnKZKkkg==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6C10E496F9;
	Thu,  6 Aug 2026 19:36:08 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 06 Aug 2026 21:36:04 +0200
Subject: [PATCH net-next v6 06/13] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ax88179a-v6-6-fde7414619e6@birger-koblitz.de>
References: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
In-Reply-To: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
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
index 04aaa9c91bbba2079b7369840b1ecb7b06df00bf..45cb182b2bb111bb7e974b4633f098ab876fe02b 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -196,6 +196,20 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
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
@@ -205,6 +219,8 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_eeprom_len		= ax88179a_get_eeprom_len,
 	.get_eeprom		= ax88179_get_eeprom,
 	.set_eeprom		= ax88179_set_eeprom,
+	.get_eee		= ax88179a_get_eee,
+	.set_eee		= ax88179a_set_eee,
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
@@ -429,6 +445,10 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
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

