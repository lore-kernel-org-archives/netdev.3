Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F8400DE9
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525036; cv=none; b=KSc2sJR0JlDVsS3tsu3xLI5l/vLaEN30Wiu40KK/Z9dUdf56wstOGE8P8z0gcT459evYXpPvdYoWbLjDu+AmCp+g0FUSuiOEZeyJ2Nd4nVGw+gJYpri1Gk/GGOMVTc+qdCvZ5ZwKTug8JZXk7wTX2ti0FUAh3pZFAmZSZ5511O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525036; c=relaxed/simple;
	bh=YrnzjfDutoDQJgYg7pVUPEkNuwr+OCkY22me7I0w6yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVLsispBBgOneNJaOLl1b/FZkfq3t0HhxEbJ1zSEt04lwnUxmnCLjnTgSn1ukY1dcY4JuvakepCRV4cTYNaGeZg5Fh97c13wtuQh+f+/bqyDLe3MUpfUSx0TW9QCPPOzxlq6iPVCof4X/tO1/v97em4QXdOwpH68fei1IQPz9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OryZ/KKQ; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OryZ/KKQ"
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-81f52945098so22424717b3.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525034; x=1786129834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0RC1KyUniSVPl3Rkj1xMgfX/YWlzrxEahXFpzlTqf0=;
        b=SmcxtaHkX7hUFHKMM1WSiUKtihv7ShAsVuoYsmHfiEXsnFvDGRycZ4fv2q9rMZpAKS
         GNqhMF8yyscNWDaWfHPar2ScIj7bteB/3FCjLxhteCFFps4YgzgEHAZLH7JNGHBnTI1p
         FEm1K5KxIOxBiLO1jRxRNm6GMYCGQba8NfXmiUwnk/CLKz2J0B+Nnvqc2ok82B2/cZRS
         ufhSAvusJVgsmsAU/qMMBu8iC5gnSFb58ud5mMug0b98tl28PxkXUy6RVcGsQgG+nzFu
         N6RCVdLwDa4SKuaD4s0hMKkjBaPqZZpfQyVc8vNgC62CbcQYVaamcbghFWyYNSmqV/mq
         XeSw==
X-Gm-Message-State: AOJu0Yxqgekeh0W0b4ZcySxLx2dKEV++lXrSiiedrP225CgDl7AGolyS
	HeGbFzvSqBaeuRXiAVUfL5N6bnm/cerXaujgJaWYeZc99gXj/+fyoBDDCLnW6A00Z1wfOFAAzFR
	qMeIVbcuYGsmZWw8fpAJtWxLhFX9woAY4ApRbQWtsk+CvobHG9qNV/zu93dUsixGNp1haJNKAsm
	/1IjLy0j7fXapVGECxlX3TpOZ8/4Egj4mQ63wz5aixdpz24/FR1PuEwriFTuj1g1f5xAVHdihi0
	C6Jaa0NX3o=
X-Gm-Gg: AR+sD12KxFeglhj6saybWfDLFOSTZ9EyXDgxhDaY1pfaJURdzz/Y+Z8lSxoOoo4q9v4
	pT9U98yi4tUxUr3SHGOdZ5OMGoHWycEYDDRNzwcTc11SNtaQhzVWzMfU/7xLrmuQeRa0PPm2hZK
	v/Q1NhVnFtddiSSc7WrNmc+1676YxAw0+RPcDUIA3uIkiuBdNa8uPJl+igy7kdnXJCthX1HYPC8
	O/9dgasjwNIUx6MG5yfOUEDilejrlMJzJRHzoUy/WkUmZWqcRL2Bjk1nQIWKnKB7CN/zJKQS/Mx
	5/pF2wYQN/2BZHDLptwm07hDg+ZO76JY1qdodPUb5ZeiROqtVFzA4vcdh4i7EI0X/dlr/XOnsar
	7wEUovL3VvU1cePy34YDkj5LhwWa/g/GGSydKt3VcjZU8T5hA5IyvnKoTjCnkFkmgi8HKFuNhU9
	3gjPrf5VEnnoe692GJzGxkco+uzLiObE6CQ2w=
