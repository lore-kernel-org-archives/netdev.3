Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397566;
	b=q/UHoDSx+O6lDCKHhLy3yViFV5LwF8BjZxcWpG863Wc9gi8LB5d0EKT4kzib+YDxFN6E
	 pl6E5rK/tEoLibvHZ4mlviGebENWZBWSCddinulPEompzn5ybJDQgG7hRCy1wQwO8yECd
	 viFQxkSz+Eb5xfFsObBuOJbPk4E7seNQe5moVMbKlpRMKx/wgib5ESGp33mwikfKBWAr2
	 8/p94IJHNpHAvVKigyDrqP6LVPNhgS8Q1KKxMQCSVy65nKJxAr9+U1hc/Qi9W9UYTCMju
	 8R9LNz/h24W2bc/FRXzhewJTY7kkRMRCfgUuLe6uhLkHgVkI4M18llhya1YM7ccmnxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UYIWoFisBkbrng3LjjKl6CMStSYrercs1Yl20n+415c=;
	b=1UEodlHK0wzmLoROhVvT0U0y3jOLTU3ILvZnPz0n/OWQ+KjSyiYNSp9rrkHOd5iRZSMx
	 mcNtyPzdB1rCiTE56e0x/ybPD5r31/JhrxXgNh3k1wvOcbaNBxJvZrNqxXM129FgnYzyb
	 pSQRKRF2cbQ4FDq5PIYbki+iHB7b4xgh83ckDJsKC2xLLTZOp1WcHhLnCE/bFUJwnrlvW
	 ooNYPqBsR0y+/loyer1L45p9WW/0k3VfECbwlsoCrqqfLS+16OJwoBS1+q3RyGZXYdnHq
	 Sp5EVhNLQ0Tq+8+Kg+K7/x0V0gDbcu9wkilFaH4NxjX/5GeTmgJ6Z4Xau4rspqoEq6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L295eTdS;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4393606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4393606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L295eTdS
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so12452455e9.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793397564; x=1794002364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UYIWoFisBkbrng3LjjKl6CMStSYrercs1Yl20n+415c=;
        b=L295eTdSoN7ErpWdwDYHwSLcNa07vb0WiKNjdwJCIHe/eU8RUDRsAHr0GD/Jrou3CU
         2h2SNxiFU5VF35r/1Muk0rKMnA0bda/XcEV68gFo87iRe+xbR4BNRByBT7CAqVlRpAh+
         5NCX4w6KxZTImwB9FrSmLepyYCJWDBdJ60cSoiazfN65FjR12fA91kWBt6RYuxHsLN5N
         qub+EyLFUFu+5kJW30KX9mLrsPVBuEhHkPQEO8+zZtjgjLdpisWPY9PNfVFIwJqWgToB
         kIFSzGQt3PMVY5QiU7xabtYi0OI7+x70gRL5alleyE8VFueTJ0O26iVU4z3w9a/+7ldw
         iTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793397564; x=1794002364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYIWoFisBkbrng3LjjKl6CMStSYrercs1Yl20n+415c=;
        b=1ge4Nf+ycUHKK50FGCaW7H6Wv42RtSj6pvnetl9bpqklGLmSZKFurYwKppKFLZqYWA
         wIkSAfsNe052aK1U8v7MMsvAgKvDjY5tERL+9sZIulIu3Ze3Aq9StmbPmYDs6nH+C7yC
         Duz7fVAJSD0dFggeZHmctnxxmH6AYQax5KufIWuNzxLjU8xytukNWSHgmFRcgXSuvD2T
         ZmJoqnfSe+qjIlGRAx9leHtBDTzp+GfM8SvQ9skKyulJZTN/Bk16zfsiE5ooy3oHSTFr
         V6txKl548S5xZNM0cCBJSza35bYQZCQf6wKK1Vkjgh+8wPQ4LnR2d/qTm0jNVXR4lvBI
         Jmig==
X-Forwarded-Encrypted: i=1; AKwUvBzNPpusoMmkl9ll+ng3favmai2fBZH0dCtfaGoIpbah2elvo1LLpbXfcaYrsEeTOULL4KcZCA4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsrlD2WKxcnN7K+FKx76enelArxZun2U/U8fIp5JYOz6zA3B4D
	wB6JZW/Jn+D2coVygccFIaEDu6/IYZnFNFRYPK4w21zACO6b7b09Lvft
X-Gm-Gg: AYBFou1vaDhlaeQRA+abBGlg2BGJMJ9iJCxKLSGgBxSoNl0GsrM4y1KYslmGe5op02H
	ZUYQNwfmAGsk5lXgb2JmEez39BILfuUPGSH796wKPpNobxUppyI7fmD026QIxnpuqq55IB7wEZJ
	NdtTViFXdcPblrdPafC3+p40cjupFEzkz92LCkuqdUPR0/+jVZEdLt14yuSoolMehdMsAhDn/HH
	PelmjeluupOlrrAGFaJ02I2D0PgF75FbDvOdVFfSsSNAmEHrXvbLoor6gxCOz1eV8xQ3VNRgmu0
	BcDLPEyedILXRZQZl06pmbQQhp6w99ZjceMY08+4POB1WDgBuVGLyUv+1S1YZHi5eHNDs//RrRL
	XFnCU7aaKFrrujRatwL/LpTlVCVCfW+TPmawCgHVCoEaTexn0JTWOuGel3jKsJoMDJXqMv11jSv
	WM7W/+Gwni+VNqIZmT7uaCUo9XqEfHc/bfAiw+j/1h3MTLIr4BKbh4jH+y5YdFahh4tPJbHSrB0
	NmfiTuQBjuNErztUcEZhWgrj0sOVSk42KCrcpxz8lvBUdfkQNZj+V4v3OBKAxSj0KBO/tBiM201
	jAfSi58Oob43tSV3socy15lMxlNuJzDVGr+jEwj4eVtLWg==
X-Received: by 2002:a05:600c:8119:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4ac17a36a28mr69980545e9.9.1793397563837;
        Fri, 30 Oct 2026 14:59:23 -0700 (PDT)
Received: from linux-virtualbox ([176.123.20.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80306sm5776764f8f.33.2026.10.30.14.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:59:23 -0700 (PDT)
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
Date: Sat, 31 Oct 2026 00:58:31 +0300
Message-ID: <20261030215831.17997-1-haddad2inc@gmail.com>
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

