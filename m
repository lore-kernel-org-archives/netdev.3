Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8848423F
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962292; cv=none; b=o7xDIY1c87+8AqeVNlt6fqXaiupp+lMNp6cxOZ2YBFpI5JdVEGkijf/fxhXz1AD4kjcMSrJ6D1sTjiBYJGhDnI/jC8mv28VbAB73ubH7r2tIm9sX1nkV6qvT0TJDP18Llw2mdhNR4aSaou8VSy1hgHlO8nKsMkwvQ/40ZECbDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962292; c=relaxed/simple;
	bh=XAsShjY8Z5IlS5KJ3rSh157yIfXXyBkTp/ySZ5inQ1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dts2hW4OvJuns8ds2p+4cjvsQ1EhIq3RKhCVZKdIYnQrCxG2OYKwQWv5TyZLmB0lp5f2H5fe/vrINyayXgYlinLESpe9JRht43Gf1KqRagXMcof9G/KIwT8g1x2bseGLqUiO+q5sPLEKDF16MxExfWYvIS7j7Raf/81BuyDYppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hezf1WMl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hezf1WMl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a02753c04fso20481295e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962289; x=1792567089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KVXvU2y3CWgDkb2iD40+8fhR4es61+R0ZnlRm3BwJkU=;
        b=hezf1WMlQub1JgO0ymgQsQFV67TTNbyvgGmIR74Z2E2+II8b2FeOZKdEcf8GeMDTV7
         9WX2REn1H7QyhTg9ev7MBHDBuNvo1w0w+SQnnwIrPhQUFF19uCKDT6LcrA0vHoLUsIrD
         xG5pD7Z6HMgcEgT33dm7GHXLiA0g4UNJjSL+dfaVmzDS/iKlA2QzVf1MuGLqz+x7H4ZE
         girUNZjMamy5DYxYwyn55bonuQER1HhwwERpZj+W8Y1yWiFU7UZwTxXIJ2V7F7Xhsc0o
         4XS0jaCY1WzM2P5lNv8RY/dLHpGOe0Ka9xvuzSZLlsNmijkh4lb1FjElWRT3RG16P7L1
         RaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962289; x=1792567089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KVXvU2y3CWgDkb2iD40+8fhR4es61+R0ZnlRm3BwJkU=;
        b=YcvltuHBPTeNthvFGdm8Prdcr29KaHxTrU2vr/9LTP4F1GsjP9xw+rx7tIun1B62DU
         V9zPKZU5iyBfVRGhVpOBHjlx3gt/If3j3HuQ6DICJah/UBQDX+Bys4Caixtw4busmJGl
         PHqjmHwJlrYONUFgWTxIoqCUZ3Z2S+vjCQqQDeClS2CwZpUH8LN0G9bj5oKCeUnGHIba
         bZDWzaj242wCYhBUoCrbOwTPXymC7LPWHK5DlU83FjJ5SzdYBIZq10CJcjvwDf041LIX
         AthluL4Vy6q+DDb73Sl7BtRzWEuEzvrjKisS/OsGV16mv+Pk7IfcmOKdn1PsvXYdyfMH
         i/QQ==
X-Forwarded-Encrypted: i=1; AKwUvByjqHr5HB45v1RyO1LrelyYGT6tT+O80i56P7fPRT4DLT7WsB3Xq1FUI/xz4jcHXCsbAlGlrZw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyxA9pYoC7kvK/6WbS373w+LJqLg7HwysUZF47DpuKuagxGPIj
	W8czMOtjKlHPzYJwYk+1rSQtJPceNuA+P/Nt/CFwmG0KM7o34oG9bXFb
X-Gm-Gg: AYBFou36ZBxtBSUm2LVn5Pwdo1f46uTUKfye4VVM/zvH6rFDPBzA8KgoFP2cyVIBby4
	aaxxBBDj2eC4uAbhMv/T7iVtXPPbZ7MWNI/awq24eV1uTvKHULLFp7LDdJpeDNlwmm5yHB7GTQ5
	8ZGQlYgjQOV9UWBCalVtfzdtpPRHcQp+B7lVKq9ZD8ZUiKjieNDGnKjdqJxFv5Lepix4HTxCFGK
	OGk0mzU8TquhM+//jo2aXatVm+yeYu/Y+YSutSl/2I29Hz/m3rKl4DBCMSdD9oFLFxpWGN/7fF3
	zSQSDobwaJP7m/7DnJ8Z17TI8QIPVuXA/rDHTRjLjjXkLJFjd/O+iFBIHtnYsvW9YcrWgeAG5h6
	pzG6oWvcDZVpjTQ5PBSFLarmTOeo7dDMwxfSTdxNUrTxueqc3j78AJu6O83uKm9ESSWm3aAsXsA
	9zb8i24djrmh6PhskcvF1AK4rIUNU7UMEwOtAMDeYEVHqfbBrKm8e7hA80GbmOTwXEJldfJ4mdH
	EqRPayR0wCHct2ZUJm32WV6hipoI9mtV/3baEZiHdJMKgnWnTvxblTrtdJaz6HO0hDFPzXjzIMf
	LxY09uxmJjlksK1gXW7AjA==
X-Received: by 2002:a05:600c:1c07:b0:4a1:b044:9ccd with SMTP id 5b1f17b1804b1-4a1b0449d00mr79174665e9.28.1791962288754;
        Wed, 14 Oct 2026 00:18:08 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-235-252-189.retail.telecomitalia.it. [95.235.252.189])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1b35d64e4sm18756285e9.0.2026.10.14.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:18:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ahmed Naseef <naseefkm@gmail.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 3/6] net: phy: mediatek: generalize cal_cycle function for GE SoC
Date: Wed, 14 Oct 2026 09:17:34 +0200
Message-ID: <20261014071739.216345-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014071739.216345-1-ansuelsmth@gmail.com>
References: <20261014071739.216345-1-ansuelsmth@gmail.com>
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
index 2b1e9923db98..f3ce6e67eb38 100644
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
index 008efd148a2c..14370b5ce482 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.h
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.h
@@ -354,4 +354,7 @@ enum CAL_MODE {
 	SW_M
 };
 
+/* MTK GE SoC common functions */
+int mtk_cal_cycle_wait(struct phy_device *phydev);
+
 #endif /* _MTK_GE_SOC_H_ */
-- 
2.55.0

