Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4E17D6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569196; cv=none; b=KVN/dNGaIMqmdkNf5fQ+bTCYOe9KgDG6g8o8OXWCczfs8VcyEZBepqDAvQmE1H+A4qwmzt4llq+r6KYk+TPkJhPUMdCjMLrppmaMgw8ZgWZpMn2MmhTvHI3Lf+4ontSUUmFL9pbAmmuICxtdez0phEui8xLNXdScLYd79Sbc25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569196; c=relaxed/simple;
	bh=upmfnbOOQ39YJsTyL6sV00WtOUbuJTyp1Igtkl7NSKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb5AhM8iW11wxD5AaFGcNWOOA1V/MYqwJioxAA97YOkWMgvSoUNX7SYPMJvOVI6BYqt3oeYtlf6cq32XH2zJlODabV5rG7o8bZ42NW1T+0gzgJ2zkurw/crE/wbqQWxJV94YPAR3XPk/NGVUXePg1J50+y1ArxnmPUEroqJLppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EEvj3YE/; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EEvj3YE/"
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7f84a55cc06so830705a34.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569194; x=1791173994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGcl7v0amKVwql+256fcZd55RQh1XGO/VXhPMAWKVbk=;
        b=poLT+uaFpDCqwNergF3CwAfYjkp4iW7TEVDmavtG2JyysOOrSrgdbogILAmITBbXQ5
         MwYaJKYno3Yw9LEPjjPDkhnp1PloLpAp2bGEbb3G0g4hKDYlSGZKTMBihBYP/Jm7+BN5
         /IC1Q4c3X+WlycpjPxb8f9sAHceU2RWdCyh2rWi/3cgdA6neInxLrxmjfrAZgKL3GeZt
         Lbty0/Q/5lTx76S7Ix/c+GFqVaHhH8q4adSAl1ek+vUDVfR+pl+lLT1KNsSlpIL4MHwn
         pOH6WHSkWpHPdOkhLf9jkNwdx3KSn0PRUV9Mc9e0tahPUT86oFZ7VXz0r07OVaJ6i88J
         Wrrw==
X-Gm-Message-State: AFq9FYKyjHdJgTAKz9jceN8hFAg0/h7Zk5DnePR1iX7SJpZ+ydSTJvpW
	wvZyS92W3cs424hxoIw3Pm0DqStiaMWoVI61QT/RpXR6HYIgN7zhlC6AD3YiCv5qqsWm38qvRz+
	xNmOui/Q2/mdQt9gfv4cXIkSs9lKoOyigLG8sGZiK01QdL+S0LaJ+3hh0Oillnu7Eh2CUeh9/G2
	mGxpQgfxmqXsmyx2+eSbKAzUYBZnKCsv4dsUq/ENoiUJIYS4SbZIJ0l7U7qWOPeIzqWJtITaxDG
	SZYhBOKK50=
X-Gm-Gg: AYBFou2M1/txOQ1jmzTJMCE4oGoZQhYCrdKT1d+Y5qMU7WhSrHtDzPhJ6AImd47GH6v
	GhnNazRpC6NUcUSGYBcJdkzoyr6iHlrs8bz6kMss52CrE3b4jgATk7r+W52+be67/xm+e9yP2ED
	f+L/thcbHyYL25Adq1Z/ZyPlqXCg4G9LEtcuxfWKlkS/14iS8mUPcph5zmNsByU61pH610PoL6C
	f1iIWhfyLUwrPLb01r10UdcEuFhVZz77yklc6P4tlg3y5bniUSpWxDlXoY9YLeeDAqLIkGbkUrx
	h5Xx+p2/0L/k+95flmUpfIN+2uNSb/VGbAK9lFFtR4OAl5U5sKieJqwSUThRRq9kP0IZam4LeI2
	Uto+T5iz1xuJWL+8cwsMnqhbsNCTKlN5zl8u/IV9f2/r9Jzk4uMFnwMhMssrs/B4ik/EzW0Eb+B
	eWh4uZ6Z7JcFjBbmgPkRl1W7WxT8+uQLhb0WI=
