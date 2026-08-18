Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BC45D5D9
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061287; cv=none; b=ZiJHNmjAnh3tRm27oAjLB9aTqYR+8/83QvliOl1bKcQsAlpJbImg9mJhOduFibMUKHFnZCGBhW8yjSwi2Ks82GXXo7p5jYxKOaWJ3ngmOZy0V2WQjhEuJa1cw1OAHEipDGwNIW+O9Qcm+558bfbCjMivoQh6xRP0ZCT2dVLkqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061287; c=relaxed/simple;
	bh=KvNeFuWa9CZ6x5KDR4krMCHXl7bGc2zgpdiuvAllhKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZZ09RzQ5Gd/ExZnXVnZr5Uy1Su1PBHsIuXomZxDExUFpD9Ce6D4caiz99hUMqdgaRiY01BipWHOhytIgqV/PjgTps+OKQaiY0oEEYYmcl48jaIRN+/NR/x4iQpuG106BpKCqC73kl6FfRh4fj2nj0Doo/UYrnqYpLlekXtAxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSZ2VuAU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSZ2VuAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787061285; x=1818597285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvNeFuWa9CZ6x5KDR4krMCHXl7bGc2zgpdiuvAllhKg=;
  b=YSZ2VuAUzNouYYk13wwaEwVBL87Hu9AL10izmleEJBIid7Oj+5qrPAMX
   f5P5eBMAJ0qBE13OyjfyhfcnxkdBvZnORIsxRL6UYN77ZovidK67eFepm
   DwCQgKQyfVBLpyDPYOb0iNGifF+RZwYF+zRba8Vxp/3CpCoyzdkSY6Vpm
   P2R8GWNUofZCk1DmWJPi2GM2k0RK7wuFlGpy6hypftDZ6Qq0FwJ7qyqWF
   JcV6JP2BcSZ89M/IwiLjrRA2WSJ1CAt1DY/eTTcFtRQ6DaOP9KWM2B9xZ
   EXcGAprFdqgmqe4VnKpCUyds36vFjsJVV5s+MP4w3zDay2BZcnQXEuHZX
   A==;
X-CSE-ConnectionGUID: t4XVmmP1Tna9W9XY3ZSgaw==
X-CSE-MsgGUID: ci2gNkgPROepl06fYzF8DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87315173"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87315173"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:54:42 -0700
X-CSE-ConnectionGUID: +V6T1SEgQBCkzg8RgF6JSA==
X-CSE-MsgGUID: Cqt3MslOQ0qyOVu6n6DF0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261021645"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:54:37 -0700
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
Subject: [PATCH v6 5/5] drm/xe/sysctrl: Reuse xe_sysctrl_create_command()
Date: Tue, 18 Aug 2026 19:22:09 +0530
Message-ID: <20260818135304.497098-6-raag.jadav@intel.com>
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

Now that we have a helper to create sysctrl command, reuse it for
threshold crossed events.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_sysctrl_event.c | 28 ++++++++-------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sysctrl_event.c b/drivers/gpu/drm/xe/xe_sysctrl_event.c
index da395148ee9d..15ddd2d8bc6d 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_event.c
+++ b/drivers/gpu/drm/xe/xe_sysctrl_event.c
@@ -49,18 +49,6 @@ static void get_pending_event(struct xe_sysctrl *sc, struct xe_sysctrl_mailbox_c
 	} while (response->count);
 }
 
-static void event_request_prepare(struct xe_device *xe, struct xe_sysctrl_app_msg_hdr *header,
-				  struct xe_sysctrl_event_request *request)
-{
-	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
-
-	header->data = REG_FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
-		       REG_FIELD_PREP(APP_HDR_COMMAND_MASK, XE_SYSCTRL_CMD_GET_PENDING_EVENT);
-
-	request->vector = xe_device_has_msix(xe) ? XE_IRQ_DEFAULT_MSIX : 0;
-	request->fn = PCI_FUNC(pdev->devfn);
-}
-
 /**
  * xe_sysctrl_event() - Handler for System Controller events
  * @sc: System Controller instance
@@ -72,16 +60,16 @@ void xe_sysctrl_event(struct xe_sysctrl *sc)
 	struct xe_sysctrl_mailbox_command command = {};
 	struct xe_sysctrl_event_response response = {};
 	struct xe_sysctrl_event_request request = {};
-	struct xe_sysctrl_app_msg_hdr header = {};
+	struct xe_device *xe = sc_to_xe(sc);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 
-	xe_device_assert_mem_access(sc_to_xe(sc));
-	event_request_prepare(sc_to_xe(sc), &header, &request);
+	xe_device_assert_mem_access(xe);
 
-	command.header = header;
-	command.data_in = &request;
-	command.data_in_len = sizeof(request);
-	command.data_out = &response;
-	command.data_out_len = sizeof(response);
+	request.vector = xe_device_has_msix(xe) ? XE_IRQ_DEFAULT_MSIX : 0;
+	request.fn = PCI_FUNC(pdev->devfn);
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_GET_PENDING_EVENT,
+				  &request, sizeof(request), &response, sizeof(response));
 
 	guard(mutex)(&sc->event_lock);
 	get_pending_event(sc, &command);
-- 
2.43.0

