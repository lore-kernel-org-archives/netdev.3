Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F036165E
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072412; cv=none; b=P6daYd1V73IXQMoiLrly89QN0MgBdxr1RgbJy4z7zHcJzpAao1Tne74oNwLHF+ll/wuYJQf2S4AghWVn50MbuRcLjj3KeOKaZRh+SdDJ5CskrJpGeC7WqYO8rNWTEXgIGsoqNlFgyqHKt4uQ3xYWcfKwPcr+RnRA1M5yejdqpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072412; c=relaxed/simple;
	bh=mvM9VPu/Rs7kGZQB3oDZpSGOWjgiJJKe6xhTJLJKuNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+X2YKd2s4tjDfC0v9ilvvtLJlYVdQXrdre71x1eKBnNcppevB1nTboR8bSQg8IY8u9UC6fTjirryyuUcb20JHEsMj5i64xR0YfBFVKee2mxoex0OV7ZOCJKNAd7NN3vczn5j3ZLaCmGAU9G6q9pXcAIRHRR+usMin4GJAsyYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFJqF4Kt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFJqF4Kt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceed7018c8so11898435ad.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785072408; x=1785677208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/TLl71jUWptanjVEHFZh82fCzoKSbTQp3yt1GZ8oxw=;
        b=MFJqF4Kt9ijo/J11Wo988V5t/krGkneIWF9IPeQizc6ILoB4/vZPPEU31MGmRlcomE
         7Qq8Ksc3P1OnkZ0D0F1KMu1yaq9w40Pzw7uu3coebJ6jgMY2+NAkt3aEbUoZpjf82hi6
         SnIDVxD4Y2PbdWPCCReG/iQcbrjiGCfGb5ohZKcJcquMRGndW0Gvt2XXX5Kh60V9QqLx
         X6ga5WZ94As0hDtoSl0MpR0DE3TNhplEVqvVw+OkyWPPDPCiey5vlIO6FeB7rKaTYxQV
         LMX1xl0p9XSVgeugxpAOvm5ol4pBslsflAXmtBeb5ZtfbN31mDHVw2jNL0Q8ZpczWKsB
         52LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785072408; x=1785677208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5/TLl71jUWptanjVEHFZh82fCzoKSbTQp3yt1GZ8oxw=;
        b=RBjBVTDjl62qunvpan6at+MREQVRjPEjuMptr+fV4XHQ2ffJw6DuMAIwUguE0PUfgR
         R1iRxlENe4Q4JKT9Cf+FDD0YMeC5KQFLs5bBM4Vn2ruZByLtBqQJWAuyDBrgRmcKmApj
         VfmJ8zf8Mk1xxKMVxw+PLtAMxmJcRwmbh7vNG0mHtYZ2RVi/br10PsXogtp9lsvcW67x
         rFOWJ7wF5PeaWdv5YyIsCJJmzkvRqiopycs9duB8B5KAdKfE5KtmKc38/CMrzWXMlnKK
         266wvwG1w6Kq42mdlMqsFaNyC0KygO2wiSmQ+r6X3u/tET0LgBLVjSQ4Aa0aetZGbWG4
         U5ow==
X-Gm-Message-State: AOJu0YwCMRzgoAtx48iEvB6BQPwpdLkLuhSBO37jzn8hPLUkCIn+wD8B
	RIdosoRIVsFEy5Rp/ioN1g76u4FUv95yiVjCdQpz6rAUnLJyAtuKGBuiGmpq5qED
X-Gm-Gg: AR+sD12iMIt9QzX2GExgM78aTwJSAqUFL5URjeLPeruRRdLSEDQEFL4GySK6mdSU9Tb
	ywNqfimOo4kYJ6adc2/zbdt0+YLef+2RFfrqLklCC01FgzOAT5wKE0C0i5r4Vr7uspeQn38b0gl
	JXK96QSvuGcX54efoz7+mGp9W9czLOV01G2pRosk+p1oCumIVBqTeKiNvTzc7youcGd4iDP4JbU
	fUPKlz8OR+CsEdThiP+9e/j9doLjL2AxufxbyZsOrhQG826/lWX3jkVcvtXWpfpUwLwlCljgPwW
	Y0wwvTKQgD4IRZxm0lvdYsWUoVzTBmDJuAlBlkmt/WJHGX+4hTaxuiiOmynVV3cg62OOvwcwaNX
	KnuT/bdvOQssXiTt0UoM4aogxu8zLS8Pl2YhRB02EQGqbkdIzxrE7kNgQu+EjIDAsZIU5r9YbiN
	Ll
X-Received: by 2002:a17:903:988:b0:2ca:281:27fd with SMTP id d9443c01a7336-2cfde845828mr50672695ad.25.1785072408037;
        Sun, 26 Jul 2026 06:26:48 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdc2sm20677655ad.42.2026.07.26.06.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 06:26:47 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: stmmac: Skip PHY attach if custom PCS is in use
Date: Sun, 26 Jul 2026 21:26:18 +0800
Message-Id: <20260726132618.3580612-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260726132618.3580612-1-zxyan0222@gmail.com>
References: <20260726132618.3580612-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a platform provides a custom PCS via the pcs_init callback,
the MAC's phylink_pcs is already configured. In this case, phylink
validates against the PCS's supported interfaces and manages link
state through the PCS, so no traditional PHY device is needed.

Without this, stmmac_init_phy() falls through to the no-phy-node
path and errors out with "no phy found" when the DT has no
phy-handle for such interfaces.

Skip the PHY attach when priv->hw->phylink_pcs is already set and no
phy-handle is specified in the device tree.

Fixes: f0ef433fc264 ("net: stmmac: introduce pcs_init/pcs_exit stmmac operations")
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 562d20830b94..044ed3b89247 100644
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

