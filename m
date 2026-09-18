Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214814FDA50
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738404; cv=none; b=GQxgcrycKi7mo6gWWiMygYi894sMGnXJ1ZK1PFZn4/SFvKLmhxacoi3XnwfWNJC4zHYvxKFbkCCvbLSRCmsilN7Plv3gDMd/HSFMH/NsssKT+y7Df+2+3X0uVN5iMRAf0GAGTz4+ahU65qJuqQwp/asr2NR0tmtHLlZbGJVMySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738404; c=relaxed/simple;
	bh=Kf9aY7QSDRzrm+l0yxbXYgb/bQwvAoaDc2QxP7217fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOU84jfza9Sa0C8Uyh2bfLibCvc29qcGlChwXHncvsx+D1ZLd0SSIdom4mms//IIiX5dQZ9Bf8hfuWPB2rj4MtS5uOjfm6FcHlVLFRPdc0+qFGj0G2N80pk2L/wdg06lunTmzDekhSbwYb/OxmZ4MllyGQfC3J44mDkzo93uOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNrIv6lX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNrIv6lX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738402; x=1821274402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kf9aY7QSDRzrm+l0yxbXYgb/bQwvAoaDc2QxP7217fE=;
  b=jNrIv6lX/cIQeCxzAYnpRfY+nO2crRAxSM1BfM7rSiz8thtzO3oaLyDj
   V5nAYgu/nVX9qe5nwQq5NcW8yDjIQXZkOkZmGTcqidY01q6IgD6MTu7Ll
   HjW8yDiLiLO33NwcQ5V+PeaLuAhy64SAJBN+TTHGVP/IDep9h6U+ZDjkl
   b/Yqzny+1bI5AKGxLhob6nb6rCTQ/1ss9YpeDzAi0N6Gsx+dtlhVtirsT
   +AVhIIXEnLP0zxfeIVF+7mUFqjbcbZZeSSocKFNszXbJ1ELDzmUy442u+
   U2Vp3ZVhCsq5gy7/5BMrscmjO2CZCWtgjvDogOMiPQdTeOohIsL/5w64K
   w==;
X-CSE-ConnectionGUID: hJSCv9fQRBat3u7/+2X80Q==
X-CSE-MsgGUID: JfgEmBniTuO3clYZKXUAnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="101592500"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101592500"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:33:22 -0700
X-CSE-ConnectionGUID: ZCxT48LHQ0eo+lIyUImQPA==
X-CSE-MsgGUID: AqdK15czQlyimMh4f1cJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270717965"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 2/4] ixgbe: add ixgbe_container_is_rx() helper and refine RX adaptive ITR
Date: Fri, 18 Sep 2026 15:33:14 +0200
Message-ID: <20260918133317.4169815-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
References: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexander.h.duyck@intel.com>

Add an ixgbe_container_is_rx() helper to cleanly distinguish RX from TX
ring containers inside ixgbe_update_itr().

Refine the RX-specific latency-detection path:

 - Replace the shared "packets < 4 or bytes < 9000" threshold with an
   RX-specific check of "1..23 packets and bytes < 12112".  When that
   condition holds, target 8x the observed byte count in the next
   interval by computing avg_wire_size = (bytes + packets * 24) * 2,
   clamped to [2560, 12800], and jumping directly to the speed-based
   ITR calculation.  This provides finer-grained control over low-rate
   RX latency workloads without affecting TX.

 - Remove the separate "no packets" special-case block.  When packets
   is 0 it falls into the "< 48" branch.  The mode-tracking logic in
   that branch is extended: fewer than 8 packets forces latency mode;
   8..47 packets preserves the current mode.  This replaces the old
   unconditional "add LATENCY flag from ring_container->itr" carried
   over from the removed block.

 - Remove the adjust_by_size label and the associated "halve
   avg_wire_size in latency mode" step.  The Rx latency path now
   pre-calculates avg_wire_size independently and the bulk path no
   longer needs the halving to compensate for incorrect thresholds.
   Rename the jump target to adjust_for_speed to reflect its purpose.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 67 ++++++++++---------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f918564..ddc18e1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2711,6 +2711,12 @@ static void ixgbe_configure_msix(struct ixgbe_adapter *adapter)
 	IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIAC, mask);
 }
 
