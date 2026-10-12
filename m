Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5763416869
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824918; cv=none; b=P2Kebb5eD1jb1uGTVroURZdSO7OZ5jSOU/vaP8DQ8XtzGmx5zhd/vCtCi+sHZfBXyRNdnpgVqdrXShQr6/D1hyi+BfvEQhy2+zcAEisd22ZlQO914SQuj+pozjx4zauCKXg+gYw4c6pcDRlq/glW4erPA83g1WTVFYbCjwAl9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824918; c=relaxed/simple;
	bh=a/B5rxo/3r+hkMrNUWeADP7iZNnahorsfgK9Gmw7bo0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgoiuLffLiJ+5Q2fcI0Z/wjwiKBE6K1wADqgyfe6ewYQVFmoCMug4wfEkEnN2aDt9np78c1bqflVijZYHRPoVWp035V0SMj/MSt/9AcX5jQn+HnwlifAqlAcFJgZLXVLVV6wwq6EFHRm15Xe9uLHvKVSVDu3Cw/YtkMyOQXed2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BAS7vN5o; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BAS7vN5o"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiDBn1180313;
	Mon, 12 Oct 2026 10:08:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=6N+nshClg
	Z5dPYfne/jtci9oCeck8zNjKcZoHF4wMfw=; b=BAS7vN5oaBszW1CUc6gAKcpCA
	rjNPxZkUayCSyo+addKU3QdaqX6/jdBZlgyRXd3dEsSDi0NmLzHfKT42Af/s568R
	xR28bw8xwHZKQLFQXKesTq6OcDSXU3/mz+mklvqLEg8FK0UGuR69Gq1uFVEVGZgQ
	cORGpagh6dxaxx8mxhtDZhSg+ezx+hVw9TAkK4y7JGJ/QSPHiwte+5e8TmogYOcI
	M5cFDiVKJ0iKiFqkd4+Zjg3D659BIrx7Exy6roE2n17zpt5y4L3n6NK9qHW4gxQr
	8Vp+sXRCub2+XxsQ5yZacMkcRKsBCfS5yoGfbn4G+fPlnbiQt650F385jobpA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h860hhnm1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Oct 2026 10:08:25 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Mon, 12 Oct
 2026 17:08:23 +0000
From: Erfan Sharafzadeh <erfansh@meta.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <almasrymina@google.com>,
        <kaiyuanz@google.com>, <willemb@google.com>, <asml.silence@gmail.com>,
        <sdf@fomichev.me>, <bobbyeshleman@meta.com>
Subject: [PATCH net] net: devmem: allow peer-to-peer dma-buf attach for bindings
Date: Mon, 12 Oct 2026 10:07:54 -0700
Message-ID: <20261012170754.669462-1-erfansh@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX0i+IeYzbXQMZ
 oNKMtU5RfLmJ2j5/FWLGDjJ5cg/aju++2IdRGRaoMMHmszLlmBudjk0SkhaU3CHWjSJlmHs1GN1
 r3uhKOJCvj7TfZdLBJS+BE73dUx0yzs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfXw3broH9/9EYf
 qxPg/+NF55+/BoTo1vp6s+vHoFo053wldz1WDha8InkvVzc9sJMHQm3TItep00BoK6OUfWR9mgG
 cMenX97nulmZPqymMQ0A+PQ06ovSExUf/ByEn4r5h6FVRyU4k8Q1PKvHgCKRU5OvAPSLa3XK0TI
 Wr9wdj7AVfrH9AAdfzIDPjyWM9aund44Wngx8+fv+jmTfGyPmJYL2b24sqSs6OfGUMew2bniWuj
 4d8Nsw/jVMP18xGUADq9L330+H1M73ItNXoZ19++DgtLhyBWCkpVPg90RX7vm2NRL8WGjwo4A33
 OrlYRfEEMPVjuKHqBodsMZkFjoq0VzBgJvXsiMRCZGcLWk9uS8pscfxfTX9s84EhEHnoao0Q4LR
 uNuCAsdpMyXPdfy9pu3mPTi7tYBfO6xuwbqk9XtNObJvy29n10E+6MIkXbIcDxKmYrFbXFdO0rC
 1/+4rAYbncpuVN5HuqA==
X-Authority-Analysis: v=2.4 cv=cJx1IVeN c=1 sm=1 tr=0 ts=6acd1409 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8 a=FoXqbPtTdAXYarXlNX8A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: --Y9LjwhZj_vvJZ9wpbuqvB2dCQqnr5-
X-Proofpoint-GUID: --Y9LjwhZj_vvJZ9wpbuqvB2dCQqnr5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01

net_devmem_bind_dmabuf() uses dma_buf_attach(), a static attachment:

- peer2peer is false, so exporters must keep the buffer reachable
  without P2P. amdgpu migrates a VRAM buffer to GTT (system memory)
  for that, so device memory bindings silently land in host memory.
- the core pins the buffer on map (dma_buf_pin_on_map()), so it never
  moves while bound.

Switch to dma_buf_dynamic_attach() with allow_peer2peer set, so the
exporter can keep the buffer in device memory. Dynamic attachments are
not pinned on map, and devmem cannot handle the buffer moving, so:

- pin it explicitly with dma_buf_pin() before mapping, which keeps it
  non-movable for the lifetime of the binding, as before;
- wait for the exporter's kernel fences after mapping, which the core
  only does for static attachments.

This matches the pinned RDMA umem path. Exporters that cannot do P2P
to the device fall back as before. RX and TX bindings both go through
this function.

Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
Signed-off-by: Erfan Sharafzadeh <erfansh@meta.com>
---
 net/core/devmem.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index f4d60654ce7f..3721a47426fa 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
@@ -49,6 +50,10 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
 	       ((dma_addr_t)net_iov_idx(niov) << owner->binding->niov_shift);
 }
 
+static const struct dma_buf_attach_ops net_devmem_dmabuf_attach_ops = {
+	.allow_peer2peer = true,
+};
+
 static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 {
 	struct net_devmem_dmabuf_binding *binding =
@@ -74,8 +79,11 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 		  size, avail))
 		gen_pool_destroy(binding->chunk_pool);
 
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
@@ -200,7 +208,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
 	unsigned long virtual;
-	int err;
+	long err;
 
 	if (!dma_dev) {
 		NL_SET_ERR_MSG(extack, "Device doesn't support DMA");
@@ -234,19 +242,35 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
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
+	err = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL, false,
+				    MAX_SCHEDULE_TIMEOUT);
+	if (err < 0) {
+		NL_SET_ERR_MSG(extack, "Failed to wait for dmabuf fences");
+		goto err_unmap;
 	}
 
 	if (direction == DMA_TO_DEVICE) {
@@ -343,9 +367,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 err_tx_vec:
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

