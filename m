Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98245C6E0
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391048; cv=none; b=HeD7XnJdWlfoFBLL7yU5J4EXhpQTueeRbCxojzj74CXzmoTsOLq7OES8VG+YPPMyd6A50pBvZe7RQzZqet9mqa6YAMlNGYdtnFZbspuBF2jAi50+NGVvr4FlCi654FMUpRP9H4Svyx1aarINduZalXedzEhahmq67YhYiz+zTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391048; c=relaxed/simple;
	bh=nVxKF4JUnFA8pYDHYkDQgqgrgnBto0O4WtcNzT812io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUxAs4ViKh9tWCvbAKOehRsO1oUmdd8gLHkEHhbJ6aBGJ21EOcSo8tKYTduQpwN6ppfhV6109r6LJOO/V4cXkMP+VUCra84rMi2xfcBXbpjgi2G5v2yzMt69OKpkLlHImF6rs1WU0DmGKtKb8RbyYUjH4Ve6k5M9FXdAeqquG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT/PU6R7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT/PU6R7"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbee846deecso3096426a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791391047; x=1791995847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zzmCTlN2LKpQDlGX69irecctA25CCs8mwLmZ5GzVuOQ=;
        b=jT/PU6R795cHyNLYNdCOHMxVBj9kA0pQuW27xjM+kCrL+mkO5/KW50zrMwsIOqJ2rV
         F6r1Aeb5NakLhcZ8EVG37qXvDupssRFlblKU17T8EyUdipgruLM1xL4Eqe1cEt+hEIcN
         t4naVjRUEklNORrXabTei6bQq2E1spytnByC2eG9/7CYzWvYQzG04h92ByzZHbm/g46O
         2uTfN++I5p+URCVbR2ZQg1n1hU6s/JxdlMCALhTNDHYIkTpSefsJEyMEkqhVjIhaUt6w
         o8+m06n+GnaDGRwDGGJkbuQJqnT8KBfB8ow8Cxe6PelIRGPF2j6tYEMF59jkGdiQWt9o
         nRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791391047; x=1791995847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzmCTlN2LKpQDlGX69irecctA25CCs8mwLmZ5GzVuOQ=;
        b=rc82ug+zMURKKB7JiUKv0HVK2TlW8CkwnNG8q848jbJNlCvqMund5d99QLLtAF4pZ3
         /w4W5DrrnVsM1kHA+CSjwY73KGJRGMGYQdD5jc4aiOKkOHhpTgC6NaTHQp5lvrSjRvKI
         JG5ZhMZU1i+kCV8uYu2ahiilXSlJW0DkH9pMPE0KHPfUCe6lWUxEF5iXt1EBtDHotEHc
         JLk9P8oLA7Deh8M85y7W381WuFuOtxrFzG/Vr/5Ca+GCamVBVsd/CfwZ/BZwBg7DDaVF
         oEqC3DYlJzWpg7h4Zy5e/LUAQACb3j69WvyJPjllzY5gMWXWgw8qVlsEOs7PH62DMWXc
         8NnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEIFq/rwkz8I9EOVd8eZdbJo4glEXxglj/knS45YpJ9SuRjseQF+h3unmWpJrdYIOzSnGbGf4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+FB8L3n2U8fYo78hl7xyZ0lf4wUnsWXCkSPr61sRjYIhJWDoX
	/1ZQS1Qj/3jL+DkFttk8QBwaJSrR3oGQvqADqhYscUh1kV9jmdJVh8+W
X-Gm-Gg: AYBFou0h0wPPzXy2+5ZlHFCx54+f1vbk8FzrFNtoCdwINl3AT8GDvPWm7pXNJP/k/ho
	vxo7qqvpN973SKST89T8DYvZ7NgBIvrogyU0AAGfQZL95G+FC04cXcjisquUP0cABBHSt24fsBE
	/NQ09lnfG8OSkgeH1uhITHZWStwOkcD5qqx3Qqh9JYsgIgTjPmpfwr7zQCZF661Msbj0x0tWkQI
	4wzkqOVs0DmbqG6H4rb4LkyTmDzGRmKjMFWkoGsXTsYdrYGhAedoeoQZ9Gw2FDdhjPGYmuhTaXq
	LLAIbraiUCxQ+08BTCfHp/R15aDLI1AVBWvTo5QnRCo5NlWj0fFHpWxWteVMAjovRwU5qcKlCUs
	LsSsONdWYiyhspmwrSgzW+gpEfS8pBDl+jkJm/Rv6B+ElwpZoLqaTmXDopBc3jA4zkD9UZv3hBw
	Kf65WlT01N67F3RQhy33F2b/iy0K8DF4wQqh2XWnuKoX4ZakVz/OojdsV11cnJmqPya5vxxX1gK
	/iYgLNP0dCgMgTS/CkIE6DU6FsM2ypGhKhY7a5w9R1HYO9c4A4w1xIdo05/ltcH5EWGM6aa/znX
	cggr+0TBi1Ql2iPuEcehxB0efov6Zy6m+jUQWvW0+qlNPQ==
X-Received: by 2002:a17:90b:2e90:b0:3aa:548f:eb7d with SMTP id 98e67ed59e1d1-3aa548ff22emr28279a91.20.1791391046569;
        Wed, 07 Oct 2026 09:37:26 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.201.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9d94ef876sm262958a91.0.2026.10.07.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:37:24 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Karthikeyan KS <karthiproffesional@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] vhost-scsi: use FOLL_PIN for DMA page pinning
