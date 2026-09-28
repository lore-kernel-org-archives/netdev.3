Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37C2D29C8
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569209; cv=none; b=KnSkAIIgtRrvS8VCJSQV5+uH4R0RskPExHr5ASWD8PcELunYtqbdAYAHsbKPBUZWa/62r7/4obtsBT8dBmCUt0PW8P4K1ZUwOC7S26jpY6bVYnPholr+bwPLbUOyePN2JY8XRcj3XH/1btnnDPIkdVz5lt8AHihfusd8JTBok1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569209; c=relaxed/simple;
	bh=afSr8oAzITUGfUOoulqy4HOjzf2jM32UQDGDILksJK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI1ZQ6t8W0LTR0Myk+fzFxmv4DnGuverGMZAHFyrFX1QvIerXiirY8EYw8bRnre6DAivtBltfzoMgfQndQirdKxnqSFFU5gz+z07/nmYj0micO95uixZVPvljYbjl/diAiGKwHj/QqY9/6txSHRcrZ9dSaLdaplGUfSfp+Ruaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sv1hhcDO; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sv1hhcDO"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2e12db20e65so2481395ad.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569207; x=1791174007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zo/wXgFZCwNTXSmMVxZX+JZIQ9AhxQpMictI0nChL4A=;
        b=Bn8hL2Gb9bgRseVuc6MVIUocYPs8cxv8zJnkYtiz7TjBB0GLioX5QmivjnV49FDmQm
         zb+JEzX1PaNvIFLRbPU3pUcVmqo+UkRQIPKi5wts0ZEhInqh0D2/w8INY8lZmrDBFmnK
         NHA1GEvJCK+oLZZSX1Q1OA2OzlYGiB7RG8OMgrqNtvudonZMnbOQmmHL9ttGG0PeBkq6
         Zw8wJhajYh32PaAtaMGZR63ynUv5BbALSNkwhbw7QHVyAGPmEu7qGdLrzaeZqJDptNnl
         dioATJ/3enrfKPRuSiVaguCETTlAPQnzIqcTMrNtFW9UlEfb1MMO5CExdvcWtNiC29xM
         iX9g==
X-Gm-Message-State: AFuF++mqA9vFQ8ztWtmwMORoVJ0v/cVkm56d0MhwhCWa/dOS7gayrF+3
	u8rnB6X/3kbwTKwSvamvSlZObkeXcxKQuAZu9IU76me5bF4+cTrKcmI5S3asoCU5OTn8lde3kZm
	OrFiIGfGfX6SKYHD+dt47kW/pW5vqlUaMkQrw07at+BeJkzuMfkj3+/0zuUA8SAVsHZUtZUuErJ
	4enBAa/nv57zZoqIK0J0pW4+YTk9FYT9OvCfoelcQF3kiFzrRPSX8YxSCqAv+PlKqHHQyXnZf2p
	U6uOS57E4I=
X-Gm-Gg: AYBFou0kdNJNIceD8778TxEmov0KScJ4NrAkF20GLQ3Zh+ibueaeNBnGxlCoE/+PVc/
	DY2D9Eu+U3cpu2sIobfuiSKpFyJif9yLzt+XRrIri34y1S+DcC4rRgjh0lSysDIwc5QOrCXxd85
	zmfllMsxpIMsRSmL3ZI17CXTakgVoZfp+b2D0RS3e8HCI24pDLKa5HsY2W1Wu++p/J/QjlnL9DA
	0t660L1F5T3JjtrnE7gbjGaZ1pxjGbvQEksJe02bYRitq25mgGlSs56L4xty+mBE4lIg74B6GuA
	6qi7UrRUUXBdeN6d0qIDLz3ubzEKsNsRPDlDpl992e321jWrnNwgbK4Er8/pc67mqtvfJHsIFUE
	eNr0gy9eH1MEmKrVTXygXzN9l9S99YWMTMVZJQKaw0rWm5RlXfH+yZIIXWiZQPay9KipTMM8ONX
	J/WUGe0qqV4ov1hulpT9D1U77FQSMxprFPQO4=
