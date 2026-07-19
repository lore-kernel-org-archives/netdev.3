Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A52E1C7C;
	Sun, 19 Jul 2026 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784439083; cv=none; b=EhoQ6/RvDRxB/t3qaBjzqDygosaLRNj7IThqRkElTvvkGXi1n6/0F0xuCcxgx/MpK0HeObmRLqg9kxUpnzzEVEnmUQ+itGH42X8B0XOUtI9rewS6EFVG8y36d1aEvemAwgey+7OFlie5WsJ/Hz5DGLMmN5fW5j2Ky7aMfpbvd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784439083; c=relaxed/simple;
	bh=p/J5zBvlooAb3AW4HoGNAlUH8lpu+4TEI5vxm/YIb6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbvhNM7uTZY6ywBsyQgfM8EHpyOAOOoaRKewvMt6zyhAvSH+wrRlqAOehCq0IaGJ8o2ADtL6NTVwVl/pP8I34/FiVrbHfKISNMBjJP9FI+fiBpCZ92T0aJBjsH4qCeWq9yn+ufBOqWmppZbs3dBm6VT1UCdqe1RvTaqE5/87tU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=a5kd8Sco; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="a5kd8Sco"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 6A6B9621DD;
	Sun, 19 Jul 2026 01:31:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784439074; bh=taKk5GGGOvyjf/PNarDXZt/ilsxoc27/UgcXXpAe8YY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a5kd8ScoTOrarvTIrYsr43j9mDGytKVS/LOu2PEDsumSVNLj2m5gVHnIiCbaxzedW
	 rErkhCAYLNtqM8tyzEuioOldvCAaVFjwZ3FlGCzNRKJ0CFEHnRz6bZpe6vS68C7pji
	 S6+y8ujQtpDcLLTdhEBSVVdnPz/5Jyn9ZdIyXqSVRSOZqa0JFMyTpN1Ufdup0mmfmQ
	 /Qz3YMHzJJnslg/W8/dMB8qfDIoN2QSmkq0tQnrRIsCO9Eo5EQyh/aoJmLT8KK9Do/
	 ksJZ2DU+7Mi5gkepailgFbeWvrdmz8NZSr+JcyD9Q38NOUE9ub5zVCkCedHr6vOVjh
	 sLI5hnqRogQbQ==
From: Luke Howard <lukeh@padl.com>
Date: Sun, 19 Jul 2026 15:30:55 +1000
Subject: [PATCH net-next v3 3/3] net: dsa: mv88e6xxx: apply embedded PTP
 arrival times inline
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-mv88e6xxx-ptp-fixes-v3-3-161386ac8a62@padl.com>
References: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
In-Reply-To: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784439056; l=11404;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=p/J5zBvlooAb3AW4HoGNAlUH8lpu+4TEI5vxm/YIb6U=;
 b=VOt5mDrbHTvllJljve1MzyqnccwMWffsfSTrT/+kyBpUyIaV9m9yt4cHTF7+nQYtJf1Nq5LCT
 90Eb196Ud+cCSpNNzl38q7Eh8AEaT/VT64/7XfxWHZKD1xyUT0W8P8S
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Embedded PTP arrival times can be extracted without using the PTP
worker, avoiding the issue where PTP general messages could arrive
before the timestamped event messages. DSA can deliver the frame
normally, similar to ocelot_ptp_rx_timestamp().

The register-based arrival path is unchanged.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c     |  1 +
 drivers/net/dsa/mv88e6xxx/chip.h     |  7 ++--
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 69 +++++++++++++-----------------------
 drivers/net/dsa/mv88e6xxx/ptp.c      | 65 ++++++++++++++++++++++++++++-----
 drivers/net/dsa/mv88e6xxx/ptp.h      |  1 +
 5 files changed, 87 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c3277c1f3d785..624cdf6c80a67 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6638,6 +6638,7 @@ static struct mv88e6xxx_chip *mv88e6xxx_alloc_chip(struct device *dev)
 	chip->dev = dev;
 
 	mutex_init(&chip->reg_lock);
