Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E333A6E9;
	Wed, 12 Aug 2026 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538920; cv=none; b=SoR8rRAYnnLbTF84Lsubp1vK5ghfYGDW9+6hzhluQ86qNoBqCmKR8M1h/0apGXvwUgbHEFw7Gc+Rrn+O4CP0hzWbPIpd8gVcXl9RbjX6sqjEMMJMhq5etbq6lVcZRf+toLXr/E+KoFaem2KAaTD3Hyab02YMOVbrLt3fJkqil4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538920; c=relaxed/simple;
	bh=uReFeL1N8QIRqkSrI/vaid8IQx5zpv4gcnl7BKMXYTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r8i4eT/wdGPp2STPYF/pXT3oIY/Whgbv58nYy157DVL39fH8yyyw7QlSQWqKo4Hv1Pgv1/ppFwTkuS+kCtxwT2LyccqXU7lYz4FFpcVUxQPUH0oRCopAJzmg5Lb/qL1ew4k5GHNWLDRrYUK2jGgfwni9ZdZ8ZgMDYkiWbPVDaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=B2gmX3Hc; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="B2gmX3Hc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4098; q=dns/txt;
  s=iport01; t=1786538919; x=1787748519;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ckyVYzEjdCkdtRZJR6MiwMXJsxPNXV6cgphE7zr2KW0=;
  b=B2gmX3HcgkRViCraYV7MiJg2qoefDgp8CRw0ERyxoeFk2egYWlSm6/5n
   hgWUqMVHBardKKUrvwsKABi2xhcBih00bDSMRc1l+hIsa083qi592uNWo
   Scp46ivA7XJ7kQyIaMp8OLumkuJUfrNPV7H8hSwvwVuxpElB6myT+849a
   Kk0bDcnbnOcBJtTBffqF6j4gPN/eqO/Fv5qEkqkQ2WFBD3RglSKQQo7ML
   GblW51qA89KsajgiGxscFoLlZ97U/xr7CxlkBRkL+zs3g3wT/47+i+/b4
   yIhKeJdE4j+Cfnl3dGgHF95+i5m8cgUbE0rPEw3Cssi5AiCDhTBHu4BZ3
   A==;
X-CSE-ConnectionGUID: mkl4apRATryI410L5semrg==
X-CSE-MsgGUID: Wudvxm85RSyEOIUuIC+C8g==
X-IPAS-Result: =?us-ascii?q?A0BFAgBhanxq/5EQJK1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?oIhnh6Bfg8BAQEPUQQBAYUFAo1nAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdQPDLHp/M4EBh?=
 =?us-ascii?q?H3ZSYFmAQsUAYEKLoVxgmwBgXCECDuEQScbgUlEgRWDaYEZgwaDf4JqBIMcE?=
 =?us-ascii?q?otkhxwJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJxIsF?=
 =?us-ascii?q?zVYGwYFgR19FAQThDYjGTZ8gQlhgSsqZQESF4EJgiQCgnaBKmECAR4LGA1IE?=
 =?us-ascii?q?Sw3Bg4ZBD0BbgeOCCCBVF8SPRw1FIEpDxQZG4EPkmMIFYNhjV9rgTWfWoQog?=
 =?us-ascii?q?WagDwEyl2eTBZkII6Q3hGmBaDyBWTMaCBsVgyJTGQ+OKgMW0BknMj8HAgcPA?=
 =?us-ascii?q?pIEgW0BAQ?=
IronPort-Data: A9a23:a/7XY6Jc9qgRa0T3FE+RA5QlxSXFcZb7ZxGr2PjKsXjdYENS3jRWm
 zAZC2HXOKvZMzTzett0bdm+oUIAvJHQzoJlTgMd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnQ0
 T/Oi5eHYgH9i2cuajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1rD0VqNJUi09ptEEASr
 KQ8dSsAawqM0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSBXbAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzMXwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQhiOS3YYuNIYbiqcN9oVuUu
 HLDrznDOQA3E/2i1BuusVn8ibqa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pbJ
 k0I8y0GoaU49UWtCN7nUHWQrXKZuxcOVsZ4HOo95wWAjKHT5m6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5JKIKfC13Et
 38elo3GvKYFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz0k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:p3QwL6nD8tif11FNUgS1LZmhjWvpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: 9a23:/lqWHW9cwN3iY8/awRiVv0sXHpwsakf08G3BAhPhUUI0U7CQU1DFrQ==
