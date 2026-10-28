Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145964;
	b=sRwHzamX50yHwAdommGYlFQ2cD3Ubjq6Hs4f0g7BbObiO9W5O7y23bZr7yUf/bK2CUSL
	 KgOiDWaYgRddWwZlh3Q5Uovih9zkzGLAR7OhDcVYMor1pfTRupA3HmWKV/JNkPcMBg6vd
	 hp1nOl4y9xSl8UyQY1J9P6prY1PQRwuWvz1yZPyC9KSKgCGi598KfNAEQO2Q+3Fqbj0N/
	 RLNKgZkrBic/ItDnlYRemGc9L1QAPXJKATJM6xzGijRpqCh+pHEPk09wpsxg3BKREjkWt
	 z2x8vEl0boEqX9CCC8hLBfL8aFdQ2FVBuorb343GXVz1m2pWjDoUoa6P7laK29pHhHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145964;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7jQHzbWrvHz2Nv1IzFC4deF5ZMvPhXvyXc2GOgIvoHc=;
	b=mb2nO5hOa30Vods0uueDur53zOnyb1FSRE/Tc3+w21otEyKJRFbhd/QF5LNuzIgAqxY3
	 rwAZnW5kH06IswvYd9i3EJDWJQvMrjMcrZ7pUHss8W+zo6eAIzJqwjsV9PdCCMq5Q75aJ
	 YUSKEbvNDD7EkOVsA2biG81vmCnZuVlpFQed/tV+6mFdo7vp/BJ8JuRXfbpfAGSfTxVVX
	 c3hTUGM8F5rf96slw5QO+230vr5NMc1xTiSpJCrzH7KOqsDo6eHQ/8kY5OPet2OSXzWee
	 f8g/49soa2wxZRV6OR5s0hBc6L/UQZzWKDR5xgbkTmmYndVtN6HndyI+lG6JABZyCcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O4BtAo88;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F0606A321
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 142F0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O4BtAo88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793145964; x=1824681964;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6xryLsaw93MP+m+iDKJzE2PqKIrqHNlYpTYEzoAmo48=;
  b=O4BtAo88K/EDViVfC6A6VDDxDt2A9drfeXOTaNLqVj9iCj7tg2SmJq6N
   KycWc1v2nLsVJ5Vamim/BursBnE14TuJUtXHW5BqErnEPqRLJ7xU5mTVf
   9DX6VrCqMrkP5kFF5OdSGJO10Ldesj8Q4x5277J9GlkQyYtclQ4zyVeEm
   cGj1pGRFcz9ErWUP1vEIRMMNeJ7FEFJl6t2GvuqSskBIeTyQwS2Evb8Nr
   W51ozJrahx7f/fxBGfoyoW3yWjKlM5jb0Y3jbJMgjBnoB3TxJYwjs3qjN
   tzlHpsc8lz59I/mUVIZWtxiWpEW8XaQ7PdWW384NQc7DqWF1opXSQ73Gi
   w==;
X-CSE-ConnectionGUID: W9uZ9IsgQvCa9oJpGyOBIw==
X-CSE-MsgGUID: pwmCGGWGRFyxSh1WU0Nk7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1747207"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1747207"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:06:02 -0700
X-CSE-ConnectionGUID: JQ87Qe8RTQ23sPNWnpdbCw==
X-CSE-MsgGUID: VfgKxFZ0SvamUwzWTXBYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4776650"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:06:01 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 27 Oct 2026 17:05:38 -0700
Subject: [PATCH net 2/6] ice: set in_use only after preparing Tx timestamp
 index
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
Message-Id: <20261027-reduction-v1-2-81237c67a361@intel.com>
References: <20261027-reduction-v1-0-81237c67a361@intel.com>
In-Reply-To: <20261027-reduction-v1-0-81237c67a361@intel.com>
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
 bh=6xryLsaw93MP+m+iDKJzE2PqKIrqHNlYpTYEzoAmo48=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyHNskFim1H3fmNYr9+FxM9MCN9hYIiRxSPU6QR75ao4
 0xfbN51lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMBHtKIZ/dt7zbf5KzUo4ad7n
 5rpHbOfGsNRpM/LOSelOSKnfO7nmJMN/p1+7599Z0HYhqNs222e1qqrnh7UBH5jm5Lscep6WVs3
 ECwA=
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
index e6442b956aa9..48fde5561668 100644
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
@@ -2673,11 +2679,13 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
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
2.56.0.215.g47fdf2208c5b

