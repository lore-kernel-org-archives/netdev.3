Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA083AE6FB
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751356; cv=none; b=uK1ZXvg8B7nMDqVi6gfb1h6M4oAuu9SciWH5COHFoNdlOLQik4Q+TT1Bz3ekPZovuN705i8A6XrbCweoGJ5rojYhDJRACMcJVXRTan9Mql6bkNQ1ckXxDKpSEwvoNczfD97MGZ/s5AZ94wvPZ+fJMASUoaMYKbpbOkwMlaR7MaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751356; c=relaxed/simple;
	bh=Njo9Scw+cZ0axzyruRFtQV57OOW0xRQgQiMV2RmH80I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nIoLzT9qSs5GXN3X7QuC8Id6FKU6rh86XLwTIjfyHhA8jrbiwZBpAtngOOBl2fXlVbte9+b1hIiS3HlblAaslWWNQxlNPZWtxnASZOOGnOcWOwUB5QawrVRL6+qcay0dMLOQkLahrd9uIGOu6paMaGX5S8IWoFX8shx5pMJ9fZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXUGx4/2; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXUGx4/2"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484f26852dso1434137b3a.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751354; x=1787356154; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=61NmZboWuvt14l6xEsYMUiDHdyYvEJ2BGOPR7D4eCzM=;
        b=WXUGx4/2whMrd34of/rrP33tA103ZemTcCiOewHIBFOk5+YAA7iILJ3UtfY9+NjLrq
         ew21VqDPPtJk35oDeqi1s5wJ3lXUnKC6Qry6wRgq7koPns6CpacEdfoBwFiM1ofndif2
         3OYZ+pjMKjTI8NkWDWw5E+3ws0Vd2sd2CNnzs1g4f54NumNVIHGkSqq3rTkEUR6wTP24
         2U2YnqHJ67dWBX1QaABi6oFBr5tCBA0YSlHa5RXgBFViDD6UDwsYecvemorbYhtEZ/fD
         z4Vm0knuHR0TJyS7KNjNOMXmDIHRG6hKVbI5u2a+y9QZLyrAJ7YZi6DSibU6NQeBQNWZ
         WIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751354; x=1787356154;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61NmZboWuvt14l6xEsYMUiDHdyYvEJ2BGOPR7D4eCzM=;
        b=ETmcR7QRkEB+xeBJrgPGsMaTe3JMazdeBCIzIx6R+dfNNGI9uy6WWN82oFOP3pvJoq
         zH7MzWvRkIw7ArZmMqvnyKLa0UXZip6Ck0azxoULfODQH0MSnu+oE0aCW2Bl2pK8ddbu
         PDg2oqGjH/BljHcmh3U4hk03syrx3UbKBGCJBxO9pAVcghbenmyfqCXIlfbF7Ph/ziWf
         9kW+Yi998fHQJaeo5G0lpcMrNMjTtiAmTWc1GJ6eTg9AG3TeCQgWW796fegK8tFC+TLA
         qp7D0vMCUyCvomr1grIvKNpsLow9im0iXXaXIwwCQNl2LefJCqjenR6LKiPck27IRd83
         7KIw==
X-Gm-Message-State: AOJu0Yy2agwCCPSBNyMmVF+WQl3FYI99VGhgIDSLXN/x10D51lVMZ9Jx
	6fW/isdzbPuxb27HYKjJxtb16CC621XtE0ag1OxY9QJrCE/VklDIzOWuzjMiFx1DWMn+oiSpt6n
	gyp+yjjiKvtXbe2Lp8ohoIhj3H8JopocGIKQef9jMZQSLY34tQT7/ng6SOg5NOD0lZygdew6oMW
	eW7X7q5Vsi8xIDHgb0zw8A8cjN/aPNNyMGxInkXM0/Kul60cc=
X-Received: from pfbhj23.prod.google.com ([2002:a05:6a00:8717:b0:84c:23c5:6759])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c9e:b0:845:ba94:a56 with SMTP id d2e1a72fcca58-84fddfbf1cbmr10357248b3a.5.1786751353818;
 Fri, 14 Aug 2026 16:49:13 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:40 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-2-joshwash@google.com>
Subject: [PATCH net 1/6] gve: increment work_done for XDP and error packets
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The GVE RX NAPI will continue polling as long as

1) there are packets to be processed, and
2) less than NAPI budget SKBs (denoted in GVE by work_done) have been
   passed up to the kernel.

However, GVE does not account for all of the packets that don't create
SKBs, namely error packets and XDP packets.

This can result in XDP programs that scarcely return XDP_PASS failing to
exit the NAPI poll as long as the NIC is DMA'ing packets, possibly
processing the entire RX ring before returning from the NAPI.

This has 3 negative implications:

1) XDP RX path can run much longer than is desirable, hogging CPU
   resources.
2) If XDP_PASS is never returned, the work_done never increases beyond
   0, which can lead to scheduling delays due to missed chances to
   reschedule the NAPI.
3) In AF_XDP zero-copy, XSK_TX occurs after the RX poll. If the RX poll
   takes a long time, it will delay TX, leading to degraded performance.

Ensure every packet is accounted for in work_done by incrementing
work_done before checking for the existence of a SKB.

Fixes: 293b49361f91 ("gve: add XDP DROP and PASS support for DQ")
Cc: stable@vger.kernel.org
Reviewed-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 0ece2f6fdffb..db38bc645296 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -1145,13 +1145,14 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 		/* Free running counter of completed descriptors */
 		rx->cnt++;
 
-		if (!rx->ctx.skb_head)
-			continue;
-
 		if (!compl_desc->end_of_packet)
 			continue;
 
 		work_done++;
+
+		if (!rx->ctx.skb_head)
+			continue;
+
 		pkt_bytes = rx->ctx.skb_head->len;
 		/* The ethernet header (first ETH_HLEN bytes) is snipped off
 		 * by eth_type_trans.
-- 
2.55.0.691.gc56d675ccc-goog