+	spin_lock_init(&chip->ptp_clock_lock);
 	INIT_LIST_HEAD(&chip->mdios);
 	idr_init(&chip->policies);
 	INIT_LIST_HEAD(&chip->msts);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index b6a90eba81c43..dd52de71360b9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -427,9 +427,12 @@ struct mv88e6xxx_chip {
 	/* GPIO resources */
 	u8 gpio_data[2];
 
-	/* This cyclecounter abstracts the switch PTP time.
-	 * reg_lock must be held for any operation that read()s.
+	/* This cyclecounter abstracts the switch PTP time. ptp_clock_lock
+	 * protects tstamp_cc and tstamp_tc. tstamp_cycles caches the
+	 * result most recently returned by mv88e6xxx_ptp_read_cycles().
 	 */
+	spinlock_t		ptp_clock_lock;
+	u64			tstamp_cycles;
 	struct cyclecounter	tstamp_cc;
 	struct timecounter	tstamp_tc;
 	struct delayed_work	overflow_work;
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index fa5e897182ca2..716cbc2a86922 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -283,35 +283,24 @@ static bool parse_embedded_ts(unsigned int arr_ts_mode,
 	return true;
 }
 
-static void mv88e6xxx_get_rxts_embedded(struct mv88e6xxx_chip *chip,
-					struct mv88e6xxx_port_hwtstamp *ps,
-					struct sk_buff *skb)
+/* Apply the arrival time the switch embedded in the frame. No register access
+ * is needed, so this runs inline on the receive path rather than being handed
+ * to the PTP worker.
+ */
+static void mv88e6xxx_ptp_rx_timestamp(struct mv88e6xxx_chip *chip,
+				       struct sk_buff *skb)
 {
-	struct sk_buff_head *rxq = &ps->rx_queue;
 	struct skb_shared_hwtstamps *shwt;
-	struct sk_buff_head received;
-	unsigned long flags;
 	u64 ns;
 
-	__skb_queue_head_init(&received);
-	__skb_queue_head(&received, skb);
-	spin_lock_irqsave(&rxq->lock, flags);
-	skb_queue_splice_tail_init(rxq, &received);
-	spin_unlock_irqrestore(&rxq->lock, flags);
+	if (!parse_embedded_ts(chip->info->arr_ts_mode, skb, &ns))
+		return;
 
-	mv88e6xxx_reg_lock(chip);
-	skb_queue_walk(&received, skb) {
-		if (!parse_embedded_ts(chip->info->arr_ts_mode, skb, &ns))
-			continue;
-		ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
-		shwt = skb_hwtstamps(skb);
-		memset(shwt, 0, sizeof(*shwt));
-		shwt->hwtstamp = ns_to_ktime(ns);
-	}
-	mv88e6xxx_reg_unlock(chip);
+	ns = mv88e6xxx_timecounter_cyc2time(chip, ns);
 
-	while ((skb = __skb_dequeue(&received)))
-		netif_rx(skb);
+	shwt = skb_hwtstamps(skb);
+	memset(shwt, 0, sizeof(*shwt));
+	shwt->hwtstamp = ns_to_ktime(ns);
 }
 
 static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
@@ -358,9 +347,7 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
 			ns = timehi << 16 | timelo;
 
-			mv88e6xxx_reg_lock(chip);
-			ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
-			mv88e6xxx_reg_unlock(chip);
+			ns = mv88e6xxx_timecounter_cyc2time(chip, ns);
 			shwt = skb_hwtstamps(skb);
 			memset(shwt, 0, sizeof(*shwt));
 			shwt->hwtstamp = ns_to_ktime(ns);
@@ -376,20 +363,6 @@ static void mv88e6xxx_rxtstamp_work(struct mv88e6xxx_chip *chip,
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
 	struct sk_buff *skb;
 
-	if (chip->info->arr_ts_mode) {
-		/* If arr_ts_mode is set, the timestamps are embedded in the
-		 * frames so a register read is not required. We still need a
-		 * work queue rather than processing inline because
-		 * timecounter_cyc2time() takes the global mutex and this
-		 * cannot be called from mv88e6xxx_port_rxtstamp().
-		 */
-		skb = skb_dequeue(&ps->rx_queue);
-		if (skb)
-			mv88e6xxx_get_rxts_embedded(chip, ps, skb);
-
-		return;
-	}
-
 	skb = skb_dequeue(&ps->rx_queue);
 	if (skb)
 		mv88e6xxx_get_rxts(chip, ps, skb, ptp_ops->arr0_sts_reg,
@@ -432,7 +405,13 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 
 	SKB_PTP_TYPE(skb) = type;
 
-	if (!chip->info->arr_ts_mode && is_pdelay_msg(hdr))
+	/* Embedded arrival times can be returned inline. */
+	if (chip->info->arr_ts_mode) {
+		mv88e6xxx_ptp_rx_timestamp(chip, skb);
+		return false;
+	}
+
+	if (is_pdelay_msg(hdr))
 		skb_queue_tail(&ps->rx_queue2, skb);
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
@@ -498,9 +477,7 @@ static int mv88e6xxx_txtstamp_work(struct mv88e6xxx_chip *chip,
 
 	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
 	time_raw = ((u32)departure_block[2] << 16) | departure_block[1];
-	mv88e6xxx_reg_lock(chip);
-	ns = timecounter_cyc2time(&chip->tstamp_tc, time_raw);
-	mv88e6xxx_reg_unlock(chip);
+	ns = mv88e6xxx_timecounter_cyc2time(chip, time_raw);
 	shhwtstamps.hwtstamp = ns_to_ktime(ns);
 
 	dev_dbg(chip->dev,
@@ -543,7 +520,9 @@ long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
 		if (test_bit(MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS, &ps->state))
 			restart |= mv88e6xxx_txtstamp_work(chip, ps);
 
-		mv88e6xxx_rxtstamp_work(chip, ps);
+		/* Embedded arrival times are applied on the receive path. */
+		if (!chip->info->arr_ts_mode)
+			mv88e6xxx_rxtstamp_work(chip, ps);
 	}
 
 	return restart ? 1 : -1;
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index f7603573d3a98..2a7f97625e375 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -231,15 +231,37 @@ static void mv88e6352_tai_event_work(struct work_struct *ugly)
 
 	/* We only have one timestamping channel. */
 	ev.index = 0;
-	mv88e6xxx_reg_lock(chip);
-	ev.timestamp = timecounter_cyc2time(&chip->tstamp_tc, raw_ts);
-	mv88e6xxx_reg_unlock(chip);
+	ev.timestamp = mv88e6xxx_timecounter_cyc2time(chip, raw_ts);
 
 	ptp_clock_event(chip->ptp_clock, &ev);
 out:
 	schedule_delayed_work(&chip->tai_event_work, TAI_EVENT_WORK_INTERVAL);
 }
 
+/* Refresh the cached counter value that the read() callback returns. The
+ * read cannot acquire the register lock whilst holding ptp_clock_lock
+ * because MDIO reads can sleep. The caller must hold reg_lock, which
+ * serializes against the other timecounter writers.
+ */
+static void mv88e6xxx_ptp_read_cycles(struct mv88e6xxx_chip *chip)
+{
+	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
+
+	if (ptp_ops->clock_read)
+		chip->tstamp_cycles = ptp_ops->clock_read(&chip->tstamp_cc);
+}
+
+u64 mv88e6xxx_timecounter_cyc2time(struct mv88e6xxx_chip *chip, u64 cycles)
+{
+	u64 ns;
+
+	spin_lock_bh(&chip->ptp_clock_lock);
+	ns = timecounter_cyc2time(&chip->tstamp_tc, cycles);
+	spin_unlock_bh(&chip->ptp_clock_lock);
+
+	return ns;
+}
+
 static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
@@ -258,9 +280,12 @@ static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	diff = div_u64(adj, chip->cc_coeffs->cc_mult_dem);
 
 	mv88e6xxx_reg_lock(chip);
+	mv88e6xxx_ptp_read_cycles(chip);
 
+	spin_lock_bh(&chip->ptp_clock_lock);
 	timecounter_read(&chip->tstamp_tc);
 	chip->tstamp_cc.mult = neg_adj ? mult - diff : mult + diff;
+	spin_unlock_bh(&chip->ptp_clock_lock);
 
 	mv88e6xxx_reg_unlock(chip);
 
@@ -271,8 +296,16 @@ static int mv88e6xxx_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
 
+	/* No register access is needed here, but reg_lock still serialises
+	 * this against the other timecounter writers, which drop it only
+	 * after their hardware read has completed.
+	 */
 	mv88e6xxx_reg_lock(chip);
+
+	spin_lock_bh(&chip->ptp_clock_lock);
 	timecounter_adjtime(&chip->tstamp_tc, delta);
+	spin_unlock_bh(&chip->ptp_clock_lock);
+
 	mv88e6xxx_reg_unlock(chip);
 
 	return 0;
@@ -285,7 +318,12 @@ static int mv88e6xxx_ptp_gettime(struct ptp_clock_info *ptp,
 	u64 ns;
 
 	mv88e6xxx_reg_lock(chip);
+	mv88e6xxx_ptp_read_cycles(chip);
+
+	spin_lock_bh(&chip->ptp_clock_lock);
 	ns = timecounter_read(&chip->tstamp_tc);
+	spin_unlock_bh(&chip->ptp_clock_lock);
+
 	mv88e6xxx_reg_unlock(chip);
 
 	*ts = ns_to_timespec64(ns);
@@ -302,7 +340,12 @@ static int mv88e6xxx_ptp_settime(struct ptp_clock_info *ptp,
 	ns = timespec64_to_ns(ts);
 
 	mv88e6xxx_reg_lock(chip);
+	mv88e6xxx_ptp_read_cycles(chip);
+
+	spin_lock_bh(&chip->ptp_clock_lock);
 	timecounter_init(&chip->tstamp_tc, &chip->tstamp_cc, ns);
+	spin_unlock_bh(&chip->ptp_clock_lock);
+
 	mv88e6xxx_reg_unlock(chip);
 
 	return 0;
@@ -444,14 +487,12 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
 };
 
+/* Return the value most recently fetched by mv88e6xxx_ptp_read_cycles()
+ * rather than reading the hardware over MDIO.
+ */
 static u64 mv88e6xxx_ptp_clock_read(struct cyclecounter *cc)
 {
-	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
-
-	if (chip->info->ops->ptp_ops->clock_read)
-		return chip->info->ops->ptp_ops->clock_read(cc);
-
-	return 0;
+	return cc_to_chip(cc)->tstamp_cycles;
 }
 
 /* With a 250MHz input clock, the 32-bit timestamp counter overflows in ~17.2
@@ -486,6 +527,12 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	chip->tstamp_cc.mult	= chip->cc_coeffs->cc_mult;
 	chip->tstamp_cc.shift	= chip->cc_coeffs->cc_shift;
 
+	/* Prime the cycle counter cache for the timecounter_init() below.
+	 * The caller holds reg_lock, and nothing can reach the PTP clock
+	 * until ptp_clock_register() below, so no locking is needed here.
+	 */
+	mv88e6xxx_ptp_read_cycles(chip);
+
 	timecounter_init(&chip->tstamp_tc, &chip->tstamp_cc,
 			 ktime_to_ns(ktime_get_real()));
 
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 95bdddb0bf39f..44718e120de20 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -68,6 +68,7 @@
 
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip);
+u64 mv88e6xxx_timecounter_cyc2time(struct mv88e6xxx_chip *chip, u64 cycles);
 
 #define ptp_to_chip(ptp) container_of(ptp, struct mv88e6xxx_chip,	\
 				      ptp_clock_info)

-- 
2.43.0

