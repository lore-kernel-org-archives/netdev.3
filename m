Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1046C4D0
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167111; cv=none; b=EiFzgRotmT8GEEZYC0Q9Npxo0XXYZO9GZo8fCERd9nehd272gnYEFQC027nmvW7vDTRrCOb15cxVJXBnLTwRqmu5FM+YtXp2pwSNZcHSbtJm34iAQv2+XsaMr/vDHbCMcGVU7c/W/udf7pxxP/i6jAzCrVUUCNiUxbPI/IZbVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167111; c=relaxed/simple;
	bh=ajBlGar5lLVf70pEAWc6gwQBG7Kn+no2fIRZYpDmLvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUqZI89jnu/Yu+jPgO7Vq95II3FlzAipiwyCl4zq5kHaoL/kxJ06N+76ejgFyuEzqzT0MW6/F4TF+/W899ml9nfW1U4TnQmDWDWOdZ8HV7SDLD3FFMbf5UI8I6jc9aMIGCP/rycLVwDPu6kUrxnJqSY/ZxFNX57Ud4L0nFu99nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSnlDsXc; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSnlDsXc"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2ddbf74c12cso6656065ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790167108; x=1790771908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1UQRnFmVHWe9Z/cGe8zLRoDzdcB8ekJGDg85/atBZHs=;
        b=YSnlDsXc7uyB9jWq106LrfbjH4j1eUU9ilUC25tbDHhSt7ahs8UzR43ZGwmHafFJ8k
         SkpeNwbB96A7S+3ZlIUAhyqb0v8AyG+f7kDs01tVFD7mo/W5oFOS0b8MLwqybnFDtrRR
         gahgmRz+JMxgM4ZIcQjHfZEUgeSFfrfMlLFJJ5+Ecy6AdlFKN3jIxTV0MYXw4XJBx3zP
         835/0qzYsljPu6aUe7bcCh0mBacAKslrAsrFFOSy8665e0h6o/pAnYoCSP9kcZyA+Jt7
         R/OXj1zaLFSQgpiMMntpEMxeWnQ2U2pjQQWLCbeSxSbtNURQTL3NIQZOyS7dQtJUOAur
         iOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167108; x=1790771908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1UQRnFmVHWe9Z/cGe8zLRoDzdcB8ekJGDg85/atBZHs=;
        b=y5Jhi1mne9aUZvyd+v0vOwVzcTo8HHhQAgiIAOZI78obqCU7jZKjV4SHmcQQIA6wal
         qmBJL2ymXRfo3owWqr4Y84My+eRCkcNFWBNfOSWgK6Efkq+zGLLcJwg1+kGrnCilEQmN
         iwC/Qje/u3/UlF2c1HI5kM91ccMqS2ZZAQAAx0NOtAMcWTp8GQad58zPCEBmZ3n939Nd
         FUQ01rUQB4IKFGo4ZE9mcn5SIAuCoAethl+zgiyU0ULmVGTB2iwtEs4RKIpJjQleQLET
         OIDz1UB6JON1saoOvBeTYphAdkJH7Qwhdd2wpR0PhCrGWzcS851od8oyK1XYOxMxbKib
         cgiA==
X-Forwarded-Encrypted: i=1; AKwUvBxG/rMYmclAzLXbO2uci6Qgu6WUHL1tHYcr0x3+8sm7F9tkqGm+mKxPhEyxpaTLuc0jTswqrOg=@vger.kernel.org
X-Gm-Message-State: AFuF++lzHWJIqKTD4P5bUMyJB1/iMXT82NNTFVlpcF4eDwPinLiUuMhe
	IQM+P1gG4mj44E9YG92XVKreheE/2GqSRC/temXSl9phKoPZE2m1FvXz
X-Gm-Gg: AYBFou1KmgpaqrC1qVZZX7/bvCSTgFwaIc9jtkIwCLQ2Xw3emcGvcGFKlWoWU1wDeqR
	ZQGDpoKi0qZ1F7eKOKLl2WPT0SBzUF9zdcxd1szlggLnsSpBnZoX1Q+KMHEC+eaEHO9b45RW7MH
	rrR/xiDKZwrf5EpIFiXMbsG42RiHNuuei6gwQOUb1HIc0nec5C0XDRVfLZJFEkyGzrrdJwN/D8C
	r46R0wr/KFxLZeDR3K6ML+a/hpTVqmjlSrdcgx8wEibO2P6q3U8uO9XstRDv57WyvyFuUMF42ns
	g3GPUcDFBQo+5SgBkJ5KJ+k6jJvbKL05EV47ipyJJhK8g5IRoUvom8U3r3tOxRhSWjr5n/gHoHx
	i0dpRBGEinyzdqAaBS4SY32GXZq0ehjVYWmSwZtGMDaRApho7oDWVoLn8t69krgcAKD7g01iIhm
	drlXSPZIfAhqfBBII1MdnCR1SA0xpuCjBtB5V8lANke1f+WaR/mVj3m9dlDsjW7OyazKwi2Muc1
	y9KceI=
X-Received: by 2002:a17:903:1a86:b0:2df:5a5b:5763 with SMTP id d9443c01a7336-2df69d1ae2cmr22719205ad.10.1790167107749;
        Wed, 23 Sep 2026 05:38:27 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6afc80easm9220405ad.30.2026.09.23.05.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:38:27 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v2] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails
Date: Wed, 23 Sep 2026 20:37:13 +0800
Message-ID: <20260923123713.3137146-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gmac_clk_enable() enables the bulk clocks first and then the optional
PHY clock. If clk_prepare_enable() on the PHY clock fails, the function
returns without rolling back the bulk clocks, and bsp_priv->clk_enabled
stays false, so the later gmac_clk_enable(bsp_priv, false) becomes a
no-op and the bulk clock references are leaked.

Add the missing clk_bulk_disable_unprepare() on that failure path.

Fixes: ea449f7fa0bf ("net: ethernet: stmmac: dwmac-rk: rework optional clock handling")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 8d7042e689261..72bdbcb5e863a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1162,8 +1162,11 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 				return ret;
 
 			ret = clk_prepare_enable(bsp_priv->clk_phy);
-			if (ret)
+			if (ret) {
+				clk_bulk_disable_unprepare(bsp_priv->num_clks,
+							   bsp_priv->clks);
 				return ret;
+			}
 
 			rk_configure_io_clksel(bsp_priv);
 			rk_ungate_rmii_clock(bsp_priv);
-- 
2.47.3

