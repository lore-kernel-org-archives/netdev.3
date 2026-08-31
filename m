Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6DE3E16A8;
	Mon, 31 Aug 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170352; cv=none; b=kDq7Cn89WjeakyIpVH5GxRTovMT9JwDQM3ZIDUVXTpNhooIsHCjbrC/LTmyg7rlCOSTYtvyVxNpNeU/d5Fc1A6h4Od2EGLDxmzq9y6gGdC2oSryys3GfBnt7F0KzELmM+nCJgD2+1NNgf/GPzk7XvSmLHaacJ5OjteEep6anNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170352; c=relaxed/simple;
	bh=crUBBjC5YHq9WZfackqIILM6Z5h9qVyPmxGeUb/Uboc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdegkFqWiML1phcnsQ8yW5JJYyrsqpiJ+XzgUz9ZBcPLzFV5uy97rDPQQtaQtFIzzwhfYS1qZh2ZMQOub7zu6c4RS5EOFneUEKMhGQyD+/3N2Ok/v9eS0jpRdzFYjLTmaANn9mK0pHaIpwbWt/xYw10Wmbed4njHFw3MKeG7QJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ajIBLURU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VDBF1thZ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ajIBLURU";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="VDBF1thZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170349;
	bh=crUBBjC5YHq9WZfackqIILM6Z5h9qVyPmxGeUb/Uboc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ajIBLURUc8luNJEJrTFMxeY+NQqPhM012ifQzpW1T++2xCwlevqDTNORLw5AAOhZB
	 R73kAIUXtJYYoMwGImLf+10s46WzZlTijon65N6PBpms5GVY3UnIRcfVHCnud2EZDo
	 Eu0SUTZYK57cNNJtkEF0owLQtMGStH1k3dGORjAJEB8bgYId7OEW665oU4WVMK53C2
	 MlZMJmnA5kVL2CwvQbnlj3QZEhhjnlxDHIcViqKZvBp59QBlcZqZ+Ttn0xXAPTtZAg
	 yy7N/+31f2o9twbLMUlZwNRJgrzOHGozKjaVpCXEgSEqt+bgprgk1sgoQa438UxXhf
	 AXRcdHbUxTC4A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8B3033EC71; Mon, 31 Aug 2026 09:59:09 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170339;
	bh=crUBBjC5YHq9WZfackqIILM6Z5h9qVyPmxGeUb/Uboc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VDBF1thZ5ffGCx7DzwWMV1nkR3hAd3gju0i31EkU4BOsIQEYdh/SvwUdbYSxHaCEN
	 Sx/wqvWaE+75FbZVmMTmGgy0VkGbLpej3JZq/1ZkPhTFXoyYQGdK251eEm8Vngpaye
	 anqvQ558j8pycoMoWg3Xc4oZA+oNpV33SK8A7GEglUyRKMwVCCBfue2iQgJt6rJ+/5
	 CaXHOlKaTpy57MhoKh4WJoNjS1LpvTWBXH6PkK7horBas2ah9SwQP2UBRxDND9WsQz
	 ibRYYZiJTMcR8f9+tjMnbbKOVsXGILSUHndTSJlceKk4CY8Ml4kAu3oBVGYB4lrI+E
	 p/VXT6eAJW9cg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 93A423EC4F;
	Mon, 31 Aug 2026 09:58:59 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:58:57 +0200
Subject: [PATCH net-next v8 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-8-de905f2ee426@birger-koblitz.de>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
In-Reply-To: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
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
index cf2dc989f230ee47f4bf0b4f42ab02a511abc19d..e1c4e5a1e5dc584a471090876bcb7479cd392708 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -216,6 +216,20 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
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
@@ -225,6 +239,8 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_eeprom_len		= ax88179a_get_eeprom_len,
 	.get_eeprom		= ax88179_get_eeprom,
 	.set_eeprom		= ax88179_set_eeprom,
+	.get_eee		= ax88179a_get_eee,
+	.set_eee		= ax88179a_set_eee,
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
@@ -450,6 +466,10 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
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

