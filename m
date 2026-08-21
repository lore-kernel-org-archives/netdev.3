Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249B43C7C2;
	Fri, 21 Aug 2026 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307838; cv=none; b=tWAfPJQk+lEwt9Gt+8opCe9F2hz16dvFSA8aWbOs2Xs9rkxLfAnSrAv4bostgOkrMmVdq4J3i8FXae0uZ5JQW6z5K99MfKh7Rh2QgPhR21BzDNnV//dRUAs0BJ0wCbeTJTmyZhbWs1Q3bk4Zw/Wml2xSxvDhPwQXPQr0+T7irm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307838; c=relaxed/simple;
	bh=gh3SUA5CTlaAPluasSiQAFVeqlPrxM5MQ3oaUEMNdos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G0gb8U2bH2+5pQxhoJ1EwZDDSpL4INWz0GtEhhTBtjKLTIIotz3kqKr23hK6PM+FkJDXvoTYfvyJodsNbiw0fy6T4RTzxQFE0uhQx3YUYOV7i4Ehc/W9zsLUipltZxkYN9cntIrP4Jy7IzXZrRtMgHxaJIT4AsAuXCQCRpi0haw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Io2J3Cv/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Io2J3Cv/"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9PwU04183906;
	Fri, 21 Aug 2026 03:23:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=50CKMx1RcgkaupuOqkSFoya
	htBcAjI2A6UBvEYxN9KM=; b=Io2J3Cv/acF36rJJ6EyFLZF1Zv1yuWO63Kx4Jdb
	zwMF+f+QPYBzWM88BpQaPzUVeTeyP+W7lxR/7YHsnnWwiNvFymz/YriMIORbFhp3
	kGMZ7bykbcXYgJxEmKZ5cpbksuRH3b5FSQ5dumQ/LENnakKBWQVpAD1v2KSgvDOX
	IHz3yYoibm2qkkOpKPxfx3yf2YRqWr4UfamvyqbBo90LtLw/P37EDDvaXO4HvcuN
	fx/mCllBFB78M/ATVe2K3++1WZSUkebG/ZPvEAhGoeEGT2GTbgcy81pxCfuNgXCC
	qGpKWTE3bpCixVmi3Z4zpgcYRuGnpPSa5UcvFLwEUn3oNNw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g6m1k0348-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 03:23:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 21 Aug 2026 03:23:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 21 Aug 2026 03:23:44 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 33B463F707F;
	Fri, 21 Aug 2026 03:23:40 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <saikrishnag@marvell.com>,
        <sbhatta@marvell.com>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net] octeontx2-af: fix cn20k mailbox lifetime on repeated rvu_mbox_init()
Date: Fri, 21 Aug 2026 15:53:37 +0530
Message-ID: <20260821102337.2989169-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UbVhjqSN c=1 sm=1 tr=0 ts=6a882731 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8 a=M5GUcnROAAAA:8
 a=XAvat4cOCnBk51Z9AM4A:9 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PKxU_iZmcm58UZPicAT8gn3ptFpalDyG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3NyBTYWx0ZWRfX5u2fFp6qVMYK
 Z4pJA+/zmDXQd4Cn6KWGDonWhSPDXjkMULlKK0Xxlb0JjOrFo6COC/Lsyb5PD+81iUkWIeazXXE
 9nc/5pJPNN0rNMm35mKQ4Bj2gj2x09SebAktFp9KEZziwfAqYjPtnDkEyc93RQcmT4SJ69FMURH
 al1OSWko4X96N6VYg9JUxzHpDoIy/gYSGAEGWvKJllHsmVPSNFBtw3hVoNny/7bGfvDBIWfiXYX
 qNGQox+WzBQh9mhbsZfLXYM845572UVTrjXnWJJ1jt5XLSwnUH0EhK7WloFjqT6Ml/9za9hMMLr
 0DsrBkb2Jvn/tRXDG00fHR9aTL4RXCUpp9KK3He99uwfQjfWIuScKNqTapGg1apkZReHRlb+RHZ
 e1iZs1ebZdKV0Sr1zKKvWKgVFomNDxuYv2dzRWrCSjrr/KAbqKVtYzwg0Nw9EcpjipanlgUvAss
 tO5dgCxzRaBOPut1GsA==
X-Proofpoint-ORIG-GUID: PKxU_iZmcm58UZPicAT8gn3ptFpalDyG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3NyBTYWx0ZWRfX0bbBS+G8yrqv
 kWPnRyn9uxHHIYvg/bWOOdPo2EDVg7ogpeGUgurjuvMWv/jMPdfzNfXwTx+4byHcOJpPurPqKx4
 EYFrUS8R2q81F6qc3NZ47ouKk2QOj7A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01

From: Sai Krishna <saikrishnag@marvell.com>

rvu_mbox_init() is called separately for AF-PF mailboxes during probe
and for AF-VF mailboxes when SR-IOV is enabled.  Each call used to
allocate a new ng_rvu object, leaking the first allocation when the
pointer was overwritten on the second call.

Sharing one ng_rvu across both paths exposed several teardown bugs:
the error path freed all cn20k mailbox DMA and kfree()d ng_rvu even
when only the failing init type should be unwound, leaving live AF-PF
mailbox memory in use after an AF-VF init failure.  mutex_init() was
also re-run on the AF-VF path while AF-PF mailbox handlers could still
hold rvu->mbox_lock.  Probe and SR-IOV failure paths did not release
cn20k mailbox DMA either, since cleanup only happened in rvu_remove().

Allocate ng_rvu once with devm_kzalloc(), initialize mbox_lock in the
same block, unwind only the mailbox memory for the failing init type,
and free cn20k mailbox DMA from the probe and pci_enable_sriov()
error paths.

Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2: Addressed sashiko comments
	https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260820053656.2614614-1-rkannoth%40marvell.com
