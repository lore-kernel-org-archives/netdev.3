Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F6334C3D
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257863; cv=none; b=LYmLcu54G4FtzdY4eHAAIga/TbAp3AVdSHLrX1UUdjJMW6saRGd3QOYS8u/fTTd5d4rQvVHojFZpDmIkuJfUkA2/fZxngZRb94x6zKRAYdMY5NLbNdwW4qRPKSteZGVxkDzTVlR0HTpN5ncCIvvqzsXkaQy8fWYkBYsliVvLU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257863; c=relaxed/simple;
	bh=UpfYu1DJ0rtT1f+tZ6nACbUEG9PQRwQQHbvOwKhznPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqqYky93OzTb65cGkuhmVbAEsXQ6LFsJi9hHIsFwFkxyVHF30tHQp79cP0I5es1dJpu0G0eVv5Zfsi7cX+sgULUGeshdLEnhLOkhuKd449PFDI9t034h+bdePNfJEjMpfdpMvrIeU2FV3CqiC03WKZBPH4ZCD1GZmMUKUIuuyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmrotLKV; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmrotLKV"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f5603a0so300227766b.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257860; x=1790862660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gII017pjaiWPy7eQPcmYTXbw9whvLxZWHojjvAPZMqM=;
        b=fmrotLKVqMqevan9qW6NB3bkmJyasxUpUHR31b5XQkAIn2cuIOWa6SHOzE2gFrIPn4
         R0AQEwVbA6AFR8rB8eXe6Hxis8zvxagizcLuvSAowPnh4TtUUM6eR4P+mEcSddC+JFAF
         RjZVJEHsaqq1ZaNNJwKVRN2BpLMgcmYo3BFhrDaKvEDV4tlfk7AD+HcSJ6jBMrgTC5Sr
         IcLGGpZruyXOeIJ85XpQhgpybZXio0kEOlhEcAnYH6HdjLZhJ8Mgi4nZxThyAe2DKRCV
         d7z5p5nJBQfjRzs9x9dPLq0bGM6H92VOzOdJK+9tdw6iQ44U1lzZM8uzUtXBTXB07PWu
         bq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257860; x=1790862660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gII017pjaiWPy7eQPcmYTXbw9whvLxZWHojjvAPZMqM=;
        b=Fn6c6ne9+Bbj3kvUQArdKwWBmhOyEQ/AVRXyJqOhu1Yw73vPKs/y+tRxODvNNLQxDA
         D3kY+jJJrnnw+BC6Wwwrl5r8zUps4CFdQv634i1RTl8eYOu3AYXd5nAmLHEZdtK01HGu
         3aORQ1YN2ZBurmWN24NSTrpCFSpMSV8bkIOfvdh9uA6wfWTvhu7uetoCPkxnYmtkHAJ+
         PuhtKJX+2mGH4eX8VBsK+mTVJC62WPlVw30aYD0JL/v+7AtVQzl65ng44pLALB9TRGAh
         ff0OO18if6xnuoEnyKNe1ZLlHNSOQz5PXvqSBkIO4hek9ZLBFDyOUgufv4urzILu+WtU
         RgGw==
X-Gm-Message-State: AFuF++lQJoqEVf7KG536zH/4kH0ViMm3i4RH7BDKAPKs9zX3GRLdmXxf
	FN24clQ8gN89YkvMaqJbXOCvSIl23ChcFwm360zfktyBQEcCoo4iY/a6FbwXpj3V
X-Gm-Gg: AYBFou3iItxtgCNAin3ALdD03YAlNxAodjlWMJkgDyhTmqtamN0dSN/8ZACvTSlLU1H
	FMtJz+eCPEPddsG75RM+cMt7ACKP0EpO/4JSb776H+LMtYwRZfGk4rm7DbktlPFV3VKM7BJaVj5
	1z6GWEng2RjrupSUPChpEJP2E845/gCV5m09xmAU+bA7pQgr7I4SqV6tu18UbCpZdY2tqhlHE6d
	Ki+dfVmzS5rX4I5tJTDUKga/E3ucxUaG+yH1NcByqN2vP2InvZHgDn2G05MzqFk9Pcsr/fefxOZ
	w5t8HQLqtjbj5yf5vJl5aJElx6v0Bslgp0Iw01MKXe6Vxl8mIKgIRJem1dZCyxvRO6d/0fhi2dd
	HI+ByCdpQmgk1wD50JI8VMuSt1Id9UBp+lXn39u+R6JvX0TkfhTt3/3Vk0JPAtk2Y/2QDPTiMD1
	XpXl7Qn1qvwf2EHnVuW/3n6LvhtRGvfp3gp9dK0V6OIhbJo1aIPhIUBclfRe9oCx1xoer4zo23o
	pbBMy7QnyEwEB2Jz1yvoiQXzDoO1sPNCrXZ9t/v
