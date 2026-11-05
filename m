Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857748;
	b=EtziweOHlHac2F5k5D2xQhZtBqZrI+OgUhcThABJvvukfZB6aC5l1xV3ug8uIxEmI1tb
	 AirGAbE/p9TDMw+rFAD89iYlyUw7xl+iXQEVsjSVRBnAFpxp9IUaWN1lNtKJLZvPjBJEy
	 eHU8gVdALWZwi6kyRDQNuQnw8RgSJBvKOC9cPGYcbpcrPNiXbP6DQ1bV8kmPzA8/4v0D9
	 mDPtYj2DQ2hE6xc7OuWg4txaB+N+WjblxkaND9fEhHtp4HwwbyNDuEjR5se2fETBLbiaz
	 q6D9v6dHiaPhc3RUguL+hFqNKNLk6OORehYHnWgxGMOnbq0edNsFcu3LRgLqgb7ROiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u13IrmWwXxrAgactaGqEPzlJ7tuYhNiK6asqTlzHPw4=;
	b=n0wNZB07tki0MlzPjULbH1OGGz2QNye+DlLse+uGsJFuXY0KRJ7lwopHgzGhAzY5eA2U
	 eDd99h5nWvCqI/58XeijH2s0a8DBfesKVCIJT1cUaQUALU87qccCU2l6JBZ/d3Q6DYt7r
	 tBbpF2eISnFH470JkDCB7D3walVQkjx3v9ItRtuDZl0LFB30FL98E/MubTz8nmCdZ3zlm
	 zigMKrqo0tXZwRNV4cqnp4JLGURuKDfYNRq+7y1rHTCJAd+AtEamniKfsJ69YDwWB0EQ5
	 DAcDFmgfHrSGGXNxk2BGgXG3Jpj9Rv49WpabHnLOLzoFnUKcG20Mc7NxSguoMMVjgEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lDkhT6Mc;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD1606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94BD1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lDkhT6Mc
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso703346a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793857747; x=1794462547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u13IrmWwXxrAgactaGqEPzlJ7tuYhNiK6asqTlzHPw4=;
        b=lDkhT6McF29lUM9v96LCZ9iSwp8T3PnURepBNs/Waesw63BIrAk7A/U7ji3t0YPMr6
         +VjHxwhLJ4QF/hfk1cQSLGggc1a+LOXKyUNoQXPGdFf5D1RuzZIbYh8XkfJdUQIRA4cW
         J+Hz8w4RnRmFLggxRP7wqq4FKnGKr5XtuBVebSqz4aGw3NxTuvvJq1FOvGm1Y40tcfF/
         c9g7H/YsnYIfqSyn2oHUvBnOrbG39NlWUSne/R+ICzIG9rkdsgA9vt65s7or1QYCgr+D
         IJk6rjLR8WafUHXbc0cSGfAlpi5jErgeQ+98xNZDOdFZl07gOSR3WvGlmBdLV5rzx0mZ
         7yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793857747; x=1794462547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u13IrmWwXxrAgactaGqEPzlJ7tuYhNiK6asqTlzHPw4=;
        b=DvqObenZS1xkCgwqDMEFspOG1Z+aPB0+SPRLqSN9pjXZGQrTmCj4zlwd/4oFLVQTcs
         tKO8m6AEFFJ/rufrdj4D49xKxsJcbqpGjRbZ8sIHBkY7Fwm+mXntx0KDJQBi8uMlZ+zA
         Qm5RjURKvKlynO7dXQ2O9ECxsHvf10GODGW4KHGmTlSsWg8fepNiauUCDsyptUUDacyH
         FzX6Qb8BZrKG8BR8dFifiO6cQC8aiO0BhloBX+aTFIySu52hqHbSd57CVpEMgEu9kQb3
         NEShN3cjpcXZ/43hoV6A3pssvCHo2KSrOyZE6JxOWqN9gEfIJiDfrdwDG86g+55nSher
         MQuw==
X-Forwarded-Encrypted: i=1; AKwUvBxzjdOJshXbfGDJbFILxxBjkJzUeIEtwqgeLUbGHc8LfIvIhud4hTU1daZtVmrYeOInW0epGzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QuaJVK7cK9z6lxE3jBWVEpZTXKWdiJek0xLEtzcr2xXjXKh24
	nMRTDPjta1XfSE3G9ArXCLubHgySwKmXSY9JstIXasZ+rYIG4/1uJZPL0wY38K8gxA==
