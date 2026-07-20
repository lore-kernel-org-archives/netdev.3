Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74262EEE9D
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585067; cv=none; b=SZabZ8Sb7xFGW9EQZ7K7/64GRHzxUpmgjyPalh9R4AGQ/n544U6yeIElRCzd1JXNKbsaw0h+9EhGwiv/Rot0xOphalPE7HCQIk3tnoVOiyr7SUI+fH7CwroFu1VsFo//E3TJQVtHJuNloMkcDUUQhKBcl7lVx2e/PI1CrM0F/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585067; c=relaxed/simple;
	bh=zP8k1VEh8Sx45RCMrtUZJnLwD6OrOG7X5tab4ogU66I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4tlE7ya/paPgyoKxFuZV+zHoAlv1P6vIG3aQaG7Ke+Se6cFAE791f9q7uOYRtN34ztHvMqBYllT0aCk1C2zsOEGds3a5D6G2truZjs5a177y+owisc46snWX9R6Ny6LWb30PqTcjSe9zFexSaMak7OF3VLxsOA7rJTvarP6xdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCjQ/C/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCjQ/C/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9781F00A3A;
	Mon, 20 Jul 2026 22:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784585065;
	bh=pwpE3NqmwPyDA0h15H/nP/GCU5bS7v38rIsHErC+BBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PCjQ/C/SmPcmEd0eKScM/G43q9DjY7XngEeaHWStD5VnoW0zwXGikRcaL3xKi0r/u
	 35joYSP6T/ZXXWdgNADOE/XjQqGiKqfY1AUdv6vl5inEORsOyycdrNXDIl8dWBW1NJ
	 ylmzVDCq7aWR/8xeRTKeF1t+9E0T3ZKDgFlKGm9PukuGRbfEnVaNSPQlaeOmGb8Gyj
	 nS3TuRToZ7EzyDZyLO/v0biSV6ocx5shr7J/mL+2CYYo+qoxi6spjkS1s8uDo940to
	 DngrWUeOi0T7OSLXtFhbucVmyYgqeuFdHEeCHmt2HbzfvqMQYG4yO/6uvQU23XUqxz
	 4RiAQawM8nE9g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 21 Jul 2026 00:03:36 +0200
Subject: [PATCH net-next v9 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-airoha-ethtool-priv_flags-v9-2-9c15d8b71a56@kernel.org>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
In-Reply-To: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
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
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++---
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 41c1a0ffbdd8..aaf2a4717d12 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2482,16 +2482,20 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
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
index bf1c249255bd..bf44be9f0954 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -553,9 +553,10 @@ struct airoha_gdm_dev {
 	struct airoha_eth *eth;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
-	/* qos stats counters */
-	u64 cpu_tx_packets;
-	u64 fwd_tx_packets;
+	struct {
+		u32 cpu_tx_packets;
+		u32 fwd_tx_packets;
+	} qos_stats[AIROHA_NUM_QOS_CHANNELS];
 
 	u32 flags;
 	int nbq;

-- 
2.55.0

