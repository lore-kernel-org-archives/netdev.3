Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB238D017
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887779; cv=none; b=cH2/ChXRs8Dej4tUBW9P1kHR6XAmdOprmTLRoTnnix1Tp3udANYdUSqOrzFNIhP3I+3/gUyVpCCqh0mvZ/Gf+PKASGd2uxXPHHvwV41sMxMV9PQ8KvT8inkkNKk54NrFpH8U0tvK7WnhrLXVJ+FvW4Nr0E41NGgvB5AGKkmsvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887779; c=relaxed/simple;
	bh=jPjlin0tmMCDRTUW+snF3PCNw9aRjkrQLg8rejx6Ly4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJjfZJfspEeWhFzC0JjJG9yYwQNGRtBRzfN0azPwBgtas52mUWpewPHSzp1wuCbzaqoNA0ltnN9EthlC6HV6131hMMrnXz/TUl30moxzgnX/YhAPQuywQDv+Ogudtd9nm6WZvp+U0nXfeYVimshke/OQLRPezhimQOIleC+JEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQZGM383; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQZGM383"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso670131b3a.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787887777; x=1788492577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nm+oSzw2CJimOwrmR4fmonPKPbwcboKbls/SrfJtGuk=;
        b=ZQZGM383K2s1zkYeHdJcoSVFaHA33CHT89DmYEYIU/ylCJmPbAibUdK2EHIWXFeiZx
         /Vxd+Fwop1tgVMKhpcu8b4SYswRqcH+CcaMsS75+BF1ft6hist5CHui2eF/HrSjmeRFY
         9fDvRwiht1K1b6VRVBskyFS1IYBwzKMdHsKnctvQN78nIY6yBMB9rxUmQO8uyy99e0kL
         8NnmthT4C/vDWRNPc4w4jPy245ICoqprQHkj3dq7Quev+rf2g62ZsySiK4O+1ilwKr1A
         /59neHNjS3Gn8uqdahUPhODiFG9kg0Ryv/n97JsvQaNIhkNJ2G3UGOnfUwPPNgeOmTPl
         cIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787887777; x=1788492577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nm+oSzw2CJimOwrmR4fmonPKPbwcboKbls/SrfJtGuk=;
        b=MSTZe+EFnZsWYji8I+iC6E49UlC1NW8ZkEwC3q+aNAsgYL3jbWq2JcFQqFb7MRNr3N
         3DmLVVWkbTHnP3r1SufzJV6Rw/z0tYqBxEDumrP0brQKS7T/OnY5JvG6Dooib+6UPweQ
         TKoHauiZ3njhlMnZI4hC0E8NVKD7089U+9E12TZnEYCLXAJ9+0J23lfpL7XOlz19XB9a
         6xeShzd/tOHichO0ZIipzqozmdEut0QuolzKN2CbfUukcfVc8unYGE6c0esYI9cPRrKa
         tv1Ywh/oyuOEDCuRnrDpsuxiZmjn277P9F0yaxAG5DDZbsDr6VXMfRYTqEUjt6Fe6M3L
         Deqg==
X-Gm-Message-State: AFuF++nmHlulv79WNQkGgvZjY9KvN9ViN4QFG3p9lPCqLe1+yVAfXaS3
	pkdH1lUrGi+mApVNaQEsdShTlwg5SY8dckbnYssMUR7jb/o85Di74QhqvPDtZgzd1KGQH/N1
X-Gm-Gg: AR+sD13FDnYIT+e3EhpFVs7mY6gDznWZ2XSsS09L3x04AyDuyg1nhLqkbRZDeIDtPG3
	L/1dLdRvbLCyLsdnzxd6E0J/okx57JzRZw95IM/1+rMFsu68QyP/dSvWLK1Tp8QwcJtPGE+W9Qh
	zyIkF0HShE31+vax41xBtD3sYYrcsQB5hH1+Eu7i7Qf/ye8b4qssunH5I2e8WikvHxxNme4SnGp
	/A3q1OFoMFALwpiDNpmAFmA+lRt78z4JRbw66KlOIgp/GAi21rttYbYy5kO7P1yWGBn/mDLFssa
	KZggzrsxQ4JFJV2o5zHq98Oq6zwDvDS7ueoQz0AnW1OMk3Z2IVB7YUe9AfYenZSWS98p2y6tkrL
	V34fNm9zP5zR34Rg6qHmbPX3cGbNLTAgPOo/R59NxoyPKZSY3uJeWF5Oy7eE4kPyIE1ViATl4F8
	mEdFAef6BzSX7DAQtHbE3/iLNMrLcRPUNkuVUy6jrACKIpuIKL+9LleeFCS36YOnU1
X-Received: by 2002:a05:6a00:13a0:b0:855:a211:6679 with SMTP id d2e1a72fcca58-85628b7d138mr6941183b3a.5.1787887776957;
        Thu, 27 Aug 2026 20:29:36 -0700 (PDT)
Received: from DESKTOPHOME.lan ([240e:3a3:9304:9820:f4a6:931b:cf31:308])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-856a3d6c845sm135770b3a.59.2026.08.27.20.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:29:36 -0700 (PDT)
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
Subject: [PATCH net v2] net: phy: air_en8811h: restore AN8811HB LED GPIO after MCU restart
Date: Fri, 28 Aug 2026 11:29:22 +0800
Message-ID: <20260828032922.469449-1-xuziyougm@gmail.com>
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
Changes in v2:
- Drop the EN8811H change, merged independently as commit 03b4702fc5e3
  ("net: phy: air_en8811h: move LED GPIO configuration to config_init").
- Apply the same fix to AN8811HB per Jakub's review.
- Rebase onto netdev/main.

Not tested on AN8811HB hardware.

v1: https://lore.kernel.org/netdev/20260820141034.1400439-1-xuziyougm@gmail.com/

---
 drivers/net/phy/air_en8811h.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 0eeb7b9a4..6ee5df63c 100644
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
@@ -1265,10 +1258,19 @@ static int an8811hb_config_init(struct phy_device *phydev)
 
 	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
 			    AIR_LED_MODE_USER_DEFINE);
-	if (ret < 0)
+	if (ret < 0) {
 		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	/* Restore LED GPIO output enables after MCU initialization. */
+	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+					  AN8811HB_GPIO_OUTPUT_345,
+					  AN8811HB_GPIO_OUTPUT_345);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int en8811h_config_init(struct phy_device *phydev)

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.43.0
