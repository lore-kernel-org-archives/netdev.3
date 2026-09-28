Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF0357D0A
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569208; cv=none; b=n1q/BRU2V0DUw/g8Bbj/3WHlkljlsxqU+diN+J5T3/GQ/w5d6op7ZByPov6fCMmXq3YILI9CAikkVcrnTihxmGjipJwpvwDupIisLu4B/1YLlfq5p6I3ij8GZi6gCAskO5AbVTqbe3g2g6+xNLnBEUizLB/4Z4BqMmEnryQru48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569208; c=relaxed/simple;
	bh=SJbbbpz+8dBIIJ5qPR3uLzMOIzuUPFXUx1mWDAQVjac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAWdkLxDm8Ouf72QNDBbVsfy0z0PrcgoQupBl/iU6bcm/taPPkjUFYKOIgCt+4uRR+vkxGKUTheTjqYK6CpcN6hyTmuwCfIS09iCK+wdWZeE5F0+TlACpPmLRYiwmN/F3OPeb73LthJLZ5K72qjwisK5NMtzNszesjylD61vUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cJZBJMFI; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cJZBJMFI"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2dd4b3c752fso15548815ad.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569206; x=1791174006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OponxOyw1h8rELenxyhTE0PoKwNVtmigypiSkTASJRY=;
        b=LmlbYg0ha+1YTxR0ytLG+xTeILYrtFf+Tg9BuL3/tJIolVP0zVli1UDnRRY6DG4zKT
         NzFfRUQnhrZPQBwx/4krnJdbL4p/p3h17LvzEAGqgRYRTOa5NWRxjMLPip4aIZ/O7bv5
         p3IpD+NQ7KY0rOoq/01eyJlb4SQI8+kuESxL6FCLlZne16zL2AGDvgvKfYdpjds5e/O1
         xYgTWsnhCq6XOhjJ8nEk7FFgjPlIbu3nSMY3EmI3Vx6zRe9r0rxYFkMQ+P/Z9nzCrwPE
         NLlZeBbekmSwOibia2ocYs5VpuJ/xZzighD3YGxH3B02SF9+Ra5h7doR0yRrfJRaPYob
         XL3A==
X-Gm-Message-State: AFq9FYJ42iLhxTsPjhdPkyZAFTa+Wp5TOaBbHR4vw04OatZGKV800Pna
	nP2rAaYIG3ni6v9nIa5bHCWCHKZnjUGxnvE5NaBfNrR5foJaR0Rxj6mUQc4dvuDKRLg0a84vxgI
	gX/1gOB5dxbi1k+JWVrryp9GbMOXAPNuEOPw2VpYUSL2Evyl32Ub6nyej6Sqhvx3wZxPQcetRtd
	cdcTfbmxjdnaMMCDPElOTe1/qXaVs1xJaYLrpuThpOT5qKRkyoW/qErEsGsK8zCrzOeWyPsq678
	e2XdRcE4/M=
X-Gm-Gg: AYBFou3c6I7ZdzT7fWBGqXclw0tMcWQpb6loJQfZpyYSQDBbUi0pe1+JsP9W6WrbMg+
	JDemrzOEmLB2JM+67XggSeCNWwNNTVjoebb99TG56ux/VPXRRvtDemnGtVw5rfU5NVyEWcj9XaQ
	xVlk87DQ+rhsTUqfWER6l2aT81/aSem+qE3JHVUlOrpm2T7vheT4YGg5CTAzumVdJFO0Zp/LVdP
	uX17IG97nzGoxhPy2qUVqJD2Wyw0ZIoJ26oHoXjVMy6ZASKoQ9JO//B/e5HqzF4kcJFTakt0zXa
	KMKhOR8pPOehzjNWkDgtmeyOLK0Cad9yOFWxwoYO0GHogeKWhn5JbsyoQaUDDjajxeHpdNsA45U
	zGk3VP/RbKfNK3BfFCa5NbTQ9wizcqOQEA1nmUcOvPSKOFjJs6zeEn+xIjhLQQ2ISP00nmmnUl6
	tylRFPL9P6DrZSYralpk2rMHY0uphdoMLYNavvAw==
