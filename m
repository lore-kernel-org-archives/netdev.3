Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889F3932D3
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133120; cv=none; b=CHjejux3agNOYFPRQGzBZr0aoj/ZHccXCAwBVNdkwew7tC7olJCFHWklo3eHDEePbAvZDjdlFCIrPrEe/cagW5gdfYaXbzXiJ3MO9uBzAF98JOUMeZsrZ27HK0A/RQeUe118jaysdT2NMeL4PNCwKvQu0QcoEK8AdT3Sx+amojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133120; c=relaxed/simple;
	bh=wjc7k9xSDP1Xqbf+Etb2dy8/trxWeyPSSGrZRUBE8PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZKarFXUtOd+pkfFlakr7YTk8ARL22Iy1eLrBZaRS1ooCClBJTijdwh1R+ZjxsCp1oeTd76cVB/95E8oK++veMiFOR7TVzOxLC4Pc92JRbz4K7KCUlwLQChY18lNa9atQ2LbwNIWeQEfvA6xdQ2SIUnCpq46e3IzFUSLUIPB4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=StoTA/dl; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="StoTA/dl"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-886e61fa30fso2319626b3a.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133117; x=1792737917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZ6mkPjbTlf+XAGrQXOZahu1gbl/ceU/1F2/KJCP79c=;
        b=Hxe+qTa2JD1s6g8nklXUUsAaskJ4VVRHypDvRhrVkDlfMq2OZvHuz14XdRori1wPtY
         EOzjggLmFTU67LQqpE98X1DWXQ3effMqh8RW7Jv5Ac9AjQHxYN2bsZ6wBB/lqL+R8QMK
         bN2SalLnUmkfB+cVk7C0QNzPWZRGCbdP24vXRIciYsKSHrzObPhjkGZWDTGHUre5yAPZ
         lX8se1VZFPJNmKXdVI8BEFf64nmWgcHLG++V62/bUpi1sFDfq6g0RGA4QjM2JT7ljRCt
         2UalN87y/47xOINftg3zxEcVBsSQvXZKVMcGpR35pjLySVRmJ1UrKqgJGdyIsHxnydA3
         pYhw==
X-Gm-Message-State: AFq9FYJ88WDbD1Xmzw2UXUOkiFYXHRMr8Z8vI1oObSIrDD6IvmYUo6x9
	hgqgISQIIdwWxsrcJ5O4iSDyxR5ZyVl9Th2or9hMbnuaHVgmaX2p+PhwP0CSKzoeQlqLgd3PV6f
	ITMDTkgqz1x4265kFcgXP6eBU3/9bo6jO/GVajArYjkDYOCZdOInMiyphL4cNGYm1XQsM1ZGAkz
	874olFHRTFszu96/awvKO06A+NasRUIU3op/EktjU4/dqcOqhmnLwwTbNF4bukuzaIJeVSjYktt
	SVuhVrkkWc=
X-Gm-Gg: AYBFou25ITCMPtZNxQW2DRy6DDoMupT2bckUPnm+E+KtsbZ73Snm8GRRp9ZwumtbKwz
	SKfK2e2zFQCSdtGw9ZbJ0Zvx16GYjle5braFXjM46sHM4fUgwqaKGzHEoXybu504smy3ZymsIDD
	Pn8yHSpPheMDtipCiwhliXOdEKbmaFhBjSwVv11tup2LEG/O560t04BXf8mxMNfGWv3ahI/yFNX
	oCJkx9/bkqRU8Xc+4xnXN5PURsNPYze7QLqOnvR8zbI6vVs7mA8m9MX1IfjSsLM5F0Zp5gJ7ySG
	rCu5/kF7x3ccEtjSYRztOv7/eLnoIshmr1T5ClVL/OEuTeRStJPiJJ/Rf55i9N+zenvRE0Zli+u
	v0kVk/vor6gEIP1Mp6OR8UPjvMBRw9Qr4BeOSX79OuNY/Q8T1MPDF15d8RjpCM7dHBOeHZwFCae
	NFk5+BTt1i9koll9ioBzrM0Hp8HsvI+TyqDVg=
X-Received: by 2002:a05:6a00:348e:b0:88e:a2ca:1756 with SMTP id d2e1a72fcca58-897c634d9c8mr18674910b3a.19.1792133116983;
        Thu, 15 Oct 2026 23:45:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-89f598a4905sm32615b3a.15.2026.10.15.23.45.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:45:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so12446398eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792133115; x=1792737915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZ6mkPjbTlf+XAGrQXOZahu1gbl/ceU/1F2/KJCP79c=;
        b=StoTA/dlq6wQr2Tr1AoRxML+M5i7NpMDvXURYKr3JfGSCSnqKG2o63yHykvgr5t0qP
         XCeXLjo8LiENhaXp11i4UnuIkXYJXAKeal8R5EIgb7AIeGGVoIFi15fI2XEh7vUkbRCy
         sxRFiC9ZKU8bknL6L3mLSYd7GZJz27btiTxkk=
X-Received: by 2002:a05:701b:2717:b0:16d:dd5c:4261 with SMTP id a92af1059eb24-16ddd5c42a5mr30085895c88.46.1792133114952;
        Thu, 15 Oct 2026 23:45:14 -0700 (PDT)
X-Received: by 2002:a05:701b:2717:b0:16d:dd5c:4261 with SMTP id a92af1059eb24-16ddd5c42a5mr30085837c88.46.1792133114163;
        Thu, 15 Oct 2026 23:45:14 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm3791401c88.0.2026.10.15.23.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:45:13 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v4 4/8] bnxt_en: Refactor IRQs required logic
Date: Thu, 15 Oct 2026 23:44:23 -0700
Message-ID: <20261016064427.496944-5-michael.chan@broadcom.com>
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

Refactor the logic to determine the required IRQ vectors into a new
helper.  Later patches in the series will make additional use of the
helper.  There is no change in behavior.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0556a9b60791..4cc6ffeb56f6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11712,9 +11712,22 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 	bp->irq_tbl_size = 0;
 }
 
-int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
+static int bnxt_irqs_required(struct bnxt *bp)
 {
 	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+
+	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(edev)) {
+		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
+
+		if (ulp_msix > bp->ulp_num_msix_want)
+			ulp_msix = bp->ulp_num_msix_want;
+		return ulp_msix + bp->cp_nr_rings;
+	}
+	return bnxt_get_num_msix(bp);
+}
+
+int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
+{
 	bool irq_cleared = false;
 	bool irq_change = false;
 	int tcs = bp->num_tc;
@@ -11724,15 +11737,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(edev)) {
-		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
-
-		if (ulp_msix > bp->ulp_num_msix_want)
-			ulp_msix = bp->ulp_num_msix_want;
-		irqs_required = ulp_msix + bp->cp_nr_rings;
-	} else {
-		irqs_required = bnxt_get_num_msix(bp);
-	}
+	irqs_required = bnxt_irqs_required(bp);
 
 	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
 		irq_change = true;
-- 
2.51.0