---
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |  1 +
 .../marvell/octeontx2/af/cn20k/mbox_init.c    | 21 +++++++++-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 39 +++++++++++--------
 3 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
index 4285b5d6a6a2..f36a1d5f236f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
@@ -21,6 +21,7 @@ int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int num);
 int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 			       int num, int type, unsigned long *pf_bmap);
 void cn20k_free_mbox_memory(struct rvu *rvu);
+void cn20k_free_mbox_memory_type(struct rvu *rvu, int type);
 int cn20k_register_afpf_mbox_intr(struct rvu *rvu);
 int cn20k_register_afvf_mbox_intr(struct rvu *rvu, int pf_vec_start);
 void cn20k_rvu_enable_mbox_intr(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
index 71401dec0d77..01f32adac599 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
@@ -335,13 +335,30 @@ int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
 	return rvu_alloc_mbox_memory(rvu, type, ndevs, MBOX_SIZE);
 }
 
+void cn20k_free_mbox_memory_type(struct rvu *rvu, int type)
+{
+	if (!is_cn20k(rvu->pdev) || !rvu->ng_rvu)
+		return;
+
+	switch (type) {
+	case TYPE_AFPF:
+		qmem_free(rvu->dev, rvu->ng_rvu->pf_mbox_addr);
+		rvu->ng_rvu->pf_mbox_addr = NULL;
+		break;
+	case TYPE_AFVF:
+		qmem_free(rvu->dev, rvu->ng_rvu->vf_mbox_addr);
+		rvu->ng_rvu->vf_mbox_addr = NULL;
+		break;
+	}
+}
+
 void cn20k_free_mbox_memory(struct rvu *rvu)
 {
 	if (!is_cn20k(rvu->pdev))
 		return;
 
-	qmem_free(rvu->dev, rvu->ng_rvu->pf_mbox_addr);
-	qmem_free(rvu->dev, rvu->ng_rvu->vf_mbox_addr);
+	cn20k_free_mbox_memory_type(rvu, TYPE_AFPF);
+	cn20k_free_mbox_memory_type(rvu, TYPE_AFVF);
 }
 
 void cn20k_rvu_disable_afvf_intr(struct rvu *rvu, int vfs)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ffba56ee8a60..a0d535a1728e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2585,12 +2585,6 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	if (!pf_bmap)
 		return -ENOMEM;
 
-	ng_rvu_mbox = kzalloc_obj(*ng_rvu_mbox);
-	if (!ng_rvu_mbox) {
-		err = -ENOMEM;
-		goto free_bitmap;
-	}
-
 	/* RVU VFs */
 	if (type == TYPE_AFVF)
 		bitmap_set(pf_bmap, 0, num);
@@ -2604,15 +2598,22 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		}
 	}
 
-	rvu->ng_rvu = ng_rvu_mbox;
+	if (!rvu->ng_rvu) {
+		ng_rvu_mbox = devm_kzalloc(rvu->dev, sizeof(*ng_rvu_mbox), GFP_KERNEL);
+		if (!ng_rvu_mbox) {
+			err = -ENOMEM;
+			goto free_bitmap;
+		}
+
+		rvu->ng_rvu = ng_rvu_mbox;
 
-	rvu->ng_rvu->rvu_mbox_ops = &rvu_mbox_ops;
+		rvu->ng_rvu->rvu_mbox_ops = &rvu_mbox_ops;
+		mutex_init(&rvu->mbox_lock);
+	}
 
 	err = cn20k_rvu_mbox_init(rvu, type, num);
 	if (err)
-		goto free_mem;
-
-	mutex_init(&rvu->mbox_lock);
+		goto free_bitmap;
 
 	mbox_regions = kcalloc(num, sizeof(void __iomem *), GFP_KERNEL);
 	if (!mbox_regions) {
@@ -2702,14 +2703,18 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 free_regions:
 	kfree(mbox_regions);
 free_qmem:
-	cn20k_free_mbox_memory(rvu);
-free_mem:
-	kfree(rvu->ng_rvu);
+	cn20k_free_mbox_memory_type(rvu, type);
 free_bitmap:
 	bitmap_free(pf_bmap);
 	return err;
 }
 
+static void rvu_free_cn20k_mbox_memory(struct rvu *rvu)
+{
+	if (is_cn20k(rvu->pdev))
+		cn20k_free_mbox_memory(rvu);
+}
+
 static void rvu_mbox_destroy(struct mbox_wq_info *mw)
 {
 	struct otx2_mbox *mbox = &mw->mbox;
@@ -3519,6 +3524,7 @@ static int rvu_enable_sriov(struct rvu *rvu)
 	if (err) {
 		rvu_disable_afvf_intr(rvu);
 		rvu_mbox_destroy(&rvu->afvf_wq_info);
+		cn20k_free_mbox_memory_type(rvu, TYPE_AFVF);
 		return err;
 	}
 
@@ -3681,6 +3687,7 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_mbox:
 	rvu_mbox_destroy(&rvu->afpf_wq_info);
 err_hwsetup:
+	rvu_free_cn20k_mbox_memory(rvu);
 	rvu_cgx_exit(rvu);
 	rvu_fwdata_exit(rvu);
 	rvu_mcs_exit(rvu);
@@ -3723,9 +3730,7 @@ static void rvu_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 
 	devm_kfree(&pdev->dev, rvu->hw);
-	if (is_cn20k(rvu->pdev))
-		cn20k_free_mbox_memory(rvu);
-	kfree(rvu->ng_rvu);
+	rvu_free_cn20k_mbox_memory(rvu);
 	devm_kfree(&pdev->dev, rvu);
 	atomic_set(&device_bound, 0);
 }
-- 
2.43.0

