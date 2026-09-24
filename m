Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC07481664
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254779; cv=none; b=ZJ5gtAUkkvZupvr9pNypeoH5EofKm8ZyFYWSp1o/STIgZ71FdcrIWPZyUihZPRq4a92LWFEVweUEJCWICcZp1pw828YNzy1DaqnFVXx5pNlMXrOD5XV+1qtP2cVu+4k0h2YvtrrD2wWH5THGdl1N/MBSke96dtzcNftRldyotmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254779; c=relaxed/simple;
	bh=mKsIOdT7NnHNwx01DI9VzOebkFr0BP1VEviARtH2q/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7AZTDUrWuJlpjNV+0AKlB1JAdS7jbduqlB4YbiyYPusX53ltEWMi5oDzjK2t30owOT3oN/73EEVG8IAYYQESJjpEmpwNceb4PdI6X5qD6juUUcMJaQWtI0MkFfRocZ51PE0g3rAforLpE/br5/9CQCLBaGBLSajFSsCCmf5Svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IY2adZIh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IY2adZIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254776; x=1821790776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mKsIOdT7NnHNwx01DI9VzOebkFr0BP1VEviARtH2q/E=;
  b=IY2adZIhZ8X6dXhs+TrQ/JbJaHHMCsfuxu0d5fjuEEqst4RjzMvUzXnd
   XqK7aTa01zSTrCA1eYEc2fJRYRWtQqE1H8GeSjX+k6l7+dkmiAxCNInrn
   /5pDJbXnwYXymyL2l4WyZAwI5bOL/wwtcV2wTDNT6MsOtgmPVQZ0WhSw6
   nF6fKHnZVoZUBv83attM8DBQeWMfR2SAsxpTG3oE9XYu1Feq+p4w3+2XJ
   9B6pvbsvkjjAUo9rcMnEu4YQStbXoqFe4FMDt6L2H5vQgVYhaEBY2DoSI
   NYa9euMD90Y5Ea9Il0YYLOhoxSxv29031hU/+imHAqEGVw0HHfRvXKAn7
   Q==;
X-CSE-ConnectionGUID: F3ejFV/2QLKr3/kY3aW1tw==
X-CSE-MsgGUID: HRvGcXBMRhK4up4G4fep0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249256"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249256"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:26 -0700
X-CSE-ConnectionGUID: TpJN7cXJRo2WmkSjOOVbaw==
X-CSE-MsgGUID: bSiv6btbScuyDZd45+odbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934433"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:26 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 8/8] ice: Release control PF lock before RCU wait
Date: Thu, 24 Sep 2026 12:59:16 +0000
Message-ID: <20260924125916.2796499-9-sergey.temerkhanov@intel.com>
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

Clear ctrl_pf while holding ctrl_pf_lock for write, but release the
rwsem before waiting for pre-existing RCU readers. The published NULL
already prevents new readers from acquiring the retiring PF, so holding
the writer lock through synchronize_rcu() only stalls sleepable users.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3ed37bbae161..24d4ab2197c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3302,16 +3302,21 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
 
 static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
 {
-	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+	bool synchronize = false;
 
-	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
-	 * is being removed to prevent any secondary PFs from accessing
-	 * it after it is deleted.
-	 */
-	if (ice_get_ctrl_pf(pf) == pf) {
-		rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
-		synchronize_rcu();
+	scoped_guard(rwsem_write, &pf->adapter->ctrl_pf_lock) {
+		/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+		 * is being removed to prevent any secondary PFs from accessing
+		 * it after it is deleted.
+		 */
+		if (ice_get_ctrl_pf(pf) == pf) {
+			rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
+			synchronize = true;
+		}
 	}
+
+	if (synchronize)
+		synchronize_rcu();
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
-- 
2.53.0

