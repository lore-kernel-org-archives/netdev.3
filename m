Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B73F6C52;
	Tue, 19 May 2026 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181115; cv=none; b=qsseT+Rq1S68ziNC08xXPOVSmKsGj+5EbLutUH0p4lACiqi0Xhst3wckfsvCGXpYWLux3RRVeAJxSRNhHxXZnOXC+Wi91jS4uutI3nZt3C4g7SuHxqg6W7YgWjes6YUdtKJt+mr59SyP2QJWK6aWmXC5+UmzlwoxcKdq879f7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181115; c=relaxed/simple;
	bh=nooHuZGJEFeYRqUP64xp6V05huxhawkLN6x3sj9U1W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjWU3hARK9gVt0yp8XsYQEbdF2qdKaBDQnuDmPVG9Vp4uOV+FOTqHgsa+aEssmvndw6B4NgJjC9ml2nIe4fi4gpK2QFx962q3XwYkNy9+5Y/w0mz1VtY/0qF/CaLEN+lIqjCdjkNEtH2Ea8X1QRQAi+6UMA4DDNqSAMUJMMAURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEyf7m+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEyf7m+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A970C2BCC9;
	Tue, 19 May 2026 08:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181115;
	bh=nooHuZGJEFeYRqUP64xp6V05huxhawkLN6x3sj9U1W4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DEyf7m+KC9XJWRmiKfJkmTNeyDkqDT+hF8BlMoBnjA1tvOk7/xANo9ZgcnIAnpINM
	 biGzFLmHQPbEwqSTljGH7jHwcRF50Cgus/9WamCtwwJbtweeuWHftsxty3iBWHz0Pj
	 AcO1bgq0CiSSvv3pxkxTvpE559N7pdxF8BP7M9QSMNdZc300K6Dc7mu+YQOETwRZMs
	 fP3I4N+C1RHuBTugtliTUNjllxZd4q/9O6/drtEaZMVmpL4J0KCs9ZlblYeXuLbf9O
	 TSHGGXGtcJZaFET9glyR/dL7AJmc38+/mcT0pynWmeGRgK1Fd7QH6ZnlAcL9zY03h5
	 tiHVp3YT4tGoQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 May 2026 10:57:49 +0200
Subject: [PATCH net-next v8 06/10] net: airoha: Move {cpu,fwd}_tx_packets
 in airoha_gdm_dev struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-airoha-eth-multi-serdes-v8-6-6bd70e329df6@kernel.org>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3

Since now multiple net_devices connected to different QDMA blocks can
share the same GDM port, cpu_tx_packets and fwd_tx_packets fields can
be overwritten with the value from a different QDMA block. In order to
fix the issue move cpu_tx_packets and fwd_tx_packets fields from
airoha_gdm_port struct to airoha_gdm_dev one.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 16 +++++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  7 +++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 594fbebcb12c..27b214ce2a4e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2313,19 +2313,17 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
-	u64 cpu_tx_packets = airoha_qdma_rr(dev->qdma,
-					    REG_CNTR_VAL(channel << 1));
-	u64 fwd_tx_packets = airoha_qdma_rr(dev->qdma,
+	u64 cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
+	u64 fwd_tx_packets = airoha_qdma_rr(qdma,
 					    REG_CNTR_VAL((channel << 1) + 1));
-	u64 tx_packets = (cpu_tx_packets - port->cpu_tx_packets) +
-			 (fwd_tx_packets - port->fwd_tx_packets);
+	u64 tx_packets = (cpu_tx_packets - dev->cpu_tx_packets) +
+			 (fwd_tx_packets - dev->fwd_tx_packets);
 
 	_bstats_update(opt->stats.bstats, 0, tx_packets);
-
-	port->cpu_tx_packets = cpu_tx_packets;
-	port->fwd_tx_packets = fwd_tx_packets;
+	dev->cpu_tx_packets = cpu_tx_packets;
+	dev->fwd_tx_packets = fwd_tx_packets;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index a308a770116b..fbb50dc73af8 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -544,6 +544,9 @@ struct airoha_gdm_dev {
 	struct airoha_eth *eth;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
+	/* qos stats counters */
+	u64 cpu_tx_packets;
+	u64 fwd_tx_packets;
 };
 
 struct airoha_gdm_port {
@@ -553,10 +556,6 @@ struct airoha_gdm_port {
 
 	struct airoha_hw_stats stats;
 
-	/* qos stats counters */
-	u64 cpu_tx_packets;
-	u64 fwd_tx_packets;
-
 	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };
 

-- 
2.54.0

