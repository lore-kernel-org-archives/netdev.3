Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397368;
	b=2Hs16giE2vbwx3hPAmIzkfaptBlzCB46Yy62Y/KQhxk3hYP8y+AHrWnJv+CXRB2CqOso
	 QzkYbgBc+syxZjXb9OBx4hNm6wtEKq1GjLVvpXuLpLczqjNx8O2LuPoCV3hwsOzBeliSh
	 IjjqSGCarlpfcMnLKLj+y1pdXi6MpaLwR6qXb860eXNyGqNQqZbToSq+QJHwCQR23fQdn
	 7iYFnveSP36i7NdeFhcaz1HUHKJ6wNvoJoaYbmC8/kOa7lXe5eiN6Q7KpRuyJlxmOILUd
	 5h224WmXpcNgVe94tL38kLom5K/gEuGPqRSlefo8luOwz/owOdVKrYD6kBfBEYPJ9SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UYIWoFisBkbrng3LjjKl6CMStSYrercs1Yl20n+415c=;
	b=sp6pyfS/RwIND9DDRDvMwu8RwDccK9W7BziuWVn52pE4HNLIYwD3dW/2f/MzXN/ITqhe
	 NTjt1foCCEnuNJaDEDgSaF+hU6K4Pq/hpP9QzsbrT1WDSGnSkCKmj84aBraidcmSs5qPB
	 I9E/5rsMAR/Z+HOMSlm92DkTvjoWpSX5hWISxoV6U6xrEIlGyLvrPec0qACVlwG+QdOZU
	 6TUvt3W9Ys7Hcs1fLEC+vtNlJiLr4lAYLUn0Koc2Hvp03eVFYuKjUQN3IRSah+tUwEBqX
	 zcmGSi/3ghwXVayY8ME3fOUll0WEftxaJdsXLIdWM6KhvV5QU/0s9ILnpUqyOg1LBJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+n4J7SV;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077DF606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 077DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+n4J7SV
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e4831c028so1127754f8f.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793397366; x=1794002166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UYIWoFisBkbrng3LjjKl6CMStSYrercs1Yl20n+415c=;
        b=i+n4J7SVG8s2IQ4kc/IbKRTLorroVxdRKxLGx/C/Rjp3d18X7p/TRbFPKMWAj4JFCQ
         NKmd3yDi+K85cFu3jk1SpusGdhgYmU4kjx9WSkmnQb8iNuss9uuVTkEOr5rf4Gq6E41D
         NViFA0J8FGqyurQVJQo0gOJkgft8TVZiR9J732IHJ+OhS/D8nIZ9nkEiHk1KD3DOcaFG
         W9vylzYvBzITpaF2eJhKF6HGA5n6u3gI2di/ohMVOJYHCVx3v8yjSB5szMoAYbpheFP7
         sDUsNarUP6BDyRSHud5ju1RL1eQm8OeTDMdqpla63yEg3QFvKZbSltkxfF4JcSwgxjWh
         HNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793397366; x=1794002166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYIWoFisBkbrng3LjjKl6CMStSYrercs1Yl20n+415c=;
        b=ab/bUWBp6PoY76JfGFQHT2v/w2dKOnmi1C0CwxMiHf+XKsP2O0eXCOCMdc3mNwzp+d
         WlN7lpA2PTBIlfNZbRS4dI318R50bZKT13RIrwD59GsaDdVnzj6l5q70mjufQMvxHech
         5fV6Azzr2NyTD69NJtL2b+hcm9jjI7MHFyJdDXLnZTnFECqfiOH5STRySlCsBYrjU0jm
         +DRG5P03t5yOuzrMT4OpPmkfPC7xC31p6BvDxJ7HT7HjMt0eJrrghkWUq4H7F5c9dYGL
         DmVNGFz1Bm8q33AmwnwzXcd4gq1E2ID1nEp0tkZYLSrSpgbYuEPBsp9sLKLSqQYoBf8i
         0Kbg==
X-Forwarded-Encrypted: i=1; AKwUvByrbVhq+FHBoBXkNPvb1Xve8DTs/9ExirvEZLXMJDEXquuAHDwEiRNDK2nYrMUs01Zwo56TgDQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbV6PMPtbMdlu70LlCAKDnIRFZq/mUOxLU3VM5h/ICo/4Rv5E1
	cAyaF32CWEES5MHq9Va6+b6zV8YT8utpB+XCNAKxtTRArKgjnRmfkN6f
