Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F74A1DEF
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476973; cv=none; b=FXSneR2C4rkl/LqUaakpXRuFVc0SWPd7FzKTdrFOlPEi31WWo8D/MZwEwQrImhyVHzPeamzX0nNiqKr/816PCg6WjlOewnCQgT8NofsL93n9UqRn6LjwllfZkGTSYZBhptKSpIKD8LvQcjFQChkjZMCSJHli9KEUrCwwcZHaEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476973; c=relaxed/simple;
	bh=GgxD624Eu0lCw/tTk89CMQqXWPEIP9c3nFeqMp5ikOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWEQA26qaMT74tK6iiVWD0hvc2VT1UG4JhzNOpCWzzqhJ3clGbLAl6svRjGKDVZYj5knlGGyeNJ+Dvza1BHk4hs4hL1fbJyvDhtHdg5tIdSx/n2lHD7DNfn2smxUiGBpgrrOVs24ZVtM8F9hj913ejzm01U2UBpZZjEAD2NU9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEoyA362; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEoyA362"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476972; x=1821012972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GgxD624Eu0lCw/tTk89CMQqXWPEIP9c3nFeqMp5ikOs=;
  b=UEoyA362x75+eBBS027zKma/PotVQsOxDHYYl4zHQHSizxu40hKYVsIt
   gPQLJOtSHwtnJ5AkGzpfCdU5ApjztVhz2dVe+/v5QlpcLONJMpNouCLX9
   +DEvja2tmDZokL14DjTLdnv+diz1f7eA8yFc1AWy0AXLjGRe14lJYZXfL
   wCRJCAxnH9yHkiJ1KRGyVJwPsAHSXsPyQdjdsG1M1CmehzrlXhSdYTJhE
   /vNScSajhuayUrSmD8HtR+x/CHovOWabFRBiJbxRfP9zj/ndZBJoy3Cxg
   ukJ0nLe7C83PXXwCEvorUPw+Rt8Ncs5Fi09xc/FHwp53VBium6p0O/jEK
   Q==;
X-CSE-ConnectionGUID: Hi7QCXhKT3WWBbmr5PjToQ==
X-CSE-MsgGUID: EdBSMC4kQ9i/cKmjV3IHMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607104"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112607104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:56:00 -0700
X-CSE-ConnectionGUID: MOkHcWd8ToGKs5Qu4036ww==
X-CSE-MsgGUID: BfqJPAaMS3S7ro8VmGz+jQ==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:59 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kiran Patil <kiran.patil@intel.com>
Subject: [PATCH iwl-net v2 5/5] iavf: return 0 when TC flower filter not found after qdisc teardown
Date: Tue, 15 Sep 2026 14:55:51 +0200
Message-ID: <20260915125551.3976068-6-aleksandr.loktionov@intel.com>
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

From: Kiran Patil <kiran.patil@intel.com>

When an egress qdisc is destroyed, the driver proactively deletes all
associated cloud filters to prevent stale hardware state, decrementing
num_cloud_filters to zero in the process.

The kernel netdev layer is unaware of this implicit cleanup and may
still try to delete the same filters individually. If the filter is
not found in the driver's list and num_cloud_filters is already zero,
return 0 instead of -EINVAL to avoid confusing upper layers that
believe the filter is still offloaded in hardware.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Cc: stable@vger.kernel.org
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index e5bf15b..de80947 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4162,7 +4162,8 @@ static int iavf_delete_clsflower(struct iavf_adapter *adapter,
 	if (filter) {
 		filter->del = true;
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
-	} else {
+	} else if (adapter->num_cloud_filters) {
+		/* other filters still tracked, so this one is a genuine miss */
 		err = -EINVAL;
 	}
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
-- 
2.52.0

