Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616412;
	b=f+J1qrVo2rIMw5KRcWADU79NqAJG3ohCpzJAd4rzRWZxJe1UK+/L0Yp4i12Us/2lOo29
	 23TrB1lJehfmOoD6ZqKOq/ZduoeJNsLCgPXinf4WYPuprXys19cmVFDlDoZdGXYC0FoQ6
	 129uv0E4JvWiWsj+lFiGRYXoP07ub2CGCXHFPkzvJN7PpnsoaSQz6e61Ni1td2DsNDIvS
	 38Ohq6FrkkY+W7Ak859WsorvL8BGc13YG4I1yy/+yedeS41lf4oRYENKVsMHty11WZI5j
	 y9MG8Iq0MNcpFipUIN7Bpede62Lm0EiGTZ9XZ5IppB+nUPPO0MpVZex/5yKE/sEfjiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616412;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SVoFGUf6GXv+tO9V/ODg9yI1Wy2A/J/Aiuj0hfR9kCU=;
	b=nQSbNR+A58cWa20fAc+iERCFNUQnJXZ1RDxsio834zvrxiy+Ex7mWlv/UWiGgiUOBrWG
	 LI1le0N0byiJWu35tBlaXLtcn0MHVZ6eHloYYFsfR1OHbfSBvLi4e3Kz14bAdG9VOFeLC
	 iDQURgcYX8fSVZ3FPS2kp5AoRk572Fxcc5CpL0v8/VGSNN5HDxuSZ6956umPj7C5PgnpP
	 ncoGVnhU8ee3DXtbr+pmAPLq8ZTjupVK9++thREk0ZVeel+dXwYOlQmVqG5tcKPJ8WKug
	 BvvqNTe0YgmftZyRlCPz4b+7vCt4xliY8OmxsRb995ukZ6zZK+QqZrpBgI+wr62cm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i4jnPdIf;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617B606A330
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B617B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i4jnPdIf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616410; x=1825152410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pdw8KmbRx9IBcuVpZ651l8R1Lkf6/VlhieZIT5z+Drw=;
  b=i4jnPdIfrffWpfNKVyUC5SNJiW2rxhK12o9zEYGE2cakwoaQgkmVH5hn
   zZmNX/5aK1jab5PAdt+88Ad7lDv5i40K7XRqHev1Zm8YcI/YTUmNN0Q+s
   gR9iDL/bGbXQh1HXG/R4r0eNj4RGvXdlLCsyS7s7pKrLSI8yzIECnhv/J
   cBlIS5km3XfX41TgM9Or2Szo/7VBuKD9G4voTBnXcdkPfKdhsibnvCjSS
   Rpq9eu+q7tpBa0FcpSr1WOmINYHagY5oU4k20yzRZHTi6WtrPQ28vXTiB
   BciQwTMQAsBtlBWNPQP90pu8CywCmTiK/ZDYNViz+xksbZfw+Cla7pk1J
   Q==;
X-CSE-ConnectionGUID: lxrVk6KyTsm9pm4R4ujBmA==
X-CSE-MsgGUID: OYfygxDMTAyitfUWF4NRbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305043"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305043"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:46:33 -0800
X-CSE-ConnectionGUID: faVRmSJ5Q7m2XBOK8eA+6g==
X-CSE-MsgGUID: Xh+9+gbTRo+7Qifs5/o1cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012017"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:32 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com [10.217.184.18])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 332422876E;
	Mon,  2 Nov 2026 10:46:30 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 5/6] ice: replace tc_mutex with RTNL
Date: Mon,  2 Nov 2026 11:50:20 +0100
Message-ID: <20261102105346.30739-6-przemyslaw.kitszel@intel.com>
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

ice_setup_tc() takes pf->adev_mutex and the RDMA aux device lock, and then
pf->tc_mutex, for mqprio. dcbnl ops take pf->tc_mutex, and then
pf->adev_mutex in ice_send_event_to_aux(), when ice_pf_dcb_cfg() notifies
the RDMA driver about a TC change. Lockdep reports a possible deadlock:

        CPU0                    CPU1
        ----                    ----
   lock(&pf->adev_mutex);
                                lock(&pf->tc_mutex);
                                lock(&pf->adev_mutex);
   lock(&pf->tc_mutex);

All users of pf->tc_mutex (dcbnl ops, ndo_setup_tc() for mqprio,
ice_dcb_rebuild() and the LLDP MIB change handler) already run under
RTNL, the latter two since they take it first, earlier in this series.
So the inversion can't deadlock, but lockdep still reports it, and the
mutex is redundant. Drop it, instead of reordering it against
pf->adev_mutex.

