Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927613B6BF9
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133119; cv=none; b=ibvaQaV1bdoZerje4RRXwVfR3VS9DsR876Evx/Du21k8KOKe9ocwg94/+ghfFia1BVCU35RYqukcRqHVswPAdNdnns7O/RmyRD5ZRSW94WVtmi9xdfaxM0zsCstW/FBZjcI51i42+TSxjW7zoPiqwIse+THcxDYB1NgBeHcyqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133119; c=relaxed/simple;
	bh=MNDDEaMXwDqaAjuDvRRbbyikQsRSGWJtgyzz/iDzSjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4JoFoaZvQ/9hUjXLx9pLB6ZRUeNGV7AeOh9ylbtCBJmbP74vkURmX+MRSDk0V4GyX+JzgcskCLLoUaL0xmOpB80BL61iwhIv1/4gewOToo4dNWBYVFKuOzm8xMUnywRqIfSwrHGq3uURE4TWgUvMAOSCEYlrVOSxZIVZiJHj6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MFwXftQd; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MFwXftQd"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so2167637a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133116; x=1792737916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jNP3KNAyXLznusJNacuIWBjtx1HBqGd3rzjyEoPPL1I=;
        b=eS1RxDWHcH+8Rf8tYiZXkW3VxWt7tQbh3/Tivu78mbrhx5OKMELReDpjWoRXCI7Vwt
         2wwCLdHimm1zz4IBP1T6m5QfwYRR7MVoVUea96j37vpS9fCudO7DitgXpmrD02ycHU2V
         pMOX8bUmQnrdA2w5bccaj8Rh9cHu0xAusSYOckeM2Td0EqvVfkEaIK0zzBKb7AUXrECI
         QhXbI/C52lALVzcSr9gh+WTBGVRzqjtF6cxP73qwKmTUyYMoSvuEvbXrszxgUMQeZen0
         cZyinIEZ0m4Thih5+F819MtQSZtW7oJ38U0N4LHbR7iiwoxu77MmAaargmPJNKdHgt77
         1DnQ==
X-Gm-Message-State: AFq9FYLvnkjLffzUtEsKAVdKYxFDr4pdkxH1YfvA8BVW6wZxeqqhd6Gv
	y1RqoIByxUN64TiyNj9TBinlXmsGiByt5NtBFjLb1gzCavocdAJlC1Hs6io/JdFg7TeN1FoHjyw
	5tz9ah+5XF4R76hpSWm2cWhYRC5aAwYlC3Gt15wksKAT6Y1izmXAZnWqASLTVTHcSqvM4DSjaO+
	L0Lbk98/1KlsBPW9P7MXApCkPaBVsoac2y41me/9RNn7c2FkXILvBvlBGV5uE2DUTx98OfIlRIF
	X/IYM0psHY=
X-Gm-Gg: AYBFou0iNXuFpiL1w+RSsN8ByrePGp8kIsB6L8zOWxpdfSN2Rk3ybMeRBfwkyIQX7Wa
	saomTZ+VmzqvN3avlJ/MWTCPD/asIHNNLTbOs3E3FkGjIyYX6cZ4D0SaUWsLzlUUR/EJ+Mm8LzS
	7KDhCTR2kOX3CIEP+ngXNAoLyriN9N12kCIdqbjwV/zOsC84c1GYNlPmrHqMjHeR0hilOgFB0W1
	8+Paxh/qEtd/nZa5KsJQ1KbJ5jt2uA2CtRZuVQ/uDf4Ov7cvUGpP7CiH01eJzXDMxFJo/PCbd1M
	6OEdCWTyg0yjGjHQtLOwkAbgey/b6fhksxCAwvXU0arFj7sVASOeskbxWv4RzFpJRgRgYmtXTIK
	lYOrwLTdduw+iyzJkXJxuP/E7glIcphGud2SsbJMNb4+2YTQCVhnA7mRu0OdJiGE8vDDcAXPlJf
	UZIq74QECf82wh4ljpR8bHdKMD7+8PxLhErVcCnw==
X-Received: by 2002:a17:90b:5343:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3ab3a956dd3mr18890462a91.10.1792133115664;
        Thu, 15 Oct 2026 23:45:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acbee7ae31sm1267023a91.7.2026.10.15.23.45.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:45:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c5aef2a74so7689829eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792133114; x=1792737914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNP3KNAyXLznusJNacuIWBjtx1HBqGd3rzjyEoPPL1I=;
        b=MFwXftQd+QYQuZqDP+6LzfYGWcIBb35z9sS7HNQ7toCuxxmiCNumSUEaoI5Na+CT2i
         0q3lnvr3tk51lQhSU57OY2vcJAePIqJIMt+BHW2/CN8Hb+N7EZbZ/c6sf4QFvzQ1G1tq
         pkZ4RawtCxxyZje8Ow9ZU5KrUf8tKM4KX2yCQ=
X-Received: by 2002:a05:7022:3a83:b0:181:83c:5df8 with SMTP id a92af1059eb24-181083c5e69mr7030267c88.11.1792133108678;
        Thu, 15 Oct 2026 23:45:08 -0700 (PDT)
X-Received: by 2002:a05:7022:3a83:b0:181:83c:5df8 with SMTP id a92af1059eb24-181083c5e69mr7030213c88.11.1792133107952;
        Thu, 15 Oct 2026 23:45:07 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm3791401c88.0.2026.10.15.23.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:45:07 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 1/8] bnxt_en: Clear bp->total_irqs when disabling IRQs
