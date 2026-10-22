Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708216;
	b=sohRjIDF0QoyevsnoCXbJVI3OQGbB3TYobGRrqyt/F5MidFWjyeSEZgfkQF63wyRayT6
	 UGCUuStssIV912R4i+AWmrOGFlFpqjtgUfE6bKQB5hgaeH8gC9Qrr8sL6J57HiA3mUVCR
	 7lqe00A4S2Rpxb68E9iT0Ze0LyYxXXXC6W2hxFcVCkUfvrTVIogBqXxGibRWgOHQ55W9Y
	 TQXHVyEidpPnLoeYjTnllysSjhZ9eacCrOHrzV35gpZdcH+QOUIqFJ1DpnRtVPgyx9dJf
	 K7vnjNQpcG+/95PS3xz5Azah6aBDwzdUjML40ooFj5dqNBmnh60KmElxbAwVltPFdvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PqB/6E/5/WwmK748GvQIiLyjCpg5Y/KdOrCD+xl7ktQ=;
	b=FnFjqVWL03vlA1dSHFhVcQfRx527X6rE8LTJrn/0ojGPGfQwV+ZFHAn73Ikru7GPjpXL
	 aC3RuaGEdt1nwvchdwIUKVVk92mUEe7igm+MAWSLcF55dbmUGWgoB+JcU9TFyqV/6SR7k
	 Lf1gKWHrd4IZSJDz9eiUqT8GlFwPfpURI4KET3gAQmbbPt+imA+qtXV3+IdGrv/bEiHfx
	 HqFJJmW7p+0e+4syXifw5kAW1zCy4xejBonuUepeGsyaqFvCmd8//hAurJvDMpPhAioO8
	 5cRVJSzpwwBk58hpz89S2btyJrPFhxRmjbCjLUem+ifJWLK/Ap+7ulGsYXpj5hC9Lnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZxfvVGpK;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72335606A31E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72335606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZxfvVGpK
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so1406065e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792708215; x=1793313015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PqB/6E/5/WwmK748GvQIiLyjCpg5Y/KdOrCD+xl7ktQ=;
        b=ZxfvVGpKm0bZAaxQV0k7eQuJ3ONllKHqRxv/O249uMAyg5DJHkOL8mtV5CFUjpVv6i
         tIpszVDQjL2Ikkf+hKFKn2oay3UItm3Ht9TXYH0XP485pQZ4Mp3TSg1YX7stOd06+IBM
         5ghzwq6920oa1gLn7NmxElu1NxsSEtIFlVQZcjWKyWed5KIehA7ei90cedIHnP0Vi5E4
         5zrUGEtwjakSol8TJti9QiaaiUzbNGfRxxLtgyEtdDP5D84wbfMTEzhtgIcgLcg2r/mn
         5UPJuC0WYbOYfcf5U+2SxA/f3HULY0v8n1/n501XCBbcZthA/EVCdF6/so+UVIHqYO+V
         pTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708215; x=1793313015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PqB/6E/5/WwmK748GvQIiLyjCpg5Y/KdOrCD+xl7ktQ=;
        b=Ngv+FMylXM7qG+MH2E6PFdbOihPwhZ03gzpj7GgfoPEoUg2E4Hk+5ZfCqk8HsV7q4f
         0jUE3tRCEJPMUwmh32xMImCrkBpIvscYPc80Dy9ERJaQU36k5uNlSVE6n4Wp9hGpK/Po
         dn/S3rMlqAKWn4vi2tfEG3siVHssK6c8rsoqGeFtLV5JnW97nZ27hKJi5WD4+G9xGtba
         BLC56Cl2rst9BkBSvUwYZaa8c9+uQLVc+uAinWp+FMyKXmxjktPwM7HKxxuE122vPd1z
         nq0gFeB4YRatYxKPKOlmH4qM6e7wa5ojXGN59Jip9wB+ybNDi6/qgqXhlQ0dMcPTNGuL
         41tQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWQnmGlvVwlmdioOq7/BmjuBorybmRmKHGimeDLgit/XQwoTIznU6CS/8aF/v83Czan6EB+2c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSoYl19bVFP2V+K3YclnKmi98HIqmp/K8q7efp9w6z3gvNvJx6
	Jdvn2yiZFuu5kcIaMnZBHeni78QuMnAkfEVqqbH1beAdbGD4pxe2iFoj
X-Gm-Gg: AYBFou2ihY0YMD9j1XHL0qIysH/idT9ruPymG4fcjZllwJxxLXyuP6r2UcjHIIENMZU
	XWRv+KKL8FlNdYxHoEnK1StwE0BgvceExhpEf0rTu3mfKYGdQmpks9GI7jUoXeExmjUy9NNw688
	ZigumoaNWDykl68oAJoZkXXTRanIN0QzKmLix0BMOi4oqEsGgc6OiQ07y026Y1631WOqdjDcDeF
	2yiXWdFmzaRqaPeYTTA8T+NbOYpKtZxTsq9MyYqqaPfKlafwIW6cFSkw71HMi/Zdmzf3LmI3Fif
	rNUYPSgfvQRsF/OtGSq8uGJNYOLnd9kOZEYifj8zdDFg1bnch6N8AFYgMupYfIE2mrsE2+SKC85
	mCZh8p4paqHwSp0pn8aSEamEjMnueBAE50oKeNxWdXfM4Jcfm/ETs+glL920orhBB2zERphpgW/
	kSduFViwxV+kyoTEM5Rtk0jurql7K21/oOwBEgtI/STBi/R171l+2ybxNPLhJJqfg1Rf34vgCNx
	+b7oFckau20UPEr79heFRVFDmfbkYwkih1MuSlcKsLoAE6k/RIBXVV23r/lTrf/NncJM+qR5qld
	e++AgxqiUuD/ZX7zDdw7thotxLmYTnL7R8siErW3PHP3fYDAH6LKJOGMnR9g
