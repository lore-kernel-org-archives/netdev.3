Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D113FBEBD
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508457; cv=none; b=d5YcW2PlHBYYxCF7QrKmo4jGzCsD4w+RsNHAcdFo4MyCUgy6MtvJdiWlje0D3nvxUmHYBdNibozPviBIxAx0WUtxY1LuEV47bpTP5AJKwT5noPaWqiCr79AJOuVEhoH63Sx4bytXY4GO7LQkdXT5fuiglc3iBjxyKmF1kVPb79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508457; c=relaxed/simple;
	bh=icADDd2KOT855mztfX2cI/CHcPBzXRh4dlK5GAnzF6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZTOSjf/+IRG5p3rLf40Yg756g+WLGo1TVn5J5yNoKCZ/Q8qaH4fyUw2kEiF4l6s6Wm+ecrohGZNZnRk4sWqoVbh8Dy2TM7pn62O6Vtee6mS56wHogn14qrLYtk5H5tXp6Rm3SFEhCYyX1Shw3cTCFx/p1ztCT0NocZYZD7EFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtAJXVHf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtAJXVHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778508455; x=1810044455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=icADDd2KOT855mztfX2cI/CHcPBzXRh4dlK5GAnzF6c=;
  b=TtAJXVHfdNM1aX2kQp7TeLVji0srjfB5gxQQq8MEJgW7VSLjxhTTexA9
   Id3zl9nsAgw2HvxsD6ZPSPCJAwMQhaWpCsrnsO7U3JF46S4ccMGhHMzWw
   btZ7vfIWx3eJb2Ix35iAHrV92CQtKH55gdmR0U/D3WGg/XC/sLRJ+K2VH
   EcvsxCHVofVQwnEgzevvSz2yF5a2mEKeQ8s/2N6GaZkV1/ckFi9pKqpWU
   fIBliedJTElQrB5skWFU8VPmMo91fusHQFhXrdfNSb/fGYzw/3UfWy7Og
   JMXz7FDJeCO/BPoTeRD75nTVS6zwOplBMHthQ02E1DRcS5SOj7gCcw5K+
   A==;
X-CSE-ConnectionGUID: KPC1sbzhTxuRw8K/XqiJlw==
X-CSE-MsgGUID: faYSMX6+SJKVkBY1h2ldrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83265218"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83265218"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:07:35 -0700
X-CSE-ConnectionGUID: 0WCFnalJQPmf07MWRufLuA==
X-CSE-MsgGUID: gD8yFaKaQ5m7LD48yE02Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237685824"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 11 May 2026 07:07:34 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AEB562FC51;
	Mon, 11 May 2026 15:07:32 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 05/10] Revert "ice: remove unused ice_flow_entry fields"
Date: Mon, 11 May 2026 15:07:04 +0200
Message-ID: <20260511130710.38801-6-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511130710.38801-1-marcin.szycik@linux.intel.com>
References: <20260511130710.38801-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4cd7bc7144ec2c0bb27208c3bb1f153dfd44b1c7.
These fields will be needed in the following commits.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice_flow.h | 3 +++
 drivers/net/ethernet/intel/ice/ice_flow.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index bbfc7b4a432e..ff6af6589862 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -458,8 +458,11 @@ struct ice_flow_entry {
 
 	u64 id;
 	struct ice_flow_prof *prof;
+	/* Flow entry's content */
+	void *entry;
 	enum ice_flow_priority priority;
 	u16 vsi_handle;
+	u16 entry_sz;
 };
 
 #define ICE_FLOW_ENTRY_HNDL(e)	((u64)(uintptr_t)e)
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 855d296aeed8..e42367853253 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1604,6 +1604,7 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
 
 	list_del(&entry->l_entry);
 
+	devm_kfree(ice_hw_to_dev(hw), entry->entry);
 	devm_kfree(ice_hw_to_dev(hw), entry);
 
 	return 0;
@@ -2024,8 +2025,10 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 	*entry_h = ICE_FLOW_ENTRY_HNDL(e);
 
 out:
-	if (status)
+	if (status && e) {
+		devm_kfree(ice_hw_to_dev(hw), e->entry);
 		devm_kfree(ice_hw_to_dev(hw), e);
+	}
 
 	return status;
 }
-- 
2.49.0

