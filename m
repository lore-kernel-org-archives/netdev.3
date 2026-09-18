Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F94FDE48
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738405; cv=none; b=ZGrvwiVLpqcTKCqW765bnCeOHTY8kapmbLRM/ESLQvax7Eiet8RZyu2aXEs/WbM2ErTjyPbJOywfL0DRQX0GvBh8sUHt8e0ngdgAqf1H5mI8qCrX58aGA3A/4+O4JSPd1b0uV/79lZZYa16J3+KcBvHZwfRUSoNEI7NeOlhn2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738405; c=relaxed/simple;
	bh=nynaKHxpqFdUNf2h5qjJM7ve6b5QrdSZLCT6fYbUo7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtNsPrYx5ysjlYe3fGRREcD4iIVTD7KDGUvxXxGkem+aWiNtd43xVgCoP7T+5HF7dMYKzdt5VgGz7bmsYWNAPvfl6c5jifTLs7LjCdo242uM+0N3/cqgjPl2QqETXqAkPPc1jpOKdtF9dxGSfM9hD95TWjs8ymzQEu/qQsEKm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+cNosR3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+cNosR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738404; x=1821274404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nynaKHxpqFdUNf2h5qjJM7ve6b5QrdSZLCT6fYbUo7I=;
  b=J+cNosR3WuxhdL0x7F/tiGm8FqTyFhcb8P38LFuWmNNebO7La6tAHtn+
   GJs+vYcbqCZGHZlIz4rANDVlKXlKh0xRZGHJOz00G91X6zHIJIWdH+KRV
   XuCtCOr6e6vfpPVjr4rx1ZV7N9D3IDIL735Ii7Ceg2RQGKDELNp1rzE6k
   IM/MCqcNfDAOxK6Tp9owRHuTfsgOiBki5B38KnVOAC1c3GQ3tlrEYGe4Y
   lnPQYuJO7WEZoth4ZV+nnq8UbS0hS3Ya/ag6rilf8q4GDp77/WrX8GZTe
   1s5MbDPWURhlfJoyJnc0i5+0qlexKwHIXiTwhANkHPgJQbDftp4Sntoov
   g==;
X-CSE-ConnectionGUID: Z8WWaYZqTTqurRp7mGlwUw==
X-CSE-MsgGUID: KS5E3pm9SDqogXe7HiPUEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="101592505"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101592505"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:33:23 -0700
X-CSE-ConnectionGUID: nCtVX0dJQ6CitHw723+ZWg==
X-CSE-MsgGUID: w/5vG2qKR1yG3wWF5eULIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270717981"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:22 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 3/4] ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
Date: Fri, 18 Sep 2026 15:33:15 +0200
Message-ID: <20260918133317.4169815-4-aleksandr.loktionov@intel.com>
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

