Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E14933C1B7;
	Tue,  6 Oct 2026 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255934; cv=none; b=cdxhJCdk9WBTvf+lcqaLieDfRKmRQFC1nlTSOaQ03RCAFCDJHEnlbeCUhG/Cphqv6IZpQmNR+vbwGefGcpKgymvaMJlxJNt66DAVJc3TcajGvUVV0hL2b/pDdQMUxRxm4yrLa6DQU4frRUC2+PTi6aAqkOS1MG5cE3fVhsfJlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255934; c=relaxed/simple;
	bh=XZFXciYPl71l/SJLZUs0cR1iMcRhDzqxt1PYUf553m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cExlOvHBWo5spuFtrsGvH1jm9yna5tzH4DgPR6AkXN61LshzztM207I0i2Ol0qrDqPqTa5+XibpagYmPegA0GnA+MDfniCWDrG/ZbCPYxn2JGekHNASwEeZupkgk4V1T7XYdwZAEWlMNRsA9ZAgMKram70hevLSqoKMJHRHEaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cP8oeTEW; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Kk07tbja; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cP8oeTEW";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Kk07tbja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255927;
	bh=XZFXciYPl71l/SJLZUs0cR1iMcRhDzqxt1PYUf553m4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cP8oeTEWqQ1VCCy3mhaKofoPNxn4cx9oHyJBcfjl4n/WS6D/AsqoGKfhrgYjNq0Pb
	 /u8/TdrDY1xzgt+J4Wdbq3EWsQf2WXRatFpkYKRyd1iaNl/NCIEh/Xk6UTZ/QRHFxH
	 a/gBEXAbj0g0NQUWdUPfbm6cspBQv2V4oMLzMQEbS/gEWh1xnWhCItSKyXKqTIX7IK
	 erddo260z51j5XmxVfTiI62hy50nz7WfaPQWTmjpasJFV2CEv7Uo5V+upLI7vL1Mui
	 fddstoPa9qHQh58H/NJZB14EspByjwQWP+Fsu/V9SfMlSZGFS8fIRrEbMKzDJ1RagC
	 0NQXtgKnt/AcA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 4877D485C0; Tue,  6 Oct 2026 03:05:27 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255914;
	bh=XZFXciYPl71l/SJLZUs0cR1iMcRhDzqxt1PYUf553m4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kk07tbjawNzn/6NEZQIwBbsaizCCgjMTdY3Mslt4ZhsQVSIAatqAdI2+uFccNLkBs
	 Y86PLuIkZ0Vz1CHVQK6563GI28bWByhLiObYKIkQdvM7aw92mztvDfhV7VgSerw20m
	 y0njwt9/8x0MkQ7Cm+I16XGcCnIFfR8zhS0BVW+hHIZ+fHayNJ92e6fq12XDCDLKLv
	 eb/CKkEz1VlB0Ak5uUcFizH5oX4qiIPzAaW2Ib2T/oh9uwN9C8SIDZX1SNyXy+XakG
	 4lSffggQXF+XiTzYe8XgyGspHINLljvD/8IapDzJbdqcUluS4Qtk+SO5nEKx5oVrZJ
	 E/ECtoqOzQ8lg==
Received: from AMDDesktop.lan (p4fd5971b.dip0.t-ipconnect.de [79.213.151.27])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4C902485A6;
	Tue,  6 Oct 2026 03:05:14 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 06 Oct 2026 05:05:12 +0200
Subject: [PATCH net-next v17 06/13] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ax88179a-v17-6-252814fe35ea@birger-koblitz.de>
References: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
In-Reply-To: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
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
index f076bc41b53d670582935a099ce5819be22259ba..156b03473588be8d9afcb483ca3ec3c5f3bfcd8e 100644
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

