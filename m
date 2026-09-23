Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFB5221DD
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200768; cv=none; b=UWsSs86o1mZ57iRTf0nKg/WjALD4kM40vf5tBimHSgc9uyjh20J/1Hshgqm6xKk34icFiQDsAPo1QYU2xLUM28yKouhc5Zi7zTwVvg4WjFtZkOppu1Iuaf2+N0lLgDHhdW8tr3dg+vmywX9HAe4wUsKfGxhTo8YfE6qDHybJ4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200768; c=relaxed/simple;
	bh=saayl3HPeMGDQwP4gpkRoqyOqmY3X//RUk2hQqDBThA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a20Dt7Xn3bgUmfSV7jjPo97tc2pJgbHvxb9K963I50PGi33+WJW7XmN/CZeG6SJTUzRK2sHclAxl6i3NWRHsDDHO/poAX3x6pEHIlGVPYn9/X9NJPvjvOIXXWeQERKaXqkvMs2ak9va442gPbqBTTcv0GHBqfOWvVeekfXuhmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6AwzjSj; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6AwzjSj"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so193861366b.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200761; x=1790805561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qzbg0xrn+b4txPd4lT64CQhwFT+1jhOzwXJ+cMbTaZM=;
        b=I6AwzjSjUa1uBmixPexX15VRz02aqnyw1uVoRYW9s+dV2ppnHRe3X1ur6tmIZxA/yo
         tEaqmv8ceePSvh48v5JZcDJ3uYCH3nJtHHbJFD3WvLCWGmx+NAfIz6B3SRe8KCdjjGGy
         8HOJCPr7q/lTQbE11Hsw+x9YOSpwK07k9wW0tJRuVZwI/uT6195JMLCU+R7MEEf7Hv0U
         QpCwrsof2LcfR/nmObkjKe3bxoShACIv9NoMXLQ2APQPvmlzVx7cASpCFYyJ8guPIC5P
         cq6Pw1/JhNEkG5ft9/CIsGRK5ZSPqOrH6SNQRl2hlKIQ2SF5fBSOosq+lvd0wPqDvF7A
         EnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200761; x=1790805561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qzbg0xrn+b4txPd4lT64CQhwFT+1jhOzwXJ+cMbTaZM=;
        b=jJ39KbMdmRSvVrPtFChDjA/r7dG8V8K+sbjz1bv2qcINiRu8387sKgw5TePYPY/76O
         QYikJxF07Ai1py+VhrfCFvjLtkJFATCn+/OxDkJWl9ni2DdFTudeByrN4+FHUA6uVEAz
         fTD/7GThJdJiFWJgsVd5vKf1u66YbfU2qDS/YMcfprnBN2fgXxyIYCrbmU+RUiyJPj/o
         s5Suvphay1OlstsDDrM14MSFop6TnsXdnmlkASjIIV0BmxSLjysaiB8N7mEqh7N/U2ae
         fePxdl4elKyXZ7EMi0ef7ipNyl4PIYBcRvroAzxI4MKSW9brr2p5YhQYU3DMY+/8PH1n
         k1og==
X-Gm-Message-State: AFuF++nPWRDLOZ6tPJruzT6AHquxA7fT/o4g0uZQrj43ZffNpPDSEex8
	ECVQeZxcjq5N3fF2Gxbj76hNQoNnGCt/GHbTURBwtmUoNDrUZ4eGj2rXxTSnWG2AHNeM7A==