X-Gm-Gg: AYBFou1eQWh27zrE4vR/rgU8HHFtpyl0/NWsS7WrnJgbVVWVlKolNO6S/nTJupgJj01
	KldkvGbCWK8wF8tTl3vD/UX8i51UzVOd2ttI0PMV7JlOuumq0YmKnRfTev6Mpg1J8L431sYaitA
	vf8yJDQhdx5D9p0yyrRKOiKgn/7nmv42o54Zao491O7ETljcNJ2AKhh+edJCWBRJ/SV8VyxHmWD
	aauvLQ8FErnfNTexOFwZJ4PKAKYxAvNiYTXmxuP6hFvjOFSE1YTcTG7LO0N/jHTt6z5zzSautzF
	ZUcMQaU7rsL2IRwTk5287GSvqUj6/+z9WYkJyp9Sum809XkVwu8n5hTUfm359Mxqm1FxfI0gEmZ
	+y8T1juzPd0siPYPKZ3HIMfuo2QAXuBdqef9jPzd5uh2DWZrgbE6nmejDNnm7x8DIjhW+jbKefi
	3rxApSearrJrg08VT0p/Y5KWUDktU4/yaxNZ2S28PIw/MW+X5fTAurBH8c0+pajTcmobh/X1bul
	gAfPDuW0QZZhlXmLZo1rPPaYLypQKCTtslRJbJj7I8RmOrdRDbz650QrNYZ3WCGZy8uesg0nFB1
	2BkgnJ0CoWNrsJEFSA0lBCPOxr0DUZEp/ikoSCEtYEXjMnhWFe8NiKl6Ohuw/UOzPv0=
X-Received: by 2002:a05:6000:4b08:b0:48e:7508:bc20 with SMTP id ffacd0b85a97d-48e7508be83mr3908335f8f.2.1793397366091;
        Fri, 30 Oct 2026 14:56:06 -0700 (PDT)
