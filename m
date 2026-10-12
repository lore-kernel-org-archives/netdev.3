Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A474E0B6D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842951; cv=none; b=DpbOPBcYO9OwmIbUc7J3yApDXosw5ouFYhFoVFzUXCF3ESs2mEgM2RxNqwyNW0lupmSsfCckdt1jtVK+vKAP0Pp5Ih+ltoF6h+W4/SWeZP1zTJaK4yH5gwurcevcInkSgCszC07bPM9L2nwUgKNzgmOg1ulv/jnuNBKZPzZsVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842951; c=relaxed/simple;
	bh=Ibidnyhgdbxni11bwJ2ipMGe5f+QH/h4PEQvEvXqOHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkXsIG0TbEl0mrn0iH58PvkhKRAIaBdqZ9R50z+AlAKT0/91RT7mzCGe2HwuvdsYT/E5Ebo9mb6v6fWeZiGnjSlJ8e8D9hsUQVDwxYTnVwacATX5C97L4CtRn23nHilZ3uyGT3upGiVreccnJljaGc52nigH6eDc24J0U1l12u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aCS+fRDu; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aCS+fRDu"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-6de2f213b7aso945289eaf.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842948; x=1792447748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiKiEO9KQWB9z1FFyUy6LzzucEYjcysrYXV+VN95lLw=;
        b=OOptKzYwGRXk0Pso0NWWSGv59kf4VmFs8f4Odmdhu8lK/69vQGuZFGeELiiSR/0uQU
         faBJ1u63o85peOqDTrv88UK+yw65OCnJWfy5B7dtP9T+7i63vWToL/n7Q8hLmliumOBP
         8qpw64DM9l/xSJ3TS+kv4Pgcf3GZSCu2JeJhM6b7lt/UgDfQl+R4EwAak4BNIa0w9/74
         /YKaSa4cZ42ZPczA0Zamjzdhdoj9x4YyRGW5zzzKiPbAaIVthLlPqzykZ4QO9abZ6uQ7
         O8C5GfCk4FtXNOynLIC8bmvJSb0YnqxWMQs08LNwcrAbc4SUS6pPku3RwtpQ9/EjAsD4
         pZJw==
X-Gm-Message-State: AFq9FYJqpT7zo6VWDsOcxKf3/au/YLowjTl2reMTr6ZK+AZ4ohImRbRQ
	1ZNDIjyp6wOxQ2fS6ltFrx1Zp1wB42C1h+1JxVnxtV4UaWKx1PkT5g5uG3Fhv9LoHdhQ80Yqs5R
	GR+XT0asCgCXtzUBhCmjvOkeD3hW4jJENHWiwTpJeA7C0+S3aE3U+R6pVNAfSrvzCFRjX/Jy5SI
	i2YUBuqfRgHidHBwoVbuYpCmrI2TUsB87iJzOUbSvSFLg3FJ0RBK3hnlG0bkZUfzVMqf7YLuTsJ
	iRmg6hocQc=
X-Gm-Gg: AYBFou0VINiJKCltHi0Q60vjMLfSPkgdG6/wpz97IIglLghK+f16GTSfbf4njwYvyfT
	8oLCcSWfoeekLJDUHw9FQG5vFSOXQigMedFFGqf908j6J5JRaee9s6GFUz8wnv0zpFtfwZAUsod
	d77bmNARtGP4Ms6jZyCKbTbmlyaN4f6MfebB8qREzMFK7rqE/boo6uLHbaQKMHJ7BXoxUECha1v
	68L629TLfUCvTT+nwB7MK9qoOEvbIeuMwR3pRAXFtlL68ygCwrT3Hlu9zy2oV/3Lk/sfMPyqjPv
	M+NXt1Bhqq1lU0YpEUnYpQbB2hZJSiPgBxMQ6xn72k0RbKAj8toEr326xWKM9blO1Nb8B8d9AVM
	EbDlJTUzYtZ7Syo287+74/0OFioAIT2uFjek/z1wqybWKw2tc55uUrlFa862pEiDB2EEVUsrJ/3
	4rBJJtR+/hsPUGw1cw1j6LSqRhGGPWpGW26/GyRw==
