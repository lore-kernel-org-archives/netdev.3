Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CA49BD74
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342830; cv=none; b=CzKX2sVTmazeOD7EmPf4T+54VqFJdlPs18Vb+6QSVxb13/n1wZMVQbbv0tPumizMbamU1ihY4txtdVcuVuqwc00Gmr8T/ETzZ9EHpWp33YiXGGe6f3BIiUBASqBZxu+ScCVbkJuOLhmgx7xHESb5lxa0N03cqtNFJlsJOD+E5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342830; c=relaxed/simple;
	bh=6yPigfA5k4VyxOof2B+E+5f+0Y2tBW6P2rB/PQGm3gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvPlMiz/qyjDzMcg8dWdkKrWJAL3WgSnkeu9lwKz92LmsJwT0CkgjxK2FVfuix8zwKOOfO7mPIRQSs7kqsMD4qU8B4jNAnC7tEQ1zODGUeSBAnnW+vzSs/2vcLAoQIeo/wV6BomPEG7Vp/57H7RQTJ9eGPj1NnOingRrgQX5bfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buZdV95R; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buZdV95R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790342823; x=1821878823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yPigfA5k4VyxOof2B+E+5f+0Y2tBW6P2rB/PQGm3gE=;
  b=buZdV95RDnQSGodbpty2GPTVkef9lS1/6E8IIFUOT8Ahi3MLLfEyZnwj
   JChk7SOULD+9h3oxFRwwXgPGcWnAsgNwLYQt+bNFrOjdSBSLJcEGJu9A0
   Uu74DtDjjxa4KPd+jQ4WrUrPagcqy77d+BoKz3tgn5T1yXPhl29maW+Ck
   C62n2B9+bUyOp9FeClZKNe25t/Pc0ThO3FziUONVZOHThsWkyEWIU7Rhw
   uIjG+D35S/8odqifF1TmIDdb+XI01zDkdwWa+FfVHsmFoVZK6QQGQgQwr
   ACjZPGR9cTWhlh3hH6smoMTpkzPonH0rRyF/hhW7gbxIz4uIBrDbg7MRM
   Q==;
X-CSE-ConnectionGUID: nlEWFu0NTXKP4X6A8GLr1A==
X-CSE-MsgGUID: 3qnfJozZTKWxJoWM+0rf+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508249"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="107508249"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:26:57 -0700
X-CSE-ConnectionGUID: RDbae7hlR9Ga1lelLy+vVw==
X-CSE-MsgGUID: vhIzYfsZT5+UaAirkRc/fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="282414673"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:53 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1EE362FC54;
	Fri, 25 Sep 2026 14:26:52 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs on rebuild
Date: Fri, 25 Sep 2026 15:15:43 +0200
Message-ID: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_vsi_alloc_stat_arrays() returns early for ICE_VSI_CHNL, so a channel
VSI never gets an entry in pf->vsi_stats[]. ice_vsi_realloc_stat_arrays()
dereferences that entry unconditionally, and ice_vsi_rebuild() calls it
before anything else, so the NULL is not filtered out anywhere.

The path is live. ice_prepare_for_reset() removes the queue channels only
for resets other than a PFR, so a PFR leaves the channel VSIs in place,
and ice_rebuild() then calls ice_rebuild_channels(), which rebuilds every
ICE_VSI_CHNL VSI it finds. A PF reset with ADQ (mqprio hardware offload)
configured thus dereferences NULL.

That combination is reset recovery on top of an active mqprio offload,
which is why it went unnoticed. It was found while refactoring this code,
not reported by a user.

I'm leaning towards removing our limited (compared to OOT ADQ) support,
but it's outside of this series. Bug could be triggered by:

  tc qdisc del dev "$IF" root 2>/dev/null || true
  tc qdisc add dev "$IF" root mqprio num_tc 2 \
    map 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 \
    queues 2@0 2@2 hw 1 mode channel
  sleep 3
  ethtool --reset "$IF" irq dma filter offload

Workqueue: ice ice_service_task [ice]
RIP: 0010:ice_vsi_rebuild+0x289/0x380 [ice]
 ice_rebuild_channels+0xd6/0x320 [ice]
 ice_rebuild+0x4f6/0x540 [ice]
 ice_do_reset+0x9f/0x1a0 [ice]
 ice_service_task+0x4a/0x460 [ice]

Fixes: 5995ef88e3a8 ("ice: realloc VSI stats arrays")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5: new patch, split out of "ice: rebuild ring stats arrays instead of
    reallocating them in place" (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db376d3d..31af378aa0e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3031,6 +3031,10 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 	u16 prev_rxq = vsi->alloc_rxq;
 	int i;
 
+	/* channel VSIs have no entry in pf->vsi_stats[] */
+	if (vsi->type == ICE_VSI_CHNL)
+		return 0;
+
 	vsi_stat = pf->vsi_stats[vsi->idx];
 
 	if (req_txq < prev_txq) {
-- 
2.51.1