X-Received: by 2002:a17:90b:3b4c:b0:3a4:6b54:863f with SMTP id 98e67ed59e1d1-3a46b548711mr1203102a91.41.1790569205892;
        Sun, 27 Sep 2026 21:20:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a0b4f780f6sm611490a91.1.2026.09.27.21.20.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:20:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1466ab2bc8dso1647984c88.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569204; x=1791174004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OponxOyw1h8rELenxyhTE0PoKwNVtmigypiSkTASJRY=;
        b=cJZBJMFId8JxHBlNSQ9Qzetcj37l1T6bh7nrEmpm6XJ1iVNDJCrgKaIHioGQMjQlXM
         qQLHlt6XQoI5HoUPdyqbYU12AkooKwzcd5tdSmEv32EbTwV+AHXSqcuySqmUB4e1YWHF
         COZtbHa3iGyEysnOoCiYJhM84a6pfYCWfgCfA=
X-Received: by 2002:a05:701b:420f:20b0:13b:3c84:ef77 with SMTP id a92af1059eb24-146ced41605mr9322650c88.20.1790569203477;
        Sun, 27 Sep 2026 21:20:03 -0700 (PDT)
X-Received: by 2002:a05:701b:420f:20b0:13b:3c84:ef77 with SMTP id a92af1059eb24-146ced41605mr9322612c88.20.1790569202756;
        Sun, 27 Sep 2026 21:20:02 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:20:01 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	joe@dama.to,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net v2 8/9] bnxt_en: Fix driver init in kdump kernel
Date: Sun, 27 Sep 2026 21:17:11 -0700
Message-ID: <20260928041712.3467803-9-michael.chan@broadcom.com>
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

Fix and strengthen the FLR sequence when initializing in the kdump
kernel.  If the NIC is behind a PCIe switch in synthetic (smart)
mode, the switch may need to see that the BARs have been initialized
before it will pass mem read/write TLPs to the NIC.

Add a new bnxt_kdump_reset() to do the expanded FLR sequence in the
kdump kernel.  We now disable bus master and memory, save the PCI
state, do the FLR, clear the BARs, and restore the PCI state.  The
BARs have to be cleared to ensure that they get re-initialized and
visible to the PCIe switch.

Since it is the kdump kernel, we make every effort to continue in
the best possible way even if the device is unresponsive after FLR
or we encounter other errors.

To avoid dealing with a possible 0xffff value for the MSI-X capabilty
register after FLR, we call bnxt_get_max_irq() to get the valid
number of MSIX before we do the FLR.

Fixes: 8743db4a9acf ("bnxt_en: Issue PCIe FLR in kdump kernel to cleanup pending DMAs.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2:
Disable device before pci_save_state() and pcie_flr() and check for
errors. 

v1:
https://lore.kernel.org/netdev/20260831024342.2161156-4-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 48 +++++++++++++++++++----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8c6bf10aba8a..e4530b091d3b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17229,6 +17229,42 @@ static void bnxt_clear_bars(struct pci_dev *pdev)
 		pci_write_config_dword(pdev, off, 0);
 }
 
+/* Clear any pending DMA transactions from crash kernel while loading driver in
+ * capture kernel.
+ */
+static void bnxt_kdump_reset(struct pci_dev *pdev)
+{
+	u16 cmd;
+	int rc;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	cmd &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	if (pci_save_state(pdev))
+		dev_warn(&pdev->dev, "Failed to save PCI state, PCI restore may be incomplete\n");
+
+	/* Since it is kdump kernel, try to continue in the best possible way
+	 * even if the device is unresponsive after FLR.  The device may
+	 * eventually respond to HWRM_VER_GET later in the init sequence.
+	 */
+	rc = pcie_flr(pdev);
+	if (rc)
+		dev_warn(&pdev->dev, "pcie_flr() failed (rc: %d), trying to continue\n",
+			 rc);
+
+	/* A complete or partial reset has been done.  Clear the BARs
+	 * if the device is responsive.
+	 */
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (PCI_POSSIBLE_ERROR(cmd))
+		dev_warn(&pdev->dev, "PCI config space inaccessible after FLR, not clearing BARs\n");
+	else
+		bnxt_clear_bars(pdev);
+
+	pci_restore_state(pdev);
+}
+
 static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct bnxt_hw_resc *hw_resc;
@@ -17244,15 +17280,11 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENODEV;
 	}
 
-	/* Clear any pending DMA transactions from crash kernel
-	 * while loading driver in capture kernel.
-	 */
-	if (is_kdump_kernel()) {
-		pci_clear_master(pdev);
-		pcie_flr(pdev);
-	}
-
 	max_irqs = bnxt_get_max_irq(pdev);
+
+	if (is_kdump_kernel())
+		bnxt_kdump_reset(pdev);
+
 	dev = alloc_etherdev_mqs(sizeof(*bp), max_irqs * BNXT_MAX_QUEUE,
 				 max_irqs);
 	if (!dev)
-- 
2.51.0