X-Gm-Gg: AYBFou0h0gdJwIS2b2EmFwvKGQlz1LjsX1yrSZOqRHWe+HSQRHE/kGHUGid6lRKOj75
	CCLFq9p+aAzi35JXgJlVuDEDxAr2bIMng+EUN8BALrasDpJPLxczShBbrouBnxmBjviRz8KiQq8
	w8SUaDc080lxyalGpaaIIfrPONquUmJaWZCbJvnyPQxj3QBNfTIJKFU/Q1zs6tdVWxEW3mF05Nb
	jUXIiqTfO01z+bN0DBVs9/8wruKEhYPq3+qgrAS4kmRstK5D+6ie1Dex316xkbXtIK2/MZTefUj
	KXmauabtkMDH3dvuEmGgCPTU2sA9R0jSOv3azfw2Fttc0L6oD8guHWYmp48Sj/14N/WhLup3Oj9
	6ZYTtg/n7qjYLswpKI0BigWWeODhJ2xng1sF3eO3W3qE6rz/kjmDpWuqglU3YPcgFTGJjDhKiG2
	HUq6rS14fhBhci+DdgJmuRCOoTW1COmE/xd6DQIie8jv5XSdHp2tYsjK+oKNAZ0ii0PMPHbCk2b
	BZGs/siKvp00Ll154AKTSOm+0UZYQXmqZAPuYBgY+3AsU94B7X2D0escqR+FSsSlficqmQe19AU
	saW72ARoCWW2vDn43hClB6AqV3rYxHZyjAPTBUnEllEhIUnBEaDQutsHfQ77vAc8AVFWL3njfuk
	y/VvgdZP6RFhqjqUlaQ==
X-Received: by 2002:a17:90b:33c1:b0:3ad:b8c8:4a84 with SMTP id 98e67ed59e1d1-3ae89745e20mr15367037a91.26.1793857746942;
        Wed, 04 Nov 2026 21:49:06 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b319f2c9sm1989676a91.10.2026.11.04.21.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:49:06 -0800 (PST)
From: James Clark <jjc@jclark.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Hubert Feurstein <h.feurstein@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/6] net: mdio: add timestamped write operation
Date: Thu,  5 Nov 2026 12:48:36 +0700
Message-ID: <20261105054839.2248046-4-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105054839.2248046-1-jjc@jclark.com>
References: <20261105054839.2248046-1-jjc@jclark.com>
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

