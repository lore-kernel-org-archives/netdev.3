Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BD4D9F84
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646246; cv=none; b=RNrco48RijilQl30hZV+XQxr0pJmRippa6iXvvAe7ONClbi66630dARvYIT73xUkDmdwV14j6fE2aIvtZwxY8IawvGTmnJWvShKv6J3RN7xQn9PajF8QtlzYAHsvOG+tQBLlYUaBZHk029RqfJy8r4YvnsE71GffSgCN+IotY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646246; c=relaxed/simple;
	bh=/JmFXBnZ5o6iVoL/3jZKa1soaX4Hw/WgDxT/Fm9DA54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpRdRXjn2LlMBpV+qYc5z5UiTNgAAboP33lzgV5Zjcq6/o04ZpKXYaS4QPDIA7C8dMmkvYoad07sC2VrCygfggRzLyPdrT6Xa3uxoT7lWfBQVATuPRwZcnQC3nmmdmV9iEncTba7IU4iRkP1EYP4/NXoWNJEWcoDX8em7BnZ4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOUKS8hb; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOUKS8hb"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so4566335e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789646220; x=1790251020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ePwmsMkUKDU1SxF8E4e113FncU/+AY22Hw2g6GemxcY=;
        b=gOUKS8hbOgrYl8blR/OahLwLOP221DbRsqwd/+EuP00Taj/iHcqYZVRwghSvhOy9CE
         xv1bgSEFCzc94oTxUJfh4N0MJPXlDF3P2SgQsw0OyEw7e5sU2ahFUDjZ3Kb0t7pGizWs
         GnjxtlDldNL1i3tnH12RnAcVenHoqmJ111i+Ebv1cUUUbWtya1X668XcjPQ9azBy0+40
         9gA0eibAS4UBSOe97bHl+AGd46DlpT+32uVLsfweIvXll9HFzK/7PMEUmHxibS6r4/k8
         /ls+U+LVgLHrPb3kp07Y7suncdHoh1g+ytu685sJUNrt2Z3KSLtM6HSL+n8fWifXomIy
         yvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789646220; x=1790251020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ePwmsMkUKDU1SxF8E4e113FncU/+AY22Hw2g6GemxcY=;
        b=o58QAbbWKN/2QCNqXXwuza8V7Yud20R03CdaQiaDheV9pW5jCdqVTD4K4ZBe1SHQIW
         VwMpyKX489i+7cW38roU1mUPbpPwcTfwHsv+nZ/5FshM52SnjHjZ6MuBZaCLU+GdvbyW
         66Z19wmDPGzmqI7yrCMw5fivqPteO3PgSA1Ssa9ucjeNG45A3NMkEifchqErtLghHWed
         3dq9pP8ESVNRfDmdYJlGgpJVTsSfoYgucYylhUrydxvRO7zIUjeDccHETmk3qeT+X+SA
         55Q/eUHY4mGRTcEsq5kEOimKqvyXzvLbEOvIEvktI0WlD0jSm5daSF7T3AZDLaFeGvi6
         YhVg==
X-Forwarded-Encrypted: i=1; AKwUvBxXP00qdlIKYbxO6VUWmyF81q+zeyUeXpt3b/a1eM5fJTqY9ZHhqexwCPO7u1rr/Td1ug0vXCE=@vger.kernel.org
X-Gm-Message-State: AFuF++nO9puW3Q8K9Lz7X1EqXR1D5g4y27KqNja5pH+lLMQH9CuVNItT
	uZ6QRFNCc9egRsRIVng0PE7Z+QzkWcPvFdP7afRIElpVkA94Hg6J6lI4
