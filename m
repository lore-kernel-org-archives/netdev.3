Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91D46EC73
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552721; cv=none; b=OmFgldBIMAtyf/8sVNUjPyngXrK0xePLQvaM2+2bILE7iCQoZsheuUR6vCMKYd8HJQIJ7rMAJUXSFFEv7jWNBQ8hEcDR7MK2qHZKubJ9zAq65jC2Vols3rG77BABY8q86UfhSLUpIsRMlTufk8tJZSeAqWftpFXx4JAENE3g9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552721; c=relaxed/simple;
	bh=0nnGs9BKmMrogR6D9UzkP/Ffhn2TfdtVFYK+MpuOfuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhbLTfAisI6iyv5Gtxadx2LKjlL+qe/KX8OlnuO1nBNSAaUnF9RYjdX2n/hH9Xr7GPPbKXs2PiUHBiNbNUvz7zq39wOpFtNfnr2InfLXBJnDpfinyW5DVYcIzTjbLmNUuYQBnhG4Y5gA4JLXTX9dBFAg1M7JrLNkY9znpotH/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=YFNyQXPm; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="YFNyQXPm"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e6391b114so97843285a.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786552718; x=1787157518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PCmXTVYaRt4RiBQRwuD2RR3u3e6JKLZJQPNiKvz5wI0=;
        b=YFNyQXPmM/BA2ViVyPl6PaMCqN8MqlL3wAa8543zHl5Kwj5KsP/LHmrFkQLCxdZlyF
         lMv6d6y2mrSv95HALMQnv7nPt+cKGTeBWotrq43OFT+F/GteToNl05XDlxrxqe8Zr4D1
         LIt4aoye0oG4UQcRXyuLGQEll9g8T12r856KLOubJZO5H6nj82JIMxMyaJJ8PbMFJd4t
         QehgpcO+4cJbw5gJanp3H1vJ57++58SkBvaFGYOyl3wmQOvy4YVcBq01IjulUipqMzf2
         F9Q/9FQspZCfZaYOsbolKJGDNR+ybZGEm/TqBelrjvLNTFGhzW+mT7vVt3eKObA2skMN
         cB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552718; x=1787157518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PCmXTVYaRt4RiBQRwuD2RR3u3e6JKLZJQPNiKvz5wI0=;
        b=DK66CsrMQ7Oe+mwm3tE/xiexGRkJedxPo6kvEYHcz3vGMIksqnK8JpAgBTBRc6sr4Z
         Jkzmj2mCYZyaL9MDZuNFmF+nqp4NETqI7cO59A53yYIPBJGZ1OTrQimVs5YKb/QkjshQ
         mgzOtdpQORqaFi90rxn6LZQxJkpKD+qOcw1QOGHGrlRntPQ1J/ZrQkAiXT24IAAurbdq
         i6bdRMWnU+8/FgD1138tiGNVVJ2x7H6ddSHxLgnFoC+CH1H7ZWs9RuOKxK7FDqmHBE0J
         y+lUT/nhkwAP23oeD7xs681JHHADVgX6WqrrEFnClBJI1MOy85HM5hqwz/HwfqbLMlhn
         XEWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQFdRMFyMDsfKWvMwvaQ1oCOvtK2Ge2AgkkPJixrnmkeph4a7GZfKNn92tV3xmxTg31Krreos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnuX+RYdZXuRzdrRGsv5PTPNq4BKKI9/Y0BWr43jl719ZF58l
	ozxaCMqoiX+DjvTUzag0c88BLwJ9AQ82bKKPw0CvemAWWPYxyhLRZbwpRUobU1GiqZU=
X-Gm-Gg: AR+sD11BY4SMsrDuMsML8ebKKbp6Xn25ftBCA6suL3MRMprKabCH04/PLkYUsmy4Zkv
	lSBHRyBAAMNH6Snfrvz7PLOmHowKzREwCPzG99iifpNW6CKCFF1bJhlMIe2r41Gb+PGIzcyt+w7
	3fvM+SgYrphXHkqiLRV/ILq7wiE3/xCo5bzFftS+2VSD9mWfmiD0w56H1/PNmn5a0xD/dxokvBA
	JHzJk3fNNU7PeUyAAgBYP2rN3C2pznUbe0Fi9l3XNXCh2keSqSQkn062rSPf1SeG4qcoDfWuVdz
	MqpXDBlRrn1aPZN2pbeFTRE9dgYRJYWAi/VqzNeT7kRGEbMcWu6+vqgHnFXLS/3JwdzRt1BEBnB
	mNwxAQwsUU9xis/QpgsrLLMIEPnJ5PBGvessf0TnsWdg1LsB8B/OUnh0Nnq/CHWboamupH0oK7k
	5GcRxSJfaw7+zZa/9lAHBOQWOSpf3LwW2seBPP06vgmP6XoC6ywjMBIVzcrOnohFav
