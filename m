Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C648F83E
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698510; cv=none; b=GRdXrvMBDaemrz5aFzpNf2mLy4d3mc0p4fl9ncX5uLNKcmpsPku2Ejelny97lYCE/as7X4GaEGC1CP3w8ByAs3MaIkY3kyOgB9Pom6YR9qlTB1zSrXn5EA6b5l4TL6vk9npxr9oP9pRAOD2OixhypYw8BdCP3HRD/WaLR0XIagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698510; c=relaxed/simple;
	bh=IWVM4EjWcI7Wh7RPq3uvEJvVsi4+ccGsgc+lRY4c+mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/WaG2/mXvJtFBfqTRC3/8xDoxQ3BX7/NEC57/tveKLjmhj4urT5WGDkGnahDRoSx07JIZXyUQTl8bJ3LsguHVvy+O47imNsLtF6FNooD63OM9izoU/RqcbLo/WtPoZtSy4aLf7QeOV5IViqe3PgUgiHbfN1MjzCnHLbEatAOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG2ktmsd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG2ktmsd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698508; x=1819234508;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IWVM4EjWcI7Wh7RPq3uvEJvVsi4+ccGsgc+lRY4c+mE=;
  b=LG2ktmsdPvkCbreM/coS5beAygDdVYI05Sz+fDIehq7LzQoh7OIdkwa7
   sKvKfwV2ACdtrpyArO0dQLyHR60A6B3/UNtwvZQT6FptbqUnb3He1xXFO
   5JZnrbzozHTI/BMOcdxO6g8GP5Pw94a//ibs912HLwRsykiqLVX2t9U5V
   91r7laZrWKHKdXcG1GntkBDxuc7okVqX71X7JP6/xtIv5RmvgUXIJTl1m
   wcJ9dGdabPybjDICizQ3sEdaxAM6fPSTSZ7wp+T7jLp8ZMKhihy89i6E2
   V0ecMH9P/q3uMAoDNMaQ+Y+dnVXAm9xeoAQBsgUL28sNp205tSf8ILSOn
   Q==;
X-CSE-ConnectionGUID: B6ncAGmbQCKMlx4CFWfvAw==
X-CSE-MsgGUID: gbtgvOKiQ7aMVPEBGGyJHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120419"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120419"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:05 -0700
X-CSE-ConnectionGUID: C/leY4PGSWSuE94QXB3Yuw==
X-CSE-MsgGUID: CTWqHrIAQqm1gdJqnDipMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789668"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:27 -0700
Subject: [PATCH iwl-net v2 03/14] ice: set in_use only after preparing Tx
 timestamp index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-3-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=IWVM4EjWcI7Wh7RPq3uvEJvVsi4+ccGsgc+lRY4c+mE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+Wev/IpWvitSNjI/MaFexfqSZVPL+2/bJhbvS3J/f5
 WFZ0CDbUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwEQc3zAy/OY8UzDlTFniex59
 vjmPp775s/jjBqEM/r4JG6O3JHtwNTH8r53jw5TT1OR4zzovbGl8T5VEwu7pqny3I28HGx71TrB
 kAwA=
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
2.55.0.814.gc42f45431d0f

