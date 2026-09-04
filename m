Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58042511E9C;
	Fri,  4 Sep 2026 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542927; cv=none; b=mbcuUj99mV7j+Ry/ljYcteXqIKQYr4wQpQ+kvXeSKJT+zr3kcvInNY2vG4nRpI8keD7MUHijfwEgUSjXS2cSUIFpHWfw+K3loazU7PvmrsGeuvOaeC/s/8rtrMpuaV8ut4MWgsA1PzGKoLLmN6a7b1TiTDSiya6dzT/fik5Cv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542927; c=relaxed/simple;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9saSDPPLlMPBKnrgG6TgD5ndqm/bRTzrlR9XpPBE2Z7VZAsQbcwq5YK8ojsZ3Q+Aqukx8wOQqN5mXp0NKemH8N9BXqjJVxShC3MVQxpuFsK7HWCV8WsMA6QIq2LboUYZxM7AttxIdm7ePUxU3iRSc+ezKqetonalRcLqfRhtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qQEVaG8V; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0dmjUI4a; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qQEVaG8V";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0dmjUI4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542915;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qQEVaG8VqNuDxjyE8J+OBe0jmNx84alKdlg2aOGEDKQ/gg2KthWQA+1xajZQlZ5Oo
	 xS/DkBLjjT0+/yK3f9hx5fPWXKGtUcVuNE7XC28lpPgA/4ubFnRRpsVggNh9e/CVLT
	 uLyh4lYSul3STPir5Pid96MHsRxzePWN7HM86bYGW0NHd8E4RXs6EWUpNO4Q4+uLl2
	 LZhXa49TxBWEdeac6ueSRHSDmKexHaV3GSYMioTmJKoH+MN16HVOQP2fv8lImT3oi0
	 b9oaQCN31gCfavBSr73QUlIHsVi/J8RnxPpT/whCyl9VDAIyOVcih34B+YZfSrxZ6m
	 gmNqY3pWqWHhw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 03CE53F0F4; Fri,  4 Sep 2026 17:28:35 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542913;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0dmjUI4aoDtjxDNEhVB+az2Kue5pzmWgNAYlhAP9VHQGin/q7S8PSy/zdl3dTL+Yl
	 1Io2J/+FwdBwbriaRN2ABuUFF9K+O3p1HsozWeB9vBShs4BQW4Z6BONVIOChQPsBjX
	 wfxhwi6RiAF14/g208lpo5Tmky2MOH5CosvY41SVFXqxCpPgDrLDqLFy/zSYP6Q7D9
	 Rv8vzjkeoN+vvwlvgNut6QjssQcv7cD1SGDgnpOptKoOsVyiYxe58Hjdyli1Av70/r
	 3AOoWNY4ecjG4AIOQ/Vyi6XTjVE1xLiRIP4twXJyDlkt+DC+93+5aQLpRwYxzu2+hj
	 +/UKw1G49GAPQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1776A3F0D5;
	Fri,  4 Sep 2026 17:28:33 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:26 +0200
Subject: [PATCH net-next v10 01/15] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-1-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add the phylink_mac_interrupt() function to phylink, which
passes a link-change interrupt received by the MAC to phylib.
This function can be used by drivers which want to avoid
polling the PHY and instead rely on an interrupt received by
the MAC when a link-change happens.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phylink.c | 16 ++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3ec3bb43910953f3d57a4601633d0c3be65e959d..96ed13458e9f399fa911a145613d213b1c4433c8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1612,6 +1612,22 @@ static bool phylink_link_is_up(struct phylink *pl)
 	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
 }
 
+/**
+ * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Passes a link-change interrupt received by the MAC to phylib.
+ */
+void phylink_mac_interrupt(struct phylink *pl)
+{
+	struct phy_device *phy;
+
+	phy = pl->phydev;
+	if (phy)
+		phy_mac_interrupt(phy);
+}
+EXPORT_SYMBOL_GPL(phylink_mac_interrupt);
+
 static void phylink_resolve(struct work_struct *w)
 {
 	struct phylink *pl = container_of(w, struct phylink, resolve);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 1dda5c7ed5f146930d1acc6f06072e6755167af6..f6c1db837fb5062c6d42ffc6489ec06ae84e535b 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -768,6 +768,7 @@ int phylink_ethtool_set_eee(struct phylink *link, struct ethtool_keee *eee);
 int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
 int phylink_speed_down(struct phylink *pl, bool sync);
 int phylink_speed_up(struct phylink *pl);
+void phylink_mac_interrupt(struct phylink *pl);
 
 #define phylink_zero(bm) \
 	bitmap_zero(bm, __ETHTOOL_LINK_MODE_MASK_NBITS)

-- 
2.47.3

