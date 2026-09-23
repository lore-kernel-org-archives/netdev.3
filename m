Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFA3C819B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197681; cv=none; b=ukv+EBauCRrd2tRgC5Yym6oGJGTDnL0yXShWvO21cI6JmfpbNEtL8c1Nk9pWitobnFROnBO1KCLsKEqg0ifkbrZ4Po+xeinNCH3B9Yleoxnwec4o6KM1q2rb7hyeHCp3sMHr/QqGXKzR9WYgMnMAxI8xsdpu9QhXZrjXvJlEzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197681; c=relaxed/simple;
	bh=+9ObR8sZ6oxPHgi0+oswXpBH/VC2XkRBGmM9k23GnkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWRUIG6RRNB2aHLR8xn+Hl7jsQLrifKrn6zi27NFSnkhMSlFSp7e/x469haPXwLcSVAL8MHit5VrmxqB5XzVaAE8xjtA2CWVnl6Nzc0Q/lxXybbdZCYuXWQb43C/VJzuXMdccaTEvKIKvPxC5i/XQquwtC7nmENOUWirH4HNjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=wfbQgxt9; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="wfbQgxt9"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d90ba1d807so13678665ad.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790197674; x=1790802474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWTLyua4wnNjgucbsZIX9QDTCvjLZHoMRXqqxyAwH6M=;
        b=wfbQgxt9wVGDq+cXS+L+LaX7wdr5CRtLon/t403RyCFwYXjB3hfJzoNqDQ96mfXdXh
         werfKpVRB+HKdp1JuTW3ssoTBjmLIcs9UDynfmavMxu8ao8bf8rt42nGF1x2/pMC5kg1
         BrKPpvv3xxxLWZTvrCosPE7Qpu1RA9nQG7608Mb1ap9g+HRXafDLLMlzP0ZECrV2WQkE
         7mPcKF5sdoCZ5BvNJ56FAKX8pHTSzoK9ho/4n885WsffeOsQBIRJIvZGePepgEDWnsZk
         YmiioLxGDBJUrVtggnHAAtS7bKBzi6NHNPK0ApogyxFThQv4Uj4RO6mpXcjFzCta6Yy7
         s8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197674; x=1790802474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWTLyua4wnNjgucbsZIX9QDTCvjLZHoMRXqqxyAwH6M=;
        b=tJnY848NiBtnUvexSAHkvFWNkmZgWwi5OQUdMgqSu5/P9TTLOzXXF0QOxzAgxtr53m
         SVPMrt0jitBgCgqz5dz3ZIG2k8jsQVWcU82u6TBF9pAP4wDiUt4Xk8Y3gnkJHf+16zJb
         liryF9ZcT7XUiQ46PVZqsLqNxFgagLid+VyXLnK1ZlGhJQqVROo6MtLaQFHA/YQiM8y2
         N/bG9DIdC8yeS83ZYsnMJekrzuv3P0Uz0P3/tEy9C/0R3z7iiHW0zOcnvuEVihQDEDA+
         Fo237JTQbX2mUlF4FUsZu2KR3OwmAlKhHaMaCPaMaLlNIUSAIxREcFNTR/Hnt43I1cXJ
         06Ig==
X-Gm-Message-State: AFuF++k8uR8pJ5f00on6KW4Igod8wTademz19NCEXGWTeeuZBXJ4M+Rr
	lgtROL5OE9veZaPsqHIYo/ZghopugvdfklIvKG08Cjj/0uubgtym16Q55atrX6Gep/p7JH1vNix
	lG0vd
X-Gm-Gg: AYBFou1q/vpgA+d795YumHYblHVwJmWsmoN3gT8j7wPTraokU8SDPSdtuLgzREFj/dm
	dZPGtWKnq+ULq5dcD2ZdsXOejMcQNqix1dyLook16iv4VyzMBxFo3iTf5ZmawXo/RKq6YwDM4Ui
	e+zgveyvkGHXrb9AmjcZd6aWhMfGI9CDw8fpGwto/H4eS7PbuKOSWCpCEp1wF3Dw0WYuZ3jPvZb
	iLlSo5UPeWpZzIiJqtCIk4+mczTScogkTVCuLutgGtjXIYeC+zj0k9okR+s3e8ZWLasNy6q16tY
	2FWWoBPz88DSHfmo1JjLxxElXyF7NiGJd+A3ZRMga4/Qo25Q7hKkpO91qum9fQ2E4NcwgcwcxPJ
	cxeHzFvXZJrWm93+xIR/FKphWKDF8UpFZ1PYljNngPSbvAvBAr2rRLyHx4Ow8N1fBc8UetlpQbU
	7Oi53DoRvFFE0OGOOq1zsGdjZ/k4C9RQGt6AOwyNOVyMlhK2YaVmb7
