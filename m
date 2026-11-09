Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248760;
	b=HoDhNF6dofmuwXwjnErxBZpflAIOZeZ0qfdn45Gze3hfkAIKxzmKBYnsEvq4xD3kVxxV
	 QA0ghDWD/zPitVMgidMSTzG7z72kGDcmpQtHPAr6I0RWg3VymTNEPjUrKvgoPlZIKJQlm
	 /cMKY0eXoso7E6SLZH1E/4CDJn/Pxxa3KxM4PG5qBcmizO+xKsIQxMh6akDCQcHMK2ZEX
	 E4ccnqSGA/1kys9SudDfnl+6RRrIK24M8JBFgsLmtH9wFloHLdbhoNGoenL9t5QTem9hS
	 sNwEWS/gL6eJfpHZuDvP73xT2kuSmYUPEN+lHzaKC8ZI7LuiuFP/SfkDM6AFTckbpcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QwEhXQGhncgxAenLKf9FgZtSttnofeN4/QkcfEPx9jk=;
	b=rwKeoxGCLwwvsi+wCAr6j/Jgt48A4mBMu8pogdHvEjT0FWtCSDOSoZh6JMSUqA6mODQq
	 T5jFPlZ68QNOM63SRm/BWii6yh/uVK3z2Xzh9d0RaBDiJWP69QPSbtZFDyld7R1INlXIY
	 NwV03Pq+hfMq1pb/LX63NHL5ROtrxFj26Gjtw+8+Kx4GqH2gc+7EGbsTALj8N18+KAZ2t
	 pucz28GkKDcD5I4acSZ9FZWPR3PsrnTp9IR3PtQKY7P+NYQyx3tjjP/+yXw3ajxj19RnT
	 ImZ1JD5tyahRrBW7dhiEspriXECmqfEt5ITqd4B7MaFrQ+x7WWCgjSG+wJfTiuvsu3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AvIo5Cen;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667A606F3B1
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7667A606F3B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AvIo5Cen
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c42888c50c4so110493866b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248759; x=1794853559; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwEhXQGhncgxAenLKf9FgZtSttnofeN4/QkcfEPx9jk=;
        b=AvIo5CenHwqJzR0/aJvWxFF16Sm33oH5itV/RnAWKoJNiKZaHyjmxs7yggU3oZzKS2
         wo1L7TCp83gitouvSBciLM1T2iE0Pr27jaS5tvlvsvWE/8bmY9O7lGn35qsVCmUl/+VH
         I5e0hWUb8ycsB5gEjdjyvnncJJ/We9yLpkk4vY5KhGsyF6thkS8RNCkaQVvdO3dJrc/b
         o7npwPhhTJ0hpH91FBqWkuarog07XO6YdY44//RHEU8cWvmU6QGlL6Q2vQ0RYf80PkW2
         sJ3DSGi1kV0jIofBK8rjXFVlow++yi4U9cK+y0urrlACc75yW+onGAj7erJHnYg4P/Ku
         dDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248759; x=1794853559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwEhXQGhncgxAenLKf9FgZtSttnofeN4/QkcfEPx9jk=;
        b=DsYA4RLJhJYfaS4Rt952x9c0ooF0LJjUpRODVWiiiPevyWyDdLXspdduObmNevcoLb
         y3slyhEy1ZPpCslD14RslLw3Xd7ingaZDFfw/WJ37YFDdRxx1cG6W7hiB/sH9oji9dR9
         JtX8R/4Ucg8OQKVoZXmySdfrAOoOl1x9vrCekyde60A4H2Tbq364IvO6RiJow5ZD6U18
         HmG2QFnI3OpvNs3TyCrz0iJzcaLnPgR3FNt4eag88WbU9Xel9yQng/96vGD1OTJvjmsZ
         5VhIE0OW/G4URCFNklSQUQRoaXaeyAb16a82Z9eWwBfA8GiXPuROFAtK4E/gS6sfgRYZ
         4gQQ==
X-Forwarded-Encrypted: i=1; AL+hErGbUX0g/IGjVkcIIpjDMWH54UsEFcPrIrOeT2c9HL8inIm5T0o18vuVI9j/otQACNy8zczmYfc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sLg5m7hNXY6eBFEm+/vmUVdCVbneA5BWdPgo2cME1TsrTD6pf
	pVLRHmETPtLfADY/Um6DblxX2B4z34t/TynsOIaW0qToEjj0oCj1DZETb1pXZ40dx8egha9lsQa
	GZLsbCA==
X-Received: from ejcxk8.prod.google.com ([2002:a17:907:d808:b0:c4d:1c8b:9299])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:2f06:b0:c41:5e31:5184
 with SMTP id a640c23a62f3a-c504951eb65mr12737766b.13.1794248758596; Mon, 09
 Nov 2026 10:25:58 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:29 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-22-lrizzo@google.com>
Subject: [RFC PATCH v2 21/25] net/gve: Use GFP_KERNEL when pre-filling RX rings
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

When pre-filling DQO and GQI RX rings in process context before NAPI is
enabled (e.g. gve_open), use GFP_KERNEL instead of GFP_ATOMIC so page
allocation (and CoCo page decryption) can sleep instead of dipping into
atomic reserves.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 7 ++++++-
 drivers/net/ethernet/google/gve/gve_rx.c              | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 6880d1531ba5e..3b13aa4999ae5 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -223,13 +223,18 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
 static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
 				    struct gve_rx_buf_state_dqo *buf_state)
 {
+	/*
+	 * Use GFP_KERNEL when pre-filling RX rings in process context (e.g.
+	 * gve_open) so PISA metadata init and CoCo page decryption can sleep.
+	 */
+	gfp_t gfp = gve_get_napi_enabled(rx->gve) ? GFP_ATOMIC : GFP_KERNEL;
 	netmem_ref netmem;
 
 	buf_state->page_info.buf_size = rx->packet_buffer_truesize;
 	netmem = page_pool_alloc_netmem(rx->dqo.page_pool,
 					&buf_state->page_info.page_offset,
 					&buf_state->page_info.buf_size,
-					GFP_ATOMIC);
+					gfp);
 
 	if (!netmem)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e94..89f287b678bf0 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -161,12 +161,16 @@ static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
 			       union gve_rx_data_slot *data_slot,
 			       struct gve_rx_ring *rx)
 {
+	/*
+	 * Use GFP_KERNEL when pre-filling RX rings in process context (e.g.
+	 * gve_open) so PISA metadata init and CoCo page decryption can sleep.
+	 */
+	gfp_t gfp = gve_get_napi_enabled(priv) ? GFP_ATOMIC : GFP_KERNEL;
 	struct page *page;
 	dma_addr_t dma;
 	int err;
 
-	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE,
-			     GFP_ATOMIC);
+	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE, gfp);
 	if (err) {
 		u64_stats_update_begin(&rx->statss);
 		rx->rx_buf_alloc_fail++;
-- 
2.56.0.542.g3ef89b7020-goog

