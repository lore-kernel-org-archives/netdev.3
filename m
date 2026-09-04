Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE654772B3
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519190; cv=none; b=PStCW5OWmxtyo/+g4NIbTUSSHqpHWiaqPio/1c8Kx6TjyGX5LSo5wGBkVTMYl9uM2I+ZnyULwhyNi0dvOig2/IgR99A51pABieYOZCPUcFj+oT1oMyO9k3O/A5tc1ZYIgpecSlhAm6od67kcadLheg94qMce8GrNXcgXMgWhfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519190; c=relaxed/simple;
	bh=HkTEqZ6sjlxxGMjaeue/XW0Df3UPtwFZcq2SgGPDeto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc5a9/qUJ/6NPiEYoj6U9SsWejaxLcT5u181gDcffRKB3YFY/gNpu1yFKR+hFjD0nhneSMweBHKlkCXUUBalMURx5wYKw1B9mumN/xrMjQbTDx7NwR84idAiPWh2blALNw8ui3Mlt7mxq2lF5OD7V70xCZn6aq2Gg9D7D+Imcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PA8UzAAZ; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PA8UzAAZ"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5c2ae02f69eso826947e0c.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519177; x=1789123977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8/JgLbE54eU7oy503citsIF4dH0n9XMNj5rOPWa5Ac=;
        b=lNwZJEU562CJz6oCZpLl6bRLuW0Wgh+X06gPHklHaYtgDIb+G+JAbktL/8BED22QLv
         ouCQ7UpVH22yGtCDQH/vBQCJu29zpfvPdkKjojVMMxTCn1EgHRpkGrQo9c6oa6RCpBsG
         9GIwdBMY3Ht73uaDoTEC8c9rWVu7MSy1xUNuV2CrzWr4fynZ0m3990Ko6V5UCiFNyrJP
         jv+VQUq/CulL5r12g/68nbXXlEplM0EuQF+XyOWoH1HwqFBlfMwcgCTo56NSzQacSAxo
         0WO6QDwweTSgV/YyTO2aq9WrefogJJRIdj1nUbym5UrUx1FgE76QuDWsweER6SM9AWjc
         7CgQ==
X-Gm-Message-State: AFuF++mHBbKHPPGfBBIWP+d5cIgXQRt8g1sWkuKesPqdQotpCacRRSX/
	azjs9B/WqO3X7JVdjue5/MqgCt/CgWZ7RIaZ4WhVtb0RxDd0jJNihrM2lhx809QtdZaFbYZ5n5p
	Biyst2F5LI6zL7c6jOGo/0gvW/XkEHp4gzor1uche1fW3QUIWzUVINluwuWVVuVI0WZu1xx+SvL
	8rcf5XORV1/5pfuaLL/uH+FaG2J5LpIT+3SIvmdYmrIIYOkb2xGwG6waGJZXeZ2vvAki4hctWNK
	zhvX7ypoFgR
X-Gm-Gg: AYBFou00JDGjTAAd+UpISxxW3FwQ5FRYQpiXo2DTmb3ph87pqrVuJU7FG/mN4mUvusJ
	1g/06/tKgQhgFaH/iGF0YQwM2R/X7QgqXkAfVzJcnwuhopOi4prKMgnrU8qRyb096EmTB5J5FII
	tGVqpWlwUu+2BdiYTMakA1OQFlLApsCJhk0ZlEkhpOpXvYekE8xDhfF3I36ZmyuWQ4OTrP1MEd+
	SEAR3dbiM24AX7+LQ41GuoL//rmRJ59lly6n6vEQG4BHPuBKRT86czg7xdCFBPtfFd15BzjtDHP
	qH5H77m5CCaQNhQArh1Vmypn+DXFoPQZ6DaSXGDXkHgkWhEjZPpf8opU2EacKJjoIVeBNvIvrr9
	LqJHrlVGcO4O9KRET54BIjl4mesdE5WxE0iIo4CMzpsgWl8DEXwhqQUO+jTmNuWhdbri5mK78+d
	GqcM5obc1oX03ZyF2U/Q2j9Cj5gnpyn7mYjQ==
X-Received: by 2002:a05:6122:8c8:b0:5c5:dacb:6ae0 with SMTP id 71dfb90a1353d-5c7ed723929mr2421923e0c.4.1788519176735;
        Fri, 04 Sep 2026 03:52:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ec138a06sm1005759e0c.2.2026.09.04.03.52.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2026 03:52:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d7293f13c6so11818565ad.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788519175; x=1789123975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+8/JgLbE54eU7oy503citsIF4dH0n9XMNj5rOPWa5Ac=;
        b=PA8UzAAZXTVKgcELafUoYixYl17EyhOVR9a1vXHt/HQwvi8KjxFxNt+kXxTlJTuXqo
         0BqXyNDYYF/lok8LVAbMoi+fk5bP8GHOlbCskjxNwfgVnQxTfCo5sxHkFq1YY8oVMvGR
         AlGmZASRuKAK4iP7bldIG8Ua9X3uqyvjbuxGI=