Add an optional write_sts bus operation returning system timestamp
bounds for completion of a clause 22 MDIO write. This allows PHY
drivers to obtain tighter bounds when implementing gettimex64. SPI
introduced a similar facility to allow a device driver to obtain
timestamp bounds from the bus controller in commit 79591b7db21d ("spi:
Add a PTP system timestamp to the transfer structure").

The core provides no fallback, because a bus driver's write may return
before the transfer has completed.

An aux clock that is disabled and re-enabled restarts its raw time
with the same clock_was_set_seq, so the MDIO core cannot always tell
that the clock was reset during a write. The same problem can occur
within any PTP_SYS_OFFSET_EXTENDED sample, and the PTP core does not
yet detect it. This patch leaves this problem to be fixed by the PTP
core.

__mdiobus_write_sts() takes the longest delay from completion of the
write to the event being timed, such as a PHY capturing its time, and
adds it to the upper bound before checking that the clock was not
stepped within the bounds.

Also add MDIO_C22_FRAME_BITS and MDIO_PREAMBLE_BITS, the number of
bits in a clause 22 frame and in its preamble. A bus driver can use
them with the MDC period to work out when a write completes.

Signed-off-by: James Clark <jjc@jclark.com>
---
Changes in v2:
- Require @sts (Andrew)
- Say that write_sts and __mdiobus_write_sts() do clause 22 writes
  (Andrew)
- Wrap __phy_write_sts() to 80 columns (checkpatch)
- Add MDIO_C22_FRAME_BITS and MDIO_PREAMBLE_BITS for use by bus
  drivers (Andrew)
- Drop "callers must retry anyway" from the comment on the
  clock-step check (Sashiko)
- Explain why the core waits after write_sts() returns, and the 1 ms
  cap on that wait (Andrew, Sashiko)
- Say that the MDIO core cannot detect every aux clock reset
  (Sashiko), and that this is an existing gap, to be fixed in the PTP
  core
- Say that -EBUSY and -EINVAL may be returned after the write has
  taken effect (Sashiko)
- Read the time before each snapshot in the wait, so that a long
  preemption can't fail a valid write
- Add an event delay argument to __mdiobus_write_sts() and
  __phy_write_sts(), added to the upper bound
- Move after the ptp patch, whose helper it now uses

 drivers/net/mdio/mdio-mux.c |  27 +++++++++
 drivers/net/phy/mdio_bus.c  | 107 ++++++++++++++++++++++++++++++++++++
 include/linux/mdio.h        |  10 ++++
 include/linux/phy.h         |  39 +++++++++++++
 4 files changed, 183 insertions(+)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index fe0e46bd7964..ed463a087ce9 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -123,6 +123,31 @@ static int mdio_mux_write_c45(struct mii_bus *bus, int phy_id, int dev_addr,
 	return r;
 }
 
+static int mdio_mux_write_sts(struct mii_bus *bus, int phy_id, int regnum,
+			      u16 val, struct ptp_system_timestamp *sts)
+{
+	struct mdio_mux_child_bus *cb = bus->priv;
+	struct mdio_mux_parent_bus *pb = cb->parent;
+
+	int r;
+
+	mutex_lock_nested(&pb->mii_bus->mdio_lock, MDIO_MUTEX_MUX);
+	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
+	/* write_sts must not return -EOPNOTSUPP. */
+	if (r == -EOPNOTSUPP)
+		r = -EIO;
+	if (r)
+		goto out;
+
+	pb->current_child = cb->bus_number;
+
+	r = pb->mii_bus->write_sts(pb->mii_bus, phy_id, regnum, val, sts);
+out:
+	mutex_unlock(&pb->mii_bus->mdio_lock);
+
+	return r;
+}
+
 static int parent_count;
 
 static void mdio_mux_uninit_children(struct mdio_mux_parent_bus *pb)
@@ -222,6 +247,8 @@ int mdio_mux_init(struct device *dev,
 			cb->mii_bus->read_c45 = mdio_mux_read_c45;
 		if (parent_bus->write_c45)
 			cb->mii_bus->write_c45 = mdio_mux_write_c45;
+		if (parent_bus->write_sts)
+			cb->mii_bus->write_sts = mdio_mux_write_sts;
 		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
 		if (r) {
 			mdiobus_free(cb->mii_bus);
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 00d0e4159e9b..493eb4ae0303 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/phy.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -145,6 +146,112 @@ int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)
 }
 EXPORT_SYMBOL(__mdiobus_write);
 
+/**
+ * __mdiobus_write_sts - Timestamped version of the __mdiobus_write function
+ * @bus: the mii_bus struct
+ * @addr: the phy address
+ * @regnum: register number to write
+ * @val: value to write to @regnum
+ * @event_delay_ns: the longest the event being timed can follow
+ *		    completion of the transfer
+ * @sts: system timestamps bounding an event occurring at most
+ *	 @event_delay_ns after completion of the transfer
+ *
+ * Return: Zero if successful, negative error code on failure. Returns
+ *	   -EBUSY or -EINVAL if the system timestamps are not valid; these
+ *	   codes may be returned after the write has taken effect.
+ *	   -EOPNOTSUPP is returned only if mdiobus_supports_write_sts() is
+ *	   false.
+ *
+ * Write a MDIO bus register with a clause 22 write transfer, with system
+ * timestamps bounding completion; a transfer is considered complete on
+ * the rising edge of the MDC that clocks the last data bit. The upper
+ * bound is moved @event_delay_ns later, so that the bounds also contain
+ * an event that follows completion. Caller must hold the mdio bus lock.
+ *
+ * For clocks that can be stepped, validate the clock generation through
+ * the raw time of the upper bound.
+ *
+ * NOTE: MUST NOT be called from interrupt context.
+ */
+int __mdiobus_write_sts(struct mii_bus *bus, int addr, u32 regnum, u16 val,
+			u32 event_delay_ns, struct ptp_system_timestamp *sts)
+{
+	struct system_time_snapshot now;
+	ktime_t deadline;
+	int err;
+
+	lockdep_assert_held_once(&bus->mdio_lock);
+
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
+	if (bus->write_sts)
+		err = bus->write_sts(bus, addr, regnum, val, sts);
+	else
+		err = -EOPNOTSUPP;
+
+	trace_mdio_access(bus, 0, addr, regnum, val, err);
+	mdiobus_stats_acct(&bus->stats[addr], false, err);
+
+	if (err)
+		return err;
+
+	if (!sts->pre_sts.valid || !sts->post_sts.valid)
+		return -EINVAL;
+
+	ptp_adjust_system_postts(sts, event_delay_ns);
+
+	if (sts->clockid == CLOCK_MONOTONIC ||
+	    sts->clockid == CLOCK_MONOTONIC_RAW)
+		return 0;
+
+	/* Fail if the clock was stepped. */
+	if (sts->pre_sts.clock_was_set_seq != sts->post_sts.clock_was_set_seq)
+		return -EBUSY;
+
+	/* Fail if the shift in the upper bound crosses a clock step. Since
+	 * write_sts() can return before the transfer completes, we need to wait
+	 * until the shifted upper bound has passed. This wait needs a deadline
+	 * in case an aux clock is disabled and reenabled, which restarts its
+	 * raw time. 1 ms is enough for a frame with MDC down to about 65 kHz.
+	 */
+	deadline = ktime_add_ns(ktime_get_raw(),
+				(u64)event_delay_ns + NSEC_PER_MSEC);
+	for (;;) {
+		bool late = !ktime_before(ktime_get_raw(), deadline);
+
+		ktime_get_snapshot_id(sts->clockid, &now);
+		if (!now.valid)
+			return -EINVAL;
+
+		if (now.clock_was_set_seq != sts->pre_sts.clock_was_set_seq)
+			return -EBUSY;
+
+		if (!ktime_before(now.monoraw, sts->post_sts.monoraw))
+			return 0;
+
+		if (late)
+			return -EBUSY;
+
+		cpu_relax();
+	}
+}
+EXPORT_SYMBOL_GPL(__mdiobus_write_sts);
+
+/**
+ * mdiobus_supports_write_sts - Check for timestamped write support
+ * @bus: the mii_bus struct
+ *
+ * Return: true if __mdiobus_write_sts() can return system timestamps
+ * for writes on @bus.
+ */
+bool mdiobus_supports_write_sts(struct mii_bus *bus)
+{
+	return bus->write_sts;
+}
+EXPORT_SYMBOL_GPL(mdiobus_supports_write_sts);
+
 /**
  * __mdiobus_modify_changed - Unlocked version of the mdiobus_modify function
  * @bus: the mii_bus struct
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index a7d9e3ae362a..204e71b8bfe3 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -11,6 +11,7 @@
 
 struct gpio_desc;
 struct mii_bus;
+struct ptp_system_timestamp;
 struct reset_control;
 
 /* Multiple levels of nesting are possible. However typically this is
@@ -156,6 +157,12 @@ struct mdio_if_info {
 #define MDIO_SUPPORTS_C45		2
 #define MDIO_EMULATE_C22		4
 
+/* Bits in a clause 22 frame, from the start of its preamble to the end
+ * of its data, and bits in the preamble (IEEE 802.3 22.2.4.5).
+ */
+#define MDIO_C22_FRAME_BITS		64
+#define MDIO_PREAMBLE_BITS		32
+
 struct ethtool_cmd;
 struct ethtool_pauseparam;
 extern int mdio45_probe(struct mdio_if_info *mdio, int prtad);
@@ -574,6 +581,9 @@ static inline void mii_c73_mod_linkmode(unsigned long *adv, u16 *lpa)
 
 int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum);
 int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val);
