Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7373DA7D7;
	Mon, 10 Aug 2026 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365246; cv=none; b=CN2UCIfO6TysyUj1gDPwq5clFwKd6ozE3yVQgpgizwVpBjgaFzrM7k7jD804oeieLsM8BuKKIhi+EkGFt3T5u9f63hEHRxLWrTfH9pLHQ5h0QGIYJJ8OAsVhpxgKlGN96LscfzU1QWqSfn/CHMcNnbr423B/y9+ytiYo2kvG1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365246; c=relaxed/simple;
	bh=crUBBjC5YHq9WZfackqIILM6Z5h9qVyPmxGeUb/Uboc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5MekTmPmhUpQsSpr8r1QOCmndgZPlkQVmib1Rs+x6zhbF08f77s1boO894PNEG8GiPuG3weiRaV/1pGn1A0WMQxfYwaYoCGXo8NPm2k5vL9KVvJY1/x3H710mazEkDa8P3cTtWRLQAiZuNdDYW+HgD/XufwLoYyzpPwvLxDr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QtwKDQia; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1fhOZaMy; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QtwKDQia";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1fhOZaMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365242;
	bh=crUBBjC5YHq9WZfackqIILM6Z5h9qVyPmxGeUb/Uboc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QtwKDQiaFhRGpZXdlSzW//fmwNROKIy48+9EPy5p4nVEVtccsYA2fBkPDiYE0461X
	 OwRO7Y/V6da272l8miur8vpWxUY5qVateMNHBY6HacCLlgNBwhTs/N1RwwIoF3exRs
	 ivxiAHgy+OvWJgae8ggHhebXpPeGFYce0xUGo2IT+oJNfH/ubpYLQpuJbp7gQFpEbM
	 gb2A0youa1eMeUkbeQVWf8xWqYKf4Gdr4q6lV8c0eKnTp9njIRKxDrr6bVcTG7SGNR
	 H8tuXfGY7UOOgMpX+jNog0mV6s2z81ouYQbC9RBjXvplJ1dPen7XGtEfGmm41/vh2b
	 QOg1WOtf0NEfg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 87F0749792; Mon, 10 Aug 2026 12:34:02 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365218;
	bh=crUBBjC5YHq9WZfackqIILM6Z5h9qVyPmxGeUb/Uboc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1fhOZaMy/4Q930keVskGGAY6yJ/o94daHxxXobbz8xM+WmTUGrRxoh5lpkdIQWqDJ
	 4OHpKsuiMgXLblii7+T84UARcy/Vv1OC6Klu+0wCHSGzE2nH/1Bw8W3wv5QbGFRTDh
	 o2ft8ALYEGef87+clWhQTBis3BRrybO8iwuNd9cjzFWoEZy1LgTqWg3Bux7E4JpI3e
	 HIBTSuDOYITwZVJTJvoCzTLjl1ennKYN9G8QfupPohOBq2H6XPDi1yHFZqRj5eQMhh
	 nqdBN3j48WeQnSveUCE9s9R1zCUuIF4gnmV0nogmHFhXCjAnwRVx5iBwWuQkvNvG/I
	 mRJaBIYD8e3WA==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0DF7349774;
	Mon, 10 Aug 2026 12:33:38 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 10 Aug 2026 14:33:32 +0200
Subject: [PATCH net-next v7 07/14] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ax88179a-v7-7-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
In-Reply-To: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
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

