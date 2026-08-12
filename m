Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C645C71D
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552719; cv=none; b=pwfEPqPkHEk4LnogCqBx3qBpfTzDd5PbKINi/YmzGQQPQWO6e9bqwLnWap6UGaRxR3P8c8MQhiNaqa6aJh5jP6X+DYNWANnkMCfMQM/sMsQyrYRbakDuFUoMYepL4PWU2j0XW5xVVU3FgNswiIRO2AVCa1waRxF/MyGU3evvjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552719; c=relaxed/simple;
	bh=92rIbi/j6t5lwYD9hWWkDGqI1kpWcYVw3jfTWr1yGqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAShAVKH9BlLrCXKGavaBD21yy4k/rmS2tvbCHsKupAuZpCp5+m7Wu7ZhQP6o4XEYvYwT0N9OH2+kJNLPGDegN+4gs17r7bJiqTlGYPD5EjDknLGlGthvEXRta2wFotC5WlifO+p4dA1SPguxLETL3aPrRp5MbmblWzSdNAOJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=QjNThbZ+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="QjNThbZ+"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5b048375so49316385a.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786552717; x=1787157517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58Vxr1ewmacSO4oLjVc12aVhWqqIgFPJfyqFJRG5hDM=;
        b=QjNThbZ+3xIu+FP5nEFdi2ZdXRy+i+EYwO9ynkfIXQIgGeFhZuSwq1NExCgIcMWMS0
         pSEpH9We7AGj3w3CMY4rQIgmaYr6ZwMkXgSl8izqO5dYlbHJ0v+HMUwByBIqxFhEjJ8u
         2tHybrjAdpVHFn2W+upSq7KR3VBQfUQes8kxdW/q3BJN7+8Y52Ezc+BkcvhX2fp0hCTr
         BR5pliHt7BtCr8NbfqELY/YhaDUuKucQ9zthV3d7XFpz3KjVZvvsfiSSH1E+SIuk3SoI
         P7WJEVBJCfMzNbQdgBZwwrSRQR9myph0EP9pbOWsiIe74gdEBwPtyryatDjW/NumDuX1
         t1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552717; x=1787157517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=58Vxr1ewmacSO4oLjVc12aVhWqqIgFPJfyqFJRG5hDM=;
        b=DSQivJaCk4LxO/QHEPV5u9XZuXTmmt6fi6RFKcUCbI5lLf4sWn0Ahwn6kkGa2FIBZC
         dxs48d1QF1FIVdBYj+s1hBG0K88P+tFs7OacvGeSqYfm0NPuZelU8m4glcaZd8gmQOKd
         sI8q/GyPfKcPjr68RGGTxBz0WHUMEbgGLsJ7jTZVBU1Sy5MqyKvSThMCOwhGVE09N/ZO
         d0aZfZMME0vTWSqbhcPhtvl8A6AvnyRY8FgsHdcDdAAJpm+Q4B9BXsY1rPwNCAV6IGvp
         QTWr63/LKqRoRxlz0KyJPEZ5tSzC6BoXp/emczJVo3SHNsKPddQqgqT5VL2+fP4tcRsF
         796g==
X-Forwarded-Encrypted: i=1; AHgh+Rom6iH5f07Ps7oWu1HiIFIXy4ryRUVNGlwYYKw41KT0QKboDlRgSZ8l6XxF/BexFMRuP/GS1f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3qeAuMC8wbRDGk7LJ/5EW/uLXsJ83pZbul1H34Tw4/KeNhPI
	QmGDpmAvcmsNj+ag8Ljr+YcdmwLA7lSVnDmgaRPxw3PEBHG0N5Um9uRCDETpZGEmi10=
X-Gm-Gg: AR+sD13tGfDsvicqYGdtz0gVxXse1OhytV9tVO17JoKnkOnlsP0hEZnVtbpsvFU+Kkr
	2+IozLTpgpILAGczrCa0+lDIOpUYUC0qlf+5WxEpvqOQ8f2NoYeQX1V3NPr9bEwMa4eiOi5Rsry
	sMJIdcyqeqTa4Y7Arz2U8TdL9QEhrauTbJOWqaQ3CxEjjHXGoRyAf+mk8AWl52B7i3WHPSdXukX
	Y5kwmsxfOe2S6ZDhJCk1dp7Uhnf8eLwZly/BXoV46NNCX8SI387sdPpzpB9AOxo94MF20SnmjOf
	bM59PW+u8Q9UAdb+egAB68AVC+qwygaOo0wLCnKJXJ1o3rVSBM0lq1l5yxB3S/49VIhac/9geWc
	V+z08rLzg6jQgpRsyfjGvOV9APPehsOAWAiDZhK+z8W/G2dwBhGmyP+RXHHsMDZjoAncJS1yXJ1
	4lhh9OM27LZkkWinh5wYzd9A3FskIlw1J+NLqzyRt7hWofYaLN/k+PU0dCYppPSI6d
X-Received: by 2002:a05:620a:199b:b0:92e:4859:49dd with SMTP id af79cd13be357-936b3d3af54mr541451685a.26.1786552716869;
        Wed, 12 Aug 2026 09:38:36 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5dd3d4dsm166040385a.3.2026.08.12.09.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:38:36 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: sashiko-bot@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: stmmac: use dma_addr_t for DMA addresses
Date: Wed, 12 Aug 2026 11:38:30 -0500
Message-ID: <20260812163832.271742-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812163832.271742-1-elder@riscstar.com>
References: <20260812163832.271742-1-elder@riscstar.com>
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
-- 
2.53.0

