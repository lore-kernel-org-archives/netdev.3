Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591503644C5;
	Sat, 10 Oct 2026 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608085; cv=none; b=nHDq8Zte2LeFvxiZK6iOTozUQjR2AGWo18R4dJFpVwVpYtMfJ00ZSZmSvSE1RtooWi0GLtziozFFb4JlOJDHh4h07gVmJTrJAEiUyebc32zDIEPFPQrQAFvDPv0FpQ12+cfuzkC2euPschCuFHE56a9mnWEKJXl4l8D5of+DvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608085; c=relaxed/simple;
	bh=cg39L093dm5ZgWsTfiATniGIm12jPVEs5/MdqNtJY2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7mXvb0cEc3ZsyCo0JL9wnnxGtHAt7J4tDvt6j+AG0v7xloo69PSotNH2pIBKBBiUaZgH+1vfMRIH9qYSJYinJB4u7qcsgVMuagcOH3bKA9Q3xcPAOucvY3Tyx0s4YLJLBmyhcXW+m5anNuQ/0XiqFFE1LioAa42qzjcrUyh4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=dL0N/hDs; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=GihmRuvz; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="dL0N/hDs";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="GihmRuvz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608082;
	bh=cg39L093dm5ZgWsTfiATniGIm12jPVEs5/MdqNtJY2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dL0N/hDsw7HarLA55SegoY6NJVSiZv+CWfRPGy0MlySc0nc7jUxI4N89BI5FmkCzD
	 hWDYvtElstUGcGF6U5RYXXyazyTBRhHMATBSLKStrPqavhbtvqBwgPCJL+tmWCojNg
	 Y3fAaeYttdhHjyqDw6YFC63TRbTOJ241vnELvpBBQYA/IflIz640q/AQc/7dJTpeKC
	 RsSUv2aSUzctdxFgpkf8c8iPA6qClwbO/YNoWrBy7IdctdS9zoZJr3z4j2FeoelrzZ
	 dVyFkWbxDkt/oIZiL3ht9f2/+U6yaTh0S4tQaRI2/wrQufBvQq3a2vTVRUdVSQjJyE
	 UG98aNAwup4cg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D5D0E475CD; Sat, 10 Oct 2026 04:54:42 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608071;
	bh=cg39L093dm5ZgWsTfiATniGIm12jPVEs5/MdqNtJY2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GihmRuvzZfmXQjZ0QI1WMRiGm68IqGQUzanSxShdp3ikCj4K9MGi9qLUB5ybOH6iH
	 2AZIBd/ddemLvFP5M2Rtu9KrB5FNQH2dGgt+DsBFmiu4y7mFTS+azyofm3xsdUOSXX
	 wIBXrJikLKNSfmC11myeN4fIpNWRa/9bUkbHcsCn62xaS3oF/uvFX7LdM7YH/2W8Wt
	 AdZQ0x46bF0HUPPC6XjGhb0lSUZCdVFoRYXOTA+wszIfpqhOsfg+9jFTuLr34hm5h3
	 SxpHIfk4XnihVyxTQC44s41PA32K2/7lGcwnwunDaORCZ25ItPjizDw8FRE/3suKxF
	 cs2DqQmJjBbOQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E687347541;
	Sat, 10 Oct 2026 04:54:30 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 10 Oct 2026 06:54:28 +0200
Subject: [PATCH net-next v19 06/13] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ax88179a-v19-6-7475173cfb56@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
In-Reply-To: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
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
index 62619fd68c408f453e48c94020bce2254da9a1f9..272e92365683247b42a5fd25013c728a9c1af711 100644
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

