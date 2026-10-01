Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D23BBFBF
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830418; cv=none; b=kRKmZSULXeDcCO9FTyBkHeHXWC+vLyotGObE62iduFXFpADaWQghkpB1T5xzvJY/3UoVY2L0avM6Rg8NzkyeegdhvBIjLH6bnqI5POxjYWY80YWLIA8tFRTmAKVWaEXAi+UjnVtZ3m2sD5CJ1G4TlMaKKvt6fY6SURq2HevkIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830418; c=relaxed/simple;
	bh=5Kio8RtxV7sBc0mpDH2TvnykRXHYCC/NufCuroxXloY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Byy6UjYcjtaFjH7b0UVet5HaSeBA9T3a2iMN/s/rDVg2x9YokNiPoqFzirjeFGAjH42uFqmzyNpw4l2eeHcK3372zs8DLvxpWteYWTJSpT5GTyXc3YkQH48krxCCbZyNmMUIhNl24A67sbEgQOpJOcM5eHKqrv3yXj82fxmHVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7Uz7MIP; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7Uz7MIP"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b02c279beso3672515a34.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790830415; x=1791435215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qGfEP9YKt+sxdoo5ymI5NTrv8fzOq/Y6MXhmWkaNL/o=;
        b=P7Uz7MIPwKZKU/3MxfHGcKeicN21TiKm7/89c4dZuZVHo2bQmI6WU3nfvT5+R05BNQ
         7m3+Btg6I/tSLsXLTp+caa2Ntd0kwkQX/bWGwoO+GPpyuxBwdZUY2t9ZP1qQ3gaJq6kD
         opjDgLrDUPLDnf+zCpIbzOQd95bO/bySUv/CUmeI+mLoMZx/9eqVkzqRlTe+V3AyXMT/
         DLy9uV2806gb/5FXhoFA7WKa3hGetQuy8fma3ysGs8WMar6z6FGYYMfYhll1kfxp5Phh
         KTJOMWXY9sweTmhLH3w4I/3JuDhDzmPqWFY9ZnRqVj4Bsy2TNApr+qOwtiHoTK3pHuNI
         R6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790830415; x=1791435215;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qGfEP9YKt+sxdoo5ymI5NTrv8fzOq/Y6MXhmWkaNL/o=;
        b=qOaNQ6XHLCveP4Oi6yxZcR/weM6Bmylz4RYcPvbJzJdTmN2kiMwvz8TQWP8Qh/jgG0
         CZdk+0kXAlJw5sZCqnh1B0IkqlZYtZDVsD2jin7xnRZ5Oe/f1sew1V6itWLwc2hC6C+K
         gQzMnClR5xlDsjT7yiu1F9AKtUoOQNQi5Il9wLUbpufOC/LcFU5PME+yvFmD1+YMCuaI
         ekfaSquugFNh/AP8Z0CHZJeuKWLzd3XcRnVjgydVem//vi/zcxXn5MkE88F3GuWiDsbn
         upEW1R3H+fkCFvka7Td2S9vANY3JgVbHc5O/JzDnwslM8gUGu3ydlSsuS+Arjr42i7UV
         ot+w==
X-Gm-Message-State: AFuF++mqnnBkWzWd9g4XHQ05rbk+3TZzn6ldgi5DogyZ3TD9PjnajaxX
	nxeUh5dRwn2Wzg0fDoL7ymmHClCQTvAYO0otJuIfEafGidU1YPpii2d4
