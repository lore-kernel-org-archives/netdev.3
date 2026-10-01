Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9B48F006
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872762; cv=none; b=ILm0CcHCXXA4zu1AQIoW56hufLRdJ70WQ/nYibuinpkQjUN1tPF2H7WH3c3APebjdgv+XLzatLYStmBE0g3dWPdH/E+zC9EbCfEs5PrBkGwJ9sgb2wjgLOYb6qoCMu7qyEsqmdlWpRKgSS18Rq6gTqKofTFax7C/pSlXZIzC05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872762; c=relaxed/simple;
	bh=5eEyieqmHMszBlGZ+dTh2KjTjHoncpn9M6WHXl5Pdb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YysGyS0zffU3gC0UfugOx9wzIj7S8Mst7nHCJnwUsKHwnstQUwV/0Yfb9ZF5gr/NuGEpg+eeD1DmPe754Tf7A93AAweBxWb5a3K/mj9ECri7u12/YxGpq0oHeGYgtTjzVcBboQM4fYgHg9EmMZzJ+w/LW5/Ivwse3F3SQ+KoAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzMRaz6C; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzMRaz6C"
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-81a86afd781so3041874a34.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872758; x=1791477558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAKEBIit+v4BKWlpY/14WoleWJpA6zoSyagZIX4Dlao=;
        b=SzMRaz6CAdMypJbNANJJ3+BfkL8cbHaGc/M4MNuL3PWgOK1Kpoh32kajjAHYEVMWKh
         eK/eaQZ39kkf8vrYhYQu5nUDPxE7ucSb4dVfvmWe9r700kYxIACOEWYR3pd85zyU82bm
         use12r6z5fmMqESnpMzc3Wb9XIg5ANkesJLvgAZqSC3Q6NwWh6kCKjo8KZWerZnUb+2J
         qZAL5v/NNclgq0yFDVWcXjxB4z4K+IMvBHw0G5ml5GBTokBDu9dgxtLSq5HfolvUtOdT
         3zMfkgYFF3TTNM6SpRvl6SyxsMyiLxQ2KwyOAemWouA0FreenUMr0FC618kVrk8DUyb0
         Y+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872758; x=1791477558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAKEBIit+v4BKWlpY/14WoleWJpA6zoSyagZIX4Dlao=;
        b=dMKou6nadIIp7chP8/RyvfA/x8LyjVnNiqMlyd0BBRHU7re2nUOv0JIf63Lom7zXrP
         giJtBi02k6+WEZ2NqXUDxWkSUjDgYBEljwRF0QADb7vs1I2eXyPTb2R2oSA0snLI/1ye
         79YT/t3WOYQtN2EAViSR9JdC/36IAl+yqHZWHHObTlJqtnu9WlROXgv2mX2+J4S9q5JM
         NBqU/OEQdrgos/+Oihcz/C6pAK9nD6dRdTgH7ejjmitIv4x3eSpCyQF2gx238X25Zgv9
         UUD4pGIGSWOrCKome/eZwBKrqKOu5CcYz3MAyBli3mbq/B7F0/jYwMyhiNJd+YGUn07E
         nJew==
X-Gm-Message-State: AFuF++nBro0OxmbTaVWTXML5M3UMv8suCl0+8krKhIDOhfVPz1oGwScG
	QLujCxNEkhVPIrPHaL6PwNQgjMrR2E0ZnTl6+6xyNLl6cFgvtmdN9glQ
X-Gm-Gg: AYBFou2z6yJYfHp6FLOpS/BHdiWn3+y4Hp/g7B0MZSx79Hh0iPWSvoKZZ2Ruf3c5eO7
	P3gBOZUKCw+p/85cktaxQjatYEpp9XhpNq17lF6iY8LIolgGtkYRSeJCwZ9n60MDBULqlyOk95N
	bvlER1VMMxfP0tT510dLCZjejmqhgi+6oF5JsGU8rIxQYbT+nxLsFFx7TKWzhDOlpKWt0RKOm6h
	iHESfdqptedzSr2yvEfleipdka0sgq6o1LaCfMa9tPb9CegO57l2g3rbd4EOzcMlgUprz0NuHQm
	YpkqIPUKxZJVkx+CSXtdUX/k5FsXv8N6zmz3H76qo3g/LO03Xs3ZjqP5r6qDSjdSNDFZwIfK8Pk
	+n7M9SQsmp+TajV+XjgQpJ6OdxNBNehTpUSuZHIcNFSKstqRzp7/u1HI2Z+rnBGLUQHHvIwjvV9
	/4snIYvCycLJoxJePYdgIq+4u19DuF1xAC19eDdyMol6q+jns8plDJ9MYzOMyOc7rPcHFr
X-Received: by 2002:a05:6830:374c:b0:81c:4784:a5e2 with SMTP id 46e09a7af769-82283f6568emr216716a34.6.1790872758576;
        Thu, 01 Oct 2026 09:39:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227aa6cdf1sm306233a34.26.2026.10.01.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:39:17 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 01 Oct 2026 09:38:58 -0700
Subject: [PATCH net-next 1/4] eth: mpnic: use WRITE_ONCE() for BDQ head and
 tail updates
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-linux-mpnic-v1-1-6422ee74233a@gmail.com>
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
In-Reply-To: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

Convert writes to BDQ ring head and tail in the NAPI path to
WRITE_ONCE(), so that a buffer NAPI depletion check task later in the
series can READ_ONCE() those fields from a workqueue outside of NAPI.
The remaining writers in mpnic_enable_bdq() and mpnic_clean_bdq() run
with NAPI disabled and the instance lock, so don't bother converting
them. The NAPI depletion check later in the series will run under the
instance lock.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index edb07b7f334b..49061c7316d5 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -384,7 +384,7 @@ static unsigned int __mpnic_fill_bdq(struct mpnic_ring *bdq)
 static void __mpnic_bdq_commit_tail(struct mpnic_ring *bdq, unsigned int tail)
 {
 	if (bdq->tail != tail) {
-		bdq->tail = tail;
+		WRITE_ONCE(bdq->tail, tail);
 
 		writeq(tail, bdq->doorbell);
 	}
@@ -483,7 +483,7 @@ mpnic_pkt_prepare(u64 rcd, struct mpnic_rcq_state *state,
 	pg_start = mpnic_hdr_pg_start(pg_off);
 
 	page = mpnic_page_pool_get(&state->hdr, &qt->sub0, pg_idx);
-	qt->sub0.head = (pg_idx + 1) & qt->sub0.size_mask;
+	WRITE_ONCE(qt->sub0.head, (pg_idx + 1) & qt->sub0.size_mask);
 
 	/* Short-cut the end calculation if the page is fully consumed */
 	pg_end = fin ? page_size(page) : mpnic_hdr_pg_end(pg_off, len);
@@ -513,7 +513,7 @@ mpnic_add_rx_frag(u64 rcd, struct mpnic_rcq_state *state,
 	struct page *page;
 
 	page = mpnic_page_pool_get(&state->payld, &qt->sub1, pg_idx);
-	qt->sub1.head = (pg_idx + 1) & qt->sub1.size_mask;
+	WRITE_ONCE(qt->sub1.head, (pg_idx + 1) & qt->sub1.size_mask);
 
 	truesz = (fin ? page_size(page) : ALIGN(pg_off + len, 128)) - pg_off;
 

-- 
2.52.0

