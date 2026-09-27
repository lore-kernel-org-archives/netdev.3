Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A03CFF51;
	Sun, 27 Sep 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502228; cv=none; b=X/yRIv/oqnz2r/gm9cae01HuwdXuaUHtDypDAxMGMepAuISZjbe1z42FEc2FMmI3x6Drj9+c0AEaYiwm4CbTZvLlYljUijRf4q1ar0rEniyekhM6VEFHpR2QD1oR63yWKXjWF+B0HWyJhgk1HlznEfAY/3DacAsbSKexDKoavX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502228; c=relaxed/simple;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N56Uirmk6LeaoJ3Hm+S1PvRVBXAwdmNeYxtwo9bmlAtTKWvdPsCvXz/LK6d+slkiXH/D+I9fhd7D+NmtA0XgwCGBL2jnS3d8e2llkyLjx0mYhn9BJbXlLlqdItZ9jltuQwkjIQNx3QBh7ey5z1q+46modNIm9U3wKAuKyrFn9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=SwLSZDPn; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EalK+tS/; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="SwLSZDPn";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EalK+tS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502225;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SwLSZDPnqi4342Mv8AkOxTWWM5R3Zthh1TXokR9pt748odNVEYqlv7AUBeIDMWevr
	 1HOPfNE+KCedKFUQpbL2ssY+QwDnnmdautcuhl+iYufztIt9oqH4oSNo2voTjxeBCa
	 F6Xb5SnfK1dLa2yy0mEUscSpb1YqWbCXrqzMyzZu0ZPZHrBmp2ie1Wxn47VKoaS/0J
	 +lui2rTCGkHRsmZUcR6bSAnvWYGaat3Ypse5AuIERT47DPtIRkBRoDhNrPJzK2+3oZ
	 FGP3qlZ87K3ACaeLseJFCZVG3adgBSOjo5W9o+FmNAs3MOV0MB5tHb7ocB9T8V604b
	 JbsMTJcqmbQBg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 58495412CD; Sun, 27 Sep 2026 09:43:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502220;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EalK+tS/h5c9mR8wNl9+swbLc1+5gL8dXZnAkUhCQMQuPNTP3lihqlGEL1A0ju45S
	 h8g7CvaHYfMabZC72upiJ0e+3/DuTkXdKuv9LrOIAoV4vjwnPyFPV8ISvSbUhMv3jK
	 A3vw5WHAigYX2qHgkVGGIleGUACTqgaK0bBJ1zi+H1vBrtKsgyRI04PsZR5yvECbV/
	 hIOsJMVa7xLQdGwZbRlgfh9tUTrVhe2u8OqgiCBXkuTG/XbAEQuQfR822vBPCblua3
	 oLppYdpFUDgFg2nxU1+tOyHVXxG2DLCQiN+yZLUZ/c6WetMGQuuBlcNcoJ8hQzFGnQ
	 F9P35kcdqlhVA==
Received: from AMDDesktop.lan (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 76D2E412E5;
	Sun, 27 Sep 2026 09:43:40 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:43:40 +0200
Subject: [PATCH net-next v13 02/14] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-ax88179a-v13-2-4fac6b3e032e@birger-koblitz.de>
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

Add support for PHYs which only supported auto-negotiated
speed modes. This prevents a kernel warning and stack-trace within the
phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
because they do not support forced modes.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy.c | 4 ++++
 include/linux/phy.h   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be3304b408c9f3ec9b5b95c76d3680a88..b83f938fe7c3bd619ae453434fd9582c0a055a57 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1190,6 +1190,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	      duplex != DUPLEX_FULL)))
 		return -EINVAL;
 
+	if (autoneg == AUTONEG_DISABLE &&
+	    (phydev->drv->flags & PHY_BROKEN_FORCED))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&phydev->lock);
 	phydev->autoneg = autoneg;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868e0ff558c163421cfea5a6f3bd73a53e..d5f8e527ce8dfefd40a8b34e7c2f9adbcd6c87c1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -64,6 +64,7 @@ extern const int phy_basic_ports_array[3];
 #define PHY_RST_AFTER_CLK_EN	0x00000002
 #define PHY_POLL_CABLE_TEST	0x00000004
 #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
+#define PHY_BROKEN_FORCED	0x00000010
 #define MDIO_DEVICE_IS_PHY	0x80000000
 
 /**

-- 
2.47.3

