Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611556;
	b=b40RF694fbZ2NgC8EGrZpI61hQwNj0FKun0hOC/ytBZFy/9I1hdD/KMtQk/sTB+oRyUn
	 /WzO4GyjGejhkqnkpSDIRTcRVme42orO8KA3cN9HAZ1Q55hfsQ6zaXu6DU3Fgc1C4YGZT
	 Vcl+nh3Lztj7sYqEW+8iuMQpgvIRTRPiDaeVc3xzo7gsQdpLyZNNXfnVARFCkW1UAX/HK
	 KqLDMdoxemFYXVKwq7xtjONt17ieYl1gflUnjSRwFPDowneaar5ZBiS4oTb1jt9yv/V5b
	 4Tjufq0IBFKb4KigsYKUAq+p8N1Y6V6/dapQgStprNX6I2VvbupbcqDD+lSgWXsDDhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611556;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f+AGwPKiS0MhJ8ISSMylJjJH6ptL+IEmq2EBGy3oHjs=;
	b=X5PBbARx/rg7m+IiTdaSZEVqrnWtfQpejT8a1/m9b7X78kfmV3uwTa1NgwJanPWCS9VF
	 hl7ktPJkl8KUuWJ62JXjUbmGyItU1ocWDruDX4BVA19RBJbOSkIMuvZmIx++wJK4W7Zt1
	 DNS46xmIkcKCeXVt/LHQGaIk9H+HqwKNW/tCZWfjXGl/b5hZYvoJfLw0t4yu7nYIHtOZb
	 5ylgb2LKjTl75ktYiHuNkvmwClEANajbr1fJ+LRYjQjw63GOL9S7V5GyxwEnHQLsPFtI3
	 tVL1PE07SQX3itSxAjUiUavZKilK1MRfOAbSF0KBGbbXa6H4OapYpB1WrjoG8BYhCzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cDSi76Mx;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69045606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69045606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cDSi76Mx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794611556; x=1826147556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ESKBqx23uzu0A+plUgXPSFzFigQTcAQp9ku/8UWTrRo=;
  b=cDSi76MxhBLAK4GQRWEjYSRrGm0FDC0eJ0On3rXv9J9f3+u2eEMfUQWt
   df69H+hcOyXDmmbI+iOImtGLZZfUqz61Pxs37TJPAtM9czv2g0hcCRnI0
   1PPwS3SW9eXfHVaDTcUIFO0gFT0kLrkqs4l/ToAhN+MAx6APxUeA7EKvZ
   uSCFzC0ZFs1Umv7ArWdQEtgFO9cOIMHG0U2UKosesjNNZq8+Br8kYFp42
   c0rDqIR6jkVt/ze1ZmqT8jY9dZLXjoxwUPXkd+0CvTUXe0nwFMaPXKciP
   XK+j4V1VtXWTJMBdcmlGgP6s9NWbfrrizNLvZcxTx3qhvec5GlhWuiUTc
   g==;
X-CSE-ConnectionGUID: 55r6rIvvQsKhxk2xghdz9g==
X-CSE-MsgGUID: 3/u8McpCQI2eBPcNTe9wVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3443143"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3443143"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:12:34 -0800
X-CSE-ConnectionGUID: WojMPZyaRKC90Tl0gZ06OQ==
X-CSE-MsgGUID: y9hJ8IivS2mA3FUmWXvEhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9360982"
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
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/6] ice: skip per-VLAN promisc rules when default VSI Rx rule is set
Date: Fri, 13 Nov 2026 15:12:19 -0800
Message-ID: <20261113231225.1864810-3-anthony.l.nguyen@intel.com>
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

When an ice port in a vlan-filtering bridge goes promiscuous (typical for
bond slaves), the driver installs a per-VLAN ICE_SW_LKUP_PROMISC_VLAN rule
for every VID on top of the broad ICE_SW_LKUP_DFLT VSI Rx rule. Each rule
consumes one of the ~32K Flow Lookup Unit (FLU) entries the device shares
across PFs, so a wide trunk (vid 2-4094) over several PFs overruns the
pool: firmware rejects further Add Switch Rules with ENOSPC (AQ 0x10) and
the DFLT Rx rule itself fails to install:

  ice 0000:5c:00.1: Failed to set VSI 14 as the default forwarding
                    VSI, error -5
  ice 0000:5c:00.1 ens1f1: Error -5 setting default VSI 14 Rx rule

