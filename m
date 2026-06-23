Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067FE3769ED
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209713; cv=none; b=ldW2EyGnvEnkhPIE9fCIWVFJANwmP/2ZxqKpstdgWdLn5j4qIbKTmNQkZDNzBi5UM9ChWM6O+z/EaUs2ow8PwL8cja4y6noFiMUoYcK8XHf9qnjuFIKSYh06hVBFR3sMSbkD+or0eOJ8sINOjiUEcmIfB8c/zwe02NaKpjFpSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209713; c=relaxed/simple;
	bh=PjWqZ/1dArIO2yfBSr01QxEUMOsHrYw2XQ7/Cxk/jBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1uG8AoVCrzX27A14NJ2M/rZbLJ03eH25hGkFzIfuNUZ2p3IWXDYM4xXJCUAvUhW0yywjoNKLYs9TVJKlDc7frKRDvcoy5293wp8sVMouSex2fG+FhV7FD2rxZIdN+SJ9pFNVagS9BYN+XhUZB3avhV/L3+GDfc6KU7LgkyAazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIYITJx1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIYITJx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209712; x=1813745712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjWqZ/1dArIO2yfBSr01QxEUMOsHrYw2XQ7/Cxk/jBQ=;
  b=eIYITJx1vgvD73I7ugJyV7uY4S8RxidsG7RFA/0rXLPVTz/muGe+Z/rn
   XR4AChHmB88jdLLShTkg1y5Oh3P/LSEYZVtfFzEmwCYtxxuOuFUYuMBbb
   mRwQ0M4uToiSvFuUTXo3BeD3MzrEyHCt37e1TZ6+0+m7fmGqVyt5A1NMl
   TLQ1Jks4rgf0vfBT0N86W5Ef+9EgKmYbKjzgIi2+YpSDvd8E/VcCC/RB0
   iJNgwVrYTkzZD9JNMFrl0qht0JdobMD26WzcBpnIt2sjNo9w3Hu136oIs
   z+dp0IStXGDx+GQomCNKYH/lfvqumkjFhy9g1ZupsdEr8X11Sz7hL0jsd
   g==;
X-CSE-ConnectionGUID: 8tR60vEhS4uXaBEmbl9wyA==
X-CSE-MsgGUID: p65m5pzWRQWeBwQXNqwyaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82053203"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82053203"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:15:12 -0700
X-CSE-ConnectionGUID: qbTuptXoRjqNsk2JtGB0kA==
X-CSE-MsgGUID: Ena8hjmJTKKRmoV1yiki1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="273175563"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa002.fm.intel.com with ESMTP; 23 Jun 2026 03:15:07 -0700
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
Subject: [PATCH v4 4/5] drm/xe/drm_ras: Wire up error threshold callbacks
Date: Tue, 23 Jun 2026 15:39:58 +0530
Message-ID: <20260623101043.255897-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623101043.255897-1-raag.jadav@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
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
index 7937d8ba0ed9..4afa2ad98300 100644
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