X-Received: by 2002:a05:6a21:e104:b0:3bf:63af:855 with SMTP id adf61e73a8af0-3de0e725c25mr10886418637.1.1790569206962;
        Sun, 27 Sep 2026 21:20:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc7877bc2f9sm6102950a12.10.2026.09.27.21.20.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:20:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1384427c3efso3915467c88.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569205; x=1791174005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zo/wXgFZCwNTXSmMVxZX+JZIQ9AhxQpMictI0nChL4A=;
        b=Sv1hhcDO67Z8ym4C/01LpjXud6W37zrXrAPTbgHU9vA0YfbHWi1EFvnqKQ3Bgt8N8A
         lGoWPsLRpU7bxZK2r0F1j4/+G08hk8FokgCqDp1/WMKTw8n3RoHck4mvEy3uzOEb8Qm4
         tQ8JdhOjjJvpJW2WtDKaUTf2U5IMtwKpnnCTM=
X-Received: by 2002:a05:701b:4546:20b0:138:507b:30fd with SMTP id a92af1059eb24-146ce2a1e62mr7596649c88.6.1790569205005;
        Sun, 27 Sep 2026 21:20:05 -0700 (PDT)
X-Received: by 2002:a05:701b:4546:20b0:138:507b:30fd with SMTP id a92af1059eb24-146ce2a1e62mr7596617c88.6.1790569204257;
        Sun, 27 Sep 2026 21:20:04 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:20:03 -0700 (PDT)
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
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH net v2 9/9] bnxt_en: Re-write the BARs following any type of PCIe errors
Date: Sun, 27 Sep 2026 21:17:12 -0700
Message-ID: <20260928041712.3467803-10-michael.chan@broadcom.com>
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

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Currently the driver zeroes the BARs only when fatal PCIe errors
are reported so that pci_restore_state() restores it.  However
firmware handles both fatal and non-fatal errors the same way when
it sees the slot reset resulting from the PCI_ERS_RESULT_NEED_RESET
return code from the driver.  This means that we must re-write the
BARs post recovery even during non-fatal errors.  Otherwise we will
see that every MMIO access returns all-ones and the firmware appears
dead.

Zero-out the BARs during PCIe error recovery regardless of type of
PCIe error, and make the wait after the hot reset unconditional.

Disable memory decode and bus mastering before rewriting the BARs so
the device doesn't decode a half-updated address, bailing out if
config space is still inaccessible.  Defer pci_enable_device() until
after the BAR rewrite and restore, so the device isn't re-enabled
while its BARs are still being rewritten, then re-enable the device
and re-assert bus mastering.  Guard the same Command register cleanup
on the re-enable failure path against an inaccessible device.

Skip re-enabling the device in bnxt_io_slot_reset() if it is already
enabled, so enable_cnt does not go unbalanced.

Fixes: f75d9a0aa967 ("bnxt_en: Re-write PCI BARs after PCI fatal error.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2:
Disable device before rewriting the BARs.
Improve error checking.

v1: https://lore.kernel.org/netdev/20260831024342.2161156-5-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 105 ++++++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   1 -
 2 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e4530b091d3b..810219d9cae2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17710,10 +17710,8 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 	 * so we disable bus master to prevent any potential bad DMAs before
 	 * freeing kernel memory.
 	 */
-	if (state == pci_channel_io_frozen) {
-		set_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state);
+	if (state == pci_channel_io_frozen)
 		bnxt_fw_fatal_close(bp);
-	}
 
 	if (netif_running(netdev))
 		__bnxt_close_nic(bp, true, true);
@@ -17743,65 +17741,80 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 	struct bnxt *bp = netdev_priv(netdev);
 	int retry = 0;
 	int err = 0;
+	u16 cmd;
 
 	netdev_info(bp->dev, "PCI Slot Reset\n");
 
-	if (test_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state)) {
-		/* After DPC, the chip should return CRS when the vendor ID
-		 * config register is read until it is ready.  On all chips,
-		 * this is not happening reliably so add a 5-second delay as a
-		 * workaround.
-		 */
-		msleep(5000);
-	}
+	/* After a PCIe hot reset, the chip should return CRS when the
+	 * vendor ID config register is read until it is ready.  On all
+	 * chips, this is not happening reliably so add a 5-second delay
+	 * as a workaround.
+	 */
+	msleep(5000);
 
 	netdev_lock(netdev);
 
