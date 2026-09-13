Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CB2BE7A7
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789333077; cv=none; b=VufA28ZGBRili5+/esfIUbQQtMVThNmYrlodFmgd44xp8Ve/H7IBxSCpCLco8wF3uDOfhl47gvE6au7JgB6orOFEB7ZpME+fkzp2Bp01EJmsirFoI5VR+WIfOiYxE+EP/ItYA0Hi5Pgw4RbAR106T9IlRzU8xgNW6crJTQ7BsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789333077; c=relaxed/simple;
	bh=mf93YlN/XE96GK0N1kC2CPR39oh9Xn4J9PXaEedZizc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drinS/qjfNetscedGIatsxeqTuZ9A2aDexSVvG4Q8bKwEVei/90tmpoS6zgrapL2p96c+kZ56MXGvd65+djXfMsaNy4nvHx2fGGUXsyjNHN/f/wViIxIToLsIMBsXpVvYgYcjr9KJjVXCqmNlM9drCRlKXCzgUaevBl8V5H/5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tM7k4Upa; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM7k4Upa"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so988006a91.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789333075; x=1789937875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X0tnZg4ciozzZFeiLauyInjWDuzOBWpSsbusg1RKLpM=;
        b=tM7k4Upag3JFaY5On56kJeVae4fznMoE87ES7ava7A0cB+TH0lZye4tBY6F7ftCrXy
         KTJH74fBbObMOt3wKYkPqdiraAwJGM5M2I8BnXuAb2bDdPyvIO3bu+KbgsgjJsbXog1i
         lIABeqOlL8nRMEqOFp9tYSzfwt5CKaqIcUo7c03nRD8OcS+ntuU7tXhlCunjw0cUpqgC
         BdoYSLz2zfXdrROhJhj1NC4oW0q7gCOoKLmNZ4REbwxyzxwiy/myGSZAFuvw/E3yfRVV
         xLGoh21uc5pKFou3ip5CwTjuCijv3HcVpLnBkepodVt0GqzVwgbH/PSk5epKvLM06csI
         UhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789333075; x=1789937875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0tnZg4ciozzZFeiLauyInjWDuzOBWpSsbusg1RKLpM=;
        b=RwSrdhR8z+PcD9x5OUaaytXe9ynmKHWmYodPJSAlXQZAr9s8vmuGxO4rzutZps8Bf+
         gRyCjYg1l1eIM0iBfdlo7imnZw52TF7TLo4yDIJGD3EWfSSHfbIteSP+BxK39G79pH2W
         Zh9erAF8jVOUblnB/GjHgCCReI2r54ab/RwaxMcIGjwvFMJH8HT34ZlHAeWu+LRWaEHn
         DRIeDg3Lm7ZBUKDsZHbYLvdnLcnLIwEl4PH74Ckeu4yxyYErTOkeavr3j3u2NrXZT81g
         CSo/175upIQPc5Xqyk6nbFnnKOCcdHWxagec1cNBOLD4Eh/Q7pE3AZFXurO0jAs0Kt9B
         dUdA==
X-Gm-Message-State: AFuF++nPe9mhBC8Y30BWZPIJAG95Tk3ZlD+pypB6+KoDkLCVNcbHbEWL
	cCKnojFdnjWRBYsgjEo7jYVaEY+sMdGpSpmpifDO+CgFKth5xnhHhhJWreABsQ==
X-Gm-Gg: AYBFou3g87bRiZrG61K14Uo1DLBD0drvcalM0ORCyhHYO4nCdTQ5eprgdI4sv76Wi81
	W/PNbBsE1l2oKUlfGSVFaf6YiN5caofuahSkW1RZrZgwtVmVJT4poYxx4OHiXlgIHxK5ntfN1Yx
	Nv+cTWjboYQjZ7hGY+3RKrXxlnHLSFtyaeNwiW30t65zdEbX7PaOLRS5ubT62fEObRYSs4TgTpZ
	wi0HaLKLCJx9nUOM/sX4KU10aI8Wcre/NhFR4t3dJIfcQJHlZYvzv31WIXozKhIKvUpST1a5/1S
	iTLxOx3LqabgPcyWJS2tnSGDMw9Tx0DZk2vjphTYLi4XQ8oLqA8cV5dCreXMhkDhrUNkDzPniND
	aAVRJBxhk+IKHuhbqDg1/dSjwpRDBPjpvxVVJxPq8m8N1GtL+LiuR60qd7Qouc4ywTG4Vjq6r7l
	+Sw0Lg7ZdH1DofpdlqxPFZgRb4L/bCGIJVnQH3zb274vsKdM+rmZT/fsDfIxSlmvol6WB0V1he5
	ujDZLBb4J0wRS8feht9c2CIJdEw24PEr2fxfFZTyl0Z/ndfz4KQscWpexEx2ACaVATmOpYrGY45
	NRUssRe9GUj9l9rhHazHwXv+byI2eivUdX/h5/dnYwwVZrUt9/RKE4gJxQY=
X-Received: by 2002:a17:90b:560e:b0:39b:34ef:3b2b with SMTP id 98e67ed59e1d1-39d9c0ba635mr26460010a91.14.1789333075056;
        Sun, 13 Sep 2026 13:57:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d6b08sm17281800a91.8.2026.09.13.13.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:57:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: marvell: undo WoL setup when Wake-on-LAN is disabled
Date: Sun, 13 Sep 2026 13:57:51 -0700
Message-ID: <20260913205751.81163-1-rosenp@gmail.com>
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

Undo the WoL interrupt setup once all WoL options are cleared:
clear CSIER.WOL_EIE and restore LED[2] to its prior use - the INTn
output on interrupt-driven PHYs, the plain LED function otherwise.
Never set the FORCE_INT bit while disposing of the pin: it holds
the interrupt line asserted and turns the shared PHY interrupt into
a "nobody cared" IRQ storm when the PHY interrupt is in use.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/phy/marvell.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..6f7c190880f2 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -2074,6 +2074,35 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 			goto error;
 	}
 
+	if (!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY))) {
+		/* Fully disabled: undo the WoL interrupt setup done above,
+		 * so a later re-enable starts from a clean state.
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
+		err = marvell_write_page(phydev, MII_MARVELL_LED_PAGE);
+		if (err < 0)
+			goto error;
+
+		err = __phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
+				   MII_88E1318S_PHY_LED_TCR_FORCE_INT |
+				   MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
+				   MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW,
+				   phy_interrupt_is_valid(phydev) ?
+					MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
+					MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW :
+					0);
+		if (err < 0)
+			goto error;
+	}
+
 error:
 	return phy_restore_page(phydev, oldpage, err);
 }
-- 
2.55.0

