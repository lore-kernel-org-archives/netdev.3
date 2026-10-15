Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78756C63B
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091485; cv=none; b=cgWlAMTQOU+JUrQYZyRMyMHUJflHashu3pkDJ5k9G5XIe26q6CHj39S/iUzRqGWDGV61qwu6tS0/WX8qPwvZFzDP0EtyHgRnFOLp8YsW6yGkxCKPj/oaJdcKxys3O/HHLFVNCGsQZzn2cjNrwRptFBVQZ1tp+IY5C8DXk8f8PYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091485; c=relaxed/simple;
	bh=7UuaylIhX9Q3l2dVz4wy60e1pNB4H6bi9m+WdeixEm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eI3WRv6Yktz6OT6wnmyotiCj/BZfFBrrpsjTqTRUYvg30yVg49VHC/aYL7PatsQiXJqJNOlzU35EC7SAYFcw3uVL2MB4Hm/zhzYPjUV/fBrMfg1Rx/7MDPdepPYRyAE1ku+tEncikgEDJReIh0B+ndMWUNTsQkuYqzfjW2L51Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3j4UCC+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3j4UCC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091481; x=1823627481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7UuaylIhX9Q3l2dVz4wy60e1pNB4H6bi9m+WdeixEm4=;
  b=L3j4UCC+rZzPKKCqDkTriH6HgQrRGClHBCOM3g+R/6Vj0pk6VgUwDsFV
   Q7xTf9+qfIUrD0a8nb9D7FDyido9JXnkmmvSsYvKPliwbu8x1sTeRWnX9
   j41cbVe46FVJnA6JR7LGpwfEIj5eHH+SAoIFY/2uqw5+NbBytcENSgpCX
   MCKwSa539nHa9G0gENw96Lb2FcUH1wC9cFkEFz+wolxcK++M17rpEtbaR
   6uZTAHVRU5cfC8PhLWCdA9xrXTjffCFyiaGbXNH+7q7QLqIpcwLvHzpXG
   sKEPYPPFvOGqh2YkyIRSK9ynPQqfVjYj//1hgPv7c/CF2NwVtChA+OzoY
   g==;
X-CSE-ConnectionGUID: C4syMWoiTGWXF8HyuVaRuQ==
X-CSE-MsgGUID: QIridjOsTV+MF0xqqbDGMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765562"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765562"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:13 -0700
X-CSE-ConnectionGUID: iT2ePMC2ToqbEUjEryxfOg==
X-CSE-MsgGUID: 9AC6CRuQTyajnhn9x0JhLw==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078472"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org
Subject: [PATCH net v3 04/14] ice: set in_use only after preparing Tx timestamp index
Date: Thu, 15 Oct 2026 12:10:50 -0700
Message-ID: <20261015191102.1174111-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_ptp_request_ts() function is used to request a timestamp index for
use with a packet. When reserving an index, it sets the start time and
saves a pointer to the skb into the appropriate index. The function marks
the in_use bit first before doing any of these steps. The IRQ handler which
clears the timestamps reads the in_use bits uses a lockless flow for
reading the in_use bits to determine which ones are in-use. This is
necessary as actually processing a complete timestamp must be able to sleep
so we cannot hold the timestamp tracker lock over the entire sequence.
Additionally, blocking the Tx hotpath with such a lock indefinitely would
be problematic.

However, the existing flow now has a very narrow window where the IRQ
handler could see a timestamp as in-use but read a stale value for its
"start" time.

Fix this by ordering the sequence to mark the in_use bit last, and add a
memory barrier to prevent re-ordering of the previous writes to setup the
index.

This was found and reported by Sashiko while reviewing an unrelated change.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=7
Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d1cdd38ea27c..11416e23dade 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -592,6 +592,12 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		bool drop_ts = !link_up;
 		struct sk_buff *skb;
 
+		/* Paired with smp_mb__before_atomic() in ice_ptp_request_ts()
+		 * to ensure ordering the in_use bitmap and the indexed fields
+		 * in the tstamps array.
+		 */
+		smp_rmb();
+
 		/* Drop packets which have waited for more than 2 seconds */
 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
 			drop_ts = true;
@@ -2674,11 +2680,13 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
 		 * a reference to the skb and the start time to allow discarding old
 		 * requests.
 		 */
-		set_bit(idx, tx->in_use);
-		clear_bit(idx, tx->stale);
 		tx->tstamps[idx].start = jiffies;
 		tx->tstamps[idx].skb = skb_get(skb);
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		clear_bit(idx, tx->stale);
+		/* Ensure index is setup before marking it as used */
+		smp_mb__before_atomic();
+		set_bit(idx, tx->in_use);
 		ice_trace(tx_tstamp_request, skb, idx);
 	}
 
-- 
2.47.1

