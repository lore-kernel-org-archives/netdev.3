Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F134D8CE;
	Sun, 19 Jul 2026 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784439073; cv=none; b=Ic18cQzUUNbo2pe1r4UQHAPkWUFowWeeln97epaHJe2Xb9EI+9MlbsUwKMb3J3RB3B0dr7M3otCVUGuzni3ISUXPASNwSLHMhukGl5TKZvuUjmAca9OzhPjMAyrTZwi2EjaRXgI4uCyOl/fZD10miotVrjRTLn8yGmU2cWtm6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784439073; c=relaxed/simple;
	bh=VQJDRxAA6T5afKbHAOHhm/scPrBhzoEHJ1AKnjYlzc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lt1HFoq8EXnVyruuoyyYCaUc2K/PfqZhRV2OrIB+yTH2FeuLhRh9oLBAhjbwsRmBmgBBy5OPpa8PM1A1G0wE4zD9hsPIcgvmY+O2lTvJ89GWcQyxpqYqNyzBVFSymWo9TrayjOZaQWCskDnN0F7nkUlAHRfwOudLgxY4LQHViEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=saxBk3RK; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="saxBk3RK"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 0F7DE61932;
	Sun, 19 Jul 2026 01:31:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784439070; bh=iDVz1EaZ6nKjivhC8mxmJVkOeFg8forT8bnVhF6H8LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=saxBk3RKlV5JS6ku/LYdXlElmNfo13OD8g3jTBfCrfZEapi79q7GtiSmJ6ZEPcVl6
	 b+8vDyAab7XaM8SbUzIz2xQpzPNk3IvNjO4o0Y8Iy9+1UYzmMiscA6q2znAY3M0ebQ
	 soo08R4SJgrH/KoyxpUZhWu/Z0R4wg3tqynuv+XQ7tTZlLAf+hh5nF8x8PmNJrlVZl
	 QZOMtwPywmGs3W9sVcIw+ZViGv4GoLZowQeNvmEJmTzfzOvPE/ZbFNbPlxtFq3LveI
	 VNchz2luhzuMmywFeKij6dfaC8LCJ1+XCfQ3rldBG4iLN6zjqjKcZX7/OOEO7T9geI
	 lNcnFA2XfT/uw==
From: Luke Howard <lukeh@padl.com>
Date: Sun, 19 Jul 2026 15:30:54 +1000
Subject: [PATCH net-next v3 2/3] net: dsa: mv88e6xxx: embedded PTP
 timestamp support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-mv88e6xxx-ptp-fixes-v3-2-161386ac8a62@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784439056; l=9946;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=VQJDRxAA6T5afKbHAOHhm/scPrBhzoEHJ1AKnjYlzc4=;
 b=Y1o3aPqcH8lcJp56V11p7coaL8P+/BBy88k2HbriLbhU1RqCxrsQ3Ls37WHx8j6M/6WwWLn1m
 Go6ASDrG6MSArmIFAlVys2lrQrFwp/j3BlXNE5ErFXrWwq8LqzXV5ao
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

mv88e6xxx switches can support embedding PTP timestamps directly
in the frame, either as a trailer or at a configurable offset
(typically the reserved bytes in the PTP header).

Add support for this on the 88E6341 and 88E6352 switches, being
those on which I was able to verify this. Other switch chips may
also work. The arrival timestamp offsets are relative to the PTP
common header and will work for both L2 and L3 PTP packets; the
respective headers are skipped by the number of bytes set in the
ETJump and IPJump registers, which are initialized to sensible
defaults and are VLAN tag-aware.

(Note: the 6352 datasheet incorrectly states that ETJump and
IPJump are initialized to zero. They are initialized to 12 and
2 respectively; this is corrected in the 6341 data sheet.)

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c     |   3 +
 drivers/net/dsa/mv88e6xxx/chip.h     |   8 +++
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 131 +++++++++++++++++++++++++++++++----
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |  14 ++++
 4 files changed, 144 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..c3277c1f3d785 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -28,6 +28,7 @@
 #include <linux/of_mdio.h>
 #include <linux/platform_data/mv88e6xxx.h>
 #include <linux/property.h>