Date: Wed,  7 Oct 2026 16:37:16 +0000
Message-ID: <20261007163716.707102-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_map_to_sgl() pins guest buffer pages via
iov_iter_get_pages2() (FOLL_GET), which does not prevent
copy-on-write or page migration while DMA is in flight. Switch to
iov_iter_extract_pages() (FOLL_PIN), which does.

Cc: Jason Wang <jasowangio@gmail.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: virtualization@lists.linux.dev
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
 drivers/vhost/scsi.c | 49 ++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7a1f39a327da..e14b4da4ea9c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -115,6 +115,8 @@ struct vhost_scsi_cmd {
 	u32 tvc_sgl_count;
 	u32 tvc_prot_sgl_count;
 	u32 copied_iov:1;
+	u32 tvc_need_unpin:1;
+	u32 tvc_prot_need_unpin:1;
 	const void *read_iov;
 	struct iov_iter *read_iter;
 	struct scatterlist *sgl;
@@ -433,8 +435,13 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 
 			if (tv_cmd->copied_iov)
 				__free_page(page);
-			else
-				put_page(page);
+			else if (tv_cmd->tvc_need_unpin)
+				unpin_user_page(page);
+			/*
+			 * Else: iov_iter_extract_pages() took neither a ref
+			 * nor a pin on this page (ITER_KVEC/BVEC/etc), so
+			 * there is nothing to release here.
+			 */
 		}
 		kfree(tv_cmd->read_iter);
 		kfree(tv_cmd->read_iov);
@@ -443,8 +450,8 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 	if (tv_cmd->tvc_prot_sgl_count) {
 		for_each_sgtable_sg(&tv_cmd->prot_table, sg, i) {
 			page = sg_page(sg);
-			if (page)
-				put_page(page);
+			if (page && tv_cmd->tvc_prot_need_unpin)
+				unpin_user_page(page);
 		}
 		sg_free_table_chained(&tv_cmd->prot_table, vs->inline_sg_cnt);
 	}
@@ -773,7 +780,8 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, u64 scsi_tag)
 
 static void vhost_scsi_revert_map_iov_to_sgl(struct iov_iter *iter,
 					     struct scatterlist *curr,
-					     struct scatterlist *end)
+					     struct scatterlist *end,
+					     bool need_unpin)
 {
 	size_t revert_bytes = 0;
 	struct page *page;
@@ -782,7 +790,8 @@ static void vhost_scsi_revert_map_iov_to_sgl(struct iov_iter *iter,
 		page = sg_page(curr);
 
 		if (page) {
-			put_page(page);
+			if (need_unpin)
+				unpin_user_page(page);
 			revert_bytes += curr->length;
 		}
 		/* Clear so we can re-use it for the copy path */
@@ -812,9 +821,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	size_t offset;
 	unsigned int n, npages = 0;
 
-	bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
-				VHOST_SCSI_PREALLOC_UPAGES, &offset);
-	/* No pages were pinned */
+	bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
+				VHOST_SCSI_PREALLOC_UPAGES, 0, &offset);
+	/* No pages were extracted */
 	if (bytes <= 0)
 		return bytes < 0 ? bytes : -EFAULT;
 
@@ -837,7 +846,7 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
 			WARN_ONCE(true,
 				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
-			goto revert_iter_get_pages;
+			goto revert_iter_extract_pages;
 		}
 
 		sg_set_page(sg, pages[npages++], n, offset);
@@ -849,14 +858,17 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	*sgl = sg;
 	return npages;
 
-revert_iter_get_pages:
-	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
+revert_iter_extract_pages:
+	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg,
+			is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin);
 
 	iov_iter_revert(iter, bytes);
 	while (bytes) {
 		n = min_t(unsigned int, PAGE_SIZE, bytes);
 
-		put_page(pages[npages++]);
+		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
+			unpin_user_page(pages[npages]);
+		npages++;
 		bytes -= n;
 	}
 
@@ -926,6 +938,7 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	}
 
 	cmd->copied_iov = 1;
+	cmd->tvc_need_unpin = 0;
 	return 0;
 
 err:
@@ -950,11 +963,17 @@ vhost_scsi_map_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	struct scatterlist *sg = sg_table->sgl;
 	int ret;
 
+	if (is_prot)
+		cmd->tvc_prot_need_unpin = iov_iter_extract_will_pin(iter);
+	else
+		cmd->tvc_need_unpin = iov_iter_extract_will_pin(iter);
+
 	while (iov_iter_count(iter)) {
 		ret = vhost_scsi_map_to_sgl(cmd, iter, sg_table, &sg, is_prot);
 		if (ret < 0) {
 			vhost_scsi_revert_map_iov_to_sgl(iter, sg_table->sgl,
-							 sg);
+					sg, is_prot ? cmd->tvc_prot_need_unpin :
+						      cmd->tvc_need_unpin);
 			return ret;
 		}
 	}
@@ -1392,7 +1411,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		/*
 		 * If T10_PI header + payload is present, setup prot_iter values
 		 * and recalculate data_iter for vhost_scsi_mapal() mapping to
-		 * host scatterlists via get_user_pages_fast().
+		 * host scatterlists via iov_iter_extract_pages().
 		 */
 		if (t10_pi) {
 			if (v_req_pi.pi_bytesout) {
-- 
2.43.0

