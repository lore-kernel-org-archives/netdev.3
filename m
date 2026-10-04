Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17F35F5EA
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791097178; cv=none; b=Vf8nBGnolsuidnoQTIAoJPcidR8Tib5okJ/oF/bkd3HPnD1FApZhS36HeYrdMZeLhOL+FZXzWHshG4Txdph+4D/3EEuR9hMYXsOLG0liFWI0ZijSkh9tHU6UpfamsbN3+NNqm+e9ov60QEyngHkMpydtxsrE2q+ppEINc9KtmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791097178; c=relaxed/simple;
	bh=7bUhH/KPZO2e6VYSg4aJn1VClINpmoLcCMRzvLmtLtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ry9nprd25wcSG6qF4hL3AbA1Vxp/rDUzsm1MjQ+c/efn4JgOQGAlnLfbCayHWUFbV48prky2FTuDP6SOwEMCRjutCMNT1Nem6cw7AcsM3kQ/OnK5yL0AQ5CkyEQUMpHk/iccqq/FYBGkBrOfauBPT/CB5905rxWccB0b9PsFxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX67hq8k; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX67hq8k"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b9d8055dfso592555f8f.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791097175; x=1791701975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jUq35Mj7y/kPdp1eqVQTd7ny1GwkFBnwNODPDMNc1j4=;
        b=LX67hq8k7UF/BXMFF3MujneexUiXhOao57wXGfg/U8RAzVInwBL8KaDxxDy9q95Qmr
         c79f9BH/zFaQ/uuTYoquhW0u5BHaozo/myZSlEDZ/4IYXBeMBTmjpD8iQStHNBB4tR3W
         tPcuo7GDc0eT4n0VAOcGxG348ItNWQMnhMWagrrtcM4F3YZHVItyMJL0EDiH7EIo8mLB
         FYHIKNwB6oq5VJN2tPUWzFQBP9xbv1yeeQnQOoQp1En6F3ipZcDqWJ8GO77Y1N6Zr0LR
         jFPvt3xEaM2TzX1+Ca7SPF71mMvLsjGHRsu8v2CwrgvcqfLiXCDS8e+ThsflYiLWtcR1
         E7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791097175; x=1791701975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUq35Mj7y/kPdp1eqVQTd7ny1GwkFBnwNODPDMNc1j4=;
        b=SOcHAiufs5w2UxAzEf6jOcSfZVgzInnoDFQm7xW/st5WOO9nvkt2EHLk0b72nHS6xj
         NZhHmMJZGuE6P6F91F7FEpaOo5hjON89XO1a22Y33LjN4/AHVO3RppHj1yKdV/wlraXD
         HLmzuGpUenQi7TlhCdDA52JQn46RZ+nUSuLGZ6ga1h5FlG1q2Hemc9VYKDpbxrW3vn6e
         9oVCv6YshvTsFhbu618LmUyqxBdUPhEgA3E0wqDm7tkvo3M1PuClP5fcxZm/ClFKlINz
         86Gtf1zq5GUj+zeNvZxDWu0t1Ah+fbQS+u1z9hCkWasJAXemGJ7PXaJQfohby5uiE31H
         wlgg==
X-Gm-Message-State: AFq9FYJAhKdvJH1lCLO1NXfBVyuF08rQZ+GregewHz1rXQwBhIK4IgJO
	rBn/dHrTb22xwJTRATGA6+hdA9X1xcOSMZkwuLcm4IMNiS89lmKbFHtLwBKcQgc3
X-Gm-Gg: AYBFou06XHEKJchq8Ahs0yX2LKDKdgouCHcIVbUl9y6DvltAYNuJZJRkpOrDncNKaS/
	keVq6RLnxLdR0KKw83n6RPOOi10ztYOHGz7b/wazmldSwhFV5oBrO2C5Fw78Lo+iIyesgajhlwF
	Xf47CZwf7zWDxLOJsJrBEDdbvt8Dlgecp9xZ8pzzzSckwK2ALzqvXkN0ecxrORgG+GkLT9OFzVp
	ji09r34tIa6a8UMIRuqdi9mACm2V+YxBEIRVXK7PJ8GoUetiHAjkeg4S7FLl2KKgNK8lsVIbVRt
	9/5oMajwQXXcUTY0YRjTKZdn4qAqQ+/996rYSwk5O3S3TWxp/XewGzHyCxwOdlumEIB2KD6+ovp
	tukSpB73GqFbVfDTpEN5eZketjBN/I5hFa/4yrbkAp7dI15U4NFBuQUTGRxhifAhOFc4MoDMk4J
	kAUaivqIlQRobLsIDrfOu6MkQUuC0Dv4o8IW5TSMSv/Qpb/TQztRpE8osOcuZW6oh3zOKfYY5bt
	qmShy3LWlHi1M+ambH2dxBQ4CKkeGSSJT1USvcd5x7ef0ZOJFU=
