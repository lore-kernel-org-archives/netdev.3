Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623817;
	b=utBYyFts80+kxfr7ABCU3kgG1+Q5QNRxHxrTfh3hxrti/ErNFmIgRDX/rFqpZPbua7rY
	 NGBC6H6iqmQTxvBhgxz4zNRCFLyiw3rSVaALCtQOcSXgZCJrOvjD1piFJEGr9pUnzfcSd
	 GCggaYzayrZ6tbLJ7hQF+eQNkSe+SYULVqSrdW6X4BZrsvkTCvuYpXlISWGametaBy3xl
	 6RSgsnNJgJVDP7tVqD1Su20KUBKr12LrUUfcBn2+HmkMwpJurlo3r3BBz98LE9IFarBnF
	 flQNQqSXQCFnf1ItbYxQDIFU+DS9lcp3t+4JAJA4mLEFgzop2ObSa1tfeTedJrWEQYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623817;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=89Gmn4oEGWFd+uO9gEA2OKgl+cvspNEgCMF/bQuzRSo=;
	b=IAhRsK9YeqzHFIr792iEuGGMmRqS+//dFYVUfQUZ4a735qX0GkrXK5Z73iGnkxs4isSy
	 YAlMiYc6tqgzYIFIa4kKx0r1RsORu1mVLsgwKJU0YnE2lXmqrlJb/ZL14Z0jP1jaBRREn
	 +44BtdcCRzYNptlzWSXa1OBE6OACVwftAbYfny/df0H0tOIJJb5pY5SadnbnCrccSqSBV
	 nZKtX0i5leHHO99ZM1Q8C2NuiXyIz1O+G/mEL2uTh7yF1MZlMBQMMcQRQbA1BwTJa/tZN
	 aIJSNdZ77TEiJ8CQpQpbTqYyQjvSodDNNE6Dq40R5zLbj49n1rMI/YGkWrratgC8udA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h0zK1q3s;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255A60A2616
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8255A60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h0zK1q3s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623815; x=1825159815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FEQ0aJAxsz1IQL8fFJWybWjkJfi9kqYUiQxLKvzPA6g=;
  b=h0zK1q3sCwdIJToyjYHYKyE50toNO2aflcDdnDStMDnpQl9n5FA4eSS1
   +Oa2rIpEsa78qgg5ozWGaPFRam/TkN965ul7tk03kvTj/PIV3yPWIyYeL
   YXCNCzNC8h+b61e79BB1swOQBIFrekSpAzW9FTenv8JAgB+0d85L1ewIp
   Gg1rhzl3oyLfTS5W4xbRW8DXcCL6VLVCaRr4ba+MEg4gbnmSh5OMWe79P
   HKIB5M0NRHUAGBReblyvadHHAzSr6aNJ6Gj1Tkx5toO7JsCc9pWMysKUd
   Z0/KQzO0/zRAWylWJUzTiGN5sNBxQrLnlSbYhRLQDKzdF+vWSaTkmCbqs
   Q==;
X-CSE-ConnectionGUID: sFZEqYxYRnSpw+oKBdi/Ag==
X-CSE-MsgGUID: PNaOL5+VTy+uzh5L8h7oRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191872"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191872"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:15 -0800
X-CSE-ConnectionGUID: y+1Sd7gLQAaW2KPczQB8EA==
X-CSE-MsgGUID: bwiV+Y8aQEabBePm8npHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928498"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:14 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	zuomao338@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 6/9] xsk: do not clear frags flag when acquiring a buffer
Date: Mon,  2 Nov 2026 13:49:47 +0100
Message-Id: <20261102124950.958345-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
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

xp_alloc() and xsk_buff_set_size() reset xdp_buff::flags of every
buffer they hand out. In aligned mode, duplicate fill ring addresses
map to the same xskb, so the head of a frame still being gathered can
be handed out again and lose XDP_FLAGS_HAS_FRAGS. xsk_buff_add_frag()
rejects the duplicate and the frame is dropped, but xsk_buff_free()
leaves its frags on pool->xskb_list, where they are taken as frags of
the next frame.

Keep XDP_FLAGS_HAS_FRAGS on hand-out and clear it when the frags are
released, in xsk_buff_free() and xsk_rcv_zc(). The driver XDP_TX paths,
bpf_xdp_adjust_tail() and bpf_xdp_pull_data() already clear it, and
pool->heads starts zeroed. Other flags are still reset on hand-out, as
nothing clears them on release.

Since xsk_rcv_zc() now clears the flag, i40e must count Rx bytes before
running the XDP program, like ice and libeth.

Fixes: f7f6aa8e2438 ("xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 include/net/xdp_sock_drv.h                 | 4 +++-
 net/xdp/xsk.c                              | 1 +
 net/xdp/xsk_buff_pool.c                    | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index e6ae4c7a5cb3..57b0f520fbb2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -354,7 +354,6 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 	struct sk_buff *skb;
 
 	*rx_packets = 1;
-	*rx_bytes = xdp_get_buff_len(xdp_buff);
 
 	if (likely(xdp_res == I40E_XDP_REDIR) || xdp_res == I40E_XDP_TX)
 		return;
@@ -492,6 +491,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 
 		xsk_buff_to_i40e_ctx(first)->desc = rx_desc;
 
+		rx_bytes = xdp_get_buff_len(first);
 		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
 		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
 					  &rx_bytes, xdp_res, &failure);
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 29965e369598..a40ad3f90f13 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -153,6 +153,7 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 	}
 
 	xdp_get_shared_info_from_buff(xdp)->nr_frags = 0;
+	xdp_buff_clear_frags_flag(xdp);
 out:
 	xp_free(xskb);
 }
@@ -225,7 +226,8 @@ static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
 	xdp->data_meta = xdp->data;
 	xdp->data_end = xdp->data + size;
-	xdp->flags = 0;
+	/* Frags flag is cleared when the frags of a head are released */
+	xdp->flags &= XDP_FLAGS_HAS_FRAGS;
 }
 
 static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *pool,
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..d22be82533ae 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -241,6 +241,7 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		goto err;
 	}
 
+	xdp_buff_clear_frags_flag(xdp);
 	__xsk_rcv_zc_safe(xs, xskb, len, contd);
 	xskb_list = &xskb->pool->xskb_list;
 	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 9d2d94f1fb75..4318ec98199e 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -597,7 +597,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 
 	xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
 	xskb->xdp.data_meta = xskb->xdp.data;
-	xskb->xdp.flags = 0;
+	xskb->xdp.flags &= XDP_FLAGS_HAS_FRAGS;
 
 	if (pool->dev)
 		xp_dma_sync_for_device(pool, xskb->dma, pool->frame_len);
-- 
2.43.0

