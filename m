Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E74CCDC0
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556523; cv=none; b=qqNc9qeG3MNZBrhwTuMf3ilGlQacdtR49Qpz9TV0PVRBv9SQL9pbl4DWiItuPb3TFRNDH+0UCJs8TGPjyIismcuLR4FjIbEJmDsd+8zdTxRisde4lgq85foO9lKDwXsamYey2PMaNyNsiRf3zKuIg/O9dUypDAB8w9DZEysjSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556523; c=relaxed/simple;
	bh=XjY9ZgtYkoP4Amh/eci2Ig0MslB2hC/NfbIZFA6Q9j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdNk7E18LOaRSaUweu8hT/UtEur5VLBljKLFty3b/JjMtfrswTdM19cUpZbRhwd7SuO5IkvphmzVZpRD5GJn9WCu4X0xj5nW0LEUXfreMBt+o+PyIIDKuHxawxaEsAgGQ1UWPMU4bxEcQfPVMp5If4GV0eEUsoblCvL14+53Utg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=Yw1Rd7n4; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="Yw1Rd7n4"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917c04630c2so44471426d6.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791556520; x=1792161320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IiMKQZLsG+92+V8twkMsjG56s12mZLkh2CzsWkHiPjI=;
        b=Yw1Rd7n44EjqhZR8psRjOsBHLT3wYgZJebF92v1md8mmYkvSXq9gTOdw4s9NHrP/em
         f6owUaIIHwHxt9NpePwGjR2MZaVBoG3po8BPAewaDjZQsZaKzTGe9KDJybPhODt8VKZT
         WA/E8PIhmx9AzbCFsMgtUgfnP5TKvOXrlEYJ8UDAWApWbcYWwAmw034dcwi4dTpS4WgY
         WIh8kA65KL8GaJgo8clw2UeHRmLyiM7tV1S2JFntP3wFv9k7Lhl3ZzPe+UkJF8o1VTh4
         T67+sllOHFVpzZ8rjapGwUe5Rf9cLHYGgr3v4HXlnYLKXeS6EmPmCzTx+vCPhUqupoGf
         feUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556520; x=1792161320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IiMKQZLsG+92+V8twkMsjG56s12mZLkh2CzsWkHiPjI=;
        b=q+S4cBze6/16V74WrOkFIYfRwpvsY0katUX/UDjyPdM7MPAFJ1V7betTvB9+1kAMbB
         Hl4aKFJFFI1x+inHdayKSt88x8VlZvpeemOlBk3XwdkZ8oYqtdeUA6SqiCKRx0R+4LwS
         i6QSThpR2JkzmASD9TW0aMN8NNTBugobeUYmGH2l6dC7pTuoU8MjPD9UnbVB+E7L4REy
         SoyZTO3rM3tzA/ZCjGlEuqtarvZVEemno8BhgUXKknaHGNy5WwWp6zHG5cKPMwbAlgMs
         MmrRiw7Gl/Hi/rmv5LRyGmtKDapa7uvUNrrM3bqyRXRZwATN82uZefcOj+4poN6eY0po
         GT8w==
X-Forwarded-Encrypted: i=1; AKwUvBwXK+cysnfV0GsPpjhZtXtBcdJMto9JXQtabazq+I3D53cj8dzIw9VIfEax6Qu+cZj8THITqng=@vger.kernel.org
X-Gm-Message-State: AFuF++m8vPswI6F2acp0hoY9bpsJ3ZgJ6Zka8qX9P/mN4bFBvbV7GiC8
	c1AahqtsHN5kKkOOKkqYomCtwom3GFupQN/9UT/Un31RC+lOob5KXdArEew7sMRH2g==
X-Gm-Gg: AYBFou3AqgmN9dxBrIg2AWxyXTCo1O7yTHx8hF7ecCiEIVDI/L0gNAybakY4XOjxSLm
	4jnhgsKdFaTDGVr3vd4J1usAIpCg5BNUP7DRL6I4b8iS0rpJ2h54e5E1qPL/o2rdOyNINl9QsVo
	i63iY3ZCuD4cfPl8QSo7ZCsJwig3XI/m8PXBEYQ6YNnxQ4KHtBRLsrbf5dJORiDa+KYM915ITcR
	EC7b4xSwYEOcH2z5dliO3WmnNy5PgCG3ucioCbGctpdJ2iEJYf3wEXE1PMEHG0UXeLg2YxKzmnV
	uprkdIhIT6qsx9UzJlY56P+A0GR8H+LmqRUmZwsEw3XBynBt3TKVv6eSgAYZdckAyuGmbg8efxZ
	H45le0tOe55q0hzi8XNAL5R0EFYbY3F5vEWqO/fFUN3oou28+hVxv+nyH35Jmm2gVfKlQZBaLAx
	SkW36RJ1ZWmdBfSJDasGKH4UVLRq9IBP4V9bF/4ts0hRrYuRB20hUpPKzNXkJg
X-Received: by 2002:a05:620a:2985:b0:93c:9d56:a860 with SMTP id af79cd13be357-93ebd228f3dmr313532885a.19.1791556520243;
        Fri, 09 Oct 2026 07:35:20 -0700 (PDT)
