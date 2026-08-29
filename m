Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FF33F5A9
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974885; cv=none; b=oFB4S3U8wY0wwcTDlbmYK1ZyHev1GbH41CKsoYbhhwY49/rnMBJkYqb+2yKZrhu94AZ8eUTf2KhutXfqFvmX1gCjCaGdfB1tI7zHYr26wOdgPO/oqUzq1AgWp1VDYVjQxB7lxxfIXofvSMuYWd3pheQlOS2WaKuR3Hh1lSf+jYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974885; c=relaxed/simple;
	bh=Oyzr0NbbRntUhfVfyint/OMfL9PMoXNLK9GrLWCD/II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYekt90u1nhZ5xVXHchfRqwXnhPfBza+NF/QG1GSspWcQCgPHcr94cV3Ebxgq9banpG4Xd4ZzwA7BsLMsYuw4bLEkwrU/KV3cGFHbxfgsndOHgKyIYUULXsulfVZXJMIfChjg7dxs17wwdBtzgq8ZuEQXaoyQnaFqxzJyphdpkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRF3X1Kc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRF3X1Kc"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3968e063f84so1290820a91.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 20:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787974883; x=1788579683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhmCGz4O2Sg0rYh2f0GjlwZofbGMWZdgyMVeCKxxLm0=;
        b=cRF3X1KcAFlhu+9utsa4YBJ9gyzsEoLS7exUkC//8oUGA95LjbWzQFV6UOGFb2O+u7
         5SrcaFloiVundhC8r8mCIVbd4MuHvUXAh2VWkN+T9H5wdxmFYMvUyArQB+MjBpda0fib
         9HirL9mUxxEdoAQS7CbVSpNXnYDt1IJC+Ux6Y+DhTA4S6DRhfcVRfYj0i+QYJxws8ZY3
         2mZ9EkiG1eNRgjLBG25ghJtKEofw3cvs3+fDVg8aWCLvReesUxreUncDNCD2sWs20WC3
         Vuyyr0gw0JmTvkHxhHKX00XKWv7e5YAPGY+l1o0Kam0N3b7hhL3ebUz9ysE5t5k+ebC2
         /pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787974883; x=1788579683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhmCGz4O2Sg0rYh2f0GjlwZofbGMWZdgyMVeCKxxLm0=;
        b=mcjI/kuOG1FoYhFSwCWT6e8UcJ8W3GfKisHfwFrtPeuI49IwGU+4kIlGgNOjebMoiH
         /7AO/pymmaXKp0eeITXEheH/gLP8p2IrttAtK+hJE9VdnBRxdGosX0oPVYnAHATBepKY
         KgujPUy57Z1q31jdS4ZWnFE5VTOFUGP7FN12rTB/X5pyGyCw4iaUCU1O/ampfK+9gKTN
         xgn//p7I80wsdEMWqbl5yWTElO5z6jdPXrh7VBRGxTiOG3V9ikgK+2hwyDOtc4L6tUYH
         cJhyEGTxMAOZiP6oo1KWdbAPdypToM82OvYcr0SVIIl3M92e/LIyVBfyQ8pelpXa4BXZ
         wGxg==
X-Gm-Message-State: AFuF++nd99tN+xDj+FiCOGpl9kXyB7O+cQ0UZZDMyDAKCr2HN/56WLT6
	i+GnJIPgN1+oegvqCDjeG8tbjSQCjeK9VtfjtG8k1i3nrm8OnJGVD1Kzc9JVpaKSx8w=
