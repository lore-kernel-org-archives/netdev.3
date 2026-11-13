Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611556;
	b=uktQuYKHHv2CRXl5ZCisbRPiJKxfuaBxxceq65cOXZHUkuBVgkxI/xe+RK28nLMM6a4q
	 gaMY3UeUWjk54dRI9H4xlzS4v1W57aePkIrLBVlKfNxnYXEmbBOTACcgvOdTkDhsODtb/
	 4WrZQBe7oPHgMyYWoO7q/EnyQ+c/gkc+bql1zRer3epZtKfWgRLmjPwssgIWQA/lNw+5N
	 HnQR34So7P2QqZJ5qi/2pPBpygRFsgYBJLPUModjJSpnNGPD89Z5h+cGtyDsXwJXcMV3B
	 8K5h931zgW+mKF9QRpN3JD/qGuy3xaoC8SBUIOS6+wMwS6O/Lbgso47xsy1/E7z9xEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611556;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Icu6BkCvgz/0bOJBK1yHPYyC67KMDfpy4tnUPsOBvjk=;
	b=ESg4MpIavyQl9qIicnN/NBXx1Ztifc/vwLTKBxuLX4yWnupwAXUfTk00XJVIK++cf/XU
	 aSiKXEfM6TOtOCFHdBDoRCd8x6jSR36Fs7H1mw8aMUZyESXigcwPpNn9r2dW7V3Yr3MuA
	 ZbbFGAfOv2WO98kP2Vl73agetdYBvaUYZadag+Z10++OMPxeMXOTxzmoKO+WhEhwJEAx0
	 rlCppZ4q21NGD0TUaPufyd5z7bHIobOvXj04RiHoQO7Hmtbq07Tj/vTl2K7BNnIrGMgak
	 LnAScQow2HJBUArfWIpC6mhQtVo288DH919JsM7YAnn+XApIg27SrX8DrZ1IztdUZWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ajbbhML6;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B63606A33B
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B63606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ajbbhML6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794611556; x=1826147556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nP8R+gBXZvOTJ4VXEvas7YmgcJzpx5/8oP/YbgvTLGQ=;
  b=ajbbhML6l3fz/XHCjBEMLMxouYBA8L3FhpfaAwOaYDVZZIVxMvJku98z
   VSvtE8IsnGuSPs3qEUdhaY0MTsRGaQJqip9gRLX2QUyJPXpPr79ZiymTb
   Ic7hOtiFDpmrZYzPRMHUwAdFnhwKxp0zzPlrcJAoIDkjQDawE7FuxrEbi
   lYj5UU+xUF+6LcgtDgXFcEbBwUz52WinXeUh902NtzD5oPQ1ScJEfXD3a
   B/w4OkcwW5yZ8BEpj+EwcsWRN97pALwlczsuR0V7Xb6QStden1JeNXXlX
   sKEWwW5hPI/ebhdeiTf9kblnh7lxQSjtlxfW9+pwKUHLhZV5FWkblELpj
   A==;
X-CSE-ConnectionGUID: 0WZZW6+/REWJVZbYESD+Hg==
X-CSE-MsgGUID: ht26TYpeT1yTCy/GFq+WFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3443151"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3443151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:12:34 -0800
X-CSE-ConnectionGUID: /QV8rzqcRjestNNvb5xQnQ==
X-CSE-MsgGUID: x7yvE4kFT4mt6BpuDa2uKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9360985"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2026 15:12:33 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	david.m.ertman@intel.com,
	pengpeng@iscas.ac.cn,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	ivecera@redhat.com,
	jacob.e.keller@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH net 3/6] ice: preserve uplink DFLT Rx rule on switchdev release
Date: Fri, 13 Nov 2026 15:12:20 -0800
Message-ID: <20261113231225.1864810-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
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

From: Petr Oros <poros@redhat.com>

When the uplink PF is promiscuous, ice_vsi_sync_fltr() installs an
ICE_SW_LKUP_DFLT catch-all Rx rule on the uplink VSI. Entering switchdev
re-affirms it through the idempotent ice_set_dflt_vsi(), but
ice_eswitch_release_env() removed both the Rx and Tx DFLT rules
unconditionally on teardown. That clobbered a promisc-owned Rx rule: it
disappeared while IFF_PROMISC was still set and the sync path was not
retriggered, leaving the uplink without the catch-all the netdev
requested.

Skip the Rx DFLT removal when the uplink is promiscuous, both in
ice_eswitch_release_env() and the err_def_tx unwind of
ice_eswitch_setup_env(); the Tx leg, owned by switchdev, is still removed.
Test the live netdev->flags, the same value ena_rx_filtering() ->
ice_cfg_vlan_pruning() above already keys on, so the preserved rule and
the pruning state stay consistent, including for a promisc change made
while switchdev ran (which never reached the gated filter sync).

Fixes: 5c07be96d8b3 ("ice: Avoid setting default Rx VSI twice in switchdev setup")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 6e7bba473898..c32d6b201369 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -66,8 +66,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
 err_def_tx:
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+	/* keep the Rx DFLT rule if the uplink is promiscuous (see release_env) */
+	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
 err_def_rx:
 	ice_vsi_del_vlan_zero(uplink_vsi);
 err_vlan_zero:
@@ -276,8 +278,16 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+
+	/* Keep the Rx DFLT rule if the uplink is promiscuous; it must outlive
+	 * the session. Test the live netdev->flags, the same value
+	 * ena_rx_filtering() -> ice_cfg_vlan_pruning() above keys its decision
+	 * on, so the preserved DFLT rule and the pruning state stay consistent.
+	 */
+	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
+
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
-- 
2.47.1