Reproducer, with RDMA enabled on the PF, but irdma not loaded:
  PF=eth3
  ethtool --set-priv-flags $PF fw-lldp-agent off
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:50 1:50 prio-tc all:0 4:1
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:100 prio-tc all:0
  tc qdisc add dev $PF root mqprio num_tc 2 map 0 0 0 0 1 1 1 1 \
          queues 4@0 4@4 hw 1 mode channel

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Reported-by: Petr Oros <poros@redhat.com>
Closes: https://lore.kernel.org/all/20261023070258.730168-3-poros@redhat.com/
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  6 ------
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c  | 15 ---------------
 drivers/net/ethernet/intel/ice/ice_main.c    |  4 ----
 4 files changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 432da05c48c0..12907be77454 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -592,7 +592,6 @@ struct ice_pf {
 	struct work_struct serv_task;
 	struct mutex avail_q_mutex;	/* protects access to avail_[rx|tx]qs */
 	struct mutex sw_mutex;		/* lock for protecting VSI alloc flow */
-	struct mutex tc_mutex;		/* lock to protect TC changes */
 	struct mutex adev_mutex;	/* lock to protect aux device access */
 	struct mutex lag_mutex;		/* protect ice_lag struct in PF */
 	u32 msg_enable;
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 59fafd296f1c..5355519726df 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -555,7 +555,6 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	int ret;
 
 	rtnl_lock();
-	mutex_lock(&pf->tc_mutex);
 
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
 	if (ret) {
@@ -587,16 +586,14 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 		goto dcb_error;
 	}
 
-	mutex_unlock(&pf->tc_mutex);
 	rtnl_unlock();
 
 	return;
 
 dcb_error:
 	dev_err(dev, "Disabling DCB until new settings occur\n");
 	err_cfg = kzalloc_obj(*err_cfg);
 	if (!err_cfg) {
-		mutex_unlock(&pf->tc_mutex);
 		rtnl_unlock();
 		return;
 	}
@@ -614,7 +611,6 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	ice_pf_dcb_cfg(pf, err_cfg, true);
 	kfree(err_cfg);
 
-	mutex_unlock(&pf->tc_mutex);
 	rtnl_unlock();
 }
 
@@ -1077,7 +1073,6 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 
 	/* That a DCB change has happened is now determined */
 	rtnl_lock();
-	mutex_lock(&pf->tc_mutex);
 
 	/* store the old configuration */
 	tmp_dcbx_cfg = pi->qos_cfg.local_dcbx_cfg;
@@ -1142,7 +1137,6 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 	/* enable previously downed VSIs */
 	ice_dcb_ena_dis_vsi(pf, true, true);
 out:
-	mutex_unlock(&pf->tc_mutex);
 	rtnl_unlock();
 
 	/* Send Execute Pending MIB Change event if it is a Pending event */
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 2b9f5e6c1bbe..bc2af975b1e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -78,8 +78,6 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 
-	mutex_lock(&pf->tc_mutex);
-
 	new_cfg->etscfg.willing = ets->willing;
 	new_cfg->etscfg.cbs = ets->cbs;
 	ice_for_each_traffic_class(i) {
@@ -117,7 +115,6 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 		err = ICE_DCB_HW_CHG_RST;
 
 ets_out:
-	mutex_unlock(&pf->tc_mutex);
 	return err;
 }
 
@@ -277,8 +274,6 @@ static int ice_dcbnl_setpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 		return -EINVAL;
 	}
 
-	mutex_lock(&pf->tc_mutex);
-
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 
 	if (pfc->pfc_cap)
@@ -293,7 +288,6 @@ static int ice_dcbnl_setpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 		ice_dcbnl_devreset(netdev);
 	if (err == ICE_DCB_NO_HW_CHG)
 		err = ICE_DCB_HW_CHG_RST;
-	mutex_unlock(&pf->tc_mutex);
 	return err;
 }
 
@@ -774,9 +768,6 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 		return -EINVAL;
 	}
 
-	/* grab TC mutex */
-	mutex_lock(&pf->tc_mutex);
-
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 	old_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
@@ -867,7 +858,6 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 		ret = ICE_DCB_NO_HW_CHG;
 
 setapp_out:
-	mutex_unlock(&pf->tc_mutex);
 	return ret;
 }
 
@@ -895,7 +885,6 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
 		return -EINVAL;
 	}
 
-	mutex_lock(&pf->tc_mutex);
 	old_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
 	ret = dcb_ieee_delapp(netdev, app);
@@ -978,7 +967,6 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
 		ret = ICE_DCB_HW_CHG;
 
 delapp_out:
-	mutex_unlock(&pf->tc_mutex);
 	return ret;
 }
 
@@ -1003,11 +991,8 @@ static u8 ice_dcbnl_cee_set_all(struct net_device *netdev)
 
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 
-	mutex_lock(&pf->tc_mutex);
-
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 
-	mutex_unlock(&pf->tc_mutex);
 	return (err != ICE_DCB_HW_CHG_RST) ? ICE_DCB_NO_HW_CHG : err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 30de690ecf7c..6b6e5ae533ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3876,7 +3876,6 @@ void ice_deinit_pf(struct ice_pf *pf)
 	mutex_destroy(&pf->lag_mutex);
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
-	mutex_destroy(&pf->tc_mutex);
 	mutex_destroy(&pf->avail_q_mutex);
 	mutex_destroy(&pf->vfs.table_lock);
 
@@ -3975,7 +3974,6 @@ int ice_init_pf(struct ice_pf *pf)
 	int err = -ENOMEM;
 
 	mutex_init(&pf->sw_mutex);
-	mutex_init(&pf->tc_mutex);
 	mutex_init(&pf->adev_mutex);
 	mutex_init(&pf->lag_mutex);
 
@@ -9461,9 +9459,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		}
 
 		/* setup traffic classifier for receive side */
-		mutex_lock(&pf->tc_mutex);
 		err = ice_setup_tc_mqprio_qdisc(netdev, type_data);
-		mutex_unlock(&pf->tc_mutex);
 
 adev_unlock:
 		if (locked) {
-- 
2.54.0

