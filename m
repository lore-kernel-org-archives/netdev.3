Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0638F64E;
	Thu, 14 May 2026 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799874; cv=none; b=LkXqBLeAQ3VEO93Rp9FFK4PEJdUpTIc0T6ly/W+NXSDET1Q1uImRPdIvs1jR9BVPbyUSQFgF5GLprQiwLnJzN8eNVzW1MGeIEJeFZ4alaywEQEt/LIobQWxWCqUNcnjQBqyXZTH4sTRCVEkxv0TDv2M1q77vCxlmnVTrDfOpkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799874; c=relaxed/simple;
	bh=0CIYW/gbW5djTp4U2PoSARXuN+Tj7BNt7+huCOXfV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTGB3tM4l9wixipPUNxz/iXZPia+aENOhRgqLOev4CPMlpzI5u6fcWV8VyoJFyuEt8a6cwrJjIf7q6c1vJRAVsVXoxma/ijvb1JmhlDd5w61YLYAT0bm5IeS4i+0hvgaP/emS2mLN0+hSpmVLHAMVK/FUlct9knPmj/o7iHHdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOY+X7Js; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOY+X7Js"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778799873; x=1810335873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0CIYW/gbW5djTp4U2PoSARXuN+Tj7BNt7+huCOXfV+o=;
  b=dOY+X7JsLbr6ddmUq6KQNzWJkFNwVIq0WIJPzqygDSOk9NQVL4q5X9Zs
   I5hbgtO/g9TxMFIJArxsuZJn58t58XjleeinWLL57wWGfcUNxes+Ji9qV
   GnHVizxz7baCbR+PduabS3yvRv7nsannZMRKCPES4WLIjSw36/82oFmmY
   q6lDAutOqJZWRYcfGlR5CBGYsNSPSHdr5GAStvcWWPS5JNm6O6Hc9TJBB
   ZpTC2xV+E5INdBmrnDxRiXBNrtHa7UVusqDxHWt9ig/6PFliziVgxTX04
   yS8o5oCEZadpTKWCpK7cHadg+xA7C2dCL+G5YFiFH3tQk43ypd3XxY0BT
   A==;
X-CSE-ConnectionGUID: avziXnmPRIiXWpQbwtGusA==
X-CSE-MsgGUID: hVwi6MHbRI6QfTYXidvoeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79924575"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79924575"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 16:04:33 -0700
X-CSE-ConnectionGUID: ne89P8QpSSSwSLBU5GNJzA==
X-CSE-MsgGUID: CwyzlhESTUKDbWv9OC1y9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="262275870"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa001.fm.intel.com with ESMTP; 14 May 2026 16:04:28 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v9 net-next 4/8] dpll: allow fwnode pins to attempt state change without capability bit
Date: Fri, 15 May 2026 00:59:42 +0200
Message-Id: <20260514225946.2885623-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
References: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pins registered with an fwnode may have .state_on_dpll_set implemented
without advertising DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE upfront.
Requiring the bit for fwnode pins ties firmware description to driver
implementation details unnecessarily.

Relax the capability check in dpll_pin_state_set() and
dpll_pin_on_pin_state_set(): when a pin has an associated fwnode, bypass
the capability gate and let the ops layer decide, returning -EOPNOTSUPP
if .state_on_dpll_set is absent. Non-fwnode pins retain the original
strict behavior.

This is used later in the series by the SyncE_Ref output pin, which
relies on the fwnode path for state control.

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index f709e3dcd58e..025b9df4f934 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1327,8 +1327,11 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 	unsigned long i;
 	int ret;
 
+	/* fwnode pins may not set the capability bit upfront; let the ops
+	 * layer return -EOPNOTSUPP if the operation is unsupported.
+	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities)) {
+	      pin->prop.capabilities) && !pin->fwnode) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -1363,8 +1366,11 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	int ret;
 
+	/* fwnode pins may not set the capability bit upfront; let the ops
+	 * layer return -EOPNOTSUPP if the operation is unsupported.
+	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities)) {
+	      pin->prop.capabilities) && !pin->fwnode) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
-- 
2.39.3

