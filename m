Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620804;
	b=33gxC05jBArstqNP9tRAM2e4K6smY+gsB9zn6oUKdBmOGpsT8HeI5KZ1wLUiGIw2bNoJ
	 VMl/t+Uii31mBEAvi/yJY5M6fteSUUSJntK7OQ+/TYDVr6ALheVry1a8H/XQdTh7JK87D
	 cjbN7xafE4pqPW1swk6GWoe482Is/crU6qrabtW9Gn+SVHpP8YZ1XfzRV3VS0ruiOOMBP
	 tsWzr4fkXP9V3sjDIGI0cgJ9CHqYYLwYXV0Okb5p5PuGT60JKXG8fmumukzz1Op0OAGtt
	 /9pYcoc4N2k82EAALSFqjFMjvQhR2xr1Y6ygcO6l+TQJJpgHi5sqlahiXgzOkkoBgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620804;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=sX1Q2gW/j3CRYdAcj8pkc2j0bb8JZF+UmyYr8waVAVo=;
	b=TWX3cwxFDtRYBpVhDpfdJlPByjpdgZ6Zx6RQkGBqokj9qSH6QpHO69qtn1uC0I1bd4iI
	 Z1GfChd8vrbzkRD1PpUU3CGUO8fRYhlKfslMUcRhZ2+unfMuOuEd+R8WMnna1J+/mj4eq
	 FWrY+2hY7WSewRI8ourMCukUeV1mXjp9zIHFXKfs6fNygu1TjYNQm2u4DztUToJ7jIspF
	 HlVGpgD+18qtsEwHSonVYb2iSjgzBTIN6s7M7fQKtws+8ODwnxiN5HfCkpP90cOBcQLK8
	 zPrCHlTFAXrwzkB2wrv2nfpbrwwryxzpFIiybQJTgzHRzdg2fFTiRtpc82aGde0PZsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QdIrmbiC;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B6606A327
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618B6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QdIrmbiC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792620804; x=1824156804;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=uNafFL4sSCShhKbmP4aPVrpJQzFPp7OUizg2wWDQI3w=;
  b=QdIrmbiCjVu0yBUyWCFPOC5hPze3r7uMN8x9vR+nPdpL+KTxoIP10wxn
   jpLrSP57hGHVQfX+5BOuBCgaxe+Skv3Aqp91e8fiKHXyIUv6V+j5+7hC6
   8TsYEu/r4xXkyXaKuy1kFDH4iC4MfJHD3Xq5x1LCI9bEel252j6D/PER6
   wJVtDasDxgPqKXryFU5v/QrhDxs2+UO9D8YTZTFSXxfmRGtkYJD1pZ5MA
   CvZ8UBVDMwqX2Gw22iCpQRpytaj369ijBxI2+JImiDbH9G3r5cQ7PyFGe
   5R44KXCGiONzOGfjH6bNTvt0nYVwZGMESHRsXU0GcHa0i89Ye2W/uBtaD
   A==;
X-CSE-ConnectionGUID: efRhM4Q0RveAaMZBrp7ZDg==
X-CSE-MsgGUID: AIrYwBSXT4yJ3gBbEFRFxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1363181"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1363181"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:11 -0700
X-CSE-ConnectionGUID: jlHTXGD9T8G8+9hQrFGkOA==
X-CSE-MsgGUID: tBKErq9jRqSZoXfuSdYiTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3275467"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:10 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 21 Oct 2026 15:12:49 -0700
Subject: [PATCH net v5 04/13] ice: set in_use only after preparing Tx
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
Message-Id: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-4-72289a4ac8eb@intel.com>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
In-Reply-To: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
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
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqybFu+lbb+f3RK2e0bDzLMvdxY5T8hf86fv9brNf5coR
 c/YqvRnS0cpC4MYF4OsmCKLgkPIyuvGE8K03jjLwcxhZQIZwsDFKQAT+VPA8If/V++8Aw5Lz0w7
 GqvVu/FDT+nO7X3mj0PDZ5evqXM4f+osw//kyh519sO6HZdKlmXXFO6a7vTNOM93UmSl853lT9e
 t9+EBAA==
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

