Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14404A9D6C;
	Wed,  2 Sep 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368259; cv=none; b=ZDeNE7LPWRJizDEnpk0WszSikGkqB/EO0ud/DR8COr715TKqvI0gER7I9wKKJWx5uxJmK1Cr9202RfZKZnDFoebVJPPZNaqLMmgIjTvD8KFSYI796zVicTh9EO9lCgrSgV/Qmh4JV0d5osK7bWlkN87SdROfsdkSbfsCkT9mT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368259; c=relaxed/simple;
	bh=+jWjbE4LavDkqylCyIJIKiZBFkq9B+LwhAk7I6B4hHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2EsuSTbqy3IlA9BwmpxeMoN9Eh3ShQyscoCrx5mPboBaJ0mMY4jfWjDHqG37b1PStuywMc/Om/wIaAJ+Te3cwfBvfafSzxvOAh0g+PHA0DogbjKGDO309XXBc6hIJMgpzP43ASzo4/o99TYHoMdw+IvQqWxvPfUh4DxrKDX3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CasyByOU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Oc+UW7vp; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CasyByOU";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Oc+UW7vp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368256;
	bh=+jWjbE4LavDkqylCyIJIKiZBFkq9B+LwhAk7I6B4hHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CasyByOUYkGoeVBviWIWWt63cfDN1JvCYQbVXW8xJrlz8MnQ1c+O8FWxMkziYK4a7
	 XxTCC2glWIXakTmmPanQc3rNrk5GtIOhr7fk+rp5YOy6YpxkTNDNV8dPjI7nsyKlNR
	 GBVy5vk0ofSzH0o73h2qSKrODOQ/+kvXkwU7IcmS2PekIijwvGTbvg0xpKk0qmPRbe
	 j2DEgh4tkyG78ewJC5aHD5I8xEU2CYbFsyrHjMvGnciSAo+a55202C4+lwmhx3qYiX
	 gvrbce+O6tMza/QWreEoW/CUYjlTiZaBLuZiqxx1A4Xahlhfeazp1V5kIuE7wNhnAc
	 YU7UiE+iyTskg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 34A743EF1F; Wed,  2 Sep 2026 16:57:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368246;
	bh=+jWjbE4LavDkqylCyIJIKiZBFkq9B+LwhAk7I6B4hHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oc+UW7vpDyJM8DrK5lSKMssstxhYfHBzx54PMEh2SyLHqkSG8XYbXG36651ruuOHt
	 r2BlppHyadLBLx313ksci0LW/i4t92ZUYFQHiyy7fmAhp6AcgLLsy3bZ8CO7+r08g/
	 wWhYSDTm8G+FJFFzf5Z26VUhQbBTW89vXmqCmEEYKpINyn/eCcoVsKWMJ0CL541T/K
	 eWsi2OAhg5h7LJlSH+yq85pbAoDq1YZU79PtYdssYQbwNpzkprVbXq5zQ8LokFcaUU
	 LE8Y4Ep9n4GuHEM+BhW1LChTfvOyun6nuno0BG0JLm5GzsYHudi2VJ7jYDMKvMpGNk
	 Q11zPognu03Ww==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B53A43EEF8;
	Wed,  2 Sep 2026 16:57:25 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:22 +0200
Subject: [PATCH net-next v9 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-8-8e6d7710a2ae@birger-koblitz.de>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
In-Reply-To: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
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
index 92e1512f62852d7687ae27f97351f07fa13057fe..966e86a007fab2e73756af52eb66ae654c7e09e4 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -204,6 +204,20 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
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
@@ -213,6 +227,8 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_eeprom_len		= ax88179a_get_eeprom_len,
 	.get_eeprom		= ax88179_get_eeprom,
 	.set_eeprom		= ax88179_set_eeprom,
+	.get_eee		= ax88179a_get_eee,
+	.set_eee		= ax88179a_set_eee,
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
@@ -438,6 +454,10 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
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

