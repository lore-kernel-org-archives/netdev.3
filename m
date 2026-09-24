Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0747F78E
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254775; cv=none; b=ZQwAh76uS+pNa8HuCPmdxnIlE4DNHJW+Es413OEruBuDIXalJSn6DX9mGbKKNhvViJnyL4aeo/io9sTW9w9LoVd+CiaXwumYZyul3MsqmneypGQqONSCzIhXY8BrcHUVfcJXUkHhtFfmiAvKoMf0HuatUp7kDCI1r70flmbtgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254775; c=relaxed/simple;
	bh=aaf1m91xnzH813tnvwtfaIyDWRoM2cZnDJhUGIqF7gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pes2TiyDY9KDy1MgdJ0VScfd9XnS6SRELcLfs3QCQ3zbzwsVKxRW0y6wWzn2opV0pcPl0yenG4F45oe9duvuucqxzwsYdM26E1yD3jcdWKHYU0mIRlmALE9tcn0+p/hdE3e4IEioouJ0M2kTy5ohnmRHpqPoDHOtf1e51atreKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doKnV8jF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doKnV8jF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254774; x=1821790774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aaf1m91xnzH813tnvwtfaIyDWRoM2cZnDJhUGIqF7gc=;
  b=doKnV8jFL4eWBwfn1mRewzqYpZXXe10ljYEM6uo2mz3NR5LGMv0pxQbX
   qny9wugUiWUCykQRjGr8HL3B/DBxQF/8f+oIxM1ifn24ecz/t8aECCIJA
   A49taZsEFHCxs4PQGZFtHFQJfJgd0/9RFEbUJmHRLkx7Eg2ZDQN7kWdX9
   0/+DpqJbv2JcjWkl+lzpMzZCxvOWMxhbizYBBNujDNtaSHSFJcZ/EG59C
   gGcpJgpF8knlTwXHHuEW+PYKajp2pdnIQ+uopRQy5FWwYYQF4oo89D0oS
   xR+Lfy3T7CTPMlmiJrPNccnxY58uS31rt1TbDmmwoVvSALdVNdpmMyWSf
   A==;
X-CSE-ConnectionGUID: TG4i1OkSSCafrdfS5FFBwg==
X-CSE-MsgGUID: p0Y5NCYGRTGW8BlzHO4K/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249235"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249235"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:24 -0700
X-CSE-ConnectionGUID: Kstyg882R7m8s9+Ax42aHA==
X-CSE-MsgGUID: ZQ29WJM5QrKjOd03Hq5+gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934428"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:23 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 5/8] ice: Clear the control PF pointer when the control PF is removed
Date: Thu, 24 Sep 2026 12:59:13 +0000
Message-ID: <20260924125916.2796499-6-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zero adapter->ctrl_pf when the PF owning it is removed and wait for
pre-existing RCU readers before its storage can be released. Without
this the pointer outlives the control PF, so sibling PFs keep
dereferencing it after it has been torn down.

The preceding patches make this safe to do: readers already resolve the
pointer once per critical section, and the PTP paths already reject a
missing control PF instead of falling back to the caller's own register
space.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Reported-by: Frederick Lawler <fred@cloudflare.com>
Closes: https://lore.kernel.org/all/aIKWoZzEPoa1omlw@CMGLRV3/
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3ee29c0cd726..3ed37bbae161 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3300,6 +3300,20 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
 	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
+static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
+{
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
+	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+	 * is being removed to prevent any secondary PFs from accessing
+	 * it after it is deleted.
+	 */
+	if (ice_get_ctrl_pf(pf) == pf) {
+		rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
+		synchronize_rcu();
+	}
+}
+
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
@@ -3656,6 +3670,7 @@ void ice_ptp_init(struct ice_pf *pf)
 	mutex_destroy(&ptp->port.ps_lock);
 
 err_exit:
+	ice_ptp_cleanup_adapter(pf);
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
@@ -3683,6 +3698,7 @@ void ice_ptp_release(struct ice_pf *pf)
 	if (pf->ptp.state != ICE_PTP_READY) {
 		mutex_destroy(&pf->ptp.port.ps_lock);
 		ice_ptp_cleanup_pf(pf);
+		ice_ptp_cleanup_adapter(pf);
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;
@@ -3697,6 +3713,8 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_cleanup_pf(pf);
 
+	ice_ptp_cleanup_adapter(pf);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	ice_ptp_disable_all_extts(pf);
-- 
2.53.0

