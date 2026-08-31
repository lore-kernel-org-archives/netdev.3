Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303703C1D4F
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159710; cv=none; b=YMcD1f1PsAbN3pFt46J4vXZtX80Nz/fZcf+HjoRKrKBv8zw+j6rs6VPGIh5fY6CMtx1doNzBP7NPT98kogZX8IuMK5Tmfx13Qj1mByl8lySq7y/KlZ1VuAEwdZraCLkeV9y3M2pKzWs6ZaROyCkHyGx8XBBjKevWZ608L+wYcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159710; c=relaxed/simple;
	bh=jlX20ZSKwhf7V5jBoOYcaZ37EYu7IOXjGdlfLGsDv1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFHPYXsjP8zqAGap5jtyEoKn3q6FHJTc2cl7hGwMnrZcskJ3Co1giZt0RusPKxD6Ajtex2+tl7+abXGcYhBw0SjCcfipu2rznbvk6kqEgQgA7wF09vlSSXyAuo958465bsflKi8pWPgd0+hA8iTj+Nl9TCakitxWNqvOaKo4qTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c9hjm12x; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c9hjm12x"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B63C81A18E7;
	Mon, 31 Aug 2026 07:01:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 881F1601E1;
	Mon, 31 Aug 2026 07:01:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBA4E11C78A03;
	Mon, 31 Aug 2026 09:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788159700; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OXqMCRoQXVkihjLttQXA7lMF61U2RKr6mJhVeRjSKZ4=;
	b=c9hjm12xDvKljAIHLcp7vSBYOqe9hu9+BboALzGB//G67CoWn3vxznJ10hQjj9qBrM389Z
	aeRpqlbYYwQIGISmXHYaQ6bz0gVZp5i0OKF6lUFsOaE814/Doymm+Pl1wtxXvwI5G7LQd5
	RuwgE1ymIvNdV/VHrShJU4d/hy6Bbfib6kKfJD90Wi9xorBXSMEM7V+EpTXx/7rP3bM4pZ
	oFBr4fd7VQRTQjTiY+V2UNVycQf/wwcmSrjyWpAejAX42ni41HfbfUgeITqxgmUnp2ZtzD
	0z5Ic7FrcRSY74mmywP1tLY+CPIxYiA8g4gkemkdlfq0CXTqrzqq0jvmeBZZ2w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 1/2] net: stmmac: dwmac4: Read the UC filter size from hardware capabilities
Date: Mon, 31 Aug 2026 09:01:19 +0200
Message-ID: <20260831070121.349778-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

dwmac4 has multiple banks of perfect filter entries, independently
configurable during IP integration.

The multi_addr bank reports a number between 0 and 31 corresponding to
the actual number of entries in that bank, while the 32 and 64 banks
are all-or-nothing.

Expose these caps over debugfs as well.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      |  4 +++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ++++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 927ea6230073..77bd47a83357 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -419,6 +419,8 @@ struct dma_features {
 	unsigned int half_duplex;
 	unsigned int hash_filter;
 	unsigned int multi_addr;
+	unsigned int additional_32_addr;
+	unsigned int additional_64_addr;
 	unsigned int pcs;
 	unsigned int sma_mdio;
 	unsigned int pmt_remote_wake_up;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 6382836828ba..89368e34a388 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -176,7 +176,9 @@ enum power_event {
 
 /* MAC HW features0 bitmap */
 #define GMAC_HW_FEAT_SAVLANINS		BIT(27)
-#define GMAC_HW_FEAT_ADDMAC		BIT(18)
+#define GMAC_HW_FEAT_MACADR64SEL	BIT(24)
+#define GMAC_HW_FEAT_MACADR32SEL	BIT(23)
+#define GMAC_HW_FEAT_ADDMAC		GENMASK(22, 18)
 #define GMAC_HW_FEAT_RXCOESEL		BIT(16)
 #define GMAC_HW_FEAT_TXCOSEL		BIT(14)
 #define GMAC_HW_FEAT_EEESEL		BIT(13)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 23ffe1adcd0d..14ac3f0e51f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -388,6 +388,8 @@ static int dwmac4_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->half_duplex = (hw_cap & GMAC_HW_FEAT_HDSEL) >> 2;
 	dma_cap->vlhash = (hw_cap & GMAC_HW_FEAT_VLHASH) >> 4;
 	dma_cap->multi_addr = (hw_cap & GMAC_HW_FEAT_ADDMAC) >> 18;
+	dma_cap->additional_32_addr = (hw_cap & GMAC_HW_FEAT_MACADR32SEL) >> 23;
+	dma_cap->additional_64_addr = (hw_cap & GMAC_HW_FEAT_MACADR64SEL) >> 24;
 	dma_cap->pcs = (hw_cap & GMAC_HW_FEAT_PCSSEL) >> 3;
 	dma_cap->sma_mdio = (hw_cap & GMAC_HW_FEAT_SMASEL) >> 5;
 	dma_cap->pmt_remote_wake_up = (hw_cap & GMAC_HW_FEAT_RWKSEL) >> 6;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f2fc89176654..a885f8cfef21 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6580,6 +6580,18 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		seq_printf(seq,
 			   "\tNumber of Additional MAC address registers: %d\n",
 			   priv->dma_cap.multi_addr);
+	} else if (priv->plat->core_type == DWMAC_CORE_GMAC4) {
+		seq_printf(seq,
+			   "\tNumber of MAC address registers (1-31): %d\n",
+			   priv->dma_cap.multi_addr);
+		seq_printf(seq,
+			   "\tAdditional 32 MAC address registers (32-63): %s\n",
+			   priv->dma_cap.additional_32_addr ? "Y" : "N");
+		seq_printf(seq,
+			   "\tAdditional 64 MAC address registers (64-127): %s\n",
+			   priv->dma_cap.additional_64_addr ? "Y" : "N");
+		seq_printf(seq, "\tHash Filter: %s\n",
+			   (priv->dma_cap.hash_filter) ? "Y" : "N");
 	} else {
 		seq_printf(seq, "\tHash Filter: %s\n",
 			   (priv->dma_cap.hash_filter) ? "Y" : "N");
-- 
2.55.0

