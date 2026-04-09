Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9713CF05C
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739630; cv=none; b=EBaViAJ9Y6P68M6IZ4DudNExuTQ7Al98pdmvyL9VqAyfS7CG0uuNrwHgPpP9nyRhd5fiIWxEEKq8daKvYTVxHEMOyQxK6H7iOM/fGezaYMbK+QYpHjwt64nQoXc4nPq0oGEjy1LT3dDPgH6cxAx/fkkTlNj9jwH7socIrpvpONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739630; c=relaxed/simple;
	bh=fw3VWQaw3jKVivPmKcKZkhU6kwzRwU/BAJwJqJQoaQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td+lV5k80Bq0yMQrB7Lh1SEJVsjtp31YaDW2iR9cHF5q76ZklYmxQGBTkbKqDrdmsNZoobTq2tvnfd6dSaOM0dD7zcjJegUD7xuIKS15A+rYpMogtStlR44W5QEUjt9S4R0sh2mEosmRwmfZQiJBz00x38DDMIpmCCUHHL9Q1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuY/AC3+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuY/AC3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775739630; x=1807275630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fw3VWQaw3jKVivPmKcKZkhU6kwzRwU/BAJwJqJQoaQw=;
  b=EuY/AC3+Y0tbbKXVTbSuPMy5RVI1S85evDJtFaHWZ1gmcf4VqH7VzV/X
   haOqcU/BLVzWBUQF9cEbBcP2ogTuI7VxufKahf1GKL+OPFq150kcYymwL
   zycB2d87Gn3K+PQ/cKIYjHSxove1T1XwYGrHVGIqiMllwHfXjEbgY/o35
   xpnKo93s/tAzqkLCvZxieqmMiuKtmOIGbUpmy4HZ0IJ4sqU4erF3fDjH2
   9k0MOAs/UQkaRpoiMKeutyjGCBp3vxrY14X6TtIoxeeo2g/c3rEoIwIoR
   4U/RvASu5lecxWwvTENRQU6MpM4C033hpCVyHHxFJdoqiVTT3l5bVH03l
   Q==;
X-CSE-ConnectionGUID: nvXxOyhEQEqp3dTg7Ssvbw==
X-CSE-MsgGUID: 6ee3KTyPQCOFIGbDFDqjSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75777535"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="75777535"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 06:00:21 -0700
X-CSE-ConnectionGUID: dMn2HIOoRGGLC69kyQk0pQ==
X-CSE-MsgGUID: 7BHlYphpTbqhInD1DSh7oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="259208137"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 09 Apr 2026 06:00:19 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1C6B92FC58;
	Thu,  9 Apr 2026 14:00:18 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2 09/10] ice: re-introduce ice_dealloc_flow_entry() helper
Date: Thu,  9 Apr 2026 14:00:02 +0200
Message-ID: <20260409120003.2719-10-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was removed in commit ad667d626825 ("ice: remove null checks before
devm_kfree() calls"). Now it's useful again.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 33 ++++++++++++++---------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 144d8326d4f9..20ee85b0bcf0 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1589,6 +1589,23 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
 	return NULL;
 }
 
+/**
+ * ice_dealloc_flow_entry - Deallocate flow entry memory
+ * @hw: pointer to the HW struct
+ * @entry: flow entry to be removed
+ */
+static void
+ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
+{
+	if (!entry)
+		return;
+
+	kfree(entry->entry);
+	kfree(entry->range_buf);
+	kfree(entry->acts);
+	devm_kfree(ice_hw_to_dev(hw), entry);
+}
+
 /**
  * ice_flow_get_hw_prof - return the HW profile for a specific profile ID handle
  * @hw: pointer to the HW struct
@@ -1760,11 +1777,7 @@ static int ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block blk,
 	}
 
 	list_del(&entry->l_entry);
-
-	kfree(entry->entry);
-	kfree(entry->range_buf);
-	kfree(entry->acts);
-	devm_kfree(ice_hw_to_dev(hw), entry);
+	ice_dealloc_flow_entry(hw, entry);
 
 	return 0;
 }
@@ -2899,10 +2912,7 @@ static int ice_flow_acl_add_scen_entry_sync(struct ice_hw *hw,
 		/* As we don't add the new entry to our SW DB, deallocate its
 		 * memories, and return the exist entry to the caller
 		 */
-		kfree(e->entry);
-		kfree(e->range_buf);
-		kfree(e->acts);
-		devm_kfree(ice_hw_to_dev(hw), e);
+		ice_dealloc_flow_entry(hw, e);
 		*entry = exist;
 	}
 out:
@@ -3021,10 +3031,7 @@ int ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 
 out:
 	if (status && e) {
-		kfree(e->entry);
-		kfree(e->range_buf);
-		kfree(e->acts);
-		devm_kfree(ice_hw_to_dev(hw), e);
+		ice_dealloc_flow_entry(hw, e);
 	}
 
 	return status;
-- 
2.49.0

