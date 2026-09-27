Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10793D47A6;
	Sun, 27 Sep 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502241; cv=none; b=QDCc+1CZlfLD5ciqGRDGyzDM8M37+kGxhUDZOTMzFoek5+LTG3ash/bgPV6lzUZIoDEcy4o3LlgfC7ws3T8G7ZN42sfwz6N0/sbyO2K9XS6Txoi4iCK90WDJarV1fR8prM3xqGCnCPWqE30pP7yisYHDQrY8DeMzej+95yOOIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502241; c=relaxed/simple;
	bh=jBZVvx+tFxcAcqhGb5gfAVEGyHbhwI7uGLasNYH0V/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUx3k4Dly3E6wU38MYmLX03D6u9o6naarxoGTNBycCsRLz3fjrHDYxQ8Aa9jqyiwMBIqwv84Om87p9fLK95Qesm2a6CelB677wPnim543ZV7uoDyi7PLectszoFbjPfFzQkKwD60ZEO+Yei48s8iSCbyrQw6qA0G0sGK5/7Z+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vlnRIyGo; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=z+JoBCnr; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vlnRIyGo";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="z+JoBCnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502238;
	bh=jBZVvx+tFxcAcqhGb5gfAVEGyHbhwI7uGLasNYH0V/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vlnRIyGoaCNPevzT/cSv0yAb0aJnfVv+wk0UqzXX8WGJ1cAvyNyiQ1G8lNSkjz1lN
	 MP4JudkajkGPvqaI0o+6R7LTIrW/jLWn42xJnQBpiAVtVF1Yz10+QDYQ5lPB9Q8okH
	 unwdsBzQkt6MPMxFG6QNUd1wHdtcXDmaL2hMSn46sLYZjHJomw3pezAFOVVI1OzYWM
	 fxkTIO3TjtZT8pmIzWiNnADrsxaCsHcCiO0xbwUo2aRLT0MlH9V+3Kakj3DTXfJuGB
	 kOiUsutNBiuiHUKoyNZtoU877CLmeFkOO6/TZLLOveL1igfH/SClxwfNGQJQZXXBcs
	 iQDhwClAZW4Fg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 634E8412E5; Sun, 27 Sep 2026 09:43:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502222;
	bh=jBZVvx+tFxcAcqhGb5gfAVEGyHbhwI7uGLasNYH0V/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=z+JoBCnr3NKkHnKkAlaCRhpchPpbaYev7kcyHuuGIH0qdN+TzGj3Y6CWIFuXV3w3X
	 EYyYu6BHdph2uz15grKGhMX80lVUBsxpMxuofc3NEa2ABb3z7ydyCxYVehghkoOPtD
	 gDFpkKS8GZMitKATU0eN/XVi+VA1H1JiTOkD/eS54qDnLnINQtsPa3TLjOe/O8WcDz
	 kVGxodwP5mPSYKCJ5iQDvmAJb/chBBKqEH98Rzf1kyoK7szo9D2n7chqJ9rX45TKyx
	 O9ebRTdxLmXXkIR7Rk1LkXJdZ5p6JgspvyjoTJXil3LM6OGAoOOBuW6ASjVYfA9iDx
	 B3SLJ8f/+rBsQ==
Received: from AMDDesktop.lan (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C524541309;
	Sun, 27 Sep 2026 09:43:41 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:43:45 +0200
Subject: [PATCH net-next v13 07/14] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-ax88179a-v13-7-4fac6b3e032e@birger-koblitz.de>
References: <20260927-ax88179a-v13-0-4fac6b3e032e@birger-koblitz.de>
In-Reply-To: <20260927-ax88179a-v13-0-4fac6b3e032e@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
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
index 96748ca49743dcaef71bbf649a543508be01b8e6..e2ea9724433929d4cbfba0597787ddcb84dacf98 100644
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