X-Received: by 2002:a05:600c:4fd4:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4a211f3a5f5mr4752595e9.35.1792708214561;
        Thu, 22 Oct 2026 15:30:14 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a211be8f79sm11958795e9.14.2026.10.22.15.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:30:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/4] net: phy: as21xxx: fix read_status speed handling
Date: Fri, 23 Oct 2026 00:29:52 +0200
Message-ID: <20261022222955.698722-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022222955.698722-1-ansuelsmth@gmail.com>
References: <20261022222955.698722-1-ansuelsmth@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With further test with 2.5G NIC it was discovered that
phy_resolve_aneg_linkmode is not enough to detect speed higher that 1G
when autoneg is enabled.

Also in the switch case there is a typo where the speed mask is AND with
VEND1_SPEED_STATUS instead of the correct mask VEND1_SPEED_MASK.

Rework the read_status code to always read the speed from the vendor
register and parse the generic bit only for the pause frame.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Handle half duplex on 10 and 100mbps
- Handle >1G advertise

 drivers/net/phy/as21xxx.c | 104 +++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 40 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 0db82da8dbdf..519b78d3579d 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -671,7 +671,7 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 
 static int as21xxx_read_c22_lpa(struct phy_device *phydev)
 {
-	int lpagb;
+	int lpagb, lpa;
 
 	/* MII_STAT1000 are only filled in the mapped C22
 	 * in C45, use that to fill lpagb values and check.
@@ -698,13 +698,22 @@ static int as21xxx_read_c22_lpa(struct phy_device *phydev)
 	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
 					lpagb);
 
+	lpa = phy_read_mmd(phydev, MDIO_MMD_AN,
+			   AS21XXX_MDIO_AN_C22 + MII_LPA);
+	if (lpa < 0)
+		return lpa;
+
+	mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, lpa);
+
 	return 0;
 }
 
 static int as21xxx_read_status(struct phy_device *phydev)
 {
 	int bmcr, old_link = phydev->link;
+	int speed;
 	int ret;
+	int val;
 
 	ret = as21xxx_read_link(phydev, &bmcr);
 	if (ret)
@@ -720,58 +729,73 @@ static int as21xxx_read_status(struct phy_device *phydev)
 	phydev->asym_pause = 0;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
-		ret = genphy_c45_read_lpa(phydev);
-		if (ret)
-			return ret;
+		if (!phydev->autoneg_complete) {
+			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
+							0);
+			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+			mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+			return 0;
+		}
 
 		ret = as21xxx_read_c22_lpa(phydev);
 		if (ret)
 			return ret;
 
-		phy_resolve_aneg_linkmode(phydev);
-	} else {
-		int speed;
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+		if (val < 0)
+			return val;
 
+		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, val);
+	} else {
 		linkmode_zero(phydev->lp_advertising);
+	}
 
-		speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
-				     VEND1_SPEED_STATUS);
-		if (speed < 0)
-			return speed;
-
-		switch (speed & VEND1_SPEED_STATUS) {
-		case VEND1_SPEED_10000:
-			phydev->speed = SPEED_10000;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_5000:
-			phydev->speed = SPEED_5000;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_2500:
-			phydev->speed = SPEED_2500;
+	speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			     VEND1_SPEED_STATUS);
+	if (speed < 0)
+		return speed;
+
+	switch (speed & VEND1_SPEED_MASK) {
+	case VEND1_SPEED_10000:
+		phydev->speed = SPEED_10000;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_5000:
+		phydev->speed = SPEED_5000;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_2500:
+		phydev->speed = SPEED_2500;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		if (bmcr & BMCR_FULLDPLX)
 			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_1000:
-			phydev->speed = SPEED_1000;
-			if (bmcr & BMCR_FULLDPLX)
-				phydev->duplex = DUPLEX_FULL;
-			else
-				phydev->duplex = DUPLEX_HALF;
-			break;
-		case VEND1_SPEED_100:
-			phydev->speed = SPEED_100;
+		else
+			phydev->duplex = DUPLEX_HALF;
+		break;
+	case VEND1_SPEED_100:
+		phydev->speed = SPEED_100;
+		if (bmcr & BMCR_FULLDPLX)
 			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_10:
-			phydev->speed = SPEED_10;
+		else
+			phydev->duplex = DUPLEX_HALF;
+		break;
+	case VEND1_SPEED_10:
+		phydev->speed = SPEED_10;
+		if (bmcr & BMCR_FULLDPLX)
 			phydev->duplex = DUPLEX_FULL;
-			break;
-		default:
-			return -EINVAL;
-		}
+		else
+			phydev->duplex = DUPLEX_HALF;
+		break;
+	default:
+		return -EINVAL;
 	}
 
+	if (phydev->autoneg == AUTONEG_ENABLE)
+		phy_resolve_aneg_pause(phydev);
+
 	return 0;
 }
 
-- 
2.55.0

