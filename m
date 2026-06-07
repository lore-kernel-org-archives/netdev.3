Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7F379982
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780844284; cv=none; b=RkywEfNjZWuQKw3TYZzdgZ6koRe72qVybYQ5nCycGCL3QqddMoEgXGY2+ufb/+cS0BefDHAxaZaN7Ajh5rV6/3n1Oc2jz0/3CmMzS9PnfcoTYSuEP/XbuaF7AIZU+D1tOIligiF57Q6G1w3bPf16R+h3B+f68Hq7MfSsJBV3JVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780844284; c=relaxed/simple;
	bh=Dlnm/MWdlb1q2yVcz5wGOnl1lNnuwa+b5TYnLN5AGWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUsfwPcFpI4If4c2CNsdcxawbVB4OfBTYIsHGp32WKrqt7f2u7KWadXKKea/wlmBOEYZhGU19Z2bFWRyVSPtaKPlRuR0O1/fINK1chdYsr6ja6Hl/sT9WQa4y0H8GAJqnYSpA14NlUcN9pSeSCBJ+McgVqDz8cHls4PzNIsFebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc+unYMt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc+unYMt"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so2182084a91.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780844282; x=1781449082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4iCFmP5W2TOUD6yv8YIsGIOcqi2pm6d8E58pu60ycxo=;
        b=kc+unYMt8lW2Xvl5llPw2QFnEZfLIl+6WdzH9Iroqt0AIE9KSq1BhsAGFnH96bE6qB
         0GOfNjrlyqKaf5KJaoNtgIzpZN4jOGQJRWzsM26mVPwyo/fNLrVO9ento8n91AS/2nPI
         LVlUb8OT/+ymf29GGM75/F+rM8xos+4P+pEADUetrOg6QyTMd45huwtRroRZT+kK0Rx4
         zytEbDNHH7dLGUyi90KXtBDwCcae2D/dogwqzWjncM96PElSr9YxPVj3TmEZLTVAt8XE
         KHMp46xINScKRCU05iponxuvWobPfL8csLHvgveoSp6eMuAIz2iMcxhbgoqONzHN1fU8
         3h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780844282; x=1781449082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iCFmP5W2TOUD6yv8YIsGIOcqi2pm6d8E58pu60ycxo=;
        b=JyIw6EP6zpsOYdlPp2NWya1REtMwamwqyoDm7LrgOVuDD1WksfrT0ELzgozLG3Oww6
         tAxMjDg5PBkcKvrSPPmBOVvMWHI3tVwu6SXi5DasudWQoe+YOMaCrF2uR8/FqGbAH1Xp
         ynRrypWQmimwfQPPb3Pp1EyNkCHCdpyJVJVnZxRMJ6Yg9qHxKaZds4VGyrj9SkegCbUf
         SA9FFECK9NCuctUQyLVllpKOD/1dRzCVi9K/07L6he0DkMYXCDZFsq7LHoCJDTZfEcZc
         O2ovsifgMMEgxGhurq1OYVaGHTn8YvKwG3yVrezaImoUbjWvYBbxgiBxlpQp78oWa8Wh
         FF/A==
X-Forwarded-Encrypted: i=1; AFNElJ8LiHJgAyCsjVsbVrhlXEfBhGHlwimjzM2LcNGaSmPqfpSuek8TjHKbx/G6LufeZUCr9akB38s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8x0qpm/Ak4zsX8rIyJp4ftDmkDeBFNlMU/c7vYq05Nh8CR50m
	KnZB2IEG+QnZH9bJLPCisWoIxH7ht+fyfGGKKsJQeyNDLaHbMTb6dxqh
