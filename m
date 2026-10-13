Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8A551991
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925837; cv=none; b=rr8kcNjBuntsoupNY9XG+rWYDMWE1o+BBW3Z+ccBb9To7CfUXnRH+JyC4nkUWMOnk+HUoXc3WzJg6dIV9PEoMjEoD0xYl+UUPKW0klul/Xdlk11lSEEzcYMLTvIsA/3PXgRwnsylzw7OeHh2AtoyFtzKpnaa6sgmIAZzisivpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925837; c=relaxed/simple;
	bh=w3LyJVcLGysNtFfsB2TYfXuX/N9oTmEPymDVCNFvtrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G52jvUbHcqmxjH0cvXIWJhXqSAawvJnZNxuVaEG2Zv4EE8vXn1j8lNt/LBWus/wpnpgFrqB+AG9Bm/4AZzCWKPMvyWLP0xGYO9CQp0tFpL1nSKf1Ct2l2t8WUXsLlz2jgdkiELFyOUhZgRsYSPGzTpbczgNxyHdl0oFluPw7fpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=L2H9qUSi; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="L2H9qUSi"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKWQWb699767;
	Tue, 13 Oct 2026 14:10:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=NRl4xIAYX
	WDn6TqLD0VLSF/LkVa4LN4zXVDDrr8oTno=; b=L2H9qUSi9mg+AFX+vpm37cE+Y
	iDQZYQPC6Q/MqD90RLYvztJ4eBNX6gpSMEKqtTfNpzm+f94ARKtaCZxq4INQILls
	ZE6prZQ16rVGKHJnbgYMvlqj6FLVNcGRL9LedMYs/tyT+OLX3nZ6c43oqNTLqlCn
	RFl8ZIEebEyUfhLHGou/swEPOEYydwXuM4COqzeeoAD8rx6gn02wgcQGJDbAxwOj
	SKngrThGXFQBOwNSl5T4s+vG34bydlMUck5hKpP2SGnLHXUQSKsCrrFtlGFyJnas
	qS2n+YiwY6f7wOhDRUrjNwWMd615VbXClWmGXce2r7Ew0OxSZ35T5QEWTy6ww==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h86xj6eps-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Oct 2026 14:10:16 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Tue, 13 Oct
 2026 21:10:15 +0000
From: Erfan Sharafzadeh <erfansh@meta.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <almasrymina@google.com>,
        <kaiyuanz@google.com>, <willemb@google.com>, <asml.silence@gmail.com>,
        <sdf@fomichev.me>, <bobbyeshleman@meta.com>
Subject: [PATCH net-next v2] net: devmem: allow peer-to-peer dma-buf attach for bindings
Date: Tue, 13 Oct 2026 14:09:54 -0700
Message-ID: <20261013210954.2170175-1-erfansh@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NCBTYWx0ZWRfXxoi9a497rDB1
 0wxgCU8BDAplrcwlo6V6gkx5wWFZHU31sUMFr4eiMyt6xzNwqcm8TVTMM4wzX6fvRBTsP16f1sb
 bhrDVYrb8oVT9BLaLGODZ/32J0W5Iqs=
X-Proofpoint-GUID: PC_Dt95gPK6Dutv_1_Ml6Jfqf_Gw-DIX
X-Authority-Analysis: v=2.4 cv=eeGo7LEH c=1 sm=1 tr=0 ts=6ace9e38 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=63e_jcLooa-Z38S73TgA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: PC_Dt95gPK6Dutv_1_Ml6Jfqf_Gw-DIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NCBTYWx0ZWRfXyZKV31pWbtTx
 Dy1XmmiNVfEE4ofX9znp24IEChj+Lq33jHJ35KepQPWNLXMuZmv1eI9O+3aHIKFbvgrQpbh2tT1
 0IZv7Q7WFMXwvSqL6HI1FnHMZPms5XSHDJA8q0xvcf+JqMCUjqeR2biA60hjdpaDIcsHSyGu26I
 Yi3WRRRMnSuP6XsAD9iXfk39LtYEvh33sJoEq9dNDrRtT9Lldh18SuKW2IAjsmvKS8Rj0JpQ6py
 v4JiNv0N5FR7GOmA4PaqEsa3Ox3N5NU2g7sMWITGo9aVSiSEB78R+5Xuz/4a9VaoKIDCDcR30wk
 U5zI+3DvKyw71syBP8Kz3i6/OZtt1iOFqVy+3pwtRCYDWC8yun5jK+slf8zz2E2VDm5iTtKMOA5
 8BlNbR+EKp01FPfIvGEDcriuq5ChC1hinaX1mxgQhxCaASgKwKu2ckuoGRE+49/UfMLXjCR9HYK
 j4L8OtVvPg49JybYFdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