X-Received: by 2002:a05:620a:19a7:b0:92e:7533:ef63 with SMTP id af79cd13be357-936b3a82f84mr533659785a.13.1786552718202;
        Wed, 12 Aug 2026 09:38:38 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5dd3d4dsm166040385a.3.2026.08.12.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:38:37 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: stmmac: convert DMA address to lower 32 before assignment
Date: Wed, 12 Aug 2026 11:38:31 -0500
Message-ID: <20260812163832.271742-3-elder@riscstar.com>
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
there are places where a DMA descriptor is converted to little-endian
byte order in assignment.  The DMA descriptor could be a 64-bit value,
which makes the 32-bit byte swapping operation seem a little sketchy.

Explicitly extract the low-order 32 bits of the dma_addr_t value being
converted into a u32 so it's crystal clear that we're doing the right
thing.

Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c  | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index ec25193d287bb..66025e2509e91 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -37,7 +37,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 
 	des2 = dma_map_single(priv->device, skb->data,
 			      buf_len, DMA_TO_DEVICE);
-	desc->des2 = cpu_to_le32(des2);
+	desc->des2 = cpu_to_le32(lower_32_bits(des2));
 	if (dma_mapping_error(priv->device, des2))
 		return -1;
 	tx_q->tx_skbuff_dma[entry].buf = des2;
@@ -55,7 +55,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 			des2 = dma_map_single(priv->device,
 					      (skb->data + bmax * i),
 					      bmax, DMA_TO_DEVICE);
-			desc->des2 = cpu_to_le32(des2);
+			desc->des2 = cpu_to_le32(lower_32_bits(des2));
 			if (dma_mapping_error(priv->device, des2))
 				return -1;
 			tx_q->tx_skbuff_dma[entry].buf = des2;
@@ -68,7 +68,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 			des2 = dma_map_single(priv->device,
 					      (skb->data + bmax * i), len,
 					      DMA_TO_DEVICE);
-			desc->des2 = cpu_to_le32(des2);
+			desc->des2 = cpu_to_le32(lower_32_bits(des2));
 			if (dma_mapping_error(priv->device, des2))
 				return -1;
 			tx_q->tx_skbuff_dma[entry].buf = des2;
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index 664d8cfb58cdc..f7949419eb9fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -40,7 +40,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 
 		des2 = dma_map_single(priv->device, skb->data, bmax,
 				      DMA_TO_DEVICE);
-		desc->des2 = cpu_to_le32(des2);
+		desc->des2 = cpu_to_le32(lower_32_bits(des2));
 		if (dma_mapping_error(priv->device, des2))
 			return -1;
 
@@ -48,7 +48,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 		tx_q->tx_skbuff_dma[entry].len = bmax;
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
 
-		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
+		desc->des3 = cpu_to_le32(lower_32_bits(des2) + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum,
 				STMMAC_RING_MODE, 0, false, skb->len);
 		tx_q->tx_skbuff[entry] = NULL;
@@ -61,27 +61,27 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 
 		des2 = dma_map_single(priv->device, skb->data + bmax, len,
 				      DMA_TO_DEVICE);
-		desc->des2 = cpu_to_le32(des2);
+		desc->des2 = cpu_to_le32(lower_32_bits(des2));
 		if (dma_mapping_error(priv->device, des2))
 			return -1;
 		tx_q->tx_skbuff_dma[entry].buf = des2;
 		tx_q->tx_skbuff_dma[entry].len = len;
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
 
-		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
+		desc->des3 = cpu_to_le32(lower_32_bits(des2) + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 0, len, csum,
 				STMMAC_RING_MODE, 1, !skb_is_nonlinear(skb),
 				skb->len);
 	} else {
 		des2 = dma_map_single(priv->device, skb->data,
 				      nopaged_len, DMA_TO_DEVICE);
-		desc->des2 = cpu_to_le32(des2);
+		desc->des2 = cpu_to_le32(lower_32_bits(des2));
 		if (dma_mapping_error(priv->device, des2))
 			return -1;
 		tx_q->tx_skbuff_dma[entry].buf = des2;
 		tx_q->tx_skbuff_dma[entry].len = nopaged_len;
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
-		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
+		desc->des3 = cpu_to_le32(lower_32_bits(des2) + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
 				STMMAC_RING_MODE, 0, !skb_is_nonlinear(skb),
 				skb->len);
-- 
2.53.0

