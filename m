Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7103033CB;
	Tue,  6 Oct 2026 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255918; cv=none; b=EYVfWNM4GJ7AJlKmoclZcSmj+rxEdogTJacA20I3Nn9C/2UJHJnGkBxzqs9oqjCb3iwJmeAOS6oj6tZ1oyCmN69s5H4rU5oqruUyZdpyPXzCgm3zQDg0QsVTNXYNe8Uifz/dJfwGePfbVuvtPe9IAamSDVeADZ0Ko0rPpukgFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255918; c=relaxed/simple;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ls02K1az+QAx1KJsGEWRTjVzr3sWVktAKGtiJrtanqwm2YRwx7OvdWrOfDiy1lqEK4HSUlZxj5UheXtwTzfSjJvuM5QnjHhkKyO0r/N6v2yj5rLFgWj5mKlVm4AAbF02FpvXaHcE8kP7TQH6mpIU/HGjbxzsjyMxLeoOSKa3vms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EATcpvKz; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zOmVZZxi; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EATcpvKz";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zOmVZZxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255915;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EATcpvKzkEu38fHIj58PuzV/YcN1ee0sQ5Gzfb5q8kRWb81Q9FHR0lUlelvMBKhiC
	 GYLvIsObzNHehDf1O/igpteU7L8spX9af8Aw1ox0SjGz3v0S2G3AFRHC49Ll43igvz
	 v8kjo1p83GQqeEulLC5X//Zg35FBaaIs4pH5iiLdeffzzmn5OyWundu6uEj6E3ERlV
	 BEptIz9Brn+B+4emszpvWVnFC8yb5MIrUHhn0l5zC9HP6pBIfMaddF4XpzkRtApA6K
	 4JI3ft3o3rgFFLQo11Yox6qbFch6ozDrsNrhgkICKlKKjzf9A1yO9Nd4oUMxYP6pGq
	 xn8i0RHMqVDkQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C1858485E8; Tue,  6 Oct 2026 03:05:15 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255913;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zOmVZZxijsgfAGtuOg4BmOfmISpKtaksrt0w3JFU9g13Lyw69A0VA607GJjc6/9fh
	 mIQncJHOpcr0HxUCAFMxqozbtwOADjTUcc7JVHkCXk0tzJwLjOOqmuguXlgo8RpgYm
	 mmxSlqo+X7HIPGmLhP9LqzC0++SHmjVR7MChnCQX+zMaoVzBZbd+Br6e2ldvI1ELkV
	 XDKdhE6ygx/y57rPL4BiFng66vtYrO1Ck96pjL1WzCtGAlsOHUboB8H3BwML4z3F5A
	 Slt44cplffTewuMF5Gxc+zmJWDzNnusbCZ3MxK/o7mwPC8qV0aqCN2/Fjl2Z22EDXN
	 61u1XH6ZR0FiA==
Received: from AMDDesktop.lan (p4fd5971b.dip0.t-ipconnect.de [79.213.151.27])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 01AB34829C;
	Tue,  6 Oct 2026 03:05:12 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 06 Oct 2026 05:05:07 +0200
Subject: [PATCH net-next v17 01/13] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ax88179a-v17-1-252814fe35ea@birger-koblitz.de>
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

