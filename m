Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B183B05AD
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282980; cv=none; b=CjA4R7OsEvxnGUhjfr7kWQV4nUWIJQb4nUESHLPpHPqBWviWk3Tk4khLwXZvws8wL0kaNNAJGxqdbDlZBsvPYswrrhHbarP8XSLkcnvIJ8sDFZzfC2o7wnNc/4qDQsjUIt2PKnc3njgZHOGjtBQGcwwgLJ6ak+yViQB2Gg1JKUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282980; c=relaxed/simple;
	bh=mOSknRJALEeH0ArVTK4a7P9Cf+YKbXn1MALPUuZ6BMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDHiSE/1qQ8gjHXGRLloQuAvYGXqjQMgdhGshq+LNIFdvmGknr2CuqpdcxWXYCA8PL4Bzf9vKczlMxqLdz43lNSXtK7OMkFLIf2CRb5hRovmLChtGfVcLycb61xQ/YfLg+la4Rss3W6jNvt3T/FvrrwOMyVKESVALJN5bDVSQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=E53AaLNs; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="E53AaLNs"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso945216a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791282978; x=1791887778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G9KwwvdCGw4wnkqkBvgSxtro1CwOxVuRFZAYG/9e5sw=;
        b=E53AaLNs7cavZ8bcJ/WP6XXZyBqo6RnGnOE07bP4Tmqmd/qIiQmYNT8eg42f7U1KHi
         vUpI+LRr6DTvNJJeBZLexRSKcYJ3zo+/w7ZeKuEG75jTzKnB0oNwDkAN4gsJbuE+D1L1
         C1VjQiQto7PFGF9RlSfNPreTojyF7jgpmJ4ZWk+LJE24tZO6EoLixLR1UKtjGHyLkpcT
         OiZ2spf5zAxP37NgsE+IkiEF4Bh/gzaMLCU8Mt93BGfntzolikaKkNrKfaDF9fC70F9E
         /9uNzsqWMSC2GvDOfedDen4YhDUb8beidQ12Icy3P1WQ8xoCqRk+8rEa2eX5eyQcAsr2
         sh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282978; x=1791887778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G9KwwvdCGw4wnkqkBvgSxtro1CwOxVuRFZAYG/9e5sw=;
        b=LqCF4KAKpnUEC7R+MdaRM0mENxY35ph+ydQo/VYmcLsbZk1vpwhRzzjV+n3JsDhEkY
         eXljTr3bF9SFfirsw8N6jz9qlTsdMGnyz1NIbIlWmtNtZTZl4wbjDzn6bhHHD9whBKO3
         XSApfhyFzY6/YScGWOLN7rVDtZFlJF15G7NyEUigukmpA+xAdbxF3QdzNc1kJFiNyY7O
         SvygMVMBZpWtUHIeMM+DB+s8mSUJk82ntI/k3lNtkH/M6hdZB2TMRKOJ56MelSUz004+
         graZ7NUKzfgHSlm/cNxuNnZxaotwVi1ufVr02Q0URrVz817pBxVZsS+6kMN4eYOsW1xL
         bUKg==
X-Forwarded-Encrypted: i=1; AKwUvBzDhhEQYJk2t0OGXyv6yU88OcZIfmsFi9Q2PHZNxOWcOcTTDcdAvQilvvzOIqUyq2SXzHATsWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbJ8ahTj3GKSjcB+xB2UhPNmzP8uSmsvneAg3lGldixEQTloUv
	WBDHnEt0WRakmEXkVp6i1o7q3uEQj6jXXW8t0NLZXw9f7bkcEvDyzbIPsJk39Aq97w==
