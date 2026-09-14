Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56C3876A7
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421055; cv=none; b=t/oTKP2TK5BwdF4F9B/91zKHloKrWTCAwbG7vT6FHMbdF+WPnqaWqP0djOKRk9OkhSWMn4pCG951cfqfz5L4/E1GQjttVkIiUzAxEHwKOVG+Lr2aOtT/Mp/8vOnNjefBdoOjoUra0iiRki/EzHJNtKFaHehQayLS8qN0rFDBbzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421055; c=relaxed/simple;
	bh=lbLxqTslHY5Xz5ryYX0WcyX1dKos3wDAdzbFLDTheuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBtd7LfqQt/X5avzQgcgyeumgdHWVzR9FkAZC/nWfSuEWzb1dAIMUqbhb9febL4MtNKT1xHMwWCuKT7e44bsPhewByerehMv8mhsQZqn1wBvOw5nqNE3A1IAnxAd8Ydd9bWhjRy+e6TIxh/QTAZwEA8Ki4C+00pKligBA484Wzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1L1fAt5; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1L1fAt5"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so2001189b3a.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789421052; x=1790025852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=91Cem4/G9gFH2+/WU26dVxIdOZc4tVrgEbxFE9sY/B4=;
        b=O1L1fAt5i6hBbvwSfXmdt10LPQQUDLuDDm9x6347mz7Kxw1SufI29LuguQdG043puT
         vM3NlFxyWmzmvjVkYn0Q3Fc0AsiAaxxP6uSFJhmwl+RuTyJF7+pItZUak6a9Dl4RNhva
         oUWXupM8o7iCVSGGgsR+wC/ct/k2pVAWZifuSbfZN7qEHWyYKbPcFKIyJOie76i/wj5+
         K2RCtKVokfecpfTyOShkMQkAPT2rGjTBSHbiPaWxRDIanUiIhn0xs+rIG3Y+6cseDKFo
         Iiayi1zjFQZBpcd3PhPvBP5y5I42ilr0C2x78NaGuVPaMexCj8MAU9ozfGZzZ/DhJHCG
         O9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789421052; x=1790025852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=91Cem4/G9gFH2+/WU26dVxIdOZc4tVrgEbxFE9sY/B4=;
        b=a1aWx6Uh+x3O0Qc3V30YeewrIz6PAP+7ldH2EvLPhBK1FKmyAoNA5HoHXa/Dx15jTV
         fJ5MP574O3nqemH3/ESR+WYkoMqpGEK1sBDsJCoihy6gHjMP+OHW2Fe/DyuBImCFopGS
         /c2I3nwGZgeD/pMWlMYoSSuz2VbHoW1pOvYsjQQJ4sk2EjfJq80LhMjkUCa06gCEhruj
         1E6dn0OB5QUu7Qzx+f/T7ID6KTN6YiAU7szhsO1T6a9WodGHemit9B31WDgFwWWhfes7
         UaJiIi9AEF72GvEIGkw1fUvNaJ5RTIXW2aVRd/iiirAcMl0ilzNNbgF39S+8QDCIundR
         8V7A==
X-Gm-Message-State: AFuF++mn/ztKG31j4q3IDPrKwc7PBJromsogQOducNRek3FUvQR031D2
	5ihAfxtpDsr9yvGucgu9EOuiGlbdUvgdvhWz/zF4nYj1za0Nluz51juQbpi15A==
X-Gm-Gg: AYBFou0ijD+dkzLk+bxhUPLEtziG3sorhV+O4NDw1L5WNg9Z8CVF0pwQ5OBjl0Wb8SB
	eFebgUzem8pfliv+uZ5vrKjqFxIAnpBSmv28XQ5FlqpygIMY8X9OyxqJDa1ACqlN0OoyrC3RuZ4
	oWIJo2LA7QsI4FbSLDcBgzoQ+9sw6wdULlpu5Efh8gIstvYJpQWBOdMVfJZo9CcFAhiMvay+QVk
	5DzxBZEXLERt57PeO9FgS+SdqTct+44cX5H27fe/+fdwfzEGAJ8R3mfxRKO3uNthDgAPbmF8QUu
	bEVY3SRbNy9vvFrQUZmqUZ9R/5SFB2zE7iNyzjAnr3D310+FFv2mxGNDqgqY19GkaFS6z0U/Q2T
	cn+uTbl/vBq73dplqSx6tmL8dLFZUNFroVt961NBPQsLCD5a5E/kh14pPLmz06mKhQkc7wklE0s
	rtjMwp3DHWaHWpZ9i+sYy8kYppdvOYffk9xsXvWPlrK1DFPjHqIA+VwOj0/dFDllsB4wyy8gyEv
	6dO7tQ4fDK29dVIgLzvoF2wb8xIeQ8WZ40RggtFEU26qMiu52QX0PaQz8FEInfk1WMbqLjiAtI5
	8DFQGZ8J77/30mujWEwBOMXKDfpSnaUYVUPlPcFqtZWQvAe3OqwbFTRrMvM=
