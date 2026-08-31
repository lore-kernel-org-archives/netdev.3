Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC18390CAB
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187812; cv=none; b=u87cWOQ6ggnaHn5ZgOtikjinZigJocy9cjvnHbnJ5+uxAH0VI50VGFzgdHzmbCyQcEUs1DKsa6kbUlIsc7uzlXQtB5BzVstzCpBoy1hAG+3zdoCiujcZMZ3XHe0oTdDblpdWbx8br/LAxDBPlmAYw6ZmtyBF/N+JgjixkHlv4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187812; c=relaxed/simple;
	bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyryVCVNOTEvxMZOC/eOVf8LBBVurwYUr7qKGPaQPONqom9Vjpre8TKA5EIk2FjYFu1KVdIe36JAFthm3HSpFjTrMWC0FLk30OP9DQaJulSm/+9OU7VyDoGgMgL6l1h5N4+zaNLEDmIVPx0lD4DOHSEKvzO0V6xiVcUboQvQFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/uOUCKD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/uOUCKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788187810; x=1819723810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
  b=e/uOUCKDEHMAyn/12I+1f7EjzXtcgwn5katg7kOCeoWvUZtCqOylwmMF
   WjlwzP+hQ40Zae6R6OITihOR/kw3iGqyScdnapvW221rT4ixW6XGWL07n
   5fij071PjUVRcgJV291BCSDB5eaD4mHx8uc1KkpGlfF8korBuQDn34ggh
   XEaZo4fs4SbJtxiryNjVsWaaKZOLSOQJBNsuBKezgpqZU65zRxp6yxZIy
   7mYQeHrUVX4ZnaqzKRqkpUBXXCPO/H4o31yoCqn9futIzpO/ByZ1AAO8i
   qHSfg7ZhhA3bRiN5xd3QtjRdV4HJTy/LfNT5Hyc0mgchTVYUZhuvhStWn
   A==;
X-CSE-ConnectionGUID: 3kQDQlfkQZOwdn1fbeRibQ==
X-CSE-MsgGUID: H7mG2nv1Qi2lSIDmtYq25g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144523"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="76144523"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:50:08 -0700
X-CSE-ConnectionGUID: QOzBMPyARimzG/+k+oM3fg==
X-CSE-MsgGUID: 7LCNMY+YQFeXI5C0EQSKqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="273003695"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:08 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 1/6] ice: dpll: Add the MUX tables to the documentation
Date: Mon, 31 Aug 2026 14:50:00 +0000
Message-ID: <20260831145005.191040-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
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

