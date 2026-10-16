Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F23B7B83
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133126; cv=none; b=ilptxcF8cNOOtAccJLEI/8l6/5dAIvXtcHbm81DI3GIFfMRYgJI5XrqPiwvlKD0tSkHfF0cFrP5vUxygLMS1R1uCNZ1X+1d+Qy5DiaP7Dg45wk9JlWqJCnF8xaueqMgV9vv/sUM1NRG0nMHyMzc+YFwav71/nnXrXAjvAwbnZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133126; c=relaxed/simple;
	bh=/c/X8lQzDNXtNMpGMEJT5V332cMx1dB/LiE4ywC9aIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuOXZbB43Jkukz5G4EVT7YSrs5uiIZSottC5MbiEhiU2j/bHyXxPsLX54AOZm3tFkzdgpVUrJnNA3N1diBvDWxuV4RDJ3ebLaiVchZrwy9kL+qo+i8FPpgwnH+RhDeSOlt4CsStRExdLWpXoQroi7Urvz1lIPL5qOoXd8kSQ/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VcCfzP2Z; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VcCfzP2Z"
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-8aea7b7ca0cso47220517b3.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133121; x=1792737921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9lrS5rDQRnYayxmT/v5bMyv38Ksh5DNga2iBY2+7ho=;
        b=PdVrl2liOwjc4+ffw9ygoy50YQrDFFBhYyVeLsQeFvzJ6rT/8BRdXPQ9ErpKFFa08L
         LwYUBPh1BnbvcnkCmJUW8OCgWdqkoWhSUnAYeV3OEl+oeBCJQEloK2pcjo6dnFlBQu6k
         hqB99CQLNMjL3DBEyB1UFEHkSkCSbcwbyrpJTjJFK0gQAzLR8P/SOtpSaJdXnqRBznaa
         7ciVS59BZuo9seFWgr3dsGJtuh+2vPe8D8miwH2rX2Zd6caHbkgVR7rcIVfKIM2SB4jb
         rymybU8WEde0osjLsas89Jm9fn9DWewuOsZ93tSzJ3lkgss2PUgVaoPsxSw8Uk0LyOzn
         Z2Pg==
X-Gm-Message-State: AFq9FYIqv/Ht2KagYtUk1TrU8XYI7xiU8c5oYpzCIonVp6mfmT5u3b4H
	vXPbAS3p+lJQts12rX9yRIiVZ2y1CbGNBlrZQwGwSrMPi7DiBgV28+VKLp27GQPOYoGDi7n2RIX
	IjWFoRRE8KCBTTDOE+ZtSE8H6hOv66tP1qGzlG3tQt3nqvDfUO1i4eWgk0yk3fQKYlMr7jUeaLl
	LHEy2Wv6BDf0obL5MDBEtKr/fZG8HEVwbyGSkgiC+m81tKSu1caNh1SIw0UmJxr24g7f45mBvzo
	XTe37tsMQ0=
X-Gm-Gg: AYBFou2qlDkbPfpNohY2PfomlCVfzxLBPimf5eLQR48+cysJk7gx6mWt4f404x3HECt
	+KB/47PZDprxUPr+N4oXB9PJLuGnGy6obi0MmT+6XWQsJjUTZ76nm0pGfkjpAw5tUUcf1I4pJfX
	wo+g2GIptmkzRaMjIZhtMVHdLo3o8tpUkf+WeqGH8yFkgAZJqv20Yjc07MlMw3IYlcdYUyYDtmG
	wT4bRX//OHWGYBywXWFH1PUGfxy85miSJq8Ge3QMI9n3Jbz8hIMK9Dfy43CtbQ47fhsRQRV5jrZ
	10L2x1oZ5RZ/goy0F8DooOMm2xh8141HDxsJOQdmXwjAgFPhSKsOBmiQsLvdQRRL8es8Vv45olK
	09eTCRy5ZibYl85ecDiMMrduCsfaqzrHpjFEBxhtYVbO4LBfJJJT4L2D/XTq6Z1pT0X51JFDL1L
	sHFpd/poMYXsNPTv/DsEiTyxJuoJ6K4ZJYd8I=
X-Received: by 2002:a05:690c:7107:b0:8ae:a5b5:e97a with SMTP id 00721157ae682-8b07ed30e85mr69514207b3.13.1792133120752;
        Thu, 15 Oct 2026 23:45:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8b0e58b30c0sm106177b3.23.2026.10.15.23.45.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:45:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-151ba226e1bso7455135c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792133119; x=1792737919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9lrS5rDQRnYayxmT/v5bMyv38Ksh5DNga2iBY2+7ho=;
        b=VcCfzP2Z2RJxZCx8/FfTsXJ9g6FJLYq23taB9EdzGvwTsmGfJSYm5CnvtiqlMFiTMF
         crlAiGtlMzDE1epuYwQCTOubuQ1tNfxpg6dmaFIJ3ZHAuN1Y+6Wo3XtzX01bHsTbFDSY
         VjjPNrjGOY8ZexcIVbasDCv8C0Ywgrb6iHDyI=
X-Received: by 2002:a05:701b:2045:b0:17b:6c28:8be1 with SMTP id a92af1059eb24-17b6c2894aemr12128286c88.23.1792133119397;
        Thu, 15 Oct 2026 23:45:19 -0700 (PDT)