Received: from linux-virtualbox ([176.123.24.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78f95sm4776325f8f.28.2026.10.30.14.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:56:05 -0700 (PDT)
From: Salah Ahmed <haddad2inc@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: qca8k: expose cached per-port MIB counters via get_stats64
Date: Sat, 31 Oct 2026 00:55:47 +0300
Message-ID: <20261030215547.17497-1-haddad2inc@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSA user port netdev statistics count only CPU-seen traffic, so bridge
offloaded forwarding is invisible to /sys/class/net/<port>/statistics, to
rtnetlink IFLA_STATS and to every kernel consumer of them, including the
netdev LED trigger. The switch MIB counters see every frame crossing the
port, but reading them costs a register transaction per counter on a bus
that is either MDIO or MDIO-over-Ethernet, while consumers such as the LED
trigger call dev_get_stats() several times per second.

Use the pattern that is already established for switch drivers: ar9331 in
this same directory caches a rtnl_link_stats64 behind a spinlock, refreshes
it from a delayed work and serves it from .get_stats64, and ksz does the
same. Poll RxGoodByte/TxByte per user port and serve the cached values.

The poll is adaptive rather than fixed. A consumer that derives a rate
from these counters only sees the wire when the cache moves, so a fixed
period sets the latency of every rate-based consumer to that period.
Refresh four times a second while the counters move and once a second
while they are idle: an idle switch stays cheap, and a busy one is
reported within a quarter of a second. The work also runs once as soon as
it is armed, so the first consumer after a link comes up does not read
zeros for a whole period.

The work is scheduled with schedule_delayed_work(), i.e. on system_wq like
ar9331 does, and not on system_power_efficient_wq. With
CONFIG_WQ_POWER_EFFICIENT_DEFAULT the power-efficient workqueue arms
deferrable timers, which do not wake an idle CPU; on a single-core switch
SoC that is mostly idle this deferred a nominal 3 s poll by several more
seconds, and consumers saw the wire that late.

DSA serves a user port either from the driver's .get_stats64 or from
dev_get_tstats64(), never from both, so the cache has to be layered on top
of the software counters: start from dev_get_tstats64() and override only
the byte counters with the wire values. Otherwise installing .get_stats64
would drop rx_packets/tx_packets to zero and break every consumer that
looks at packets, including the netdev LED trigger in tx/rx mode. The MIB
counts every frame crossing the port including the CPU-bound ones, so the
wire byte counters are a superset of the software ones and replacing them
loses nothing.

Each 64-bit counter is read with a single regmap_bulk_read() so that no
other register access can land between the low and the high half of the
same counter.

The cache fields sit at the top of struct qca8k_priv to stay clear of
target-specific patches that extend its tail, such as the ipq40xx IPQ4019
built-in switch support. The poll work is armed at the end of
qca8k_setup(): a failing setup never reaches the remove callback, so
arming it earlier would leave the delayed work running after the driver is
gone.

The poll work is armed at the end of qca8k_setup() and stopped from a new
.teardown op. DSA calls .teardown both on the dsa_switch_setup() error
paths that follow a successful ops->setup() - the tag protocol setup and
the user MDIO bus allocation and registration - and from
dsa_unregister_switch(), so the work cannot outlive the driver data it
reads. Stopping it in qca8k_sw_remove() alone misses the probe error
path: dsa_register_switch() fails, probe fails, devm frees priv and the
armed work then runs on freed memory.

Signed-off-by: Salah Ahmed <haddad2inc@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   |  17 +++++
 drivers/net/dsa/qca/qca8k-common.c | 110 +++++++++++++++++++++++++++++
 drivers/net/dsa/qca/qca8k.h        |  15 ++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 07227ae8bc..08f3ef00e6 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -2020,6 +2020,14 @@ qca8k_setup(struct dsa_switch *ds)
 	/* Set max number of LAGs supported */
 	ds->num_lag_ids = QCA8K_NUM_LAGS;
 
+	/* Arm the MIB poll work only after every failure path in this
+	 * function is behind us. DSA calls .teardown both on the
+	 * dsa_switch_setup() error paths that follow a successful
+	 * ops->setup() and from dsa_unregister_switch(), so the work is
+	 * always stopped again.
+	 */
+	qca8k_mib_poll_start(priv);
+
 	return 0;
 }
 
@@ -2030,11 +2038,20 @@ static const struct phylink_mac_ops qca8k_phylink_mac_ops = {
 	.mac_link_up	= qca8k_phylink_mac_link_up,
 };
 
+static void qca8k_teardown(struct dsa_switch *ds)
+{
+	struct qca8k_priv *priv = ds->priv;
+
+	qca8k_mib_poll_stop(priv);
+}
+
 static const struct dsa_switch_ops qca8k_switch_ops = {
 	.get_tag_protocol	= qca8k_get_tag_protocol,
 	.setup			= qca8k_setup,
+	.teardown		= qca8k_teardown,
 	.get_strings		= qca8k_get_strings,
 	.get_ethtool_stats	= qca8k_get_ethtool_stats,
+	.get_stats64		= qca8k_get_stats64,
 	.get_sset_count		= qca8k_get_sset_count,
 	.set_ageing_time	= qca8k_set_ageing_time,
 	.support_eee		= dsa_supports_eee,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index ab978cc836..7c446f507f 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -520,6 +520,116 @@ void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 	}
 }
 
