Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20953ADB98
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070416; cv=none; b=TJcnkkUg3f11ilsoQ5UjG5KUwZx4vO7H4ZAhLAm3WmYa4L/b+AkLbxMrhdqFCPo5YEo8Hi9WH2byJegPRx2OUwLpstzqhT6sfjJS3685mj0aQ1AfJC+MKsnJNpR8B6s0cWh1oOtRiwObl1tW3jV2FBQAGgO9thdTpLTNybhmpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070416; c=relaxed/simple;
	bh=9tfKi82+gKl4NuEAu+9otAM9qL+evCA7f5THgkApNP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQczfA2xfGZTrzkVzY3G2slkKWYPAe/qGWb/YEwym10GUp7hWcjUlyaIgv93i6DyDLPXpfhgwdkQHxuN5qwiQKA3mjrtLqQSw71p7R/ON3lyKFyab1dTG5yU2x775HGy1J0WQCzTs1IcFnkSED5oBUkFZdDDkqwcbxcaNB815rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I98B/Hgu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I98B/Hgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53B41F00A3E;
	Fri,  3 Jul 2026 09:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783070414;
	bh=RVGZpzobJnt83rgDwOsAgyqT+FGaaTXUCKerOjXE5Cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I98B/Hgujpl5cokwi18qnCTkz4LtT4AvbdZQG0/sX9pxIeX/nBDyIkdza0gD9UTOg
	 lijlUW7cAWCE49XrpxmsyJGkbbIf0hGkBL3Sb5j2owQA3YfrtOdOi8ysFF80QHLanp
	 4WvOf10DfSkYf4VzTocndiTEkI0xfXyNHIzq1SkSH7sGGPEqZPjjU35J9u9xD9i3uu
	 +FOq82Jh3TDMhj9SDuCvMT8kLY9xnQVPQatlXS9o5r09tLyxElH5j+aVlJaH8b3fOV
	 kRKwCKiZBlxebXvERLcQIj7fCuWam+VksCB2RRFcNBcvHTmibnojCxK3Fsgg5Ex/QV
	 JLAxz93cbB5+w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 03 Jul 2026 11:19:26 +0200
Subject: [PATCH net-next v8 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-airoha-ethtool-priv_flags-v8-2-015ba5ac89ee@kernel.org>
References: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
In-Reply-To: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
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

