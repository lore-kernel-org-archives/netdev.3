Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E42D3EF2
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086888; cv=none; b=I6Gd+zsHGjFcd5rJTlCW6dlK2+wIVPGzDHqeeQ2tcFQ6JyMvm9MtMxmjgSzeSrtYSStnu0YxY4SPljwPFAHXe1XG7yhAWPNXnzH1s2R0fpo5d3GmsSRh93nQ589cizUWlnA7WAlViA/hJWEUh32q2z9/mxNH8R0p/jLmJZMth/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086888; c=relaxed/simple;
	bh=IoQxTHwnCmYuqR4nDC4JTkHm534srTPZHdDkxvgSYdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU5aZ2WpArkm2tSXp/4DSQno0ky5H84bcoN3jXMlG/g5U8uW89ZGol9DGdGjMKMN72XfZqWQ+TOhlujhLfPDPI6PaPCM18K0GT5YhNaiEPZR7aMsDS0Kyup/7jO6XgwuaVu8kCNRlGBSt7HfFfcGQKpqAnPwu+5Fw0uD9o1hBCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYxhLh1X; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYxhLh1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789086887; x=1820622887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IoQxTHwnCmYuqR4nDC4JTkHm534srTPZHdDkxvgSYdg=;
  b=DYxhLh1XpcmWmGLgmDSANlZOo+H9+WGhaEU2vXNKVg41dFUXldXECQM8
   FZqjenR36E9jjFzS42BW5ulRmHGOMihsKGszAroF48czKhSIXdoZ/z9HS
   +DzaaUecLigfdSx/idgXLO+QwctVU33KdUF7QESS9C97fPTHcFNTRDL0+
   QRRs1+fQbB8Np6tr8sFCh3gvVw8GqKkHBx2H0C4KrHxz4+rotpG0HHVRf
   wCMUBouaFfAgIf+vGXbLyB1MrtqaSH8rN6shgSbJtwWuoSgPd3aEXNTz/
   BC7+6GTGcT3P4MmDTyMHFqapWZaHRP0VPOwJaOnzp+qgf2jHcH+MJuK4h
   Q==;
X-CSE-ConnectionGUID: i4nKRCCmRhOcsr5ci5ae+Q==
X-CSE-MsgGUID: lLnsp2bQReWaNFStp+0huA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89564683"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89564683"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:34:43 -0700
X-CSE-ConnectionGUID: 1eUdnMUDTiubOgZQ0Imo1w==
X-CSE-MsgGUID: 5/zxar+iQbOURAY3NnjHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272291048"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2026 17:34:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
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
	horms@kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 03/15] ice: set in_use only after preparing Tx timestamp index
Date: Thu, 10 Sep 2026 17:34:12 -0700
Message-ID: <20260911003430.3386340-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
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
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 142d39ee5cc5..68537705e839 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2672,11 +2672,13 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
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

