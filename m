Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAC519929
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655869; cv=none; b=oQVAFs6/mN3l5OllRztQEHPuQikwkjztNZLmnhw1CcCLVwP2afi8ukCDZsWC+feToOBtNhhFS0eykZCepYEsVdIZSNth/VIexapipb6V4XUasmQ8HvAf4adDvgefDD5sD49xp12Ma7v8nJkZ3aks0oC4Yg5cvTUh07kVaVoaCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655869; c=relaxed/simple;
	bh=zPDbRt7SWjOhBSTiItfYXamBduo0eahAQ8Ay3tia8Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRoE4hiGLM+Fg+0Qu/o0WmA8YtIU1LC0tDM4RZnIkFgZejRGyZ+tNVq87kqJiw1yEfPhrTq0cpTxgrxbD3KqZHrq4hUIuJdRR8JqY9Pvx7WmHaKxlA7lPx0mc0JoG4Ol7cICgYBXxIuniJYL8mtdg4Crj8fAuPZkDrHkfuPb3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYasOBFj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYasOBFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789655866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vYyGtM8w68AyJ6Trt+JnOBiDiytD+rUjN7FjZ1SYvRE=;
	b=dYasOBFjruOcCP+pgPtqlYZVgi6aaFC8kVm+BDRLnZOlbap+9qhT72kizJ1utJMMAmoS2U
	EnmyGOgd4FFj0jEKFFBCZU/gLNvVwrUAQWJ4V9HoZ0RnD5kxoRO1o/mHIdngG4pVwmpNMx
	SVGa1ZPWhyilbRxgYRCSieotmJ7OcSg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-mwcE1IDMMjafGPAf8DLRFA-1; Thu,
 17 Sep 2026 10:37:42 -0400
X-MC-Unique: mwcE1IDMMjafGPAf8DLRFA-1
X-Mimecast-MFC-AGG-ID: mwcE1IDMMjafGPAf8DLRFA_1789655861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86FBA19772F7;
	Thu, 17 Sep 2026 14:37:40 +0000 (UTC)
Received: from p16v.luc.cera.cz (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA2191800345;
	Thu, 17 Sep 2026 14:37:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: use exact lookup for reference sync pin id
Date: Thu, 17 Sep 2026 16:37:36 +0200
Message-ID: <20260917143736.526221-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

dpll_pin_ref_sync_state_set() looks up the reference sync pin in the
pin->ref_sync_pins xarray, which is keyed by the sync pin's id (see
dpll_pin_ref_sync_pair_add() using xa_insert() with ref_sync_pin->id).
The pin id to operate on is supplied by userspace via DPLL_A_PIN_ID.

The lookup however used xa_find() with a ULONG_MAX limit, which returns
the first present entry with an index greater than or equal to the
requested id, not the entry stored exactly at that id. If userspace
passes an id that is not paired as a reference sync pin, but another
pin with a higher id is present in the xarray, xa_find() silently
returns that wrong pin and the subsequent ref_sync_set() operates on
it. The request only fails when the given id is larger than every
present key.

Use xa_load() for an exact-key lookup instead, mirroring the deletion
path in dpll_pin_ref_sync_pair_del().

Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 45365214fbef..fb24fd53f2e1 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1210,8 +1210,7 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 	struct dpll_device *dpll;
 	int ret;
 
-	ref_sync_pin = xa_find(&pin->ref_sync_pins, &ref_sync_pin_idx,
-			       ULONG_MAX, XA_PRESENT);
+	ref_sync_pin = xa_load(&pin->ref_sync_pins, ref_sync_pin_idx);
 	if (!ref_sync_pin) {
 		NL_SET_ERR_MSG(extack, "reference sync pin not found");
 		return -EINVAL;
-- 
2.54.0

