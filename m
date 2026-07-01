Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D63D2FE1
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893409; cv=none; b=pE5N2TMC8YpcNkn0k1lUiW59My8bKpii6oYNYGnJUUCbNvATvOxLZUOxwi6QSR8o03cJSb4TyyF03epMNXGwEpZCAD3yB0ZZ45da9QdjI0YDplggr4DQNoltX+y64DcXEwApZEjX3m6cv6If2CKG5SkbSl/IQ4SiiqoVDgPdWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893409; c=relaxed/simple;
	bh=NsOWX4DQvOS8/eT8Kw122NAK+eIPfV8Fq1lHewu7OT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AppsFDIhAkhobK8/lpZwC9jdMe5s3055lfONy7T2Xnd/g4P0h7wdamlChICimcjcVdlOGYY6vFN4Dr6uMWCUUHSsgGjjDNG+mf5v6eWpcsn+JZSBChxx2y8LU0uk29TuDCrHj1DA3pSZ3hIEh2f3ug6pwFcXhEOmxe52husGMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDtPr+zc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDtPr+zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4DE1F00A3A;
	Wed,  1 Jul 2026 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782893407;
	bh=nZ+2B+xaLfX8+tFnRPAnP1FR0Q3RyX1768KOIO+38mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZDtPr+zcus8B3Tw2C4LzlJqZhau8ISDZEqkExI4VtHOAQ2R9yfUMVyJMUKvrx7uQ6
	 K/B28O3j5r5fjsuY+JH3vT9WEtz1bL2TvlQKQaNAeB9FY64pduBMpmQ6lQGy37aA5V
	 b30BcxXCjzRm4hhVuzhQo7E2Kd0RJfCXIRaMKcShixUl1SjclbDnemTfmXY+PkUcJX
	 noOw64er8atV8v19tIW7qkJngZviAimVicpb7w0IldUIOeMZk0FE5B+HoWZ7EIt79Y
	 4zJhRMic3sfNSEDPdba6KylwBsRJxC5kH2i3qcxec5NNEWmkT2H2+XyO1djZu7OHXS
	 b3RP3P1q71YAw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 01 Jul 2026 10:09:26 +0200
Subject: [PATCH net-next v7 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-airoha-ethtool-priv_flags-v7-2-b4153bd44428@kernel.org>
References: <20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org>
In-Reply-To: <20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org>
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

Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++---
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8bba54ebcf07..2c9ceb9f16f8 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2491,16 +2491,20 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
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
+			   dev->qos_stats[channel].cpu_tx_packets) +
+		     (u32)(fwd_tx_packets -
+			   dev->qos_stats[channel].fwd_tx_packets);
 
 	_bstats_update(opt->stats.bstats, 0, tx_packets);
-	dev->cpu_tx_packets = cpu_tx_packets;
-	dev->fwd_tx_packets = fwd_tx_packets;
+	dev->qos_stats[channel].cpu_tx_packets = cpu_tx_packets;
+	dev->qos_stats[channel].fwd_tx_packets = fwd_tx_packets;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 87ab3ea10664..ac5f571f3e53 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -545,9 +545,10 @@ struct airoha_gdm_dev {
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
2.54.0

