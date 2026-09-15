Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FB4A0EE6
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476972; cv=none; b=YwWCY8ADxyz6AAq5CuwO47Mm0bsmwHtYWYcFGX7PSmBUpAdOIeSIw+ENv8CnzKgvMlOHH7Wa+0Sexw8/l7+gSFyX2YRnHDPx3Z6opu6pjGQufQKcvudNd1WYnwASSBkAyc33LtDNN4NlpBPtwXh0lj2YVVUDJqpZmbRdSMpqyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476972; c=relaxed/simple;
	bh=KehZcwkWdnhWf0oheib2pksWiItrtHlAvJaoTz5VeWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn4tAWF+qvtePOFLG9YqiM/C6LWIK2SRqErifGu06OHwluk/VAhoz+pe6MCv7JLxCnyVqajx+SSPGd/+jOgGzwU+SIfWa5wqa+6AIaDqReEg+I4A4gnwnMHTxVaZt0fel1Ty3QwRUF+TiNhI3zG/OFRY+KxEK0Xlc/zAPQw5aJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgI+OvBF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgI+OvBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476971; x=1821012971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KehZcwkWdnhWf0oheib2pksWiItrtHlAvJaoTz5VeWw=;
  b=AgI+OvBFH6lKpxSDIBF9m2xDig/SUMLAiZtjVH02lZ3NH9VTL+oHtcFy
   U0NYA/es6TYAUrPl5sHkE5MRWomb8HqorTaoDhcIk5Dp9qY8bwLgn6UX0
   ebJsFNkyGwxnII2ffGFDey4BQV2l/2CGZZmFk/EBgq3Bu6TKRir4bZxwL
   1b/vX7M6HIeRj0H5z5S0uyvToDGAUJN8cGOJFR0EqB9mGGIMijkExNz2l
   M7R+yK0Zut7tPizR1kbLSxJm1a3s4zSaDHVBnYWBk4UCUEpcYSUU0PvvM
   MyH+ldXXpJk5W0aM67+j3lGep+T9C27kobnpq6RoQzAyH/DWjG+DSMXdI
   A==;
X-CSE-ConnectionGUID: r7vecjiBQLyQRp0JtApfWg==
X-CSE-MsgGUID: BBhQ6mx/Rjaul42JF3lh0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607086"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112607086"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:57 -0700
X-CSE-ConnectionGUID: 0drApu48TcSxA8bkTa18UA==
X-CSE-MsgGUID: O7ePtFbmT6mtTuc3RJveSw==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Subject: [PATCH iwl-net v2 3/5] iavf: prevent VSI corruption when ring params changed during reset
Date: Tue, 15 Sep 2026 14:55:49 +0200
Message-ID: <20260915125551.3976068-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>

Changing ring parameters via ethtool triggers a VF reset and queue
reconfiguration. If ethtool is called again before the first reset
completes, the second reset races with uninitialised queue state and
can corrupt the VSI resource tree on the PF side.

Return -EAGAIN from iavf_set_ringparam() when the adapter is already
resetting or its queues are disabled.

Fixes: fbb7ddfef253 ("i40evf: core ethtool functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 1cd1f3f..3909131 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
+	if (adapter->state == __IAVF_RESETTING ||
+	    (adapter->state == __IAVF_RUNNING &&
+	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
+		return -EAGAIN;
+
 	if (ring->tx_pending > IAVF_MAX_TXD ||
 	    ring->tx_pending < IAVF_MIN_TXD ||
 	    ring->rx_pending > IAVF_MAX_RXD ||
-- 
2.52.0

