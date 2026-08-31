Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB239CCE9
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144280; cv=none; b=WGbSmjGLuCDZEhcbBdv/7e/NGNKkjYI9QZbuv3/e6BZjvil+NhWJKgZ6bf7k+M//hAfqMTqUdGGFyf5+1MqaxGddZKijEySUYcraaMO35WgzGIdaoi+c29XvOkINcbflIHnwYAPVLG3CnyYKw6xkx/aXs1hHK8B0LhZEFkIuXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144280; c=relaxed/simple;
	bh=xzHTcgw2nMjUDgBj0+uyJveDyJtP6mufRVr3wzpc05U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWTN+WsDEc+knmlOwf4HJ9QbX09DVhyCrhdrMPZr5PT4YtQMqnmPFIAWYQEuTPqyryils9PZ9HgACxMhU9DeFy1Jx6kNrRTBAGnWTWPUKt2nTBRwtznUfk3Mj8q6RgMrnKAJ5cJ2IVDZL1OZWtcO4MEtpc291+QZrRxRCpA9jDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M9WuP0VY; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M9WuP0VY"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2d6d28aa26cso20236075ad.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788144276; x=1788749076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzL+apuHYW6JOK73HmlLGgbS4b6CpPn5sM6P/+ddn4I=;
        b=REFcj6Nb6rmZaopxbGCnR9mEsieBf6v3alrPqf0le8g1WBFZR2WN6p57FE7Mg3j5/2
         rtEICnlfWZ+VaCfznjbGcL3vxzLNgw5ATeWSOkc/w6Gx0kuqRsDLtE9U8mWhzbG/LduO
         bvddeJxmQga8GQGltN8bZ0MAeUbgvhR3bmK/MAwBDR6MZkXKnjR5w7n2WEG2iCrnvHeR
         YWoPCq4Av9h1cD8C4wV611V7K4/QMA2Q+YkHlWv164JFUQYutoi3mESTaXiYDvXjB927
         3P2WqKIV2/nYavrqgaSSTNYJDQn9JJVt9f57GyLySqOPFMdleIof/pHZUZIvG3TN2gHw
         IeRg==
X-Gm-Message-State: AFuF++lKdtJtFezS4nblPH58DjJ4ONoNW1LnqfspLnjCXFOz9HQSWS0s
	mVsL07fLEb7QxDTqpJE9yThLYfwF6q6OzXpjcwx3Bnu4QcnOZy53h6YcQ2rXB52dJdXzSRhGpMD
	EFyJko8OL8MKzmKj7jqBs+g1mfTamxeKEVJtfZuMv5/wRLtgWeRwG3Ig4Pj4oD5Jn+v9WGWBS+5
	zNkePx+9R5myS8Ib8VZd9Qy3QqywgOYO/wZA40BX3B0CILBl1lyOFg1d75XpL8oReWw+KNQVQ3J
	cSnvdxCgz8=
X-Gm-Gg: AYBFou3Cd84dhF68r36+n/Erl2vWwUP+yjsbxqEn51d+lgA9tpWgId3lBwYY14X66LY
	QFe7rfEfjVDtJ3YZrTsub/kNVDs6SrTfsPzrtweQA9E1zMyUPcYylPIpktTMv8eMWERNWGCn/Th
	z0RdyTkUp0ZcD9oF5FyyjuJ+bnP/l1Fcv/sxdDoQ3ZdWA0uoaBC1deDemfZAZZmHFdvDYJtax9O
	zEi8uZTimmKCszTErLnTA9osfy1C08WWJy8WhYYqSyIgWjmvZALYfMc1c0FVPrxk+lcg/XN6wmi
	tkp+vt9X04/ufVVPejDWgZpemenkWXgttnChdLeDjdPMSm1Tek0tAjAt4RgfV3zV/+Xe6wt0wRA
	6Br9axtj3GwD49JO+AZUgMhO8sf6aPDxYXitDFPsPXyboBHh7XaeePATI6/ILew7FEL/+x/xEUV
	qEqTiHXQA061Py4aZd4yYIBqeDvRGe1FPjbTA=
X-Received: by 2002:a17:903:38c3:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2d74dbe9f23mr417490925ad.2.1788144275955;
        Sun, 30 Aug 2026 19:44:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d7598db993sm981485ad.32.2026.08.30.19.44.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2026 19:44:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f73d0f89so48670195ad.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788144274; x=1788749074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HzL+apuHYW6JOK73HmlLGgbS4b6CpPn5sM6P/+ddn4I=;
        b=M9WuP0VY5Jz9PYSyWSymUfDFIOVhC2tN6lDju1fJ2f8z0/AsNf0jwzSyLAy2PaIDDF
         DdWyvQ2/wVUlIcTsdEe3EmANvoEQ9IXC2E6AqbU6npbGQvY9veoz8BvizJEMO6sq19Ut
         TCwydVqQQi3NChe8QAcugzeptt3SEdLHWCDwc=
X-Received: by 2002:a17:903:1b0e:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d74ddc6da3mr378056725ad.9.1788144274101;
        Sun, 30 Aug 2026 19:44:34 -0700 (PDT)
X-Received: by 2002:a17:903:1b0e:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d74ddc6da3mr378056135ad.9.1788144273675;
        Sun, 30 Aug 2026 19:44:33 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm26421728eec.27.2026.08.30.19.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:44:32 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH net 4/4] bnxt_en: Re-write the BARs following any type of PCIe errors
Date: Sun, 30 Aug 2026 19:43:42 -0700
Message-ID: <20260831024342.2161156-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831024342.2161156-1-michael.chan@broadcom.com>
References: <20260831024342.2161156-1-michael.chan@broadcom.com>
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
PCIe error.

Fixes: f75d9a0aa967 ("bnxt_en: Re-write PCI BARs after PCI fatal error.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c3d561ac53dc..09fed8784a2a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17564,7 +17564,7 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 
 	netdev_info(bp->dev, "PCI Slot Reset\n");
 
-	if (test_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state)) {
+	if (test_and_clear_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state)) {
 		/* After DPC, the chip should return CRS when the vendor ID
 		 * config register is read until it is ready.  On all chips,
 		 * this is not happening reliably so add a 5-second delay as a
@@ -17580,17 +17580,15 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 			"Cannot re-enable PCI device after reset.\n");
 	} else {
 		pci_set_master(pdev);
-		/* Upon fatal error, our device internal logic that latches to
+		/* Upon PCIe error, our device internal logic that latches to
 		 * BAR value is getting reset and will restore only upon
 		 * rewriting the BARs.
 		 *
 		 * As pci_restore_state() does not re-write the BARs if the
 		 * value is same as saved value earlier, driver needs to
-		 * write the BARs to 0 to force restore, in case of fatal error.
+		 * write the BARs to 0 to force restore.
 		 */
-		if (test_and_clear_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN,
-				       &bp->state))
-			bnxt_clear_bars(pdev);
+		bnxt_clear_bars(pdev);
 		pci_restore_state(pdev);
 
 		bnxt_inv_fw_health_reg(bp);
-- 
2.51.0

