Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCC47253B;
	Mon, 14 Sep 2026 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390034; cv=none; b=iJX7SUMHktbBvwmAxqJxFOXoUbZfpsl8n1kt9X+QsxMpmwIB+24KO/Od4KHKlLsz4IEedoqaoce26b6kLY0AkEglfggi+0M2Mi+Pn/rRyoBBR4pLUMBA9+LLLMW10e7ZKKld9dv79CMtOeM6U2t4UseKL+Wpo0TAazJm8IuL2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390034; c=relaxed/simple;
	bh=oG/6DSnjIaHY2b7deki/byVVuyIUyfM2YU2doMsGH+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSPUueehedfQLY7V8ULQE4Ct0D4hPKwPiv32+WgNcfgtwQZILmYFgJ6Gb028dcYktzLcTa7S2gSP5CBP+NKaaIl+r20pCq5y80rzEce8Zbo2+Htke16FqGctxyXEmYmxqGys91N+5FYRIFKXxMnlgUdXapnBVuze7APWMzGsaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=u9avie8l; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2V5vqBNK; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="u9avie8l";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2V5vqBNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390030;
	bh=oG/6DSnjIaHY2b7deki/byVVuyIUyfM2YU2doMsGH+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u9avie8lgidbowuIfQEkS5rK4ul1rbD4pWmXMhWQ2qrlriLMhMfCOrwxefCEHWwZC
	 4AkhJTSohDMBKz5exLraMbMe3cR9zPFLUDmJIrXQpVBb8NVqg8Vjnlnvhbxw/0FcJS
	 8DeIm2CK616yKZoeEPRVRJ9mSjEjbg6mBf7WTborWM424cQGYYGiN4BhCD8ECdmcWy
	 Shzwev7eC43boPQbyxYbDAPLaFtE3pZ94Bu2GqX07D/ihaCXlwigGU0xTj5jKeKPcq
	 qX9b7ZMirIPB7qU5Ge9qd6HaaVkNsQ1qWik8pLnVd5S8j+zK8ZvOiinsQdI24gmJN3
	 HlC1Z93vKRmIg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 870C83F6E1; Mon, 14 Sep 2026 12:47:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390029;
	bh=oG/6DSnjIaHY2b7deki/byVVuyIUyfM2YU2doMsGH+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=2V5vqBNKUMAxup8uE8AtMsa8/QoCnTOXetuhwyIBhC8tUNpYqIqQmMXEZtte9nlsf
	 UKqGVU+vb9ycCQc6aMuQmzkuqgfWpPwK9Ye2HnkySJRrC8/PYsCdMn2V8VYHNKeFQp
	 q3b4gjvqG3CZYNbe//em6eQvtIutcuaWV2DLOqIa1JhgpWVC0AqpaO5sKBBJmjQAAt
	 kDjkObsO67g3xAHTFKUxcgmALYiyDKBnv3p/ZyB5UlzLI4ih5X0jANsp3RVN3kJoT7
	 n4H4O5K4laMLh+EV+mnQ7E1noeU0UKEoH2382Q0qm30B5XEpR3qtP56MN+gfHm/BIT
	 hYprLISSHoVwA==
Received: from DELLLaptop.net (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8083A3F6E8;
	Mon, 14 Sep 2026 12:47:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 14 Sep 2026 14:46:17 +0200
Subject: [PATCH net-next v11 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ax88179a-v11-8-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
In-Reply-To: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
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
index 80cabe3557cdef8267c365fccc0bc379936bb241..97aad545daee1dd1f5c4d63a1276523589c9617f 100644
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

