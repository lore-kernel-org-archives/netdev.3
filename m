Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A0502778
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633256; cv=none; b=HQsSEiMGUIteJU26o2AIjRFKz0zEFixvridHFHcgYKNKgnkGVIk0hnE9v1LHZPHBG2twiymjOKRnKcVEWHVrtC5R7X0lUYzRUhhK9JBTBoiGiX6stzO11M+91bbZKR4cBLOMC51lwV1IA8R/aqS9O9lxJSW+sv0NaaSWh1SeDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633256; c=relaxed/simple;
	bh=Ot/8R66e/mkPVx670tudpj7xs96d6ihMr8n1GprTSKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSdGH4pTrXa+9Kxn1BjMDqizFg9AItZCyAcc8MYnWkVLhDH9DHaHorCRRG7hJmX6N1mm1DfqQ2MW+zHqFvAPrPkXf8awcginwqkIxK+eBYPVaMjeLMWR6Tua6T7kCk1jwwW/EeHZ9hLaTw7J77wJCkzmPO9/5SfJSvHQdXuanac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMgOZV27; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMgOZV27"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a4fbc5586so550343866b.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633252; x=1791238052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pO83qbmBUiFGt2TePIWrrliB13OXaWfE2B6nEGDhy3A=;
        b=VMgOZV273ujEOTho9QT7k8DCW4jLLHGlN61TamKFUCzMrEWcUoXHcYxcbZ4cucQDI2
         /9udYfDI84R63cFIs8b72H8UyEQrcJAmiOpBvjaXmqSBmlE6zhPvHkfrVGV2URZm7kHK
         HQ5KiiiHJawAE4UzJy1OS4QmMxdvwPVs1OlrRjv6ng27rTc899KeEo3zIRgXSj1GULhA
         5JqTiY2UWCuRDO7tWcMrYk9RE7I2r/SwCMRXGM5qmrGz+jzVyuI48crddFn2zD59ktpi
         OL2U8xH4LiFxtD1G4WvjWaJzCBi2f4iF75k6t4KavmzaeR5TK4VX2oBHimlat2tQpS7H
         oXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633252; x=1791238052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pO83qbmBUiFGt2TePIWrrliB13OXaWfE2B6nEGDhy3A=;
        b=ooMpNkYFtmNEQCGsxH0o8hyrkdXXOplw5xsyb4KKcjTAtCE8we+SqZhcyPpV7Hjdgy
         R0fW8lyes5wL0cj/wxCl5z/Q8/NM7KrU6cPEPFUsS5Jr+KoPYwk1zs8TUB8cY1WYfhvA
         yIe56MIYW7/60zTmZgSlTcDD/kvh0KhfhAZLWFM4eUffq+R2zft8X0/9NfWNiKQtNkAo
         WqY1q2LCalFdO7IoK/NBuS+J9+v+O7j4zZH4FL1JvcYKxzSyYNdGSks35Nl4xgHHY/wg
         HXTpj8ZiULzqNPiGMbuJzuPUfrEt/PG8ZLaapYX5r6kpOELTn1DScp0YwvN1CUNFovlM
         hgzA==
X-Gm-Message-State: AFuF++mxexpbSb8Yqr9BLhnH9o0PfEYcZ3LRLgaA1CvY5ANf26wWXR7z
	4FkoSFwe6o8+n215ZoFElBoxvUC6eXyr6SdvqvaYTmcm++I2+5Uau3QM
