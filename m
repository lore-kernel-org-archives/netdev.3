Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6763DEAF6;
	Mon, 27 Jul 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124786; cv=none; b=PGnMfUte5YZ9mXP16ntqPxAV7laN4I29SixFnys88Xvwq6Zu6C2RNGFhFiJnd+X2l53VH6BUHQasMnhir+cUJGJIPm/fuRB3Mv5Uz8GB77p1fla9n3yZxy466zn79m415dTK8kR6dWVhNE5s2BHpnhdX80kqZUsDjqB5haovSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124786; c=relaxed/simple;
	bh=BWY+UJOOmFr/bSZpHMdzJNEVBajFyZxZ2BPIn0zyB4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlazTTw8x4LE1qbopKeIgaLOhSceeaZYhO5KCmBFVtModsvtfHY0nUgPZLLosLkiASB7SxyjjT9caP2+kUucfnrBryZStJrABffErPRdXsWFU2SpE5n8cNNdc3yxSU8fDfyfUaA005yJcNiHW8eshB/aw3WWPqoTcfmxLSM3rtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=NjyiILBv; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="NjyiILBv"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 0F8BA6227F;
	Sun, 26 Jul 2026 23:59:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785124783; bh=Eh/HKI8Qn4mJ4lNapJUHHII2ryT1ZabVIqrHcGjHBvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NjyiILBvH0cs5u9i3mQsEcjAVTBHve5dDXDRfAUfvflxVu90W4pLyDhjMQTemfDZE
	 u55uK8aIlhcEPcKprvjgYw4pVAZ2blUYiw4f15ebDp+manpu6Wrbfk/YJWgsXsn9rY
	 Dgo7UV7d0A2fJ+QNOt3GIMT7GIG/ptz7Os/voJZS1gvX2f8pDhbEPx3Wq1AVdXzYVA
	 Ry8p1wIIJaqNtctqNjdPVSWUxQGCvnj1cLQIl7J1tLKnupGgNVX9Qgz2Dl/wcABAJc
	 zCdQ79RQtch3924BsCpSYA4YbS8KJsr/yH7qw8x33/SngQ0DBghc20yivhGTQymJgH
	 08Swu0fcULggg==
From: Luke Howard <lukeh@padl.com>
Date: Mon, 27 Jul 2026 13:59:14 +1000
Subject: [PATCH net-next v4 3/5] net: dsa: mv88e6xxx: decouple the PTP
 timecounter from the register lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mv88e6xxx-ptp-fixes-v4-3-10b4020155fc@padl.com>
References: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
In-Reply-To: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785124760; l=7973;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=BWY+UJOOmFr/bSZpHMdzJNEVBajFyZxZ2BPIn0zyB4k=;
 b=PD/YVfpR9SN5KjWAjX82s2Bhn5bqiubsu3cdMxbDLyQF2ZXt/Y5E/7fKdDnPA5JAb1bq3IL0S
 SUjzFgwssupCyirDYD/MrqN9bQTo1Mrtppv8ONpmgfcdVq9FpA8VHV6
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Use a dedicated spinlock, rather than the chip register mutex, to
protect read access to the hardware timestamp cycle counter.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c     |  1 +
 drivers/net/dsa/mv88e6xxx/chip.h     |  7 ++--
 drivers/net/dsa/mv88e6xxx/hwtstamp.c |  8 ++---
 drivers/net/dsa/mv88e6xxx/ptp.c      | 65 +++++++++++++++++++++++++++++++-----
 drivers/net/dsa/mv88e6xxx/ptp.h      |  1 +
 5 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..b24ebbb275b34 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6635,6 +6635,7 @@ static struct mv88e6xxx_chip *mv88e6xxx_alloc_chip(struct device *dev)
 	chip->dev = dev;
 
 	mutex_init(&chip->reg_lock);
+	spin_lock_init(&chip->ptp_clock_lock);
 	INIT_LIST_HEAD(&chip->mdios);
 	idr_init(&chip->policies);
 	INIT_LIST_HEAD(&chip->msts);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index e966e7c4cc5de..7272b7dc4955c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -419,9 +419,12 @@ struct mv88e6xxx_chip {
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
index d468d988b258c..a5b362a999e64 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -293,9 +293,7 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
 			ns = timehi << 16 | timelo;
 
-			mv88e6xxx_reg_lock(chip);
-			ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
-			mv88e6xxx_reg_unlock(chip);
+			ns = mv88e6xxx_timecounter_cyc2time(chip, ns);
 			shwt = skb_hwtstamps(skb);
 			memset(shwt, 0, sizeof(*shwt));
 			shwt->hwtstamp = ns_to_ktime(ns);
@@ -420,9 +418,7 @@ static int mv88e6xxx_txtstamp_work(struct mv88e6xxx_chip *chip,
 
 	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
 	time_raw = ((u32)departure_block[2] << 16) | departure_block[1];
-	mv88e6xxx_reg_lock(chip);
-	ns = timecounter_cyc2time(&chip->tstamp_tc, time_raw);
-	mv88e6xxx_reg_unlock(chip);
+	ns = mv88e6xxx_timecounter_cyc2time(chip, time_raw);
 	shhwtstamps.hwtstamp = ns_to_ktime(ns);
 
 	dev_dbg(chip->dev,
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