+#include <linux/ptp_classify.h>
 #include <linux/netdevice.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phylink.h>
@@ -6370,6 +6371,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.ops = &mv88e6341_ops,
+		.arr_ts_mode = offsetof(struct ptp_header, reserved2),
 	},
 
 	[MV88E6350] = {
@@ -6447,6 +6449,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.ops = &mv88e6352_ops,
+		.arr_ts_mode = offsetof(struct ptp_header, reserved2),
 	},
 	[MV88E6361] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6361,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index e966e7c4cc5de..b6a90eba81c43 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -180,6 +180,14 @@ struct mv88e6xxx_info {
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
 	unsigned int internal_phys_offset;
+
+	/* Arrival Time Stamp Mode (ArrTSMode); see the ArrTSMode encoding in
+	 * hwtstamp.h. Zero (the default) leaves arrival time stamps in the
+	 * switch registers; non-zero embeds them in the frame, either appended
+	 * as a trailer or overwritten at that byte offset past the start of the
+	 * PTP common header.
+	 */
+	unsigned int arr_ts_mode;
 };
 
 struct mv88e6xxx_atu_entry {
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 57ff77496864f..fa5e897182ca2 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -15,6 +15,7 @@
 #include "hwtstamp.h"
 #include "ptp.h"
 #include <linux/ptp_classify.h>
+#include <linux/unaligned.h>
 
 #define SKB_PTP_TYPE(__skb) (*(unsigned int *)((__skb)->cb))
 
@@ -245,6 +246,74 @@ static int seq_match(struct sk_buff *skb, u16 ts_seqid)
 	return ts_seqid == ntohs(hdr->sequence_id);
 }
 