X-Gm-Gg: AYBFou2HHxSuiQ4OOGMnX0pB57tOszgaeOI2ryty9awCgWn87jJnlLjPWZQekCWzm3j
	qZk7WEN2jWND2FUXSPISS53JWxJyWdUjFTr9TCC39OQSPu2PpES3N7cWKLWyuze9Q2D02uWfq5A
	bf/tdsoGQWejTsFa3O4SLGnWxf3K9r+yyECiSAl2oZGNpvbW8OYpUhokBVokdTb4fM3wzqNp+fo
	FQB8aKXP6g8OyW26Y8PCuPLpJO3QV6UwRIWSOynN3KYr6Gi/LEDUJeYVHbXflv8anRl2roy7kH5
	FV+OyfAaNSN4EaW1HzC0LBNP9zw5Ojo2FgaPKF6s+0qcp4SZyo2zvT6WiKREnqr4LGPwk6zEzQv
	5hOG8YapXIuI01XegaITGRpDc9xxSqH0N6KqL5B2nYZ9lLD+68ajnVMdcdN4dIRmXljXbDjfCaZ
	xctX1K8IMYOOkKnAT5l1LDgQpBZ/MaY34JSFQNeogNLbPuKkbDjrSI0enExsDn9zjwUPXyrFLZ3
	AyqDzg5XRZhXvPqHYJAoqBRQ8t4yrwkwW9sQJDqZAcXwuKbR8pTGOJG
X-Received: by 2002:a17:907:3e87:b0:c29:f5d8:9c78 with SMTP id a640c23a62f3a-c2ac229ee9cmr1188419966b.39.1790633251888;
        Mon, 28 Sep 2026 15:07:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm540308966b.33.2026.09.28.15.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:07:31 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	George Moussalem <george.moussalem@outlook.com>,
	Ziyang Huang <hzyitc@outlook.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: phy: qcom: at803x: Fix IPQ5018 short-cable DAC values
Date: Tue, 29 Sep 2026 00:07:16 +0200
Message-ID: <20260928220717.939-2-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260928220717.939-1-yongzhao.derek@gmail.com>
References: <20260928220717.939-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "qcom,dac-preset-short-cable" is set, ipq5018_config_init()
programs the MDAC (MMD1 0x8100) and EDAC (debug 0x4380) fields. Both
fields occupy bits 15:8 (IPQ5018_PHY_DAC_MASK), but the value 0x10 is
passed unshifted as the set argument of phy_modify_mmd() and
at803x_debug_reg_mask(). Neither helper shifts or masks that argument,
so both fields are cleared to 0x00 instead of being set to 0x10, and
bit 4 of the low byte, which is outside the field, is set.

Use FIELD_PREP() to place the value in the field. This matches the
vendor SDK, which clears bits 15:8 and ORs in the value shifted left
by 8.

On a Redmi AX5400 board, where the IPQ5018 internal PHY connects to a
QCA8337 switch PHY without a cable, MDAC and EDAC read 0x6868 and
0x7800 before the write. With this change they read back 0x1068 and
0x1000, with the low byte preserved. Without it, the same writes would
leave 0x0078 and 0x0010.

No in-tree DTS sets this property yet, but it is documented in
qca,ar803x.yaml and used by several IPQ5018 boards in OpenWrt.

Fixes: d46502279a11 ("net: phy: qcom: at803x: Add Qualcomm IPQ5018 Internal PHY support")
Suggested-by: Ziyang Huang <hzyitc@outlook.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
 drivers/net/phy/qcom/at803x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 6872dbf7785..cacbadf1f48 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -1051,11 +1051,15 @@ static int ipq5018_config_init(struct phy_device *phydev)
 	if (priv->set_short_cable_dac) {
 		/* setting MDAC (Multi-level Digital-to-Analog Converter) in MMD1 */
 		phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, IPQ5018_PHY_MMD1_MDAC,
-			       IPQ5018_PHY_DAC_MASK, IPQ5018_PHY_MMD1_MDAC_VAL);
+			       IPQ5018_PHY_DAC_MASK,
+			       FIELD_PREP(IPQ5018_PHY_DAC_MASK,
+					  IPQ5018_PHY_MMD1_MDAC_VAL));
 
 		/* setting EDAC (Error-detection and Correction) in debug register */
 		at803x_debug_reg_mask(phydev, IPQ5018_PHY_DEBUG_EDAC,
-				      IPQ5018_PHY_DAC_MASK, IPQ5018_PHY_DEBUG_EDAC_VAL);
+				      IPQ5018_PHY_DAC_MASK,
+				      FIELD_PREP(IPQ5018_PHY_DAC_MASK,
+						 IPQ5018_PHY_DEBUG_EDAC_VAL));
 	}
 
 	return 0;

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.43.0

