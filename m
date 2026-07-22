Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322353E6DEC
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692042; cv=none; b=bVBijh2sHSTAcxgQ1ipAHOfJy8IzFb7X/4R2GQckhiTMdqVAEiyCNBojmFMuifgVx+NGjpc/M1Yp38a1ktp0IcARJwxs/jiRsrYDqhb4BFn7CJ0buwuDq5GWXKc1DaTqTJO07+AEGWGZJWPdYdV5/UA6vGFVol3TKEtypMU1494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692042; c=relaxed/simple;
	bh=PjWqZ/1dArIO2yfBSr01QxEUMOsHrYw2XQ7/Cxk/jBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyVJteBaL8HqigL0ByKqv2z8Uj6qViwKprDHgEaGJGPqolpYdu3dBy273T5I7dwigBoIK6RwgbTMMS+IjrfQcFUuzcnfGQ0ludS7dCjEPBLbnaDdvjqeGRzNtblACJNRSpkYFi+/gYkVsyAjU99LKIbzfQrx9bRZi1r6zIiNBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbj7wp1Y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbj7wp1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784692040; x=1816228040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjWqZ/1dArIO2yfBSr01QxEUMOsHrYw2XQ7/Cxk/jBQ=;
  b=gbj7wp1Yx5odZ8Hh+f6u1Y6cHu1VtN8T9XpxvpnerfCSvWAG0TfokC71
   bo9j0x0bsvL1866KWL/QHZRxA64SAmgbK25ce4TkVN88Nc9W3Tx1bfAjb
   mA1HcMYZ8VYz8R7alTy90CmuwI3oMPEY1ZPfwI1nEBWo5GjgpZyKoH0ga
   JeRNQTbL9lUQyqqWCAs24cg3nzMdI/jBb9b/7TG0UbbfK85BVucv+Rj5e
   mVEy0XvOVHBBz3pOmG4qE96KWo2wUmmUU3xph7spXkMRtLSQawaw+5R14
   w05Xw9cfdJ1019FUkEtfp+sQWTI4agK7l79c0Ca01wAHqmMRMI3sSmqn0
   A==;
X-CSE-ConnectionGUID: CT0QIyXqQDuVN4zCFkYY1g==
X-CSE-MsgGUID: lWGzQOkAQ/Cyc29q4FwxNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85434031"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85434031"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 20:47:19 -0700
X-CSE-ConnectionGUID: Q8+tP4umQdeAwSTOsFON+Q==
X-CSE-MsgGUID: QuzvXSvLTFS7qis2NwxAQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="257421742"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 21 Jul 2026 20:47:14 -0700
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
Subject: [PATCH v5 4/5] drm/xe/drm_ras: Wire up error threshold callbacks
Date: Wed, 22 Jul 2026 09:11:14 +0530
Message-ID: <20260722034228.662746-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722034228.662746-1-raag.jadav@intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
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

