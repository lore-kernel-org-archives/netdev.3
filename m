Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA3346FA8
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569206; cv=none; b=s9VgDPimJzOBITchYn2ssECrkGkSBxuomIzub6USecuJj+efc8XerOroaP3SjVXRfsssRZHhfVr/YOlcTeMfAQxbJBomZseNBKYy5/f+wXZfGHe0vCheW37hZc6COatW+NGcp8UOW2Mx1XznWmSdcRGtK4HCtH98X8C/fQfbNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569206; c=relaxed/simple;
	bh=4ZFNe3mxgNHLe+z5UhCxtDFG0sAc6xyOTnbK0+RLR0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtcPByVLWjKG7OhUD9IpErwIeDlxmtJsYZ2EhUXeuqFAsih4+pbMawKW2TycycY9f8Dp2vsQkB4qRnOv5YE+y6swznzVYv0tOp7fKGatRE+d+Q8i+hYqr9uYvcR2YgKo962jQEF2teyyRMTBze7CzB+k/q9hV7UJqVV35Rp8UmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gRt/uGl0; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gRt/uGl0"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-672c54f96e8so696614d50.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569203; x=1791174003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qu5tVNpGFkHemP6V+Q0WNlrHLzm7Grq1uV3Ia9zcNaw=;
        b=1BWmTEz/rRwXxOMLkdh/2xnFrI90h8fs65XEfXzg8EbWRAATj/s8+8lP2ud+kY+XiA
         BirYNowek6OZS3/hcp12xmBbH6qyFwyUcLPsIuCt97/hdHUTxrqSkZWk6QXjmAx6mn2F
         n6nJl03Q3lRJU9S/gb4Su0h7MYwg48wStYvQchT66haNyw6Q3ty8zukplE3y1pcVYM+G
         nNUzzYmr45BNukbPmx2JVPCJ/nFYyMRLlj1ptOtTX7pjXXV3PMECRaQvv7/X+jr0pFHC
         BAPh14LQSmwvQz39yZa7U8TBwGx1f9tP1T/EScXNw8iyuelnhA0ayOMPyiw56I9oZEck
         hh/w==
X-Gm-Message-State: AFq9FYJuR9yFP7cNlUH8cuAvleJxwTy0Yzp12um/h/CmnKYw97kCNSC4
	5dti/MYKy77hRdRRED+JE2bZChLatss4koiBE81QfBje+tABlaZC7NjPHzK3fsVwtyx7l1uPyPg
	I0kYYRjHdOgvTHwo/R5DKIuj8peyDOZbk6Vgo2vjgQ0ygiUfguCC8htRR4Xo6UG6VpU4ZW6kffh
	Lop5/mfDq9HD9i9+uMptWfJ7/2S3KluSGD1ZzTm+lT+45EpYHcETZOZ3q2r/M2eMz6FlOfWzLON
	S23hf7e1BI=
X-Gm-Gg: AYBFou3H7xL2e9mmPxW10GrL4fMTxUYB5ssXjPmu8v09i8wEDilXgnURiVfA4o5BWdA
	Tv+kL8d4k86RgR7lNVB9uH7jJqYKxfSK8iS9EcJnaS/dkmtRHTsbgNNbIro37H5k8oep8y4W/lr
	Ls0HX/LY3ndz3pWEKrTogxNVBiUpxpqs48Bp7VUNgpxZlWSXkiffR1/ZY/zhrXz2Fwp4PYPPXbi
	O26PCKSHEWy5DjxrdThoi80rtP1VFTnnyR+lRy9GsPo+J4nm2nNOdC3FjFnAJm3GOjvCP/UXyp1
	Kz+jCzV/MU/9ZZFbbCtpIiVxiu6J5Tmv5g9bPRLJ8iS806Eglu57ycepJcYZ4cqv8CzCNR8tNeO
	3U9lb/vUEwsj6EvmvlEULdm9CPDq7wgNZ/mPsUl90ah6wbwN6/85vJhfIKmRZCgjD0qbiM0g0l2
	o3jLLEe0d5UB75yYiYm0b7IhJLes5bi36CFto=
X-Received: by 2002:a05:690e:4181:b0:66c:c644:3938 with SMTP id 956f58d0204a3-672ed2627f6mr4808251d50.7.1790569203186;
        Sun, 27 Sep 2026 21:20:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6740ef80843sm1240520d50.21.2026.09.27.21.20.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:20:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-347536bd6fbso669736eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569201; x=1791174001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qu5tVNpGFkHemP6V+Q0WNlrHLzm7Grq1uV3Ia9zcNaw=;
        b=gRt/uGl0vFnC+wuC89Acj736jFJeL/2LHHRqmugOUoVHoRzZFxQ2oXmDeaCpqi2Zij
         p7+fhTzMqSYKTNMpk9/i21shMhOo+iEfBTHoHilHH3x8iOEWySSuJbshzU6gCJ9n2Hos
         nw+ofcBRpRRr//j5NptJ5Uc3gQH69z/30yiBs=
X-Received: by 2002:a05:7022:4199:b0:144:fdf0:9d91 with SMTP id a92af1059eb24-146cfdd2b0dmr11671712c88.24.1790569201177;
        Sun, 27 Sep 2026 21:20:01 -0700 (PDT)
X-Received: by 2002:a05:7022:4199:b0:144:fdf0:9d91 with SMTP id a92af1059eb24-146cfdd2b0dmr11671668c88.24.1790569200469;
        Sun, 27 Sep 2026 21:20:00 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:19:59 -0700 (PDT)
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
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net v2 7/9] bnxt_en: Add bnxt_clear_bars() helper
Date: Sun, 27 Sep 2026 21:17:10 -0700
Message-ID: <20260928041712.3467803-8-michael.chan@broadcom.com>
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

In bnxt_io_slot_reset(), we clear the 6 BAR registers.  Add a helper
function to do that.  The helper will be used again in the next patch.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8e4bde720ef5..8c6bf10aba8a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17221,6 +17221,14 @@ void bnxt_print_device_info(struct bnxt *bp)
 	pcie_print_link_status(bp->pdev);
 }
 
+static void bnxt_clear_bars(struct pci_dev *pdev)
+{
+	int off;
+
+	for (off = PCI_BASE_ADDRESS_0; off <= PCI_BASE_ADDRESS_5; off += 4)
+		pci_write_config_dword(pdev, off, 0);
+}
+
 static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct bnxt_hw_resc *hw_resc;
@@ -17703,7 +17711,6 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 	struct bnxt *bp = netdev_priv(netdev);
 	int retry = 0;
 	int err = 0;
-	int off;
 
 	netdev_info(bp->dev, "PCI Slot Reset\n");
 
@@ -17732,11 +17739,8 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 		 * write the BARs to 0 to force restore, in case of fatal error.
 		 */
 		if (test_and_clear_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN,
-				       &bp->state)) {
-			for (off = PCI_BASE_ADDRESS_0;
-			     off <= PCI_BASE_ADDRESS_5; off += 4)
-				pci_write_config_dword(bp->pdev, off, 0);
-		}
+				       &bp->state))
+			bnxt_clear_bars(pdev);
 		pci_restore_state(pdev);
 
 		bnxt_inv_fw_health_reg(bp);
-- 
2.51.0