X-Received: by 2002:a17:903:908:b0:2dd:c053:a6f5 with SMTP id d9443c01a7336-2df7dc41ad5mr3196195ad.39.1790197674312;
        Wed, 23 Sep 2026 14:07:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516d58sm16931435ad.11.2026.09.23.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:07:53 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net v3 1/3] bnxt_en: return the RING_FREE status to callers
Date: Wed, 23 Sep 2026 14:07:40 -0700
Message-ID: <20260923210744.3406861-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923210744.3406861-1-joe@dama.to>
References: <20260923210744.3406861-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwrm_ring_free_send_msg() reports failure to its caller, returning -EIO
when the firmware rejects HWRM_RING_FREE or never answers it. All three
ring free helpers that send the command discard the value.

Return it instead. No caller acts on it yet, so there is no functional
change.

Fixes: 74608fc98d28 ("bnxt_en: Ring free response from close path should use completion ring")
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 48 +++++++++++++----------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d7728d0c5b6e..a7f6facca7b4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7660,50 +7660,55 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
-static void bnxt_hwrm_tx_ring_free(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr,
-				   bool close_path)
+static int bnxt_hwrm_tx_ring_free(struct bnxt *bp,
+				  struct bnxt_tx_ring_info *txr,
+				  bool close_path)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	u32 cmpl_ring_id;
+	int rc;
 
 	if (ring->fw_ring_id == INVALID_HW_RING_ID)
-		return;
+		return 0;
 
 	cmpl_ring_id = close_path ? bnxt_cp_ring_for_tx(bp, txr) :
 		       INVALID_HW_RING_ID;
-	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
-				cmpl_ring_id);
+	rc = hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
+				     cmpl_ring_id);
 	ring->fw_ring_id = INVALID_HW_RING_ID;
+	return rc;
 }
 
-static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
-				   struct bnxt_rx_ring_info *rxr,
-				   bool close_path)
+static int bnxt_hwrm_rx_ring_free(struct bnxt *bp,
+				  struct bnxt_rx_ring_info *rxr,
+				  bool close_path)
 {
 	struct bnxt_ring_struct *ring = &rxr->rx_ring_struct;
 	u32 grp_idx = rxr->bnapi->index;
 	u32 cmpl_ring_id;
+	int rc;
 
 	if (ring->fw_ring_id == INVALID_HW_RING_ID)
-		return;
+		return 0;
 
 	cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
-	hwrm_ring_free_send_msg(bp, ring,
-				RING_FREE_REQ_RING_TYPE_RX,
-				close_path ? cmpl_ring_id :
-				INVALID_HW_RING_ID);
+	rc = hwrm_ring_free_send_msg(bp, ring,
+				     RING_FREE_REQ_RING_TYPE_RX,
+				     close_path ? cmpl_ring_id :
+				     INVALID_HW_RING_ID);
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	bp->grp_info[grp_idx].rx_fw_ring_id = INVALID_HW_RING_ID;
+	return rc;
 }
 
-static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
-				       struct bnxt_rx_ring_info *rxr,
-				       bool close_path)
+static int bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
+				      struct bnxt_rx_ring_info *rxr,
+				      bool close_path)
 {
 	struct bnxt_ring_struct *ring = &rxr->rx_agg_ring_struct;
 	u32 grp_idx = rxr->bnapi->index;
 	u32 type, cmpl_ring_id;
+	int rc;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		type = RING_FREE_REQ_RING_TYPE_RX_AGG;
@@ -7711,14 +7716,15 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 		type = RING_FREE_REQ_RING_TYPE_RX;
 
 	if (ring->fw_ring_id == INVALID_HW_RING_ID)
-		return;
+		return 0;
 
 	cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
-	hwrm_ring_free_send_msg(bp, ring, type,
-				close_path ? cmpl_ring_id :
-				INVALID_HW_RING_ID);
+	rc = hwrm_ring_free_send_msg(bp, ring, type,
+				     close_path ? cmpl_ring_id :
+				     INVALID_HW_RING_ID);
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
+	return rc;
 }
 
 static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
-- 
2.53.0-Meta