Date: Thu, 15 Oct 2026 23:44:20 -0700
Message-ID: <20261016064427.496944-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016064427.496944-1-michael.chan@broadcom.com>
References: <20261016064427.496944-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

bnxt_init_int_mode() and bnxt_clear_int_mode() will free bp->irq_tbl
but bp->total_irqs retains the old value.  If a subsequent
reinitialization happens, bnxt_reserve_rings() may see that
bp->total_irqs does not match a new irqs_required.  It will then
try to adjust if dynamic MSI-X is supported and call
bnxt_change_msix().  It will then crash when dereferencing the NULL
bp->irq_tbl.

Fix it by clearing bp->total_irqs when freeing bp->irq_tbl.  Dynamic
MSI-X adjustments should only proceed if bp->irq_tbl is valid which
means that MSI-X has been initialized and can be adjusted.
bnxt_ulp_irq_restart() also needs a similar check.

Add a bp->irq_tbl_size to prevent OOB bp->irq_tbl[] array access in
case MSI-X capabilities change during re-init.  For dynamic MSI-X,
allocate the biggest bp->irq_tbl that FW supports without clamping it
with maximum CP/NQ rings to allow dynamic MSI-X to grow to the max.

In the AER path, if MSI-X capabilities change, bnxt_reserve_rings()
will initialize MSI-X if BNXT_NEW_RM() is true.  Add a check in
bnxt_io_resume() to skip doing it again later.

Fixes: e68256c8a73c ("bnxt_en: Support dynamic MSIX")
Fixes: c2d20a3814d1 ("bnxt_en: delay pci_alloc_irq_vectors() in the AER path")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4:
Clear bp->total_irqs in bnxt_clear_int_mode() to fix a possible NULL
bp->irq_tbl issue reported by Sashiko and Gregory Price on patch #8.

v3:
Added an additional Fixes tag.

https://lore.kernel.org/netdev/20261012220827.340998-2-michael.chan@broadcom.com/

v2:
https://lore.kernel.org/netdev/20260928041712.3467803-2-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  2 +-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c1d3fcc7ae84..19b4d3b92352 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11510,6 +11510,12 @@ static int bnxt_change_msix(struct bnxt *bp, int total)
 	struct msi_map map;
 	int i;
 
+	if (!bp->irq_tbl)
+		return 0;
+
+	if (total > bp->irq_tbl_size)
+		return bp->total_irqs;
+
 	/* add MSIX to the end if needed */
 	for (i = bp->total_irqs; i < total; i++) {
 		map = pci_msix_alloc_irq_at(bp->pdev, i, NULL);
@@ -11652,12 +11658,13 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 
 	tbl_size = total_vecs;
 	if (pci_msix_can_alloc_dyn(bp->pdev))
-		tbl_size = max;
+		tbl_size = bp->hw_resc.max_irqs;
 	bp->irq_tbl = kzalloc_objs(*bp->irq_tbl, tbl_size);
 	if (!bp->irq_tbl) {
 		rc = -ENOMEM;
 		goto msix_setup_exit;
 	}
+	bp->irq_tbl_size = tbl_size;
 
 	for (i = 0; i < total_vecs; i++)
 		bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
@@ -11680,6 +11687,8 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 	netdev_err(bp->dev, "bnxt_init_int_mode err: %x\n", rc);
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
+	bp->total_irqs = 0;
+	bp->irq_tbl_size = 0;
 	pci_free_irq_vectors(bp->pdev);
 	return rc;
 }
@@ -11690,6 +11699,8 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
+	bp->total_irqs = 0;
+	bp->irq_tbl_size = 0;
 }
 
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
@@ -11716,7 +11727,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 
 	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
 		irq_change = true;
-		if (!pci_msix_can_alloc_dyn(bp->pdev)) {
+		if (!pci_msix_can_alloc_dyn(bp->pdev) || !bp->irq_tbl) {
 			bnxt_ulp_irq_stop(bp);
 			bnxt_clear_int_mode(bp);
 			irq_cleared = true;
@@ -15080,7 +15091,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 			hwr.cp += bnxt_get_ulp_msix_num(bp);
 			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
 		}
-		if (hwr.cp > bp->total_irqs) {
+		if (bp->irq_tbl && hwr.cp > bp->total_irqs) {
 			int total_msix = bnxt_change_msix(bp, hwr.cp);
 
 			if (total_msix < hwr.cp) {
@@ -17743,7 +17754,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 			err = bnxt_open(netdev);
 		} else {
 			err = bnxt_reserve_rings(bp, true);
-			if (!err)
+			if (!err && !bp->irq_tbl)
 				err = bnxt_init_int_mode(bp);
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 41d05efd6307..75428a585577 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2489,6 +2489,7 @@ struct bnxt {
 	 */
 	unsigned long		*ring_affinity_set;
 	int			max_irqs;
+	int			irq_tbl_size;
 	int			total_irqs;
 	int			ulp_num_msix_want;
 	u8			mac_addr[ETH_ALEN];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index a515c368bac0..9b7bc508fae7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -396,7 +396,7 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 		if (!ops || !ops->ulp_irq_restart)
 			return;
 
-		if (!err) {
+		if (!err && bp->irq_tbl) {
 			ent = kzalloc_objs(*ent, ulp->msix_requested);
 			if (!ent)
 				return;
-- 
2.51.0