X-Received: by 2002:a17:903:3810:b0:2d6:3c22:99bf with SMTP id d9443c01a7336-2db124afcefmr84673555ad.9.1788519175242;
        Fri, 04 Sep 2026 03:52:55 -0700 (PDT)
X-Received: by 2002:a17:903:3810:b0:2d6:3c22:99bf with SMTP id d9443c01a7336-2db124afcefmr84673015ad.9.1788519174773;
        Fri, 04 Sep 2026 03:52:54 -0700 (PDT)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d0asm6171170eec.8.2026.09.04.03.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:52:54 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH 15/15] RDMA/bng_re: Register with ib-core
Date: Fri,  4 Sep 2026 03:43:23 -0700
Message-ID: <20260904104328.763768-16-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260904104328.763768-1-siva.kallam@broadcom.com>
References: <20260904104328.763768-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch registers with ib-core

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 79 ++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 6e9df737c751..2633bb289f09 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -5,6 +5,8 @@
 #include <linux/pci.h>
 #include <linux/auxiliary_bus.h>
 
+#include <net/addrconf.h>
+
 #include <rdma/ib_verbs.h>
 #include <rdma/bng_re-abi.h>
 
@@ -553,6 +555,73 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	return rc;
 }
 
+static void bng_re_dispatch_event(struct ib_device *ibdev, struct ib_qp *qp,
+				  u8 port_num, enum ib_event_type event)
+{
+	struct ib_event ib_event;
+
+	ib_event.device = ibdev;
+	if (qp) {
+		ib_event.element.qp = qp;
+		ib_event.event = event;
+		if (qp->event_handler)
+			qp->event_handler(&ib_event, qp->qp_context);
+
+	} else {
+		ib_event.element.port_num = port_num;
+		ib_event.event = event;
+		ib_dispatch_event(&ib_event);
+	}
+}
+
+static int bng_re_register_ib(struct bng_re_dev *rdev)
+{
+	struct ib_device *ibdev = &rdev->ibdev;
+	int ret;
+
+	/* ib device init */
+	ibdev->node_type = RDMA_NODE_IB_CA;
+	strscpy(ibdev->node_desc, BNG_RE_DESC " HCA");
+	ibdev->phys_port_cnt = 1;
+
+	addrconf_addr_eui48((u8 *)&ibdev->node_guid, rdev->netdev->dev_addr);
+
+	ibdev->num_comp_vectors	= rdev->nqr->num_msix - BNG_RE_MAX_RSVD_IRQ;
+	ibdev->dev.parent = &rdev->aux_dev->pdev->dev;
+	ibdev->local_dma_lkey = BNG_RE_RSVD_LKEY;
+
+	ib_set_device_ops(ibdev, &bng_re_dev_ops);
+	ret = ib_device_set_netdev(&rdev->ibdev, rdev->netdev, 1);
+	if (ret)
+		return ret;
+
+	dma_set_max_seg_size(&rdev->aux_dev->pdev->dev, UINT_MAX);
+	ibdev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POLL_CQ);
+	return ib_register_device(ibdev, "bng_re%d", &rdev->aux_dev->pdev->dev);
+}
+
+static int bng_re_ib_init(struct bng_re_dev *rdev)
+{
+	int rc;
+	u32 event;
+
+	/* Register ib dev */
+	rc = bng_re_register_ib(rdev);
+	if (rc) {
+		pr_err("Failed to register with IB: %#x\n", rc);
+		return rc;
+	}
+	dev_info(rdev_to_dev(rdev), "Device registered with IB successfully");
+	set_bit(BNG_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
+
+	event = netif_running(rdev->netdev) && netif_carrier_ok(rdev->netdev) ?
+		IB_EVENT_PORT_ACTIVE : IB_EVENT_PORT_ERR;
+
+	bng_re_dispatch_event(&rdev->ibdev, NULL, 1, event);
+
+	return rc;
+}
+
 static int bng_re_add_device(struct auxiliary_device *adev)
 {
 	struct bnge_auxr_priv *auxr_priv =
@@ -575,8 +644,17 @@ static int bng_re_add_device(struct auxiliary_device *adev)
 	if (rc)
 		goto re_dev_dealloc;
 
+	rc = bng_re_ib_init(rdev);
+	if (rc) {
+		pr_err("Failed to register with IB: %s",
+			auxr_priv->aux_dev.name);
+		goto re_dev_uninit;
+	}
+
 	return 0;
 
+re_dev_uninit:
+	bng_re_dev_uninit(rdev);
 re_dev_dealloc:
 	ib_dealloc_device(&rdev->ibdev);
 exit:
@@ -586,6 +664,7 @@ static int bng_re_add_device(struct auxiliary_device *adev)
 static void bng_re_remove_device(struct bng_re_dev *rdev,
 				 struct auxiliary_device *aux_dev)
 {
+	ib_unregister_device(&rdev->ibdev);
 	bng_re_dev_uninit(rdev);
 	ib_dealloc_device(&rdev->ibdev);
 }
-- 
2.43.5

