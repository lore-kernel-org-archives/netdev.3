Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A1233941
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512756; cv=none; b=VMFKsXfX1A+tq/3yknM1Zozp79xhI7yXYTRikYLS2iIV2XSrXgtT0/mq40cZqikkdhagx1AbuS6Q1tWWWGsMqHnyo09ihHLK8rd+0zOkoSdbSCnC0b6zr/1bOSqJgUyGzRZWrxXFqAg7Q/GJ3i4lW1KlSxgDn6+Z9h+QJ1cFkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512756; c=relaxed/simple;
	bh=EhIhubh9Rh0xfO3OovAjCUxMlnj9bya8XxpBsuwv5sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaHJ+k4OEhaxCIHFkef5SIuxt2Ky+qZhx7MqdKorcVpYd1u5I5K+TcgailZMyEf4oGWoFGQ4VLhU/hQoDVy6ojkpsB+F+v0FomjacLrHd6VrDfs4whRdOwtbjTkpLlmeg57Bn4ajzItT0tdiEkkFOgFYB3dV086cWx8MHIgfy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/pMrXrN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/pMrXrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779512755; x=1811048755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhIhubh9Rh0xfO3OovAjCUxMlnj9bya8XxpBsuwv5sI=;
  b=g/pMrXrNtXG3QgMcFyvpLmYtaKCc0ifOF5U8aQG1bC3MrcibQv4C37Cr
   nMpLHrahDHtHzFcdvZm/vDhxYVnT9ppC69xhN7DFT7KBn8t6hT3snc68m
   ivt/KdW7SCtXrpsx0KsJ77OdFC7G3iB50KQZb1dh4fmwthpEpOwPS8pYT
   /fue7SZ+deiLeXvE6j/7Oqe0KYjpJB1vH16aJW9cKi4drQH3cXowyzGGT
   bltt0JA1v4Xg/hxAhSOiag0DkZDRWIZjCVq5qrlilPpJN24naWD8/DrpD
   htUaMjvXXRMDGXUhsXFk55LOcPry9wgCPBhsfeYYtUuUDB3SWqd81POdk
   A==;
X-CSE-ConnectionGUID: fBXJppZzRHaaEqy/Nh53sw==
X-CSE-MsgGUID: Pg2baNzxS3yX19oobkg+4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="83013550"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="83013550"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 22:05:54 -0700
X-CSE-ConnectionGUID: euMoS4AbT+OXXNVuI8g8Yg==
X-CSE-MsgGUID: 9NT2x0N+SIaTipOjfajB4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="279199761"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa001.jf.intel.com with ESMTP; 22 May 2026 22:05:51 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	dev@lankhorst.se,
	airlied@gmail.com,
	simona@ffwll.ch,
	kuba@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 3/4] drm/xe/drm_ras: Add per node cleanup action
Date: Sat, 23 May 2026 10:30:21 +0530
Message-ID: <20260523050212.557292-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523050212.557292-1-raag.jadav@intel.com>
References: <20260523050212.557292-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cleanup_node_param() is not registered for previous node in case of counter
allocation failure, which results in stale memory of previous node that
isn't cleaned up on unwind. Add per node cleanup action which guarantees
cleanup on unwind and also simplifies the cleanup logic.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 59 +++++++++++++--------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c1d5ac198a7c..b901976203fc 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -131,53 +131,46 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	return 0;
 }
 
-static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
+static void cleanup_node_param(struct drm_ras_node *node)
 {
-	struct drm_ras_node *node = &ras->node[severity];
-
-	ras->info[severity] = NULL;
-
 	kfree(node->device_name);
 	node->device_name = NULL;
 }
 
+static void cleanup_node(struct drm_device *drm, void *node)
+{
+	drm_ras_node_unregister(node);
+	cleanup_node_param(node);
+}
+
 static int register_nodes(struct xe_device *xe)
 {
 	struct xe_drm_ras *ras = &xe->ras;
-	int i;
+	struct drm_ras_node *node;
+	int i, ret;
 
 	for_each_error_severity(i) {
-		struct drm_ras_node *node = &ras->node[i];
-		int ret;
+		node = &ras->node[i];
 
 		ret = assign_node_params(xe, node, i);
-		if (ret) {
-			cleanup_node_param(ras, i);
-			return ret;
-		}
+		if (ret)
+			break;
 
 		ret = drm_ras_node_register(node);
-		if (ret) {
-			cleanup_node_param(ras, i);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
-{
-	struct xe_device *xe = arg;
-	struct xe_drm_ras *ras = &xe->ras;
-	int i;
+		if (ret)
+			break;
 
-	for_each_error_severity(i) {
-		struct drm_ras_node *node = &ras->node[i];
+		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+		if (ret)
+			break;
+	}
 
-		drm_ras_node_unregister(node);
-		cleanup_node_param(ras, i);
+	if (ret) {
+		cleanup_node_param(node);
+		ras->info[i] = NULL;
 	}
+
+	return ret;
 }
 
 /**
@@ -206,11 +199,5 @@ int xe_drm_ras_init(struct xe_device *xe)
 		return err;
 	}
 
-	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
-	if (err) {
-		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
-		return err;
-	}
-
 	return 0;
 }
-- 
2.43.0