X-Received: by 2002:a05:6000:2610:b0:48a:f11e:6d57 with SMTP id ffacd0b85a97d-48c47fe6a3fmr6495332f8f.19.1791097174408;
        Sat, 03 Oct 2026 23:59:34 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c57d927cdsm1761318f8f.6.2026.10.03.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 23:59:34 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	suraj.gupta2@amd.com,
	radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	robert.hancock@calian.com,
	sean.anderson@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v5] net: axienet: do not report TX completions as NAPI work
Date: Sun,  4 Oct 2026 09:59:30 +0300
Message-ID: <20261004065930.1004953-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_tx_poll() reclaims every completed TX descriptor in one pass:
it passes lp->tx_bd_num to axienet_free_tx_chain() as the descriptor
limit, and @budget is only used as the napi_consume_skb() bulk-free
hint.  It then returns the number of packets reclaimed, which is bounded
by the ring size rather than by the budget, so the poll can report more
work than it was given.  This was seen after TX completion interrupts
had not been taken for a while and a full ring was reclaimed at once:

  eth0: NAPI poll function axienet_tx_poll+0x0/0x180 [xilinx_emac]
        returned 96, exceeding its budget of 64.

netpoll is affected as well.  poll_one_napi() polls with a budget of 0
to reclaim the TX path only, and warns once if any work is reported.

TX completions are not budgeted work: Documentation/networking/napi.rst
lets a poll process any number of them.  Do as bcmgenet does since
commit a58cdf56b6eb ("net: bcmgenet: complete Tx NAPI after one reclaim
pass"): reclaim the ring, complete NAPI with no work done, re-enable the
TX completion interrupt and return 0.  Re-enabling the interrupt raises
it straight away if more completions are already pending, so none is
left behind.  This also drops the extra poll that used to follow a full
budget's worth of completions, which only found an empty ring.

netpoll polls with a budget of 0 and must not complete NAPI, so skip
the completion then; napi_complete_done() refuses it in that case
anyway.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 5a6caa2cfabb ("net: xilinx: axienet: Fix packet counting")
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

Notes:
    Changes in v5:
    - Complete NAPI with 0 and return 0, following commit a58cdf56b6eb as
      Jakub suggested, instead of capping the returned packet count at the
      budget.  Subject changed to match.
    - Dropped Suraj's Reviewed-by, as the change is different now.
    - Build-tested only; not yet run on hardware.
    - v4: https://lore.kernel.org/netdev/20260930071536.627964-1-maimon.sagi@gmail.com/
    
    Changes in v4:
    - Keep reclaiming the whole ring and cap only the value returned, as
      Paolo Abeni and the review of v3 suggested, instead of stopping the
      reclaim at the budget.
    - Fixes: now names 5a6caa2cfabb (review of v3).
    - v3: https://lore.kernel.org/netdev/20260924135052.185129-1-maimon.sagi@gmail.com/
    
    Changes in v3:
    - Report no work for a budget of 0, so netpoll cannot trip the
      WARN_ONCE() in poll_one_napi().
    - v2: https://lore.kernel.org/netdev/20260917115657.20697-1-maimon.sagi@gmail.com/
    
    Changes in v2:
    - Treat a budget of 0 as no limit, so that netpoll still drains the TX
      ring.
    - v1: https://lore.kernel.org/netdev/20260914114821.55503-1-maimon.sagi@gmail.com/

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 09443623a3e2..a13323a9399f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -985,9 +985,9 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
  * axienet_tx_poll - Invoked once a transmit is completed by the
  * Axi DMA Tx channel.
  * @napi:	Pointer to NAPI structure.
- * @budget:	Max number of TX packets to process.
+ * @budget:	NAPI budget, or 0 when polled by netpoll.
  *
- * Return: Number of TX packets processed.
+ * Return: Always 0.  TX completions are not counted against the budget.
  *
  * This function is invoked from the NAPI processing to notify the completion
  * of transmit operation. It clears fields in the corresponding Tx BDs and
@@ -1019,7 +1019,12 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 			netif_wake_queue(ndev);
 	}
 
-	if (packets < budget && napi_complete_done(napi, packets)) {
+	/* The whole ring was reclaimed above, so there is nothing left to
+	 * poll for: complete with no work done, as TX completions do not
+	 * count against the budget.  netpoll polls with a budget of 0 and
+	 * must not complete NAPI.
+	 */
+	if (budget && napi_complete_done(napi, 0)) {
 		/* Re-enable TX completion interrupts. This should
 		 * cause an immediate interrupt if any TX packets are
 		 * already pending.
@@ -1028,7 +1033,7 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
 		spin_unlock_irq(&lp->tx_cr_lock);
 	}
-	return packets;
+	return 0;
 }
 
 /**

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.47.0

