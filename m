Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D34429CD4
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325899; cv=none; b=afX6KJQDfoqlU9xCsQhu4VZlwEh72xtmtPAfR1to7y5YHl/8QQZzeV5xekrrdWMCuUTXkdaaGfcbp5tMXs6aBzTltH0+X5l+zIv3q9bv2a5hWKv1LFzYflEvwcym5sGsgwExLgq+96BArVnQhOL7E1nP4WwOXjIpWpedfFrcKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325899; c=relaxed/simple;
	bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhgqISrm7hEBiNptEMhjukDHTeLig0MN5YBS9/oSdu+whpNIUxI4iZt0QTZ+9DxrpxPjkKl/EJJFiJKwWM/roRO/Yo8i3zrAJ9K6c3LIoX2rvsUtJR8gR9pA/tBFEMJMOANE+ToESr7wGTqxEMISQvCHE1XnOgkfKbzT+wd0hrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8/N3yzT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8/N3yzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787325898; x=1818861898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
  b=h8/N3yzTu0sN67Z9BKsxCbC/WfqrEdFGfz1Ft5aOBXI9gXoqmksjfA/W
   TwKcC1QocmtzmTPI+BwxnEbPi/vTdzNDZrQWgOS36ludXXWwreYkGjAWp
   qhSp4DjDR/Gpwqje79GcK6lTBTB4eCYMj/EcR1zRc5bnLHP8Pe0Tyb4se
   zPCacwAZYfu0E4XRYGRSwJdK3ltvz6XO3qAJByqZgWQHMXnLbpH7CUyB2
   cTMe10SD7eakgNYb6h3XJDDf0ipdRoZTuuabECzk5AD3quNYKXu8AWbhs
   V/AtYzAFzAngxki0xsUm+hORzYlJ0djVaCudjY3RUQ5PnNIPXSRVBz+jw
   g==;
X-CSE-ConnectionGUID: lxlTsx7iQ4u0uBcLma6hFw==
X-CSE-MsgGUID: ctkyS/8mRies75XPzB/3tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91553199"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="91553199"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 08:24:56 -0700
X-CSE-ConnectionGUID: riteX99IQ666q2+XxzqFTQ==
X-CSE-MsgGUID: 6dZFAxTHSAuzOrNuPlgyRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="270602188"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa005.jf.intel.com with ESMTP; 21 Aug 2026 08:24:55 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v3 1/6] ice: dpll: Add the MUX tables to the documentation
Date: Fri, 21 Aug 2026 15:24:49 +0000
Message-ID: <20260821152454.3703979-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
References: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tables documenting the DPLL pin MUX states and behavior
to the driver.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 382fbe98f2b0..9b3584fa43a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -92,6 +92,29 @@ static const struct dpll_pin_frequency ice_esync_range[] = {
 	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
 };
 
+/*
+ * SMA1/U.FL1 MUX table
+ *+----------------+-------------+------------+
+ *|                | SMA1_DIR_EN | SMA1_TX_EN |
+ *+----------------+-------------+------------+
+ *|SMA1 RX Enable  |       0     |      x     |
+ *|u.FL1 TX Enable |       0     |      0     |
+ *|SMA1 TX Enable  |       1     |      0     |
+ *|All Disable     |       1     |      1     |
+ *+----------------+-------------+------------+
+ *
+ * SMA2/U.FL2 MUX table
+ *+----------------+-------------+------------+------------+
+ *|                | SMA2_DIR_EN | SMA2_TX_EN | UFL2_RX_EN |
+ *+----------------+-------------+------------+------------+
+ *|SMA2 RX Enable  |       0     |      x     |     x      |
+ *|u.FL2 RX Enable |       1     |      x     |     0      |
+ *|SMA2 TX Enable  |       1     |      0     |     x      |
+ *|SMA2 Disable    |       1     |      1     |     x      |
+ *|All Disable     |       1     |      1     |     1      |
+ *+----------------+-------------+------------+------------+
+ */
+
 /**
  * ice_dpll_is_sw_pin - check if given pin shall be controlled by SW
  * @pf: private board structure
-- 
2.53.0