Received: from cantal.lan ([58.136.72.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501751dsm19769456d6.17.2026.10.09.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:35:19 -0700 (PDT)
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
Cc: Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: mdio: add timestamped write operation
Date: Fri,  9 Oct 2026 21:35:02 +0700
Message-ID: <20261009143506.2507607-2-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009143506.2507607-1-jjc@jclark.com>
References: <20261009143506.2507607-1-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an optional write_sts bus operation returning system timestamp
bounds for completion of an MDIO write. This allows PHY drivers to
obtain tighter bounds when implementing gettimex64. SPI introduced a
similar facility to allow a device driver to obtain timestamp bounds
from the bus controller in commit 79591b7db21d ("spi: Add a PTP system
timestamp to the transfer structure").

The core provides no fallback, because a bus driver's write may return
before the transfer has completed.

Signed-off-by: James Clark <jjc@jclark.com>
Assisted-by: LLM
---
 drivers/net/mdio/mdio-mux.c |  27 ++++++++++
 drivers/net/phy/mdio_bus.c  | 100 ++++++++++++++++++++++++++++++++++++
 include/linux/mdio.h        |   4 ++
 include/linux/phy.h         |  37 +++++++++++++
 4 files changed, 168 insertions(+)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index fe0e46bd796..ed463a087ce 100644
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
index 00d0e4159e9..8e734227b2c 100644
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
@@ -145,6 +146,105 @@ int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)
 }
 EXPORT_SYMBOL(__mdiobus_write);
 
+/**
+ * __mdiobus_write_sts - Timestamped version of the __mdiobus_write function
+ * @bus: the mii_bus struct
+ * @addr: the phy address
+ * @regnum: register number to write
+ * @val: value to write to @regnum
+ * @sts: system timestamps bounding completion, or NULL
+ *
+ * Return: Zero if successful, negative error code on failure. Returns
+ *	   -EBUSY or -EINVAL if the system timestamps are not valid. If @sts
+ *	   is not NULL, -EOPNOTSUPP is returned only if
+ *	   mdiobus_supports_write_sts() is false.
+ *
+ * Write a MDIO bus register, with system timestamps bounding completion;
+ * a transfer is considered complete on the rising edge of the MDC
+ * that clocks the last data bit. Caller must hold the mdio bus lock.
+ *
+ * For clocks that can be stepped, validate the clock generation through
+ * the raw time of the upper bound.
+ *
+ * If @sts is NULL, perform an ordinary write.
+ *
+ * NOTE: MUST NOT be called from interrupt context.
+ */
+int __mdiobus_write_sts(struct mii_bus *bus, int addr, u32 regnum, u16 val,
+			struct ptp_system_timestamp *sts)
+{
+	struct system_time_snapshot now;
+	ktime_t deadline;
+	int err;
+
+	if (!sts)
+		return __mdiobus_write(bus, addr, regnum, val);
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
+	if (sts->clockid == CLOCK_MONOTONIC ||
+	    sts->clockid == CLOCK_MONOTONIC_RAW)
+		return 0;
+
+	/* Fail if the clock was stepped; callers must retry anyway. */
+	if (sts->pre_sts.clock_was_set_seq != sts->post_sts.clock_was_set_seq)
+		return -EBUSY;
+
+	/* The shifted upper bound can be later than actual completion. */
+	deadline = ktime_add_ns(ktime_get_raw(), NSEC_PER_MSEC);
+	for (;;) {
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
+		/* Cap the wait at 1 ms, which is more than any single
+		 * write's delay. This guards against an aux clock being
+		 * disabled and reenabled, which restarts its raw time.
+		 */
+		if (!ktime_before(ktime_get_raw(), deadline))
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
index a7d9e3ae362..07b6b0c5f8f 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -11,6 +11,7 @@
 
 struct gpio_desc;
 struct mii_bus;
+struct ptp_system_timestamp;
 struct reset_control;
 
 /* Multiple levels of nesting are possible. However typically this is
@@ -574,6 +575,9 @@ static inline void mii_c73_mod_linkmode(unsigned long *adv, u16 *lpa)
 
 int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum);
 int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val);
+int __mdiobus_write_sts(struct mii_bus *bus, int addr, u32 regnum, u16 val,
+			struct ptp_system_timestamp *sts);
+bool mdiobus_supports_write_sts(struct mii_bus *bus);
 int __mdiobus_modify(struct mii_bus *bus, int addr, u32 regnum, u16 mask,
 		     u16 set);
 int __mdiobus_modify_changed(struct mii_bus *bus, int addr, u32 regnum,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c5098a0dd6..d4f57c9bb7a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -374,6 +374,14 @@ struct mii_bus {
 	/** @write_c45: Perform a C45 write transfer on the bus */
 	int (*write_c45)(struct mii_bus *bus, int addr, int devnum,
 			 int regnum, u16 val);
+	/**
+	 * @write_sts: Perform a write transfer on the bus,
+	 * with system timestamps bounding its completion. Set only
+	 * if timestamps can always be provided. Must not return
+	 * -EOPNOTSUPP.
+	 */
+	int (*write_sts)(struct mii_bus *bus, int addr, int regnum, u16 val,
+			 struct ptp_system_timestamp *sts);
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
 	/**
@@ -1792,6 +1800,35 @@ static inline int __phy_write(struct phy_device *phydev, u32 regnum, u16 val)
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
+ * __phy_write_sts - Write a PHY register with a frame-end timestamp
+ * @phydev: the phy_device struct
+ * @regnum: clause 22 register number
+ * @val: value to write
+ * @sts: system timestamp bounds, or NULL
+ *
+ * Return: As for __mdiobus_write_sts().
+ *
+ * The caller must hold the MDIO bus lock.
+ */
+static inline int __phy_write_sts(struct phy_device *phydev, u32 regnum, u16 val,
+				  struct ptp_system_timestamp *sts)
+{
+	return __mdiobus_write_sts(phydev->mdio.bus, phydev->mdio.addr,
+				   regnum, val, sts);
+}
+
 /**
  * __phy_modify_changed() - Convenience function for modifying a PHY register
  * @phydev: a pointer to a &struct phy_device
-- 
2.56.0

