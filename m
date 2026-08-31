Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF7345EAE
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144277; cv=none; b=Jv80/G7HF/qqN2DVXT4yjfjHTmIMto7Kk0nvQUVcphY2xmDavYWHQCOUsApU7UHFQBYKq9guqBRfKd3xyJwDXi2S7K+7unVhSs5OGsgqerR6Mqsn+sXSUSTD6irylSerFG/AlFw84nq/0yvxlM5ML8zTzLoKuPflWX3kmFFe9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144277; c=relaxed/simple;
	bh=2H6V6nYHOzCdLHkiLL4cMAw4BGfXhP/k1fef5htGimE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dz3FEr0en4dw7WY3ggILguDaH1cAL43vV2qfKcllD2KI+wxbqvROBZ7utuuQS0H8JiLmzwiwbYyEoWOkFGCbyJg8T68U2EzZEtomBtIxj/8khSlni0/Au5BkD3xNy8+m0kPsChKOX6ownmiuW0zlVDeRmYsxO+A3cX0aPNeGRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Di7sCDTw; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Di7sCDTw"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso3038735a91.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788144271; x=1788749071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XIcgguFpSNExWOAMo4e/TH9XFbB1U8vP4j3ZWHsDki8=;
        b=YHIOcF55CoMGgVtin21gDRdHJJEoDZbIrr4Q5HNL6UPCDHKzLTBylwtA+m0I+1/ApX
         NlR7rYl7F1qfvd3hPwc/2X4++KJsi6Zy46esNh/zVQi1pMnot73dX92UduWjLXL4PLjf
         BaP+ncyROfTrIIETLJeplZyndz9NQNfAKan9vhkIPXlpx5nQe0qy7frWW/s8E1XioEi0
         ZYZrYLoZac41p14PDyGDTI8EJZanf7rNpHwHdoi8JcRhDsxLJKStAjP9Okg8fimRs+J8
         xx60/s4lJXnYB+O2IuMjEhET5MDRd+rU2/0vT8Obxb/pP84gdfD25MVWo88Zdv/6N9/p
         j/sA==
X-Gm-Message-State: AFuF++mYQM6+4ubimCxgYkaopv01NghBZKIiwvvtjaS11Wx35MpAZ42X
	bPVeSZOPydoW5MWe/rCs5+HVTzUshVqj35yU7H8ubXbwedywjfnLv/eNxM/DqMd7HdXSAxXROI/
	uKLT5pAkbcJzrKf6GI+IAvbrhPw0DVQHNA1ji7ur91s/7MWDDaX2rfF8nxm9YubTe/I4JuIigP1
	f90fj36MxVNt35Pmt5t2YjJxs2LIeXXfIpOSllkU1MlO1+tP0+xRyr8vGtyKjPYIMTHxdbW3Gzk
	MYIos3zhao=
X-Gm-Gg: AYBFou2UnAKLtmEYPTNBSPt1Wx8DKJv1fKpEJ58cXqIQSDawk5SjizrAETf47TttSvS
	MnFPMPAhf6rtdeTsT7yL3KoPsWLn/1p8xyqsrLRRiAmLFe3urXUr2lPJIEUHYj/gVU2/8DZzEc0
	8DQ83M8C0kCeiNiSMRaunuuBFau4M0WrXDN3YBzUMqAWC8DzTh/7SAA524BPLJGCbcCRVz+9QRL
	ovd6Uyx5v7Vb2zSVGnsLybCpxk7CbJJXpCGQb47pfuDLiRH7bpWkQTs6kYyCYA8pYGiSgvfCODB
	F0cIyqXyQhAsI2/ZXMvAGDMdaYejRZ8aoibbgAD9HFj7a9kqg+WujMe5Cdzyosk9bJEEM87qEXq
	8+ZAq0AZuiZHSGcq/W5CDwYW7HDzk5p3IcbyM8jz6kw7QRRdD5bU/hO06XXjtcguYOV1pgqMkKy
	78mXKT9M8IM/VrGlrPt68RT5FlfgOPVr4lD98=
X-Received: by 2002:a17:90b:224c:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-3989c003c31mr18801662a91.20.1788144271308;
        Sun, 30 Aug 2026 19:44:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-398bfa4aba3sm2119204a91.7.2026.08.30.19.44.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2026 19:44:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d55d8cd938so49941875ad.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788144269; x=1788749069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIcgguFpSNExWOAMo4e/TH9XFbB1U8vP4j3ZWHsDki8=;
        b=Di7sCDTwtcX1ObIo/5ifeuQRHw0kxAzC2ceeNE+dXcIS5YoViQZppIFTFa34BkbrDF
         563l2hdxJbZ/QX/SnuM6jMFFU31/wO1oM1CB8shoEL2HLlgbIAq5jVo2IJXn+xBzHuq+
         qp0T6jIMF6Ixh5ns5Mmp7fYNNTm9Vl8zJx0X0=
X-Received: by 2002:a17:903:228e:b0:2d6:fed1:7127 with SMTP id d9443c01a7336-2d74ce1ba62mr341338905ad.0.1788144269249;
        Sun, 30 Aug 2026 19:44:29 -0700 (PDT)
