Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489579;
	b=yXT8WhBjrUxip+PiT5SaEi19/3N1oxghs6sx0fadAWHtYWfSXb9xaqDkvAoqYA6uXIvH
	 evHIXKmjhR0OghocMtUD50Kgi2vDPSymOI0QWfw2nVeJs2HGaBHO4gqt/5+Jy7/m5fQg4
	 2xqJtawwkowRn8wN/TwZehLbboDnVRRibrVS355dxBv0NS8t9Jmsbp5D87MsxAkgmFCcV
	 pFPxaEYwwJpm4Axi5cOWctULNzIdVsg02JFQHCTXOpvCz2aSDIP1UogKyv5lNoLBhNWK8
	 SrBeGpbhShcC7QOxBPh1GCS+IB7g/cjxz3XiE16jfAa4p9eeyPBgRoVtHCfmkzASBgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489579;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=i1tVcWMHmhHcQNA0RiqSC6Y9kYmLvTRwYKuv8Rl8Nhs=;
	b=qK3fyB+EUvNlsAz8F/wpEq+hiPQ74NlTeywh4GJWM/Y4GnCqRrS5XlE6Rjy4rhBpA6EC
	 gvBPYNQ0Xcs4+WrQhhDURAXYBS+wXob+ns26mEfRnVLcB0Ywy/BMmnwizG9ADWgri0d5V
	 LJShC7p3gfzQ3BOiP94vIRp4Qgf238ZWcp+RDpHgydMVrYOIyVtPs2VeNv2MwHgTMK3IT
	 EtPe3JPlnMW1SB/t/5CUgnrcEPpINVTq6OndgQVc5wv4+pNoPSF+8gel3zAAH5RuqUP03
	 7MQaNXWbLLRVAZIQD+R4kzOwkmy/qE/aE/vKtIXm5PcnXzm8lCNib1MscwVPSfxiKZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mdOVnMbG;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA4606A32A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21CA4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mdOVnMbG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489578; x=1824025578;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=s370zKnXI3mO41M7QGlbwfWG70sPpSzWvz7boaMtZRY=;
  b=mdOVnMbG/m57bi/1rzlEOpCe9cqE9xmDDtTz5Ep4OdLWaPbVl6I0s39d
   qd2AuUN14JdG+G2y+6HyXZ023I36PdaOkdyJ/O1t52pnSDf0/IYydifCU
   HSgauf/5yLuQ1OnDgux4/CtkymY5TTipaDd6NUR4wKkPGi5LIGvCuerSY
   xZR5/Qk3c6522sGpvaHJB206bQzjPHSpI7GZSnm3YHF6eQP6BIjk10KE8
   UP49X8YuHsIsQIbHo/KX2APWbA2Kxdg9NxNfi/tkVjML6IZHl0Nu9CyaE
   gfvICV56tdBYwI2tTh68tvdME17Csik7fNA8ZAxnE1JeSz3pDiWd4iMIc
   A==;
X-CSE-ConnectionGUID: 4DmYS3nfQieX4gsEMvpGWQ==
X-CSE-MsgGUID: V0v1Aq4oTmum05YXf+sedg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287900"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287900"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: 98QANiv3RESX04d1mZUHRg==
X-CSE-MsgGUID: LPwMK9hwQeyKgALLX1aQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723901"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:36 -0700
Subject: [PATCH iwl-net v4 05/13] ice: call PTP link change only from link
 events
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
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-5-3e30fc9adc73@intel.com>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7484;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=tKONP/UiQ4rS+wXMJ6t0wDq8UA44IDt2slS8WhXsWh0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvH8Uzn36Nf9m/U6gTOYZa/2tajuue83tYjse/mk9
 5ZwYnZCRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABMR0mRkmKb2IuHMxqv1d8UK
 7z2WusGoJyu479Auv7+ZsYtvOrF98WFkmJJ22NFbrT/PSUJ3Y9GN2Guue5ZOVpVttOtYmeb/6td
 TJgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

The ice_ptp_link_change() function is currently called from
ice_up_complete() and ice_down(). The up and down functions are called from
many places including a variety of administrative tasks such as MTU change.
When called, the ice_ptp_link_change() function forces the PHY to restart,
which can be destructive to ongoing timestamps. We must restart the
timestamping block if the link has changed, but we do not need to restart
it for most of the administrative tasks. The calls also cause unnecessary
re-initialization at every ice_open(), and trigger premature cleanup at
ice_down() even if the actual link hasn't dropped.

Ideally we only want to toggle a PHY timestamping block restart if the
physical link has changed or we are fully reconfiguring the clock. To that
end, stop calling ice_ptp_link_change() during ice_up_complete() and
ice_down().

Initialize the PTP link_up field at probe as part of ice_init_link(),
before the service task and link event handling are enabled. Change
ice_link_event() to call ice_ptp_link_change first before checking if the
link value is the same. Update ice_ptp_link_change to check the current PTP
link status and avoid triggering a restart when the link states match.

