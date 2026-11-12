Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511469;
	b=kn3ha34yceKiA6lVf1nUlgAbxZrhbc4Fix2UgEkT8jhqZzhvl0CkbyHxuvy58DOy/GLx
	 g4QIlSsNsuIzAUKVxnhJ9DiIH+5dzCd5uP6PNH/zYWgvqE1ametN+JiP+xQ03TMnG+qaq
	 sXbpm62I1+PA2O1hOXkILfJmqHH/FcWK21SeTbuBfV5kJ4kClF0NRMctt5t6kXtKaUFfJ
	 GROWa25oD2fyuXwYSiJnyQ+z+5c2bPly6GxwVuu9qvJ8nvVRYopflo6jMn/hSs/NzEPB5
	 J05MHYGmuGtaB1f8dK57Unpkng7xOT7XDnp+DiVPqLPK3UlL3J3jGA/FFeJgfc311Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KWis15C9gwyKxX/AadJ47/KSQbDmZvxNeSEcthxvKXs=;
	b=3PFOrJBZEbYLXX/yMod/jGbBab8yx9mrZrMF5sSHAgYlkw/0aFUEwidvgWTa7Yy+l0WD
	 5u3n0D/pANV2hXgSI38PpFW9ETao7CDzs6EvbpnE9vLeRTT8mcZ3WIJxB8XNRDBNeKQF3
	 tYX4+l+b3oImSFXeRuTM1oQQ8ZGoz3PFsrTh8L1LkPm/bZPtuf3adFjyaa73S9Di0b72a
	 TcPmmEaY8O0++DDZRujX2UULjAzEuLAaC9Rw86o+FGXz576LNShw/2enKoQJ4OThHGJUA
	 30zgFp9nGhdIos/AXPYIWQETW04D43LUj0g04/hYmvjkFewSFt8sqYWKSQEuXrFiiPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EapjoZXw;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F380606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F380606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EapjoZXw
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c10dc41270so185177e87.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794511467; x=1795116267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWis15C9gwyKxX/AadJ47/KSQbDmZvxNeSEcthxvKXs=;
        b=EapjoZXw1zrssn0UTql3WJ/Q6T+GwNyZfusCoGnM48XKFO6V6L5phme3JDut7g5DeF
         74XnfR+3ZWJ7WnOeBbCXnToCC2E6X5pQ9CD6ew9q+Dkkllt9CBRK5jFYnM+6K9wAaxi1
         YwnJ7GnJs+LbRcX/O3e9YPlJGkDDs22UIwF6w2n/hgJg4oXZCedilcP1Fqdgy4b/M/jx
         cbPl+k/hb7Ui7PLx8ZXgzlC8sY2HWGerke/VvoHGueXWZdKXtvAO1P3Kxlqm4Un4AEYh
         IdaVxN9kZY2G6VcoR5ad3P5frQ4FGt0u1mvG7g3imcsq2OpOG6a89JCDNjvNAgaFraom
         28WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511467; x=1795116267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWis15C9gwyKxX/AadJ47/KSQbDmZvxNeSEcthxvKXs=;
        b=QcduU/9V8fb/AVqH3mKoU0XwE6BYVgrybYLBNj9Syh41yWij0WRCKM5TFSsKLxcLzh
         tZYbVtt5vkodcTPGu/uUXMdgWhXFyBpQL6iVBLQ2E2Ut+yUaObZEPSQI+qGt0QgFsmst
         6wOnLTtUjFa1hdv+0sJluPttLMLk/oqLDtBwPxoYcZQyLKd395FkETOHUac46qvsmMJ+
         /ibPzub59AbWWy8bEGL6sVfiCAj4Nv45EaD1ouLfrVtts+HMlTl13EuzVXQZlMbeBUvc
         OjwMD+81WALnkPWrcgHbQQvLe6MVel5BfCGzbOgzTf9euU+ufdMXIx6nAcyH6/nSbD6U
         e1pQ==
X-Gm-Message-State: APuU4Z9Td9pXPt2TOU9vj8o2e0dQFKroAYBmagvQ6Kbbt5KLWsjQP0EH
	PCkM777P1MYNvXkDekopr4dHbaBoE92WBXYav/vcTXkuSZpPQ9gwv+mT9hk3BL3C
X-Gm-Gg: AYBFou1QEO/B+J6si46Tb2tnlHHI1Ef1aBOKd4vHGOCBb8htJw5tY1yK2CTEq7hG3vA
	DH8JzfZU3wwPCF8YCL/LER0eRS1Tw/zGSFNhTttU+exncMeLd+u+DrIPGUQ2L8brCHUuq6h58EP
	SpungkQfP1wySIK6JtpGjyk2uJ2acHl1YmkO3LblkG2SQ68Dtju5gjuGpJbvpFkHh2WSoIcFbOk
	IqeHfAoePW2antDDPEeyG58TRvcR4EL1bdmSe7EPNKtxLAkCD4np70o+UFyzYPveIHdPGgIJ8oW
	XN+t6/cbzQX4h5+uiEEwXRWMCRVywpCxKtkLkwIJf2LDZQfIVxyVmYVqggck0PIRdhm0jpxh73y
	npB6Ofj3AeKgnUoiDO7kE5oyZn90Ulwuz9bhaSs/1WbfzVDntSQdpThkFGg6OQJLtVZ9ROZPJVq
	h6DE93vKnMesREwV5qpTQ45Tm0oL+tklJKlSWlPGf70D4Nfp9zGLN6YJBjtDH3fvlFcRsORnRe0
	a5mAEWckDDD1XrTWGGHw9t+TqiSRZai5X+Rl2M3c9Yl4xqNf+g+1z3bDRDdJZRbf9/S0KTHM96f
	0tbL6T6d5tbrViOF7WChDPAXbBzwKHGWuyfQ1HOKFcctFI5ODbGcfJUx3z2kF3zNZWI3MV3H9wP
	wB0g7fPQypz/utmMa8c0w0x2PWArakWQlwMS37QVO6JQ93+SnPcmhRSvicR4=
