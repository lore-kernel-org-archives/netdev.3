Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076441443C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859686; cv=none; b=b/uc9VatJqEo5owduIzpNG1J9FcEyctusWZE8ReuuwfVHkPAWm1X5aPzn33tWv+lGdJfLlQJdysd33PLtSriyvyqPgeYHrhjZ+lOGakR1lJv1rhyc4RkSYhlumWeqjApREyRvBK26oFZxRbCQ9sdDUhZiLlM9Y4SNfnumy85ddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859686; c=relaxed/simple;
	bh=/nq9ULOagF8TNdNkpu6Q5sv3UadZrrvNv8JRzSgtxuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o12kas5aVwHnYKuN+JL1XUCN9QWOLA1wSwYCHzmGormvcze1e1Up9l/7J2Ro6Ldx57rsKnzzPJS/kGyKYGuaGdCfZQs647Ce0Auc2PbLCtRPwqKLC1rZYYimxcegcwsAcONG6xWke0MMxmzwC4nwsHxI4jRqi3L4i1nzvrJm9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqIrQNZd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqIrQNZd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-88bf90b7f07so666906b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791859684; x=1792464484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S/CQGMpBuy/7FJjcfHtn4Lxv99je/uyA1AfUbEVnRss=;
        b=sqIrQNZds3xFmRLXdaMHSF8btDZx3ZrJbYWNGitFywvjWYRvXhj7fW8FPXmqy47L7f
         4R4E3o1EHAJYNhO87Te1XIHk0rl2E5tF6BRN0qzg8AJqc3tu+uME9O8ZNJigABnl7xYV
         A8gZbvcvIR5/9Op0W9xGrxxScN6kaqDC/z4u2Dv2XrGVnkLddQRaNRPI05Ieg2GUZzpJ
         vvyxwN0InN6oCEaubqC1Q9TOYRLy64sRiXi60aQHvwhqlzEIb3aNotiFg7VYLPneln/n
         qxanFs7s95ViAtXuv9vSr/ilNLgo9LNZT58P4pPDyy9jK5nrxFT/+YnavuyJc7cMuC1N
         69dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791859684; x=1792464484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S/CQGMpBuy/7FJjcfHtn4Lxv99je/uyA1AfUbEVnRss=;
        b=ZMzc0OWq9LKR7lmAfVUlkUOwfy8rwSjvoNbG4N/GoTMK05Hy5mQ76IhnFcK5QbzcX4
         4Wkwo+HSCw9vWWLoWq2pU2TT0UhOQ3ub4HSs33iWY++2XY+dMT1Ns08RTK7AunAUFFsS
         uOahTVOliysmLoFNodR/PAX2b9CUuG1l7EEVK4q0AoGGHzukOwglowN7TEKy2BTRESnx
         TMk1Gb6fMeGXgz4cI1FgSbUv13ei4iOzdHvHzpQNMwABsZ+rzR/VhNtCEE6+itvYiSmH
         HJLf2tY33BDpA9URsX3iFiwBhiufa86cR9HRO0xkaQGkRxyOy31im3Nrz5EPgR7gM5QY
         tj+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzHIggU0tCdSrhVlxFTZv8SCQsHeXn1n7B8W00emd6c7Jh2GCfvAxb3g4AL7nV9/oUsUQiCq38=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm9zTDt+ZFKAm4krDSKfJMJvTS6P9JHi51rIXNiYpi/PWuD+Xo
	+y7DLUazyv4cOW93BHHfTX79GBWQpzrRr/M6OAS3g24t9EeP5laDeyX+
