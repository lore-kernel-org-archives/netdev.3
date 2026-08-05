Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BA3DB620
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965752; cv=none; b=uEPos32HU7Dq2CnoKAL0EBZyI+LuPniv2MhINotkuphbYbJ2Yg452DHmWpAAW39OUwiRrZ4ANYJgT4oA592r/a9Jiy0JiscvnRb/5/wRxcabHXtzvVWDizA4LXrq42Ac7HO4qbm9pztB0akYuYFvyfRLprdt7NyZKb8VpVzLHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965752; c=relaxed/simple;
	bh=o1njJp5ZUqbCDIWM9da7vz4exId0PE3GKWD8jGCOozU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5yQ6m/GUb/uUDD+h0ebgfG/CjxjHf31dzn4iA7Z8bw0bXMO9e5LtpvZjiIidtxL33qmD1DNOUncJ4XYsSDJBm3d6fivETkRUlWZh1lsJz0eJn05xE2EpzCRP3LGBiNDE/XGBftkny9t6n5HhySEOzhCDs6hGir1krbUXuGVuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYemOuDU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYemOuDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965750; x=1817501750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o1njJp5ZUqbCDIWM9da7vz4exId0PE3GKWD8jGCOozU=;
  b=JYemOuDUxHt3vAykbgETBKjF2c+74zT5YBPcB1VTC3Mq01cQqLP5dcYS
   kKzqCucMHk00fkuYswSP2Zdud8qqFge2/lYsWem8zR3eHHf6wDlNKlTAM
   LwjnJ3whXAxrkyYobdpd9vztrmntgcqjxDo13/ba/H1boZSJFo75Mzi2T
   MG1NGKe/f40zfxAOwMmsEA8u2p5p5ClLQBmBvRsCGfRx3oSej0lhSSLtD
   NxpcNCupPbhMdq8G+Kr/oQPfCmlU+ChUI/wCNHf3bW9kbAMbyx4wgEVs/
   ngd99upSs0zIlniwUGRSpfzkAeXFXPF+WyN8cu6ezWq8idHJpc5m2H/D1
   w==;
X-CSE-ConnectionGUID: UF6WJeNrRRqIOSnLJHE5/Q==
X-CSE-MsgGUID: cNlY/tbwTnynksbZxk7dFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343516"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343516"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:48 -0700
X-CSE-ConnectionGUID: nmR9z7ZoT3K8xz4RLmsLRg==
X-CSE-MsgGUID: OdSZFqOLRq2SrNnyVU/4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576067"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	benoit.monin@gmx.fr,
	willemb@google.com,
	jramaseu@redhat.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 03/15] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
Date: Wed,  5 Aug 2026 14:35:28 -0700
Message-ID: <20260805213541.2281287-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The hardware is capable of calculating checksum for IPV6 packets with
extension header. To not drop such packets switch from IP/IPV6 checksum
to HW_CSUM.

HW_CSUM is also used in previous generation (i40e).

Previously HW_CSUM was used to indicate that hardware supports general
checksum. Drop it assuming that if the hardware supports it, it is used.

Disabling offload for E830 in case of TSO isn't needed anymore as the
check for TSO is done in Tx path just before preparation of the special
GCS descriptor.

Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cc30d8c73a41..a5e9c3114706 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3491,9 +3491,8 @@ void ice_set_netdev_features(struct net_device *netdev)
 			NETIF_F_RXHASH;
 
 	csumo_features = NETIF_F_RXCSUM	  |
-			 NETIF_F_IP_CSUM  |
 			 NETIF_F_SCTP_CRC |
-			 NETIF_F_IPV6_CSUM;
+			 NETIF_F_HW_CSUM;
 
 	vlano_features = NETIF_F_HW_VLAN_CTAG_FILTER |
 			 NETIF_F_HW_VLAN_CTAG_TX     |
@@ -3555,12 +3554,6 @@ void ice_set_netdev_features(struct net_device *netdev)
 	/* Allow core to manage IRQs affinity */
 	netif_set_affinity_auto(netdev);
 
-	/* Mutual exclusivity for TSO and GCS is enforced by the set features
-	 * ndo callback.
-	 */
-	if (ice_is_feature_supported(pf, ICE_F_GCS))
-		netdev->hw_features |= NETIF_F_HW_CSUM;
-
 	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);
 }
 
@@ -6519,18 +6512,6 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 	if (changed & NETIF_F_LOOPBACK)
 		ret = ice_set_loopback(vsi, !!(features & NETIF_F_LOOPBACK));
 
-	/* Due to E830 hardware limitations, TSO (NETIF_F_ALL_TSO) with GCS
-	 * (NETIF_F_HW_CSUM) is not supported.
-	 */
-	if (ice_is_feature_supported(pf, ICE_F_GCS) &&
-	    ((features & NETIF_F_HW_CSUM) && (features & NETIF_F_ALL_TSO))) {
-		if (netdev->features & NETIF_F_HW_CSUM)
-			dev_err(ice_pf_to_dev(pf), "To enable TSO, you must first disable HW checksum.\n");
-		else
-			dev_err(ice_pf_to_dev(pf), "To enable HW checksum, you must first disable TSO.\n");
-		return -EIO;
-	}
-
 	return ret;
 }
 
-- 
2.47.1

