Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395813DB626;
	Mon, 27 Jul 2026 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124798; cv=none; b=IteirB5xAhPJKhV9AuvRLmDJkvTw+B2WQrea/5yrUjhH6oWkP56lMtYsFkoX9HHNY2r33sVANOBk/DrhUBNWv/SaKscYdNZNwv/4HAa+/Gy/nujGTlAIGkpB2SxcOLIsN6IGZ+vXbsAv4kF5lGaa+8JzvFOl2I1QecsQ4rxAyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124798; c=relaxed/simple;
	bh=sy0PmpIpFhmH5cFnllL9q7z513ZwMQODfcwEL1EMB7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZnrVrbzL2daGuEFVNA51b8o9iDkQmtFKY3WP0RFJl0cPGWGC5rc73FiTwYdM6vV4balAh4o4tIfxfdlAzoL1clpuOsvNJJLzZr7WeBONzSFRuPWHOInGhwS78Dgd4qwcRfiEp+JwDDfX2K8BoVg/1izygHlDcWLFSxfvW3T8/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=azMp3mao; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="azMp3mao"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 5EB2760BED;
	Sun, 26 Jul 2026 23:59:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785124794; bh=pInsbW8VxvNPJOM8cbKxwKfOnk/j22NjLsGda4tRBOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=azMp3maoyi8c/BLniCRpi5myOesu+CBDYVz8noMLFTdhfa3c1JVBSX6DJorf7uzrL
	 8nbbipsvcj9UvATW45kIO2P3J3GRBi9UxwtwCb5lwbINJ2JZFhOFmGqgE6VfGPlc/C
	 5lFzmerurnKwjWRQrDy65TjvfbLLFuf7VEIzLzJ/Cd0yrrK+b9jSRyzyZE4SkYyjfi
	 C2EyDrtwv0aQoocyHJxYnl32CkOGKiwNuBr9GdtfK2N51XuiukFypWCv+1PwcrgKqg
	 kNLr1UyQ9e29+FZPd7KiJf3e7f8gXtpyBwH420SPWTD8CE6vH1Q1Faf/JpI6XxVz1P
	 BZDi4FCubZKqQ==
From: Luke Howard <lukeh@padl.com>
Date: Mon, 27 Jul 2026 13:59:16 +1000
Subject: [PATCH net-next v4 5/5] net: dsa: mv88e6xxx: embedded PTP
 timestamp support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mv88e6xxx-ptp-fixes-v4-5-10b4020155fc@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785124760; l=18981;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=sy0PmpIpFhmH5cFnllL9q7z513ZwMQODfcwEL1EMB7M=;
 b=hb3EL4BFLK8YCFSC6LogOGxc6qqS3gsQB2JdNcmG/MBYxeGkYEEX1NhyL78ugOS/JzLSMplkv
 spL9kz1aO3FBZqMj06iVwvqT9Pq5EtFux37mc0JtBqNslHzIRU+Nj/4
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

mv88e6xxx switches can embed the PTP arrival timestamp directly in the
frame, at a configurable offset from the PTP common header, typically
the offset of the reserved2 field.

Add support for this on the 88E6341 and 88E6352 switches, being those on
which I was able to verify this. Other switch chips may also work. The
arrival timestamp offsets are relative to the PTP common header and will
work for both L2 and L3 PTP packets; the respective headers are skipped
by the number of bytes set in the ETJump and IPJump registers, which are
initialized to sensible defaults and are VLAN tag-aware.

This feature is off by default and must be enabled by selecting the
"edsa-ptp-reserved2-ts" DSA tag protocol.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c     |  29 +++++-
 drivers/net/dsa/mv88e6xxx/chip.h     |  15 +++
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 194 ++++++++++++++++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |  21 +++-
 include/net/dsa.h                    |   2 +
 net/dsa/tag_dsa.c                    |  18 ++++
 6 files changed, 262 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b24ebbb275b34..e92524beb40c4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3271,7 +3271,8 @@ static int mv88e6xxx_setup_port_mode(struct mv88e6xxx_chip *chip, int port)
 	if (chip->tag_protocol == DSA_TAG_PROTO_DSA)
 		return mv88e6xxx_set_port_mode_dsa(chip, port);
 
-	if (chip->tag_protocol == DSA_TAG_PROTO_EDSA)
+	if (chip->tag_protocol == DSA_TAG_PROTO_EDSA ||
+	    chip->tag_protocol == DSA_TAG_PROTO_EDSA_PTP_RESERVED2_TS)
 		return mv88e6xxx_set_port_mode_edsa(chip, port);
 
 	return -EINVAL;
