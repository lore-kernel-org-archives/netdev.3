Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523624570D2
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920112; cv=none; b=nI/puXFk7evy29D75QEbCRcumQJV81ggAPwMNvzxuzq5kkZhlHEappPrSze1LsiCAA4Zf6oy6C4rjTR6eUEkuhbkfrlIYLQW/tyzXIfU02DxTewgaZ1uu1FwTXub00nK12HIHfZUSSQsk0TZnwE0WcM3N+69cq1QqoacQChSiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920112; c=relaxed/simple;
	bh=B5uc98kBFmHZM+0OVEG0J+KLShSMzWz6KTFb8Kw6SWE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ar8hf6KcgD0vWRP4/085azt7tpcVTGfqiUx2cS5/8SznDM60sAnESq4ctnoeTlYsmV9RP4pmmQH6MEWDFJmi4cB2CBcIAoMPpqByEefvD9uVCmXzV1Ppp5ZzA0nSw6c+kaw87tPEgsRH8xzGrkyNjaMCf2aT2NypdeoWf5Zqabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BElNSxzX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BElNSxzX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4956242332dso7156395e9.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920108; x=1785524908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j4Ic8NabspzFl1YQzO0CBvVxP+4q7RfeLVihZdCAEtA=;
        b=BElNSxzXIDuUHYriZaPvxufWgNeD5lJCJHHPnOErybPhoodqlqqTEj1F8xiKFMc/DN
         u0xt+dEW5tYvHxJxXPMK4SnDjUroa79+m/5YQLC3tVMh1o4ntCyjuH57NQIgxBh07f8J
         kZ5nDSvGOs7afI6CLJ51KoCquFrkrnvABV4wF07pgdOLNnr6eXApDs+Aeq4ywEFeFYAa
         Y6kx87dGlhZ6ZXy/NV5FvdOp4OOIs4QWpYrbjwfU+KEjyYIsCrQ1Ievra3ZOGkmx6sCu
         UGYkxLCXh9zdqIDUT5XatG3gSXzdWDunP5DHd5ENis1vaxiYNSx8vz6W5s790gwcFWxA
         2/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920108; x=1785524908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j4Ic8NabspzFl1YQzO0CBvVxP+4q7RfeLVihZdCAEtA=;
        b=e4BIZodzLlZ2OZWxvA8EIoeqVcLUu6dBdrkrmR6IdFc/RJ4zScnYpajAxUgV0KeR5M
         Gd1zsW/7DNUrInHabgoKOXjOlfX7lr3C/qgdRqFq6R/opJA/a1pyUS/lcXL+SDKaBWoR
         nHl0pFntArhv/DafAD5bG3geYsPakdV+aR731DLTCnl7aJ9CiwiLKbWJXen1rGlyPB9v
         ZWFRXRWcC0vUa4Qjv0KW/euPP47PlwUi5U7x1ZBLsr2AocH07TChTNJHcJJW78nVP2Eg
         FBssJG4arIjjIl2CvI7VpYwppVAWdpJfYrT/FdT+4BNbZ4rOo1F2hcGPm64OEVr9e45p
         78LQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7cRhTRZ/TYKAaCwuR6LZOdViwXVMcazIJVb5jTpnR2FRkN/bpKxz37kk7DfhauotCVRRBdZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qPfd2HQjtjY/WEPxsvKf8ZUCjLgpPz69Chq57tLgIXlObBEb
	2u6khA4MXUyqDCKGCprd5jokLq98OlVHSIE791YLbCtymIvpXYkzUZIu
