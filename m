Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4E3CF942;
	Sun, 27 Sep 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502227; cv=none; b=cY7zvM7D6ccSsypAdoa8zJTqOjZigHLmMfgCeBAHYgeiXr9nqH3H52szl0kZR92rqjCn40yF4sekolCdhlhUuibuxjaiPqRMsqCPvis96ymk60rwO9DrcG5CqupcUYQ6vQ4dxChqZZWMPlnFxTlCbYQ/EI8N6mNIIHdx+XNFr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502227; c=relaxed/simple;
	bh=anHWsZmc/HioyP1vEPDMn744EpmT5YgretWwLYFhp2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dynV5IADZag+9AlcsH8KXtsXHBvJBxy5Y5NzJuSLg15APeU7s3OxBudnSrg64aSyePN2MWKmiDUfGYimMbcEJzhUByW88uY24E3/V7RlEDASGYDZL2zGalpxCxQhv0UNuoGbaee2Lp6hKkLxcpPXzgAIgR/OZ6c/sEjQctSh9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=bDiHRTvp; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=C+7QiXs7; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="bDiHRTvp";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="C+7QiXs7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502224;
	bh=anHWsZmc/HioyP1vEPDMn744EpmT5YgretWwLYFhp2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bDiHRTvpHIXSHJ6bQlhzpkqzwxGQxGKdoN6qnP+EJVl/aA4kXo9ny6dPVLOwLnBbh
	 93k9+5j/OXrQBXzLUNk7epx3FQwwj2MdGlcvGOkG6BZHOsKBK3CqIxXJ0n9WOGTl1n
	 XU1zjwz7RNtv+zbyXRjnlOsUuSwOC6GdefdUDc0Kr6qy56v1BhNRKsAndZRNYo61+8
	 IFhmOqc98uaa0QTkrHdbpHgoylrfXiewe7XLu1pboXKB2lYc2iC2ALkyon1RXwcBLq
	 gjshG5t7FO49JNaUNWBluXnzk5m59yvkolVnSS1AEPsFmWznkSPbLVT/WjLEyGIcEj
	 XZTVscMDOUcyA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 98F51421A4; Sun, 27 Sep 2026 09:43:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502220;
	bh=anHWsZmc/HioyP1vEPDMn744EpmT5YgretWwLYFhp2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C+7QiXs7P0wpxxgPpIYwQ+fLrcBs+FBc0661QfD+43sFyfwcaJz7cW3jVpVSIjFj4
	 im/xs8hFTy6nicipLSSZMS9EWurWLJwZ/vPkZzn/0fkGEF4bkR0BDDjxRxL6coOlMg
	 U/eDbzQ0ZhdHyXFDq6AIwfLGSS5vxjH7oqyd980d8iGEyaYkXA8Egpc1NGHKC7vBgW
	 6Qn2qh7a5xHyi9AUMVeBnTr9ijxzL3rU1WdOW2b7IhuXsqGH+WWLpWIihAE7mIEJ0H
	 ISc7T9UZgbEvAa6SchFT7WHAK9yJz2ul+6Qm599tMW2G1Yw/lZqbkZiPh+R0NIK970
	 KnPV+CEkaOYlw==
Received: from AMDDesktop.lan (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 35D8D412E1;
	Sun, 27 Sep 2026 09:43:40 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:43:39 +0200
Subject: [PATCH net-next v13 01/14] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-ax88179a-v13-1-4fac6b3e032e@birger-koblitz.de>
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

Add the phylink_mac_interrupt() function to phylink, which
passes a link-change interrupt received by the MAC to phylib.
This function can be used by drivers which want to avoid
polling the PHY and instead rely on an interrupt received by
the MAC when a link-change happens.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
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