X-Received: by 2002:a17:903:228e:b0:2d6:fed1:7127 with SMTP id d9443c01a7336-2d74ce1ba62mr341338455ad.0.1788144268777;
        Sun, 30 Aug 2026 19:44:28 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm26421728eec.27.2026.08.30.19.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:44:28 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 1/4] bnxt_en: Fix ring accounting underflow when rings are constrained
Date: Sun, 30 Aug 2026 19:43:39 -0700
Message-ID: <20260831024342.2161156-2-michael.chan@broadcom.com>
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

When __bnxt_reserve_rings() reserves fewer TX rings than requested,
and an XDP program is attached, bnxt_adj_tx_rings() blindly subtracts
bp->tx_nr_rings_xdp from bp->tx_nr_rings, potentially causing the
result to be negative (large value).  The large value will propagate
and cause unpredictable failures.

bnxt_adj_tx_rings() should scale down the TX rings for XDP and TCs
evenly when there is a shortage of TX rings to be correct.  Because
XDP requires a 1:1 mapping with RX rings in combined channel mode,
bp->tx_nr_rings_xdp must be equal to bp->tx_nr_rings_per_tc.  Any
leftover rings after integer division is intentionally left unused.
This will fix the underflow resulting in a negative (large) value.

Additionally, update bnxt_rings_ok() to require a minimum number of
TX rings based on the active configuration (at least 1 ring per TC,
plus 1 XDP ring if XDP is enabled). This guarantees that
bnxt_adj_tx_rings() always has enough rings to satisfy the minimum
viable configuration, gracefully failing the reservation otherwise.

The bnxt_rings_ok() check in __bnxt_reserve_rings() is moved earlier
to return -ENOMEM if we don't have the bare minimum resources before
we commit and update the software state.  Also add a check for
bnxt_trim_rings() failure earlier in the same function for the
same purpose.

Now that we have the proper bnxt_rings_ok() check for the bare
minimum and a more robust bnxt_adj_tx_rings() to handle fewer rings
than requested, we can remove the error path at the end of
bnxt_reserve_rings() that would abort if the rings could not
satisfy the TC requirements.

This existing issue was detetced by Sashiko when reviewing the
new kTLS patchset (patch #3 of 15):

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810051358.1244418-7-michael.chan@broadcom.com

Fixes: 1ee581c24dfd ("bnxt_en: Adjust TX rings if reservation is less than requested")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 45 ++++++++++++-----------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59bcca73a2b..219a6f551f1d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8135,8 +8135,14 @@ static void bnxt_copy_reserved_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 
 static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
-	return hwr->tx && hwr->rx && hwr->cp && hwr->grp && hwr->vnic &&
-	       hwr->stat && (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
+	int min_tx = bp->num_tc ? bp->num_tc : 1;
+
+	if (bp->tx_nr_rings_xdp)
+		min_tx++;
+
+	return hwr->tx >= min_tx && hwr->rx && hwr->cp && hwr->grp &&
+	       hwr->vnic && hwr->stat &&
+	       (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
 }
 
 static int bnxt_get_avail_msix(struct bnxt *bp, int num);
@@ -8211,10 +8217,16 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
+	if (rc)
+		return rc;
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx = rx_rings << 1;
 	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx);
 	hwr.cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
+
+	if (!bnxt_rings_ok(bp, &hwr))
+		return -ENOMEM;
+
 	if (hwr.tx != bp->tx_nr_rings) {
 		netdev_warn(bp->dev,
 			    "Able to reserve only %d out of %d requested TX rings\n",
@@ -8243,9 +8255,6 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	    hwr.rss_ctx < bnxt_get_total_rss_ctxs(bp, &hwr))
 		bp->rss_cap &= ~BNXT_RSS_CAP_LARGE_RSS_CTX;
 
-	if (!bnxt_rings_ok(bp, &hwr))
-		return -ENOMEM;
-
 	if (old_rx_rings != bp->hw_resc.resv_rx_rings &&
 	    !netif_is_rxfh_configured(bp->dev))
 		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
@@ -11663,7 +11672,6 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
 	bool irq_cleared = false;
 	bool irq_change = false;
-	int tcs = bp->num_tc;
 	int irqs_required;
 	int rc;
 
@@ -11701,17 +11709,6 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 		netdev_err(bp->dev, "ring reservation/IRQ init failure rc: %d\n", rc);
 		return rc;
 	}
-	if (tcs && (bp->tx_nr_rings_per_tc * tcs !=
-		    bp->tx_nr_rings - bp->tx_nr_rings_xdp)) {
-		netdev_err(bp->dev, "tx ring reservation failure\n");
-		netdev_reset_tc(bp->dev);
-		bp->num_tc = 0;
-		if (bp->tx_nr_rings_xdp)
-			bp->tx_nr_rings_per_tc = bp->tx_nr_rings_xdp;
-		else
-			bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
-		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -13216,11 +13213,17 @@ static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
 
 static void bnxt_adj_tx_rings(struct bnxt *bp)
 {
+	int tcs = bp->num_tc ? bp->num_tc : 1;
+
 	/* Make adjustments if reserved TX rings are less than requested */
-	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
-	if (bp->tx_nr_rings_xdp)
-		bnxt_set_xdp_tx_rings(bp);
+	if (bp->tx_nr_rings_xdp) {
+		tcs++;
+		bp->tx_nr_rings_per_tc = bp->tx_nr_rings / tcs;
+		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
+	} else {
+		bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	}
+	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs;
 }
 
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
-- 
2.51.0