-	if (pci_enable_device(pdev)) {
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (PCI_POSSIBLE_ERROR(cmd)) {
 		dev_err(&pdev->dev,
-			"Cannot re-enable PCI device after reset.\n");
-	} else {
-		pci_set_master(pdev);
-		/* Upon fatal error, our device internal logic that latches to
-		 * BAR value is getting reset and will restore only upon
-		 * rewriting the BARs.
-		 *
-		 * As pci_restore_state() does not re-write the BARs if the
-		 * value is same as saved value earlier, driver needs to
-		 * write the BARs to 0 to force restore, in case of fatal error.
-		 */
-		if (test_and_clear_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN,
-				       &bp->state))
-			bnxt_clear_bars(pdev);
-		pci_restore_state(pdev);
+			"PCI config space inaccessible after reset\n");
+		goto reset_exit;
+	}
 
-		bnxt_inv_fw_health_reg(bp);
-		bnxt_try_map_fw_health_reg(bp);
+	/* Upon PCIe error, our device internal logic that latches to
+	 * BAR value is getting reset and will restore only upon
+	 * rewriting the BARs.
+	 *
+	 * As pci_restore_state() does not re-write the BARs if the
+	 * value is same as saved value earlier, driver needs to
+	 * write the BARs to 0 to force restore.
+	 */
+	pci_clear_master(pdev);
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	cmd &= ~PCI_COMMAND_MEMORY;
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 
-		/* In some PCIe AER scenarios, firmware may take up to
-		 * 10 seconds to become ready in the worst case.
-		 */
-		do {
-			err = bnxt_try_recover_fw(bp);
-			if (!err)
-				break;
-			retry++;
-		} while (retry < BNXT_FW_SLOT_RESET_RETRY);
+	bnxt_clear_bars(pdev);
+	pci_restore_state(pdev);
 
-		if (err) {
-			dev_err(&pdev->dev, "Firmware not ready\n");
-			goto reset_exit;
+	if (!pci_is_enabled(pdev) && pci_enable_device(pdev)) {
+		dev_err(&pdev->dev,
+			"Cannot re-enable PCI device after reset.\n");
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		if (!PCI_POSSIBLE_ERROR(cmd)) {
+			cmd &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+			pci_write_config_word(pdev, PCI_COMMAND, cmd);
 		}
+		goto reset_exit;
+	}
+	pci_set_master(pdev);
 
-		err = bnxt_hwrm_func_reset(bp);
+	bnxt_inv_fw_health_reg(bp);
+	bnxt_try_map_fw_health_reg(bp);
+
+	/* In some PCIe AER scenarios, firmware may take up to
+	 * 10 seconds to become ready in the worst case.
+	 */
+	do {
+		err = bnxt_try_recover_fw(bp);
 		if (!err)
-			result = PCI_ERS_RESULT_RECOVERED;
+			break;
+		retry++;
+	} while (retry < BNXT_FW_SLOT_RESET_RETRY);
 
-		/* IRQ will be initialized later in bnxt_io_resume */
-		bnxt_ulp_irq_stop(bp);
-		bnxt_clear_int_mode(bp);
+	if (err) {
+		dev_err(&pdev->dev, "Firmware not ready\n");
+		goto reset_exit;
 	}
 
+	err = bnxt_hwrm_func_reset(bp);
+	if (!err)
+		result = PCI_ERS_RESULT_RECOVERED;
+
+	/* IRQ will be initialized later in bnxt_io_resume */
+	bnxt_ulp_irq_stop(bp);
+	bnxt_clear_int_mode(bp);
+
 reset_exit:
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	bnxt_clear_reservations(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a757d8258f71..75428a585577 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2468,7 +2468,6 @@ struct bnxt {
 #define BNXT_STATE_ABORT_ERR	5
 #define BNXT_STATE_FW_FATAL_COND	6
 #define BNXT_STATE_DRV_REGISTERED	7
-#define BNXT_STATE_PCI_CHANNEL_IO_FROZEN	8
 #define BNXT_STATE_NAPI_DISABLED	9
 #define BNXT_STATE_FW_ACTIVATE		11
 #define BNXT_STATE_RECOVER		12
-- 
2.51.0