net_devmem_bind_dmabuf() uses dma_buf_attach(), a static attachment
with peer2peer false. Exporters must then keep the buffer reachable
without P2P; amdgpu does so by placing it in GTT (system memory), so a
device memory binding silently ends up in host memory.

Use dma_buf_dynamic_attach() with allow_peer2peer set, so an exporter
that can do P2P to the device keeps the buffer in device memory.
Dynamic attachments are not pinned on map, and devmem cannot handle the
buffer moving, so:

- pin it with dma_buf_pin() before mapping, which keeps it in place for
  the lifetime of the binding, as before;
- wait for the exporter's kernel fences after mapping, interruptibly,
  as the core does for static attachments.

This follows the pinned RDMA umem path, including its limits: the
binding cannot be revoked by the exporter, and once a P2P binding has
pinned a buffer in device memory, a later attachment to the same buffer
that cannot do P2P may fail to pin it. Exporters that cannot do P2P to
the device place the buffer as before. RX and TX bindings both go
through this function.

Signed-off-by: Erfan Sharafzadeh <erfansh@meta.com>
---
v2:
- Target net-next and drop the Fixes: tag. This adds P2P placement
  rather than fixing incorrect behaviour, and it relies on recent
  dma-buf core changes, so it should not go to stable.
- Wait for the exporter's fences interruptibly, as the core does.
- Describe the revocation and mixed-attachment limits in the commit
  message.

v1: https://lore.kernel.org/netdev/20261012170754.669462-1-erfansh@meta.com/

 net/core/devmem.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 95d714d46c6f..fd1b72744564 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
@@ -50,6 +51,10 @@ static void net_iov_free_push(struct net_iov_area *area,
 	freelist[(*free_count)++] = net_iov_idx(niov);
 }
 
+static const struct dma_buf_attach_ops net_devmem_dmabuf_attach_ops = {
+	.allow_peer2peer = true,
+};
+
 static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 {
 	struct net_devmem_dmabuf_binding *binding =
@@ -69,8 +74,11 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 		     binding->area.num_niovs, binding->free_count);
 
 	kvfree(binding->area.niovs);
-	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
-					  binding->direction);
+	dma_resv_lock(binding->dmabuf->resv, NULL);
+	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
+				 binding->direction);
+	dma_buf_unpin(binding->attachment);
+	dma_resv_unlock(binding->dmabuf->resv);
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
@@ -190,7 +198,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	unsigned int sg_idx;
 	size_t niov_idx;
 	size_t i;
-	int err;
+	long err;
 
 	if (!dma_dev) {
 		NL_SET_ERR_MSG(extack, "Device doesn't support DMA");
@@ -226,19 +234,35 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	binding->dmabuf = dmabuf;
 	binding->direction = direction;
 
-	binding->attachment = dma_buf_attach(binding->dmabuf, dma_dev);
+	binding->attachment =
+		dma_buf_dynamic_attach(binding->dmabuf, dma_dev,
+				       &net_devmem_dmabuf_attach_ops, binding);
 	if (IS_ERR(binding->attachment)) {
 		err = PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
 		goto err_exit_ref;
 	}
 
-	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
-						       direction);
+	dma_resv_lock(dmabuf->resv, NULL);
+	err = dma_buf_pin(binding->attachment);
+	if (err) {
+		NL_SET_ERR_MSG(extack, "Failed to pin dmabuf");
+		goto err_unlock;
+	}
+
+	binding->sgt = dma_buf_map_attachment(binding->attachment, direction);
 	if (IS_ERR(binding->sgt)) {
 		err = PTR_ERR(binding->sgt);
 		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
-		goto err_detach;
+		goto err_unpin;
+	}
+	dma_resv_unlock(dmabuf->resv);
+
+	err = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL, true,
+				    MAX_SCHEDULE_TIMEOUT);
+	if (err < 0) {
+		NL_SET_ERR_MSG(extack, "Failed to wait for dmabuf fences");
+		goto err_unmap;
 	}
 
 	if (!IS_ALIGNED(dmabuf->size, niov_size)) {
@@ -332,9 +356,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	kvfree(binding->freelist);
 	kvfree(binding->tx_vec);
 err_unmap:
-	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
-					  direction);
-err_detach:
+	dma_resv_lock(dmabuf->resv, NULL);
+	dma_buf_unmap_attachment(binding->attachment, binding->sgt, direction);
+err_unpin:
+	dma_buf_unpin(binding->attachment);
+err_unlock:
+	dma_resv_unlock(dmabuf->resv);
 	dma_buf_detach(dmabuf, binding->attachment);
 err_exit_ref:
 	percpu_ref_exit(&binding->ref);
-- 
2.53.0-Meta

