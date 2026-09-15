Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556D44065A
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476973; cv=none; b=GaKiponmJN3FXs6T4UXee3GESAaPpAPWKYMU8yj05zpcuqq8L9MudVk+uavrmTgxw9gmTqv3kjan2YIqoXnE3P+vgeDm2MedJhJANlvIPv9oTmRQw0yrQynJCaDXNjgEmUsi+sGwNJhpBbH957JziOAPz8m99lsY3/aicklbm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476973; c=relaxed/simple;
	bh=aM4iJYBdmPrwxDojTTWajxKiBW00z3SlPeWCh6QehOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RY/NhNsMzrob5S7T/zylpXX6hp6B8Q5tSAO+6w9caybY2R/PnL33VpElGQLsEF9mJELzGy+UpmxAzilRw9U+D+sQ0tDXDUICgnDtMSLJ2wxMv5v1w8GZayR6xlvVux3sryoC8dEcHEUHNlOEVkUFIP9KA1ixSx4ZA01/ZURZ9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGSa+Ctu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGSa+Ctu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476972; x=1821012972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aM4iJYBdmPrwxDojTTWajxKiBW00z3SlPeWCh6QehOg=;
  b=DGSa+CtuhgN9WAAxYv86NRittObF34I3t23+5sV7EcsVjkuvzNs26ZWU
   8ps5hyPrac1ZhLzjWfwKEIYnSgQOxAFElhqt+YCk0hdPtqtzYv7+wWGl7
   zYJ7EMxscm9M3MAYHLV+iWhO8V111luz+2m0STxBP4Kmr0D1ilrh46HZn
   WNQBwFopqnzI7aDkY2GW4LIvQnD8E1Xj0NoUVzTavHC+ulCWFdDYpR4es
   7leP4MzVosaVfqwMiAlCkH4exdZdldmizFXIp4FiTfwaAqU/UCJGQJie6
   Mqdg7D+XlaIcS6DROcEIfVvkHoKx1CuNdm6auy37sg9sQHb8XV5YsShAz
   A==;
X-CSE-ConnectionGUID: zAzCU/3ATyOGid522R3sDA==
X-CSE-MsgGUID: exxhQbPqSVCX7ZwarKxWhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607094"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112607094"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:59 -0700
X-CSE-ConnectionGUID: TI4Y5hk0Tjej+rVZrZOJAw==
X-CSE-MsgGUID: VEK50ZFuTma+yQau4hptEQ==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:58 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Avinash Dayanand <avinash.dayanand@intel.com>
Subject: [PATCH iwl-net v2 4/5] iavf: fix TC boundary check in iavf_handle_tclass
Date: Tue, 15 Sep 2026 14:55:50 +0200
Message-ID: <20260915125551.3976068-5-aleksandr.loktionov@intel.com>
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

From: Avinash Dayanand <avinash.dayanand@intel.com>

The condition 'tc < adapter->num_tc' only gates the destination-port
check for in-range TCs; when tc is out of range (tc >= num_tc) the if
body is skipped entirely and the function falls through to
VIRTCHNL_ACTION_TC_REDIRECT and returns 0, silently steering traffic to
a non-existent traffic class instead of rejecting the request.

Simply flipping the comparison to 'tc > adapter->num_tc' does not fix
this: it would let every in-range, non-zero tc (tc <= num_tc) skip the
destination-port requirement entirely, while an out-of-range tc with a
destination port set would still fall through and return 0.

Fix this by explicitly rejecting tc >= adapter->num_tc with -EINVAL,
and only then requiring a destination port for the remaining in-range,
non-zero TCs.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Cc: stable@vger.kernel.org
Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403..deb03f2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4047,12 +4047,15 @@ static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
 {
 	if (tc == 0)
 		return 0;
-	if (tc < adapter->num_tc) {
-		if (!filter->f.data.tcp_spec.dst_port) {
-			dev_err(&adapter->pdev->dev,
-				"Specify destination port to redirect to traffic class other than TC0\n");
-			return -EINVAL;
-		}
+	if (tc >= adapter->num_tc) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to add filter because of invalid destination traffic class\n");
+		return -EINVAL;
+	}
+	if (!filter->f.data.tcp_spec.dst_port) {
+		dev_err(&adapter->pdev->dev,
+			"Specify destination port to redirect to traffic class other than TC0\n");
+		return -EINVAL;
 	}
 	/* redirect to a traffic class on the same device */
 	filter->f.action = VIRTCHNL_ACTION_TC_REDIRECT;
-- 
2.52.0