X-Received: by 2002:a05:6820:160e:b0:6f6:61c5:d929 with SMTP id 006d021491bc7-6f661c5dceemr3302340eaf.38.1791842948433;
        Mon, 12 Oct 2026 15:09:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6f361a3d311sm118728eaf.8.2026.10.12.15.09.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 15:09:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c3c370b17so349822eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791842946; x=1792447746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DiKiEO9KQWB9z1FFyUy6LzzucEYjcysrYXV+VN95lLw=;
        b=aCS+fRDucwvWXJ9N1xyJ6UpppqCGpUaswf4N6vfx9/N4K5IR9aNk3jMtk7h8K/SrMJ
         lRJvszGt6nuC7zI3EGRvflScN3OUyu9H0ytO1uzEYPlpBPioEtBZ9sxMp/uWUq3hXpXn
         ouY1UD7PelHfhq5yY4aQ8/A0qSh5lLzP24bEs=
X-Received: by 2002:a05:701b:230c:b0:14a:51c8:ea06 with SMTP id a92af1059eb24-16a5fe7c17dmr16760534c88.29.1791842945629;
        Mon, 12 Oct 2026 15:09:05 -0700 (PDT)
X-Received: by 2002:a05:701b:230c:b0:14a:51c8:ea06 with SMTP id a92af1059eb24-16a5fe7c17dmr16760501c88.29.1791842944858;
        Mon, 12 Oct 2026 15:09:04 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm12483206c88.13.2026.10.12.15.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:09:04 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 1/7] bnxt_en: Clear bp->total_irqs in bnxt_init_int_mode() during error
Date: Mon, 12 Oct 2026 15:08:21 -0700
Message-ID: <20261012220827.340998-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261012220827.340998-1-michael.chan@broadcom.com>
References: <20261012220827.340998-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

During error, bnxt_init_int_mode() will free bp->irq_tbl but
bp->total_irqs retains the old value.  If a subsequent
reinitialization happens, bnxt_reserve_rings() may see that
bp->total_irqs does not match a new irqs_required.  It will then
try to adjust if dynamic MSI-X is supported and call
bnxt_change_msix().  It will then crash when dereferencing the NULL
bp->irq_tbl.

Fix it by clearing bp->total_irqs when freeing bp->irq_tbl.  Dynamic
MSI-X adjustments should only proceed if bp->irq_tbl is valid which
means that MSI-X has been initialized and can be adjusted.

Add a bp->irq_tbl_size to prevent OOB bp->irq_tbl[] array access in
case MSI-X capabilities change during re-init.  For dynamic MSI-X,
allocate the biggest bp->irq_tbl that is not clamped by CP/NQ rings
to allow dynamic MSI-X to grow to the max.

In the AER path, if MSI-X capabilities change, bnxt_reserve_rings()
will initialize MSI-X if BNXT_NEW_RM() is true.  Add a check in
bnxt_io_resume() to skip doing it again later.

Fixes: e68256c8a73c ("bnxt_en: Support dynamic MSIX")
Fixes: c2d20a3814d1 ("bnxt_en: delay pci_alloc_irq_vectors() in the AER path")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
Added an additional Fixes tag.

v2:
https://lore.kernel.org/netdev/20260928041712.3467803-2-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 18 ++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c1d3fcc7ae84..2bd2c039ce43 100644
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
@@ -11690,6 +11699,7 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
+	bp->irq_tbl_size = 0;
 }
 
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
@@ -11716,7 +11726,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 
 	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
 		irq_change = true;
-		if (!pci_msix_can_alloc_dyn(bp->pdev)) {
+		if (!pci_msix_can_alloc_dyn(bp->pdev) || !bp->irq_tbl) {
 			bnxt_ulp_irq_stop(bp);
 			bnxt_clear_int_mode(bp);
 			irq_cleared = true;
@@ -15080,7 +15090,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 			hwr.cp += bnxt_get_ulp_msix_num(bp);
 			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
 		}
-		if (hwr.cp > bp->total_irqs) {
+		if (bp->irq_tbl && hwr.cp > bp->total_irqs) {
 			int total_msix = bnxt_change_msix(bp, hwr.cp);
 
 			if (total_msix < hwr.cp) {
@@ -17743,7 +17753,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
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
-- 
2.51.0

