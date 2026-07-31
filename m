Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCD3112AB;
	Fri, 31 Jul 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514768; cv=none; b=ZkbwiPTZ3UZZtFpAy8XSMuR7iXRLHWJ2rkeNwIRc0aFVT7LFdAC1FI80cSblOOmeEW3F4XiU2/BD5r/eSv5W+D+5KVDdUK26J2Kv1UgG4RSA1tzyu0EsJlGrs3gTPF6NgAR7Y97H0ihAf3AAEBeSgMfJmSpWMjxP4nS0EgUAy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514768; c=relaxed/simple;
	bh=ndTiNW9XrGr6lB+9LHnxZ4kDmTjXp9gtEQWIKuwPSFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fdck5LC+unhdPAqSuC/2FCaDnhjYGOP9miRmgscdta85AIn3n0Fo88JKQ9CK5gZ5KQAwqonLdh3L0d+hakkMV/DUbjxy339VTsw5EWlzmGvzg2DeNlBt8i/IVGeGdn7CHW/ZiCnGRVwtffkTtS9i8Vr6hhae56yxYloID73aikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=SWjf6RWA; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fg/rKcaz; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="SWjf6RWA";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fg/rKcaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514754;
	bh=ndTiNW9XrGr6lB+9LHnxZ4kDmTjXp9gtEQWIKuwPSFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SWjf6RWA1uTKcBhahR24YQrNGea/3JMxvEQBK5bzrJnSfcLpBsO1Y00Wpf1mR8GzH
	 W0hrSkYV+PW9mm6O2OA6JwEgqqUewDRLCRSgXaDlsTGeA/WcwSFV/uirdzZwy3Za9R
	 PJXpOtkq1bCbJDeEItlz5Ju4JKYefSO57WWEYBZH60LaEBNGxoB4NNOlEOXQGet9Of
	 nC8uol6r0uPmP+eaLMS7CmiO/7hQckvyuE8PYzHbnJMjTm+wrqpWLjzl+iiwnbasl8
	 /apa+UGqrlz4a1n2gBiQvBNurj0ZXWtVvEFUJktUhE5CBZbUlbRc9Q1Ih4KS+ay3es
	 wjA8bv9G2vnJQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 746AF494F9; Fri, 31 Jul 2026 16:19:14 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514744;
	bh=ndTiNW9XrGr6lB+9LHnxZ4kDmTjXp9gtEQWIKuwPSFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fg/rKcazd9bHC7UpNHQE0vdXqh/aY4n1AVKjGP3MtfH18oOr8sJMBI86W5Wv1etyk
	 2919neCnacFs9X9Lgm7b5VBrkRpyK/K8ak6zJtj9cpfLwN2KML0BEa+Ug0OzQ4QEVE
	 yLTgWqTiwsBR4EV5UgWtqe7LLd6V08GCb5QTjkiqmNVTVaYZ0tPDzT6tJx5oPVYbe5
	 95dqzAbIDBNpUyvxldlgTEK0Xlloq9SB8NBVIklwqvKRHH9I1BZhSKKJjpvu7Y/rqZ
	 iZmCtJFTs+7/5L9vjs5ucTXhFQwY7sB5KP52G83mj8Xj/q6e57GC957PNrYZq9xI7L
	 Ix0ZgVNZ2o2Ow==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 33EFA494F3;
	Fri, 31 Jul 2026 16:19:04 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:05 +0200
Subject: [PATCH net-next v4 05/12] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-5-2cf1f71b1dd2@birger-koblitz.de>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
In-Reply-To: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
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
---
 drivers/net/usb/ax88179a_devices.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 835d1c369b533929e92175f8223c728ffcc8d168..2bd6e181dfbe319e569fa3d6325fd45ea0b9c732 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -222,6 +222,26 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
 		return AX88179A_EEPROM_LEN;
 }
 
+static int ax88179a_get_eee(struct net_device *net, struct ethtool_keee *edata)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *ax179_data;
+
+	ax179_data = dev->driver_priv;
+
+	return phylink_ethtool_get_eee(ax179_data->phylink, edata);
+}
+
+static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *ax179_data;
+
+	ax179_data = dev->driver_priv;
+
+	return phylink_ethtool_set_eee(ax179_data->phylink, edata);
+}
+
 static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
@@ -231,6 +251,8 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
 	.get_eeprom_len		= ax88179a_get_eeprom_len,
 	.get_eeprom		= ax88179_get_eeprom,
 	.set_eeprom		= ax88179_set_eeprom,
+	.get_eee		= ax88179a_get_eee,
+	.set_eee		= ax88179a_set_eee,
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
@@ -440,10 +462,19 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
 	else
 		data->phylink_config.mac_capabilities |= MAC_1000 | MAC_2500FD;
 
+	if (!data->is_ax88772d) {
+		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
+		data->phylink_config.eee_enabled_default = true;
+		netdev_info(dev->net, "Default: EEE\n");
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

