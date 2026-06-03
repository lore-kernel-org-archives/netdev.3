Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A6429838
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524523; cv=none; b=mxYF7esG+Y8PykTnOvig6x3OnM1U1Y71PiOl/a3F74URGHsjXfnZbZcfe9RfGqsAYRdB/PtLfr5iTyE25irOOwPDx6y9YIX28mn+f7pPFWKO6Hx6XkXzQSCZBxZxLTf86pJq560j8PfRIDDOi7+01DyB+4aiDYwZAqX5Q9kq0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524523; c=relaxed/simple;
	bh=xMjMhsXvcr4RubSyP54Dwn0PQZiqO+x8RVaTF1G3eAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBDPIAboGGjHStEZ/n4T1ZwLWThm738DnqoaFISr+2qxXUy3RdHrbOFYrFrAWTvBkrlWMYyrJXF3zGNV8AiS7LWqupkyEYDlWQz7vODib87BW7eJ7nFXvgg69+OukMesY/98vvF7L8KkBQrA57LPca2yUa35nKMFxUsU1PASljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCE2mSB9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCE2mSB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780524522; x=1812060522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xMjMhsXvcr4RubSyP54Dwn0PQZiqO+x8RVaTF1G3eAM=;
  b=oCE2mSB95nK3iwom0osa8rCE2HE1t69Pojk9C4k29UeguAGhNaFV3kJ0
   e+IUdzxf140+tTw7myq3dwdXC9QspsK4rXa9fRj+yK5H6yK0UGnVTBWYE
   12aSOSLEMpCqUGXEMaBsKEfLHF0UVtBBAItieOyhxBe3jwKj121KAeUEv
   fHDe0PObboGCSgPzggRrfn5IagvTuiqMzjmECLaKaLOtY5f0A58hxio4C
   SM5U7dqEIl5O3w6W9rwANSVqEtNQdC/zjzgIiqRqi1D+JiFepoMZWYli4
   uvduH4G9MydWIR10qTZGvrdOL+HW3UebyGbZGCCpHPuk50zTCeuTqOA12
   g==;
X-CSE-ConnectionGUID: folMfXnoR2OBvEBfo1Ileg==
X-CSE-MsgGUID: eA+Qw+MGTCqpBBXR19b3xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98920919"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98920919"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:08:36 -0700
X-CSE-ConnectionGUID: 44rsnV7/Rr6LITmdxOW32g==
X-CSE-MsgGUID: VGRNZjLjRbyhYkUH5qChmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282458892"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2026 15:08:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 05/10] Revert "ice: remove unused ice_flow_entry fields"
Date: Wed,  3 Jun 2026 15:08:21 -0700
Message-ID: <20260603220828.829969-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

This reverts commit 4cd7bc7144ec2c0bb27208c3bb1f153dfd44b1c7.
These fields will be needed in the following commits.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 5 ++++-
 drivers/net/ethernet/intel/ice/ice_flow.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index 7357088091bd..23e366ee1f79 100644
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
-- 
2.47.1