+static bool parse_embedded_ts(unsigned int arr_ts_mode,
+			      struct sk_buff *skb, u64 *ns)
+{
+	struct ptp_header *hdr;
+
+	*ns = 0;
+
+	/* APPEND means the switch appended the time stamp as a 4-byte trailer
+	 * (not all switches support this). Any other non-zero value is the byte
+	 * offset past the start of the PTP common header at which the switch
+	 * overwrote the time stamp in place (e.g. the reserved header bytes).
+	 */
+	if (arr_ts_mode == MV88E6XXX_PTP_ARR_TS_MODE_APPEND && skb->len >= 4) {
+		if (skb_linearize(skb))
+			return false;
+
+		*ns = (u64)get_unaligned_be32(skb_tail_pointer(skb) - 4);
+		if (pskb_trim_rcsum(skb, skb->len - 4))
+			return false;
+	} else if (arr_ts_mode + 4 <= sizeof(*hdr)) {
+		if (skb_linearize(skb))
+			return false;
+
+		hdr = ptp_parse_header(skb, SKB_PTP_TYPE(skb));
+		if (!hdr)
+			return false;
+
+		*ns = (u64)get_unaligned_be32((u8 *)hdr + arr_ts_mode);
+		memset((u8 *)hdr + arr_ts_mode, 0, 4);
+		skb_checksum_complete_unset(skb);
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
+static void mv88e6xxx_get_rxts_embedded(struct mv88e6xxx_chip *chip,
+					struct mv88e6xxx_port_hwtstamp *ps,
+					struct sk_buff *skb)
+{
+	struct sk_buff_head *rxq = &ps->rx_queue;
+	struct skb_shared_hwtstamps *shwt;
+	struct sk_buff_head received;
+	unsigned long flags;
+	u64 ns;
+
+	__skb_queue_head_init(&received);
+	__skb_queue_head(&received, skb);
+	spin_lock_irqsave(&rxq->lock, flags);
+	skb_queue_splice_tail_init(rxq, &received);
+	spin_unlock_irqrestore(&rxq->lock, flags);
+
+	mv88e6xxx_reg_lock(chip);
+	skb_queue_walk(&received, skb) {
+		if (!parse_embedded_ts(chip->info->arr_ts_mode, skb, &ns))
+			continue;
+		ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
+		shwt = skb_hwtstamps(skb);
+		memset(shwt, 0, sizeof(*shwt));
+		shwt->hwtstamp = ns_to_ktime(ns);
+	}
+	mv88e6xxx_reg_unlock(chip);
+
+	while ((skb = __skb_dequeue(&received)))
+		netif_rx(skb);
+}
+
 static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 			       struct mv88e6xxx_port_hwtstamp *ps,
 			       struct sk_buff *skb, u16 reg,
@@ -307,8 +376,21 @@ static void mv88e6xxx_rxtstamp_work(struct mv88e6xxx_chip *chip,
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
 	struct sk_buff *skb;
 
-	skb = skb_dequeue(&ps->rx_queue);
+	if (chip->info->arr_ts_mode) {
+		/* If arr_ts_mode is set, the timestamps are embedded in the
+		 * frames so a register read is not required. We still need a
+		 * work queue rather than processing inline because
+		 * timecounter_cyc2time() takes the global mutex and this
+		 * cannot be called from mv88e6xxx_port_rxtstamp().
+		 */
+		skb = skb_dequeue(&ps->rx_queue);
+		if (skb)
+			mv88e6xxx_get_rxts_embedded(chip, ps, skb);
 
+		return;
+	}
+
+	skb = skb_dequeue(&ps->rx_queue);
 	if (skb)
 		mv88e6xxx_get_rxts(chip, ps, skb, ptp_ops->arr0_sts_reg,
 				   &ps->rx_queue);
@@ -350,7 +432,7 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 
 	SKB_PTP_TYPE(skb) = type;
 
-	if (is_pdelay_msg(hdr))
+	if (!chip->info->arr_ts_mode && is_pdelay_msg(hdr))
 		skb_queue_tail(&ps->rx_queue2, skb);
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
@@ -530,14 +612,37 @@ int mv88e6165_global_enable(struct mv88e6xxx_chip *chip)
 
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
 }
 
 int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port)
 {
-	return mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
-					MV88E6XXX_PORT_PTP_CFG0_DISABLE_TSPEC_MATCH);
+	int err;
+
+	if (chip->info->arr_ts_mode) {
+		err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG2,
+					       chip->info->arr_ts_mode << 8);
+		if (err)
+			return err;
+	}
+
+	err = mv88e6xxx_port_ptp_write(chip, port, MV88E6XXX_PORT_PTP_CFG0,
+				       MV88E6XXX_PORT_PTP_CFG0_DISABLE_TSPEC_MATCH);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int mv88e6xxx_hwtstamp_port_setup(struct mv88e6xxx_chip *chip, int port)
@@ -591,12 +696,14 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	/* Use ARRIVAL1 for peer delay messages. */
-	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
-				  MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ |
-				  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
-	if (err)
-		return err;
+	if (!chip->info->arr_ts_mode) {
+		/* Use ARRIVAL1 for peer delay messages. */
+		err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
+					  MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ |
+					  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
+		if (err)
+			return err;
+	}
 
 	/* 88E6341 devices default to timestamping at the PHY, but this has
 	 * a hardware issue that results in unreliable timestamps. Force
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index c359821d5a6ea..c25f53923e768 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -68,6 +68,20 @@
 #define MV88E6XXX_PORT_PTP_CFG2_DEP_IRQ_EN		0x0002
 #define MV88E6XXX_PORT_PTP_CFG2_ARR_IRQ_EN		0x0001
 
+/* Arrival Time Stamp Mode (ArrTSMode), CFG2 bits [15:8]: configures how the
+ * switch embeds the arrival time stamp (PTPArr0Time) into enabled PTP event
+ * frames.
+ *   0x00        frame modification disabled (time stamp read from registers)
+ *   0x01        append the 4-byte time stamp at the end of the frame,
+ *               growing the frame by four bytes
+ *   0x04..0xEF  overwrite the 4-byte time stamp in place, that many bytes past
+ *               the start of the PTP common header, without growing the frame
+ *               (offsetof(struct ptp_header, reserved2) targets the reserved
+ *               bytes of the header)
+ *   others      reserved
+ */
+#define MV88E6XXX_PTP_ARR_TS_MODE_APPEND		0x01
+
 /* Offset 0x03: PTP LED Configuration */
 #define MV88E6XXX_PORT_PTP_LED_CFG	0x03
 

-- 
2.43.0

