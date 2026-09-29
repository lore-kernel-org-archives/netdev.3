Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA343C056;
	Tue, 29 Sep 2026 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651958; cv=none; b=rwis+qdkIsdeYXlBXCZS+I+2/FzWwAqKqo0bQFjeUIYLMLVpxM7Ic+BF/dN0m50p+IYxdvQpcM6+fRa77QLjyKNz2S8dSvIIk/ziw2QdOS18XGUu4erkFbF4Ym5zeK4IaPWMkvzo9kcxOpjuJGVAh0dN/nk1R2MkLxhHCvziibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651958; c=relaxed/simple;
	bh=eFFpSJGTY9H51+Ppr2ck9NUn017OEic632u7lr+XJFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vnw8pWxeIRAOSE6BBAWpyEhAF13EcxnNxfjyEmkSgWkDkNQfj5DZEFXQYQ4JwNEcbh6sKa8QN0S8mszOypeaJkWrv1bdRixu8iaWLnM0Ny7CcxFuNDoYhuctLtNr9HH3IwxILNbvK9YAth0Za8xCy40deVzrk528fXfeSaOsAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=in7S4NcX; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WyvbW2mr; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="in7S4NcX";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WyvbW2mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651942;
	bh=eFFpSJGTY9H51+Ppr2ck9NUn017OEic632u7lr+XJFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=in7S4NcXBLwGV5p8oRmrM10z69InSjoIUpBGR5fv/VOyV1PErN53DmVm202ou1yRo
	 E6zIWmnEWEN3bxdz0+wxr1qAHEe2vQwvcHgSYJhCb0ex/svH6+z/c0t7HxfG+OTKuQ
	 33zmuDGAf0vZ1gUeWspm4TBruR4ESv2uTR2ULxTTXdrwR8HBUkU2ToehDhPmyxJHlW
	 wAMbP0/N0oRWqLDo8FE9dioqt3rbGFVAWsnzYoUdDEo5qkYDJzo1oNVFYX8LhV9/vH
	 7mYu7ccDA1j86GLTPreGri6nrYympCy51A3KvinS0XWyUBUW7tB5KL6tYDKHHBiF8A
	 zyiPYFdIqHbSQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 95F0B4228D; Tue, 29 Sep 2026 03:19:02 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651938;
	bh=eFFpSJGTY9H51+Ppr2ck9NUn017OEic632u7lr+XJFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WyvbW2mrNFF4ph9PXQnGEQ/2+bgGxHZ3vVPILPYdDjMWruJeCn4qUP1OCQIkmeERC
	 veee9AvQBfEFw/8d3wnV/EFiNUX/GUklqlBjWdDzVaP/LlCjUIdkZuGEkIslTQhkO5
	 3mdFTjUWvwxd4rG7QtKhPR+jeoMQUXiJL9xVhk5zOJ+nHtM0gcknZa97dtcGPhIg82
	 Dn53u7Au3HwxHAWadBAu/xkgzWXRfzvO6j+U/7aAA/Kggjc+9JqDiQVF62dZ4Oc3AN
	 Zz9GZA7gfzQiEMAIK8UNMOmmyRInXc7QUvGlNSoGrx1UJeHbQDIwejx6QQtUCh2WGw
	 kAOXLST7YhoTA==
Received: from AMDDesktop.lan (p5dd1eaf2.dip0.t-ipconnect.de [93.209.234.242])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 12D6142255;
	Tue, 29 Sep 2026 03:18:58 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 29 Sep 2026 05:18:49 +0200
Subject: [PATCH net-next v14 01/14] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-ax88179a-v14-1-a1f2249e42ea@birger-koblitz.de>
References: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
In-Reply-To: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
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
 drivers/net/phy/phylink.c | 20 ++++++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3ec3bb43910953f3d57a4601633d0c3be65e959d..2621d568dfa24c29d69def019e11427d5f355b01 100644
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