+static bool ixgbe_container_is_rx(struct ixgbe_q_vector *q_vector,
+				  struct ixgbe_ring_container *rc)
+{
+	return &q_vector->rx == rc;
+}
+
 /**
  * ixgbe_update_itr - update the dynamic ITR value based on statistics
  * @q_vector: structure containing interrupt and ring information
@@ -2747,35 +2753,24 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		goto clear_counts;
 
 	packets = ring_container->total_packets;
-
-	/* We have no packets to actually measure against. This means
-	 * either one of the other queues on this vector is active or
-	 * we are a Tx queue doing TSO with too high of an interrupt rate.
-	 *
-	 * When this occurs just tick up our delay by the minimum value
-	 * and hope that this extra delay will prevent us from being called
-	 * without any work on our queue.
-	 */
-	if (!packets) {
-		itr = (q_vector->itr >> 2) + IXGBE_ITR_ADAPTIVE_MIN_INC;
-		if (itr > IXGBE_ITR_ADAPTIVE_MAX_USECS)
-			itr = IXGBE_ITR_ADAPTIVE_MAX_USECS;
-		itr += ring_container->itr & IXGBE_ITR_ADAPTIVE_LATENCY;
-		goto clear_counts;
-	}
-
 	bytes = ring_container->total_bytes;
 
-	/* If packets are less than 4 or bytes are less than 9000 assume
-	 * insufficient data to use bulk rate limiting approach. We are
-	 * likely latency driven.
-	 */
-	if (packets < 4 && bytes < 9000) {
-		itr = IXGBE_ITR_ADAPTIVE_LATENCY;
-		goto adjust_by_size;
+	if (ixgbe_container_is_rx(q_vector, ring_container)) {
+		/* If Rx and there are 1 to 23 packets and bytes are less than
+		 * 12112 assume insufficient data to use bulk rate limiting
+		 * approach. Instead we will focus on simply trying to target
+		 * receiving 8 times as much data in the next interrupt.
+		 */
+		if (packets && packets < 24 && bytes < 12112) {
+			itr = IXGBE_ITR_ADAPTIVE_LATENCY;
+			avg_wire_size = (bytes + packets * 24) * 2;
+			avg_wire_size = clamp_t(unsigned int,
+						avg_wire_size, 2560, 12800);
+			goto adjust_for_speed;
+		}
 	}
 
-	/* Between 4 and 48 we can assume that our current interrupt delay
+	/* Less than 48 packets we can assume that our current interrupt delay
 	 * is only slightly too low. As such we should increase it by a small
 	 * fixed amount.
 	 */
@@ -2783,6 +2778,20 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		itr = (q_vector->itr >> 2) + IXGBE_ITR_ADAPTIVE_MIN_INC;
 		if (itr > IXGBE_ITR_ADAPTIVE_MAX_USECS)
 			itr = IXGBE_ITR_ADAPTIVE_MAX_USECS;
+
+		/* If sample size is 0 - 7 we should probably switch
+		 * to latency mode instead of trying to control
+		 * things as though we are in bulk.
+		 *
+		 * Otherwise if the number of packets is less than 48
+		 * we should maintain whatever mode we are currently
+		 * in. The range between 8 and 48 is the cross-over
+		 * point between latency and bulk traffic.
+		 */
+		if (packets < 8)
+			itr += IXGBE_ITR_ADAPTIVE_LATENCY;
+		else
+			itr += ring_container->itr & IXGBE_ITR_ADAPTIVE_LATENCY;
 		goto clear_counts;
 	}
 
@@ -2813,7 +2822,6 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 	 */
 	itr = IXGBE_ITR_ADAPTIVE_BULK;
 
-adjust_by_size:
 	/* If packet counts are 256 or greater we can assume we have a gross
 	 * overestimation of what the rate should be. Instead of trying to fine
 	 * tune it just use the formula below to try and dial in an exact value
@@ -2856,12 +2864,7 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		avg_wire_size = 32256;
 	}
 
-	/* If we are in low latency mode half our delay which doubles the rate
-	 * to somewhere between 100K to 16K ints/sec
-	 */
-	if (itr & IXGBE_ITR_ADAPTIVE_LATENCY)
-		avg_wire_size >>= 1;
-
+adjust_for_speed:
 	/* Resultant value is 256 times larger than it needs to be. This
 	 * gives us room to adjust the value as needed to either increase
 	 * or decrease the value based on link speeds of 10G, 2.5G, 1G, etc.
-- 
2.52.0

