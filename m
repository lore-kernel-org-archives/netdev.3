Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC108513540
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738361; cv=none; b=ek+6irD9B6j1W9edWV1F94YH40OxC1QJdXbV23CMaWS91KTQszqo+MUVTVhld5qq4Wj48rKeff3Z6SldGT1lg0bGN4txut42+fe/wmgh1Z4EkAXgNwIxVfoTipf4bJo7y1Woko/CPpadc/Yug4Kexmaf0OmTWbsaPUtNABIpEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738361; c=relaxed/simple;
	bh=obzIt/8/SPc/HlGDlPOusLf41Nts5aDL0HrOu18ivq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/B3Qwcv3V+FAFT1rXvkBGTXkf8xSxAIt5GdydVmhCuaGa0yzWawScccUzuFD03AiP5Cz3R7y74TjnIOodVSl1Wu5eNoG6wo4qXLQscQhs3TkfLw16w8iBloKIHTHKiK7bgVvfoIPaq9obE7D/loFhqyuNmDRoxbalgwQ6t5Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4QahaTk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4QahaTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738360; x=1821274360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obzIt/8/SPc/HlGDlPOusLf41Nts5aDL0HrOu18ivq4=;
  b=R4QahaTkQV8dxPwOYrVsWb66Eqk4BS9wXI4VablXgvyLVEbEvN84FqqO
   35wW7106NFU2ax5/7zof8H3PXUnpkFjU/f8Dub3cKEC2zMtUlY36T9mS4
   S7uQyAW8wd51H4xZW0OfQq1P88yLP5nHa0YaYB+9rNu10Pyl10cTRWZMM
   KcIDFsnuZNwPkND5mDXt4cyXTbDYYw8OPTZawwVWdC6CvnBTMV3VNEAwN
   rd6oVX55aRMBgigWuxrXQXHlm2LTQzMd0KLoFIcTEEcqd6587zQIJJrEt
   ET1ilHEALPe/apJ9iugGgG5pPTXyi/kJrWvlwIkYT+wlArBrRp85EgPQn
   A==;
X-CSE-ConnectionGUID: j3rDcJf/T6CFqKKUFEuBkA==
X-CSE-MsgGUID: SpCrAg1IQBquGLMfp6bV6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776416"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776416"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:32:40 -0700
X-CSE-ConnectionGUID: 8akHuPLWQYC4xmWaesgv0w==
X-CSE-MsgGUID: GAuhM++uRkSURtjY+FmRkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835249"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3 2/3] ice: fix autoneg disable when link partner doesn't support AN
Date: Fri, 18 Sep 2026 15:32:33 +0200
Message-ID: <20260918133234.4169074-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Knitter <konrad.knitter@intel.com>

Disabling autonegotiation was silently ignored when autoneg had not yet
completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
unchanged with no error. This could prevent link from forming if the
link partner requires non-autoneg mode.

Extend the condition to also allow disabling autoneg when the link
partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
zeroed an_info when link is down does not produce a false positive.
Introduce the helper ice_autoneg_disable_allowed() to make the check
explicit.

Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 ++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a257b7d..4ce198f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2501,6 +2501,28 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 	return adv_link_speed;
 }
 
+/**
+ * ice_autoneg_disable_allowed - check if autoneg can be disabled
+ * @p: port info
+ *
+ * Check if autonegotiation can be disabled based on link state.
+ * ICE_AQ_LP_AN_ABILITY is only valid when the link is up; gate that
+ * check accordingly to avoid false positives from stale link data.
+ *
+ * Return: true if autoneg has completed, or if the link is up and the
+ *         link partner does not advertise autonegotiation capability.
+ */
+static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
+{
+	u8 an_info = p->phy.link_info.an_info;
+
+	if (an_info & ICE_AQ_AN_COMPLETED)
+		return true;
+	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
+	return (p->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
+	       !(an_info & ICE_AQ_LP_AN_ABILITY);
+}
+
 /**
  * ice_setup_autoneg
  * @p: port info
@@ -2539,8 +2561,8 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
 			}
 		}
 	} else {
-		/* If autoneg is currently enabled */
-		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
+		/* If autoneg completed or link partner does not support AN */
+		if (ice_autoneg_disable_allowed(p)) {
 			/* If autoneg is supported 10GBASE_T is the only PHY
 			 * that can disable it, so otherwise return error
 			 */
-- 
2.52.0