Once a switch context is overrun the retries can also come back as ENOENT
(AQ 0x2), which has misled triage toward a perceived recipe binding defect
rather than a capacity issue.

The DFLT rule already catches every packet on the port regardless of VLAN
tag, so the per-VLAN promisc expansion is redundant while it is installed.
Skip it at the two sites that drive it, ice_set_promisc() and
ice_vlan_rx_add_vid(), keyed on ice_is_vsi_dflt_vsi() rather than the
netdev IFF_PROMISC flag so a failed or LAG-suppressed DFLT install still
falls back to the per-VLAN rules.

IFF_ALLMULTI and IFF_PROMISC can reach ice_vsi_sync_fltr() in separate
passes (a bridge join sets them through separate calls), so the allmulti
pass may expand the per-VID rules before the DFLT rule exists. Drop those
now-redundant rules right after ice_set_dflt_vsi() installs the DFLT rule;
ice_vsi_exit_dflt_promisc() reinstates them when promisc is cleared.

ice_vsi_sync_fltr() subscribed multicast promiscuity only inside the
"default VSI not yet in use" branch, so a promiscuous VSI that finds the
default VSI rule already present (owned by another VSI, or preserved
across a switchdev session) ended up in unicast promisc with no multicast
subscription. Issue ice_set_promisc(ICE_MCAST_PROMISC_BITS) whenever the
netdev is promiscuous; it is idempotent and returns 0 if the rule is
already present.

Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 109 +++++++++++++++++-----
 1 file changed, 88 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47c6798c97e8..ecd05f5050ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -274,7 +274,8 @@ static int ice_set_promisc(struct ice_vsi *vsi, u8 promisc_m)
 	if (vsi->type != ICE_VSI_PF)
 		return 0;
 
-	if (ice_vsi_has_non_zero_vlans(vsi)) {
+	/* skip per-VID expansion; the DFLT Rx rule already covers every VID */
+	if (ice_vsi_has_non_zero_vlans(vsi) && !ice_is_vsi_dflt_vsi(vsi)) {
 		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
 		status = ice_fltr_set_vlan_vsi_promisc(&vsi->back->hw, vsi,
 						       promisc_m);
@@ -304,9 +305,20 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
 		return 0;
 
 	if (ice_vsi_has_non_zero_vlans(vsi)) {
-		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
+		u8 vlan_promisc_m = promisc_m | ICE_PROMISC_VLAN_RX |
+				    ICE_PROMISC_VLAN_TX;
+		int vid0_status;
+
+		/* the vid=0 rule may be in either recipe (the recipe used to
+		 * set it is not recorded), so clear both; clearing an absent
+		 * rule returns 0
+		 */
 		status = ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
-							 promisc_m);
+							 vlan_promisc_m);
+		vid0_status = ice_fltr_clear_vsi_promisc(&vsi->back->hw,
+							 vsi->idx, promisc_m, 0);
+		if (!status)
+			status = vid0_status;
 	} else {
 		status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
 						    promisc_m, 0);
@@ -317,6 +329,61 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
 	return status;
 }
 
