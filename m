Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6433A033;
	Mon,  3 Aug 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766643; cv=none; b=GN0r9loEFvfCd1Sq9d8rwTJMdKXFTI9KitXo0wEOhGDrXP0VlvQvxgp61Y0UwLwbuI/VVH9KqBM9CgSfFHR90Gi1VwzzPMoFffJNHmgnUiDjHSQY9FD2qmxc5HJagyBRD0cfRniEl8fFTBoE/VFwZTNXZYIWf9n+DIOUJXoyvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766643; c=relaxed/simple;
	bh=lbIpr0S3EAnRRiqlEjQyKzX9ZPKiQgp6/AgUh8QYzR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeunuDGEqzjuQLblsfgJ1KOV2NYV77iat01xXfA5oZeSja6KFynMQcEA3Wn0CUOptCLhagOQYEyu2nHpflMeu0XFTOACiFWO41/45tP/dDwOCOdHq3vgQ1bUEVS24mVDyEwmUT5ldOiusQ3XdHVMmzUC272hsUkmBwEabXq6+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eztiGkej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eztiGkej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2871F00A3A;
	Mon,  3 Aug 2026 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766642;
	bh=dMeZxxXidnnv8L6avohKewSLU0LQy6ezrLI+Ol9UVmE=;
	h=From:To:Cc:Subject:Date;
	b=eztiGkejZ8yyi5F5R9XJXXifbi+qUj5ZEodqZOBQcciQSEVh+D0/A7KWxgjiVLhBT
	 tXrAI/JBdtRupM0JhhE98DpCoeF55d8lTj3hnYH03DSvbyLP5+czG5A3a/b0oGZmKQ
	 9QbHV4OWRGs9YrUZmgJjWFWS9DN3h+aO5eTbQXHhMKUWEUedRXoHPoADg8tzkfN5OI
	 sc158uUkSKEDOLHZf3jiZep1xX9s00x2e5gSbTwYomqGSexyRnSlLL+RWKzmPnqWGN
	 RSnObKAUrQxiEaVrGBbZWkbCnCyTvmKcdSRPchA4LzCx8hKgIeeXDqVf04CB9s0p6i
	 ZxTRwBMIPV6Fw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: remove ptpaddr/mmcaddr/estaddr "safe" initialization
Date: Mon,  3 Aug 2026 21:57:45 +0800
Message-ID: <20260803135745.12600-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These so called "safe" initializations aren't needed any more from
sometime, but the unnecessaries are obvious after recent clean up
by Russell. The code will correctly initialize them after getting
the correct stmmac_hwif_entry by calling stmmac_hwif_find().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 511b0fd5e834..265671170bf6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -328,18 +328,6 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	/* Save ID for later use */
 	priv->synopsys_id = version.snpsver;
 
-	/* Lets assume some safe values first */
-	if (core_type == DWMAC_CORE_GMAC4) {
-		priv->ptpaddr = priv->ioaddr + PTP_GMAC4_OFFSET;
-		priv->mmcaddr = priv->ioaddr + MMC_GMAC4_OFFSET;
-		priv->estaddr = priv->ioaddr + EST_GMAC4_OFFSET;
-	} else {
-		priv->ptpaddr = priv->ioaddr + PTP_GMAC3_X_OFFSET;
-		priv->mmcaddr = priv->ioaddr + MMC_GMAC3_X_OFFSET;
-		if (core_type == DWMAC_CORE_XGMAC)
-			priv->estaddr = priv->ioaddr + EST_XGMAC_OFFSET;
-	}
-
 	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
 	if (!mac)
 		return -ENOMEM;
-- 
2.53.0