@@ -6370,6 +6371,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.ops = &mv88e6341_ops,
+		.supports_ptp_embedded_ts = true,
 	},
 
 	[MV88E6350] = {
@@ -6447,6 +6449,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.ops = &mv88e6352_ops,
+		.supports_ptp_embedded_ts = true,
 	},
 	[MV88E6361] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6361,
@@ -6659,9 +6662,17 @@ static int mv88e6xxx_change_tag_protocol(struct dsa_switch *ds,
 	struct mv88e6xxx_chip *chip = ds->priv;
 	enum dsa_tag_protocol old_protocol;
 	struct dsa_port *cpu_dp;
-	int err;
+	int err = 0;
 
+	/* The embedded arrival-time-stamp protocol is an EDSA extension: EDSA
+	 * is the modern tag format for these switches, so it is the one we
+	 * extend; the legacy DSA tag is intentionally left un-extended.
+	 */
 	switch (proto) {
+	case DSA_TAG_PROTO_EDSA_PTP_RESERVED2_TS:
+		if (!chip->info->supports_ptp_embedded_ts)
+			return -EPROTONOSUPPORT;
+		fallthrough;
 	case DSA_TAG_PROTO_EDSA:
 		switch (chip->info->edsa_support) {
 		case MV88E6XXX_EDSA_UNSUPPORTED:
@@ -6690,7 +6701,12 @@ static int mv88e6xxx_change_tag_protocol(struct dsa_switch *ds,
 			goto unwind;
 		}
 	}
+
+	if (chip->info->ptp_support)
+		err = mv88e6xxx_hwtstamp_setup_arr_ts(chip);
 	mv88e6xxx_reg_unlock(chip);
+	if (err)
+		goto unwind;
 
 	return 0;
 
@@ -6700,6 +6716,15 @@ static int mv88e6xxx_change_tag_protocol(struct dsa_switch *ds,
 	mv88e6xxx_reg_lock(chip);
 	dsa_switch_for_each_cpu_port_continue_reverse(cpu_dp, ds)
 		mv88e6xxx_setup_port_mode(chip, cpu_dp->index);
+	if (chip->info->ptp_support) {
+		/* Nothing else can be done here, but leaving a port embedding
+		 * time stamps the driver will not strip corrupts every PTP
+		 * event frame it receives, so make the failure visible.
+		 */
+		if (mv88e6xxx_hwtstamp_setup_arr_ts(chip))
+			dev_err(chip->dev,
+				"failed to restore arrival time stamp mode\n");
+	}
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 7272b7dc4955c..c75a71464b20a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -180,6 +180,13 @@ struct mv88e6xxx_info {
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
 	unsigned int internal_phys_offset;
+
+	/* The switch can embed the PTP arrival time stamp in the reserved2
+	 * field of the PTP common header, which the edsa-ptp-reserved2-ts
+	 * tag protocol selects. Otherwise arrival time stamps are only
+	 * available from the switch registers.
+	 */
+	bool supports_ptp_embedded_ts;
 };
 
 struct mv88e6xxx_atu_entry {
@@ -818,6 +825,14 @@ static inline bool mv88e6xxx_has_lag(struct mv88e6xxx_chip *chip)
 	return !!chip->info->global2_addr;
 }
 
+/* Whether the active tagging protocol has the switch embed arrival time stamps
+ * in the frame instead of leaving them in the PTP arrival registers.
+ */
+static inline bool mv88e6xxx_ptp_embedded_ts(struct mv88e6xxx_chip *chip)
+{
+	return chip->tag_protocol == DSA_TAG_PROTO_EDSA_PTP_RESERVED2_TS;
+}
+
 static inline bool mv88e6xxx_has_tcam(struct mv88e6xxx_chip *chip)
 {
 	return !!chip->info->tcam_addr;
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index a5b362a999e64..74eaadeeeb784 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -15,6 +15,7 @@
 #include "hwtstamp.h"
 #include "ptp.h"
 #include <linux/ptp_classify.h>
+#include <linux/unaligned.h>
 
 #define SKB_PTP_TYPE(__skb) (*(unsigned int *)((__skb)->cb))
 
@@ -94,6 +95,7 @@ static int mv88e6xxx_set_hwtstamp_config(struct mv88e6xxx_chip *chip, int port,
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
 	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
 	bool tstamp_enable = false;
+	int err = 0;
 
 	/* Prevent the TX/RX paths from trying to interact with the
 	 * timestamp hardware while we reconfigure it.
@@ -147,20 +149,30 @@ static int mv88e6xxx_set_hwtstamp_config(struct mv88e6xxx_chip *chip, int port,
 	if (tstamp_enable) {
 		chip->enable_count += 1;
 		if (chip->enable_count == 1 && ptp_ops->global_enable)
-			ptp_ops->global_enable(chip);
-		if (ptp_ops->port_enable)
-			ptp_ops->port_enable(chip, port);
+			err = ptp_ops->global_enable(chip);
+		if (!err && ptp_ops->port_enable)
+			err = ptp_ops->port_enable(chip, port);
 	} else {
 		if (ptp_ops->port_disable)
-			ptp_ops->port_disable(chip, port);
+			err = ptp_ops->port_disable(chip, port);
 		chip->enable_count -= 1;
 		if (chip->enable_count == 0 && ptp_ops->global_disable)
 			ptp_ops->global_disable(chip);
 	}
 	mv88e6xxx_reg_unlock(chip);
 
+	if (err)
+		return err;
+
 	/* Once hardware has been configured, enable timestamp checks
 	 * in the RX/TX paths.
+	 *
+	 * In embedded mode the switch starts overwriting the PTP header's
+	 * reserved2 field as soon as CFG2 is armed above, which is before the
+	 * RX path begins restoring it; on the way down the RX path stops
+	 * restoring before the hardware stops embedding. An event frame
+	 * received inside either window is delivered with the switch's
+	 * arrival counter still in its header.
 	 */
 	if (tstamp_enable)
 		set_bit(MV88E6XXX_HWTSTAMP_ENABLED, &ps->state);
@@ -249,6 +261,52 @@ static int seq_match(struct sk_buff *skb, u16 ts_seqid)
 	return ts_seqid == ntohs(hdr->sequence_id);
 }
 
+/* Recover the arrival time the switch wrote over the reserved2 field of the PTP
+ * common header, restoring the field afterwards.
+ */
+static bool parse_embedded_ts(struct sk_buff *skb, u64 *ns)
+{
+	unsigned int off = MV88E6XXX_PTP_ARR_TS_OFFSET;
+	struct ptp_header *hdr;
+
+	*ns = 0;
+
+	if (skb_linearize(skb))
+		return false;
+
+	hdr = ptp_parse_header(skb, SKB_PTP_TYPE(skb));
+	if (!hdr)
+		return false;
+
+	*ns = get_unaligned_be32((u8 *)hdr + off);
+	memset((u8 *)hdr + off, 0, 4);
+	skb_checksum_complete_unset(skb);
+
+	return true;
+}
+
+/* Apply the arrival time the switch embedded in the frame. No register access
+ * is needed, so this runs inline on the receive path rather than being handed
+ * to the PTP worker. Returns false if the frame could not be restored.
+ */
+static bool mv88e6xxx_ptp_rx_timestamp(struct mv88e6xxx_chip *chip,
+				       struct sk_buff *skb)
+{
+	struct skb_shared_hwtstamps *shwt;
+	u64 ns;
+
+	if (!parse_embedded_ts(skb, &ns))
+		return false;
+
+	ns = mv88e6xxx_timecounter_cyc2time(chip, ns);
+
+	shwt = skb_hwtstamps(skb);
+	memset(shwt, 0, sizeof(*shwt));
+	shwt->hwtstamp = ns_to_ktime(ns);
+
+	return true;
+}
+
 static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 			       struct mv88e6xxx_port_hwtstamp *ps,
 			       struct sk_buff *skb, u16 reg,
@@ -310,7 +368,6 @@ static void mv88e6xxx_rxtstamp_work(struct mv88e6xxx_chip *chip,
 	struct sk_buff *skb;
 
 	skb = skb_dequeue(&ps->rx_queue);
-
 	if (skb)
 		mv88e6xxx_get_rxts(chip, ps, skb, ptp_ops->arr0_sts_reg,
 				   &ps->rx_queue);
@@ -352,6 +409,21 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 
 	SKB_PTP_TYPE(skb) = type;
 
+	/* Embedded arrival times can be returned inline. The switch has
+	 * overwritten the reserved2 field; if it cannot be restored the frame
+	 * is no longer what the sender transmitted, so drop it rather than
+	 * pass up a corrupted header that will fail the PTP-over-UDP checksum
+	 * anyway.
+	 */
+	if (mv88e6xxx_ptp_embedded_ts(chip)) {
+		if (!mv88e6xxx_ptp_rx_timestamp(chip, skb)) {
+			kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+			return true;
+		}
+
+		return false;
+	}
+
 	if (is_pdelay_msg(hdr))
 		skb_queue_tail(&ps->rx_queue2, skb);
 	else
@@ -461,7 +533,9 @@ long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
 		if (test_bit(MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS, &ps->state))
 			restart |= mv88e6xxx_txtstamp_work(chip, ps);
 
-		mv88e6xxx_rxtstamp_work(chip, ps);
+		/* Embedded arrival times are applied on the receive path. */
+		if (!mv88e6xxx_ptp_embedded_ts(chip))
+			mv88e6xxx_rxtstamp_work(chip, ps);
 	}
 
 	return restart ? 1 : -1;
@@ -530,14 +604,43 @@ int mv88e6165_global_enable(struct mv88e6xxx_chip *chip)
 
 int mv88e6352_hwtstamp_port_disable(struct mv88e6xxx_chip *chip, int port)
 {
-	return mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
-					MV88E6XXX_PORT_PTP_CFG0_DISABLE_PTP);
+	int err;
+
+	err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
+				       MV88E6XXX_PORT_PTP_CFG0_DISABLE_PTP);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG2, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/* Return the CFG2 ArrTSMode field for the active arrival time-stamp mode. */
+static u16 mv88e6xxx_arr_ts_cfg2(struct mv88e6xxx_chip *chip)
+{
+	return mv88e6xxx_ptp_embedded_ts(chip) ?
+		MV88E6XXX_PORT_PTP_CFG2_ARR_TS_RESERVED2 :
+		MV88E6XXX_PORT_PTP_CFG2_ARR_TS_DISABLED;
 }
 
 int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port)
 {
-	return mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
-					MV88E6XXX_PORT_PTP_CFG0_DISABLE_TSPEC_MATCH);
+	int err;
+
+	err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG2,
+				       mv88e6xxx_arr_ts_cfg2(chip));
+	if (err)
+		return err;
+
+	err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
+				       MV88E6XXX_PORT_PTP_CFG0_DISABLE_TSPEC_MATCH);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int mv88e6xxx_hwtstamp_port_setup(struct mv88e6xxx_chip *chip, int port)
@@ -556,6 +659,72 @@ static int mv88e6xxx_hwtstamp_port_setup(struct mv88e6xxx_chip *chip, int port)
 	return 0;
 }
 
