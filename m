Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377204D4868
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076973; cv=none; b=eAgX5MCAMAZaeFgwQbLLNS/i/9cdDv/jahttwgLe/USrc5VjdlOJiWR4jcasrZNBfTON2M6CMRASaTBXgahAIn58eSMtC+Ts6QYH3/hkH+44tpGpWD3IdrERHXGfMJ7NxN1WigqB5LlfrhO0BylTEznAfqL2JmMSrl1ML8Q1Hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076973; c=relaxed/simple;
	bh=EKdSAYxXzsS0D7//wmgMkbjn8Kk+YYSMLuL1v0Aqp4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UA/duIliTocaUESRqRorO2djMmERwrMH85rqHU5LO/NtBXcejKa7vHx2BpxanqQyAgxnWYetG09+98ctJBMzsh9sUPHLN7hsIFsB8rJnd9HBvL/NqQzv9pw5TTmSz5OdFbcdacGQ5v4U/73Qap1oSLu7i464kjfYdljFBqaLoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8l4yD00; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8l4yD00"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790076966; x=1821612966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EKdSAYxXzsS0D7//wmgMkbjn8Kk+YYSMLuL1v0Aqp4c=;
  b=Y8l4yD00k8Yz+N1aY0mfxZMmc7urlRK42Wc6Ldue7h9MMlue51TEk9CB
   P+SrWdlz63O9WqEY6twP5kMqHgiUJFp3QsqdV7BHhop1yv1E5tc/oGVTB
   J+v21dkxTURMnhThpkWRpi0HHMlvWGUtyVgHZihT6sWzCIeD9M7D+QYZs
   bwUB2pS7pE2wSNeE8QJHuelGJvkSHX5mtg+7xxP60B68fICs2zhLpOBfi
   4hz09VDw7G1TVny1X9tx3RM9JIBYt0IV0ClhdKsxFkR8YrB6dN2mbDyv6
   RvJQsW1N8tj9jFdtYDHl0bEAMM+J5xqXDRyhWpTgCLKMJGKUB1NnfzlDR
   Q==;
X-CSE-ConnectionGUID: tOZVEN2iSyGue/0df2dHog==
X-CSE-MsgGUID: wNXUvkGpRoa/spj0+cmWXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787333"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90787333"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:36:01 -0700
X-CSE-ConnectionGUID: K4nx68ibT6OMcZfrQaMv9Q==
X-CSE-MsgGUID: +Ue86OZIRBSouRcLo686Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272591993"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:36:01 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v2 2/4] ixgbe: Fix FCoE refcount taking for unsupported adapters
Date: Tue, 22 Sep 2026 11:35:56 +0000
Message-ID: <20260922113558.2288111-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ixgbe_fcoe_enable() increments the FCoE reference count before
checking whether the device supports FCoE. The unsupported adapters
shall not take a reference while the ones which have FCoE already
enabled only need to skip hardware initialization.

Fixes: 27ab76065c0c ("ixgbe: add a refcnt when turning on/off FCoE offload capability")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 54d8b079ada4..6585af527743 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -838,15 +838,21 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 	struct ixgbe_fcoe *fcoe = &adapter->fcoe;
 	bool running;
 
+	/* Unsupported adapters do not take a reference */
+	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
+		return -EINVAL;
+
 	/* libfcoe calls ndo_fcoe_disable() even when this callback fails. */
 	atomic_inc(&fcoe->refcnt);
 
 	if (!netif_device_present(netdev))
 		return -ENETDOWN;
 
-	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
-		return -EINVAL;
-
+	/* If offload is enabled, only skip HW init, but keep the reference.
+	 * ixgbe_fcoe_disable() decreases the refcount for this case and only
+	 * disables the offload when the refcount reaches 0. This handles the case
+	 * where multiple offload interfaces are enabled on the same PF (e.g. VLANs)
+	 */
 	if (adapter->flags & IXGBE_FLAG_FCOE_ENABLED)
 		return -EINVAL;
 
@@ -892,6 +898,9 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 	bool running;
 
+	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
+		return -EINVAL;
+
 	if (!atomic_dec_and_test(&adapter->fcoe.refcnt))
 		return -EINVAL;
 
-- 
2.53.0

