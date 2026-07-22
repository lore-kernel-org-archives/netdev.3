Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A633EBF14
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692048; cv=none; b=p8PkHt+00Ylkg0xEuozj4BwjWZZxyxHH37WeLv7zGAw0QOCwNrlUq2bAC7R4Nm5ZWw6kNJ49v4C1ls72cbyDOkWD9tvDpNFzYAl06qC/bhSwT710M37MzdUgGZwD41exsPbLzaziQVYMh/JOiGbGBM8suGOWgfH+fRngy7AlPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692048; c=relaxed/simple;
	bh=KvNeFuWa9CZ6x5KDR4krMCHXl7bGc2zgpdiuvAllhKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiNXmkV4CvtEsh2u/m3i9Twrqjot6euauahP3UFP9f23eEvJbJ02s7bK/rjgyjZ2GJnybLqT2jCV5d9uETdKoQ+a0RE/2PAP8gN6cSp2Bx0LQxLce8JpFFSZZGV55HPJhxv3v6YycSbx95gqeYuZCq3triwbmRtEcIUV3ax0+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Co9DKqDw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Co9DKqDw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784692045; x=1816228045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvNeFuWa9CZ6x5KDR4krMCHXl7bGc2zgpdiuvAllhKg=;
  b=Co9DKqDwMXS9fM1QasYCxkxdrtIWIo0cR0sRC+K09oYbKQz8gxQWrL3F
   DYe0tQHsxAVLQSVpQkCHuUfq6ZmzitAprU4CSmjYJEqowRXxloWHbA1hg
   c0eU0Htbob7CrL3EW17GnWIEmWNUuH6ahx+pfEahJhvaOm1CEVgd9LY+K
   W5OJtbVLfFU8ZtbHCDphifbzSX/BBJ7/3I72D09MSn/BRsCdqEcFkQ5bn
   9ExMfFhCzApJ9ANOHoa03UOKZbxmu5gbeoBbe1+PPEK3yAYE8qjRSOktO
   eIgfgbYNePK1jH08LeyUFQg+HX4b+Q2xlqaU8Br9dfejH3LevrvnAKcTE
   Q==;
X-CSE-ConnectionGUID: 5yfdwnNJRtucAW8tIVPqiQ==
X-CSE-MsgGUID: n5N8eFo6Sk+JqM1SXGD5nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85434047"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85434047"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 20:47:25 -0700
X-CSE-ConnectionGUID: wfuArrUWSAGYjU0yYMl8rg==
X-CSE-MsgGUID: BjFVAt/kQXOVKWNIx/bk/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="257421751"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 21 Jul 2026 20:47:20 -0700
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
Subject: [PATCH v5 5/5] drm/xe/sysctrl: Reuse xe_sysctrl_create_command()
Date: Wed, 22 Jul 2026 09:11:15 +0530
Message-ID: <20260722034228.662746-6-raag.jadav@intel.com>
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