+/* Program the hardware for the arrival time-stamp mode the active tagging
+ * protocol selects. Called from setup and again whenever the protocol changes,
+ * as that is what decides where arrival time stamps are delivered.
+ *
+ * Must be called with the register lock held.
+ */
+int mv88e6xxx_hwtstamp_setup_arr_ts(struct mv88e6xxx_chip *chip)
+{
+	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
+	int err, ret = 0;
+	int i;
+
+	/* In embedded mode the switch stamps every event message it forwards,
+	 * peer delay included, so leave the arrival capture pointer alone
+	 * rather than diverting peer delay messages to the ARRIVAL1 registers.
+	 */
+	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
+				  mv88e6xxx_ptp_embedded_ts(chip) ? 0 :
+				  MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ |
+				  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
+	if (err)
+		return err;
+
+	if (!chip->info->supports_ptp_embedded_ts)
+		return 0;
+
+	for (i = 0; i < mv88e6xxx_num_ports(chip); ++i) {
+		struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[i];
+
+		/* Anything already queued was queued under the previous mode
+		 * and can no longer be matched with an arrival time.
+		 */
+		skb_queue_purge(&ps->rx_queue);
+		skb_queue_purge(&ps->rx_queue2);
+
+		/* The arrival registers keep capturing in embedded mode with
+		 * nothing to drain them, so clear the status here or the
+		 * register path resumes on a stale capture.
+		 */
+		err = mv88e6xxx_port_ptp_write(chip, i, ptp_ops->arr0_sts_reg, 0);
+		if (err && !ret)
+			ret = err;
+
+		err = mv88e6xxx_port_ptp_write(chip, i, ptp_ops->arr1_sts_reg, 0);
+		if (err && !ret)
+			ret = err;
+
+		/* Ports that have not enabled time stamping pick the mode up in
+		 * mv88e6352_hwtstamp_port_enable().
+		 */
+		if (ps->tstamp_config.rx_filter == HWTSTAMP_FILTER_NONE)
+			continue;
+
+		/* Program every port even if one fails. A port left embedding
+		 * time stamps that the driver no longer strips corrupts the
+		 * PTP header of every event frame it receives.
+		 */
+		err = mv88e6xxx_port_ptp_write(chip, i, MV88E6XXX_PORT_PTP_CFG2,
+					       mv88e6xxx_arr_ts_cfg2(chip));
+		if (err && !ret)
+			ret = err;
+	}
+
+	return ret;
+}
+
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
@@ -591,10 +760,7 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	/* Use ARRIVAL1 for peer delay messages. */
-	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
-				  MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ |
-				  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
+	err = mv88e6xxx_hwtstamp_setup_arr_ts(chip);
 	if (err)
 		return err;
 
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index c359821d5a6ea..2fe7c7429bff1 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -13,6 +13,8 @@
 #ifndef _MV88E6XXX_HWTSTAMP_H
 #define _MV88E6XXX_HWTSTAMP_H
 
