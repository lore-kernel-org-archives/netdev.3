Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E68373C1A;
	Thu,  8 Oct 2026 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431480; cv=none; b=GjakgoaaSzfDVGrrKP9bMJ50CbOaY0U3eTTUFHkqMXCUJI6Cn/tNfhWJzPNRzo90i4W5kQ1t0AxUhMASMOoejncnuwwxvkxD2D1DpkNGBqXL84Oz5w5/X94uejUEZJ8A6wPmBelKNY3cPmmgaOdSFjsAdCa/vNMdaQyH4Xh4y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431480; c=relaxed/simple;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YhGCuTDWHklefR0Dv5dsM6VBa9gqzRoy9S0iRwl10ogDxKvmn1EVvQBw2Xi/eDkTjMjlJNT68v99ocasdwWyg0c6YgzBYOuwhef/r8F1O/QruSb8wYrtQ+jX4GU3zeJlxIEVaDF6HzBHkiMbDq/a3T3XyvDP5DlR2SzSn/TeylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=C4uzuSe2; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=g0EC19tM; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="C4uzuSe2";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="g0EC19tM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431477;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C4uzuSe2NPy3TxDGkjbgzITsYW5DFB35tpS5oS3kDM0VWXlUxBhN3DT1TLA76YqNJ
	 S8wNuz/lJfbhBr9S9sNb+3XiSnsB2t1DfcW+04qay3/cWLngtJQdfWiEYev70OvcyS
	 Dg0cOZi9DyCelzMWkOeDPSZ5ENXsjJu811k5GKpBu3xKS4H7A5aQlNPX0cuP+X9K29
	 WSWqJwXUQLZOR203eKH/a2R5XUXd5kuV98NMwsoeUG5jqXgTC6hzpNSkiSF4KQCj0R
	 +66c/ybrfDgLt4rA70rzU0csLoRRNKfOqvobq2l9mzJqoepWmjl80/KOos1c8C5VBV
	 T3rAKateWQ+2Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E28DD4727E; Thu,  8 Oct 2026 03:51:17 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431474;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g0EC19tMT/Vhg55OuieNy3IIdWvoBiU8je4+tJtDX6Y/jRsWLmsHy5QFVR/jRDaUv
	 /WgEcjP5cvSsXF2QeY/3GA/3pedyykPDjmX1NBqHlT1Un1Sz4gP33Lo1Ic6Nand7jQ
	 bo8zq6AeI7bDitXTb6w8nvLNc9a0iA9F037UWffV8TrVFwukQ0y+YJRGu4zE/+mGHx
	 WkXU8SI+iHmFpknUdmVWsVGjZCAUXKnslPp2gmlV88IYImwu0w+HIMnOuAS+RJQu+Z
	 FoXGsOYtuFcmhLL4t2mrBqERCFFkxCgmGae74/bThXCjFqmmLIq5sa/HU6yaI3Wf5x
	 5p+lvR5wgy1Kg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 72C7E470BF;
	Thu,  8 Oct 2026 03:51:14 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 08 Oct 2026 05:51:07 +0200
Subject: [PATCH net-next v18 01/13] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ax88179a-v18-1-6fa1d4c40422@birger-koblitz.de>
References: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
In-Reply-To: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
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

Add the phylink_mac_interrupt() function to phylink, which
passes a link-change interrupt received by the MAC to phylib.
This function can be used by drivers which want to avoid
polling the PHY and instead rely on an interrupt received by
the MAC when a link-change happens.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phylink.c | 20 ++++++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a7d086cdc9b2516571bbcfbc3bf3fb37fc4bf6f4..a3ca7993eb7e0090941843194ca1b924cf8d9e89 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1612,6 +1612,26 @@ static bool phylink_link_is_up(struct phylink *pl)
 	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
 }
 
+/**
+ * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Passes a link-change interrupt received by the MAC to phylib.
+ * This function may be called in interrupt context, and therefore cannot take
+ * a mutex. However, it is safe to assume that the reference to phy does not
+ * disappear during the call, as only an SFP module may be unplugged to make a
+ * PHY disappear. SFP modules however do not support interrupts.
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
index 3a88a69882a610afb868b55df6f6e77aea918649..a7b6294cc4a075bd2aaa43ed6484de17a6cb88b1 100644
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

