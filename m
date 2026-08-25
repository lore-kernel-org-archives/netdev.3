Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C14908A0
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698517; cv=none; b=uEK9jh13thIy87hB27X930DBXL4EPve7IVVLSrFf8XDWwfhi1TfB0MofKFJ6aIwq8wn/JJ0wG0sOYd2WXB2oY0vo3S1BnoP/CPUm665MQxQxveTa0Tkdsc4feZ4HXfhDQNXgZCj6P267Xv/9cW39ZK+e0X8WHGunZL+Bp7vPWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698517; c=relaxed/simple;
	bh=SYQ638ls0iaQ5NOJX73+AOiJst5sa1nueiULyMyePR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0+ceCptXSMTuzaKkpoPnLMt2NjDI5ABTCcPIRStbDcgZm6UD7QsuTsyLHQol9FOw+N7mLC/xxmCHLTbqtvOS0+RmXNUP+3F6kRBV8zW+uuTGpfBvqcEXe6TgeBlpRjJE1u83/TsDozCZZAHvY1MYWRfFXCIk3S45ujrYObbLpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9G90Aoi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9G90Aoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698516; x=1819234516;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SYQ638ls0iaQ5NOJX73+AOiJst5sa1nueiULyMyePR4=;
  b=f9G90AoiiZPP/rCNnWeqIqT42ZAVAtzxwenrKvA63kESoRud335jANnG
   Wl4535lhBkq1abgGS/PZ7R0osByGiSag06NAHO0rkEzLk2eB7fuOtuVZ2
   Ni2JhR9H6lo+reF4G1pV/laSnk5IZGhbYz8KnXAJxqACDr9aVCi7WPiVq
   qT74+MB3eoaoKuvaLFQjTDpQmOTwrSUYCwyMMLboMDTTYDHhaqm7j5f8m
   n3iRT5XIO0NlBx7nFo1qYxsymJh7u3g4z5AQrM4yDPz/5i+2jp1MT36Iu
   C3N3kyAM66RoPtSIdjGzT7ERvBQujnl82C/jy38V/C4HgqY2G/6z3Z9p2
   g==;
X-CSE-ConnectionGUID: qGffBMNURquIMbZV8IooUg==
X-CSE-MsgGUID: WfxFT6FZTT2hxzmeC3DYqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120442"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120442"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:07 -0700
X-CSE-ConnectionGUID: O4HLaHlfSRq/HW4HRfkCHg==
X-CSE-MsgGUID: RDPRJnq2RPe+oSvXB0806g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789692"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:34 -0700
Subject: [PATCH iwl-net v2 10/14] ice: wait for in-flight Tx timestamps
 before flushing the tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-10-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2534;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=nw+J/yGspiIlrSItsx0RtBZBWcC8KghOWywDHXUUTYY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WdtNi47fzL4VIMQ3/UG6H+/Z9w2blXh3sQVI331UL
 LgnRuh3RykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABMximNk+H5L9DjH1FdHHhZa
 zHZmtdp/0NMxX1cz4I3m+unPDkQrBDEyrMhaEqw8k1mLY1P2vpdFrTahG27Yx+rpHp60fgdLHgc
 rFwA=
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

Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index c535658b30fb..59972de1eda2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -740,6 +740,37 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
 	return 0;
 }
 
+static void
+ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	unsigned long deadline = jiffies + msecs_to_jiffies(10);
+	struct ice_hw *hw = &pf->hw;
+	u64 tstamp_ready;
+	bool pending;
+	u8 idx;
+
+	if (hw->reset_ongoing)
+		return;
+
+	do {
+		if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
+			return;
+
+		pending = false;
+		for_each_set_bit(idx, tx->in_use, tx->len) {
+			if (!(tstamp_ready & BIT_ULL(idx + tx->offset)))
+				pending = true;
+		}
+		if (!pending)
+			return;
+
+		usleep_range(500, 1000);
+	} while (time_before(jiffies, deadline));
+
+	dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
+		tx->block);
+}
+
 /**
  * ice_ptp_flush_tx_tracker - Flush any remaining timestamps from the tracker
  * @pf: Board private structure
@@ -756,6 +787,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	int err;
 	u8 idx;
 
+	ice_ptp_wait_for_tracker_drain(pf, tx);
+
 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
 	if (err) {
 		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",

-- 
2.55.0.814.gc42f45431d0f