X-Received: by 2002:a05:6512:31d0:b0:5bf:a6e9:4cf with SMTP id 2adb3069b0e04-5c170a092e0mr142032e87.41.1794511466966;
        Thu, 12 Nov 2026 11:24:26 -0800 (PST)
Received: from qblck ([188.130.155.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17135658csm28510e87.69.2026.11.12.11.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:24:26 -0800 (PST)
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
To: netdev@vger.kernel.org
Cc: kmehltretter@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Artemii Mashanov <ralerrdirsardx@gmail.com>
Subject: [RFC net-next] net: phy: realtek: track clock state across suspend and resume
Date: Thu, 12 Nov 2026 22:24:08 +0300
Message-ID: <20261112192408.24771-1-ralerrdirsardx@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The RTL821x PHY driver obtains an enabled clock during probe and
disables it during suspend. However, phylib may invoke resume
without a preceding suspend, causing an unbalanced clock enable.

The current resume path also ignores clk_prepare_enable() errors
and fails to balance clock enables when subsequent operations fail.

Track clock state explicitly, use a managed cleanup action, and
avoid redundant clock enables. Propagate clock enable failures
and undo enables acquired during unsuccessful resume attempts.

The change was compiled for x86_64 and checked with Smatch and
checkpatch.pl

Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 55 ++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 4927ee838..4adcdbe16 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -351,6 +351,7 @@ struct rtl821x_priv {
 	bool enable_rxc_ssc;
 	bool enable_sysclk_ssc;
 	struct clk *clk;
+	bool clk_enabled;
 	/* rtl8211f */
 	u16 iner;
 };
@@ -732,20 +733,41 @@ static int rtl8261x_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static void rtl821x_clk_disable(void *data)
+{
+	struct rtl821x_priv *priv = data;
+
+	if (!priv->clk_enabled)
+		return;
+
+	clk_disable_unprepare(priv->clk);
+	priv->clk_enabled = false;
+}
+
 static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct rtl821x_priv *priv;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->clk = devm_clk_get_optional_enabled(dev, NULL);
+	priv->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(priv->clk))
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get phy clock\n");
 
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable phy clock\n");
+
+	priv->clk_enabled = true;
+	ret = devm_add_action_or_reset(dev, rtl821x_clk_disable, priv);
+	if (ret)
+		return ret;
+
 	priv->enable_aldps = of_property_read_bool(dev->of_node,
 						   "realtek,aldps-enable");
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
@@ -1333,7 +1355,7 @@ static int rtl821x_suspend(struct phy_device *phydev)
 		if (ret)
 			return ret;
 
-		clk_disable_unprepare(priv->clk);
+		rtl821x_clk_disable(priv);
 	}
 
 	return ret;
@@ -1388,23 +1410,39 @@ static int rtl8211f_suspend(struct phy_device *phydev)
 static int rtl821x_resume(struct phy_device *phydev)
 {
 	struct rtl821x_priv *priv = phydev->priv;
+	bool clk_reenabled = false;
 	int ret;
 
-	if (!phydev->wol_enabled)
-		clk_prepare_enable(priv->clk);
+	if (!priv->clk_enabled) {
+		ret = clk_prepare_enable(priv->clk);
+		if (ret)
+			return ret;
+		priv->clk_enabled = true;
+		clk_reenabled = true;
+	}
 
 	ret = genphy_resume(phydev);
 	if (ret < 0)
-		return ret;
+		goto err_disable_clk;
 
 	msleep(20);
 
-	return rtl8211f_config_rgmii_delay(phydev);
+	ret = rtl8211f_config_rgmii_delay(phydev);
+	if (ret < 0)
+		goto err_disable_clk;
+
+	return 0;
+
+err_disable_clk:
+	if (clk_reenabled)
+		rtl821x_clk_disable(priv);
+	return ret;
 }
 
 static int rtl8211f_resume(struct phy_device *phydev)
 {
 	struct rtl821x_priv *priv = phydev->priv;
+	bool clk_was_enabled = priv->clk_enabled;
 	int ret;
 
 	ret = rtl821x_resume(phydev);
@@ -1414,8 +1452,11 @@ static int rtl8211f_resume(struct phy_device *phydev)
 	/* If the device was programmed for a PME event, restore the interrupt
 	 * enable so phylib can receive link state interrupts.
 	 */
-	if (device_may_wakeup(&phydev->mdio.dev))
+	if (device_may_wakeup(&phydev->mdio.dev)) {
 		ret = phy_write_paged(phydev, 0xa42, RTL821x_INER, priv->iner);
+		if (ret < 0 && !clk_was_enabled)
+			rtl821x_clk_disable(priv);
+	}
 
 	return ret;
 }
-- 
2.56.0

