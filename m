Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C233FF884
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049288; cv=none; b=KTFepE28g1ZUQwiJPCnQt5P45R3PMgY2gp3BTR0cGfG0zw6f3X/1eE45jmviZf7Kcsts3cescXjEP6e83u7+mxLr1CW9edgrx63H5llG39OKRxEl9ZTH9GwaQhz8ZHH2BM3aUaeTBbVRxbLKvAHD3KNsTTlmovSCnO2UswMHoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049288; c=relaxed/simple;
	bh=Cio6GetQFOW2UKj3k0s78738zSt7LrvcNA7FummsTPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDIRl+Bp1C2XBW2NNCQ3qT1yd1kymBpjcPeeYCKdeJNKjy+nzV0p5v0RVsk27Z8/jzbrT6Q9g8ldZItSYKG5S42qHc1Z45i7yQEzDlcQSyZDiVyag9gOrtjIQAr73OPRc2zF+WChrzAO6tLAoD8RT1MmO2Hstx5eQepgkERO5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfPACwyJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfPACwyJ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3310056b3a.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786049282; x=1786654082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGTqHHC4NVA2KN0cBT420M4IXX0B7VIhrwI+H5nqUsI=;
        b=gfPACwyJqZWR4HCmQwIF1+/NZFjO4XdDZbXO/hGkP3u0rQ3Xze38uvaXUr/qj6xDON
         yosehAZGpt61hNLP9fccxSu1nPSZ87m7NQO0iUC0qKt2RY3+BbCRh6+v3T78OdHIExbB
         r2urTcCjaS6h4icP2XfoJw8XZ3x9TU/E2n2InTIH4Lgg/qdFEx3/IDUQn04ABPAvlcLf
         VraY+ZYWDbUqHXerWT/TZWoPjXJermX3VzAwTw8qVZq3x4agnpXi5S21NxDLd76wK1lf
         BJ77axXEHuSSnZOFVXMopFBmc4CFpdU620ombcOQ73T6HnzJndPuzzpjEHKGj4bZ7Xmd
         RAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786049282; x=1786654082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGTqHHC4NVA2KN0cBT420M4IXX0B7VIhrwI+H5nqUsI=;
        b=HcKHeOMGJ7w32GTJso8phw9TbSim8JgjU+GbjzA5pzjvVcZ0LwnfydzlbBMt/U+yND
         OhuobFPorGrWdMkvU5puXr4v0+IBxypzDFbMLhBGm+jBkv7E7EDYsFGw76jA5i37dyDe
         W3G+PvAyUZmRV+2RjmIhgj/KJkLNxuq4B7GGjjtUTwBOosz40mcZlDpgT029rMEr3Kgf
         GskvS44oHd1qCIQw1cDCUEhZ3DN7/BHZdKi/Nd18sr6Ify7Fz0uqDd9MXxjSOvN2SMM1
         gxtXBeepnuOWY+357IxV/nbB+XSGyvJDddPqyIbMAGcV9UatR9pGyGYtE8jOyTLpLAJz
         9NFA==
X-Gm-Message-State: AOJu0Yxznb1ivf2CLIi3+brwTx1Whgpb2CyRkiouB1qiWbslsZXoH8yg
	7lIVxTsDJioiWfaOmzU88qTvBORVb6AjJl9ETy6rbCZ5N8cTJKnVTKdW
X-Gm-Gg: AR+sD13AdC4SZq/zDoxP0yNjzpejSV8mmfLQfYoo44NjDtC3/Hv9UkXt83qJOB6tyIw
	uIXdBuEJzGe7cB2uTuCLmegwOz1gSSF3PUHJ73Yr8WXCPBcLcA/hR11lF20jmFlKbccmJ5NaB38
	aFNedP0CF65HDN83/UVWwrOeWp85V7SwWhpLwTHDmWt+VN5r1+twfgsGXqKwrC5c/S1HXf5ZXZf
	X3JIjzf2XQ4LYTKwLUXzE1/ntgY0VtsbcT6G5efCkTUS1OfKlWxG6S7RL2qLUqCcpWXG1BnOkpF
	6Vpf02d8itHgOhSfd9JC7iEkRWDPR41CvX3m92mSkS2cjZMvK4oxT8bLdsmjn6bjHITypcj9WOC
	StyTD8CzBz18cVV5SgjjvevMHyC3CglGDmnGlLIsb2YcxM8hcPLtMAzqTHBrgZhAze5ZxdQoAUt
	L7//IjcVTpdshHiaSvF19kq2vzbVNBLg9RSD35bJqd88t/kLBmwfJUX7JsW4Civ0+91RNVsW9ou
	VqkJpQ=
