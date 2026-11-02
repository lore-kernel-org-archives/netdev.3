Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616411;
	b=hoOoh1ikIejFFzpfDK6XBhy1mKT7wIkzlo7Q1/p/iBThv1is5VyODqW+cDqqsS6gWE90
	 uwWKj9Hd5164dhqrEaMeGFzb4P9hTatA/bDvXwXZHwNgEy2tfPvU54JpBBtxRVExqOoD+
	 f3Ig6SgMBSPnKi76zhI5/dAiYy7BWcHnOYYKJUA6JlE3PAFX2OOwMM1c5yMlV+h2A2Oix
	 tNG5acuolMTJO1PNPb8ouMfZc+1dK34pZxn8zscZStcK5SB5TdLy3NvaxnuD+53yAh5qA
	 gwFLhpB0p3e+eNdvkRvvH/u0s35qgp/tTS5kAknpuQSSD+Yu8evcR9RrMkNOE5Ty1kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616411;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1e/18QTzPWjcuzj9EXaVFILikpuomb1TPJ/A+uDZ7q0=;
	b=BBidftfMqUbHza8mWk2WWgGpChkBt/qPxuwzTRHhZWztgpbmzqxdwsNQGnnrUEXRr0TE
	 q6ga2Te/hY7XL6R/fG+Ucg4GaqVoWwwn7hSpKNSnrip9DjLYYbmjFGsfnU7sNhlNMdqzM
	 wPb7gSVOMbP6AwudnNpQ80eKOWz63MNx2eqX9SI12OFmUB3sZqe2ONGqxmPptEXYnZF+d
	 aYl2JAPfPbUNy5aR0+bjMeA5hqX01leGddhLp77TfiumnHeS+l4u9tDxiZ1YzBjjFs3BV
	 cz4giXHFGAqXbdH8TaD4oBsKakkhEykxKsfL1VBtq28Etu1vsDPU3HoQ7txrhv8qaQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GPsPFoZp;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9CA606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D9CA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GPsPFoZp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616409; x=1825152409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJmfcS2b/F3JUroioHdfd/TNb7xOb9fGQy7xtYYDNuU=;
  b=GPsPFoZpzn/83qQCXIhwnJ+OCSaImQ7loIX1hQS4PwqrEsi+/Idup44Z
   wFvXaov5MqMoeoXnqY04WXCdSDp7gNdfX83tOQ/kxEUrEYfyRkdrcwZGu
   iK5pSd3XnsSYgWRLp1FhSJlJUGvQxZHYp0U2XLj9aiqRmoI14ysh55t7m
   GOcYromQnT3TONpSJTVRt5uErF2XXIGiJvcMvPMo8rjdzrhtkPBtj335J
   MGWkmrPjA4ceFPteQhqZs8kKXjzernNNKenryFi386WoKBVaHGTbkCNDW
   Mu5L4BuRxa2prBls4eLGx82cfl97vivILV2/FVCIicTkPMKZj1LGaONNB
   Q==;
X-CSE-ConnectionGUID: gPNtiUCfSGyZU2GSLZo2bA==
X-CSE-MsgGUID: NQMPyvPLQfWhSdnU7G+fDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305038"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305038"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:46:33 -0800
X-CSE-ConnectionGUID: 1nby3DNKRfmRVgkusntSkg==
X-CSE-MsgGUID: nsbrz+3cSAGPF2T6q+f36w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012015"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:32 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com [10.217.184.18])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A1BA32876F;
	Mon,  2 Nov 2026 10:46:30 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH iwl-net 6/6] ice: register LAG event handler last in ice_init_lag()
Date: Mon,  2 Nov 2026 11:50:21 +0100
Message-ID: <20261102105346.30739-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_init_lag() registers the netdevice notifier before it creates the LAG
recipes, but when creating any of them fails, the error path frees the lag
struct without unregistering the notifier. A failure of ice_init_lag() is
not fatal to probe, and pf->lag is set to NULL, so ice_deinit_lag() won't
unregister it later either. The next netdev event then makes
ice_lag_event_handler() use the freed lag struct.

Register the notifier last, after the recipes are created and associated
with the profiles, so the error paths have no handler, nor queued work for
it, that could use the lag struct or its recipes. Free the recipes if the
registration itself fails.

Fixes: ec5a6c5f79ed ("ice: process events created by lag netdev event handler")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-e0559bca-fcfd-4435-96f2-15f7e3d74184
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 08a17ded0ad5..c4b8af01e2af 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2601,12 +2601,6 @@ int ice_init_lag(struct ice_pf *pf)
 	lag->notif_block.notifier_call = NULL;
 	memset(lag->sec_vf, 0, sizeof(lag->sec_vf));
 
-	err = ice_register_lag_handler(lag);
-	if (err) {
-		dev_warn(dev, "INIT LAG: Failed to register event handler\n");
-		goto lag_error;
-	}
-
 	err = ice_create_lag_recipe(&pf->hw, &lag->pf_recipe,
 				    ice_dflt_vsi_rcp, 1);
 	if (err)
@@ -2638,11 +2632,20 @@ int ice_init_lag(struct ice_pf *pf)
 		}
 	}
 
+	err = ice_register_lag_handler(lag);
+	if (err) {
+		dev_warn(dev, "INIT LAG: Failed to register event handler\n");
+		goto free_act_act_res;
+	}
+
 	ice_display_lag_info(lag);
 
 	dev_dbg(dev, "INIT LAG complete\n");
 	return 0;
 
+free_act_act_res:
+	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
+			&lag->act_act_recipe);
 free_lport_res:
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&lag->lport_recipe);
-- 
2.54.0