X-Received: by 2002:a05:6a00:1828:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-86f83152fcdmr9002280b3a.4.1789421051724;
        Mon, 14 Sep 2026 14:24:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b287c1b25sm5400379b3a.20.2026.09.14.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:24:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net] net: phy: marvell: undo WoL setup when Wake-on-LAN is disabled
Date: Mon, 14 Sep 2026 14:24:09 -0700
Message-ID: <20260914212409.74539-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fully disabling Wake-on-LAN on the 88E1318S/88E1510 used to leave
the WoL interrupt enable bit (CSIER.WOL_EIE) set and LED[2]
configured as the INTn pin. A magic packet arriving after "wol d"
would still assert INTn, and a later "wol g" re-enabled WoL from a
dirty register state.

Fully disabling WoL clears CSIER.WOL_EIE on the copper page. The
LED[2]/INTn pin mux is disposed of only when this driver forced it to
the INTn function: the INTn enable and polarity bits read at arming
time are saved, and restored once all WoL options are cleared, so PHYs
serving the MAC interrupt, strap configs, or marvell,reg-init values
are never touched. The FORCE_INT bit is not set while disposing of the
pin: it holds the interrupt line asserted and turns the shared PHY
interrupt into a "nobody cared" IRQ storm when the PHY interrupt is in
use.

Fixes: 3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move to net with Fixes. Address phy_interrupt_is_valid issue.
 drivers/net/phy/marvell.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..64862f12eb42 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -354,6 +354,8 @@ struct marvell_priv {
 	u32 step;
 	s8 pair;
 	u8 vct_phase;
+	u16 wol_led_tcr;
+	bool wol_led_armed;
 };
 
 static int marvell_read_page(struct phy_device *phydev)
@@ -1969,6 +1971,7 @@ static void m88e1318_get_wol(struct phy_device *phydev,
 static int m88e1318_set_wol(struct phy_device *phydev,
 			    struct ethtool_wolinfo *wol)
 {
+	struct marvell_priv *priv = phydev->priv;
 	int err = 0, oldpage;
 
 	oldpage = phy_save_page(phydev);
@@ -2000,6 +2003,22 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 		if (err < 0)
 			goto error;
 
+		/* Remember the LED[2]/INTn mux before forcing the pin to
+		 * INTn, so it can be restored when WoL is disabled again.
+		 * Only save it once, or a re-enable would overwrite the
+		 * value read before WoL was first armed.
+		 */
+		if (!priv->wol_led_armed) {
+			err = __phy_read(phydev, MII_88E1318S_PHY_LED_TCR);
+			if (err < 0)
+				goto error;
+
+			priv->wol_led_tcr = err &
+				(MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
+				 MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);
+			priv->wol_led_armed = true;
+		}
+
 		/* Setup LED[2] as interrupt pin (active low) */
 		err = __phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
 				   MII_88E1318S_PHY_LED_TCR_FORCE_INT,
@@ -2074,6 +2093,41 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 			goto error;
 	}
 
+	if (!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY))) {
+		/* Fully disabled: undo the WoL interrupt setup done above,
+		 * so a later re-enable starts from a clean state. The
+		 * LED[2]/INTn pin mux is only touched when it was forced
+		 * to INTn here, and is restored to the value read at
+		 * arming time; PHYs serving the MAC interrupt, straps, or
+		 * marvell,reg-init values are left alone.
+		 */
+		err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
+		if (err < 0)
+			goto error;
+
+		err = __phy_clear_bits(phydev, MII_88E1318S_PHY_CSIER,
+				       MII_88E1318S_PHY_CSIER_WOL_EIE);
+		if (err < 0)
+			goto error;
+
+		if (!priv->wol_led_armed)
+			goto error;
+
+		err = marvell_write_page(phydev, MII_MARVELL_LED_PAGE);
+		if (err < 0)
+			goto error;
+
+		err = __phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
+				   MII_88E1318S_PHY_LED_TCR_FORCE_INT |
+				   MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
+				   MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW,
+				   priv->wol_led_tcr);
+		if (err < 0)
+			goto error;
+
+		priv->wol_led_armed = false;
+	}
+
 error:
 	return phy_restore_page(phydev, oldpage, err);
 }
-- 
2.55.0

