Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949694;
	b=p770Phrw2g+yavZVSP+CvU8tW5VBvwOS7pvmCeW618bi4QaTZQXd34uaepUZ1Vn34k9o
	 HBL4EH71/Zm46AtSjxcaQA/hUjhx0BTrAvfwI6hQipqgVxPpgMjJNcSlcxY3pLtnhFGxx
	 d5RU92+QKUiKljynqy7A2NJFPwgL3s0mwA5V0WdhGmzfI+CVXeUi9+pEvHCFYuGCrP7sN
	 xBNalKXjK/ldzvXqCe1gu2msWv90nZJImkTmY+Z2KJNhlgRBJF37/JVgjI99GzxIXWZqC
	 cEzKNrfHt81dVukfOsxp7QMEbTGZB4UthmuC/9FZdW2pfr79gsS70KPw465lCgR0goA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949694;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Ee/myPCg0IdhXGVMjGs0qrYdfKisJto2g/jdb1Ya1WY=;
	b=4tKvrlUdCMdYeYhb7zaDCdiNb5pBJAc5Vj2WL3ad1Fd+buzUu4LEHJ30Edw7ruZpXXgZ
	 aaAEir/5bw8qVOCtGoRktA9DtYxDvOXQ+1OxEcp95M8yPeQWIZcw4MumixAEBO4U6Dafg
	 OqeZbsdXUW1lSWy7tw2JsZfCEAQv6ebTSNF0nu4Sa3UNWwkSvCM1EuUv+5IBiPK6l5Osv
	 T+/pfZkuupg8fZjUe/rnLxoLQSS+s0GkMkS+HBgtLm3eCgl0hqOMO2yDypxKUdFXLUybY
	 FkIqr93cm/YzcmscBHI79VAswl4c0GK5Gmj6jTWMdKhtWazRsNtEaS6bioY+eg7Y2pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=QMlTR7WR;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=iThz4MXZ;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665C606A32F;
	Fri,  6 Nov 2026 07:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3665C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=QMlTR7WR;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=iThz4MXZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949687;
	bh=zknT+B53H6X7aoQ8XVtHqntrw86TTn6ol6IZ3zX5qnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QMlTR7WRIeukH2vy2Zj73EbGyO9v0QREeZIN7JhE1qISlk09NE7K0DhU6l6ydf/UT
	 ZkwxcOzpTkE12qCoH/eU+4bAAQVjlOF/fP1TGuk741sY/BqybnDgZQHrQoCUrxfcE2
	 2uJREGZ6s+9tViDuAQ2u34yn3Q593fV2Rwzw4TAF+vMBGDDMZYKihPZyyBQPuyTKN3
	 4pJ5V/WyDwuKcHbBFDMphRFmX+kfMH7FWbcJRuWaA8iwALIq92qQ52k7aP2kHHQBqs
	 TKv4HjCCSJsYVdbHeLeDi7kfJSij/D5+7SGgSlRlv4T7g91EYDfeEwwkEpCZjV3fJa
	 ypSRPxm09d9zA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 966E748BB7; Fri,  6 Nov 2026 07:21:27 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949684;
	bh=zknT+B53H6X7aoQ8XVtHqntrw86TTn6ol6IZ3zX5qnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iThz4MXZKPvjSqGBT6mBs3Zq45v9c7dh0pM1bMWJJouLHlyS5a2eBVXIgGp84qa9g
	 v3lHJyn+bbxERtfM9fIn/6u96fTGYgvxKFXAxnYC99TGm5kyhX+HvOOoIM6VNlhyMl
	 6eOZVOR4QDpzCIJtYzsbbCoquCpYjAUPeYEHCZxBDv+Nj4IRlBq36IQ6vyoMO9eoWC
	 uvFvYT/V+nPsPc+r0wBsFIuycOQf6rYaBwO9Ack2d1CI1Vtiay1BQNg2Jmla5J/PwW
	 eOCt4N7o0F1uvNza4KU1blgvJXfo9oml1RLuL8s56DmY4jyQCcJZ0k6onmdqbUk8kz
	 1umgvBz753rtg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 862A248B89;
	Fri,  6 Nov 2026 07:21:23 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:16 +0100
Subject: [PATCH net-next v20 01/13] phylink: Add phylink_mac_interrupt
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
In-Reply-To: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Emir Beganovic <beganovic.emir@gmail.com>, 
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
index e885da1c28311a12a869e29ceb3c96886f31adc6..a87eaa2f3db5bef8fe56e12b90375bdb7f9c52e7 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1616,6 +1616,26 @@ static bool phylink_link_is_up(struct phylink *pl)
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

