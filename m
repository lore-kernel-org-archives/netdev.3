Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDB4DA9B0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670386; cv=none; b=Kn/yBT9eUi/AxCbrzUiFyi+EBVL49w4qofv3TjR/OC44mROAClJvBV6Ygiz6BJjoDiC4rfHq1CnH+DanxBUFjndCPOVMB+Q/GwwTwa1GeYJ4Lm/JsVoSOwqe406Cj51vYY6+VRO1ukdWt1t7QGYD7xDsH65cMuhX6ROCuRQcEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670386; c=relaxed/simple;
	bh=5D/nOuxiaUSNtc8Cno9S/bh9rDJkLMsS/ZObVTY7s6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciOpsmKSsdXOn6z26K1OFtRTjZeDKwAvchZlvh44lO2glNGkad5mKvW6rLfK4+mdzhWKg5AmQfPNWqJ4asaJG/AFrAbB8b6Ix3KKI/kcvAWjvyxqepFOhGwxggMMPQfGpqzWHoLHVJz549xLJq2FwUFlWRjaSyYLX0WcmYsOQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkIuYsPc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkIuYsPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789670383; x=1821206383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5D/nOuxiaUSNtc8Cno9S/bh9rDJkLMsS/ZObVTY7s6s=;
  b=bkIuYsPcj6ciU2CQTRe3QPX0GKnP7NdlUyEdoCSIAuAJi7gu4Zmozxrn
   UCsY1KjZxesQWZ1W6SplS0muqp01bLMvzfBgJlaEE66G/Ghq9LqnNW9J/
   P90PwfW2lzorsJBFYG6QpejluSVvxSwRs/S8/wpPIEFZsPdoFo+/ebbGh
   oWnAhF7WC5OVR/oViVF+EvQRwsnIMMTkyFPsTbllcVFErKEi65TlFn5M6
   JBdrjXOc3hozsnTc4f3exFJZ4QXwpHdrreHqc+KdFeQlNtWE0xFNRfP5P
   SitHPcSZ7/9rxEkUzN8QETuGBQ0VhpWfI0iMviaqdyQrByHnWrmvF0Azh
   A==;
X-CSE-ConnectionGUID: 5CtUIw2AQl6VG45uvvQr+w==
X-CSE-MsgGUID: rDNQuU7oSfSXRZZHmnReQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100722092"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100722092"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:39:37 -0700
X-CSE-ConnectionGUID: EoFr9HciTj6hNNThvMiYAA==
X-CSE-MsgGUID: dHotCOf6QQSvAUIkxaqPsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267728745"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2026 11:39:37 -0700
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
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next v2 06/12] Revert "ice: remove unused ice_flow_entry fields"
Date: Thu, 17 Sep 2026 11:39:18 -0700
Message-ID: <20260917183927.2692068-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
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
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
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

