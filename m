Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896343C051
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917752; cv=none; b=jhf3FztZ4Vrty9jXv+m/bQIZEmxZD+iYOcahBW5e92SbA8rOsyI672qMvtyPoFMNY1F1cEaXcKt9z017HRUWtOulC9KX2z5sfPdgnBZCQw1HjkmorInY38hIdaNt6Ew+Wk+D3CQmIki+QGFgTOgywSjYSTIJkMdB4APLbriy8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917752; c=relaxed/simple;
	bh=tSnNz7TB1ia5nhbzp+EuV2163blMz9E/aGy0jHVUOYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHcYjbsQYHr7MjKIkSf3Gc7RvMdq3YvbcMTZ91jg0RSX096I3YElCJNI2dO3sErQqJL8qqpcxU4XRFIbSyGRYUecoHyWTK7flPhaHir/e9vG9d6NVOwyxjfSmb031+im7oZ85G9qaRVbFnhsR3K+vU7rT0m4YPHpw1mccUUJucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lb0fuKo7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lb0fuKo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917751; x=1800453751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tSnNz7TB1ia5nhbzp+EuV2163blMz9E/aGy0jHVUOYI=;
  b=Lb0fuKo7NIX59u1k0QAsO06+clfqLMD5nMpXgvqVTXsztbYt5uDjhwZP
   5UoaquM8T0w+Z6mRzA3nJHol7n0X/lj4nVRgFh5z+F2cLdN5jiiDjT4hN
   eeNDxPZLZ5lW7mhbbNcfwhVb/qVtxYmsyE4ulibbQBgLcUr2787Ko+umN
   R7r+rU9yZDu44H4D1TUm0N3jcuoGrQaUp1Z2IGQNUp18L0u/LXAT5EXyZ
   RqpS5Jcd2/dOXbMJKV5rmmYh4+Xmh8ryArhjdgS4O3mQT9EPsQls3WTiH
   k/23Xl11msEcFfy6KEpowjl2JD6/8hravEieFmECvfwhpfRNISUVlIbwN
   w==;
X-CSE-ConnectionGUID: GcF75tJST6OuNUr+ME0XEw==
X-CSE-MsgGUID: p5WicEi6QGWKNnODznppdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711763"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="72711763"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:02:30 -0800
X-CSE-ConnectionGUID: Z5suzBncQDu70q0WFZuPMg==
X-CSE-MsgGUID: JJ/4cUhHRUGPttSghNokGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210978921"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:29 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 3/6] ixgbe: E610: update EEE supported speeds
Date: Tue, 20 Jan 2026 14:44:31 +0100
Message-Id: <20260120134434.1931602-4-jedrzej.jagielski@intel.com>
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

Despite there was no EEE (Energy Efficient Ethernet) feature
support for E610 adapters, eee_speeds_supported variable was
defined and even initialized with some EEE speeds.

As E610 adapter supports EEE only for 10G, 5G and 2.5G speeds,
update hw.phy.eee_speeds_supported. Remove unsupported speeds -
10M, 100M and 1G.

Add also entry for 5G speed in EEE speeds mapping array used
by ethtool callbacks.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c    | 11 ++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 431c932f036b..289a04183e03 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1998,9 +1998,14 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	/* Set PHY ID */
 	memcpy(&hw->phy.id, pcaps.phy_id_oui, sizeof(u32));
 
-	hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_10_FULL |
-				       IXGBE_LINK_SPEED_100_FULL |
-				       IXGBE_LINK_SPEED_1GB_FULL;
+	/* E610 supports EEE only for speeds above 1G */
+	if (hw->device_id == IXGBE_DEV_ID_E610_2_5G_T)
+		hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_2_5GB_FULL;
+	else
+		hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_2_5GB_FULL |
+					       IXGBE_LINK_SPEED_5GB_FULL |
+					       IXGBE_LINK_SPEED_10GB_FULL;
+
 	hw->phy.eee_speeds_advertised = hw->phy.eee_speeds_supported;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index bb4b53fee234..779e2425e4aa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3540,6 +3540,7 @@ static const struct {
 	{ IXGBE_LINK_SPEED_100_FULL, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_1GB_FULL, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseX_Full_BIT },
+	{ IXGBE_LINK_SPEED_5GB_FULL, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_10GB_FULL, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
 };
 
-- 
2.31.1