+/**
+ * ice_vsi_exit_dflt_promisc - drop the default VSI Rx rule on promisc off
+ * @vsi: the VSI leaving promiscuous mode
+ *
+ * For an IFF_ALLMULTI VSI with VLANs the per-VID multicast rules are
+ * reinstated before the default rule is cleared so coverage never lapses;
+ * the then redundant vid=0 rule is dropped best-effort. The callees log
+ * their own failures, so error returns are not re-logged here.
+ *
+ * Return: 0 on success, negative on error with the default rule left in place.
+ */
+static int ice_vsi_exit_dflt_promisc(struct ice_vsi *vsi)
+{
+	struct ice_vsi_vlan_ops *vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
+	struct net_device *netdev = vsi->netdev;
+	struct ice_hw *hw = &vsi->back->hw;
+	bool restore_mc;
+	int err;
+
+	restore_mc = (vsi->current_netdev_flags & IFF_ALLMULTI) &&
+		     ice_vsi_has_non_zero_vlans(vsi);
+
+	if (restore_mc) {
+		err = ice_fltr_set_vlan_vsi_promisc(hw, vsi,
+						    ICE_MCAST_VLAN_PROMISC_BITS);
+		if (err && err != -EEXIST)
+			return err;
+	}
+
+	err = ice_clear_dflt_vsi(vsi);
+	if (err)
+		return err;
+
+	if (netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		vlan_ops->ena_rx_filtering(vsi);
+
+	if (restore_mc)
+		ice_fltr_clear_vsi_promisc(hw, vsi->idx, ICE_MCAST_PROMISC_BITS,
+					   0);
+
+	return 0;
+}
+
+/* Drop the per-VID multicast promisc rules made redundant by the default
+ * VSI Rx rule; best-effort, a leftover is harmless while that rule stands.
+ */
+static void ice_vsi_clear_vlan_mc_promisc(struct ice_vsi *vsi)
+{
+	if (!ice_vsi_has_non_zero_vlans(vsi))
+		return;
+
+	ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
+					ICE_MCAST_VLAN_PROMISC_BITS);
+}
+
 /**
  * ice_vsi_sync_fltr - Update the VSI filter list to the HW
  * @vsi: ptr to the VSI
@@ -429,30 +496,31 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 				err = 0;
 				vlan_ops->dis_rx_filtering(vsi);
 
-				/* promiscuous mode implies allmulticast so
-				 * that VSIs that are in promiscuous mode are
-				 * subscribed to multicast packets coming to
-				 * the port
+				/* a prior allmulti pass may have added per-VID
+				 * rules now covered by the DFLT rule
 				 */
-				err = ice_set_promisc(vsi,
-						      ICE_MCAST_PROMISC_BITS);
-				if (err)
-					goto out_promisc;
+				ice_vsi_clear_vlan_mc_promisc(vsi);
 			}
+
+			/* Promiscuous mode implies allmulticast. Subscribe
+			 * the VSI to all multicast even when the default VSI
+			 * rule is already in use and the block above is
+			 * skipped (it may be owned by another VSI, or
+			 * preserved across a switchdev session); the unicast
+			 * catch-all does not cover the multicast subscription.
+			 */
+			err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
+			if (err)
+				goto out_promisc;
 		} else {
 			/* Clear Rx filter to remove traffic from wire */
 			if (ice_is_vsi_dflt_vsi(vsi)) {
-				err = ice_clear_dflt_vsi(vsi);
+				err = ice_vsi_exit_dflt_promisc(vsi);
 				if (err) {
-					netdev_err(netdev, "Error %d clearing default VSI %i Rx rule\n",
-						   err, vsi->vsi_num);
 					vsi->current_netdev_flags |=
 						IFF_PROMISC;
 					goto out_promisc;
 				}
-				if (vsi->netdev->features &
-				    NETIF_F_HW_VLAN_CTAG_FILTER)
-					vlan_ops->ena_rx_filtering(vsi);
 			}
 
 			/* disable allmulti here, but only if allmulti is not
@@ -3675,10 +3743,9 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
 		usleep_range(1000, 2000);
 
-	/* Add multicast promisc rule for the VLAN ID to be added if
-	 * all-multicast is currently enabled.
-	 */
-	if (vsi->current_netdev_flags & IFF_ALLMULTI) {
+	/* skip the per-VID rule when the DFLT Rx rule already covers this VID */
+	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
+	    !ice_is_vsi_dflt_vsi(vsi)) {
 		ret = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
 					       ICE_MCAST_VLAN_PROMISC_BITS,
 					       vid);
-- 
2.47.1

