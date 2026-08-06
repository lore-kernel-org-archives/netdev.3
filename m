Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE43B71D5
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033518; cv=none; b=U7LHmTmJuuVYJydawrh0mNlS2QhUrh2kCo+xYFCS+fOzwqLtQh+eukYFq67P7i/xpu0k0wK217KrrBvJUkP7fk8rq4bAmJfldYcg6uR+ecYEjhKeOe+Bd/jShtSJiQXXCjHtctIj0d8NQw/niJZS7oqvQCGmBgUOdt0O6539aX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033518; c=relaxed/simple;
	bh=UHRfMQbjLWBkx3tHNc2RKv40AQfZ76LxxAOE4XPfZ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlEgPtzdvNiwhImg0SIxyh4GHh9HkLTIwVUmPgEozDrndbxbkqpw/8Q1Ta88yvGhq8llBavXybNremq7Ju74vSuN3ZSgZLnPp72T8mpRoFNNNVld1XVYL0JZnGVy3rv5AWYN37FJKHoKgAZ5hiZTjms95kXX9tjNy6WBMit73H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvdHkMhk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvdHkMhk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786033516; x=1817569516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UHRfMQbjLWBkx3tHNc2RKv40AQfZ76LxxAOE4XPfZ+M=;
  b=ZvdHkMhkqCt7YeArbjaJbWZPAzwMW2FkMU19tFGgGRC2btNJXUJDq+IT
   k5BL+n1hqqcn5C8PvYrxusl7nbYS7+uF8hdZblx4rTe8WcDl74Ni4YhS7
   qQybA/xhL5cfFC6WXWqRa4HHUOdHbAopaF2GiBcboVn8uKtwf909uGG+P
   bnAn6ZWJPeI2mryd/tGva+8upQInq7okb5N5k8SE5xFDrsl422a08TIrn
   GIhFDXsig9mS6qE43H1v3bR52QXgpTYF98zz71wzYuA/cUtAUd+5WjGX4
   EjO3v4f82oQaCeVVoCStLELfyE4nmZxGGhzAFD41JBIY2jYgjtxjZtnyq
   w==;
X-CSE-ConnectionGUID: 3k0YXhKXS/6LL7L6XpohRA==
X-CSE-MsgGUID: wRF7R8raQZiM3zscBbfUWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90308340"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="90308340"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:25:15 -0700
X-CSE-ConnectionGUID: a9GOIrb2RJakJ0c7eZoehQ==
X-CSE-MsgGUID: nQjtUUevSK6tPemc796stA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="259540526"
Received: from os-delivery.igk.intel.com ([10.123.220.24])
  by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2026 09:25:14 -0700
From: Lukasz Czapnik <lukasz.czapnik@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jakub Kaminski <jakub.kaminski@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: [PATCH iwl-net v2] ice: Fix "Unknown bps" during link events
Date: Thu,  6 Aug 2026 18:24:58 +0200
Message-ID: <20260806162458.2384818-1-lukasz.czapnik@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kaminski <jakub.kaminski@intel.com>

The driver may display "NIC Link is up Unknown bps" messages during
link state changes. This occurs when link status and link speed are
read from different points in time.

The driver processes link events by receiving an asynchronous ARQ event
from firmware containing link_up and link_speed values, then performing
a synchronous AQ query via ice_update_link_info() which overwrites the
phy.link_info structure, and finally calling ice_link_event() with a
link_speed parameter while ice_print_link_msg() read link_speed from
phy.link_info directly.

ice_print_link_msg() always read link_speed from the phy.link_info
structure. This caused link status from the ARQ event to be combined
with link_speed from the later AQ query, mixing information from two
different points in time. When firmware state changed between these
moments, inconsistent messages like "Link is up Unknown bps" appeared.

Add a link_speed parameter to ice_print_link_msg() to ensure link
status and speed are always taken from the same source and point in
time.

---

v2:
Remove conditional assignement of local var link_up only during
UP events. Cache state of both link_up and link_speed for every event.
---

Fixes: c2a23e00613b ("ice: Refactor link event flow")
Signed-off-by: Jakub Kaminski <jakub.kaminski@intel.com>
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    | 17 ++++++++---------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index da679793b397..567058c28907 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1006,7 +1006,7 @@ int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed);
 int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc);
 void ice_fill_rss_lut(u8 *lut, u16 rss_table_size, u16 rss_size);
 int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset);
-void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
+void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed);
 int ice_plug_aux_dev(struct ice_pf *pf);
 void ice_unplug_aux_dev(struct ice_pf *pf);
 void ice_rdma_finalize_setup(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 9ddd7e82a300..c37b72763ce5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2814,7 +2814,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 		/* Tell the OS link is going down, the link will go
 		 * back up when fw says it is ready asynchronously
 		 */
-		ice_print_link_msg(np->vsi, false);
+		ice_print_link_msg(np->vsi, false, 0);
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 968a8e18d197..f8f847b2729b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -835,8 +835,9 @@ static void ice_print_topo_conflict(struct ice_vsi *vsi)
  * ice_print_link_msg - print link up or down message
  * @vsi: the VSI whose link status is being queried
  * @isup: boolean for if the link is now up or down
+ * @link_speed: current link speed value to display
  */
-void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
+void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed)
 {
 	struct ice_aqc_get_phy_caps_data *caps;
 	const char *an_advertised;
@@ -860,7 +861,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 		return;
 	}
 
-	switch (vsi->port_info->phy.link_info.link_speed) {
+	switch (link_speed) {
 	case ICE_AQ_LINK_SPEED_200GB:
 		speed = "200 G";
 		break;
@@ -1190,11 +1191,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 
 	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
 
-	/* Check if the link state is up after updating link info, and treat
-	 * this event as an UP event since the link is actually UP now.
-	 */
-	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
-		link_up = true;
+	link_up = phy_info->link_info.link_info & ICE_AQ_LINK_UP;
+	link_speed = phy_info->link_info.link_speed;
 
 	vsi = ice_get_main_vsi(pf);
 	if (!vsi || !vsi->port_info)
@@ -1224,7 +1222,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 			ice_set_dflt_mib(pf);
 	}
 	ice_vsi_link_event(vsi, link_up);
-	ice_print_link_msg(vsi, link_up);
+	ice_print_link_msg(vsi, link_up, link_speed);
 
 	ice_vc_notify_link_state(pf);
 
@@ -6922,7 +6920,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
 	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
 			      vsi->type == ICE_VSI_SF)))) {
-		ice_print_link_msg(vsi, true);
+		ice_print_link_msg(vsi, true,
+				   vsi->port_info->phy.link_info.link_speed);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
 		ice_ptp_link_change(pf, true);
-- 
2.50.1