X-Received: by 2002:a05:701b:2045:b0:17b:6c28:8be1 with SMTP id a92af1059eb24-17b6c2894aemr12128251c88.23.1792133118682;
        Thu, 15 Oct 2026 23:45:18 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm3791401c88.0.2026.10.15.23.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:45:18 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 7/8] bnxt_en: Refactor bnxt_num_cp_to_tx()/bnxt_num_tx_to_cp() helpers
Date: Thu, 15 Oct 2026 23:44:26 -0700
Message-ID: <20261016064427.496944-8-michael.chan@broadcom.com>
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

Add 2 parameters tx_xdp and rx to these 2 helpers.  tx_xdp will be
passed in by the caller instead of always using bp->tx_nr_rings_xdp.
All current callers will pass in bp->tx_nr_rings_xdp so there is no
change in behavior.  The rx parameter is unused until the next patch
to clamp the XDP rings.  The callers now pass in the correct rx
value for this purpose.

To be consistent in bnxt_num_cp_to_tx(), tcs is now correctly set to 1
when bp->num_tc is 0.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 +++++++++++------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 79057a5a2b7a..5949fc72aaa5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8161,7 +8161,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx = rx_rings << 1;
-	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx);
+	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx, bp->tx_nr_rings_xdp, rx_rings);
 	hwr.cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
 	if (hwr.tx != bp->tx_nr_rings) {
 		netdev_warn(bp->dev,
@@ -11294,27 +11294,24 @@ static int __bnxt_num_tx_to_cp(struct bnxt *bp, int tx, int tx_sets, int tx_xdp)
 	return (tx - tx_xdp) / tx_sets + tx_xdp;
 }
 
-int bnxt_num_tx_to_cp(struct bnxt *bp, int tx)
+int bnxt_num_tx_to_cp(struct bnxt *bp, int tx, int tx_xdp, int rx)
 {
-	int tcs = bp->num_tc;
+	int tcs = bp->num_tc ? bp->num_tc : 1;
 
-	if (!tcs)
-		tcs = 1;
-	return __bnxt_num_tx_to_cp(bp, tx, tcs, bp->tx_nr_rings_xdp);
+	return __bnxt_num_tx_to_cp(bp, tx, tcs, tx_xdp);
 }
 
-static int bnxt_num_cp_to_tx(struct bnxt *bp, int tx_cp)
+static int bnxt_num_cp_to_tx(struct bnxt *bp, int tx_cp, int tx_xdp, int rx)
 {
-	int tcs = bp->num_tc;
+	int tcs = bp->num_tc ? bp->num_tc : 1;
 
-	return (tx_cp - bp->tx_nr_rings_xdp) * tcs +
-	       bp->tx_nr_rings_xdp;
+	return (tx_cp - tx_xdp) * tcs + tx_xdp;
 }
 
 static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 			   bool sh)
 {
-	int tx_cp = bnxt_num_tx_to_cp(bp, *tx);
+	int tx_cp = bnxt_num_tx_to_cp(bp, *tx, bp->tx_nr_rings_xdp, *rx);
 
 	if (tx_cp != *tx) {
 		int tx_saved = tx_cp, rc;
@@ -11323,7 +11320,8 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 		if (rc)
 			return rc;
 		if (tx_cp != tx_saved)
-			*tx = bnxt_num_cp_to_tx(bp, tx_cp);
+			*tx = bnxt_num_cp_to_tx(bp, tx_cp, bp->tx_nr_rings_xdp,
+						*rx);
 		return 0;
 	}
 	return __bnxt_trim_rings(bp, rx, tx, max, sh);
@@ -11536,7 +11534,8 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 	if (rc)
 		goto msix_setup_exit;
 
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings, bp->tx_nr_rings_xdp,
+				  bp->rx_nr_rings);
 	bp->cp_nr_rings = (min == 1) ?
 			  max_t(int, tx_cp, bp->rx_nr_rings) :
 			  tx_cp + bp->rx_nr_rings;
@@ -15647,7 +15646,8 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 
 void bnxt_set_cp_rings(struct bnxt *bp, bool sh)
 {
-	int tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+	int tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings, bp->tx_nr_rings_xdp,
+				      bp->rx_nr_rings);
 
 	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
 			       tx_cp + bp->rx_nr_rings;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 51a269d06c49..5ca98394a9ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -3003,7 +3003,7 @@ int bnxt_hwrm_set_coal(struct bnxt *);
 size_t bnxt_copy_ctx_mem(struct bnxt *bp, struct bnxt_ctx_mem_type *ctxm,
 			 void *buf, size_t offset);
 void bnxt_free_ctx_mem(struct bnxt *bp, bool force);
-int bnxt_num_tx_to_cp(struct bnxt *bp, int tx);
+int bnxt_num_tx_to_cp(struct bnxt *bp, int tx, int tx_xdp, int rx);
 unsigned int bnxt_get_max_func_stat_ctxs(struct bnxt *bp);
 unsigned int bnxt_get_avail_stat_ctxs_for_en(struct bnxt *bp);
 unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp);
-- 
2.51.0

