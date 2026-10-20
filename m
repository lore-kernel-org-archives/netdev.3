Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523010;
	b=KyvkivulAUQfwcFOhtYDqYkt69S4rhr9PSVy9CbVru3hMd++Q07mtUpM1eThvBOnBp/a
	 fBZbnynQrNjsUKacmpFvLvzMwLxnrTT39FFZAqtBDbPNhvKksXbJb9ZOvK8Tg3n0yIQ0E
	 BNEDJYRzS2tx22aB1+dNF/xWYxlYUYfSQafyltj/90xCMESjFqgdPZ5//b4/RamdRJLNq
	 bf9JkVzb0mloohwZxHjtYZeM4rM91YH9CLcKuzxahu/AFyi5up7BnRqG9yHQwwvTHuhjW
	 Qv7FP9tc0G7IU5G9jUo7byuPiU2V2tQlu2ibnWIs46uFryDDi/ApL3XjnP8alm+usow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523010;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uC5zYyNDKu5QdLJSVPD/ZbHeH86phuOD6U9spopPKrw=;
	b=nPweZNB8FDBGGRIXmluX+4Zqrofxiq73vuySzgKkqIKnGdUNSkZXSpv56dbwnwTX1X6f
	 MOUfBX6x4d6KkRs77GRz6eyJzYzoihms1PT+FQ5eDnhD1CRxs9ATidFIR5HGGZD7LxH4d
	 tx527TiX/tPEVcsMKEx8PAE1FNxyANUDUKq2GUBThPDYP5OyMtzJop3R5HEUWlD98Av1q
	 wKvNKA8sfkw3NAkdrMqY8Dt1BK75+U0+z0SInymti9QUhWY4nB2X/ZJwXZLadCd6PFQDl
	 eW5KrPdor64YKrPUYwOMEDOmYYft/9ki8MnSsNLcNRwybiV7Fb2iPkTeiRGhjtblNSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC7606A334
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1EC7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso24763645e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523008; x=1793127808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uC5zYyNDKu5QdLJSVPD/ZbHeH86phuOD6U9spopPKrw=;
        b=vaJjml7Ynn6zLnlV2RSPATiGiObI0dAkaMWVS6W441hJdE4RLaCRdi3E1dPhRMtAuF
         DUrQdow/zM1HAniO2PUyqnwJhJQYp6f294my3u5l9gnvMp0f68Q/ADaufxhn2sxXuNYG
         Upt6Rlx3u+mytyTYxbO2h7mDdNuD7jChU6pFRkNUlZnrxoSGD7wYaVo+01uQAmGJzSdz
         uoDfyarr9Motj55OLt5oGp2kd/DFMZfvfkU/RCqPQOrai/MgGl6qLV+n9wBGVkl2+Ei6
         V66D3cTgQ8Gn7oMTY4Kiori8i+Oho3ZPVrO9WuVq8FyIDADGCaCnTeskiUGCxVbG+D8P
         P/AQ==
X-Gm-Message-State: AFq9FYJJdlzsESmH9NJYlN+folg3Lw7388i+caPegBMpcBTlriGZvJ33
	udAcrJaxHco7yGFpgqgvziNUAK7x+vhVLwg11NNfgjs/OYZSy9RBw7AwjDt8DWUfkQW+Xf9Jkjj
	6YTVykpFwyg==
X-Gm-Gg: AYBFou1/o5g0EpF3nUxmJkZt8XSlrW9twAIPakcQgmYFYcwXyGVjkQgwNAFSvDIKHu9
	mhAucj/FTOMKcU3FQ9pN9jGLs2gA6fpevn1AaeevgrJrQQyl88HihOUTSAa0Q77BOICn1AQ8JVh
	gzwRi1TpHmdURmBBTIgIrTuAGUbj/7juCKYd8HPCJkFzCemfAXszqJXAkXd9NDnjuOij7vrZAYB
	H4HbljWdB+lScvyAmkacId9BJNKBRlx91mXIsUG76+m82e+31NZfjSADgDWwxjl8XgvVYDm7s/V
	AYIMqtYHA58DZQRAX6nS8QdkqPLemeAhY0w4uLW+KIWUMWXgsA++U8p3X5GulJ8EQkj9eXc4Q26
	DZtvdNkjXiK6R4qZcXkBrmhpSafuBqASCQa6blPk+Lg6t6DJbWgqhHidQF6ahCYi1rXLrp+ygCq
	Cp7flEazwkhTNVsZUl9KQWwjOa1HKUbAxLRi3dBc+j4o4fRw1+4H6FhxOHlr6LdRUG8IY=
X-Received: by 2002:a05:600c:8709:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4a1d75e3eb5mr232302695e9.11.1792523008071;
        Tue, 20 Oct 2026 12:03:28 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:a3ee:29e0:454d:c31e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm279157f8f.23.2026.10.20.12.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:03:27 -0700 (PDT)
From: Grische <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Grische <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: stmmac: dwmac1000: stop hardware from dropping checksum-error packets
Date: Tue, 20 Oct 2026 21:03:18 +0200
Message-ID: <20261020190319.884375-4-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020190319.884375-1-opensource@grische.xyz>
References: <20261020190319.884375-1-opensource@grische.xyz>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the checksum offload engine (CoE) is enabled, the dwmac1000 MAC
silently drops any frame for which the engine detects a checksum error,
before the driver sees it.

This breaks VXLAN over IPv6 with zero UDP checksums, which RFC 6935 and
RFC 6936 allow for tunnels.

Set DMA_CONTROL_DT so that such frames are delivered instead of dropped,
as commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from
dropping checksum-error packets") did for dwmac4. CoE remains enabled,
so the driver still sees the error status and marks the skb
CHECKSUM_NONE for the stack to verify.

Tested on an Aruba AP-325 (ipq806x-gmac-dwmac) with Rx checksum offload
on.

Link: https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/
Link: https://github.com/freifunk-gluon/gluon/issues/3783
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
Cc: <stable@vger.kernel.org> # 6.6.x
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Grische <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 1de1f929d61c..004e6e30a68b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -163,6 +163,7 @@ enum rx_tx_priority_ratio {
 
 /* DMA operation mode defines (start/stop tx/rx are placed in common header)*/
 /* Disable Drop TCP/IP csum error */
+#define DMA_CONTROL_DT		0x04000000
 #define DMA_CONTROL_RSF		0x02000000	/* Receive Store and Forward */
 #define DMA_CONTROL_DFF		0x01000000	/* Disaable flushing */
 /* Threshold for Activating the FC */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 3ac7a7949529..00c8d4dfb553 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -129,6 +129,8 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 {
 	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
 
+	csr6 |= DMA_CONTROL_DT;
+
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable RX store and forward mode\n");
 		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;
-- 
2.54.0

