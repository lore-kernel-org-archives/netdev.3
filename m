Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4355484882
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100510; cv=none; b=Unot3rStDFHGtCD7rPO4ynFIwaOgGlqfH6lT1CBy7R+cbp9pir3K63KjYMzg3p9aLunfcn2xRjPb/OBt97xrL3SOAZ1bwc1TUvI1ftnGbTHIsC266GVy4m+4kdcpVNlgnEtXmfQANisF8mcUDCNLDsyJFmU5RE+WtD+yWOMofPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100510; c=relaxed/simple;
	bh=w7tzbPfgL4SemDDc1M67jm5pchylDvuJvcpfrnE0kjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9IyXwvFSj6/An1xu6czxI5rZ6E2DyLwBZN/NxJgvlYy+oiMLDOJva6Tt0bdrNxHhykpPKbgHp7l2hBa0rVytE8ruIvWfbzVChC5ZvzSV9AFvqaZ0JLUzkkYnh2RHN1clK++HY8ah9+sn8N1uT0LpAR2XioYme64cvyWotg1ulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fF0pWsAP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fF0pWsAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100508; x=1821636508;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=w7tzbPfgL4SemDDc1M67jm5pchylDvuJvcpfrnE0kjw=;
  b=fF0pWsAPwz9IVDL3xA/BGoEP9EMwjMDlWKdsytxO7xQ2I2iAnvzFD2Vl
   6NVRX9+gU5I8NizotCNnNwkIsVAsCxR5POTo+SzyzqAiEEKX1tiwyqjQ8
   ISPqceL7NsDEKWfZqpCs6KBmEZglBy3UR+AI9mvFk7D45AN2MF0e0l3xd
   Df/EA/Vd4jery5Fy1USCHVnjtPoSOM64Ufdi9/0YlAIi/PKIjh3EVlDWy
   zQJmUkOw+LdwFTqeQJ0YRIfQ1VNcf49jsZORmiyPBuzA1xG9OEW2fhYPn
   3A+jdC3Vq//vKGw5rqP0DTn5bfSAloBn/DTKlkUu1I1je8fzrNUK5UvoT
   g==;
X-CSE-ConnectionGUID: bV4dy9YwR8+irgsQSu4G4w==
X-CSE-MsgGUID: gclqIDSxSGu1IEH1M9xaeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232032"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232032"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: jyViF5rMRUemJ/6iBiwWLg==
X-CSE-MsgGUID: /HZ257ieR9iLblBOLGax8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315307"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:37 -0700
Subject: [PATCH iwl-net v2 04/15] ice: set in_use only after preparing Tx
 timestamp index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-4-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=w7tzbPfgL4SemDDc1M67jm5pchylDvuJvcpfrnE0kjw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6UiNuhsWha8+kBt2/qFOw7/bLj5fOX+PR1b+fjfv
 Pkttbi6u6OEhUGMi0FWTJFFwSFk5XXjCWFab5zlYOawMoEMYeDiFICJiMgxMuzjTL+z7dGuh73v
 PYSj+I79nWtRa/u4cK6Ay2zurhbdSysZvjvm1Lc+OlflsFHNzLnc6M4vtjn8C06uMhG5eOXZhum
 rmQE=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 2bb9beb94806..1bcc78d08d2f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -592,6 +592,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		bool drop_ts = !link_up;
 		struct sk_buff *skb;
 
+		/* Prevent speculative re-ordering of start and skb */
+		smp_rmb();
+
 		/* Drop packets which have waited for more than 2 seconds */
 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
 			drop_ts = true;
@@ -2677,11 +2680,13 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
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
2.56.0.rc0.395.gd1f3524e15dc