X-Gm-Gg: AYBFou0VWyldhJtwxTaGgJs5lsXowY4Fm04UerBn/qGLTO7lz9OfoT/c2QEPDCuUdaE
	ClZaFTxAt+yNt9LM1TfyflIqSLUMMymzdO/WMcToI45eLquP9QjM6km8Nk57VPk0/4B+IKShRD1
	a1UN9FB+ehxAQbuPtYCj08c7mETlUQOP9XGP/sXBun6RW5DAbo0WlIIwHPm+d36uR6tZWT7nS1/
	2ypK3/EuFTAEw0BdL8r4oBYMGO9suzd2JcvurlhrQNmRpNbyzAS7vd/DecHHCcPGQY76lGkPNKT
	Btrcj3+xjKBRp5EDa2hgdD/M0Ad1rxvHZGuBz7ubZI2yz2nJNt9oQdh1iK7j0zCasOuno2UUgzL
	WNX7nw75/+bI4B5YTmnizQ+XxndfASYslQAgxgQZpo4LVvmE55Wy7X0erEuhJccsgzKdqt9QbpA
	gCrR16TWOqtlcfEc3LNYlv3AzPhcR/4U34jC8m+KDdqvF9lbvlNE1WQmORIcdR8KoN0I21Efhvi
	UnpATg=
X-Received: by 2002:a17:90b:3c81:b0:3a6:d851:21e5 with SMTP id 98e67ed59e1d1-3a87267eb17mr864083a91.4.1791282978152;
        Tue, 06 Oct 2026 03:36:18 -0700 (PDT)
