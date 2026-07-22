Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10430ACF1
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726400; cv=none; b=imafiWIgG5wXE6jVmuehUEMJqEhqZy7r2dopRoyiGVcD8rdNYlfIwcpTCK6nPDrL83w6CiOVIpdKJi2WPnNj5y+nAWKkkvymMOentdkZXV50V7EFCMCE1/LA3e6ynbfSKovh2bSr1xHbiKJtq4K5SPWu3t1dRH7uxSv9PZcX2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726400; c=relaxed/simple;
	bh=BqjtnbOXG4Fh7SFEObLdm4QiDsMOAdXbHDJBsl4pjd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmAE2GI+BIiem5ePA62fo41DWAv9egEz9eorF2Yuh4KUCW4/wF6+CZ5psi2FGgjPz/UrG2cYh2rsKwuzY0UKakbmFi/TPvaj6rpyNqqBfg5MYX1SXTOKqSu1Ezc8wQSBeXwGRfd4QZxoSsKacEkU0tduHmbYhhw42l3kJ9ETams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQI/c251; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQI/c251"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso8338624a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784726398; x=1785331198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkleSo/mHT7B7/DelUTKo1SDFA3O4GZirFnblobGSyk=;
        b=TQI/c251tn0BVfrClJ8asm5qWDTE4YfgtA+VeR5TC92UsapdSmHoxjHxXwgLoqNtAm
         Jk/y2s210YqOhfv3t2DrvQ+4QhwRdrcIkROC1r+05TnYLDmKFzDwXpy4f5CkV7QvUsGa
         tIdnOyIxLMfBUscdA0grM2+RdExYFnvjyFnnnl8rB3STnMG3Q232SFu5mQlpxFjVq1Wf
         virjuvcigRzFIozNlJJFZqIIQ6L1nevB1CaGSXp3WWhFIWT3Hul+I0SJuUOrtkAWPElo
         Ncj107c0yvyryRV0CL4Np0W37uVE2KBbu2nZHUy6ukMqpieEu1sHnganQCHNbCO2mCEn
         FWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726398; x=1785331198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YkleSo/mHT7B7/DelUTKo1SDFA3O4GZirFnblobGSyk=;
        b=LKa3PSu3nZc4+qm9Ibge1mkMOZKrG7jImiIipYRqWlnPEv4+PWQGhmJgdqvIcATDU8
         Y2snbIYTiA3UibGAFzURv6qoyrxFsy8YtI9KMgfB2EBFLxBL3ktQTp3AVTYFKH7ELQXh
         6oUlxYi80jKJj0m1bw1DnbZtPcXDg0k5VUadK6Sxt1YbPX0cUTmL5Z0ETMuaT5vfL7dW
         uvI8LQc072fVVaZSwv8gXG3W8F873q2I5cStbiUl11z0XbAaulQyerS8LprPVIxfdwBp
         RAS2QxVsuFFYNaSSDbwUkeA+Rmyv7d8ygN6FmjAjVXu4WqkK0rvkyz7rRJdYQYO6mVZD
         4Qmw==
X-Gm-Message-State: AOJu0Yya7tS46p6MfcG5ice+2XovrDfsYj++B0uizmNEkyXD5fswnkU2
	NzlYaCKKoWKNqXuqfgF6A0v50EqWkXgFjpat4y8jdPQCRwanKm0VihRkn6D4pZDC
X-Gm-Gg: AR+sD10xtWQzoh790HhmJsEPkkGfXcCkeqGY3uR+JYgE960eP9LZFkWz7c3unAIPEFJ
	woXTxecJtJ/bsjxyWz0bfhxeHBqey0KVVTDlnybMsZ1oe281gdF8TartifpCAz0xFtoxlH+jm7C
	7xbxae2ql+R0DZg4hYl26kMoTpDycp2J7o2DB6k+0AOvvlJBRjfYzvwJq+xdn2wSYLkLG6qgkj9
	8DDkjlo+xNdht15fj5DXyXr5cv0U/3wn/SKY6s2f7+/IPt9VVEjRp0hiCTdsoPskcS+6CskJJyc
	dPvVHjz3TjQfpLdYWZmb9TTyGl922oZbOYk3rQKW+UGDiqfdH7RS58lEcO2loDwlqQL4aQOeb3j
	13pKPaIlTJMZC6kA1l2AZegGUhByj0lMe/lMGBIOXR0Jjpt6zniT1t2Opj+rzEMECUtUd9vc023
	OH
X-Received: by 2002:a05:6a21:6110:b0:3c3:a140:938a with SMTP id adf61e73a8af0-3c3ad947db0mr26030102637.45.1784726397859;
        Wed, 22 Jul 2026 06:19:57 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f18ba96sm1112292a12.17.2026.07.22.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:19:57 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net] net: stmmac: Skip PHY attach if custom PCS is in use
Date: Wed, 22 Jul 2026 21:19:18 +0800
Message-Id: <20260722131918.685761-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a platform provides a custom PCS via the pcs_init callback
(e.g., for USXGMII with in-band autoneg), the MAC's phylink_pcs
is already configured. In this case, phylink validates against
the PCS's supported interfaces and manages link state through
the PCS, so no traditional PHY device is needed.

Without this, stmmac_init_phy() falls through to the
no-phy-node path and errors out with "no phy found" when
the DT has no phy-handle for such interfaces.

Skip the PHY attach when priv->hw->phylink_pcs is already set
and no phy-handle is specified in the device tree, allowing
platform PCS implementations to handle the link autonomously.

Fixes: f0ef433fc264 ("net: stmmac: introduce pcs_init/pcs_exit stmmac operations")
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..54c5281e91ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1346,6 +1346,10 @@ static int stmmac_init_phy(struct net_device *dev)
 		int addr = priv->plat->phy_addr;
 		struct phy_device *phydev;
 
+		/* If a custom PCS is in use, no PHY is needed */
+		if (priv->hw->phylink_pcs)
+			return 0;
+
 		if (addr < 0) {
 			netdev_err(priv->dev, "no phy found\n");
 			return -ENODEV;
-- 
2.34.1

