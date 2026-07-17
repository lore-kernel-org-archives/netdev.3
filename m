Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384F38F658
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314431; cv=none; b=fqIyGIyJBLOQ+91LG+2Cn4bhw0lzQsxltyI+L6zASchCV+Iylzpr3f4VDcuv+meyql1n8bsNMkShcq/biPUTvAwXnB/RG0q+TC38mcPderEH7R7+a4IxyfN0ojANHvOj8D1sbbUqKeOpfQ8ri7X13pCCssxIp70w7g5MzcCoY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314431; c=relaxed/simple;
	bh=DX8HJwTcJypktbncVs8sVt+j3I0F5JDiUuJ5pOHeHQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbZJdVkjaMQ4iXGA6ZpJigOhqSv65KiHP8JPsVaxTEOEGGZNRxzwpjW0ZS/5DI0NY4+AU5C2FYeMgUsxMLFUEl+Vnkiv7wIu9yMJHuVk2CxauO9DYcZAGmWDk8S+vhWbQwL4Y1Nga836UPZQJgBpaQpFODD/pq/xtd8/MyBIDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDpcDKVc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDpcDKVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314430; x=1815850430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DX8HJwTcJypktbncVs8sVt+j3I0F5JDiUuJ5pOHeHQw=;
  b=kDpcDKVcIiQtIQGfS/tCd/k57JnAyFSb+nzyWg6yArI1yfkCUq0iFdyx
   9/kJGfY/9RaRwxyMthlsX+KEgTqmcr+y3n3yg0bY6yXVh1zFqQJYWCxQX
   zar2Q48aPwcHECK9vQWdGma4aQLDQ84b6RlEc0+KAOJ3XBaevtdH96WYc
   hvSgG+L52aO7xMekLTYWQX3Z6O3o7OX3bwJEi3U2478pdw1jyEDtpt6CZ
   P3o6J8/aebnof9i14fc8AeQol2duH7Xabu+gp00wXAV25RwxnJPkOFnDK
   ibPaG/3hmQ4SowRwY+ESgNyUgBdktZXJIQSTD+MDWIyXEU/CWqolc36Gr
   g==;
X-CSE-ConnectionGUID: GoRXtUwjT1GVMfKpPTNV6A==
X-CSE-MsgGUID: cYFs3sSoRKum4BsCaAdIcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347610"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347610"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:47 -0700
X-CSE-ConnectionGUID: wsk80QLhQMGtbnboD+gY4A==
X-CSE-MsgGUID: 2e0OHsLKRhymMXSZZs++LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827235"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	jramaseu@redhat.com,
	willemb@google.com,
	benoit.monin@gmx.fr,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 05/13] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
Date: Fri, 17 Jul 2026 11:53:27 -0700
Message-ID: <20260717185340.3595286-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
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

The commit from Fixes didn't introduce a bug, it just shown that the
driver is doing sth wrong with the checksum features.

Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fd2dab03e3..8b439e217e02 100644
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
 
@@ -6500,18 +6493,6 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
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