X-Talos-MUID: 9a23:rAMHigv3pp2oHrnGD82nuyxuKtdts/mUM1EgtrQ7puivdgcgNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="804299032"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:32 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 7FAF01800046D;
	Wed, 12 Aug 2026 12:48:31 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:03 -0700
Subject: [PATCH net-next v13 03/11] enic: add admin RQ buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-3-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=4165;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=uReFeL1N8QIRqkSrI/vaid8IQx5zpv4gcnl7BKMXYTQ=;
 b=qCiobw7TJWrSoRwylBN5B3+0Dzg3YYS3GQbYs0F7yqWJOHIivSweMfCRKqqCEBcf1McwnlWco
 YX8LAXgmBQWDoQaIHoyjNv8VwR89gyHFGKazDpg7VhFNBjA7bWpd449
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

The admin receive queue needs pre-posted DMA buffers for incoming
mailbox messages from VFs. Each buffer is a kzalloc'd region mapped
for DMA (2048 bytes, sufficient for any MBOX message).  Zeroing on
allocation ensures that if a completion reports more bytes than
hardware actually DMA-wrote, the parser reads zero padding rather
than uninitialised heap contents.

Add enic_admin_rq_fill(gfp) to post buffers at open time, and
enic_admin_rq_drain() to unmap and free them at close time.
Wire both into the admin channel open/close paths. The gfp_t
parameter lets the caller pass the allocation context; both current
callers -- channel open and the CQ-poll work handler that refills
after draining (added in the next patch) -- run in process context
and use GFP_KERNEL.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_admin.c | 66 +++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 50b46b92c88f..edd0a2d3994b 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -34,10 +35,63 @@ static void enic_admin_wq_buf_clean(struct vnic_wq *wq,
 	}
 }
 
-/* No-op: admin RQ buffer teardown is handled in enic_admin_channel_close */
 static void enic_admin_rq_buf_clean(struct vnic_rq *rq,
 				    struct vnic_rq_buf *buf)
 {
+	struct enic *enic = vnic_dev_priv(rq->vdev);
+
+	if (!buf->os_buf)
+		return;
+
+	dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
+			 DMA_FROM_DEVICE);
+	kfree(buf->os_buf);
+	buf->os_buf = NULL;
+}
+
+static int enic_admin_rq_post_one(struct enic *enic, gfp_t gfp)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	struct rq_enet_desc *desc;
+	dma_addr_t dma_addr;
+	void *buf;
+
+	buf = kzalloc(ENIC_ADMIN_BUF_SIZE, gfp);
+	if (!buf)
+		return -ENOMEM;
+
+	dma_addr = dma_map_single(&enic->pdev->dev, buf, ENIC_ADMIN_BUF_SIZE,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(&enic->pdev->dev, dma_addr)) {
+		kfree(buf);
+		return -ENOMEM;
+	}
+
+	desc = vnic_rq_next_desc(rq);
+	rq_enet_desc_enc(desc, (u64)dma_addr | VNIC_PADDR_TARGET,
+			 RQ_ENET_TYPE_ONLY_SOP, ENIC_ADMIN_BUF_SIZE);
+	vnic_rq_post(rq, buf, 0, dma_addr, ENIC_ADMIN_BUF_SIZE, 0);
+
+	return 0;
+}
+
+static int enic_admin_rq_fill(struct enic *enic, gfp_t gfp)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	int err;
+
+	while (vnic_rq_desc_avail(rq) > 0) {
+		err = enic_admin_rq_post_one(enic, gfp);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void enic_admin_rq_drain(struct enic *enic)
+{
+	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
 }
 
 static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
@@ -171,6 +225,13 @@ int enic_admin_channel_open(struct enic *enic)
 	vnic_wq_enable(&enic->admin_wq);
 	vnic_rq_enable(&enic->admin_rq);
 
+	err = enic_admin_rq_fill(enic, GFP_KERNEL);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to fill admin RQ buffers: %d\n", err);
+		goto disable_queues;
+	}
+
 	err = enic_admin_qp_type_set(enic, QP_ENABLE);
 	if (err) {
 		netdev_err(enic->netdev,
@@ -188,6 +249,7 @@ int enic_admin_channel_open(struct enic *enic)
 		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
 	if (vnic_rq_disable(&enic->admin_rq))
 		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
+	enic_admin_rq_drain(enic);
 	enic_admin_free_resources(enic);
 	return err;
 }
@@ -218,7 +280,7 @@ void enic_admin_channel_close(struct enic *enic)
 			    "Failed to disable admin RQ: %d\n", err);
 
 	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
-	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
+	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	enic_admin_free_resources(enic);

-- 
2.43.0

