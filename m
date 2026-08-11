Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154A2F5A12
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476431; cv=none; b=B4JDXJiCRPWMYhF78/l+dXKFc/oHaer6VQJHoBZBixFW7KAia1BusGdZinQPhVn4uZsYdNnCEBPsr0DK+RYY021BYOxX5F077xULz46g1gTvxwsVAHOebIp+g3oY3Y1aP969hiTB2t8AsR061kn+71s7EvJtkz0Hi6EPLVRsz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476431; c=relaxed/simple;
	bh=BMOKZKEeinEKCN0a9DkPEKX4u006R4NgANwevX5X2V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pp1WeyTzjp/fyQvmRm6KE8MWEnKN4xLXYLYI0Tt7b2Dm+AJ8yW28/jDKjKGFImyOMVqBwGvqTES5HY63eF+UkGGQRRe9xl2uTthzBLvf2XWipewzsXVt2wmRmNp7qlTyFbEuvRW5Tr+BJLDAQhTHJXFs+7AMPqj/Bh05HXQ7aVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=RLD92B7v; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="RLD92B7v"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-907ae240ac3so1434626d6.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786476428; x=1787081228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8CJ6QNSqhWJGSffyTY/ffGanQulWe1yCj+00GIgVmXg=;
        b=RLD92B7vPW2lv9HbX5Ne64QIf5a/hKhGz9MA1vRoE3Mi2BqEt1CU/AYuOk444YFX/r
         Wa9Uv4CdnWOo3NGk9q5rjNooLubNw9jowbCjZWhbwRw5S62euK/3a9KtlaSJpNTB/aD1
         P6+zbtahUghJYZWBIs4VV4zQiIYi3eFejRyimUKmnfLGSla22xSjddykWkwgUy6kZS0C
         J8canVLH+iURb+KhNaUOY+0Zemm7XG7UwSJDyUeFRooLu747qhz8ocIL/BgvcJuc4s9w
         dUeWKBf+rd6tju2gSZDd10UY3rUxPb4D+QK2fFLjrDGweRk8cBz1YA6z74kNH5KdSTAP
         0vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476428; x=1787081228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CJ6QNSqhWJGSffyTY/ffGanQulWe1yCj+00GIgVmXg=;
        b=mnOeIlGcbqhpa74VqQm2mcgwafF6gPWW3/UbTx7U1zarCU7arYx/0jnTlQ8Np2fdwf
         Rr3X0+uusocxeOXTnM7baPfWxG7iPB+yDLdK4AQbFa4QMcOQAHPgJjA7hyrT20cYz3HT
         2NNJS1+ceZsTnwp+kobfKE0zMV65YuIfXSEHu0B9Mr51yRXWOyyPIbsFeuWrbbR8X1/I
         JjdzxHeU5BYGWgSMjybN6K4FmOrcv08TxNrx1k5S1DNgBVZF06NrJscSMElm074o/JA8
         VxnMcwUFBsXNFkng5jw9kJoekMvjn80fuGRQFfygU50td1OZ9XsT5sFvcgbGlrr+OxKC
         UHVw==
X-Forwarded-Encrypted: i=1; AHgh+Rql7Tt7VEBy2aGDZaIfENVUZfkM11m63aTwI/VN2ZWF0n10LgSK+3RvP20eCU/czdl6mKg5ARQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyot+oYvqN2IA0vgyUrF87C0EihTIU2T5rJJueD1jqHI+w3dj1k
	0d3EPOMErE1Coy2U/XNGteIV4x63r91LlAXIKc2JH23UuqXdciqM9atZ/gPVpAwgq5Y=
X-Gm-Gg: AR+sD11ovDzHtvv3nGMwXemXT7nYMmJH3n48qIqdscmJWzvZFNmZBz2eYMz/P34nM30
	AvN6F73hsjzLC/HWxJeRVURdvWjnox2GK8yBZBq4P3Cpg04XkarmjpYRlTcvukAvqQKf+tHCiCB
	kc1woGlF7duKAVkIw/+gZj3m9GzdxIEUd4+qphyexSb/HtxkoDvrM3Trkl5+XaLuF1yiz+7Kqv/
	NJp4Yk4ffoiFOHnvMnWmrK8r1zJcoFCRh1Y7RiGT5aV1Sby5CUj/wZFWtH38kymtgkOjzURWO/5
	UHOHoH0brGxgJt4kfSW60MLZ1VlLJq44xRr2lkzYRsxbHQcDSucdoqC3YDgJ8OUNExCxWqCjIVB
	C7zA0eVar+mmMSPP8OuQrRT4/pmBX0Pw967yuj/FDBSVecReZHbvrYsJED8jKSia5csnxSXWuBr
	YM33Qsll5phg4FMfmMAEa2B87Ciw4yNos8bdHXyrJyFsYI7zbdIGXi5qMiHq1a990mCyVpoaXR5
	ao=
X-Received: by 2002:a05:622a:5592:b0:51c:22c5:daf4 with SMTP id d75a77b69052e-52d58614af4mr54547001cf.28.1786476427825;
        Tue, 11 Aug 2026 12:27:07 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61a399c8sm3228451cf.0.2026.08.11.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:27:07 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] net: stmmac: use dma_addr_t for DMA addresses
Date: Tue, 11 Aug 2026 14:27:02 -0500
Message-ID: <20260811192703.1765416-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In jumbo_frm() (implemented in both "chain_mode.c" and "ring_mode.c"),
an unsigned integer local variable is used to hold the value returned
by dma_map_single().  On systems where a dma_addr_t is 64 bits, the
subsequent dma_mapping_error() check of the returned value operates
only on the low 32 bits (whose high bit won't be sign-extended).  In
this case, dma_mapping_error() would return 0 (no error) even if there
were one.

Fix this in both spots by using a dma_addr_t for the local variable.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-devicetree/20260606010122.21A211F00899@smtp.kernel.org/
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index fc04a23342cfc..ec25193d287bb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -20,9 +20,10 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	unsigned int nopaged_len = skb_headlen(skb);
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->cur_tx;
-	unsigned int bmax, buf_len, des2;
+	unsigned int bmax, buf_len;
 	unsigned int i = 1, len;
 	struct dma_desc *desc;
+	dma_addr_t des2;
 
 	desc = tx_q->dma_tx + entry;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index 78fc6aa5bbe95..664d8cfb58cdc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -20,8 +20,9 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	unsigned int nopaged_len = skb_headlen(skb);
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->cur_tx;
-	unsigned int bmax, len, des2;
+	unsigned int bmax, len;
 	struct dma_desc *desc;
+	dma_addr_t des2;
 
 	if (priv->extend_desc)
 		desc = (struct dma_desc *)(tx_q->dma_etx + entry);

base-commit: 31397cf1819210bd63fa3d2c7d8c24f7c8667d99
-- 
2.53.0

