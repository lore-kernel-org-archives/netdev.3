Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495283515E5;
	Wed, 16 Sep 2026 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529061; cv=none; b=Jl0f4qpwVRxDfyzoX5h9P4FLlH1xJn/r/TBcnCPi8VU4mF5KIJ/W2/RlWiZXc/AadaEnBLseDnwabboKdzxVz/lq3Qi1lQP5lct1rR+sIrM7sF9NRBoUCwyDgx5l1fA5CrBYWyjNHbsffsmBiLmSLCzhjCgXpkVeoqNrJcLlOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529061; c=relaxed/simple;
	bh=anHWsZmc/HioyP1vEPDMn744EpmT5YgretWwLYFhp2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fm4QbmvmbiUasMdAwl+V1QBHPkMEY7B2DtRRQR8OB6so2bAdUAQ3PKSOgr6YbHqUL7FHb5dzyqGPfXd4rC6NSr8r2qWNWr3GDb//k8YkuZMuSyHpJgbbsoHCda11Y4im8RsYgzt6RlYBQoudu986udWvFgmEI/cX6gPNnSAKHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ISnU2Akr; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=jHrNV/uq; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ISnU2Akr";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="jHrNV/uq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529057;
	bh=anHWsZmc/HioyP1vEPDMn744EpmT5YgretWwLYFhp2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ISnU2Akr2esuTs843s9S13XzSsk4YaWs6YBqYUmMJtucPOdXZI/xAYQAKoDec1BX4
	 yV+BXNwDvhkvnFpKxs9lHvDoxg93AVXoipPc5ePJYcc9unEUKWnS/dSTmXkhHpbu+R
	 18cD7uVrulfKDdN3aa8UiOWvzxjDXM3NzUiUIjd/kiDKFklEOjrJEKyup1asOvOZol
	 YQZus2b01NAnV18fFAovIRySWmadmJsACT07e0X3OGJ8+zAyhv/D+Y88pNYphebsPh
	 LzKMtIhHfPGTIgZXlox7CWMdPoA5UzA172Nno/KGFp1CDV0Ik2u3oRFfsoPoqYA6vJ
	 TK7ndkV1wDAxA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 50FC63FA82; Wed, 16 Sep 2026 03:24:17 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529056;
	bh=anHWsZmc/HioyP1vEPDMn744EpmT5YgretWwLYFhp2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jHrNV/uqut1qvRxdcb7Pj+PdryAqAmufiONqtwCM/WzcNvA/uCIiIGDavfAyuajfL
	 NCPmbwkrXJOiKNgamERVvYQAasfMgSNFU9no3YCmfv0ixQvwJYOAz9SrJQ8H34qFdX
	 VvmXdKruy1f+Pb4ZLCOaPfo7teJd+A3/Hcn77x5eufP7/CWzq7RxTPxZcOX9Noe+DF
	 aEnDOGqIq9qdSgWXZVVhpATKtzuD5A056CwA76cTszYqv0D9RUQmHlApGtjLjh/41b
	 ZplFFyv9nRxSR+pFM9RA1/qwJWFv/Yu/9djMNm9TndocCjiHvJet2T1mvD0XqGAGHp
	 XkrTTng9VSKMw==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 807033FA6C;
	Wed, 16 Sep 2026 03:24:11 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:00 +0200
Subject: [PATCH net-next v12 01/15] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-1-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
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

