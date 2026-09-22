Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A83CB567
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108839; cv=none; b=tIiNNhjEsDgHeOH8wf/Kvc9zb6vcQ94yAGeqYxI7d1ce05VT3fYRL5u8/AFnzgp28FCoT+aBF3mkh8c9xiEXXLvxet/tDJPT8puIPVzmP5JpByrtIujTnrDK5SnsNoJnl8kvwf6a/3rBVcG84DeV4kZMcHjX89IxZFYLStcrvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108839; c=relaxed/simple;
	bh=K8lImduoofP6fcAJx7GbPNJvt4mBJqZAyinZBeDmwnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUOBd/eJObWvbZh0A7FMULd9qN5OGWzyGPmvuLfGzNgCEl/6D0eH4is8pyUs2/wDAjQINAwlxttfWBrWblYJaw/0yuRQoXl9JLHvclhpVgCShqTM+M5TdKUMHrCgG1TBU5VqWqiP+DLKx1Q9WotXb6boOlSBQaF6CJs7uJBSQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHdFg/i9; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHdFg/i9"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa06e51bc3so434137a12.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108832; x=1790713632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3JqsslwIBGfERN75aiva2q/D4wO6p1mhjTwmsfsxa8=;
        b=lHdFg/i9hUmQTEwRjYHIQjIed+3Au3m07g8Q+LPfyypewskdiHn022oSNl14NZkulg
         GwI/kZ9ps2B4f2gZjiz5ZmR+49PQCJwjSebwIRKSxTLMTAKQkWJ2AxJNj08fcSwvB4zJ
         +i5PClc9/I17hkCDSaNRbcYe9cVg7aAgqluN63krBq50LOn5of4O3+WzWcqOYyI7+d8T
         mOH/Vhsxk0JpfcYUO1Zrj/Heo8IWAUmV0tmHoF8pbarVT7MIv2klaOi/Onq7uxfq5KZF
         7gIO4ECfv3YW7tcYW1RUVaTwd+nyFIhddtqsbNt/CpcMfMEh7MD5+P/C8q5P43fiOVgP
         IKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108832; x=1790713632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G3JqsslwIBGfERN75aiva2q/D4wO6p1mhjTwmsfsxa8=;
        b=gvMTXbhzs5ZEmqGfhbcsCC+VKH7FFFG6X8mfiLgTRL0pmrurDvhhon8Dxyi8mxZf8j
         qR5xZVwmx8pYptsVJzaM9/Jt9PyHPzeKfK3t3XKoAdDDLWoXFWPsBlp8n2aRivInOZQC
         oDPcduxV8xRCu7NhyPk1UbQWKadUC0YsG/k6Ew9n3Iw9FzUGzm1korvLoYOhI8y/g7V7
         Mdt90mZbJSkvDpu7/FA+/YGfWlY5QdwWBRFiZnsRmPMNrA7K9jQR3elds+YAgkI4GVQZ
         emMKTaweM40MsST+MLcaz84f0D/NOWlPVbRgIXJ2TgerFP1B2HSE3yQn+zfJC1b3ktbU
         144w==
X-Gm-Message-State: AFuF++mojbF6dfk8L0oW8D+XzChoRRvZFgUaZkFQEy4X8xhhcfSA6EVm
	Ze0UIZInDMptpLp/QVKk49sP9EbfHnQmnX73EfbaN9js2ku+IxZzrRJEawkXRs4oO40=
X-Gm-Gg: AYBFou2lsnPvHxwTNkMyUFGUG3UFA4tX23chzJrj13mi/DNgSqZ6u7ir2A0seDF5p6O
	26o/CwlsyXpeaXbSJrZI31N1nnmghu7uaX000VJVJGjZ3Y84uocw2D7+FRNHnqEB1KRysqj5eN2
	aSLCBZgSXFdtPUrYYQcBqGQrbq/AXM5EwHMPWuSf3d6Wfx0hekeEXkDmFzXno7teIlLFgfXBZMa
	attrTsPxbJ7goCJRJnKe6IBwGskDCb3aER2uZRgng7jKSfKWGYiFHYUzeHiIoFNrL4lhG6cSy9D
	mYNAqOCP9PAc5B6BjIeZFGysSXETNcY1fRMi1oO0Vylxp1j9SYhY6MOcaRNr/NAAzgFC/ry/hB9
	D4cw4OhfB8XQUJlk9/axoVF/BzEcExt+cIkRfOrW8aY/1D1MuipqoKO2rqEFhmiQwdNQ43+hq3R
	j7FCms1ngKY1YJa2YkZi/l1cMkciL2Cv3M86S4FbhDX4i1dZcMtdcUVqwTSuIyaDuQ97i5sSGWj
	iuKXkAmn3jm+baYox6FFrETkWD0kQctKb/5rcGsCXNy/PPx7WJD7cl9kkIJpy4ODicfKgmT/So0
	o3VLxo72PYyap+OBjnP9
X-Received: by 2002:a17:907:6e92:b0:c26:1648:a06a with SMTP id a640c23a62f3a-c2aadf937b2mr30566566b.37.1790108831890;
        Tue, 22 Sep 2026 13:27:11 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm11080466b.15.2026.09.22.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:27:11 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	ansuelsmth@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yongzhao Chen <yongzhao.derek@gmail.com>
Subject: [RFC PATCH net-next v2 5/5] net: phy: qca83xx: disable SmartSpeed before resetting CPU PHYs
Date: Tue, 22 Sep 2026 22:26:53 +0200
Message-ID: <20260922202653.1153-6-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260922202653.1153-1-yongzhao.derek@gmail.com>
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consume the qca8k flag on QCA8337 by clearing SmartSpeed enable and
bypass-timer bits before genphy_soft_reset(). Read-modify-write preserves
the remaining register bits, and a failed update prevents reset.

The same clear runs before the resume BMCR reset. If MDIO access fails,
resume returns the error without issuing that reset.

The downstream Redmi AX5400 experiment observed Gigabit advertisement
being removed while the conduit was not yet running. Applying this
sequence before the initial reset preserved advertisement in that
experiment. This series does not add the board support used there.

Unflagged QCA8337 PHYs retain their reset sequence. QCA8327 drivers
continue to use genphy_soft_reset() directly.

Link: https://github.com/openwrt/openwrt/issues/24696

Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
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
