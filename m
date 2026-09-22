Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B852480954
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100518; cv=none; b=QlMR5ESCnBCz4jzvNciZXrwfK9dRmLA4L6ghRBsmNyxulpAf7eTBGYdDbxxjkPMYPvanAxoQ8HPvYUb/JaujvXgjtqMkelFb+v6nrwO1RbxMwihs0hYP1zbLDJmnPCnd+K57Ou4qMPLL1yQ2nDmdTLM3vrm/CMhMXbYOwXhItrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100518; c=relaxed/simple;
	bh=uYQTnh0Hg1Gx19CjcekG5cvjGDYmClExgwMLJ2AUOzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwJK8bVcmtGdmjYyFUwiQEAMjb+9wJIdoa6vKP18KAoyKOiA0tso4XU4wbSHUFy/OdbYAsnimq1WUZ3s52n2JlyXktqVD8iOwR4IW7X3ZGc/ovsIh2lLfsOzvRsZrblsJFrmaNt9iicBIsTcrjLrTgMVUZVVHMjBq5UiSOUJsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip4/tK8/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip4/tK8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100517; x=1821636517;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=uYQTnh0Hg1Gx19CjcekG5cvjGDYmClExgwMLJ2AUOzw=;
  b=ip4/tK8/WW4s81NycEWXrhZM5puKa1ZBjdyYpERTi5esT4JVgJdjrnsD
   SKWIkD9iNRecDjsial93xpVj0GjqSvjzfqC9P3DySe1UtARnGuqaoXlI1
   g4hDG3vmfGipI2oabTNN7qTvS1K0zuQkqGXW/r3bd/50sa9JiJlLE1G34
   +gkMqv2w1PByw9layM3hxSZKrrjwiuuk2v2Q8HjZIuKEZnaoJsUD1z/ZI
   QHkxTuL3r65oYhawU60xMcKA4iZlSbAs4xNTjeQBBYfJvoVxEaWMyW/7R
   BMCqoEbuQW/jg7hf+6pfRfbEen3e78TrzYz4Bd6C6KLwDLSyBbUF8RoBl
   A==;
X-CSE-ConnectionGUID: /kbA0jQXTyi5NRPzrNtFJg==
X-CSE-MsgGUID: 1OQ9zUSSQ2iLr6sNKG770A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232047"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232047"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: C7mE2pZmRJKQ/eyWUD3DVw==
X-CSE-MsgGUID: Ucuzgu9nStCy6AYIXoT2Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315334"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:43 -0700
Subject: [PATCH iwl-net v2 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-10-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=uYQTnh0Hg1Gx19CjcekG5cvjGDYmClExgwMLJ2AUOzw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2XWa6lnbeJ34ktfvm39wg6/8we/cDhP7njgLHXXZ
 od21aTHHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzktx/DP4UmPs0EvZmq207E
 L1if/n9L+RGDvi43kec7gw/a1YTGsTAyLFz98XditEIio8FH9aWm/pc2JGfvj8rwOs/2cbKIo4Q
 ZOwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
including its timestamp counter has been reset.

Note that despite the name, this PHY soft reset only impacts the timer
block of the PHY, and not its regular Tx/Rx functionality. Additionally,
many configuration registers such as the PHY_REG_TS_INT_CONFIG and
PHY_REG_TX_OFFSET_READY are not reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e1a5ff5793d1..f8f985a5d039 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2128,9 +2128,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
2.56.0.rc0.395.gd1f3524e15dc

