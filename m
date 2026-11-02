Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623805;
	b=sqeDPRO9b/RiM9HFuCevioo7uAoKVsIkT3prKXMrdkBFNpcWI0ZuWJNqPlMTfWdJp8/i
	 D98hkU+FgC5kkCEu02TI4uf38knNbyoCpRcaQTOvxqNWCMKmAuh803m5p/oMPPDIzf/ZZ
	 bX+EUIozv36j2iX50xxKF9ZVtPyxzfiQDlYSYVFcS19DdN7fmqaa05EObwtZ5U/3VzQIJ
	 bpHREZ/jZOAKDdMgh2/rXDUnqrIefTl/qf1gVTmDjJY8r0UKKxtpsY6Scs3qDOff54O9d
	 KDU0toxbhqTKJuyTznA9YjmNl5Z0a2ZcFD90ZyNjXJQdnI/ThFyUFrdB1IptJbRM42Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623805;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SRw/fWwP1x6toUWZnFv2rG12o/c967R/fKYAGDVCATY=;
	b=gwqG/x9DegtIvdvNZYY2KcYQyPCM9rnJ1cFso7dmBgr+dbvzXG15SPYO/KBmgck8wyX0
	 geNzYdChIXhl4JfWy5nU33cj4m7mb8tKWALVk1XOZcmyAZzf6JHePsWS0efgJ31oMbus3
	 /cF8t0Tl0cSVP6OP7OitHhuWo8Jxj6MWZc+NtzALXHTcK8KY+v2Jghfr1b75cdRXyvvSn
	 gO7dUeXqZ6xdGslDhsnd/iQpcIuuncReXuFIFgDzliAtKWw8uqJmGo7hYjgB64wEaEAuD
	 Pm4Wt4kfpjZXuBFyMmFDdeC8SPtuUdNFl01jL/ISPtiDHqTmpB4egg8Pq6WVfFametg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="K/P1n+io";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC9606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73FC9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K/P1n+io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623804; x=1825159804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ln+Z8zU+zsF8tte/cw1wXmgactMyqWnSIzwWLUK/EPE=;
  b=K/P1n+iotBsMYsGDuWB16ts8OB6rylbFr6iNyXcr4qKwKU5WLe0/AsJI
   BLHVYMup5iI2Q9NGyNVdoAyBonWWqt8gYAcWrMYYWqpiu47Ag4EadkzXQ
   OmuJ5OToOkdk7WvVLNTooWhbnU2eiDu+MicNfkiof5XU3rEExxbEMdhD5
   aM29JpDFhXQGWip0sny+4Ann1+f5iEQbDMJNpmtHRsUXv1qIooTRp1+HO
   axMjVGAxnBTcFI/st9ECRsWjpdzoX+QUgY4JbvcBQP+WjkqavPt40je6O
   j9DymLwuG2haDsYzn9DuEvE+kRhLi/izAa5Wuq+N0oBdjWb+/tDkc26vI
   Q==;
X-CSE-ConnectionGUID: X1oM4TrYTo6+Ir1DAIYKgA==
X-CSE-MsgGUID: 857GWCtKRnG4mppbh3PcOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191824"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191824"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:04 -0800
X-CSE-ConnectionGUID: g2QLcP87RZihG4aTe4jDtQ==
X-CSE-MsgGUID: zprGQ2WYRk+Ct894WnQ60g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928442"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:02 -0800
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
Subject: [PATCH net 1/9] xsk: fix list corruption in xsk_buff_add_frag()
Date: Mon,  2 Nov 2026 13:49:42 +0100
Message-Id: <20261102124950.958345-2-maciej.fijalkowski@intel.com>
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

In aligned mode, a fill ring address maps straight to its pool->heads[]
entry. If user space posts the same address twice, a driver can pass
xsk_buff_add_frag() a buffer that is the head of the frame or is
already on pool->xskb_list or pool->free_list.

Re-adding a linked node corrupts the list. With buffers A, B, C, B,
xsk_rcv_zc() emits two descriptors instead of four and leaves the list
head pointing at a self-linked B. When the Rx ring later has no room
for a frame, the xsk_buff_free() cleanup follows B into pool->free_list
and passes the list head to xp_free():

  BUG: kernel NULL pointer dereference, address: 00000000000000c0
  RIP: 0010:xp_free+0x1a/0x50
  Call Trace:
   xsk_rcv_zc+0xca/0x200

The head is not on any list and needs a separate check. Adding it as
its own frag lets bpf_xdp_adjust_tail() free the in-use head and wrap
sinfo->nr_frags to 255.

Reject such buffers before adding them to the frags array, as commit
e37b2abca804 ("xsk: fix NULL pointer dereference in __xsk_rcv()") does
in the copy path. Callers already drop the frame on failure.

Unaligned mode is not affected, as each fill ring entry gets its own
xskb from pool->free_heads[].

Reproduced with a KUnit test feeding synthetic buffers to xsk_rcv_zc(),
by Nagato Shiratana.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Reported-by: Nagato Shiratana <zuomao338@gmail.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index d94aeb506379..29965e369598 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -160,15 +160,18 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 static inline bool xsk_buff_add_frag(struct xdp_buff *head,
 				     struct xdp_buff *xdp)
 {
+	struct xdp_buff_xsk *frag = container_of(xdp, struct xdp_buff_xsk, xdp);
 	const void *data = xdp->data;
-	struct xdp_buff_xsk *frag;
+
+	/* Duplicate fill ring entries map to the same xskb in aligned mode */
+	if (unlikely(xdp == head || !list_empty(&frag->list_node)))
+		return false;
 
 	if (!__xdp_buff_add_frag(head, virt_to_netmem(data),
 				 offset_in_page(data), xdp->data_end - data,
 				 xdp->frame_sz, false))
 		return false;
 
-	frag = container_of(xdp, struct xdp_buff_xsk, xdp);
 	list_add_tail(&frag->list_node, &frag->pool->xskb_list);
 
 	return true;
-- 
2.43.0