X-Gm-Gg: AYBFou3x6Pq5HN9NTO/B9jnyLzoSRyVM24a3jgzmY2BFveDrzQsoKyPNeD3pdA6Bmgf
	P+CodS+jNldA4y4SD84FiOHkJ0O9dBHdbUEae5KnhmbeFtrs2Oesd0hGCELrqYDZGWQj+hG2PlH
	cvbNKo5yvlP8rghG5LociJuGMDTl141VqsPNmR9ONXTQvKFzb3S9hYhoFc3lrY/2AwO/qQc97CL
	88j04fha0yfmzjyzmak5UQsTTVmdJzxHhQfDnFO75EPBfgVPUUT2ERk7y1LH6q7eXJ9u898NlTX
	OdBnrPQLwiliqdTNeXlC+pK0tAQBP/HV42csiT0YHgHqGaadDORDu8f+qVwwB/9X3je+l4tlL8X
	qLCGMRmRRL/T94qkZLMCXxzV6Ez9bP1k2yPuwWmv52saGNMGmmUoUcp0T/3U/i3pmM1A6MQr0Lp
	+mcnqBUHzAbHsLEqYMV1ZSrlotDWUvehs5RQAjzEpSxgiQsXM4BRxsBKxIs78z5eme+0tab0Qwx
	aLIomvls+92KGgmMiGPK0aXF1HxmcsZSnxplQlF
X-Received: by 2002:a05:600c:198d:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-49eac4642ffmr84127505e9.4.1789646220111;
        Thu, 17 Sep 2026 04:57:00 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847eab65sm91365315e9.2.2026.09.17.04.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:56:59 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v2] net: axienet: bound TX completion cleanup by the NAPI budget
Date: Thu, 17 Sep 2026 14:56:57 +0300
Message-ID: <20260917115657.20697-1-maimon.sagi@gmail.com>
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
half-freed.

A zero budget must not be treated as a spent budget.  netpoll calls
napi->poll() with a budget of 0 to reclaim the TX path only, and
axienet_tx_poll() forwards it unchanged with @force false; testing
packets >= budget alone would break out before examining a single
descriptor, leaving skbs unfreed and lp->tx_bd_ci unchanged.  Since
cur_p->cntrl is cleared only here, axienet_check_tx_bd_space() would
keep reporting the ring full and netconsole output could stall.  Zero
therefore means no limit, which also covers the @force callers that
clean up after a DMA mapping failure with a budget of 0.

Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
v2:
- Do not treat a zero budget as a spent budget.  netpoll polls with a
  budget of 0 to reclaim the TX path only, and v1 broke out of the loop
  before examining any descriptor, so nothing was reclaimed and the ring
  could stay full.  Reported by the Sashiko AI reviewer.
- Update the @budget kernel-doc: it bounds the cleanup when @force is
  false, and zero means no limit.  It previously read "use 0 when not
  called from NAPI poll", which after v1 would have meant "reclaim
  nothing".
- Compile-tested only; the board this was found on is not available to
  me at the moment.  v1 was verified on hardware with the napi:napi_poll
  tracepoint (8424 polls, max work 64 against a budget of 64).

v1: https://lore.kernel.org/netdev/20260914114821.55503-1-maimon.sagi@gmail.com/
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 782f903d318f..f643453261f1 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -772,7 +772,9 @@ static int axienet_device_reset(struct net_device *ndev)
  * @force:	Whether to clean descriptors even if not complete
  * @sizep:	Pointer to a u32 accumulating the total byte count of
  *		completed packets (using skb->len). Ignored if NULL.
- * @budget:	NAPI budget (use 0 when not called from NAPI poll)
+ * @budget:	NAPI budget. When @force is false, cleanup stops after this
+ *		many completed packets. Zero means no limit, as used by the
+ *		netpoll TX reclaim and by callers outside NAPI poll.
  *
  * Would either be called after a successful transmit operation, or after
  * there was an error when setting up the chain.
@@ -788,6 +790,15 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 	dma_addr_t phys;
 
 	for (i = 0; i < nr_bds; i++) {
+		/* A NAPI poll must not return more than its budget.  Stop on a
+		 * packet boundary once it is spent - cur_p->skb is only set on
+		 * a packet's last descriptor, so no packet is left half-freed.
+		 * A zero budget means no limit: netpoll polls with a budget of
+		 * 0 to reclaim the TX path only, and must still clean the ring.
+		 */
+		if (!force && budget && packets >= budget)
+			break;
+
 		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
 		status = cur_p->status;
 
-- 
2.47.0

