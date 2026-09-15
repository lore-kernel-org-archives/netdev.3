Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACC47ECC1
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476945; cv=none; b=db/noE0Tsn+7AM9TpFN5G5MtY5nY7jS0/sR7pjuSVD4T1d3LanV7sr9945GLp5y00a+kdu1Nh0zPmClYAHYIB7CgTfaW+La7eL0TO1e6hBv0d9HgNNxFYoeoRIZwGhJ/vd4P6AW1k1oTRAvuC/ZJRscxPmSLgQi0lTY4CFm6oG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476945; c=relaxed/simple;
	bh=2QMvi8X6HL6xA7TDdFrFvAc8tDQJHCt+PjUS7CwKGHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmqGMyEQei2zy+I4lZo7Zc2ZSowCodcGbIgcZ8+UspkdMiOysGkBFjrTN+Fb8uSUhLh+0E/jq3PSk5aDTFeX0AEZAEFktgrZTmw+/NiSHLSDqXCXeXwIKs9ZdWDUa3eibFO1cvtqQrkdjEoGvzvV9FC0CWAJzjjx2R2L267qYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lgk9C33m; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lgk9C33m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476943; x=1821012943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2QMvi8X6HL6xA7TDdFrFvAc8tDQJHCt+PjUS7CwKGHM=;
  b=Lgk9C33mF/hmtTgbXpDItafW9RNKfOEx1/xJ8tR5ZZbYSZwQQK/913tL
   YfI6PcU2ayMGl8Zd5Z661vTff2x4QbdQ0umB5yacmXGflbroAd4RAud7U
   9o9mYPs5qWSpZi3PCXFXagC4f1BM+fzadgOhEhdMJ9XfeSIxyBEdVAR/x
   5PldLloNM7P/o4hFUGn48mnc2tfu3RlUeX7GLXQENdz5pKEnjA8n3S/NX
   PZmBlgC2MQTlBReO3QUvHCLRkEqqyok8NeSC656T9wzbDappPqcCIJYIA
   TyE6wyUYrvq1DmHtqggnbjO3J6uSHkjJ4U9Wiv50ldCWuWtY8W0KLlRiE
   A==;
X-CSE-ConnectionGUID: IvUwFUVnQwyXpy0y+TSbjg==
X-CSE-MsgGUID: 1dwDo7OaTseQjTRb371kVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853123"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89853123"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:43 -0700
X-CSE-ConnectionGUID: uylKX8vRTyCW61DLTtLpoQ==
X-CSE-MsgGUID: JcuOGJ16RaKxV22hzFIm5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225228"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:42 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 2/4] ixgbe: add ixgbe_container_is_rx() helper and refine RX adaptive ITR
Date: Tue, 15 Sep 2026 14:55:36 +0200
Message-ID: <20260915125538.3975870-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
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