+/* Two cadences, picked per round by the work itself: while the wire counters
+ * move the cache is refreshed four times a second so that a rate consumer
+ * sees the traffic almost immediately, and once a second while they are
+ * idle, which keeps the MDIO cost of an idle switch low.
+ *
+ * schedule_delayed_work() (system_wq) is used deliberately instead of a
+ * power-efficient workqueue: with CONFIG_WQ_POWER_EFFICIENT_DEFAULT the
+ * latter arms deferrable timers that do not wake an idle CPU, which on a
+ * single-core switch SoC delayed a 3 s poll by several more seconds and
+ * made consumers see the wire late. ar9331 schedules its equivalent MIB
+ * work the same way.
+ */
+#define QCA8K_MIB_POLL_IDLE	HZ
+#define QCA8K_MIB_POLL_ACTIVE	(HZ / 4)
+
+/* RxGoodByte / TxByte offsets in the per-port MIB block, both 64-bit wide */
+#define QCA8K_MIB_RXGOODBYTE	0x3c
+#define QCA8K_MIB_TXBYTE	0x84
+
+/* Read one 64-bit MIB counter in a single regmap transaction, so that no
+ * other register access can land between the low and the high half.
+ */
+static int qca8k_mib_read_wire(struct qca8k_priv *priv, int port, u32 off,
+			       u64 *val)
+{
+	u32 raw[2];
+	int ret;
+
+	ret = regmap_bulk_read(priv->regmap, QCA8K_PORT_MIB_COUNTER(port) + off,
+			       raw, ARRAY_SIZE(raw));
+	if (ret)
+		return ret;
+
+	*val = raw[0] | ((u64)raw[1] << 32);
+
+	return 0;
+}
+
+static void qca8k_mib_poll_work_fn(struct work_struct *work)
+{
+	struct qca8k_priv *priv = container_of(work, struct qca8k_priv,
+					       mib_poll_work.work);
+	struct dsa_switch *ds = priv->ds;
+	bool busy = false;
+	u64 rx, tx;
+	int port;
+
+	for (port = 0; port < QCA8K_NUM_PORTS; port++) {
+		if (!dsa_is_user_port(ds, port))
+			continue;
+		if (qca8k_mib_read_wire(priv, port, QCA8K_MIB_RXGOODBYTE, &rx))
+			continue;
+		if (qca8k_mib_read_wire(priv, port, QCA8K_MIB_TXBYTE, &tx))
+			continue;
+
+		spin_lock_bh(&priv->stats_lock);
+		if (priv->port_stats[port].rx_bytes != rx ||
+		    priv->port_stats[port].tx_bytes != tx)
+			busy = true;
+		priv->port_stats[port].rx_bytes = rx;
+		priv->port_stats[port].tx_bytes = tx;
+		spin_unlock_bh(&priv->stats_lock);
+	}
+
+	schedule_delayed_work(&priv->mib_poll_work,
+			      busy ? QCA8K_MIB_POLL_ACTIVE : QCA8K_MIB_POLL_IDLE);
+}
+
+/* Serve the wire counters on top of the software ones. May be called in
+ * atomic context, so only the cache is touched here. The MIB sees every
+ * frame crossing the port, including bridge-offloaded traffic that never
+ * reaches the CPU, so DSA user ports finally report the truth on the wire
+ * to every standard kernel consumer, without ethtool or userspace helpers.
+ *
+ * DSA calls either .get_stats64 or dev_get_tstats64(), never both, so the
+ * packet and error counters collected by the DSA xmit/receive paths have to
+ * be picked up here as well or they would be lost.
+ */
+void qca8k_get_stats64(struct dsa_switch *ds, int port,
+		       struct rtnl_link_stats64 *s)
+{
+	struct qca8k_priv *priv = ds->priv;
+	struct rtnl_link_stats64 wire;
+
+	dev_get_tstats64(dsa_to_port(ds, port)->user, s);
+
+	spin_lock_bh(&priv->stats_lock);
+	wire = priv->port_stats[port];
+	spin_unlock_bh(&priv->stats_lock);
+
+	s->rx_bytes = wire.rx_bytes;
+	s->tx_bytes = wire.tx_bytes;
+}
+
+void qca8k_mib_poll_start(struct qca8k_priv *priv)
+{
+	spin_lock_init(&priv->stats_lock);
+	INIT_DELAYED_WORK(&priv->mib_poll_work, qca8k_mib_poll_work_fn);
+
+	/* Read once right away: without it the first consumer after a link
+	 * comes up sees zeros for a whole poll period.
+	 */
+	schedule_delayed_work(&priv->mib_poll_work, 0);
+}
+
+void qca8k_mib_poll_stop(struct qca8k_priv *priv)
+{
+	cancel_delayed_work_sync(&priv->mib_poll_work);
+}
+
 int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset)
 {
 	struct qca8k_priv *priv = ds->priv;
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 9563388930..edab7e1218 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -443,6 +443,15 @@ struct qca8k_led {
 };
 
 struct qca8k_priv {
+	/* Cached per-port wire statistics from the switch MIB, refreshed by
+	 * mib_poll_work so that .get_stats64 (atomic context) never sleeps.
+	 * Placed at the top of the struct to stay clear of target-specific
+	 * patches that extend its tail (e.g. ipq40xx IPQ4019 support).
+	 */
+	struct rtnl_link_stats64 port_stats[QCA8K_NUM_PORTS];
+	spinlock_t stats_lock; /* guards port_stats[] */
+	struct delayed_work mib_poll_work;
+
 	u8 switch_id;
 	u8 switch_revision;
 	u8 mirror_rx;
@@ -513,6 +522,12 @@ int qca8k_rmw(struct qca8k_priv *priv, u32 reg, u32 mask, u32 write_val);
 /* Common ops function */
 void qca8k_fdb_flush(struct qca8k_priv *priv);
 
+/* Cached MIB statistics served from atomic context */
+void qca8k_get_stats64(struct dsa_switch *ds, int port,
+		       struct rtnl_link_stats64 *s);
+void qca8k_mib_poll_start(struct qca8k_priv *priv);
+void qca8k_mib_poll_stop(struct qca8k_priv *priv);
+
 /* Common ethtool stats function */
 void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset, uint8_t *data);
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
-- 
2.53.0

