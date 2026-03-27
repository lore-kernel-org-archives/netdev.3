Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2E1A0BD0
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596234; cv=none; b=mmO/O6MxZpYJhFu7nqGvjgmlgmQi7vYivLBBsm1qvi+dIr67cg35UBwkHrgr8DYrKJIB1MP74JVjTD/WGmrO9Y3Yom+8/gOSxf5aSiWGizAqjzlXiVa/2WbhpbrPKern6C8Lfxmw3xVuq3vlndOfFgiRqoEmWjojRLBUKF6HZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596234; c=relaxed/simple;
	bh=LBFE63JaCQqSofulUu3xv89vB3PFNkSXDiss19Iht1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LanhCf6LCBdL0nvIq48a7CjJ5H5RT1Q1prt4JrwKgZhtYj4jAB7VCLxqqSV8QcjDpsgrVZQKr45WmCdApny2Ax5+LCqE898Sh26ZkTnpYxYx4JJJpwC2BdyVEP8KBmxwkjNkqtyaEnSqMkqTyLW1Y6evacsqmL+27b5cQomUzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQStMXym; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQStMXym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596227; x=1806132227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBFE63JaCQqSofulUu3xv89vB3PFNkSXDiss19Iht1Q=;
  b=IQStMXyml8VOjVA7H8IXonupkSyJS+71c82z5DfpRi+7g6ZqH6rVyPQl
   pl+7CedcbSQ2ZyN2hyYYDnZzZf5BJvg4miFU8GSxOo+1vTMyH10SrA8nK
   f27MqhXoXUhp111jIKfvgYdUHfxnGcf85MD7cYgrkeqOthdY6Az+CLsUe
   TDqo/4ggCUCpmw3opBp2AHe/3iVv6cs8yHR6jizS5gThIan+t7qLEr6Rz
   7zjeoZH4qXTCJfIqbwC1j4Qpsi3aLMCX0NXF2eSGv9S0MNgZoFXTvWJe4
   q7LuxSPnOQ2iEPJwUp5sNlIx9eCZQtGuJt0RVgMAX7yQEOc67Ih1TfvyW
   A==;
X-CSE-ConnectionGUID: 1yGYJbHJSS+4RtJGV09A3Q==
X-CSE-MsgGUID: sLzBEfPKQ5WwBG5BzNfu+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733977"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75733977"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:23:45 -0700
X-CSE-ConnectionGUID: gtJv4Gg8SM+0/j4xItdRpg==
X-CSE-MsgGUID: cfCkn3ZyQHWEJAepH4flog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255739111"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:43 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Konstantin Ilichev <konstantin.ilichev@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net] ice: fix netdev bring-up and bring-down in self-test
Date: Fri, 27 Mar 2026 08:23:30 +0100
Message-ID: <20260327072332.130320-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Ilichev <konstantin.ilichev@intel.com>

When an offline self-test is initiated with ethtool -t, any ongoing
traffic could get stuck because ice_stop() and ice_open() are called
without letting the OS know about state transitions.  In most cases
a write() system call would block.

Fix this by calling dev_change_flags() to bring the netdev up and
down, which ensures ndo_open()/ndo_stop() are called and all watchers
are notified correctly.

Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
Cc: stable@vger.kernel.org
Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Konstantin Ilichev <konstantin.ilichev@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 96d95af..2a4f06f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1416,7 +1416,7 @@ ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
 		/* If the device is online then take it offline */
 		if (if_running)
 			/* indicate we're in test mode */
-			ice_stop(netdev);
+			dev_change_flags(netdev, netdev->flags & ~IFF_UP, NULL);
 
 		data[ICE_ETH_TEST_LINK] = ice_link_test(netdev);
 		data[ICE_ETH_TEST_EEPROM] = ice_eeprom_test(netdev);
@@ -1434,10 +1434,12 @@ ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
 		clear_bit(ICE_TESTING, pf->state);
 
 		if (if_running) {
-			int status = ice_open(netdev);
+			int status = dev_change_flags(netdev,
+						      netdev->flags | IFF_UP,
+						      NULL);
 
 			if (status) {
-				dev_err(dev, "Could not open device %s, err %d\n",
+				dev_err(dev, "Could not bring up device %s, err %d\n",
 					pf->int_name, status);
 			}
 		}
-- 
2.52.0

