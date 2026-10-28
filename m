Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172651;
	b=WMMyKfewsw2KhCRWDIxrhAD4Cer4g0omhP+EeTjbnQs1cGNEUp89JnVySQS3L93trA3S
	 zBXwPIgmeTfVeI4Le5HOQI7Z9a8v4TH14yzS/RsLG1pjjegtXCsdoUupRh4cyNediwfvd
	 LQl9HPKuZ4s0x7wLzL4ei/D3YPKXIIs3JryM09Df7ZTjdl9Sr7VQU+dAgMhH/tNnntLWy
	 LDyJMixLQ+76Fjk4QS/pw/x3GbKdNiligv5xvmR+5SQv2wrKyykKSvYhIEIJ6oGamhLqF
	 D+TFPV6h5EWv9pm8J5jou3fCeo3Vp2Twy4+lnyMaJM/XRogRgkVEl824ShbWEfiecYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OAGqs6jUlmv0p4hRztxaTJMgYX66siN4FoCA+yfUcJs=;
	b=QFpQTJFDpNOo830JliCsIaCxRJRNn3twZ7gk7+m+KZB9w9oa84s51054YKQYTpRxQZge
	 v+tQfa2pUCTsbRuzmC+bZwhElPwvCmRuyyoURx1nRMZeqn6vNfg7qgvc2QNgTc5rhlq2X
	 eEufx5k9u54TLdvQX9xCD/6Ne1NjmtqKwDRa22BPFjucIqt2eUrpLK6Ntmv7NmoAuV3t+
	 mv2/SkwK4VEaK6ud4V/2TMXAvhRx1YEcYxocbnZqo54XZzu1oZBBGxKszh2zgHZtf9bNo
	 666PkSaHP+jwvwksuMdmUOp2kQwdjIdwGHs/yWY0BjNSI9G2a2cAUj6PBu+otBPdfhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cJ/5izAF";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F8606A330
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9F8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJ/5izAF
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso350628f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793172649; x=1793777449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OAGqs6jUlmv0p4hRztxaTJMgYX66siN4FoCA+yfUcJs=;
        b=cJ/5izAF0PHl91urAMXo+UynlwE+xocDZpvUz+OvZz1d4+FePg+sIrjEH9PtOVcBqf
         jae7xQ2Zm2tYSGfhFLoc2JGWYJicQdFiPdFYhBSvjKzVzKCwycfJXp43nc1snnSFlD2n
         N5Ha2i3IMQcKAV+mjTbwNf4Z7qKlWSoBho9NNc7QSGMenJtUC+zcY0IoRhAS/W+A0zmc
         8hp3KGcI5w16NVTvkbnQLmDJZd6wqDDcBbrxbB2eoS2FplTAi/u0qiQhZeAuq51xaF7I
         X3T4hAaTMp6FAS7cQLnXEoR+D7Vz3Y0Fv2umMLwUrHr8imHWZHyZf8bYRs6YftowhhFv
         3XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793172649; x=1793777449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OAGqs6jUlmv0p4hRztxaTJMgYX66siN4FoCA+yfUcJs=;
        b=OZigopnSUFm7hdXlUZvDdUX7hlbknt+PQ9jz48AxRaOfy8eU6wv+3k9E5MuboG5A2m
         ulZ4ee/lTCibKcT2VqQt/74uN5U9SJc1t+T59Clsf/sKXG5CPgCF8l/h4TIAgjLpMZAe
         0W4SykUPuO+lUHAuw0v4TCUY+Zn0v7KUDB3Z47V6YFv/GadTmUKizlereN4e+GNtjUjE
         CJ2Who+cQ/p8JRDXs+VERE1WlHmtiojdOVIlZwyiHy95YuPKgulk4auF8Vk34VCVTflJ
         v3Gk/vSHLmGvT9EMgPbDGOPBwtRPVW5qTxWy+4/a5zwIjkyIe4r4ONUtBZO7rGlvr7lw
         LvXw==
X-Forwarded-Encrypted: i=1; AKwUvBy1+JsJhlgh5ZoYvWclTb7EukESSUKSwcsDLazL5Oh1ulBymCR2Ck+AQx2IjQXK+l9lPZ8Emdg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLV+dw9StaFRAzzKeotTCCMasNzKgj4RWvfH+LzlVSx/1n0L+OY
	+7ki/joxL3iZui395TjCEcnsPawRmPRVPp1iC6uY8n8bbRhoBj1Cu8vl
