Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490262;
	b=gPPmCKf6SB5lsB1CIddm7UlyO150d2iMwMvutTOn/MJMAlU7nOfrwyFyioFhPEROVvdc
	 3I1zqkDNko4UMwbWFuk1Ei40n8Zf+NbMfeULqoPl5MMk+LRKreRJ1JRlDRlGPEAH/0omR
	 F9+DOsbToeMLr7EiDksYSQ/2H0LeEERxJmUKrBGP+ONWRHqVkW3TjRg0cIfRRRNj5sbOE
	 oB8Wfe2XWdGPKn3VbUTDKaUBOTPBpEN1Bc1gtsZXyFJlARaUypou7GXA6oOXOGEz/jJD+
	 /xV/4XKN+H+1HthT7So+lpmB5bTdhO/cpMCk8ixMAXpjIxKe0yF++vwb9vlwglWiIjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490262;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=C/ul8wKR/6oXhvn30kfkxVANWsSumMKodWzszgMRavU=;
	b=znzTiuPofI456WKfbaZNFjEWEiNAV+rLF+vf+wFlTggM5rWsDgGg6DTLJafnRmm8rQ92
	 E537lYeIgC2siA+0Xly+7HD6ofNYIzKDNGrMkJ1dp3SLwY2f2i685ZYlXNFJjesNysVwm
	 nvKk82EJuKdv3Oj5e6xvJiTJxgviIZ1Vi7esP5uJdMXCzSED3OyTvrXc8XwaWZE5AKQTo
	 S8mHmQJMZVXMyZDHGV086ei4Ztz8tYdGyq7doouD+nwEUDk4rkqQdy7sAAiuHilH0B1h3
	 t9qhKMFNq/NogtSo35X+2+XQs2UZeRfYSO5/J16fAbae/ARbVJ4zJAi8jV7++R8d6Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkuC4nWt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32448606A880
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkuC4nWt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8873F1F00A06;
	Thu, 12 Nov 2026 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490261;
	bh=C/ul8wKR/6oXhvn30kfkxVANWsSumMKodWzszgMRavU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZkuC4nWtQpFxFnCqZQ+6W69Cy7eK/ip38WVYOo9sKos0M5Kxqk8SxuHe3ramUjOB9
	 EZGwCV8+ecdANURW+XoGy1MhnJd9lt0UNgWlD9tyqCvy2Bdb4Od9pSI7T0Q4IOYpzV
	 41CeehlywxVo8+GJ1UEoq0n/3ykCfyGViReFrjQF8J3oBz+x8vsrkd77ajTibjOvcR
	 BQty41CVi8kFLkyEEzS5l1rZFl+ASpEEaM8KVTqedr3NDIdO9jGW36uv8Mbhy1efin
	 OO8Z1jQXsY+EuX38pm0HpVMcaBkOfM0PLcvaGqKqj1gvDtiUQfp4zCZJ/X1M00RUOX
	 nT499JViD6MBw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:30 +0100
Subject: [PATCH net-next v8 15/19] net: ethernet: cortina: Serialize TX
 completion statistics
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-15-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

gmac_clean_txq() updates ir_stats_syncp with hard interrupts enabled,
while the MIB and RX overrun interrupt paths update the same seqcount.
Initializing its lockdep key exposes the incompatible IRQ contexts on
32-bit debug kernels. The writer sections also lack mutual exclusion.

Take the existing IRQ-safe irq_lock around the TX completion statistics
update, matching the other ir_stats_syncp writers. Acquire it before
opening the seqcount writer section so PREEMPT_RT does not acquire a
potentially sleeping spinlock with preemption disabled.

The TX fragment counter also uses tx_stats_syncp from both start_xmit()
and process-context teardown. Use IRQ-safe writer helpers around that
increment so a statistics reader cannot interrupt the writer and spin on
an odd sequence. Keep this protection local to the counter update rather
than covering the entire TX cleanup.

Found during Sashiko review and confirmed by tracing the IRQ, transmit and
stop paths. Cross-built gemini.o for ARM with W=1. No hardware lockdep or
PREEMPT_RT runtime testing was performed for this change.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5a87d88607cd..cc26ff16a0a3 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -671,6 +671,7 @@ static void gmac_clean_txq(struct net_device *netdev, struct gmac_txq *txq,
 	union gmac_txdesc_1 word1;
 	unsigned int hwchksum = 0;
 	unsigned long bytes = 0;
+	unsigned long flags;
 	struct gmac_txdesc *txd;
 	unsigned short nfrags;
 	unsigned int errs = 0;
@@ -716,18 +717,21 @@ static void gmac_clean_txq(struct net_device *netdev, struct gmac_txq *txq,
 			if (nfrags >= TX_MAX_FRAGS)
 				nfrags = TX_MAX_FRAGS - 1;
 
-			u64_stats_update_begin(&port->tx_stats_syncp);
+			flags = u64_stats_update_begin_irqsave(&port->tx_stats_syncp);
 			port->tx_frag_stats[nfrags]++;
-			u64_stats_update_end(&port->tx_stats_syncp);
+			u64_stats_update_end_irqrestore(&port->tx_stats_syncp,
+							flags);
 		}
 	}
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
 	u64_stats_update_begin(&port->ir_stats_syncp);
 	port->stats.tx_errors += errs;
 	port->stats.tx_packets += pkts;
 	port->stats.tx_bytes += bytes;
 	port->tx_hw_csummed += hwchksum;
 	u64_stats_update_end(&port->ir_stats_syncp);
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
 
 	txq->cptr = c;
 }

-- 
2.56.0

