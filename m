Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE347F2C6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100520; cv=none; b=UdzAT9B/IbPhpr9A6wWhnCXjH3CXU7D9bymPUKlNAwUCQvrJJJb79QvalArHO9BtWn2u+fj3l5r6PM7KCd26S+VvyDQ19j2WXOAtYv3Q3l5juzvFqXzRROegy2+N+PZSD+5tIeiV7fuDq8veHERyRSsIPZUGI0Ozznm1DpHSe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100520; c=relaxed/simple;
	bh=31BLiW6+gM0P/lNSOno+h9fVruEdC4wIwqDW9dNzsgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWgEiGjjEPJ9fxC5+gXx8xQHM43NtKxMsYZzBQZeTiZu1lCAyBcs0ichVTv6LLYYN548GjAggqU6vJdWX6Ze4uK2CEUSTB2HkIrzU+tzm6WW1OuRYsfCXgFNW3Xl0vJl7IA+PE+6jC0UdREdtC2jhxHuwPRKwqIiuOaYtFPZN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4LRgaY5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4LRgaY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100518; x=1821636518;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=31BLiW6+gM0P/lNSOno+h9fVruEdC4wIwqDW9dNzsgU=;
  b=f4LRgaY5P6mgkCAVSR+fvv8oXuBOIU06mtZ1QxojQOfS2lAFRqSQ8xPr
   VFglRCnXJyaw+/kQszLrZH4TOV4f6pVQjh2xhQkQeQVni4a8HtfULo4Fu
   ei5ZcoPXwlQ5zZmQZcY2IionT//SzVAVkHWsNyG4GViKH5d3PK67Fibnp
   YcyVT8Y7S5caUFcXlIMMbxw2i1VY25/IDKiFCEvo57Tbud8Zo9C1boXCO
   PhG9Vq7kNM/2onvaisiK8sjoDQDgAyoMBUP5L7+MwysA3k4SbRWm6EPF7
   ad1VKc6dk8cRrixqG8JyLDR2EQGK05vdLq+xKkOr/yLyH0tFmR9ieNJtP
   w==;
X-CSE-ConnectionGUID: 95oTvxaxT0Wd+A9vSc/uMw==
X-CSE-MsgGUID: sNN0i9NkTxipwaZaQxp5rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232050"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232050"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: T+sVDZZfR16XKOERX5kDxg==
X-CSE-MsgGUID: uZSB8qFcS3Kb0GA3KTASrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315337"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:44 -0700
Subject: [PATCH iwl-net v2 11/15] ice: wait for in-flight Tx timestamps
 before flushing the tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-11-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Petr Oros <poros@redhat.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=GJLyGkVYnnRRmU5BgwXqkMVcvvTKw8l4fUj+knzvHbY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2WWOidyskz62PdbfdLqvxu+Zimc/i3pedRy4f2t6
 +XXu5g7d5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRDXaMDJsXZAudTPm3r5it
 Uy8nKDDYVvHZi81Ltm/OfOj+9jx3wjOG/9XXheftmf0zZ3KdvQW7EKfYtHIrVh+DBVaneKNsXzP
 sYgEA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Petr Oros <poros@redhat.com>

ice_ptp_flush_tx_tracker() frees every tracked request, but a request
whose timestamp is still being captured by the PHY at that moment is
freed without touching the PHY entry. The ready bit published shortly
after has no tracked owner, and the PHY does not raise another Tx
timestamp interrupt until every outstanding ready bit is read, so
delivery for the whole quad degrades to the periodic work.

Wait up to 10 ms for in-flight captures to publish their ready bits
before flushing, so the flush clears them together with the rest.

Note that the ice_ptp_flush_tx_tracker() function was introduced along with
the original E810 support, but that device does not have a ready bitmap.
Only later devices (E822, E825, E830) have the bitmap and potential issues
with internal tracking. Thus, skip the wait for E810 by checking the
tx->has_ready_bitmap flag.

Fixes: 10e4b4a3a3e1 ("ice: check Tx timestamp memory register for ready timestamps")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 657cd78ec738..142d9e1c1f2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -744,6 +744,47 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
 	return 0;
 }
 
+static bool
+ice_ptp_is_tracker_drained(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	struct ice_hw *hw = &pf->hw;
+	bool pending = false;
+	u64 tstamp_ready;
+	u8 idx;
+
+	/* If HW reset is ongoing, we can't access SBQ */
+	if (hw->reset_ongoing)
+		return true;
+
+	if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
+		return true;
+
+	for_each_set_bit(idx, tx->in_use, tx->len) {
+		if (!(tstamp_ready & BIT_ULL(idx + tx->offset)))
+			pending = true;
+	}
+
+	return !pending;
+}
+
+static void
+ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	bool drained;
+	int err;
+
+	if (!tx->has_ready_bitmap)
+		return;
+
+	err = read_poll_timeout(ice_ptp_is_tracker_drained,
+				drained, drained, 500, 10 * USEC_PER_MSEC, false,
+				pf, tx);
+	if (err) {
+		dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
+			tx->block);
+	}
+}
+
 /**
  * ice_ptp_flush_tx_tracker - Flush any remaining timestamps from the tracker
  * @pf: Board private structure
@@ -760,6 +801,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	int err;
 	u8 idx;
 
+	ice_ptp_wait_for_tracker_drain(pf, tx);
+
 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
 	if (err) {
 		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",

-- 
2.56.0.rc0.395.gd1f3524e15dc

