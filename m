Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5148E0C8
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101462; cv=none; b=ipUL0B6Z6brAo2f5ipM+TPbhv9HM+J36xE+a41ohe2UZjfZ8grv+lkSyo+Bp9WmQWiXt1zRtA+Cr0QX+yYPZmly9s5BBdydW/ZPvVqFwxW9UoP1CLm+Qdo3PRxCt1XXeuo0j9ZSLecDtM2/z4qwMZyW9LiBw3qyDSd+GIQkpyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101462; c=relaxed/simple;
	bh=+9ObR8sZ6oxPHgi0+oswXpBH/VC2XkRBGmM9k23GnkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvKkdDdHPYLuRbUyDky7iMacJDrC5Qhq/XEPFAxTtOh3L73HlKyKHF5wG3mgP92ZhzwFmjzRUXlj/jWv5v+jLLDUQQSs0q/+w0LAkSqK/dSqnsmbfFPb26OE2k8pt4gtoIlDuq3cie3icKfqk/GedL3ybipJ+bYQkUH9n2R1qG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=h+bxILWJ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="h+bxILWJ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so158278a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790101459; x=1790706259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWTLyua4wnNjgucbsZIX9QDTCvjLZHoMRXqqxyAwH6M=;
        b=h+bxILWJ0fcOr2kr70/9TAJ3oeIHe5ZsLkTkvIHLFRBXSqPFiEMI/FQAPR+OXLIX+G
         2LHQiQ85hwpPcn90NmmG1qQG3vGypWMpSU8ffjh0nHpeXJt1efbnLZC3dl70HESEmLhj
         1ejiEgrFjCDYV8iloZyCkSdG6VMKSy812Sin6Q9+YPGF591swkJneHWqZ0IJUR1bx3cb
         TYN8FUdPVv+JBWz2X/7X7kJiRd+vPv2KteUWdR8ce5dxdoNJqsAMpFI4x3oe+TYe/W0W
         QXOAsHdr+ytE/5Zv4KtKcDDvZdw9gf5h+/2qyli2janrqyyMucskgVHCbJoYdP9I0+sF
         UDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101459; x=1790706259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWTLyua4wnNjgucbsZIX9QDTCvjLZHoMRXqqxyAwH6M=;
        b=Y4AhgEJ/Hks/w8IIRRmQa0mQDI8YnILM3/mOFV0BBQj0+Ne74sS0wHmXRDa1oE9cuX
         2pMKZoHW1UnHsYWV0Arv9tXI2SpzgXsggWoVmS2sO61S7ddUnDZ3sxCmTllA3MBPEvwk
         hpEEGl9zKsUo2qBCV+mtHYZ4p0rei1mzYHcHbYDBC3EOcoADgNg3YQ76s8qfMdXUMbTt
         e8caBhLg7wW3FfQPhQow2Cv1KqjO0aER7rM/2U3WnNnfWOoiIl4f0ioHdi8PJ7mR0oxb
         vUfdzZfq0mTe0zK6LlcHvJgwf6jaPMhBkdbcsKLlu/4hw8JBvksImG90bXovV7T/w/zt
         2J0w==
X-Gm-Message-State: AFuF++kloQRN52ZmzZrEwH43lhOXcn3uh2BWsi67vTN5V8FAcHjFm+Sf
	R/YXm5t+bD6x1SAq42GklSEc54VcrIpnjYaolyY2Afk00Ofp0+0EHCRODwaWMW7NWAbdUgP1pYE
	DKmyk
X-Gm-Gg: AYBFou1MTqWF50paGlvciW05Yw+apmV+XqGoFO6yNZc89OhZmXcs1olHzRD9y3EYIah
	p8IFCKpfb3YYEXVrXJYfvM80B9BujtLYnxQhdC+scP4jgwaE0OvXnIvCIoqPc6gesxtm4CW3cL5
	gOP2FVUOzfGcf6UyrjeZ2ILlfWegBTqI4IdallHKwIGNsf2lILWddpHa4Ui5MOHV8Q1NsT/Gwic
	IaKk1AMy9yaMoIeVprnvdr3cqHf7BxptloRluYXwnuL3DZAGcrBHZvPPNCpaD7zlCa2YXMYFnXp
	uZjNB15pavHvB2+v1o9oDkQk5wDqWsgctmTGeUySi5ZHakmYTknd0hmLuvfbgXZFdOvJicTXo+n
	g0WGd9L3EhuJ5ujBrgYgcF/01N47Z0Smu23zu0H9awwrlgFvC6awNMVrrgtXt38jSzp3KnY8OoI
	ojNkFdSNh52oh5ksi3ofGMAkzcINEVoUPXnjuqvacKV3VEflB3wAGh
X-Received: by 2002:a17:90b:4c87:b0:3a0:516d:9f7e with SMTP id 98e67ed59e1d1-3a07e752ae8mr224806a91.45.1790101459604;
        Tue, 22 Sep 2026 11:24:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddf1cf3sm579154a91.9.2026.09.22.11.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:24:19 -0700 (PDT)
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
Subject: [RFC net v2 1/3] bnxt_en: return the RING_FREE status to callers
Date: Tue, 22 Sep 2026 11:24:01 -0700
Message-ID: <20260922182405.1290749-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922182405.1290749-1-joe@dama.to>
References: <20260922182405.1290749-1-joe@dama.to>
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