X-Gm-Gg: AYBFou1pkVnfJVDrXFzpcr3GdIM0YtDH7P3iIlLEMfMhmrzWwY570FJQ1wxDIfNUD6J
	HSt/jxjviuKIaDfDfcLGVYHi95eEuOMR27oReS/cI25QqHXp3e4gkfPc72qI3FgGToaVsDfA8AS
	0okj8O1VVepynBmTl16GHw9cOZ5puR2B6yak/SxiUqQ5pPG6gBg+xF383Mp2seoSwx2qRbDPUV1
	o814N3lePQtPmIvVDziF/bi2fipYfShiALKaHMnXSy+E8lAQZQe8m9dfQKQOZIbMzwJpMYVsVIt
	FxPDzKUO5y2Kgr3f7YsYUbxS2BDzYRyLH5xSwoSUogpdM+k7fBh9mxApJcIpDN9XMbVKUEGEyfJ
	d+aY660/9H3EGKQDJqT2KSREha21xGd3zPEAuyZCy1FoiuKb8CNVGk1b702qM2Cr9tNcpsAA+JY
	tLB6yiGl9y5ulwBJlOSqi4uIkyyne0siBxS+PRIWch1MpsDSMp9ZGAYWx6WHxFe/V8ytbHGs4ih
	h0ofFZiOnXud3ByTznyoCGZv5cHnsaDDDxeRPrysQgZ2ZypzewdGQ0avgqDYdRf5yITWPgPrOaf
	pWO9Cgg1km3+MH7MygPK4frDlgC4DQEDrCsb0HhuxPWpxZm/EoUTQ2Sl9KqI3DbS2bEIl7dGYA9
	WvVqESX6VtZdIW3uP5L9TQvl9SuQHgl+GHg==
X-Received: by 2002:a05:6000:2207:b0:48e:5df2:fd24 with SMTP id ffacd0b85a97d-48e5df2feb5mr3037152f8f.32.1793172649305;
        Wed, 28 Oct 2026 00:30:49 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm12083088f8f.13.2026.10.28.00.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:30:48 -0700 (PDT)
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
Subject: [PATCH net v3 2/4] net: phy: as21xxx: fix read_status speed handling
Date: Wed, 28 Oct 2026 08:30:20 +0100
Message-ID: <20261028073024.25175-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028073024.25175-1-ansuelsmth@gmail.com>
References: <20261028073024.25175-1-ansuelsmth@gmail.com>
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

Rework the read_status code to use the vendor register to read speed >1G.

While at it also address a problem in read link where autoneg_complete
wasn't cleared when AN was restarted.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 100 ++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 0db82da8dbdf..f5968eec11c8 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -650,6 +650,7 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 	 */
 	if (*bmcr & BMCR_ANRESTART) {
 		phydev->link = 0;
+		phydev->autoneg_complete = 0;
 		return 0;
 	}
 
@@ -671,7 +672,7 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 
 static int as21xxx_read_c22_lpa(struct phy_device *phydev)
 {
-	int lpagb;
+	int lpagb, lpa;
 
 	/* MII_STAT1000 are only filled in the mapped C22
 	 * in C45, use that to fill lpagb values and check.
@@ -698,13 +699,22 @@ static int as21xxx_read_c22_lpa(struct phy_device *phydev)
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
@@ -719,57 +729,63 @@ static int as21xxx_read_status(struct phy_device *phydev)
 	phydev->pause = 0;
 	phydev->asym_pause = 0;
 
+	if (!phydev->link)
+		return 0;
+
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
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+		phy_resolve_aneg_linkmode(phydev);
+	} else if (phydev->autoneg == AUTONEG_DISABLE) {
+		ret = genphy_read_status_fixed(phydev);
+		if (ret < 0)
+			return ret;
+	}
 
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
-			phydev->duplex = DUPLEX_FULL;
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
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_10:
-			phydev->speed = SPEED_10;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		default:
-			return -EINVAL;
-		}
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
+	case VEND1_SPEED_100:
+	case VEND1_SPEED_10:
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.55.0