X-Received: by 2002:a05:6870:2184:b0:475:a1ec:961e with SMTP id 586e51a60fabf-491e69aa33dmr12452146fac.32.1790569193853;
        Sun, 27 Sep 2026 21:19:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4947f47f1c6sm410420fac.18.2026.09.27.21.19.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:19:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-147be78cd56so5456918c88.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569190; x=1791173990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGcl7v0amKVwql+256fcZd55RQh1XGO/VXhPMAWKVbk=;
        b=EEvj3YE/FXl1IEaqrZ1RHJ9kJM38rqtVPT2eDy3E6DCLRWCt24QIXODAlhsLfpDH3O
         9KTE3C59v2+Z0MkAbuUkOjoyuCn9jHuYbekEWkXM8uf1E6PxSleQb5v9oqgh74D08BV/
         anHc0+2cgLRT/N2v2YrwXUDXPkb0OYiHDUYW4=
X-Received: by 2002:a05:7022:b0c6:b0:142:d676:146a with SMTP id a92af1059eb24-146ce1aa654mr8703459c88.9.1790569190259;
        Sun, 27 Sep 2026 21:19:50 -0700 (PDT)
X-Received: by 2002:a05:7022:b0c6:b0:142:d676:146a with SMTP id a92af1059eb24-146ce1aa654mr8703418c88.9.1790569189560;
        Sun, 27 Sep 2026 21:19:49 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:19:49 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	joe@dama.to
Subject: [PATCH net v2 1/9] bnxt_en: Clear bp->total_irqs in bnxt_init_int_mode() during error
Date: Sun, 27 Sep 2026 21:17:04 -0700
Message-ID: <20260928041712.3467803-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928041712.3467803-1-michael.chan@broadcom.com>
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
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
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 18 ++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d7728d0c5b6e..51557ee6c9ad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11511,6 +11511,12 @@ static int bnxt_change_msix(struct bnxt *bp, int total)
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
@@ -11653,12 +11659,13 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 
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
@@ -11681,6 +11688,8 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 	netdev_err(bp->dev, "bnxt_init_int_mode err: %x\n", rc);
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
+	bp->total_irqs = 0;
+	bp->irq_tbl_size = 0;
 	pci_free_irq_vectors(bp->pdev);
 	return rc;
 }
@@ -11691,6 +11700,7 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
+	bp->irq_tbl_size = 0;
 }
 
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
@@ -11717,7 +11727,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 
 	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
 		irq_change = true;
-		if (!pci_msix_can_alloc_dyn(bp->pdev)) {
+		if (!pci_msix_can_alloc_dyn(bp->pdev) || !bp->irq_tbl) {
 			bnxt_ulp_irq_stop(bp);
 			bnxt_clear_int_mode(bp);
 			irq_cleared = true;
@@ -15081,7 +15091,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 			hwr.cp += bnxt_get_ulp_msix_num(bp);
 			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
 		}
-		if (hwr.cp > bp->total_irqs) {
+		if (bp->irq_tbl && hwr.cp > bp->total_irqs) {
 			int total_msix = bnxt_change_msix(bp, hwr.cp);
 
 			if (total_msix < hwr.cp) {
@@ -17692,7 +17702,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 			err = bnxt_open(netdev);
 		} else {
 			err = bnxt_reserve_rings(bp, true);
-			if (!err)
+			if (!err && !bp->irq_tbl)
 				err = bnxt_init_int_mode(bp);
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c673b2ce4a0d..a757d8258f71 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2490,6 +2490,7 @@ struct bnxt {
 	 */
 	unsigned long		*ring_affinity_set;
 	int			max_irqs;
+	int			irq_tbl_size;
 	int			total_irqs;
 	int			ulp_num_msix_want;
 	u8			mac_addr[ETH_ALEN];
-- 
2.51.0