X-Gm-Gg: AR+sD12grgT7e843e1gIHgmXCAj8f2IlZEy2di5yVQk+kk4wT2biEoBHt34sGQumPB+
	3tw3poz4eHpiEwH+jvIU/oFY2dzkoO9voqQUxJEywBx2/6RUgkRyhCMEsDR7bLvryIk63jCOmud
	ZUWVKnmp1ZPxZSN4vfsaUsfMu49LOVhLifjRpKby4HTSsrgBmomolnxQ3U6+WvrY/m+917GN4td
	0f8IXqOhyTE5nBSeqMHATuGMcXVXOn0ehNlOqF0uDerO2PFIr5AvFvV/gGHhS3lPXa4j8XlmQbB
	OZGYD3rg8yUEbrtLCAK3o1iaAo2ZsIFIwSXO0IKvCw34NrNy2YryMDWwq8AZVdNTcdC6s/aOKKk
	624DgOVqLjrZeq/jZpoRXWdPaoI4DKLVHyok9z316/M8G4g8K0nmOHeJjgFDYSJBgOhoccvg+1s
	kqFOE15J6GtXpI9QVPvLF5Bu33DvpXGVI+w2it9AGxe0m72z/1RmhLdTNaA2n6PI+k
X-Received: by 2002:a05:600c:1d23:b0:495:77e3:88ba with SMTP id 5b1f17b1804b1-49577e388c0mr81039295e9.27.1784920108360;
        Fri, 24 Jul 2026 12:08:28 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-3-249-180.retail.telecomitalia.it. [87.3.249.180])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496b4c8d6b5sm5893755e9.2.2026.07.24.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 3/6] net: phy: mediatek: generalize cal_cycle function for GE SoC
Date: Fri, 24 Jul 2026 21:08:06 +0200
Message-ID: <20260724190811.198339-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724190811.198339-1-ansuelsmth@gmail.com>
References: <20260724190811.198339-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for support of special Software Calibration for Airoha PHY,
it's needed to generalize the cal_cycle function as Airoha needs only
part of its logic (the wait logic) to complete a calibration cycle.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 32 ++++++++++++++++++---------
 drivers/net/phy/mediatek/mtk-ge-soc.h |  3 +++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index c25292f7178a..b4d73954072e 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -39,20 +39,11 @@ struct mtk_socphy_shared {
 	struct mtk_socphy_priv	priv[4];
 };
 
-/* One calibration cycle consists of:
- * 1.Set DA_CALIN_FLAG high to start calibration. Keep it high
- *   until AD_CAL_COMP is ready to output calibration result.
- * 2.Wait until DA_CAL_CLK is available.
- * 3.Fetch AD_CAL_COMP_OUT.
- */
-static int cal_cycle(struct phy_device *phydev, int devad,
-		     u32 regnum, u16 mask, u16 cal_val)
+int mtk_cal_cycle_wait(struct phy_device *phydev)
 {
 	int reg_val;
 	int ret;
 
-	phy_modify_mmd(phydev, devad, regnum,
-		       mask, cal_val);
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CALIN,
 			 MTK_PHY_DA_CALIN_FLAG);
 
@@ -71,7 +62,26 @@ static int cal_cycle(struct phy_device *phydev, int devad,
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP);
 	if (ret < 0)
 		return ret;
-	ret = FIELD_GET(MTK_PHY_AD_CAL_COMP_OUT_MASK, ret);
+
+	return FIELD_GET(MTK_PHY_AD_CAL_COMP_OUT_MASK, ret);
+}
+EXPORT_SYMBOL_GPL(mtk_cal_cycle_wait);
+
+/* One calibration cycle consists of:
+ * 1.Set DA_CALIN_FLAG high to start calibration. Keep it high
+ *   until AD_CAL_COMP is ready to output calibration result.
+ * 2.Wait until DA_CAL_CLK is available.
+ * 3.Fetch AD_CAL_COMP_OUT.
+ */
+static int cal_cycle(struct phy_device *phydev, int devad,
+		     u32 regnum, u16 mask, u16 cal_val)
+{
+	int ret;
+
+	phy_modify_mmd(phydev, devad, regnum,
+		       mask, cal_val);
+
+	ret = mtk_cal_cycle_wait(phydev);
 	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
 
 	return ret;
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.h b/drivers/net/phy/mediatek/mtk-ge-soc.h
index 349dfbdff1fa..9aaa7e3caa41 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.h
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.h
@@ -345,4 +345,7 @@ enum CAL_MODE {
 	SW_M
 };
 
+/* MTK GE SoC common functions */
+int mtk_cal_cycle_wait(struct phy_device *phydev);
+
 #endif /* _MTK_GE_SOC_H_ */
-- 
2.53.0

