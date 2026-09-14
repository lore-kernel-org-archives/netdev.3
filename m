Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5E469842;
	Mon, 14 Sep 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389999; cv=none; b=okVT+WqsWnMDZxPmm4PX8rXmj/Ve6WPg6sTIDteMLhbuZAQ6ivOqNCkcnHWE9FKeh2CP1TqAtj9oiziwkHFqcBVgmVhScheyYIAN5efSB6f8GO+KIsgHpWblbHeJlpOMIfS8uET9+R4I1dieswjkBjib8TGVSZ5U+OqbT7quSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389999; c=relaxed/simple;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gz90RAkQ/LWqPI0eSv1LZfd3RSus6qaCxzlbLlFwkn/a/UGRxeH5Vdyv8dhwLGXiyI0pNU6beb8+trPi6hwtGcpJ7J4deJTqvQdcuHdjRCF2JeggySwMVupybxPhc7tFmqyCTwQiJsfjBnnIaNaSu6N0SxUNIzDB0vIpkH8EUew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=u/0mnDKj; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kLSCHYQt; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="u/0mnDKj";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kLSCHYQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789389996;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u/0mnDKjm+36Y6bRPRQzbJuZhmOSi2t7bho7pOO4vX2NpFn3AIdT6vOSc1ce0u+J8
	 6BofLZ+PC6iESd/THWvlupQjTdBcHV5DmwAVPPJaZUOxP9IS5JddhJ0KvY0RQI9ezb
	 x0hI2ejKw+ZWiOCueWweC2eM63PLqcse31zOL6OiXbAAmWuWXUEmawpz8fH3lZu5mi
	 hMJJl51KArQ0Mf9v1zl/6pzKDz/3otKdu4O+v1sBo8t+g6+SBEyyPXSrKT7NFs3otb
	 rLOMsO4DyLDSAL4S5wooTnWZ59Dn+YkvLtN9L8Ds5rPSuOMvnhRieQ71m6Do9Vitv9
	 FTJ3dVKC2p+PQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2A3D03F6E4; Mon, 14 Sep 2026 12:46:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789389995;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kLSCHYQtj0pGwpH6Cv0d8hXd56a/WPk0xXR1qdLUb1QwuaLQLKzCdG9F43QzmzzEf
	 NxnztNh/GprhWheynH2bRFCd0MpCnMYVfWm3vuWLZfK+AEdpktfspgj2HdTpfyEdhv
	 dMVC7v26qfPPH4xWYfC5fGDquvIrTQffT3OUrktjVCp83c01BjCPmaBtPy7+XhCLiE
	 SHy8c5iaqZYMMO1295GP+Pg0Ind0nQjFXRcM7JxT3iJPX22VVWcUBNJ3WNe/4bHkJu
	 xnT52nbP6JYau8TcpRZyi1Y89e29ILxIm8i4xuQ99vDFbOUJXUiUHW1mND7gu7o8ja
	 Tb+7DO9WPwMuw==
Received: from DELLLaptop.net (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 75D333F6C2;
	Mon, 14 Sep 2026 12:46:30 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 14 Sep 2026 14:46:10 +0200
Subject: [PATCH net-next v11 01/15] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ax88179a-v11-1-5ea7a925ba6d@birger-koblitz.de>
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

