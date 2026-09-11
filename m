Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B05310645
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086895; cv=none; b=VW7R1f/GIKEEzgjHz/TavDp5eJyzd+2QPGPh70UVDAqIxcbzs0GfWzWvqh4qFFn9MUhG9kzMvH4ASsG2f879HGBieGphbNlV6DwjqiLv5EZv+YN21K1O4G+owLIHnkmz1TXDU4k4EZJSz/zx6u4PSasrvXf41acN26IKY7WSJo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086895; c=relaxed/simple;
	bh=YmfkkYk6iUwJPbT5b0nPM9Ml8zeexUvHBDo25/GRerg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPYmCZU9Z17R9NJ87ZPAvPm6VSXZj1lqa0LuGVxahNou7LPKHrB4VfBlPfBwHJRjF6QijsTtlFBaIgVJBegQ7QPK8B5GAdWWIIO4Dq8fJ88itW/fE7/bxWz7fA7rjrg4cjlAQB+kulo9XF+Nbl8PUNcGGNQHr/s4AjE2tYGlpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNeffPpm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNeffPpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789086893; x=1820622893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YmfkkYk6iUwJPbT5b0nPM9Ml8zeexUvHBDo25/GRerg=;
  b=NNeffPpmcBd0DyYNep30ZQpDDpoLjRohxzPyIRb0dvBRUae6Yf7p2wTv
   iKR32AYqxSliTOyPJP/dc22+t4gu/9xeIhxJAqPdehgCfnvPiXBHivGqK
   w/+qheiv+gGivdoqE09tX1JThNmq954pQ/PlWf2ZehtZ+2ADtaeHD/vGs
   TEjtSu610ekVTLuwSs++R90v4jSdd5T3V9z/SqGFnejOvd4/UuhPbG7iD
   ALxMFWw31P/0YY4S5jCoCARa5L95lyzkbb8lj0aDObBHz0gDPj59tCd+G
   zozNsKlssA0oc9/bmgSZMNvfnVcTSCHcnZv3C7ayLatAvRon4dBvGjb5s
   w==;
X-CSE-ConnectionGUID: FDLl2wF1RGC+wYX6cswNaQ==
X-CSE-MsgGUID: lDRYACzwRRec9p7bo3AUFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89564753"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89564753"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:34:45 -0700
X-CSE-ConnectionGUID: vi4jtiBJSEW15AygqmcEDw==
X-CSE-MsgGUID: 03CiftO8R+KDBfWFsLfUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272291095"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2026 17:34:45 -0700
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
Subject: [PATCH net 13/15] ice: skip reading Tx ready bitmap on ports with no timestamps
Date: Thu, 10 Sep 2026 17:34:22 -0700
Message-ID: <20260911003430.3386340-14-anthony.l.nguyen@intel.com>
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

Using the ice Tx timestamp traces, with a simple ptp4l setup the average
latency appears to be around 175 to 200 microseconds with a few outliers
taking hundreds of microseconds to be reported. With the check to skip
empty bitmaps (and thus skip reading the ready bitmap for inactive ports),
the average latency drops ~50 microseconds.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 277d9c77af1c..e060de502662 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -573,7 +573,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */
-- 
2.47.1

