Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F44478E25
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476945; cv=none; b=mRJ1iBHJfcqDwkVWYitUKtbBfOnbqlhR9VUF8ODgLMV3sOYIPwFFpXiqT9opGwch3GY9zwrUhRepdXdjzXHmKoiaC8+9NyOju+WuEM345ouHSWWIrbQeovVZ7/j6YHb/jUQT80AYsb6V8ftEcTrjGdScYueuZBJNSO6j+QL6vpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476945; c=relaxed/simple;
	bh=nynaKHxpqFdUNf2h5qjJM7ve6b5QrdSZLCT6fYbUo7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr/V7/M7iJNj/S+9Bs/i2Wew5JG5u20s9dBlO+uBic9J5KIUB5Qqv/+pANoT5xXhr/3H0MjUKSRGCYp/dkwGcTQGLVJOC/6REZTCtBqoo1yV1U6I/3jhkb5LKzNEU9RuNu4r8vCkXlAgHRsPccLGK/td6McH4IRUMFcIl7UewMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZDfxFvK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZDfxFvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476944; x=1821012944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nynaKHxpqFdUNf2h5qjJM7ve6b5QrdSZLCT6fYbUo7I=;
  b=NZDfxFvK3gLcKzxUIziPLZl7j5fUZ2440JuMSL49syc8qz9mPIVLzk5o
   WnSgNZoVsfa4mvwRp2uEtQCYlmp0vbdtOiK4tLIJiY8Wf6vRq5Ep6q1ed
   1LsrJyyvkupiTEtCJ9p2B9wjPL10YF0dZpFJBU/+LMtaLDAIjLQoA91/T
   Zo6bBs0m88BPjgGdNBSoHdMO/U9wISM++cbWEMgve7xAKwFPUSN2BskGt
   Wu/wabqOwC9WE605W9k6rE0oODrNyTpVrPw/rbEAy6F2OLCtDPoPtIEFa
   IAAHQezTT9OdJdl8tqUZM3BhG4jllvVqt2lCGw/3HLWqGYFYcYXd0yCvd
   A==;
X-CSE-ConnectionGUID: XiS9MFVVTNOMcamxcJpVpg==
X-CSE-MsgGUID: GdQqLoqyTKeOYFnDr9EAmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853128"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89853128"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:44 -0700
X-CSE-ConnectionGUID: LDA9n+64TICdbbJ4NdstUQ==
X-CSE-MsgGUID: bSMa/eeBR9GbSunN1CX+eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225238"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:43 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next 3/4] ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
Date: Tue, 15 Sep 2026 14:55:37 +0200
Message-ID: <20260915125538.3975870-4-aleksandr.loktionov@intel.com>
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

When operating in latency mode and the computed ITR is lower than the
current setting, the algorithm can reduce the interrupt rate too
aggressively in a single step.  For a TCP workload this means the ACK
stream (a latency-sensitive, low-packet-rate workload) can drive the
moderation down to very high interrupt rates, starving CPU time from
the sender side.

After the speed-based ITR calculation is complete, check whether the
result is in latency mode and would decrease below the current setting.
If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us)
per update.  This ensures the number of interrupts grows by no more
than 2x per adjustment step for latency-class workloads, dialling in
smoothly rather than overshooting.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ddc18e1..7fb2ab4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2891,6 +2891,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		break;
 	}
 
+	/* In the case of a latency specific workload only allow us to
+	 * reduce the ITR by at most 2us. By doing this we should dial
+	 * in so that our number of interrupts is no more than 2x the number
+	 * of packets for the least busy workload. So for example in the case
+	 * of a TCP workload the ACK packets being received would set the
+	 * interrupt rate as they are a latency specific workload.
+	 */
+	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
+		itr = max_t(unsigned int, itr,
+			    ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC);
+
 clear_counts:
 	/* write back value */
 	ring_container->itr = itr;
-- 
2.52.0