X-Received: by 2002:a05:6a00:4b05:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-84f2e0148a8mr18752552b3a.8.1786049281819;
        Thu, 06 Aug 2026 13:48:01 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.149.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc9cffsm2073686b3a.59.2026.08.06.13.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 13:48:01 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: magnus.karlsson@intel.com,
	kerneljasonxing@gmail.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v3] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Thu,  6 Aug 2026 16:47:57 -0400
Message-ID: <20260806204757.47817-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
loop without checking its return value. xsk_buff_can_alloc() only
counts fill queue entries without validating their addresses, so it
can succeed while xsk_buff_alloc() rejects all remaining entries and
returns NULL.

  Oops: general protection fault, probably for non-canonical address
   0xdffffc0000000000
  KASAN: null-ptr-deref in range
   [0x0000000000000000-0x0000000000000007]
  RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
  Call Trace:
   xsk_generic_rcv+0x26d/0x5f0
   xdp_do_generic_redirect+0x3c5/0xcf0
   do_xdp_generic+0x92f/0xe70
   __netif_receive_skb_core.constprop.0+0xf7e/0x2b30

Fix this with a two-stage transaction. First allocate and stage all
buffers required for the packet using the pool's xskb_list, recycling
them with xsk_buff_free() if any allocation fails. Only after the
allocation stage succeeds, copy the data, reserve the RX descriptors,
and release the buffers in an error-free loop using
xsk_buff_get_frag().

Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v3:
 - Use pool's xskb_list and xsk_buff_get_frag() instead of a local
   staging list, per Maciej and Jason's review.
 - Set frags flag on head so xsk_buff_free() recycles the entire
   staged group in one call.
 - Guard against duplicate aligned Fill Ring addresses.
v2:
 - Allocate all packet buffers before reserving RX descriptors.
 - Recycle partially allocated buffers instead of only cancelling the
  RX producer reservations.
Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail.com

 net/xdp/xsk.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4b6..02ff3ad97410 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -297,10 +297,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
 	void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
+	struct xdp_buff *first, *next, *xsk_xdp;
 	u32 from_len, meta_len, rem, num_desc;
 	struct xdp_buff_xsk *xskb;
-	struct xdp_buff *xsk_xdp;
 	skb_frag_t *frag;
+	u32 i;
 
 	from_len = xdp->data_end - copy_from;
 	meta_len = xdp->data - copy_from;
@@ -343,11 +344,34 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		frag =  &sinfo->frags[0];
 	}
 
+	if (WARN_ON_ONCE(!list_empty(&xs->pool->xskb_list)))
+		goto err_alloc;
+
+	first = xsk_buff_alloc(xs->pool);
+	if (!first)
+		goto err_alloc;
+
+	xdp_buff_set_frags_flag(first);
+	for (i = 1; i < num_desc; i++) {
+		xsk_xdp = xsk_buff_alloc(xs->pool);
+		if (!xsk_xdp)
+			goto err_free;
+
+		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
+		if (unlikely(xsk_xdp == first ||
+			     !list_empty(&xskb->list_node)))
+			goto err_free;
+
+		list_add_tail(&xskb->list_node, &xs->pool->xskb_list);
+	}
+
+	xdp_buff_clear_frags_flag(first);
+	xsk_xdp = first;
 	do {
 		u32 to_len = frame_size + meta_len;
 		u32 copied;
 
-		xsk_xdp = xsk_buff_alloc(xs->pool);
+		next = xsk_buff_get_frag(xsk_xdp);
 		copy_to = xsk_xdp->data - meta_len;
 
 		copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
@@ -356,10 +380,21 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
 		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
 				  rem ? XDP_PKT_CONTD : 0);
+		xsk_xdp = next;
 		meta_len = 0;
 	} while (rem);
 
 	return 0;
+
+err_free:
+	/* Re-set frags flag; xsk_buff_alloc() may have cleared first->flags
+	 * if the same Fill Ring address aliased back to first.
+	 */
+	xdp_buff_set_frags_flag(first);
+	xsk_buff_free(first);
+err_alloc:
+	xs->rx_dropped++;
+	return -ENOMEM;
 }
 
 static bool xsk_tx_writeable(struct xdp_sock *xs)
-- 
2.53.0

