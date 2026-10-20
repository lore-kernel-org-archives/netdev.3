Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489579;
	b=RLt0WWMfzk5TRGCEdPmDGE8yfHubhb2KuLqJpv9Kboyat/B0mCP03k2iTlE6q++Jy4SV
	 TqmybtDdU0AGAckXITlM3RISQ7PFY3G1nhWBU47ppLlPpLb4lqjv3N5e72lx6LuNfJhln
	 W6VleuEFw1GfrMtMdgDYoG4qaCO324eCIXdll6tUgN2mcOvxCzN/gsnfhw/rUF6SqSE22
	 MF69W24iO/qtpky6DaEDmPfkRz8+0ftDRPPHVCXG8pzjTvfbntBEQPbBlUBG7RQjqt1BA
	 SeVnMSJ0WS9crU+wwOLFdHtRHWr6y/QynTufrZ0cCmMpu8lbxv4mS69hJB0TRl4UuAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489579;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=sX1Q2gW/j3CRYdAcj8pkc2j0bb8JZF+UmyYr8waVAVo=;
	b=kVBoxcu8CVN88kDSj+VcNPhAo3xfx/y5kDfh2d7UEWLtGaMQPkVljNCYW8ZUzt46/5x+
	 Dwy4CLWM/9GqmKKcaxSWoQ6HsZtt5IQJtlOelnTRbIUksaaKhQ8YkkGOLLs5NlY1Irh8O
	 eZcg0ROMU1QGxjMnTFlcLhTU1cHJAEnIubzb1RfL7bh+iFL4icgMErZOE0yFi47hh/Jzn
	 4aSOU6mHZC0gtF719uOIrfaoGBdDoMcKiUd4RuhWJVGwsOYcyDKO/1qFatuzdeypypiRD
	 09SMdQBL/F9ZsI0A99LHkApVYX/3MvtzgVG8CMRcce4E088XMMOSfhmgfdmn1Px3RcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EL4ImaEH;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAB606A327
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EBAB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EL4ImaEH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489578; x=1824025578;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=uNafFL4sSCShhKbmP4aPVrpJQzFPp7OUizg2wWDQI3w=;
  b=EL4ImaEHHaX8GjO93XwzxeRelf7CvmDweB0yve7/0Wl2QKhmVIuHKuGq
   y+lHpLakQe4dvnJe7i0X6kA3AAbeADnIqUL1jJWDu1WeuEs7vTJjG95m7
   oAAm3TM/DyJ6tsauBsmw4653jJoCmVYN2GMlKZfyAncbynL84INCdkfGz
   596tBS/huKeUWXVWYJ7rAOwd1cuXtQyiVDybxTbi202NcnBXUGrnVReiO
   SSYdrh2pCW2Wp7HeNHUmZ6DV+PBwK6xdjyk4aVRDSN3tesRfUqNhOHFlv
   mhH1eP34sfFnl4kbAbc3VG2fkqSQmCWSUpsVEkrN/YeX5L5O+Hju9GDF2
   A==;
X-CSE-ConnectionGUID: DeLU4ErDTVG9toROwvRfHA==
X-CSE-MsgGUID: PjMzBE9ET36z1hOpTngjFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287888"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: GlHRxxupSrCGRrXWl+jUWA==
X-CSE-MsgGUID: Zsl6118wTh2zR7jqs2GQGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723898"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:35 -0700
Subject: [PATCH iwl-net v4 04/13] ice: set in_use only after preparing Tx
 timestamp index
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-4-3e30fc9adc73@intel.com>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=uNafFL4sSCShhKbmP4aPVrpJQzFPp7OUizg2wWDQI3w=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvF8r/dzXze2XiZTpPJ/T/DhmNw5n+aZJfgq+wcpl
 R6X35rUUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwEQermRkeD/N7DhzrYfSol7O
 ycdeuPAKmOokFhvNuhH37eQUFqk6GYb/SUvr9VR3Lpzluk7t7mRDjUu2u9ZzSL7dHmPc+Wd1Vko
 IEwA=
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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7a1deb3ea212..1e6ba6bbf6c2 100644
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
@@ -2670,11 +2676,13 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
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
2.56.0.212.g129ede20d986

