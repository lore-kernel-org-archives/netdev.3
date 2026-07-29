Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF46432BE9
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310987; cv=none; b=sYJ7xzACbfuG7CPg0ZOQRXUjx06cWdbShYdp8P49uCftL7ukHJGiQFjWhAezkmSzcfLLKclKkXhnTwF9oZiVFaHm35Hf6/9vagShMPRKRvpKMSFEazJ5pjkiuZz7axlorbpklAIjo5ZrtJ64JSItS4Pv+GJnn6fcL5VsI26zrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310987; c=relaxed/simple;
	bh=3yrpu63e5AExL+jcix3y7Gj6Ok2VDhHJQAiDsgszpdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfceaofzKLusl61zhlUcCYRfiHOJoT7pUyM/jAasnCm3aHN4hOiv7KYi0lhARaDR+qOQXslGYNYjNZztU0dz/qC4HJ/qyoiTtGQRDN10erC49biU/BYIxfipclBo3lx9Dc7L8z/rcJ4V46WKIXezbGDJZroqP5ikeRDGvtGSrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHNgNFGO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHNgNFGO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce98cb8165so6732775ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785310975; x=1785915775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNKMfFoLrxfVgkUmO/8mblNHEBodyP1KuT76nV4WYpo=;
        b=OHNgNFGOsoHE5agn/gIk3TZkyG6zpCmsEh5jRdzo1iIc0A9mhWO7nhTzgT/ozPbMVG
         PX/YWKePI/cJyZpKE0ta30+xTeJkslT80dz+vAMm3Urk6JbRn8fpCyeQw9RYaH9YXaB1
         T+UcoVkSBm0DIw/Mu6L1ifbaD8Ah1r3iG8f264K+j3+Thdc1cFrfbhpkt/Sop8YppyJr
         oL9VdCyef61Eg1B2nMmoKBtU6zS2HrwUs37JxMzgFLk3C5+mK/sWXsX6PmNiIUAmh7Gw
         ifOCICAk7UBAB65NRpmmImpc8CJOHE13ohCaqc9LBQG0EC+3eYudp6/FR0NfgN/LKKOB
         yJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785310975; x=1785915775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNKMfFoLrxfVgkUmO/8mblNHEBodyP1KuT76nV4WYpo=;
        b=Fi7xXZ5f+Sl7LTpBl2rZ+B+7B6eTG9b8gVHUwR7KuTROIsag1e382arp8JCZ4nJ2Zj
         HgYzWrceRqjoqBdxI/f5laAeMzILT9oUmPC5U4HslrwdIzNI4PT0onyFKUaqJHQbVppx
         t5bfGsFkCXXnm5m2Am6WZ5UwYKDlXpukdyNk5+dsOmkS3mVG1Y4X7d2DuQJbBoeCE/TR
         PwNGgYgX+2FyLReY5CWVlSl6VyUK13771ks0PjA+u1ulBsMmAa2x9Bj4hEX7dT8h5Liv
         cT6KOfpslAhmGeM/MjyzRwHnoSlNTr5w9PkzM2CqNVXRBvjEbglis5EKrery5Rcbq5NC
         hiVg==
X-Gm-Message-State: AOJu0YyIRNU4pL84bnlNpwlL7PtRbspuDTnPoGuoW9D6fcuu0+8PDnqg
	UWyX1U6hysiozDmDlqM/KqgidC1gasZK6wm4hU3PbOOsaVrLHXY6Fk/Gp2cXE5XF
X-Gm-Gg: AR+sD12eK7BTL7uQwT7k2tRcdhHh6w/Zzyt8brMyoGGLBN5bge2xgBd2FQYEQyIgf82
	4NwFmTGYMWyhkQxP3Xz/0vi0uqHBAmYQAnAiB2boNbKYucOTVO2FgGhmWB2AdHBYXoufhXy9Vxa
	ec+6DKQ5WUuyAdwfxf2Ir8ESz/QYOi3SwGslXBbg8QoVCfLAvIuohmQNOLgv3OGrob9z+CaB3jx
	FfMLOxSbilkD4s869+nt4WaJv3SGNUahoDLMdZ/JfTm7d2P/MMJb9lloBIGassRMDCdNyNJXTYM
	cHJKROEGNfg+4Eg+t172MGt0YzsOFqDajFxEYVHApm7IBrgpi9ZibSberObsriXypx/SBNGWiTB
	LJlemgrrYU3Tq/GIlh2ws4LO8yHvdRLZx/lZp/mVsHQeSzaXFGMvJb6933iTcQV79t5O1fbEWPf
	NIglLWNlJG47fOWYETdjDWft0faWiQOaBzY5ihkxF+LFw8BPRw/NcJSZr4asY=
X-Received: by 2002:a17:903:46c6:b0:2ca:e496:5f19 with SMTP id d9443c01a7336-2d0267522d0mr13767845ad.19.1785310975421;
        Wed, 29 Jul 2026 00:42:55 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf888csm7154505ad.64.2026.07.29.00.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:42:54 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/2] net: stmmac: Skip PHY attach if custom PCS is in use
Date: Wed, 29 Jul 2026 15:42:36 +0800
Message-Id: <20260729074237.2624940-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729074237.2624940-1-zxyan0222@gmail.com>
References: <20260729074237.2624940-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a platform provides a custom PCS via the pcs_init callback,
the MAC's phylink_pcs is already configured. In this case, no
traditional PHY device is needed.

Without this, stmmac_init_phy() falls through to the no-phy-node
path and errors out with "no phy found" when the DT has no
phy-handle for such interfaces.

Skip the PHY attach when priv->hw->phylink_pcs is set and
phy_addr is invalid.

Fixes: f0ef433fc264 ("net: stmmac: introduce pcs_init/pcs_exit stmmac operations")
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 562d20830b94..575132b9cdbf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1347,6 +1347,10 @@ static int stmmac_init_phy(struct net_device *dev)
 		struct phy_device *phydev;
 
 		if (addr < 0) {
+			/* If a custom PCS is in use, no PHY is needed */
+			if (priv->hw->phylink_pcs)
+				return 0;
+
 			netdev_err(priv->dev, "no phy found\n");
 			return -ENODEV;
 		}
-- 
2.34.1