X-Gm-Gg: AYBFou28ew8zH87pn51sF7skl1eR264iX/jwnUW8ZnuKMYWYi5kdYKggOxNDX6/1RIv
	bV/PYR5S9CqIEbruKFxC8Zp4goRJyPNOCTOH2XlGsr0P55BEkjZC2Dn9nq9g3m5a0v50//eXCV1
	EeB98gmlBH4ASVrCw4tZoVTywz2zLXWzmqmIg58QnmNKBKma6uV2Dhx/zgzLNyCszMW9pQid8Fm
	d+d67vmNfWtpQhL1m9G5Pyd63tdU+yYFY7LYJ6FvNPKd7a42BG5mzY3rJ09xWlnp6ELpnhX5+UG
	ZgO1mXlMJok0+xH0b2rMv+BUFFwdRE8s4YL5pZ+41pAez5v1HnscX60R4aU2asmx13i6N6zNPvb
	MNAOqBcq/hNz0zNtrnKAK/k4fFSmvaxklNe1MDgcKIdTecCZmHwl0rG0gosf+I8bxnBtCyHMo0p
	rvfMulSsXodbq15bR8FeJQWyBbp+NfQEIHX8jw6U1N4fTr5kAE+jUbKqmEMphjX2VMk7XNzOG3H
	7uLeYqWlsU=
X-Received: by 2002:a05:6a00:951a:b0:882:2b16:c314 with SMTP id d2e1a72fcca58-897c7cd1127mr9507515b3a.52.1791859684155;
        Mon, 12 Oct 2026 19:48:04 -0700 (PDT)
Received: from online.mioffice.cn ([2408:8607:1b00:8:5e2a:b6c:f432:a6f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c42b4549sm4466018b3a.44.2026.10.12.19.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:48:03 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jose Abreu <joabreu@synopsys.com>,
	EricChan <chenchuangyu@xiaomi.com>,
	Simon Horman <horms@kernel.org>,
	zhangpengfei16@xiaomi.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: stmmac: xgmac: do not treat TBU as a TX event
Date: Tue, 13 Oct 2026 10:47:47 +0800
Message-ID: <20261013024747.2688984-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8d07a7930434 ("net: stmmac: xgmac: Do not enable TBU interrupt")
removed TBUE from the default DMA interrupt mask, but did not remove the
TBU check from dwxgmac2_dma_interrupt().

TBU is set whenever a TX channel runs out of descriptors. Since TBUE is
not enabled and only enabled bits are cleared, the TBU status bit is
never cleared. As a result, TBU stays set on every idle TX channel,
regardless of whether there is any TX traffic.

With a shared interrupt, stmmac_dma_interrupt() checks all channels,
so every interrupt from any source schedules TX NAPI on every idle TX
channel.

Only use TI to trigger TX processing.

Fixes: 8d07a7930434 ("net: stmmac: xgmac: Do not enable TBU interrupt")
Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
Tested on a board with 8 RX/TX DMA channels behind one shared
interrupt. A peer sends 10k UDP packets/s to the board and the board
sends nothing back, so there should be almost no TX work. Every idle
channel reads DMA_CH_STATUS 0x4 (TBU only).

Per second, averaged over 10 s:

                       before    after
  hw interrupts          9071     8580
  tx_normal_irq_n       72572        1
  tx_clean             ~73000        9

- hw interrupts: the shared interrupt line, from /proc/interrupts.
  Unchanged, the RX watchdog sets the rate.
- tx_normal_irq_n (ethtool -S): how often dwxgmac2_dma_interrupt()
  returned handle_tx. Before the fix every interrupt reports it for
  all 8 channels.
- tx_clean (ethtool -S): stmmac_tx_clean() runs, i.e. TX NAPI polls.
  Each spurious handle_tx schedules one. What is left after the fix
  is real TX and the TX coalesce timer. The "before" value is from a
  separate run with the same setup.

No packet loss before or after.

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index ff83858ebc..0a6e82a155 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -346,7 +346,7 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 		u64_stats_update_end(&stats->syncp);
 		ret |= handle_rx;
 	}
-	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
+	if (likely(intr_status & XGMAC_TI)) {
 		u64_stats_update_begin(&stats->syncp);
 		u64_stats_inc(&stats->tx_normal_irq_n[chan]);
 		u64_stats_update_end(&stats->syncp);
-- 
2.54.0

