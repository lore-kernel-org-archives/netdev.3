Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616398;
	b=YJkr8j3LIJ5g4NUOWHRV/qHbHM/OHewv9stcm3ojPtiSh8CrGrxJ0DVjeYQaCDYMZz4I
	 L7ivU/sheysTwNzynuDGofZddInJRt0CKVJaxQm2saOxNF2eX+nCZfPNtQBPwtsdojMyT
	 KOgvbq4WMRYK0IKahH9qbCdTG6aAJXPAaSW4GC8LBo0GT046OCX3b+Q3RxecpOQx2ubQE
	 hUaTrJI9lGr9NoUHztdfR64gvQf2LggHucXQ4OGfcv7SRiKnzE6JVMOwVnC1KmCjJsUga
	 kaD6k/eWc7GQimEoXXokUe3jQoq3OnxGGU3g7kHOIJ3is6z8cIX1FseMQ7XOBCN6Gug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616398;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EpbIBsCL2Gelwm0gnFKEDFKVP67syfArtemZZbQZRac=;
	b=GgNjpmQ6S+EsHEtC9OprrX3rYPqSsAbGA6uuZ4ga1ZU+fUIpDPoop8HHhG/U1N1NdjmQ
	 Uuz2IKBFJbaD8iei/pHVY3h9iDMFaqpZbgxDD+WDjU/Os/1EgemaIFKyiNnDKsVGNwy6N
	 AT8iR8efN+QA4pDP9uIX1XzatrZmrjlbTS/FOvoyw5Xb/MItoTZCW0s814Eln1h5vNW0o
	 9iuM5SzgDCbJSH3NlQJxzzrlzFgcBKtgJUL6evuHc1BrD+tpCaI7nTXYGzExZpJEcUbPy
	 B9WU1K6slEQ90S2M++EXT1dE8zeG9gFT+Z5noM6w/SGLrwAenN7iWAJEE1l3XNfKEUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kx6oPeiK;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D36606A32E
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D36606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kx6oPeiK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616396; x=1825152396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZ31yo5800+JACi9OIQacH893m5RVhuD/0Qx7nxKPVY=;
  b=kx6oPeiKI4dlh2smo3T0AxYSUAOxmcDQYfnukkvJxtK03wtHWZUalOw6
   vMQR9+nI9lc5+o/FHMSDzcg+jpqNn35C/y+827WVthvRMwPSwSunwGCgT
   RfT7sv/GA3OHYjJ2iCBwCY9IIvzURgmkimlhdJNi8wcWgt82hxfx1cC3W
   Qd02fRKWXaCftT5d+3HuT62jXAVp7Qz5KOR+wUYYe385X64yvP0S75uJn
   0xLgfdvqXS6spb8KWZNo0Z0Yf6Hj9K++X5NcNayD02vhTymxOObcdkONm
   cvNSVCkrnjqqsxTbEvj9S0Me5bUsmdyg8xDRVtM+IszGat4xXuT98jo3S
   g==;
X-CSE-ConnectionGUID: CPt8BrMOTpOniB8I6V6/MA==
X-CSE-MsgGUID: 1SEi5l+rR/OX6tG6FkA9wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305029"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305029"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:46:31 -0800
X-CSE-ConnectionGUID: 90pEQXsLSIK9ChzcXryxbg==
X-CSE-MsgGUID: kmT0w3QZTj+bplELH8X9ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012005"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:30 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com [10.217.184.18])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4B1612876C;
	Mon,  2 Nov 2026 10:46:29 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 3/6] ice: clear stale rate_node pointers in ice_tear_down_devlink_rate_tree()
Date: Mon,  2 Nov 2026 11:50:18 +0100
Message-ID: <20261102105346.30739-4-przemyslaw.kitszel@intel.com>
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

ice_tear_down_devlink_rate_tree() frees the devlink rate nodes with
devl_rate_nodes_destroy(), but leaves ice_sched_node::rate_node pointing at
them. The pointers are only reset when the last representor goes away, in
ice_eswitch_detach().

If DCB is turned on and off again while representors exist, the next
ice_devlink_rate_init_tx_topology() (e.g. on adding an SF port) sees the
stale pointers as already exported nodes and passes one of them as the
parent to devl_rate_leaf_create(), which writes to freed memory.

Clear the pointers before destroying the nodes, as ice_eswitch_detach() does.

dcbnl ops can call ice_tear_down_devlink_rate_tree() while a reset is in
flight, or after a failed one, when the Tx scheduler tree is gone. Make
ice_devlink_rate_clear_tx_topology() skip the clearing then, as other Tx
scheduler helpers do when the port is not ready.

Reproducer:
  PF=eth3
  BDF=$(basename $(readlink /sys/class/net/$PF/device))
  ethtool --set-priv-flags $PF fw-lldp-agent off
  devlink dev eswitch set pci/$BDF mode switchdev
  echo 1 > /sys/class/net/$PF/device/sriov_numvfs
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:50 1:50 prio-tc all:0 4:1
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:100 prio-tc all:0
  devlink port add pci/$BDF flavour pcisf pfnum 0 sfnum 1

  BUG: KASAN: slab-use-after-free in devl_rate_leaf_create+0x109/0x390

Fixes: 86197ad5800b ("ice: set Tx topology every time new repr is added")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 8c2b63eef82b..044aa62be473 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -705,6 +705,7 @@ void ice_tear_down_devlink_rate_tree(struct ice_pf *pf)
 	}
 	mutex_unlock(&pf->vfs.table_lock);
 
+	ice_devlink_rate_clear_tx_topology(ice_get_main_vsi(pf));
 	devl_rate_nodes_destroy(devlink);
 	devl_unlock(devlink);
 }
@@ -842,6 +843,10 @@ void ice_devlink_rate_clear_tx_topology(struct ice_vsi *vsi)
 {
 	struct ice_port_info *pi = vsi->port_info;
 
+	/* the Tx scheduler tree is gone during a reset */
+	if (pi->port_state != ICE_SCHED_PORT_STATE_READY)
+		return;
+
 	mutex_lock(&pi->sched_lock);
 	ice_clear_rate_nodes(pi->root->children[0]);
 	mutex_unlock(&pi->sched_lock);
-- 
2.54.0

