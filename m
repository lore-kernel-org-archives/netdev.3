Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5A282F05
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357707; cv=none; b=c7yr5hUdVkIjzefgnxQHckbGs2JZR44hmYct8Bg7NauuBbb2MdfWD+m7ndv2ZI8YC+RMpa2IRLAbitRBf6ZOhWxDHCQGjLJq2be2zJq0tW8+hF/amn5Zc1BRBFNt6CKj4p2xeQbuh4Ik5HHBhX4NxoZIZpLDJVhlubgx/xHQuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357707; c=relaxed/simple;
	bh=DdiuRcPosYhy7NuVjHP3/zhyDcqMNAbUl/73h11PIl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g06Ias9fItd/gQPjMoJj0jfpiRYGDaCucKR9Aw5pCX/9XKAa4KY7ja1zkRne9+BQDrU7vBOPJmHQXX0iMZnPg3yIvdNXBn4eYuez+dd+LO/u490XxG1kK+TgMR739Yu7niTlBtN7lkeLpRJ0vAU/s3FiqE+M1+QSV+NpG03P158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEBkAa7e; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEBkAa7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787357703; x=1818893703;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DdiuRcPosYhy7NuVjHP3/zhyDcqMNAbUl/73h11PIl4=;
  b=bEBkAa7e3GiqCwmwh//ACP5gw6hx4QeV3vXwNJP+qfTgyIxH1EkVOnYB
   H/L7DH5hvlzMtCCmzSPfLbG7A0R5D3sgiL/k2TyMkYfl/G6DYVL3mSUQL
   mckrh+ccZvVyVcqIJNeY1FRGylMr3cdSAI7GGI2NIWRGsbySjFOShoZ6V
   iWzqTuqutM1r3tcSELH6lQAvdeTvVmmP1xQfaH3a8n82+36ESwjWX8Zaq
   mNcKkZvS39Sy5zeiICc090AsETcAlB/OLlxOzCkpulcRjhWmGYKt4qPM/
   TSdqBpuGHEtVVjCCD9oh0yxHdZt/o201xCoO5t0yeh55UVIbJXFot46Zy
   w==;
X-CSE-ConnectionGUID: +6zxw5zAS8uaSN5EAOUmJA==
X-CSE-MsgGUID: wsdhQ9pzSW2QsHC0rodxFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584778"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91584778"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:59 -0700
X-CSE-ConnectionGUID: mlqXvjHeSu67qo1hXgFPYA==
X-CSE-MsgGUID: 6w5qdaGrRS253bR0oYOB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263836484"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:13 -0700
Subject: [PATCH iwl-net 08/12] ice: wait for in-flight Tx timestamps before
 flushing the tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-8-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=2476;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=z6i5K5O1IlONQimxEEaxr21SOuuhG2xszeqrH2sUzp4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl7+6RCdFL7M7/uiyzoRlr/YF13Y/ZFx8df350GfLp
 qTZNC8X7yhlYRDjYpAVU2RRcAhZed14QpjWG2c5mDmsTCBDGLg4BWAijSaMDO1JbQ4bK39571Bo
 3HfRUEmK69M598e+208etXfxmh+ypZKRobtZ7QlDUa2Ek0TLPQMexTU1fZknP+7UYzk7a2sf68Z
 0ZgA=
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
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8aa49dda90a2..a049dc7a2241 100644
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

