Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42D40F8C8
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917755; cv=none; b=eDhwxFs1q4o5+Ig2OrwUnBrKmG5Os3YbUjXbDER66d8hc9wzxFSByoeIyWQ5p1DUrA15o5fx+ipb3H5Ey5XYQ4MQPBqVsn282ZqA0aR8kW4FfgtOZGgW6iaXmjIZ/WPfVP1WaTi2GgLC+WPVDq6OegmU92JpXkWCSIJPlVq4CSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917755; c=relaxed/simple;
	bh=0YkMMnRQnUttBI9ws8lik8ieeR5UeFB3lq4CtOHZ8O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SC/wDrj/j3mdeeAfOFt7Ae728Ol72ErU6vg6YcImORWeKIv+2r6ygivY5k4ZGFzDe5/iYSnSbuMbxKK/daenctU/gfrH52hWkzgSGuIcKRl6taNWkBptXKVPw80qSeL5i9tEuuaw5H/m70o8PPZ4eEmliDVr6JwHcbAtDpcKi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pz1NFQaN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pz1NFQaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917754; x=1800453754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YkMMnRQnUttBI9ws8lik8ieeR5UeFB3lq4CtOHZ8O0=;
  b=Pz1NFQaNbZCgRUMttFmoqrsGKVWtfdiiu4c/3edgi9MDrU5ms4ThKk4z
   s4TJa61zU3Oj24ec/J1JUdOC+CahGjNtoRgNK3MSJJIlYaf5/1S6cEP3w
   Eah7ryMvPYVmtrs1KAtRtStYpdZ8q/eo2PdUbIPn7/q+IfmCpRGCrhzNb
   eK2/3ghFPolgKt/JhM7diTSRH/EzC3Ir8MKBAr8f/nPAcAzJvmxaA0Sff
   EULoHuCCjBngjGnpvGr0uhmq+9Zg9ZTD9lYyCSm+JHC+RM1lPwGXLieO8
   cg0zUmRgp2zIpqmvWPB31hha5GKKV/reDQNZeSn/AhSjihVdZpJRuesR/
   g==;
X-CSE-ConnectionGUID: W9smt/jaT4OdSBKAD5Y3Uw==
X-CSE-MsgGUID: A9aFU+rpRGGn72M/W/aCrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711783"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="72711783"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:02:34 -0800
X-CSE-ConnectionGUID: 8uKMYPhoSK2gpQreG+FKhg==
X-CSE-MsgGUID: 6C8FiCIsRjekQaed+DnMbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210978958"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:32 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 5/6] ixgbe: move EEE config validation out of ixgbe_set_eee()
Date: Tue, 20 Jan 2026 14:44:33 +0100
Message-Id: <20260120134434.1931602-6-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make this part of the code mode reusable move all
EEE input checks out of ixgbe_set_eee().

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: add comment on returning EALREADY
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 98 +++++++++++--------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 779e2425e4aa..b5b9b9335d52 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3556,6 +3556,47 @@ static const struct {
 	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
+static int ixgbe_validate_keee(struct net_device *netdev,
+			       struct ethtool_keee *keee_requested)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ethtool_keee keee_stored = {};
+	int err;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE))
+		return -EOPNOTSUPP;
+
+	err = netdev->ethtool_ops->get_eee(netdev, &keee_stored);
+	if (err)
+		return err;
+
+	if (keee_stored.tx_lpi_enabled != keee_requested->tx_lpi_enabled) {
+		e_err(drv, "Setting EEE tx-lpi is not supported\n");
+		return -EINVAL;
+	}
+
+	if (keee_stored.tx_lpi_timer != keee_requested->tx_lpi_timer) {
+		e_err(drv,
+		      "Setting EEE Tx LPI timer is not supported\n");
+		return -EINVAL;
+	}
+
+	if (!linkmode_equal(keee_stored.advertised,
+			    keee_requested->advertised)) {
+		e_err(drv,
+		      "Setting EEE advertised speeds is not supported\n");
+		return -EINVAL;
+	}
+
+	/* -EALREADY here is for internal use only, must be converted into
+	 * early bail out with 0 by caller
+	 */
+	if (keee_stored.eee_enabled == keee_requested->eee_enabled)
+		return -EALREADY;
+
+	return 0;
+}
+
 static int
 ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 {
@@ -3614,53 +3655,28 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	struct ethtool_keee eee_data;
 	int ret_val;
 
-	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE))
-		return -EOPNOTSUPP;
-
-	memset(&eee_data, 0, sizeof(struct ethtool_keee));
-
-	ret_val = ixgbe_get_eee(netdev, &eee_data);
-	if (ret_val)
+	ret_val = ixgbe_validate_keee(netdev, edata);
+	if (ret_val == -EALREADY)
+		return 0;
+	else if (ret_val)
 		return ret_val;
 
-	if (eee_data.eee_enabled && !edata->eee_enabled) {
-		if (eee_data.tx_lpi_enabled != edata->tx_lpi_enabled) {
-			e_err(drv, "Setting EEE tx-lpi is not supported\n");
-			return -EINVAL;
-		}
-
-		if (eee_data.tx_lpi_timer != edata->tx_lpi_timer) {
-			e_err(drv,
-			      "Setting EEE Tx LPI timer is not supported\n");
-			return -EINVAL;
-		}
-
-		if (!linkmode_equal(eee_data.advertised, edata->advertised)) {
-			e_err(drv,
-			      "Setting EEE advertised speeds is not supported\n");
-			return -EINVAL;
-		}
+	if (edata->eee_enabled) {
+		adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
+		hw->phy.eee_speeds_advertised =
+					   hw->phy.eee_speeds_supported;
+	} else {
+		adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
+		hw->phy.eee_speeds_advertised = 0;
 	}
 
-	if (eee_data.eee_enabled != edata->eee_enabled) {
-		if (edata->eee_enabled) {
-			adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
-			hw->phy.eee_speeds_advertised =
-						   hw->phy.eee_speeds_supported;
-		} else {
-			adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
-			hw->phy.eee_speeds_advertised = 0;
-		}
-
-		/* reset link */
-		if (netif_running(netdev))
-			ixgbe_reinit_locked(adapter);
-		else
-			ixgbe_reset(adapter);
-	}
+	/* reset link */
+	if (netif_running(netdev))
+		ixgbe_reinit_locked(adapter);
+	else
+		ixgbe_reset(adapter);
 
 	return 0;
 }
-- 
2.31.1

