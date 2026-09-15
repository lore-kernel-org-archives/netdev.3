Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F23342514
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475213; cv=none; b=DrEO9aFzUumtb8sEWfxiplN5UvRwMKttmd93SDq3GJcu9phJYWVO8aHREHNo/YPZbAC/zkcb3GfzzOceUqv0Zl838YxIBUweDaGZPshFaG9NWTTit+etMdqoaQGqrI7cgsyxEU3ocT98yUJoE00cC05GZC9pl+TaYijyvREHISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475213; c=relaxed/simple;
	bh=oAWDpuqZOdpll16QDaftNVKANJiwi9Nhqcrxs1OPnQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvnfnrN3QrSNvyKNV5/t++YiZRtP2xiYUxqJ4bG7DOEZyWEFrtkWXte6feZIooX8vnu/DKQeM1I444yO1RYU9/1Yb8dRk/ocxnJ95sf4YPjg/O277Y1/9fl7PTuzVyNZREXalShAbBQHSUiSrogM/xB/R/YIfsC8Si+UrXeKZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQ3NqG3M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ3NqG3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789475210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u8PaP3KPXc1QUATAOA2VFUQ2Gy/Dv+8BB/twsZEIeAM=;
	b=DQ3NqG3M01yOrkjHBV1UfcSsoUtYw5ANLQgWJzXHyO4sJUGdQLHPzW8IXD/tbhPrlAPG7z
	vnEK6EEVm8KziysEm9vagb8Q4giR4edLU7Kauw+vVE9HtIR6Ee1SzBt/9QLOBIMUrBewDd
	pDBhv78dxfHWyGbCEMOVakXevbMPE44=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-mnOb_VfGPnCqFbFRTKzerw-1; Tue,
 15 Sep 2026 08:26:47 -0400
X-MC-Unique: mnOb_VfGPnCqFbFRTKzerw-1
X-Mimecast-MFC-AGG-ID: mnOb_VfGPnCqFbFRTKzerw_1789475205
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D267195398D;
	Tue, 15 Sep 2026 12:26:45 +0000 (UTC)
Received: from fballuch-thinkpadx1carbongen13.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5879C3003EEE;
	Tue, 15 Sep 2026 12:26:42 +0000 (UTC)
From: Filip Balluch <fballuch@redhat.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Filip Balluch <fballuch@redhat.com>
Subject: [PATCH] e1000e: rename init/exit module functions to avoid confusion with e1000
Date: Tue, 15 Sep 2026 14:26:38 +0200
Message-ID: <20260915122639.64936-1-fballuch@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The e1000e driver uses e1000_init_module and e1000_exit_module as its
module init/exit function names, which are identical to those used by the
older e1000 driver. Rename them to e1000e_init_module and
e1000e_exit_module to clearly distinguish e1000e from the legacy e1000
driver.

Signed-off-by: Filip Balluch <fballuch@redhat.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..2a4cf75bce34 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -8203,31 +8203,31 @@ static struct pci_driver e1000_driver = {
 };
 
 /**
- * e1000_init_module - Driver Registration Routine
+ * e1000e_init_module - Driver Registration Routine
  *
- * e1000_init_module is the first routine called when the driver is
+ * e1000e_init_module is the first routine called when the driver is
  * loaded. All it does is register with the PCI subsystem.
  **/
-static int __init e1000_init_module(void)
+static int __init e1000e_init_module(void)
 {
 	pr_info("Intel(R) PRO/1000 Network Driver\n");
 	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
 
 	return pci_register_driver(&e1000_driver);
 }
-module_init(e1000_init_module);
+module_init(e1000e_init_module);
 
 /**
- * e1000_exit_module - Driver Exit Cleanup Routine
+ * e1000e_exit_module - Driver Exit Cleanup Routine
  *
- * e1000_exit_module is called just before the driver is removed
+ * e1000e_exit_module is called just before the driver is removed
  * from memory.
  **/
-static void __exit e1000_exit_module(void)
+static void __exit e1000e_exit_module(void)
 {
 	pci_unregister_driver(&e1000_driver);
 }
-module_exit(e1000_exit_module);
+module_exit(e1000e_exit_module);
 
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.55.0

