Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A1524B08
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903916; cv=none; b=ITa3YWlmp4OGbcMGDiFjiquOKBpV0wzsHgPM+DiTukcX6rRkjfgzvqVGACQEud7T9Aj5jZQ+1qTcolVVwaAl+UfZaDDQAMBhPBvX8IX/y53Iu/GJM1artVaSg6xKa7O6ofOEzA+pKEm4RYSuxvMxvu34HVSZBhpBwxQCnVRY698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903916; c=relaxed/simple;
	bh=C/SIOX+7I//Hl0NvH9G+BC0+0zw+23QRMY6RGh3RX5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkXdEt4qnnTLCTSPp+pwftNA09ldpxWffCK8/euUSovLaCDC/bQnXjB4zObRld7As7EWNqdevOkbCRGQoWCcQVPjzqolUCNSGHG4mTxCgeirratCbVPdPn6zNdRmn8cwdIxDyz7Hzw+sHPCx49X6FbbucZW2CbtAydxiOFv7mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4frtgl2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4frtgl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788903915; x=1820439915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C/SIOX+7I//Hl0NvH9G+BC0+0zw+23QRMY6RGh3RX5A=;
  b=Z4frtgl2JOFyamrdp12wAADr6mD8f5PuD+Oo7Kyzqf3Nzjm8xh//ah50
   D1yRkuC8WZNBTHL4opTozjqISinXnGl242p7rdZMq3Vaw7RsN+H2Voq8+
   kW2aFAT5Kxx6/DErLhp0DnOHZlz3uNjX74UswI19F/VE3kgv5FOr/qmc4
   B/BdvTHcrTSi1gms1FMLrGrrWWdit+4tgDgdPvg9QR/v3wGFqKKKlVsQI
   mp5nnnqxjjBJ8hRHJ+L4qFad/KM+u6y6ulB7AApeyrJl3Uq4uaMPVF43L
   Dxjpcg48ydZkUVvM5NkbuqBEsIEojB10BcazuTyXuUTSJKaCmDvOVy+4o
   A==;
X-CSE-ConnectionGUID: vqgdA7b8SESiD0rYbvvg7w==
X-CSE-MsgGUID: z1gW70gAQ9KjPjp+Efa/Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106836249"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106836249"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:45:09 -0700
X-CSE-ConnectionGUID: B4U+dcTgSwKzswKy8xXljg==
X-CSE-MsgGUID: G9NQle0LQDSbRTMfqTQNIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="269782525"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 Sep 2026 14:45:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	ae878000@gmail.com,
	mhun512@gmail.com,
	joshua.a.hay@intel.com,
	sridhar.samudrala@intel.com,
	milena.olech@intel.com,
	vadim.fedorenko@linux.dev,
	willemb@google.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 5/5] eth: ice: don't dereference pointers from TP_printk()
Date: Tue,  8 Sep 2026 14:45:00 -0700
Message-ID: <20260908214502.528440-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
References: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

After forwarding net-next during the v7.3 merge window we started
seeing:

  TRACE EVENT ERROR: Event ice_tx_dim_work has double dereference in TP_printk: REC->q_vector->tx.tx_ring->q_index
  WARNING: kernel/trace/trace_events.c:420 at test_double_dereference.cold+0x39/0x4b

this is due to extra checks added in tracing subsystem in
commit b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer in TP_printk()").

Printing happens long after the event was recorded, by which point
the pointers may be invalid (the ring or the dim instance).
Copy the eight scalars into the event instead.

Fixes: 3089cf6d3caa ("ice: add tracepoints")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_trace.h | 64 ++++++++++++++--------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 4f35ef8d6b29..7568c917cdbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -63,23 +63,33 @@
 DECLARE_EVENT_CLASS(ice_rx_dim_template,
 		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
 		    TP_ARGS(q_vector, dim),
-		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
-				     __field(struct dim *, dim)
+		    TP_STRUCT__entry(__field(u16, q_index)
+				     __field(u8, state)
+				     __field(u8, profile_ix)
+				     __field(u8, tune_state)
+				     __field(u8, steps_right)
+				     __field(u8, steps_left)
+				     __field(u8, tired)
 				     __string(devname, q_vector->rx.rx_ring->netdev->name)),
 
-		    TP_fast_assign(__entry->q_vector = q_vector;
-				   __entry->dim = dim;
+		    TP_fast_assign(__entry->q_index = q_vector->rx.rx_ring->q_index;
+				   __entry->state = dim->state;
+				   __entry->profile_ix = dim->profile_ix;
+				   __entry->tune_state = dim->tune_state;
+				   __entry->steps_right = dim->steps_right;
+				   __entry->steps_left = dim->steps_left;
+				   __entry->tired = dim->tired;
 				   __assign_str(devname);),
 
 		    TP_printk("netdev: %s Rx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
-			      __entry->q_vector->rx.rx_ring->q_index,
-			      __entry->dim->state,
-			      __entry->dim->profile_ix,
-			      __entry->dim->tune_state,
-			      __entry->dim->steps_right,
-			      __entry->dim->steps_left,
-			      __entry->dim->tired)
+			      __entry->q_index,
+			      __entry->state,
+			      __entry->profile_ix,
+			      __entry->tune_state,
+			      __entry->steps_right,
+			      __entry->steps_left,
+			      __entry->tired)
 );
 
 DEFINE_EVENT(ice_rx_dim_template, ice_rx_dim_work,
@@ -90,23 +100,33 @@ DEFINE_EVENT(ice_rx_dim_template, ice_rx_dim_work,
 DECLARE_EVENT_CLASS(ice_tx_dim_template,
 		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
 		    TP_ARGS(q_vector, dim),
-		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
-				     __field(struct dim *, dim)
+		    TP_STRUCT__entry(__field(u16, q_index)
+				     __field(u8, state)
+				     __field(u8, profile_ix)
+				     __field(u8, tune_state)
+				     __field(u8, steps_right)
+				     __field(u8, steps_left)
+				     __field(u8, tired)
 				     __string(devname, q_vector->tx.tx_ring->netdev->name)),
 
-		    TP_fast_assign(__entry->q_vector = q_vector;
-				   __entry->dim = dim;
+		    TP_fast_assign(__entry->q_index = q_vector->tx.tx_ring->q_index;
+				   __entry->state = dim->state;
+				   __entry->profile_ix = dim->profile_ix;
+				   __entry->tune_state = dim->tune_state;
+				   __entry->steps_right = dim->steps_right;
+				   __entry->steps_left = dim->steps_left;
+				   __entry->tired = dim->tired;
 				   __assign_str(devname);),
 
 		    TP_printk("netdev: %s Tx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
-			      __entry->q_vector->tx.tx_ring->q_index,
-			      __entry->dim->state,
-			      __entry->dim->profile_ix,
-			      __entry->dim->tune_state,
-			      __entry->dim->steps_right,
-			      __entry->dim->steps_left,
-			      __entry->dim->tired)
+			      __entry->q_index,
+			      __entry->state,
+			      __entry->profile_ix,
+			      __entry->tune_state,
+			      __entry->steps_right,
+			      __entry->steps_left,
+			      __entry->tired)
 );
 
 DEFINE_EVENT(ice_tx_dim_template, ice_tx_dim_work,
-- 
2.47.1

