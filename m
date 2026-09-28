Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9E17D6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569200; cv=none; b=IxEw+SCEvKAqsXqhaBsLvi6+HoE1ktqMvNcA/LIXjByUTlrfmrX54jaYAJLaToSViwpet1lWEJgwt3OekwTaGldUmEbnqkgZEg7Rtkg4kaWENK/8Gk6USeRdvYccN83ibXS0ge0y1uIsSbZWKjZ4zsZQLphLOkAwQSvIe4wYBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569200; c=relaxed/simple;
	bh=arKmTu7R3CR+PZuEsH47tQ6JngB9Mpw/UMbkJHoiJ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LX2aa7+T6rekbpZpd4dI3GaoHef/gdd9ICS62sBlfF+CfZ6F3cwUUMQdWzX820jQGZI4jApMsjCHu1VsqU9bvASu3LngTvpsA8rvRp+9/Rrao+AWsRxRtlni8cBdlSIBcsOdj4HdL2SiI7lQjp7Bfgz+EEJ7GOz3BuA7uNpTz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c11HEzgv; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c11HEzgv"
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-98076bb236eso876862241.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569198; x=1791173998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrDmRmoRF2CFBhgLrTbkCPcWGKEDfwYyjc2emC1wv6U=;
        b=g4Qc8VHqjSjZhIZyUkPtFGpXiol+dP77/Rx7bVcCbRsSgpuFOa9MJTVfuGEY7a7AZ7
         hhxvPn+qeyjfeqmzUzbqjswlPTefKO/FajUyeeAVTxx52LOfkUTIxvCekz1LdM/dlSwI
         OMg59TDHItQN+s/BjBw+pKQ9F2uQnBqaDTgviHGQptnuSOfclP0qcUXIl5aPRykRMdws
         EcoUCHwM5nBbE0j9hvTRDUh6Np6z0/zwhBsw7lHXmaQGOAfLUdPwirOBZ7NHAwlkhm2y
         oXU472c98sdKog/BoUYCE8B04hmFuR6UX9sf3/5+QkjNlkLWD35s/Ga6daYUmKMpw+un
         NHxw==
X-Gm-Message-State: AFq9FYJckc14Ij57zVKqDQTSkMD8QHHuKeuwPAs9hxYBEb+p2wMgNVz2
	RnFfK2XRgOC92d+AY5Ekc3/LGqYRmKQ9iyUKfUmIz7veHKmDaON2nNSJDWe5RgBJL+35ndtfRE/
	Z9kMTsCLrJiN3slvtzy5Mig3tCPgFLMS46YPc2VyfmbkUK0ii025dYMeOBqHICrzTyv9CRaDXJa
	awm8zaXSFYdRrLSdsRtv6j3QX32EzPRB+KaSySHCNPKw7TWJwiRmeZiRVaJFbEtiAWqCm443Zr9
	iry6curc9A=
X-Gm-Gg: AYBFou2lhv84EOLfl5u2vNTNqv5LAn/+R8WGlUWYp+dBuQyUTUbND4GIs0SRlQKyn3j
	iuxx7oEvyGyWVRBJ+IKkafTpI15gWoThgw6wSnnumqhlvfhHP9+6WH6RnzyUfqF+C7ZTwrjsL2K
	KmqDDINy0IHiwt+F555CtgqIVJ7y2fGZFo7BFGB3YoS8gbXEecEcoSJ61vPJserhE2i0RRRYviY
	JVXPB0fZXDnAXv/jQILScZAJiw6Z1LlVCTUFixHk3JSx2j77rzrb/e+euHqFMtHPnuGjHi3xXxg
	bNO60ODBrSWcMzM2D2GXf8oAIV3WIvxjtUtiILvdddRp6Xw1b/w9kxVm9GqoLf0aOy24ZPkiCRT
	+4kbmSajCYK9ITNbeQKM7HeIbrcvIun2OdaAfBSztoILK1dpdCE20/caEU3j+59JGixOOgVo4Ue
	pg+hR5TRiKXZnq64FROqRCenBVMULw8WqyrmbrHjvN9ghViw==
X-Received: by 2002:a05:6102:5613:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7af1ecf76c6mr4432119137.27.1790569197897;
        Sun, 27 Sep 2026 21:19:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-986f04df293sm312355241.9.2026.09.27.21.19.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:19:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so5573924eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569197; x=1791173997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rrDmRmoRF2CFBhgLrTbkCPcWGKEDfwYyjc2emC1wv6U=;
        b=c11HEzgvz97FmLI5wu3gAPo5YRHBXM2MMJXoxv9i7Cdy4bwoK1h8BIWyClRvDGEOdb
         H+CJaj9pe/MgKzr7xKN/HWOGug/Z++CAjnxh8x0uugmjetO52hZHqE78MaUQrVxty5VH
         L95Q+zrMl2CvzfB0ZcEQgzfHqOXK0QJEpmBKw=
X-Received: by 2002:a05:7022:28a:b0:149:6cb9:6cd8 with SMTP id a92af1059eb24-1496cb96d3cmr2854427c88.10.1790569196256;
        Sun, 27 Sep 2026 21:19:56 -0700 (PDT)
X-Received: by 2002:a05:7022:28a:b0:149:6cb9:6cd8 with SMTP id a92af1059eb24-1496cb96d3cmr2854386c88.10.1790569195458;
        Sun, 27 Sep 2026 21:19:55 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:19:54 -0700 (PDT)
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
Subject: [PATCH net v2 4/9] bnxt_en: Refactor IRQs required logic
Date: Sun, 27 Sep 2026 21:17:07 -0700
Message-ID: <20260928041712.3467803-5-michael.chan@broadcom.com>
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

Refactor the logic to determine the required IRQ vectors into a new
helper.  Later patches in the series will make additional use of the
helper.  There is no change in behavior.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f83f4c8e994f..aa40d5fd05da 100644
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