X-Received: by 2002:a17:907:ea8:b0:c25:8bf0:36ef with SMTP id a640c23a62f3a-c2ac2409273mr221371166b.14.1790257859622;
        Thu, 24 Sep 2026 06:50:59 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6ecd17sm298110766b.63.2026.09.24.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:50:58 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robert.hancock@calian.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v3] net: axienet: bound TX completion cleanup by the NAPI budget
Date: Thu, 24 Sep 2026 16:50:52 +0300
Message-ID: <20260924135052.185129-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_tx_poll() passes lp->tx_bd_num to axienet_free_tx_chain() as
@nr_bds, and @budget is only forwarded to napi_consume_skb() as its
bulk-free hint.  Nothing limits the cleanup loop to the NAPI budget, so
the number of packets returned is bounded by the TX ring size rather
than by the budget, and the poll can report more work than it was
given:

  eth0: NAPI poll function axienet_tx_poll+0x0/0x180 [xilinx_emac]
        returned 96, exceeding its budget of 64.

Returning more than the budget breaks the NAPI contract.  It also makes
the "packets < budget" test in axienet_tx_poll() false, so
napi_complete_done() is skipped and TX completion interrupts are not
re-enabled on that pass.  NAPI reschedules the poll, so this recovers,
but the accounting is wrong either way.

In steady state fewer descriptors complete per poll than the budget
allows, which is why this is rarely observed.  Triggering it needs more
than @budget completions outstanding at once - for example when TX
completion interrupts have not been taken for a while and a full ring is
reclaimed in one go.

Stop the loop once the budget is spent.  cur_p->skb is only set on a
packet's last descriptor, so breaking there never leaves a packet
half-freed.  The check is skipped on the @force path, which cleans up
after a DMA mapping failure.

A budget of 0 is a separate case.  netpoll calls napi->poll() with a
budget of 0 to reclaim the TX path only, and expects no work to be
reported.  Treat 0 as no limit in the cleanup loop so the ring is still
drained, and have axienet_tx_poll() report no work for it.  Returning
the reclaimed count would trip the WARN_ONCE() in poll_one_napi(),
which the unbounded loop could already do before this change.

Tested on an AXI Ethernet MAC behind a PCIe endpoint: traffic passes
with this change applied.  Neither an over-budget poll nor the netpoll
path was exercised in that test.

Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

Notes:
    Changes in v3:
    - Report no work for a budget of 0: axienet_tx_poll() now returns
      "budget ? packets : 0", so netpoll cannot trip the WARN_ONCE() in
      poll_one_napi() (Sashiko).
    - Reword the @budget kernel-doc and the in-loop comment to cover both
      uses of a budget of 0 (Sashiko).
    - Drop the wrong claim that a budget of 0 matters to the @force callers
      (Sashiko).
    - Add a hardware test note, and the Assisted-by: tag that v1 and v2
      omitted.
    - v2: https://lore.kernel.org/netdev/20260917115657.20697-1-maimon.sagi@gmail.com/
    
    Changes in v2:
    - Treat a budget of 0 as no limit, so that netpoll still drains the TX
      ring; v1 reclaimed nothing for it (Sashiko).
    - v1: https://lore.kernel.org/netdev/20260914114821.55503-1-maimon.sagi@gmail.com/

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 782f903d318f..7fd77f8cb57c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -772,7 +772,11 @@ static int axienet_device_reset(struct net_device *ndev)
  * @force:	Whether to clean descriptors even if not complete
  * @sizep:	Pointer to a u32 accumulating the total byte count of
  *		completed packets (using skb->len). Ignored if NULL.
- * @budget:	NAPI budget (use 0 when not called from NAPI poll)
+ * @budget:	NAPI budget, or 0 when not called from NAPI poll; also passed
+ *		to napi_consume_skb(). When @force is false, cleanup stops once
+ *		@budget completed packets have been freed. A budget of 0 means
+ *		no limit: netpoll polls with it to drain the TX ring, and
+ *		axienet_tx_poll() then reports no work.
  *
  * Would either be called after a successful transmit operation, or after
  * there was an error when setting up the chain.
@@ -788,6 +792,16 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 	dma_addr_t phys;
 
 	for (i = 0; i < nr_bds; i++) {
+		/* A NAPI poll must not return more than its budget.  Stop on a
+		 * packet boundary once it is spent - cur_p->skb is only set on
+		 * a packet's last descriptor, so no packet is left half-freed.
+		 * A zero budget means no limit: netpoll polls with a budget of
+		 * 0 to reclaim the TX path, so the ring must still be drained;
+		 * axienet_tx_poll() reports no work to it.
+		 */
+		if (!force && budget && packets >= budget)
+			break;
+
 		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
 		status = cur_p->status;
 
@@ -1027,7 +1041,11 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
 		spin_unlock_irq(&lp->tx_cr_lock);
 	}
-	return packets;
+
+	/* netpoll polls with a budget of 0 to reclaim the TX path and expects
+	 * no work to be reported; see poll_one_napi().
+	 */
+	return budget ? packets : 0;
 }
 
 /**

base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
-- 
2.47.0