X-Gm-Gg: Acq92OHUFgKbVBZfgQq/wWX4ZlbIJ6aI5iiQD84wJ6wKQaI0rYElt7dKafn2mwU/VvJ
	F4KTgi4sOzqGXYblOXXIVraw3Mcrep55xCHmUdnveP4o8qcxcww9kb7XXOYcWo1RjSAL+leUb4T
	BBcex/TScu7xRma40wV5+6sVUJNtabHatQqYBnP+8XMwfZAP4/SwAkibF/ahqS38j8V+BeHCnWO
	NLL2o9JiqmNV3VVGqGabZ/AHxvVeUUThAFdSPXZkL9rXWE3RAfVRtF0PoGmt1nHnmCcmQlYWH1F
	eljSlmqYQ/2pI4TihGLCueskKZpsRCyX2NdrR+upMm0MyDt3/MH1iacG30/ogLpy13ZCstDPZUo
	vq2txJ0WxQ6EBKmNwAX/AP15jWRJh2DFVwHt+PorHV2oyT+upx6Ve42XfmOBKygkDr3+g3HhlDV
	Rs26oMLvNjq6ZtYQH18w5l5CxGkNwyotbTHQ==
X-Received: by 2002:a17:90a:d643:b0:36b:b4a1:2939 with SMTP id 98e67ed59e1d1-370efda7ab1mr14484284a91.15.1780844282266;
        Sun, 07 Jun 2026 07:58:02 -0700 (PDT)
Received: from lgs.. ([101.36.111.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b56c5sm13227300a12.27.2026.06.07.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 07:58:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v2] net: lan966x: restore RX state on reload failure
Date: Sun,  7 Jun 2026 22:57:47 +0800
Message-ID: <20260607145747.1494514-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan966x_fdma_reload() backs up rx->page_pool and rx->fdma before
reallocating the RX resources for the new MTU. If the allocation fails,
the restore path puts these fields back before restarting RX.

However, the reload path also updates rx->page_order and rx->max_mtu
before calling lan966x_fdma_rx_alloc(). These fields are not restored on
failure, so RX can be restarted with the old pages, old FDMA state and
old page pool, but with the page geometry from the failed new MTU.

This can make the XDP path advertise a frame size derived from the new
page_order while the actual RX pages still come from the old allocation.
For example, after a failed reload to a jumbo MTU, xdp_init_buff() may be
called with a frame size larger than the restored RX pages.

lan966x_fdma_rx_alloc_page_pool() also registers the newly allocated page
pool with each port's XDP RXQ before fdma_alloc_coherent() is called. If
fdma_alloc_coherent() fails, the new page pool is destroyed, but the
rollback path does not restore the per-port XDP RXQ mem model
registration either.

Save and restore rx->page_order and rx->max_mtu, and restore the old page
pool registration for each port's XDP RXQ before RX is started again.
This keeps the restored RX state consistent after a failed reload.

Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Save and restore rx->page_order and rx->max_mtu in the reload rollback
    path.
  - Keep the XDP RXQ page-pool registration restore from v1.

 .../ethernet/microchip/lan966x/lan966x_fdma.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index f8ce735a7fc0..8272ad085150 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -815,6 +815,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	struct page *(*old_pages)[FDMA_RX_DCB_MAX_DBS];
 	struct page_pool *page_pool;
 	struct fdma fdma_rx_old;
+	int page_order, max_mtu;
 	int err, i, j;
 
 	old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
@@ -825,6 +826,8 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	/* Store these for later to free them */
 	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
 	page_pool = lan966x->rx.page_pool;
+	page_order = lan966x->rx.page_order;
+	max_mtu = lan966x->rx.max_mtu;
 
 	napi_synchronize(&lan966x->napi);
 	napi_disable(&lan966x->napi);
@@ -854,7 +857,24 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	return 0;
 restore:
 	lan966x->rx.page_pool = page_pool;
+	lan966x->rx.page_order = page_order;
+	lan966x->rx.max_mtu = max_mtu;
 	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
+	/*
+	 * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
+	 * each port's XDP RXQ before the allocation failed. The new pool is
+	 * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool's
+	 * registration before restarting RX.
+	 */
+	for (i = 0; i < lan966x->num_phys_ports; i++) {
+		if (!lan966x->ports[i])
+			continue;
+
+		xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq);
+		xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
+					   MEM_TYPE_PAGE_POOL, page_pool);
+	}
+
 	lan966x_fdma_rx_start(&lan966x->rx);
 
 	lan966x_fdma_wakeup_netdev(lan966x);
-- 
2.43.0

