Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6D4B0E5F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358255; cv=none; b=sbZh8/VuzGQcM3UCgPsBAf3kANtqY6y+KrQ8dy6BZsJSTcUP4/KZhSFXKShbaDTiktkfQVtJvGdFELcPlrKJYD2re2cFalusArtZliLgyYH72szd8tJFmutEM97JMgHNTEQu1SJsKHY297SfgzMIi0jFnCth5gq2TfUinZ70/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358255; c=relaxed/simple;
	bh=+9ObR8sZ6oxPHgi0+oswXpBH/VC2XkRBGmM9k23GnkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itNn7oF2OuCl28hieiwe+CTfIhPkcLWpJUAYsTcku78BmHlUesE8uYAdZn8D/dKlVLEs9WRbcgApuJ5gFhrqRUdpNgNDz9tcE7HdSjG62HawgCRcm5R240YqyUnU5uA5Ly6NF/zxSFInQw0vpP2xrYiSTqT47LOuihayaeF/RfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=N0m0RkQd; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="N0m0RkQd"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so319028b3a.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790358253; x=1790963053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWTLyua4wnNjgucbsZIX9QDTCvjLZHoMRXqqxyAwH6M=;
        b=N0m0RkQdl2gk68EeVMssiXX2sGxfa0SmJCzdeuQJLtdBUhmdQemKyFL9pdKnHF9kcI
         ssFi8QOXPB4dXM6F63wcbLbjIVPkUMcEjcURs5QajggNEgcr0TgTyzPLrZ8ANl8S10wt
         SpkPbvlz8TzU11sXkh/x1ALRmNZs1WYpz/4ePR+gkmhzENwwWHrawmw2E8NqhkjRc8RP
         B/IHmZ/rO3tsJ6E8tXpSW0emtF7xKMNNs7s0Gb7dmj33Y2G+KbL8RTdRa2cuLQ/rkME2
         Sk6WiyG/csQ6mYubm2L7/W1v+GBS1y/j0XlGrqpQirL28Ato1EY34NjfNbDKSM22UbS0
         YWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790358253; x=1790963053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWTLyua4wnNjgucbsZIX9QDTCvjLZHoMRXqqxyAwH6M=;
        b=OlhU77nb9SF1DMDD29yUCif3BEFc1vAimn/bTzVFE8h9j0EfjSvNM5KHWAu40UfqnR
         NqSk+NaBPbFa3fsw0H1ocnPrhOtWIiC/3Jjs5mQ5me3x/1ANz5LoL1dGr5tuLUlGunku
         Rl+QARArfF89a7NMlWHgv47ceSrFgb5De/dOqJV5aU9zIFJrELnpkxWDAF9cMIp1hQwQ
         vqbOtQBoFZtMcaPkA6grLAbVsedJ9VuPjVT5TgMXCAnQEcxLzJJmuImrDhelh0fmvsMV
         jRBXZqVMFenP3Hm97Gh70e9U1wIxnxwzaI9DMYCDQYRJwXWQyeTREZ9eE9CWPn6N9ej7
         8RgA==
X-Gm-Message-State: AFuF++lUMz9Ge5YTiuiN4ypq3MP8V9eqd8+1M2px+bK8By2feBf1Loka
	uymXxkjgvmiwIDO774O17JjxtPBXAV3HWj2vAIbquFcvEDYRABIkMmvD1ppB/LHOTEzNwYXwdeT
	wkk2I
X-Gm-Gg: AYBFou10fGP0s9QHxuvoLPbkPtT/tbs7X+Bn1UNgelayYUWB6LdkVC1w0fbh0ZhRGkk
	LFgEK+No481eFSqcHZUoZL3SeQycp5ktuVR1dGedcjLnPZqDrYoNvzuxSIV+c6lo8Ugm7h/JQNO
	H7q4n+6xBreWsPORmDun8waDjkYyZy0DuvGx7+sKHP2X+9YoN5bBSguCuyifk8eQmfuC0VW8r7z
	o+ffBNSyTVTnNwPQqhSXMl8mo9MB15huHT7UEr/2sDMDqT3Nid8KfBxd/KilXryH0NtmkHFGDTU
	dE6NwoHAaAs4PkPh4pWxiBPEziY+TmUJqeto9EpruV0zRnE4HAyjEJDBLP8HSQspQjUUTAwiF+M
	wlmBAnxkf7MWkteMUqMwzonU8bDNQKlRZl3zSDZOqF3uboG3JUzKG/m02VLL0iVxsHsy02p+Eb0
	MzCRViyI2YYrpnwFShHYO9BNuODozm0IYv1Ii3rgYy31phN5u6+6GDgmgsnv+IWZFcRDE/+v/Qf
	F3tLKAmeRM8Map1akT3D3s=
X-Received: by 2002:a05:6a21:505:b0:3de:141e:c712 with SMTP id adf61e73a8af0-3de141ec98amr3845520637.14.1790358252614;
        Fri, 25 Sep 2026 10:44:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea88dc7esm1528404b3a.30.2026.09.25.10.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:44:12 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net v4 1/4] bnxt_en: return the RING_FREE status to callers
Date: Fri, 25 Sep 2026 10:43:58 -0700
Message-ID: <20260925174404.2789072-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925174404.2789072-1-joe@dama.to>
References: <20260925174404.2789072-1-joe@dama.to>
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

