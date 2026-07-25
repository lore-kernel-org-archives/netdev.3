Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560A331A7B
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012132; cv=none; b=ojb+0v3Qk/AT3CUpkO+bZHchgDqoXONLRH/dbz2rb81R6zsKZ8XXiz4yRQ6ZsP8OFruZPYePSnvlEIWPk5mY3pO8WA50MXi8Ji03LZvDOyWb8trbIwt7qC72OxdElFdYTR0QykQbZ0L7bwqX2tvq62BUsaw8Oh/Q7ae4KOfvYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012132; c=relaxed/simple;
	bh=ob4J+U080i8ImmOVbb+QW0QA1MHoV58gu39+VNwXi8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PqK31T2xwwnsxT4vtMXJ1F5W3I/JKH7UD6t5Dbh1S8HkDUnqWEppS35xdhqFEQK3HnY38UKRFAs9B5A10aTwyNB633Y3Zbpurh9438GUVu8xuyyk1EypoCV2pRenVx67AUhjobKqdCdE0a4JEnVfexSyMcvFUmfY3vree0CKtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDGbYMwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDGbYMwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EC11F000E9;
	Sat, 25 Jul 2026 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785012131;
	bh=2d95gBKRLIRPk46z3u1WxiEdY2SddpLr9a2RJusilXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dDGbYMwHIc6zkJP3cAEm+KOkkXU0CvQUBNzgzm4VLgD7mBiZOsfKGymSABhSMwgwQ
	 rBDlB8FMu0Uc1vvTHa+Ds0NrqcT+6vyD8I6SVxTGJV5b6p46oUFd35GI/JrwrO2tsE
	 iLjcjD5ShTYNjRS2EZuA+CnrCSdCUKIygjYFoY5Dbl8dQ+JeLUx72JvlWzQSSGYDit
	 ovgEeDuIzt5p8KyzJGeYZAuHQurPh2kTW6c73/OpOJY7NYGZ6GnIxad5L2J3Y1JoRa
	 CNCijoN6f9NVdrmVEiHNUBAhwr9/dOVZWgzGoGJ2j8JB+y0VaTkelECFJ3mEcHjSkI
	 S3K3QKD0P/IuA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 25 Jul 2026 22:41:41 +0200
Subject: [PATCH net-next v12 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-airoha-ethtool-priv_flags-v12-2-5136a30b2157@kernel.org>
References: <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
In-Reply-To: <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.3

airoha_qdma_get_tx_ets_stats() has two bugs:
- The hardware counters read via airoha_qdma_rr() are 32-bit values
  but are stored in u64 locals and subtracted from u64 baselines. When
  a 32-bit hardware counter wraps around, the subtraction produces a
  large underflow value passed to _bstats_update().
- The baseline counters (cpu_tx_packets, fwd_tx_packets) are stored as
  single per-device fields, but airoha_qdma_get_tx_ets_stats() is
  called with different channel values (0-3). Each call reads a
  different channel's hardware counter but overwrites the same
  baseline, corrupting the delta computation for other channels.

Fix both by:
- Narrowing the counter locals and baselines to u32 so that 32-bit
  unsigned subtraction handles wrap-around naturally.
- Grouping the baselines into a per-channel qos_stats array so each
  channel tracks its own previous counter value independently.
- Splitting the delta addition into two statements so the first u32
  delta is widened to u64 on assignment and the second is added in
  u64 arithmetic, preventing overflow when both deltas are large.

Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++---
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d9a44a11d8db..8165084daaf5 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2521,16 +2521,20 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_qdma *qdma = dev->qdma;
+	u32 cpu_tx_packets, fwd_tx_packets;
+	u64 tx_packets;
 
-	u64 cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
-	u64 fwd_tx_packets = airoha_qdma_rr(qdma,
-					    REG_CNTR_VAL((channel << 1) + 1));
-	u64 tx_packets = (cpu_tx_packets - dev->cpu_tx_packets) +
-			 (fwd_tx_packets - dev->fwd_tx_packets);
+	cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
+	fwd_tx_packets = airoha_qdma_rr(qdma,
+					REG_CNTR_VAL((channel << 1) + 1));
+	tx_packets = (u32)(cpu_tx_packets -
+			   dev->qos_stats[channel].cpu_tx_packets);
+	tx_packets += (u32)(fwd_tx_packets -
+			    dev->qos_stats[channel].fwd_tx_packets);
 
 	_bstats_update(opt->stats.bstats, 0, tx_packets);
-	dev->cpu_tx_packets = cpu_tx_packets;
-	dev->fwd_tx_packets = fwd_tx_packets;
+	dev->qos_stats[channel].cpu_tx_packets = cpu_tx_packets;
+	dev->qos_stats[channel].fwd_tx_packets = fwd_tx_packets;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 24dd16fc509a..447a5a9552bb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -580,9 +580,10 @@ struct airoha_gdm_dev {
 	struct airoha_eth *eth;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
-	/* qos stats counters */
-	u64 cpu_tx_packets;
-	u64 fwd_tx_packets;
+	struct {
+		u32 cpu_tx_packets;
+		u32 fwd_tx_packets;
+	} qos_stats[AIROHA_NUM_QOS_CHANNELS];
 
 	unsigned long flags;
 	int nbq;

-- 
2.55.0