X-Gm-Gg: AYBFou3DY/SRp/X1Cpnj+d8KAwoP1n7Tj0paRSRJAfpdplblfKMF9gYcNchUT2KTIGc
	qUffgFlOWrr89nuhiTG6laMw0pd3dF8C4wtmFdHEJ0Aoe45i8Fqampan2dwilGoSTgK5cIVR92l
	yO1w9Q7pflbhPzu1ynhXvX6ekTcIbkug0G0o+1d21TI46paPThmbhCuc+NFIE4/rHEgQDAx95mj
	41+dkLzpTgvQo1NQVLX0yWlltueg6h4uuAGWOBKopOyiMkvBD4O10JizgB9AjdhUyPe1nDw3vW0
	LsXgLDZsQEzj0ktvpDCzicI30uklAbtxrdP84Clj4lw+J9S045s/CRINKSM/zKIwAKMcolfWzpZ
	PDug6nu0RXuwA34BQG1OyiffHG1bhH5ZaWB4/lKCCS9tk5UzIcZUvfmbl6NPl9FZ/pArmNcvLXR
	2jD13LjoN/62PPjUTbXvxbrwVJ/PpqQ5QCxTbZ1ulWxHROPzYYuiqNAbJb5I6gxm7J
X-Received: by 2002:a17:90a:d2c7:b0:398:9bd1:3210 with SMTP id 98e67ed59e1d1-3989bd135c0mr6264616a91.17.1787974883056;
        Fri, 28 Aug 2026 20:41:23 -0700 (PDT)
Received: from DESKTOPHOME.lan ([240e:3a3:9304:9820:9199:f1d:64d0:73a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396dda36ed6sm5097134a91.2.2026.08.28.20.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 20:41:22 -0700 (PDT)
From: Ziyou Xu <xuziyougm@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@mork.no,
	ericwouds@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: phy: air_en8811h: restore AN8811HB LED GPIO after MCU restart
Date: Sat, 29 Aug 2026 11:38:43 +0800
Message-ID: <20260829033844.1975-1-xuziyougm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 03b4702fc5e3 ("net: phy: air_en8811h: move LED GPIO
configuration to config_init") moved the EN8811H LED GPIO setup from
probe to config_init because an MD32 restart clears the output-enable
bits.

AN8811HB follows the same initialization sequence: an8811hb_probe()
enables GPIO3/4/5, and later config_init() calls restart MD32.

Move the AN8811HB GPIO setup to the end of an8811hb_config_init(),
matching the current EN8811H path.

Fixes: 5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ziyou Xu <xuziyougm@gmail.com>
---
Changes in v3:
- Return the GPIO register update result directly, as suggested by
  Andrew Lunn.

Changes in v2:
- Drop the EN8811H change, merged independently as commit 03b4702fc5e3
  ("net: phy: air_en8811h: move LED GPIO configuration to config_init").
- Apply the same fix to AN8811HB per Jakub's review.
- Rebase onto netdev/main.

Not tested on AN8811HB hardware.

v2: https://lore.kernel.org/netdev/20260828032922.469449-1-xuziyougm@gmail.com/
v1: https://lore.kernel.org/netdev/20260820141034.1400439-1-xuziyougm@gmail.com/

---
 drivers/net/phy/air_en8811h.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 0eeb7b9a4..38eb18f0e 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1125,13 +1125,6 @@ static int an8811hb_probe(struct phy_device *phydev)
 	if (ret)
 		goto err_dev_create;
 
-	/* Configure led gpio pins as output */
-	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
-					  AN8811HB_GPIO_OUTPUT_345,
-					  AN8811HB_GPIO_OUTPUT_345);
-	if (ret < 0)
-		goto err_dev_create;
-
 	return 0;
 
 err_dev_create:
@@ -1265,9 +1258,15 @@ static int an8811hb_config_init(struct phy_device *phydev)
 
 	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
 			    AIR_LED_MODE_USER_DEFINE);
-	if (ret < 0)
+	if (ret < 0) {
 		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
+		return ret;
+	}
 
+	/* Restore LED GPIO output enables after MCU initialization. */
+	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+					  AN8811HB_GPIO_OUTPUT_345,
+					  AN8811HB_GPIO_OUTPUT_345);
 	return ret;
 }
 

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.43.0
