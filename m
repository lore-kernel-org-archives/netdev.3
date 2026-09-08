Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB075581E0
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879158; cv=none; b=u2p2DtGyZBIzXz1eXcN4vTZCIlI7y93f/Y1xe9n9OqQnOBokFkNflFVrFcs1iCl9BLgRuibkNkGntA7VTErGTlRijmFeE60g6wQAggtc/5jtnP6oQ5Y4J3tzPeIa7gnV1+41skPA55RF7lxsW4DYO5ELTnnH+xJJzfrqLa7F40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879158; c=relaxed/simple;
	bh=4WAg6LcX24a7qSuqahhS14LF7mLL6eBCnJ8iXgc0XHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rh4hJS+gpz9y/EGZq9P4ljR5qIDsMnQj0+nKci17FEKDg9unS3Kv4+GDV3Kr+rEAMMYccrszDp/haivmzDsEuJPOWipYcncivUdreXB80N7iAEfT85GP0x1Ym5DT/qqsyeV+mQMudfYO8j38vB/0+nUJYQUEqVEmdpm2bOAbe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVyfaTqz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVyfaTqz"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b4ab0e4da6so4658887e87.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788879147; x=1789483947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rZY078INwnXidXnS1tAhSBI29huMveMJ63auEB3fPKc=;
        b=OVyfaTqzQl2FWJpqqMmALQbsEYueECQOy4bPFndf3XlkQvHKyDeS8YLJZlG6ZJ5CTY
         mcjRQpVo75XXzjpctAlDChUAY4AcN4oBcEl09M/Tfo/cInIMT8ZenfLjhlI2Lv7YvPR+
         heq6sW6kPUO5dEgz1aSe8Twvj8AH4HeYh83CkhoO51djTIuaQr0PDApPx4AFXK58Ivcb
         biXV2Ca/LhcP4+6d81+1ie8a31L068wml+0Y8yNEprQsxrA3H1AgjcrC6fbLGxbK8b+n
         QuvyFImtIuOENgdCJhCEb0KpzHsXZF+NgkBLtV0Crkey5Gd5M5wvYQbzIxrU3uS63KcI
         8VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788879147; x=1789483947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZY078INwnXidXnS1tAhSBI29huMveMJ63auEB3fPKc=;
        b=GaBkaqKwwR+hBdxbfpROmI+2IWl99+VBQsW7Zovc0eWks8BOZkJ1OhuNn/p9Bhr2ID
         17YspYfU9bpoclUa0XksqFdgisJMubsxYHJpvHI/hQsyoR1kRYxvVJWdFDP/J1iPi58d
         7bFx5l69ICMAwDvsfJb7k4c1NGZags/gq4h28ZA7rN+6rLwCam7oRC+Sp/VP9LG2iTA7
         99AGwLDUffVJrZ56HW9CHwkqANw386NtZIt++ZvgTrGwr/++1G90SyXSW1004BZnziCO
         TEp2BFOBGjiTgh8R8183tgSKcpz2jHs3smQU6aKPlQKk4VBIj178694vjG6hD176Y04L
         BWHg==
X-Gm-Message-State: AFuF++nERiGN7qbzvh3RemYU+XfFQLpdZdStMvgQJY4h1pCEi7hRFKiA
	VJcyGVveIz8t8PccMSkeMkR5LTbJYQRvLnqkwcHD+0crTLm1iePn+Bb+eXFb/ricPFC8
X-Gm-Gg: AYBFou1sMi2Ozfu3+eTJEPeNS/nN0gEmpIcas8Gua3ANHWFTpVI+Q8Zqlj4l0a1d6ND
	I6L350L1JHzrCWXN33gRUaAAolqoLsSlxBbPQ/4BRSw4ZvzgwLJV6S/I/5yWVQEhaf2/L5pTUkJ
	0vooefkl4R6j3CgUn88le2y1EAEEXzZG8JR08xwh9E1YL+kAx0Pmj30Ix8vA17qiN4Px3+NSerl
	5OyDdliOLSJoucAG0osGPtRVwKNB5VC3DIUH8fmlqoc53THrbBBWWyLlESi0Jyo7TI32d706cPr
	en68JR5/oEjZYIe7QxmJ6HT1s9e6y0S6Q7bXD0qq3ypc4+5Ou9CD/NnHyB6y6vtKZLqRqamH2H2
	MSsATdHzTROwczjH4Mny/ZxVUPC/1Xi31eMpxeePjCwlgCVXGm0cddKqF6qGUeKvSRLubS54ve8
	fga37byfikycf+Qhx12lRt7HzXry4K1jKYms5tH9wf6pyN3pTQDD0iFM/NMaGG2/ueUgDvpy+yV
	U59eGmmmjVmpyYtIoWsqh9a8XZLR+4/fWWCSj/KNrJGg6QgA4k=
X-Received: by 2002:a05:6512:130b:b0:5b6:183c:5c90 with SMTP id 2adb3069b0e04-5b6183c5d6amr4728496e87.46.1788879146726;
        Tue, 08 Sep 2026 07:52:26 -0700 (PDT)
