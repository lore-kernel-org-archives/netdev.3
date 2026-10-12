Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73C4F053A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842958; cv=none; b=mlE9F33TEOeyetLXOBPSiJnLN8kb4ZIFjg7g0ur227oJKFOSrn4bQu5iUgfgwN2nNvULtaH7oJDMqbwaD/12/PDtPd5wQ56Wito4iH5JcDOhRNsiW2aEv3x+C8ceUvMbI57j+yTmYB2PzLu74HlOPifXoQfsOW5K49dv8jwQ2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842958; c=relaxed/simple;
	bh=Fda1g2vqmVgdra478u88xoCZ8YZ5XA+TAjYpQRHnfHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP2hI8/+MpALeBan16ozFzPyM5C7/VoDZtupGYVqJ/Fra/mNJLnzcQoxmdoGkaTjmoTpqmFs0rkwit91TNeXtuFq1mn9zUkwWV+4OPTv/hsJ5QN+qKoFhwLVR0qSNaKGovZNGPEisOtPRVxNYsRQQOy3bZyqumhFKi+w8FOSCeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KGQWQi58; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KGQWQi58"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so11025115ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842957; x=1792447757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AAXsxUonv9AU1AsZaZcY30JgI2R89PDLrBJp20T6kgU=;
        b=KNmqd2+RAHbryQMD9geKaJ5s+Xllzk98FOBI+T08mR+JSGSZHntiAyFDmPneillwyU
         qorPq85prbP4chgziDkiU3aiSykXuFvOMgZFf8v1ozScjERy3k0DzIsmtaRfZ5/OjlOh
         AVqiKs7ZNhJcQlGlPRLnUJSxX6XWkOucPfyHB88TEuEoPi1FNPmT4euJPl6CuwpJFCic
         fBTaoYmblMGy7NnVRMQos321ookV1otlIxCq+onvEuu7GCc7r6rknZYXURisXFZhfG/E
         3wXVgotO81Z6o861IPDAFZUjZy84wVHPk4ZLwfv0nxsQsRrvfCCroUTpWxOQHqsNgmh5
         zs/g==
X-Gm-Message-State: AFq9FYIdnapeVkmSzK9PJWClCfNhAzYZuOwceIQpYb+UnYvLPLlR17S2
	5ni+vla5pbgpsGnecKetPB8rSOzQ5VClon3ttkngc0s77Gn7/ZyG+nsMEr6hwCCwxbdvJq39v4w
	NY1MBpfXqmmub2fyjJOEjbHzqLlppdGQskyO1wurr4n24JVaTYF+RVWHaq6M/ULxJkguV03PzeF
	Vh7O9QhGlm/4bPmRUS1cs2eZr56d9yaJ2ken97XwVEtuXRy/I+S5czX2EcXZRBasLmWYrumUNLj
	l0cR5xUFwk=
X-Gm-Gg: AYBFou1zwwVClJgK+9iNB8ruuAWXtYY+kxHAHJqJDQ/K18r8N8dmiU38v6TLXQHxyJf
	fDzD+NmTHVKrjnSjtvEqEkrraJROZjOHHbaXCNkYNfHgFQVbsQlykFUZMMuBb8lnwq9+5Sum0sY
	zOmxAOGMpGGyOTy76fxl5pO8/0YmaDlZkuKFxQsudN7QX+o7liscPnr5z2bKZ9sTVaws45KU9yI
	LJpE3Ox0j8Hgo8Xlwa2Xx3GHMbv/lAKMC7WcPatT1ewb1iJcuPl/oLXQ+PT+tig0kPaZ2nqSDLA
	Jxsf0mRgD1unQpFaJrGm3lBWvMMIOroTGxXbdOMwgQ/q+eIcIvVwQyJB5YMi1mKs15LDq1MoPX0
	ebEEDFdK7vge6KWP2tzudrjd8F2XKOi4hu/n5TWoq/WH5zrrxG+ibsU19uBp/PrwNEnWF26mKNk
	IE9NxJoMOb1aRUVtpxPHgYqkvpnIi3vtVzT6MBvg==
X-Received: by 2002:a17:903:324d:b0:2df:a0d4:71de with SMTP id d9443c01a7336-2e842710e5amr64474095ad.0.1791842956636;
        Mon, 12 Oct 2026 15:09:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e841e7673asm4578465ad.12.2026.10.12.15.09.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 15:09:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35b68bc1985so1005731eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791842951; x=1792447751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAXsxUonv9AU1AsZaZcY30JgI2R89PDLrBJp20T6kgU=;
        b=KGQWQi58OJxq1U4MnxJpoMTAE8QwFYANScIx547f7cy0LEvtREUvBeTt+53WCCenqe
         0xc/wizGYNwMNuFjQI8ZXfgjqBHR+rkbXZ9fsHPEQSC48apT1oWDzUmB6Izs7mGqFBsZ
         OqPvECP08wOwOF7lz+K5luWGjTriikRTIRRl4=
X-Received: by 2002:a05:7022:7e8c:b0:143:1bb1:b3c3 with SMTP id a92af1059eb24-16a5ce94210mr15786405c88.14.1791842950769;
        Mon, 12 Oct 2026 15:09:10 -0700 (PDT)
X-Received: by 2002:a05:7022:7e8c:b0:143:1bb1:b3c3 with SMTP id a92af1059eb24-16a5ce94210mr15786377c88.14.1791842950101;
        Mon, 12 Oct 2026 15:09:10 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm12483206c88.13.2026.10.12.15.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:09:09 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 4/7] bnxt_en: Refactor IRQs required logic
Date: Mon, 12 Oct 2026 15:08:24 -0700
Message-ID: <20261012220827.340998-5-michael.chan@broadcom.com>
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

Refactor the logic to determine the required IRQ vectors into a new
helper.  Later patches in the series will make additional use of the
helper.  There is no change in behavior.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1c38e15fbe7e..05e609adf6a3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11711,9 +11711,22 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
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
@@ -11723,15 +11736,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
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