For the ice_rebuild() path, call ice_ptp_link_change() to ensure that the
PTP reflects the current link status if it changed while down. Make sure
the link state is current by having ice_update_pf_netdev_link() setting the
get_link_info field of the PF port info, ensuring the state is accurate.

These changes ensure that the link status will reflect the current state of
the physical link without needing to start and stop on every internal
ice_down_up() sequence.

This sequencing should ensure that any link transition will properly update
the PTP state to reflect the new mode, without causing unnecessary
duplicate starts and stops. By removing the calls from ice_up_complete()
and ice_down() the driver no longer unnecessarily thrashes the PTP state in
the hardware.

Finally, for E825, call ice_ptp_port_phy_restart() even when link is down.
This will ensure that the PHY is properly disabled immediately instead of
only calling the stop implementation after some other flow triggers a
restart.

Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 38 ++++++++++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp.c  |  8 +++----
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..910ebdcdde19 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1144,6 +1144,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 		ice_set_link(vsi, false);
 	}
 
+	ice_ptp_link_change(pf, link_up);
+
 	/* if the old link up/down and speed is the same as the new */
 	if (link_up == old_link && link_speed == old_link_speed)
 		return 0;
@@ -1151,8 +1153,6 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	if (!link_up && old_link)
 		pf->link_down_events++;
 
-	ice_ptp_link_change(pf, link_up);
-
 	if (ice_is_dcb_active(pf)) {
 		if (test_bit(ICE_FLAG_DCB_ENA, pf->flags))
 			ice_dcb_rebuild(pf);
@@ -4810,6 +4810,14 @@ static void ice_init_link(struct ice_pf *pf)
 
 	ice_init_link_dflt_override(pf->hw.port_info);
 
+	/* Seed PTP link status from current PHY status, since link may
+	 * already be up (e.g. after PXE boot) without a link-change edge to
+	 * catch it later.
+	 */
+	WRITE_ONCE(pf->ptp.port.link_up,
+		   !!(pf->hw.port_info->phy.link_info.link_info &
+		      ICE_AQ_LINK_UP));
+
 	ice_check_link_cfg_err(pf,
 			       pf->hw.port_info->phy.link_info.link_cfg_err);
 
@@ -6745,7 +6753,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7273,7 +7280,6 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
 	}
@@ -7623,13 +7629,15 @@ static void ice_update_pf_netdev_link(struct ice_pf *pf)
 		if (!vsi || vsi->type != ICE_VSI_PF)
 			return;
 
-		ice_get_link_status(pf->vsi[i]->port_info, &link_up);
+		/* Make sure to get current link info */
+		vsi->port_info->phy.get_link_info = true;
+		ice_get_link_status(vsi->port_info, &link_up);
 		if (link_up) {
-			netif_carrier_on(pf->vsi[i]->netdev);
-			netif_tx_wake_all_queues(pf->vsi[i]->netdev);
+			netif_carrier_on(vsi->netdev);
+			netif_tx_wake_all_queues(vsi->netdev);
 		} else {
-			netif_carrier_off(pf->vsi[i]->netdev);
-			netif_tx_stop_all_queues(pf->vsi[i]->netdev);
+			netif_carrier_off(vsi->netdev);
+			netif_tx_stop_all_queues(vsi->netdev);
 		}
 	}
 }
@@ -7745,10 +7753,6 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (test_bit(ICE_FLAG_DCB_ENA, pf->flags))
 		ice_dcb_rebuild(pf);
 
-	/* If the PF previously had enabled PTP, PTP init needs to happen before
-	 * the VSI rebuild. If not, this causes the PTP link status events to
-	 * fail.
-	 */
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 		ice_ptp_rebuild(pf, reset_type);
 
@@ -7794,6 +7798,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_update_pf_netdev_link(pf);
 
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
+		bool link_up;
+
+		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
+			     ICE_AQ_LINK_UP);
+		ice_ptp_link_change(pf, link_up);
+	}
+
 	/* tell the firmware we are up */
 	err = ice_send_version(pf);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1e6ba6bbf6c2..f43918f334e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1319,6 +1319,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	mutex_lock(&pf->adapter->ps_lock);
 
+	if (READ_ONCE(ptp_port->link_up) == linkup)
+		goto out_unlock;
+
 	WRITE_ONCE(ptp_port->link_up, linkup);
 
 	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
@@ -1367,11 +1370,8 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 		/* Do not reconfigure E810 or E830 PHY */
 		break;
 	case ICE_MAC_GENERIC:
-		ice_ptp_port_phy_restart(ptp_port);
-		break;
 	case ICE_MAC_GENERIC_3K_E825:
-		if (linkup)
-			ice_ptp_port_phy_restart(ptp_port);
+		ice_ptp_port_phy_restart(ptp_port);
 		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);

-- 
2.56.0.212.g129ede20d986