Received: from i-UX410UAR.lan (broadband-95-84-141-211.ip.moscow.rt.ru. [95.84.141.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166ecf24sm3215891e87.16.2026.09.08.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:52:24 -0700 (PDT)
From: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	SkyLake.Huang@mediatek.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	arinc.unal@arinc9.com,
	sean.wang@mediatek.com,
	olteanv@gmail.com,
	yangshiji66@outlook.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Subject: [PATCH net v4] net: phy: mediatek-ge: disable EEE on the MT7530 PHY
Date: Tue,  8 Sep 2026 17:52:13 +0300
Message-ID: <20260908145213.3976508-1-vladislav.karmanov.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT7530 internal GE PHY advertises EEE by hardware default, but its
EEE support is defective: with EEE advertised, some link partners fail
to establish a stable link. On a 2-pair (4-wire) cable where both ends
advertise gigabit, 1000BASE-T training cannot succeed, and instead of
falling back to 100 Mbps the port loops, so no link or DHCP lease is
ever obtained. MediaTek confirms the hardware is the root cause (Landen
Chao, 2021): "EEE of the 10-year-old MT7530 internal gephy has many IOT
problems, so it is recommended to disable its EEE."

mtk_gephy_config_init() used to clear the EEE advertisement early, but
commit af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE
advertisement") removed that on the rationale that the DSA subdriver
already performs an early disable. That holds for MT7531, whose
mt7531_setup() clears MDIO_AN_EEE_ADV on each switch PHY, but not for
the MT7530 PHY: neither the MT7621 integrated switch nor the dedicated
MT7530 IC ever had such a loop, so removing it left those boards
without any working early EEE disable and the link flapping came back.

Since the broken hardware is the PHY, fix it in the PHY driver so it
covers all users of this PHY, integrated in a switch or standalone:

  - clear MDIO_AN_EEE_ADV in probe(), as early as possible, before
    anything can negotiate EEE with the link partner;
  - clear it again in config_init() and call phy_disable_eee() there.
    config_init() is what phy_init_hw() replays after a PHY reset, when
    the register is back at its EEE-advertising hardware default, and
    it runs after of_set_phy_eee_broken() in phy_probe(), so the
    eee_disabled_modes mask survives and neither phylib nor userspace
    can re-enable EEE. dp83867 disables broken EEE from config_init()
    the same way.

Auto-negotiation then falls back to a stable 100 Mbps link instead of
looping at gigabit. Tested on ASUS RT-AX53U (MT7621): with a 2-pair
cable on the WAN port, a single clean 100 Mbps link comes up and a
DHCP lease is obtained, where the unpatched driver loops.

Fixes: af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE advertisement")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
---
Changes in v4 (addressing the sashiko review of v3):

- phy_disable_eee() called from probe() was undone later in the same
  phy_probe() flow for PHYs with an of_node: of_set_phy_eee_broken()
  zeroes eee_disabled_modes after ->probe has already run, leaving
  userspace able to re-enable EEE through ethtool.
- The probe()-time MDIO_AN_EEE_ADV clear was not replayed by
  phy_init_hw() after a PHY reset, leaving the register at its
  EEE-advertising hardware default.
- Keep the probe()-time advertisement clear -- it also feeds an empty
  advertisement back into genphy_c45_read_eee_adv() during phy_probe()
  -- and move the durable disable to config_init(), which runs after
  of_set_phy_eee_broken() and is the callback phy_init_hw() replays
  after resets. This is the placement dp83867 uses for the same kind
  of quirk.
- The Reviewed-by/Acked-by given for v3 are not carried over: the
  placement is what changed, so they need a fresh look.

v3: https://lore.kernel.org/netdev/20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com/
v2: https://lore.kernel.org/netdev/20260820202844.1821687-1-vladislav.karmanov.dev@gmail.com/
v1: https://lore.kernel.org/netdev/20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com/

 drivers/net/phy/mediatek/mtk-ge.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 73d9b72..96d8ac5 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -62,10 +62,38 @@ static void mtk_gephy_config_init(struct phy_device *phydev)
 		       FIELD_PREP(MTK_MCC_NEARECHO_OFFSET_MASK, 0x3));
 }
 
+static int mt7530_phy_probe(struct phy_device *phydev)
+{
+	/* The MT7530 internal GE PHY has broken EEE: with EEE advertised,
+	 * some link partners fail to establish a stable link (on a 2-pair
+	 * cable, 1000BASE-T training fails and the port loops instead of
+	 * falling back). MediaTek recommends disabling EEE on this PHY.
+	 * Clear the advertisement as early as possible, before anything
+	 * can negotiate EEE with the link partner.
+	 */
+	return phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
+}
+
 static int mt7530_phy_config_init(struct phy_device *phydev)
 {
+	int ret;
+
 	mtk_gephy_config_init(phydev);
 
+	/* The probe() clear alone is not durable: phy_init_hw() replays only
+	 * ->config_init after a PHY reset, with the register back at its
+	 * EEE-advertising hardware default, and phy_probe() zeroes
+	 * eee_disabled_modes (of_set_phy_eee_broken()) after ->probe already
+	 * ran. Clear the advertisement again and mark EEE disabled, so that
+	 * neither phylib nor userspace can re-enable it; dp83867 disables
+	 * broken EEE from config_init() the same way.
+	 */
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
+	if (ret)
+		return ret;
+
+	phy_disable_eee(phydev);
+
 	/* Increase post_update_timer */
 	phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_3,
 			MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG11, 0x4b);
@@ -100,6 +128,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
 		.name		= "MediaTek MT7530 PHY",
+		.probe		= mt7530_phy_probe,
 		.config_init	= mt7530_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
-- 
2.43.0