+int __mdiobus_write_sts(struct mii_bus *bus, int addr, u32 regnum, u16 val,
+			u32 event_delay_ns, struct ptp_system_timestamp *sts);
+bool mdiobus_supports_write_sts(struct mii_bus *bus);
 int __mdiobus_modify(struct mii_bus *bus, int addr, u32 regnum, u16 mask,
 		     u16 set);
 int __mdiobus_modify_changed(struct mii_bus *bus, int addr, u32 regnum,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21afc2082b17..e22e489eccea 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -374,6 +374,14 @@ struct mii_bus {
 	/** @write_c45: Perform a C45 write transfer on the bus */
 	int (*write_c45)(struct mii_bus *bus, int addr, int devnum,
 			 int regnum, u16 val);
+	/**
+	 * @write_sts: Perform a C22 write transfer on the bus,
+	 * with system timestamps bounding its completion. Set only
+	 * if timestamps can always be provided. Must not return
+	 * -EOPNOTSUPP.
+	 */
+	int (*write_sts)(struct mii_bus *bus, int addr, int regnum, u16 val,
+			 struct ptp_system_timestamp *sts);
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
 	/**
@@ -1802,6 +1810,37 @@ static inline int __phy_write(struct phy_device *phydev, u32 regnum, u16 val)
 			       val);
 }
 
+/**
+ * phy_supports_write_sts - Check for timestamped PHY register writes
+ * @phydev: the phy_device struct
+ *
+ * Return: true if __phy_write_sts() can return system timestamps.
+ */
+static inline bool phy_supports_write_sts(struct phy_device *phydev)
+{
+	return mdiobus_supports_write_sts(phydev->mdio.bus);
+}
+
+/**
+ * __phy_write_sts - Write a PHY register with timestamps bounding completion
+ * @phydev: the phy_device struct
+ * @regnum: clause 22 register number
+ * @val: value to write
+ * @event_delay_ns: as for __mdiobus_write_sts()
+ * @sts: system timestamp bounds
+ *
+ * Return: As for __mdiobus_write_sts().
+ *
+ * The caller must hold the MDIO bus lock.
+ */
+static inline int __phy_write_sts(struct phy_device *phydev, u32 regnum,
+				  u16 val, u32 event_delay_ns,
+				  struct ptp_system_timestamp *sts)
+{
+	return __mdiobus_write_sts(phydev->mdio.bus, phydev->mdio.addr,
+				   regnum, val, event_delay_ns, sts);
+}
+
 /**
  * __phy_modify_changed() - Convenience function for modifying a PHY register
  * @phydev: a pointer to a &struct phy_device
-- 
2.56.0

