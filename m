Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667CE371887
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280417; cv=none; b=ouHzHsDy3IvTj20pLZcvMh8q10ZMo1FLcZaIU6EBPNw2FIlyvcZFA3Do618bNV/0BKQxopkuGq/JLGo1uVObn+O2Sey6BsPCH2jRdeBT0/UdmiwIcgi570tRY/i8stBxlL/+Z3yhs1nGBob8Bme5EIX3lyT1NUuMQ5MFrEbHqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280417; c=relaxed/simple;
	bh=ckWizvcSwZhlI6rKng/yD9FrZW5unymXwuDsJRPA9Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuI1MIZ4RbrOT/240IFIxbHCxcVGvpb4+WzjrE2fZbxjaD+YiQBOhMg8Am4tt+9lLlRaIi123sMf88GWOZAurR5PJwdv05Zdid2A9o/wwOXq31b8jdRhZsxKN++SdlQo7wkT4+JbhwnStbGjjdsc99Ksq7beLr6IYqUyiy3RhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzDO6CGt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzDO6CGt"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a20f56876eso72901fa.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280413; x=1788885213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+2f2XHv+af68YmdwG7YdmU8mGG4BCpNERxEZlAskTc=;
        b=SzDO6CGtm6sO9n38ZJUTexwllFyYxnWnAri9Urk/8URoOoaZtNBxp6r36zeOXJfyHz
         HDHJ9N459Gd66A8B35LWH6cA1sYrar92wYUjYdBnrbc9xdTFDB3q6uUNSwKwONKOYmlf
         HzwW5EyiyME3NAPc6cmgkFC01d+H+UJK/WNE7X3qB+n+b5ge897gQ/QtuGcSyDNkh17C
         k/DVr5GfoHkejAmcXEOhYJqo/6r3REJ2njS0qzYXBmg4faHR99iC2wHk6+HlgMr2HbPN
         aOJnlAhyNrSHVCCM/vcftkddKA+6eVp0KDVRUvtjZPz0QbcM+f0g3f+k8tsPlQb9iT1f
         cdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280413; x=1788885213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+2f2XHv+af68YmdwG7YdmU8mGG4BCpNERxEZlAskTc=;
        b=Zdihinhph/LdEisN/OZ46NrXqszkEMbJxlk7W9WhGIONucT7hGv1QJHK7cBvWp0hLk
         PbmBtzesfpdLWd/zwBHHN27v2t8qnLJezAi401dziy9c2mwphQWAaATbxfCfMwmYpand
         h85r0ZRHArXTGdQ0xazX9cr6rPiOTmQ4Ib0jYHf+LFfwgv9PpJ7mPT0mgdkZhZcdSaeE
         Y4plm1/ZdGgxAsGVDE12LHW5a/aGxYMKQVNiFfkHHCcUYDFtTV+D0JoxZ/18js1mLMUp
         GhqwkH25N6KxwZW7bMibC+LqupVE5p2lpkJ6sWCVm/Ihkjowo9H8sE2GH9m5sCUblrR6
         6BHw==
X-Forwarded-Encrypted: i=1; AKwUvByhQ/tFKqk9Bp3O9YTAl94HLhwHqYGiQjy/aNQ1EcBG/lYIT/lnKpZkW/YNRpSc6nXCuZ0Xhjc=@vger.kernel.org
X-Gm-Message-State: AFuF++nKtPzmj2V0NDMMGh2WlEx9T7bQt4wNNSggCAh4WkRu53CCjBIq
	f0gArYVimdY8xb0H3x5GLzjql8R7kG04dTswdPudrcF8m41n6aCv0ls=
X-Gm-Gg: AYBFou0dbuIqOHwb+o5DK9YvxLs+OY/LS31AeHAhwyyTPyMK1mibystHrDrjlWGDrrF
	EsTZntVGH3HbDjw8AGDhzk/ZXkcZeGy6LVruk1L78YksGINoCMU2k1auTYSpsN3HCUooSXDn/xC
	/DbDdbA73nzDnxOZ6eHPGfKv6I5g81tQh7wC6l7C8pgifiphKlCTOq50XIdfTvxOy6ML3HNe/fe
	JJMfQUfMqniGxGJ1rrEQ6+j/CSLZx43lUQ3xWT5tGPSsqCo4vmJCdHsJsrJi+L4QfBf7reVxOlt
	jaVZzfeKeZuOSliqYLoWSrrMSylj+begxFuh4HNJgPH6Mk5loPXyy6TdnHbcLy09jM9EBtoBR5B
	q2NwL3jkWs7X/diliGC9njqwp8UPfWHbJFtHgByAuqdKmWo54ywnqPZwDWmgkIGuti8Vtfg5yin
	PF290y7It/IZfDugaRqLbI3LkIOuWZFGBslbLYJI0+1bkAO0GZ5qGk
X-Received: by 2002:a05:651c:41d8:b0:39d:b5b9:f0f4 with SMTP id 38308e7fff4ca-3a301abb820mr82093501fa.10.1788280412821;
        Tue, 01 Sep 2026 09:33:32 -0700 (PDT)
Received: from fedora ([92.36.3.203])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a34a8ed967sm678251fa.7.2026.09.01.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:33:32 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH net v3 1/2] net: airoha: handle RX_NO_CPU_DSCP interrupt, not just RX_DONE
Date: Tue,  1 Sep 2026 19:32:53 +0100
Message-ID: <17f1beec505b87a4acf16557386a978c98f94b97.1788286284.git.sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788286284.git.sochnev.v.74@gmail.com>
References: <20260831234701.206021-1-sochnev.v.74@gmail.com> <cover.1788286284.git.sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

