Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585F3B19BA
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899091; cv=none; b=j9uvE/0mRqAiUed09IvNa392Kt4CoXSvd/GhdJQwfhioPYcS5lDBykp8DJ93elYHnpXCMmQE7Ri0I+MUG/Ke1qZDMxXEoseBHKI4js+LUooZgvRLhl1iCGMIlFcKG73rFcmPDCO2s5uImhvkcfacFx1MKcI0HQMl2y62VGVKXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899091; c=relaxed/simple;
	bh=TcJpdsDum1heQGYG4qsD5ecF2S0Kx42MURjfTK4KaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms2P6+gqgtrVzno8Mxsd06HZZ0EJS5RI+UWfTLf5u016CIRPkPzrszFazOJwVhMBR5rfDeSW4ezyo/219M95qYUbO/6AYPrJ7UNQ01W3GaSF8+lAe+FbhhuwiVS1Fr6UuCblY2GFm9L2yKEvLQMdXl/94aOroxSbpgbqLhWjWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AS6pa3Rp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AS6pa3Rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782899090; x=1814435090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TcJpdsDum1heQGYG4qsD5ecF2S0Kx42MURjfTK4KaW8=;
  b=AS6pa3RpZp2nSgYYR9HWGP9WimBr8ALx/L4ywkfR1sMkY/Qt0MVDOCKO
   +2ETNoB/pZ2ia9d3HBguT2z8qDHBioMvd91VqjIGX/qlErXNQ20Jyx1UN
   PW8gGFYf7l3V8/eU632dLF8KPE2wKf1jzU3dcphjSG5q5ZjFIk2aAu9WS
   YXE24V7XseWBy5xVXLG4h+Tz60YYe/bdfsrygBAdCN69DNx5oR7D17ai7
   lHg9olRLdXNOpxBVkX5klud3KXojp8eiQclT0TSLudQQ/WX5LU8fohuh5
   amc5Tz3vjPjRAUuuE0V7i4nROM5AvprThKnnQj5nNKHbDvESvX8qdabMn
   Q==;
X-CSE-ConnectionGUID: oqqyfPjDSHu+C5CpIbleHw==
X-CSE-MsgGUID: Xaof/EoLTm2dr4MSjKYKWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94781504"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="94781504"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:44:50 -0700
X-CSE-ConnectionGUID: bI6037CeT72zdoSy7yiljg==
X-CSE-MsgGUID: cjWALvV1SVCT7rGjpxpzLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="248541473"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:44:43 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	kuba@kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	maarten.lankhorst@linux.intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v4 2/3] drm/xe/xe_drm_ras: Add error-event support for PVC
Date: Wed,  1 Jul 2026 15:14:12 +0530
Message-ID: <20260701094409.129131-7-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701094409.129131-5-riana.tauro@intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report drm_ras error event to userspace when an error occurs.
Add support for core-compute and SoC errors in PVC.

$ sudo ynl --family drm_ras --output-json --subscribe error-report

{
    "name": "error-event",
     "msg": {
         "device-name": "0000:03:00.0",
         "node-id": 1,
         "node-name": "uncorrectable-errors",
         "error-id": 1,
         "error-name": "core-compute",
         "error-value": 1
     }
}

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v2: use ynl (Raag)
    use value as function parameter
    move error event call to hw_error_source_handler 

v3: add has_drm_ras check

v4: use drm_err_ratelimited
    initialize node post drm_ras check (Sashiko)
---
 drivers/gpu/drm/xe/xe_drm_ras.c  | 32 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h  |  3 +++
 drivers/gpu/drm/xe/xe_hw_error.c |  5 ++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 7937d8ba0ed9..8e247a8139b1 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -185,6 +185,38 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+/**
+ * xe_drm_ras_event() - Report drm_ras error event to userspace
+ * @xe: xe device structure
+ * @component: error component (see &enum drm_xe_ras_error_component)
+ * @severity: error severity (see &enum drm_xe_ras_error_severity)
+ * @value: value of error counter
+ * @flags: flags for allocation
+ *
+ * Report an error-event to userspace.
+ */
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value, gfp_t flags)
+{
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[severity];
+	struct drm_ras_node *node;
+	int ret;
+
+	/* Event is supported only if drm_ras is enabled */
+	if (!xe->info.has_drm_ras)
+		return;
+
+	node = &ras->node[severity];
+
+	if (!info || !info[component].name)
+		return;
+
+	ret = drm_ras_nl_error_event(node, component, info[component].name, value, flags);
+	if (ret)
+		drm_err_ratelimited(&xe->drm, "drm_ras error-event failed: %d for %s %s\n", ret,
+				    info[component].name, error_severity[severity]);
+}
+
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 365c70e93e82..2a694bf69478 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -5,11 +5,14 @@
 #ifndef _XE_DRM_RAS_H_
 #define _XE_DRM_RAS_H_
 
+#include <linux/types.h>
+
 struct xe_device;
 
 #define for_each_error_severity(i)	\
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value, gfp_t flags);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 4a4b363fc844..a833cecc74ec 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -432,7 +432,7 @@ static void hw_error_source_handler(struct xe_tile *tile, const enum hardware_er
 	struct xe_drm_ras *ras = &xe->ras;
 	struct xe_drm_ras_counter *info = ras->info[severity];
 	unsigned long flags, err_src;
-	u32 err_bit;
+	u32 err_bit, value;
 
 	if (!IS_DGFX(xe))
 		return;
@@ -495,6 +495,9 @@ static void hw_error_source_handler(struct xe_tile *tile, const enum hardware_er
 			gt_hw_error_handler(tile, hw_err, error_id);
 		if (err_bit == XE_SOC_ERROR)
 			soc_hw_error_handler(tile, hw_err, error_id);
+
+		value = atomic_read(&info[error_id].counter);
+		xe_drm_ras_event(xe, error_id, severity, value, GFP_ATOMIC);
 	}
 
 clear_reg:
-- 
2.47.1