Received: from mimolette.lan ([58.136.77.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a85afe9ef9sm3553119a91.12.2026.10.06.03.36.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 03:36:17 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: stmmac: ptp: switch to gettimex64() interface
Date: Tue,  6 Oct 2026 17:36:10 +0700
Message-ID: <20261006103610.98277-1-jjc@jclark.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stmmac PTP support currently implements the gettime64 callback to
retrieve the hardware clock time. Update the implementation to provide
the gettimex64 callback instead, adding support for the
PTP_SYS_OFFSET_EXTENDED ioctl.

The system clock readings are taken around the read of the nanoseconds
register in get_systime(), so get_systime() gains a ptp_system_timestamp
argument. rmb() is used to ensure proper ordering on weakly ordered
architectures.

Assisted-by: LLM
Signed-off-by: James Clark <jjc@jclark.com>
---
Tested on a Radxa ZERO 3E (RK3566, DWMAC 4/5) running net-next.
Width of the interval between the two system clock readings
bracketing each PHC read (2000 calls of 25 samples each):

                                         min      median
Before patch (PTP_SYS_OFFSET):           875 ns   1167 ns
After patch (PTP_SYS_OFFSET_EXTENDED):   291 ns    584 ns

On this board the 24 MHz arch timer counter advances in steps of 7
(~292 ns), so all intervals are multiples of that.

 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  5 ++++-
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c   |  9 ++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c    | 17 ++++++++++-------
 .../ethernet/stmicro/stmmac/stmmac_selftests.c  |  4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c |  3 ++-
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index a8a5c8fdd..6efbfe501 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -493,6 +493,8 @@ struct stmmac_ops {
 #define stmmac_fpe_map_preemption_class(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, fpe_map_preemption_class, __args)
 
+struct ptp_system_timestamp;
+
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
 	void (*config_hw_tstamping) (void __iomem *ioaddr, u32 data);
@@ -502,7 +504,8 @@ struct stmmac_hwtimestamp {
 	int (*config_addend) (void __iomem *ioaddr, u32 addend);
 	int (*adjust_systime) (void __iomem *ioaddr, u32 sec, u32 nsec,
 			       int add_sub, int gmac4);
-	void (*get_systime) (void __iomem *ioaddr, u64 *systime);
+	void (*get_systime)(void __iomem *ioaddr, u64 *systime,
+			    struct ptp_system_timestamp *sts);
 	void (*get_ptptime)(void __iomem *ioaddr, u64 *ptp_time);
 	void (*timestamp_interrupt)(struct stmmac_priv *priv);
 	void (*hwtstamp_correct_latency)(struct stmmac_priv *priv);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index b9a985fa7..a556b49aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -183,7 +183,8 @@ static int adjust_systime(void __iomem *ioaddr, u32 sec, u32 nsec,
 					 10, 100000);
 }
 
-static void get_systime(void __iomem *ioaddr, u64 *systime)
+static void get_systime(void __iomem *ioaddr, u64 *systime,
+			struct ptp_system_timestamp *sts)
 {
 	u64 ns, sec0, sec1;
 
@@ -191,8 +192,14 @@ static void get_systime(void __iomem *ioaddr, u64 *systime)
 	sec1 = readl_relaxed(ioaddr + PTP_STSR);
 	do {
 		sec0 = sec1;
+		ptp_read_system_prets(sts);
+		if (sts)
+			rmb();
 		/* Get the TSSS value */
 		ns = readl_relaxed(ioaddr + PTP_STNSR);
+		if (sts)
+			rmb();
+		ptp_read_system_postts(sts);
 		/* Get the TSS value */
 		sec1 = readl_relaxed(ioaddr + PTP_STSR);
 	} while (sec0 != sec1);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3bfcc9760..41f0885ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -89,7 +89,8 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		u64 cycle_time;
 
 		mutex_lock(&priv->est_lock);
-		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
+		priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
+					       NULL);
 		current_time_ns = timespec64_to_ktime(current_time);
 		time.tv_nsec = priv->est->btr_reserve[0];
 		time.tv_sec = priv->est->btr_reserve[1];
@@ -114,15 +115,17 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 }
 
 /**
- * stmmac_get_time
+ * stmmac_get_timex
  *
  * @ptp: pointer to ptp_clock_info structure
  * @ts: pointer to hold time/result
+ * @sts: pointer to hold system timestamps around the read, or NULL
  *
  * Description: this function will read the current time from the
  * hardware clock and store it in @ts.
  */
-static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
+static int stmmac_get_timex(struct ptp_clock_info *ptp, struct timespec64 *ts,
+			    struct ptp_system_timestamp *sts)
 {
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
@@ -130,7 +133,7 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	u64 ns = 0;
 
 	read_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_get_systime(priv, priv->ptpaddr, &ns);
+	stmmac_get_systime(priv, priv->ptpaddr, &ns, sts);
 	read_unlock_irqrestore(&priv->ptp_lock, flags);
 
 	*ts = ns_to_timespec64(ns);
@@ -200,7 +203,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 
 		target_ns = cfg->start.tv_nsec + ((u64)cfg->start.tv_sec * NSEC_PER_SEC);
 
-		stmmac_get_systime(priv, priv->ptpaddr, &ns);
+		stmmac_get_systime(priv, priv->ptpaddr, &ns, NULL);
 		if (ns > TIME64_MAX - PTP_SAFE_TIME_OFFSET_NS)
 			return -EINVAL;
 
@@ -304,7 +307,7 @@ const struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.pps = 0,
 	.adjfine = stmmac_adjust_freq,
 	.adjtime = stmmac_adjust_time,
-	.gettime64 = stmmac_get_time,
+	.gettimex64 = stmmac_get_timex,
 	.settime64 = stmmac_set_time,
 	.enable = stmmac_enable,
 };
@@ -321,7 +324,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
 	.pps = 0,
 	.adjfine = stmmac_adjust_freq,
 	.adjtime = stmmac_adjust_time,
-	.gettime64 = stmmac_get_time,
+	.gettimex64 = stmmac_get_timex,
 	.settime64 = stmmac_set_time,
 	.enable = dwmac1000_ptp_enable,
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 6097f312f..2ae4f0e76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1778,7 +1778,7 @@ static int stmmac_test_tbs(struct stmmac_priv *priv)
 		return ret;
 
 	read_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_get_systime(priv, priv->ptpaddr, &curr_time);
+	stmmac_get_systime(priv, priv->ptpaddr, &curr_time, NULL);
 	read_unlock_irqrestore(&priv->ptp_lock, flags);
 
 	if (!curr_time) {
@@ -1800,7 +1800,7 @@ static int stmmac_test_tbs(struct stmmac_priv *priv)
 
 	/* Check if expected time has elapsed */
 	read_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_get_systime(priv, priv->ptpaddr, &curr_time);
+	stmmac_get_systime(priv, priv->ptpaddr, &curr_time, NULL);
 	read_unlock_irqrestore(&priv->ptp_lock, flags);
 
 	if ((curr_time - start_time) < STMMAC_TBS_LT_OFFSET)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 42a00446e..57ebeb2c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1070,7 +1070,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	mutex_lock(&priv->est_lock);
 	/* Adjust for real system time */
-	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
+	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
+				       NULL);
 	current_time_ns = timespec64_to_ktime(current_time);
 	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
 					qopt->cycle_time);

base-commit: cfb7793d1bc0f7d90571611979654cf1b3886b29
-- 
2.55.0

