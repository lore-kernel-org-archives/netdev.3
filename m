Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520813;
	b=4k5BgGCUQjAi5N19uvZHC0p9Mv7nF+FbDVkI7JdGTrdvb1VFJg2cZwJ+fPRdRx7J02px
	 KqEucShMlaqzx7rGCfhHdMITeqUDFxelN2I5taIxg7po7HxVKQ3uWjqfS9th1ipU7caUL
	 AF2dzlmsGtOsCZyw6OaTBPPscsAL5+AIpFLaA1/LICtc4TvUI5uTmUx2BN8/pjAApZaoh
	 9v5tW3uS7POrta4866PX5vW2WNyMKPFOvuS1id/lTV+i5li7TO3cclZPc5996lzFtoJI5
	 PuocjVEGe0cpBzQp/TXgOkSYKEEdezRuLQapF1hwuIMbqT+MUU7umbQ2UQ6mUQH5q9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zzmCTlN2LKpQDlGX69irecctA25CCs8mwLmZ5GzVuOQ=;
	b=IP5ZaLJkMlsHBVGZTtHU/Pvnvor4Mxgsq2uiJbcrxOMO6OUPcm8HpZDUyniJtWFqCNOq
	 6GVf5FoKNRqb5UpHC80Y88qhT9tRL4E9iuYc3wUHMAFbPNoUmsFcYbc8CwVN1U+krdEW+
	 J5rMzxPJZBTMR3zVhaEXGl0N5TgkIggTYvXO3eWcnVOtZu85g0NPcck0PBv0N7lUA6bxH
	 IhtQdbO1fSbKAZTXsaGrr8V90cu5y7iD6UpY1dbpPvV4RYqs/Cw4OBgOZNl3b18nnlUTp
	 FKLgmwz4BYAKCEjxhEpcobWcCQj5vAmxucVtsra2Ook7MKB1pxQrZXWUAobw7njETng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fsom6qjs;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D9606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 18:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B4D9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fsom6qjs
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35f1f76ea84so6344987eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520812; x=1793125612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zzmCTlN2LKpQDlGX69irecctA25CCs8mwLmZ5GzVuOQ=;
        b=fsom6qjs9j+gTUdI/+x3+Gh68FRqWXehv4w7tWPmCte8tL+IdPkP8flEfDqEgglN4R
         pjghddV73hurJBcW0fgkySjmyIiIrY5+G4CPJb6cpsIw+ZDCyDCPosrdcZ7PhbNbiJ8y
         Hf+J333mq/VDsOCud9RSwn0Suv52NihGBdLl2CYJnOclv1DNVoFm0fw3Kvpr2Hfpk8uO
         XfN9QE9vYeNEDZfQ8x1+90Zpqm2mTSSZsiFM34XD9PWUTkoLJzshbFntrKQ982VchN2t
         mTMlB7U2+/5aWl6zvSEivRQtMCOZvlXG+4ZgBx5yHgO0jG7FchZE1bOuolCl4A+1hpKS
         fSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520812; x=1793125612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzmCTlN2LKpQDlGX69irecctA25CCs8mwLmZ5GzVuOQ=;
        b=VYo5q3sPO7mY0Sz38TzSzn+y3T+sQd9JMnSjnGUos7lFLrrQW+BTFeRd3Avl5tsRJx
         BiSH4Q3c+YUzHioRkHncb3inPA+Ez1D3JMsinKRJ6iNjTP3sQt8ZZIapxtfKSVD+pkQA
         81Bix4SK1Plm07/n3KewPOV1JnQ+lcFuh9kqwiTIj8R5m0e0zDrdofk64WcvV5o/eaxt
         ptKNzu/c4WaItXr8bv2Z0Ef475mfMCRyd9cEl3a4oHqdDQrBsmWBUkO9YHV03vmBwtwu
         G/cwUePakAmk+L5ymVHxXOX0Z0DNFETDcxsXACAaij7dfsItXb3sGG1VODxwiiYHJGcL
         3Uig==
X-Forwarded-Encrypted: i=1; AKwUvBwAtPiIdvi8VK3pxDq4qlPUQmpeNne6KhAl1HG3D4ZrkYvWBzkicEG97hi4ItSU5ijt7tRrA90=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc8LGJSZcHqd1BQ6XmIxO57Rd6M2jJ/9A6pFZc+OECsO4WFvtN
	a8DzR8S57GsLkLsDBkVf9xR0KL3q+02ZTV3Bj1TBVvKj/ajwrXw5L4gw
X-Gm-Gg: AYBFou3K6Bhf0i67Jp8g/zLwCMQ3nu79SgPFTh6ncnfcOUghUEoZyb9MbQQpn/yjUZi
	XH8NkEIvVZT8Aw1wpYWEXlgHiJs2TYY19J/6i6kqNUDLJmut19GEsTjJnxW5GnhMox74n4zMoes
	XlWwuxm3l3eYtr5pCfrXjTAc22CSHJE+F1hpAzVuIvacISXKprIYriTk7nFAHQ9ztGazebu5/Z3
	fQcnUrLMncVFLfpLuHSdGXa1WlKO0XqeiokHl/3mIBJDeB4/m/mjcnGZ4ftD4qTDXYwtrYKRIp0
	Ny2yJMoEHWt+3nDAsBBeTAsre8IeOmH86cSQDqXW8gWj1EsEdu3N0CT3lGWY6q8uIttFLl4j27o
	NfGrGv5MmsfNasPRLRnKUsw9sob3ur8S/6t3I7P27OXIdNXueiSrzXGE9o3hkHH/jb8LdHsm7YM
	Fwn4Vs5Tr4eCGxBHcKFgFZeESVBDOOG5X1FG63bxZeToyhYnI/cHIFH4keRHECfEz6jvs5gsEP7
	Qho0Rwy8mpVGW36yEvkaSIRtNr1ypcbVvsD65j0l1P6WSmCPCf1HkviV4j4XTD7Ho7EPdgmDgDn
	L3zmDBZTFdPbCTkXAgzCNR/uDJ3StAX02sikgUT6
X-Received: by 2002:a05:693c:87da:20b0:35e:9c54:d41b with SMTP id 5a478bee46e88-3674db4d065mr98253eec.21.1792520812113;
        Tue, 20 Oct 2026 11:26:52 -0700 (PDT)
Received: from LAPTOP-97G9G880.bbrouter ([106.51.148.253])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bd2a6sm549302eec.18.2026.10.20.11.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:26:51 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Cc: Karthikeyan KS <karthiproffesional@gmail.com>
Subject: [PATCH RESEND] vhost-scsi: use FOLL_PIN for DMA page pinning
Date: Tue, 20 Oct 2026 18:26:40 +0000
Message-ID: <20261020182640.2048506-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