+#include <linux/ptp_classify.h>
+
 #include "chip.h"
 
 /* Global 6352 PTP registers */
@@ -64,10 +66,21 @@
 
 /* Offset 0x02: PTP Configuration 2 */
 #define MV88E6XXX_PORT_PTP_CFG2				0x02
-#define MV88E6XXX_PORT_PTP_CFG2_EMBED_ARRIVAL		0x1000
 #define MV88E6XXX_PORT_PTP_CFG2_DEP_IRQ_EN		0x0002
 #define MV88E6XXX_PORT_PTP_CFG2_ARR_IRQ_EN		0x0001
 
+/* Arrival Time Stamp Mode (ArrTSMode), CFG2 bits [15:8]: configures how the
+ * switch embeds the arrival time stamp (PTPArr0Time) into enabled PTP event
+ * frames. A non-zero value is the byte offset, from the start of the PTP common
+ * header, at which the switch overwrites four bytes in place; we always point
+ * it at the header's reserved2 field so the frame length is left alone.
+ */
+#define MV88E6XXX_PTP_ARR_TS_OFFSET			\
+	offsetof(struct ptp_header, reserved2)
+#define MV88E6XXX_PORT_PTP_CFG2_ARR_TS_DISABLED		0x0000
+#define MV88E6XXX_PORT_PTP_CFG2_ARR_TS_RESERVED2	\
+	(MV88E6XXX_PTP_ARR_TS_OFFSET << 8)
+
 /* Offset 0x03: PTP LED Configuration */
 #define MV88E6XXX_PORT_PTP_LED_CFG	0x03
 