X-Gm-Gg: AYBFou09uXmxnkpIwOFWO+2g184+36Io2nKDyLCqnbTzRPxOkFbtHWRFLx5kBqCEeCG
	LikZhOeMHu0vMnNx0D62/ndt1pQw8tURNIkNChunOxnVvB4bRkiOUUxDGzH8J6YX4nNZpuy3vCT
	v84wJD8wR1NvvxbQuvClsF6jKS2FmuTAdAh1saH1H1Y8aWCCQsBUtc3Lr2qCs1dcSGvAMWaREAg
	+zHXhZkwPnsIhVKe2kIrEPfkKJW+ZTjeWyZMWV6JXNQoUSPQ+BsJ2Y7OEGPZxpdBRlknELOvNF7
	00PM3UNQKyKwpONhGLzyn/Qxh6+4f1RQ54IodZJ/AjFJzGgzzdB5msfD1Ld/JqPlaETxn+aw01L
	Apblk2kefmXuYHJptPE2NKAVDzflfHZEyQ+HU9Sme3/lSwP31Rg0CWW5VnNFXvYeRaSypLjgXu1
	CGHmRJU86dOWlyJnNyOWDBttv7/In91oM2oN25hH/k29V3iVa5MFSFYUewD9fYPzlU1gEMGA6HX
	n3xs+NqQh15X7lHe6zGpI97dL3X30kTP7D+TydkfKsBwCAkKfIxH0kxBM5YC+gjOH1r31tuJYgJ
	nlUifIMSaI5jjsxz6AMr5UqzNI5d6loZ5+9/mEAYdQ==
X-Received: by 2002:a17:907:7288:b0:c26:19de:912d with SMTP id a640c23a62f3a-c2ac256dca9mr31793866b.32.1790200760647;
        Wed, 23 Sep 2026 14:59:20 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6dcf0dsm197647666b.61.2026.09.23.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:59:19 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [RFC PATCH net-next v3 5/5] net: phy: qca83xx: disable SmartSpeed before resetting CPU PHYs
Date: Wed, 23 Sep 2026 23:58:57 +0200
Message-ID: <20260923215858.1653-6-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260923215858.1653-1-yongzhao.derek@gmail.com>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For flagged QCA8337 CPU PHYs, clear the SmartSpeed enable and
bypass-timer bits before invoking genphy_soft_reset(). The register
update preserves all other bits, and an MDIO read or write error
prevents the reset. Reapply the clear prior to soft reset on system
resume. Unflagged QCA8337 PHYs and QCA8327 retain their standard reset
sequence.

The quirk flag is set on phydev before phy_init_hw() calls soft_reset();
config_init() executes after the reset completes, and generic
config_aneg() remains in use. In the RA74 diagnostic trace, generic
config_aneg() preserved CTRL1000 at 0x0600 and returned success, yet a
later read returned 0x0400. The trace verified that no intervening
writes occurred via the instrumented Clause 22 BMCR and CTRL1000 path,
though it did not isolate the precise timing or cause of the change. A
read value of 0x0400 reflects the advertised capability rather than an
active negotiated link speed.

Disabling SmartSpeed before the initial reset maintained a 1 Gb/s
internal link during the tested RA74 boot sequence. The experiment did
not establish a broken pair condition or a functional fallback to 100
Mb/s. Board support for the RA74 is not included in this series.

Link: https://github.com/openwrt/openwrt/issues/24696

Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
 drivers/net/phy/qcom/qca83xx.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
index 0f484cdfe..21ab015f6 100644
--- a/drivers/net/phy/qcom/qca83xx.c
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -91,6 +91,28 @@ static int qca83xx_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8337_disable_smartspeed(struct phy_device *phydev)
+{
+	if (!(phydev->dev_flags & QCA8K_DEVFLAGS_NO_SMARTSPEED))
+		return 0;
+
+	/* SmartSpeed settings take effect at software reset. */
+	return phy_clear_bits(phydev, AT803X_SMART_SPEED,
+			      AT803X_SMART_SPEED_ENABLE |
+			      AT803X_SMART_SPEED_BYPASS_TIMER);
+}
+
+static int qca8337_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = qca8337_disable_smartspeed(phydev);
+	if (ret)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -160,6 +182,11 @@ static int qca83xx_resume(struct phy_device *phydev)
 	/* Reinit the port, reset values set by suspend */
 	qca83xx_config_init(phydev);
 
+	/* Reapply the CPU PHY quirk before the resume reset. */
+	ret = qca8337_disable_smartspeed(phydev);
+	if (ret)
+		return ret;
+
 	/* Reset the port on port resume */
 	phy_set_bits(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE);
 
@@ -218,7 +245,7 @@ static struct phy_driver qca83xx_driver[] = {
 	.probe			= qca83xx_probe,
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
-	.soft_reset		= genphy_soft_reset,
+	.soft_reset		= qca8337_soft_reset,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,
-- 
2.43.0