X-Received: by 2002:a05:690c:e3c8:b0:81e:8a76:a152 with SMTP id 00721157ae682-81fcbc09788mr32226537b3.9.1785525034007;
        Fri, 31 Jul 2026 12:10:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-81fcd0f4d4csm1185077b3.23.2026.07.31.12.10.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 12:10:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dff6253so19187585ad.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785525031; x=1786129831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0RC1KyUniSVPl3Rkj1xMgfX/YWlzrxEahXFpzlTqf0=;
        b=OryZ/KKQLz5ivsapUxslB7joXir4253lpMRpPr3DHmTpjdYG6sAyO+M2XMcsfb3wjM
         jhPrNJtFwMpoLl17nhFfTbs5BOMg0MVEFR2t4hnBcyrc/uI82GdU15Oxe2NnsujMvgUM
         d7+5HOY+mLBAuMvqe5ZzRi1bh/buzOUcOLXWc=
X-Received: by 2002:a17:903:3845:b0:2c9:fc0d:165b with SMTP id d9443c01a7336-2d047e7919amr26627545ad.23.1785525030832;
        Fri, 31 Jul 2026 12:10:30 -0700 (PDT)
X-Received: by 2002:a17:903:3845:b0:2c9:fc0d:165b with SMTP id d9443c01a7336-2d047e7919amr26627275ad.23.1785525030301;
        Fri, 31 Jul 2026 12:10:30 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8667714eec.10.2026.07.31.12.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:10:29 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 1/5] bnxt_en: Move RSS table fill outside __bnxt_hwrm_vnic_set_rss()
Date: Fri, 31 Jul 2026 12:09:33 -0700
Message-ID: <20260731190937.807270-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731190937.807270-1-michael.chan@broadcom.com>
References: <20260731190937.807270-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shravya KN <shravya.k-n@broadcom.com>

This is a refactor patch with no change in behavior.  The caller
will now fill the RSS table before calling __bnxt_hwrm_vnic_set_rss().
In the next patch, we'll add code to determine the default ring for
the VNIC when we fill the RSS table.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7513618793da..48f4e38ad78d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6706,6 +6706,9 @@ static void bnxt_fill_hw_rss_tbl(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	bool no_rss = !(vnic->flags & BNXT_VNIC_RSS_FLAG);
 	u16 i, j;
 
+	if (!vnic->rss_table)
+		return;
+
 	/* Fill the RSS indirection table with ring group ids */
 	for (i = 0, j = 0; i < HW_HASH_INDEX_SIZE; i++) {
 		if (!no_rss)
@@ -6745,13 +6748,8 @@ static void
 __bnxt_hwrm_vnic_set_rss(struct bnxt *bp, struct hwrm_vnic_rss_cfg_input *req,
 			 struct bnxt_vnic_info *vnic)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		bnxt_fill_hw_rss_tbl_p5(bp, vnic);
-		if (bp->flags & BNXT_FLAG_CHIP_P7)
-			req->flags |= VNIC_RSS_CFG_REQ_FLAGS_IPSEC_HASH_TYPE_CFG_SUPPORT;
-	} else {
-		bnxt_fill_hw_rss_tbl(bp, vnic);
-	}
+	if (bp->flags & BNXT_FLAG_CHIP_P7)
+		req->flags |= VNIC_RSS_CFG_REQ_FLAGS_IPSEC_HASH_TYPE_CFG_SUPPORT;
 
 	if (bp->rss_hash_delta) {
 		req->hash_type = cpu_to_le32(bp->rss_hash_delta);
@@ -6803,6 +6801,7 @@ static int bnxt_hwrm_vnic_set_rss_p5(struct bnxt *bp,
 	if (!set_rss)
 		return hwrm_req_send(bp, req);
 
+	bnxt_fill_hw_rss_tbl_p5(bp, vnic);
 	__bnxt_hwrm_vnic_set_rss(bp, req, vnic);
 	ring_tbl_map = vnic->rss_table_dma_addr;
 	nr_ctxs = bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings);
@@ -10866,6 +10865,7 @@ static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	}
 
 skip_rss_ctx:
+	bnxt_fill_hw_rss_tbl(bp, vnic);
 	/* configure default vnic, ring grp */
 	rc = bnxt_hwrm_vnic_cfg(bp, vnic);
 	if (rc) {
-- 
2.51.0

