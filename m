Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35163A1D01
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233011; cv=none; b=i+N075XCuqi6TdBOBs5AqD2XzbrH0fz8x5Q9ttiEePICYsJIy4II0jqfLbGDwKNqzOg+FvGLRknEDWs7TQIxg5urLTUOuu2TG6ANgYuTOHFqS0bJiRHgOVLyizHUvAyQcNE2ba7248wYsLJDuiNKtKBqLZeQmxgTRdDu5gGkN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233011; c=relaxed/simple;
	bh=0BO0Y5O32K4Glka5lrXbxAAW/NxGcXbUlH2Zkk2m4vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvveVy1JbDq2r/DyiD6naM2GEVc3OZYSyroslHYXxIwD/yKP1iQtt7ENo1wjDeUwsbifkFMY6U84vhCcoE4RNFXelR5oaAoNykpROG7omkOk/dNEk7u7jFals+FoTvBj6YW7EHhdFTG7p6E8AKecJ4M3NR2kicNxJlMewt+Nxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gvoeLg5s; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gvoeLg5s"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso574036a91.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791233009; x=1791837809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlG1KaQFnT2GZoGLc6kYhBcq+PWeieteXuxWfdZnrwo=;
        b=NWFHGOhTjxHwIXizpfFYzU7BWN4JY53NSLQaRMrEGMu2xQBNKEfN+5+ec4r5iIS3sf
         uSzo9Zv2osserzuTX7X1uKY6gdZU1EmWsZZhh5vmRm3Z68lzd4wYKpjMQbF855V2kZZi
         BZZtTXYOAJ0/G6YUV/giyuk/OluvSq+18MrBgLY+QoaOqY+whx6ufsOK4xgcotIo3L2Z
         nbovBsKgRjvTvFvosfvHU4VA7mfmutn4ru568yPPhyCaFbBZG7d13o7d/UCOwY45IPl8
         p5t0FdTYlDNnszDetDqYsbYUBbED9KCth45RzspJCLSYyR4v/vjrAEVEHeOq+3deTPm/
         guHw==
X-Gm-Message-State: AFq9FYJvdID2RGkiYzLhC/eQ+FpH0Gr72erWqqroMM3B2PoTjsUIRpZN
	bHrDs5ddj8TRGpopgH1H7uW7hf4+CYqUJwawj6LJJJ/Zp9vcYlionoDMLXDffoeBmCAi66Jbtoy
	MrsrQINp0gu8pY8EDFh1plliebvIIJGqMrjiDwUS+s+B3PQp6skE1qUHjrN+58lVQL0lofD69Vl
	2nUtuDTiufFgdqfYflOZyUBEcdK2Jtj0Vex6ecBQZ5HmCN2honCkyBjCGI/T41RpS9i3jp7asUd
	W0K/pNw/3A=
X-Gm-Gg: AYBFou1LHXN7rRgAJ9mBVmmbHUcpeWeQoV0pZJIdT8cEZ7z68q6kUxWIEOzqcUpKYIj
	muIxnin45A5EUhqVCecTUzQGMO3lXTypeMNGK0150yzEcenDTK3ykRqrdtAczQajP8geqsITs1E
	Zt4/G+CSDGKjgc5UFpdWn/7EeKkBlRMmbe77fMWkSVJMPS2ccJnlsRv8G7DBnBwBkoT3kfhLEYr
	7Wm/zm7JIwdbVIoV5RSsUdWozK7h5MQSf0NLyUttvu3dOr3lIaekkiqNnlyayr2jEY2k7DGmeyd
	eZPa84Fz6Pw+Xuq02L6FEZM0W1uVnomFV3sl71bUScqD9v3hvu8V6/kyr3T0yFQQjOIkEyHKw8M
	Oo4WYcA6+TpG3UNdbZU9Eyw84Cxbq4BILSul6x1tcQtaCQVDfIPaBVAQr0M05HzYzfku6IBgiMP
	cVmWTXqiiBa0dYJP3G7DBcSdSMhjtFwzIG4S4=
X-Received: by 2002:a17:90b:4d85:b0:39e:d36c:ee54 with SMTP id 98e67ed59e1d1-3a6ce606acfmr11940327a91.5.1791233009212;
        Mon, 05 Oct 2026 13:43:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-ccb71bbd833sm1809624a12.2.2026.10.05.13.43.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:43:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90c8da50f8dso49993136d6.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791233008; x=1791837808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlG1KaQFnT2GZoGLc6kYhBcq+PWeieteXuxWfdZnrwo=;
        b=gvoeLg5slv7xuua6hy09EMzlb1nJMPuSLlsVjIsKPE3xI5P80d0aUBJWtXUE3pR1yI
         bFilbLsBOuUufiEQ2eNm7X4zONxCHHwuNdtI8/JuU5q3rSyR5NVpPbTyecz/j8I/rJXN
         mFkHYJEyx8rR7XAq6Q7vcn4QT/uBjxCoHnEBs=
X-Received: by 2002:a05:6214:2e4a:b0:919:860b:1cdc with SMTP id 6a1803df08f44-919860b1d51mr12649696d6.29.1791233007771;
        Mon, 05 Oct 2026 13:43:27 -0700 (PDT)
X-Received: by 2002:a05:6214:2e4a:b0:919:860b:1cdc with SMTP id 6a1803df08f44-919860b1d51mr12649326d6.29.1791233007167;
        Mon, 05 Oct 2026 13:43:27 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d593b457sm96914086d6.4.2026.10.05.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:43:26 -0700 (PDT)
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
Subject: [PATCH net v3 3/3] bnxt_en: Re-write the BARs following any type of PCIe errors
Date: Mon,  5 Oct 2026 13:42:46 -0700
Message-ID: <20261005204246.3822563-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261005204246.3822563-1-michael.chan@broadcom.com>
References: <20261005204246.3822563-1-michael.chan@broadcom.com>
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
enabled, so enable_cnt does not go unbalanced.  A concurrent
bnxt_fw_reset_task() can also be re-enabling the same device in its
ENABLE_DEV state, so guard that call the same way.

Fixes: f75d9a0aa967 ("bnxt_en: Re-write PCI BARs after PCI fatal error.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
Check that PCI is disabled before enabling it in bnxt_fw_reset_task().


v2:
Disable device before rewriting the BARs.
Improve error checking.

https://lore.kernel.org/netdev/20260928041712.3467803-10-michael.chan@broadcom.com/

v1: https://lore.kernel.org/netdev/20260831024342.2161156-5-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 107 ++++++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   1 -
 2 files changed, 60 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9ea7e172787e..5bd817479d64 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15547,7 +15547,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		if (test_and_clear_bit(BNXT_STATE_FW_ACTIVATE_RESET, &bp->state) &&
 		    !test_bit(BNXT_STATE_FW_ACTIVATE, &bp->state))
 			bnxt_dl_remote_reload(bp);
-		if (pci_enable_device(bp->pdev)) {
+		if (!pci_is_enabled(bp->pdev) && pci_enable_device(bp->pdev)) {
 			netdev_err(bp->dev, "Cannot re-enable PCI device\n");
 			rc = -ENODEV;
 			goto fw_reset_abort;
@@ -17608,10 +17608,8 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
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
@@ -17641,65 +17639,80 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
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
index c673b2ce4a0d..41d05efd6307 100644
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

