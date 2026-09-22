Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F74848BA
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100520; cv=none; b=s2qsvd6l4jY4dN8tw59+E1a7UN/JqVbq4dswmR74yiDhcSD1IgvnL7Qj+X17ACXIId7gsN9eDmZysaCSEzrmeXzLoyKRKY44KFm3PnIAkmgHRcPAanKifc+1Fo6dlhEmNo2eDkYZBUrtRP8UCpBjQB5UEy1vQ0Uebi6F0g/DsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100520; c=relaxed/simple;
	bh=NoObGFVJCFbWGwgcX+lDandtZXkhcJq+tpybIb8MefM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUawtwMmeeojAO2qAcoi19WB1da7moHvVOdpfyblxzs+Cl3BZ4uZ1erWeMofuly1TtdAtcX+m2DPCciyGiMLAn0tO+Q8GOObZaP57YLbDjhwrIvfTB3veh8ThiHlgT3Chfa3ZPFb/OXwuPwvaZKzZNwUuZ1nKt02eqp2dejdnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8dQ+EiB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8dQ+EiB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100518; x=1821636518;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NoObGFVJCFbWGwgcX+lDandtZXkhcJq+tpybIb8MefM=;
  b=A8dQ+EiBIO+o6GjYa0qv87sfysTm7BAoWLvwaTqRDGPJsmlmgPoAtUvd
   8NCdODypuAnalZUrOwvA3LIvj8OaMwhKBNjGdVN5OpmL52W4U7XNe1SeJ
   otEqAZf+7EwR/JZ9IAJNNUSno2lbDJyVZ/+w4zYOHhr3c3nqUgCwUN7Bq
   hJiQT88/pBNk8/Kt1Re/9WbHbflFt4tdzig5vzdgrhbt2ol52vhzVnudI
   Z13yaOe4716O29yop8TnJmLRP+qDGJ9g9NiSmMOaI4VmWfM444ZHhKkrq
   JrJ0J3n2ENemXXzdZGlh1HE61WQvhDvbcYc3j9PELq/P99TvT9F9AykKY
   A==;
X-CSE-ConnectionGUID: 1sJXY+9WRuW6/+XbJLNllQ==
X-CSE-MsgGUID: O1OfrgFDSeyld9Fm0Sy2mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232058"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232058"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: Hb3pwMZDQJi8+PWKmsve/A==
X-CSE-MsgGUID: n9BgxPM5RfKJT0uaWY0v4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315344"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:46 -0700
Subject: [PATCH iwl-net v2 13/15] ice: skip reading Tx ready bitmap on
 ports with no timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-13-e55b692d0e6b@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=NoObGFVJCFbWGwgcX+lDandtZXkhcJq+tpybIb8MefM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2U5MyZonpr1LlJ7ecwqjr0Oqxh5lxlcaVXc7TiDf
 9NO/uTKjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZy8xfDP/VP/by8jgVN+ypa
 /X67POiaXuLc0ujdeE8kdJd75i73SEaGzctq9H6ffBPZGae3eIb032lyr0JUAx73JnG4XSlU4u3
 iAAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

On E82x devices, the interrupt for Tx timestamps are handled by the clock
owner. When an interrupt with the Tx timestamp cause is fired, the clock
owner PF iterates the list of ports and checks for timestamps across all
ports.

The existing logic reads the PHY timestamp ready bitmap before iterating
the list of in-use timestamp indexes, even for ports which have no
timestamps waiting in the software timestamp tracker. This has a
significant and measurable latency impact on reporting Tx timestamps.

Check the bitmap and exit early in the event that there are no timestamps
waiting on a port. Observant reviewers may notice that the check is done
without acquiring the lock. This is fine, as the only thread that can clear
in_use bits is the miscellaneous interrupt handler. Whether the thread sees
or fails to see a new outstanding timestamp does not affect correctness,
only determining whether or not it should do extra work.

The average latency of a Tx timestamp is impacted by several factors
including system load, the number of timestamp requests, and some random
factors that are difficult to control. However for comparison on my system
with these changes, while operating ptp4l on a single port with a sync rate
of 16/second:

  Before: mean 317.43 microseconds, standard deviation 34.51
  After: mean 189.71 microseconds, standard deviation 43.24

Of course this level of improvement may not be indicative of a production
setup as one might expect timestamps to be operating out of multiple ports
on the device. However, even in that case an improvement is still likely
depending on the actual timestamp rates.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 06f383415d07..890c2e8d4ece 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -574,7 +574,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */

-- 
2.56.0.rc0.395.gd1f3524e15dc