X-Gm-Gg: AYBFou0JQMRaWXWPqx7FANF622TdnkitKY/nr7H7IPKk3b/IRtttqrwU7WTxeUgERCD
	HOAdiY3B+SbRnJVOptqmJb2oU/c/uy5PVecgD4PYTbyx4gb8ZVwhFzK6ZTS5D1d4Fw50fbm4WHy
	NnfTR4N5CLt0X8s1Unguwf7Uf7mhuDv7qVxzqv1KIQt82BwIEkfv9vEoUcAwVIPC4MIw1a5xXb+
	eJget3eF0FBWpiI0YxePMBMqYoS6XWAeKV7xYgwTSu1AFwtNut5U09v1mBTr0Ugy64lYJF8EMZu
	XyHDDSfWALfU1KI1M4PVeYkOebJC8Yw8UcbSvJekkyzBgg1cGy7zrZ03nFszR9ny+aga//0gTJY
	/r5g8y2KS9hctdVrc0+8rumA2wG6cANsIihuPUMw8i9BLj6qwdPzwrItH4/JjH5K4i6fIP+slzI
	yDCq+d7xbNJzqUoKkDY1CxSAOEHInr/3b2Vp5Oy1aS5JWSbLducTOQHYKSLtpQ8bL9SzFNwnKnk
	NFtENs6sZySdj/o8b/RGFEsD4gWszqaCesKh1+pFrlrXCimoLAj/al+ajkYLArY9qk60j+kYvKq
	XFLVC/JzHxbpMUQd5JmM4Bjo7jrO2B5tQo5oLFFo0LF5Kg5HaN/JduIPx4v2DtXWbuW3PmViogX
	V9FMMHx9Jn59AiUJRsvyjraZoqW7sIYw=
X-Received: by 2002:a05:6830:621a:b0:805:352c:a6a1 with SMTP id 46e09a7af769-8204aa5b392mr3774356a34.24.1790830415616;
        Wed, 30 Sep 2026 21:53:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212aa1b208sm1788977a34.14.2026.09.30.21.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:53:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 22:53:26 -0600
Subject: [PATCH net] net: stmmac: take ownership of saved RX state at poll
 entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-stmmac-rx-state-v1-1-c286c43813c1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MTQ6DIBCFr2JmXRJwLKBXMS5GHFoWaAu0MTHev
 aTt7n3v74DMKXCGoTkg8TvksK0V1KUBd6f1xiIslaGVrZY9SpFLjORE2quiwkJ2Co3iDtk6qKt
 HYh/27+MIKxeYfmbi56u+l38yU2bhthhDGRqD5rqgRd1RT6S1n1EZpWfHnj1aYkdLbViYzvMDl
 9fpd7IAAAA=
X-Change-ID: 20260930-stmmac-rx-state-041371e43e8c
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

When a saved partial packet completes with a poll budget of one, the
old loop can leave state_saved and state.skb pointing at an skb that
has already been delivered or freed. The next poll then reuses that
pointer, causing a use-after-free or double free.

Take the saved state at poll entry and clear the stored ownership
immediately. Save it again only if the packet remains incomplete,
including when the next descriptor is still DMA-owned. Release a
saved partial skb when the RX ring is destroyed.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ec62fa7418f4..1a4d03aaaf78 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2149,6 +2149,11 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
+	if (rx_q->state_saved)
+		dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = 0;
+
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
 
@@ -5726,6 +5731,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	struct stmmac_xdp_buff ctx;
 	bool fcs_stripped = false;
 	int xdp_status = 0;
+	bool in_progress = rx_q->state_saved;
 	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
@@ -5740,6 +5746,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+	if (in_progress) {
+		skb = rx_q->state.skb;
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state.skb = NULL;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		unsigned int buf1_len = 0, buf2_len = 0;
 		enum pkt_hash_types hash_type;
@@ -5748,12 +5762,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		int entry;
 		u32 hash;
 
-		if (!count && rx_q->state_saved) {
-			skb = rx_q->state.skb;
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			skb = NULL;
 			error = 0;
 			len = 0;
@@ -5787,6 +5796,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -5971,7 +5982,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
+	if (in_progress || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;

---
base-commit: 7375d38364a9aa66fb31716bcefef38aecad75d8
change-id: 20260930-stmmac-rx-state-041371e43e8c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

