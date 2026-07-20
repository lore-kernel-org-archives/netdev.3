Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9937E5CD
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535766; cv=none; b=S3ZXO19oLOoL4JmOehdyBw3Euc+bOtEs/nzUefvjeXU0cslEDvupZC0S0jTH0m2rywUij98uV2Z5s3y56Z6nTUlPGdkMBgkTm8iPX7w7UT3sW5frQTZgSSzGLpqURjBob5oeAmCFx3EmxjbTO+lpo9zkRC1/QfT2Oc9QO8fNe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535766; c=relaxed/simple;
	bh=kI9HX11AHtPLvfep3qW1CdbbEBM12C4Ad1vHVWm3A3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyR+CUeECFwBqgkA+ri+h3ga3y9/dsUaZCzMfEetCDr5YkcFU1VyiVoqBjjesUsWRZYfZ/Yf6IVjRmNEnws8ZDoKrrtomzhejnHv3ABntPokE0G793FvcCY5m4EEv/kk+jEtkS02fM4V7hYqkjGC7sy8iRakQ2Ng0OIw77m/yVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0MrS5Jk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0MrS5Jk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784535765; x=1816071765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kI9HX11AHtPLvfep3qW1CdbbEBM12C4Ad1vHVWm3A3k=;
  b=m0MrS5Jk0seWRZv5QnKY/PYwrLkg4X3/DxF6Ie+PE+m/4SVhmsAOYCSq
   +YO7hG9QqQ9BiOOgYorUsV762awpiyF0EiDT043PCecPnhQbYGMKWM3Mv
   w7n8Y/7IN1ORET9EbizqN0u4QI2/zqX3JcUOtOZ7aI/BlTkJt8iE+STPd
   R/4kK5wXnBJZNlXOzCVIGOjlM8nvGHl6GueQmhy/zUb3SaVUMD0ceKd6H
   QAVmd36o72MLTgsMjmdYaztoJafI+f1w+XSsQChAjN8VQrxyOBu3Yo/i2
   6UqFO9tZgham5PqKUl6y5iVt75/Ncitmuxa5SUqVy6tTGr/b1SErOtQXp
   w==;
X-CSE-ConnectionGUID: aThrSpg6ReCP/bYCXApaMA==
X-CSE-MsgGUID: 9RfM9qUSSRygR2Cwg9FUKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85228612"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85228612"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 01:22:44 -0700
X-CSE-ConnectionGUID: wMWxhp9xQ16lkWhtuHL9bQ==
X-CSE-MsgGUID: OKUUQJ96SwWBJUDdaugmUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="258034751"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 01:22:40 -0700
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
Subject: [PATCH v5 3/3] drm/xe/xe_ras: Report uncorrectable error events to userspace
Date: Mon, 20 Jul 2026 13:52:12 +0530
Message-ID: <20260720082208.2648279-8-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260720082208.2648279-5-riana.tauro@intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the firmware reports uncorrectable errors in response to an AER
interrupt, deliver a drm-ras error event to userspace for each affected
component. Multiple errors for the same component within a single firmware
response are collapsed into one event to avoid duplicate notifications.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index b08c664778ff..cd1307539912 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -449,6 +449,7 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 	enum xe_ras_recovery_action final_action;
 	u32 remaining = XE_SYSCTRL_FLOOD_LIMIT;
 	struct xe_ras_get_soc_error response;
+	u8 sent = 0;
 	size_t rlen;
 	int ret;
 
@@ -492,6 +493,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
 				sev_to_str(severity));
 
+			/* Send event once per component */
+			if (!(sent & BIT(component))) {
+				sent |= BIT(component);
+				ras_send_error_event(xe, severity, component);
+			}
+
 			switch (component) {
 			case XE_RAS_COMP_CORE_COMPUTE:
 				action = handle_core_compute_errors(arr);
-- 
2.47.1

