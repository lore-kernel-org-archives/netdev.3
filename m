Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437045D5C2
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061280; cv=none; b=UYdIZf1Fm+LBP2SnCx0waGAYF9GRppLu/CpEyJToYufZj+HG6016/CqE/Sfu1fdl6YghoSpiSa+5qbOXQc3bsY+iWOpzfpdVtNCsWXHloXso0VrCQyUd5R6ydS7Tt1xkQEnfF1zF2/wQ0Ev/nXGO3y80/C4BfBsqYQtK3r0OZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061280; c=relaxed/simple;
	bh=YZVMvlqihJ5Aeu60sa2t7C9BAvhMFhRsMLNa7jos1QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmuunh8711KwkTM1gcad7Hf/tLHHgOHvdee2ezHrQtyFa1RR2+McupV0VSR2LuG8buelzmPICvbaiFY/bQLbdpWZzASNH/S3FBRO4QgOL1E9ItzQKgI8sFf3NtvaY9JoQcUlptci0GvBEB6qphXf5/erd1uyiNzK5rGdjubnyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkkgiSZ+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkkgiSZ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787061278; x=1818597278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YZVMvlqihJ5Aeu60sa2t7C9BAvhMFhRsMLNa7jos1QQ=;
  b=JkkgiSZ+DssdlY8Lwd6x8eyG4rvfKlixYWixY3BhlhDtjqksQH1Fj/7N
   jpIontotUpx5/mpiiUHrBQGw9S+NR1rS3hjYhPFKzjVodvBiZ6icvlTLW
   YQQvUVXQ74dAq/zXsZana1T+spi8QUcjF9H7r2PUud81bT13uaN4RAT4F
   qzuj4YymcAS+HNucNjo1gg1E1ZZ03YUWfsjqWcHyffO/XzBeCnBBsYa/Z
   ROaBSb4VhjAILVPuFrHEyY66v29TUFGCUgO9/eE4aOjN+Hqa2tvu5SH+1
   +zgtKvFcPcb6q5/b5wHZy+ELmxvpGmwk8ssD5dIiXeaeQdBYk4RV+GFr5
   Q==;
X-CSE-ConnectionGUID: 8MR/nNuoRb6apa/AEJFSEw==
X-CSE-MsgGUID: 26xYpKQbQtWSX1SuAsLCjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87315151"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87315151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:54:37 -0700
X-CSE-ConnectionGUID: ZpuD4qq7QbSz17HZ2XCdlw==
X-CSE-MsgGUID: EeCyWSdXT7+A9p3roUry2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261021629"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:54:32 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	kuba@kernel.org,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	dev@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	mallesh.koujalagi@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v6 4/5] drm/xe/drm_ras: Wire up error threshold callbacks
Date: Tue, 18 Aug 2026 19:22:08 +0530
Message-ID: <20260818135304.497098-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818135304.497098-1-raag.jadav@intel.com>
References: <20260818135304.497098-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have get/set error threshold support in xe driver, wire them
up to drm_ras so that userspace can make use of the functionality.

$ sudo ynl --family drm_ras --do get-error-threshold \
--json '{"node-id":0, "error-id":2}'
{'error-id': 2, 'error-name': 'soc-internal', 'error-threshold': 16}

$ sudo ynl --family drm_ras --do set-error-threshold \
--json '{"node-id":0, "error-id":2, "error-threshold":8}'
None

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
v3: Return -ENOENT on info absence (Riana)
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 78184b6ea7d4..7f3695707611 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -86,6 +86,38 @@ static int clear_correctable_error_counter(struct drm_ras_node *node, u32 error_
 	return clear_error_counter(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id);
 }
 
+static int query_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id,
+					     const char **name, u32 *threshold)
+{
+	struct xe_device *xe = ep->priv;
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
+
+	if (!info || !info[error_id].name)
+		return -ENOENT;
+
+	if (!xe->info.has_sysctrl)
+		return -EOPNOTSUPP;
+
+	*name = info[error_id].name;
+	return xe_ras_get_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, threshold);
+}
+
+static int set_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id, u32 threshold)
+{
+	struct xe_device *xe = ep->priv;
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
+
+	if (!info || !info[error_id].name)
+		return -ENOENT;
+
+	if (!xe->info.has_sysctrl)
+		return -EOPNOTSUPP;
+
+	return xe_ras_set_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, threshold);
+}
+
 static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
 {
 	struct xe_drm_ras_counter *counter;
@@ -134,6 +166,8 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE) {
 		node->query_error_counter = query_correctable_error_counter;
 		node->clear_error_counter = clear_correctable_error_counter;
+		node->query_error_threshold = query_correctable_error_threshold;
+		node->set_error_threshold = set_correctable_error_threshold;
 	} else {
 		node->query_error_counter = query_uncorrectable_error_counter;
 		node->clear_error_counter = clear_uncorrectable_error_counter;
-- 
2.43.0

