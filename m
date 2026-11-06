Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992481;
	b=Cd3mSOTWua6djjzM6VDh2Iujl4clJnUSxDxCnQDh67JivT5BSgH9tyRLLoPjz97syhZS
	 ohX//AklqnPPL+v0fIP6Snz3V+velPF7NvCvlEIcHGNZZ9nCdqbJmnzycG7CJcjbhfY6t
	 xTw66FWuZZtNV5Gg7+a3h+BC2ZEUHTp6yQ5Zool8nqnKvtSL2ZBZKgq6zqW+32R/yvpWQ
	 1CoA287jhJXqqHRHTtWXUIKc+ACYA9SwwU0g/q8T9tI/iKgP7ZdFxgYc1sq6ouLHWk1YL
	 eulpJd6gbdFAEzOmrmXIRcFThetQX/VBCw4HH5aMzUGrlLtzLo++g2MgW4gWj2LLVKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kR7S8/i1XKTNJkCLT9lP58PFvpoVq2NqyFukFmYlwWE=;
	b=s6eEn67De3k8SyGRrQJxIGdZZ891SKtkUIeBS/Hs83a8HpJf+DynD5uE58DWrNLYo7iT
	 l4RPeHSe6ZmqOLUQjho64SUA3DsLAC/QaCvoLlyYUprcxYUZh7pkwAPjhbtkg5CHt+FuP
	 IrSjThYk3iVXKAppx+ZxndfiOLg7DfLEqH6yBh9uw+Z4MaeIdlbG/qEaKpUA76LKVERrH
	 VHbpW0iuMwUZSN6ChxeXyGXct+wG4sSQyTQTufGqpF3w+ysUeflu5fE2/3n4AFhmLIGio
	 CXwWhe0OpLIlARFztljnSqMIIwrxZiS+LCguXJAJBQesmEW3njAYwkO4Xsi/EHjIrJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hueZ5o77;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28789606A33D
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28789606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hueZ5o77
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso667700a91.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793992480; x=1794597280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kR7S8/i1XKTNJkCLT9lP58PFvpoVq2NqyFukFmYlwWE=;
        b=hueZ5o77w0GjbixA9TUefLk/Qk2bmsTihilVYhlQVmeIQl/8hgG39XKrLqIdCQ/Bb/
         2qRat2cs8sYtcAESSLbzRDghv9hPq/rN7I1Gvo4LP6pnG/WXDO4bOyujeAbl2Zgnfewk
         Nq0V5ey4fhKgb97cUsks8ewTQaCsKt4qzl/HjHKavifbAaSUbNHKt1wtRP4GiqKnohMy
         DNcpvFi0hdmbU8RgUSksBbjESGYjOwFCMPpt0BfNQT+UJnDMRRsLppX2uhiavk0cvwm7
         LBlJRT8pTTWjgtF/x88JKTSFEFOYkx3fA2XGF+/oxAit/WIKGAb3niHt70YnhQVRlzei
         hj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992480; x=1794597280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kR7S8/i1XKTNJkCLT9lP58PFvpoVq2NqyFukFmYlwWE=;
        b=MZf5esEqZogDv3klzrdsNCcRixateDzkDpMAredUs+CcN+h/bDL7rMikh6G4/U8J4G
         X9Di1D92jO6yJItmcjvC8Mlgepfx4QdfWdNtQVPSBiJ5KM56W9nOw6uRwLjGk57k4hjE
         PYE3qoPnpn2PZfylGMEL9HTpDrHIdfLTejxC7rsmiCLfCQzT10oIBPwpB8lCwEeMNzZ2
         Aaz0KN4CJ4e11/tdwLVnm0B0XqRZe0ftdQQx8jU68gdP4b1pp7cwEgdQxlCqxREfjyGa
         0S6FLNBrhwLBhfk8Q2AjJ9srnIfhJ7CAdfnvqW8JNUQyN750855fQ8dfix+Yz4fq3D6c
         2aDg==
X-Gm-Message-State: APuU4Z9oaMutREnZjsym7Co/GMsl0PTyc1B09qnnrCSeCJkaHgoy7nc5
	GHXcC7cm/K18Pe4rZ7jMYw8fI9/8SRB7bs/7hvRp0+Dzn5hCo6NymnvSW1CVyKM3e5vTaA9Ury4
	ovNg9
X-Gm-Gg: AYBFou0+sV7tqFJ3NBteN2Z+vzT6Ep+zFPOHqbOMy2e5AgTkO+xH8WrZfrbuo4JzxBW
	+WY0U0rKqXrh1vB1JBC+U/MU8JfwAelGABAcOyxFcYI/IVfw33jaMzSHYV4Oi4HHqBU5jBw96zM
	xPTBb+rigBxSI9um0D7kWnG22mhUgNT9ZvmZwyetB2W1hD/zWO1RkOtOCsS35ui79EV4brPocZI
	YJoiY04ZQx6G9tsDWkJlkTeIgdZq3+nj3THStA0Cg4USaj5jQjF3UoxGoMUHnQF5RaYdRjdy+fl
	YwXu8/WyLTL5QnvODiu2BYFAH43vYgEzSfJk8NTzYyiWdtQ7kCXc9YOw0L8otiOlzfOxvV//siC
	svlMcZtjojpC2uiNO9SAkqGn+ZZ0uGyBlHbU1Yys99QygR2HI3T5moJ6+hwiR0Jdj3Lmw8sbzwV
	9zaOnSyyqvOmrk1DVysefA0xi3F5Zt779/8TUaCeIvY6fVuxifDG8OhD5tAJj6Tx+UveTqEhL49
	0aEdtPjFW9SDF54kazh/y+MitadtBOmz0bPxCt3PpHkmawNbNF9EXoNUGyolIBfk5WJ/FWnhe3k
	gytL7eW7RJ3qfF7bbDoQfzjfldeZSPbTzLaKG2ZufMM=
X-Received: by 2002:a17:90b:2650:b0:3ab:36c4:b500 with SMTP id 98e67ed59e1d1-3b0db6058fbmr3536892a91.5.1793992480508;
        Fri, 06 Nov 2026 11:14:40 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105854fa9sm77446a91.15.2026.11.06.11.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:14:40 -0800 (PST)
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
Subject: [PATCH net v5 1/4] bnxt_en: return the RING_FREE status to callers
Date: Fri,  6 Nov 2026 11:14:17 -0800
Message-ID: <20261106191423.4194081-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106191423.4194081-1-joe@dama.to>
References: <20261106191423.4194081-1-joe@dama.to>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
index 33c4cacc8ffe..ea8529c78994 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7679,50 +7679,55 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
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
@@ -7730,14 +7735,15 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
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