airoha_qdma_hw_init() unmasks the per-ring NO_CPU_DSCP interrupt, which
fires when an RX ring runs out of free CPU descriptors, but
airoha_irq_handler() only extracts the RX_DONE bits from the same status
word. The NO_CPU_DSCP bits are acknowledged and dropped.

Once a ring is drained to zero posted descriptors no further RX_DONE can
fire for it - nothing is left for hw to receive into - so NAPI is never
rescheduled, airoha_qdma_fill_rx_queue() is never called again, and the
ring stays dead until the interface is reconfigured.

This is reachable on RX ring 4, which airoha_fe_vip_setup() force-routes
~15 VIP-classified protocols onto (BOOTP, PPPoE Discovery, ISAKMP,
DHCPv6, SIP, LLDP, PPP LCP/IPCP/CHAP/PAP/IPv6CP, ...) while it sits on
the 16-descriptor RX_DSCP_NUM() default. A DHCP renewal or a PPPoE
negotiation burst drains it faster than the CPU reposts, after which all
of those protocols silently stop being received.

Treat NO_CPU_DSCP like RX_DONE for scheduling NAPI:
airoha_qdma_rx_process() already calls airoha_qdma_fill_rx_queue()
unconditionally at the end of every poll, so scheduling NAPI is enough
to make an emptied ring refill itself. Re-enable the bit alongside
RX_DONE in airoha_qdma_rx_napi_poll() so it is not left masked after
first use.

Whether NO_CPU_DSCP re-latches while the ring is still empty is not
documented. If it does, a ring that cannot be refilled (page_pool
returning NULL) keeps reasserting it. Masking it until a refill succeeds
is worse: a starved ring never fires RX_DONE either, so it would stay
dead after the memory pressure clears.

Fixes: f252493e1835 ("net: airoha: Enable multiple IRQ lines support in airoha_eth driver.")
Link: https://github.com/openwrt/openwrt/issues/24715
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 16 +++++++++++-----
 drivers/net/ethernet/airoha/airoha_regs.h |  2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64619e9a704d..c59201aded26 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -784,13 +784,16 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 		int i, qid = q - &qdma->q_rx[0];
 		int intr_reg = qid < RX_DONE_HIGH_OFFSET ? QDMA_INT_REG_IDX1
 							 : QDMA_INT_REG_IDX2;
+		u32 irq_id = qid % RX_DONE_HIGH_OFFSET;
+		u32 intr_mask = BIT(irq_id) |
+				BIT(irq_id + RX_NO_CPU_DSCP_LOW_OFFSET);
 
 		for (i = 0; i < ARRAY_SIZE(qdma->irq_banks); i++) {
 			if (!(BIT(qid) & RX_IRQ_BANK_PIN_MASK(i)))
 				continue;
 
 			airoha_qdma_irq_enable(&qdma->irq_banks[i], intr_reg,
-					       BIT(qid % RX_DONE_HIGH_OFFSET));
+					       intr_mask);
 		}
 	}
 
@@ -1468,16 +1471,19 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 	if (!test_bit(DEV_STATE_INITIALIZED, &qdma->eth->state))
 		return IRQ_NONE;
 
-	rx_intr1 = intr[1] & RX_DONE_LOW_INT_MASK;
+	rx_intr1 = intr[1] & (RX_DONE_LOW_INT_MASK | RX_NO_CPU_DSCP_LOW_INT_MASK);
 	if (rx_intr1) {
 		airoha_qdma_irq_disable(irq_bank, QDMA_INT_REG_IDX1, rx_intr1);
-		rx_intr_mask |= rx_intr1;
+		rx_intr_mask |= (rx_intr1 & RX_DONE_LOW_INT_MASK) |
+				RX_NO_CPU_DSCP_INT_RX1_MASK(rx_intr1);
 	}
 
-	rx_intr2 = intr[2] & RX_DONE_HIGH_INT_MASK;
+	rx_intr2 = intr[2] & (RX_DONE_HIGH_INT_MASK | RX_NO_CPU_DSCP_HIGH_INT_MASK);
 	if (rx_intr2) {
 		airoha_qdma_irq_disable(irq_bank, QDMA_INT_REG_IDX2, rx_intr2);
-		rx_intr_mask |= (rx_intr2 << 16);
+		rx_intr_mask |= ((rx_intr2 & RX_DONE_HIGH_INT_MASK) <<
+				 RX_DONE_HIGH_OFFSET) |
+				(rx_intr2 & RX_NO_CPU_DSCP_HIGH_INT_MASK);
 	}
 
 	for (i = 0; rx_intr_mask && i < ARRAY_SIZE(qdma->q_rx); i++) {
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 442b48c9b991..bde3d599d8b7 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -549,6 +549,8 @@
 #define INT_RX1_MASK(_n)							\
 	((((_n) << RX_NO_CPU_DSCP_LOW_OFFSET) & RX_NO_CPU_DSCP_LOW_INT_MASK) |	\
 	 (RX_DONE_LOW_INT_MASK & (_n)))
+#define RX_NO_CPU_DSCP_INT_RX1_MASK(_n)					\
+	(((_n) & RX_NO_CPU_DSCP_LOW_INT_MASK) >> RX_NO_CPU_DSCP_LOW_OFFSET)
 
 /* QDMA_CSR_INT_ENABLE3 */
 #define RX31_NO_CPU_DSCP_INT_MASK	BIT(31)
-- 
2.55.0