@@ -126,6 +139,7 @@ int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 
 long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp);
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip);
+int mv88e6xxx_hwtstamp_setup_arr_ts(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip);
 int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_hwtstamp_port_disable(struct mv88e6xxx_chip *chip, int port);
@@ -172,6 +186,11 @@ static inline int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+static inline int mv88e6xxx_hwtstamp_setup_arr_ts(struct mv88e6xxx_chip *chip)
+{
+	return 0;
+}
+
 static inline void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip)
 {
 }
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8c16ef23cc102..2dfcc549de296 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -59,6 +59,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
 #define DSA_TAG_PROTO_NETC_VALUE		33
+#define DSA_TAG_PROTO_EDSA_PTP_RESERVED2_TS_VALUE	34
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -95,6 +96,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
 	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
+	DSA_TAG_PROTO_EDSA_PTP_RESERVED2_TS = DSA_TAG_PROTO_EDSA_PTP_RESERVED2_TS_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index d5ffee35fbb53..7490ecc04aa57 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -402,6 +402,23 @@ static const struct dsa_device_ops edsa_netdev_ops = {
 
 DSA_TAG_DRIVER(edsa_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_EDSA, EDSA_NAME);
+
+#define EDSA_PTP_RESERVED2_TS_NAME	"edsa-ptp-reserved2-ts"
+
+/* Same wire format as EDSA, except that the switch overwrites the reserved2
+ * field of the PTP common header with the frame's arrival time stamp.
+ */
+static const struct dsa_device_ops edsa_ptp_reserved2_ts_netdev_ops = {
+	.name		 = EDSA_PTP_RESERVED2_TS_NAME,
+	.proto		 = DSA_TAG_PROTO_EDSA_PTP_RESERVED2_TS,
+	.xmit		 = edsa_xmit,
+	.rcv		 = edsa_rcv,
+	.needed_headroom = EDSA_HLEN,
+};
+
+DSA_TAG_DRIVER(edsa_ptp_reserved2_ts_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_EDSA_PTP_RESERVED2_TS,
+			    EDSA_PTP_RESERVED2_TS_NAME);
 #endif	/* CONFIG_NET_DSA_TAG_EDSA */
 
 static struct dsa_tag_driver *dsa_tag_drivers[] = {
@@ -410,6 +427,7 @@ static struct dsa_tag_driver *dsa_tag_drivers[] = {
 #endif
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_EDSA)
 	&DSA_TAG_DRIVER_NAME(edsa_netdev_ops),
+	&DSA_TAG_DRIVER_NAME(edsa_ptp_reserved2_ts_netdev_ops),
 #endif
 };
 

-- 
2.43.0

