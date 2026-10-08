Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495633EB7FB
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455899; cv=none; b=sDMYyaslQxAYCxCyoksEcNZ6MC/+tYurffzmlW4ta4O3fJ29YpS74sMKX+Fuii3AbRWDK9nM9zgunTKDU9JelH2Bsj4HrHTcg/GDXu+p9616T7SY5y8HzzUO9qXy0X+49Pzahlgst4FX5zHcDr41kW9eA29pP80QW94qjvCCikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455899; c=relaxed/simple;
	bh=OhUwK9CKnQrFTTtUTqYePtOiFHISBigp4v656dVbCFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hCSVZWWOSKe8+MsRD9aXCMtyd/KHXAWKa/oj5jdaPRnaTouL2nzdz4FZtEkQLE1XzL5yi3VO3bv1Dy3R8m72fqes1jAmu8SdNgynuTu8hr2EIy/8A05yrjnN4zTRniWFeWCNSfVfJJatfwL8Tt+lKuJv4+LS+WSEMLQIAmbT+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=WGqCOIW0; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="WGqCOIW0"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a0a87595so3177769a91.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791455897; x=1792060697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLfGTPUcUWb9l5deLpoGs8ct/J5SWokbi6MEeKK6Nzo=;
        b=WGqCOIW0m2pOy6+0C0aUtvFRy3+Xm9Fnr1ynoZllKUNKjR3XvG0oe6BwA+UBj7FUWb
         GiRyZmGWAmOcE3BF0PnUyAIha08i+t+1R8/q7Nm4UwAsA6654bzusg+KSyDLdqW/SRgr
         Wi/WKsSTN+9SL2THu43kncfHkiOZL/Ku/47OKPjPnkOckmY2u43gMkZN52hoAhJ1FJnN
         O4mRnY2H8IV3XiIqlk8haFig7dY3WL9nk+QTA/aQtJjdotbo4zvLgCcn9v0M4gbAswdq
         UlRyqKo34ezWrzJk0TjsERkwQna/tqSTzM9yGfpPZ+Uspg737tX2+06FZLIAD3avDgKD
         Sd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455897; x=1792060697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLfGTPUcUWb9l5deLpoGs8ct/J5SWokbi6MEeKK6Nzo=;
        b=X1EJ1yhy5vkI03J+5o6rQuKAql0W2BJEPU9y7bPrpIKjPVrw/pIEtDQVnGyLrBgQ8d
         7iVjNqsS/Cy2R1owDrq0b/R4UKcg+bCmP9JmJj/HKJcioE6sU1UWjODCgpVSsIkGk6Ce
         zbq74FRMl2x3MQ93Qfj1XboC9r4GOHTEXKIhBspECuewE0pqQ0yW7EkBIdXayfED3ZEa
         X4yPc8cm9c34iKqk3Qajy2YJFEkxTJlvFtt3wYaPVbuHIqna2WZyVKp6dDcVndFa34C4
         oSLQUQFeYA4ywyfyNeWWzkNOKjwz1oSMmnnWr8+J2pzX7nMdjJdNaVffB8rFZheEXRnm
         3/hg==
X-Forwarded-Encrypted: i=1; AKwUvBzURxJ4VMyzsgzHTTf6AURvCQbcKnmivk1IF4i5Q90hzosbFpO0ZXLgXi18c/+83RhIVoFjkjk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmDC1OeLkKiXnZs5XYFBxxL4HTDW8hIpdfm/G2n8L8A8AxTv5p
	WYG5OCcVYKExVKtpKC+INh+vXayakxPYubqQohQUrxpbKYE2GyFM45VfldbQskbWWg==
X-Gm-Gg: AYBFou1yazeUy8oLpz+djCOo43a5C9PqZyQGa+8+sPX6hwZ6cZi4YAk+UxFAKxTOwsI
	D13Dln0CDlOPRci2GFphdvzomA+Wdmb7HvFQrGmU5VN288sSeIgCPT2dXuAmvsdGWOnlHQ/7HNX
	drpcA9jpllbqN+6+27GPNL0IKdmtWPEiP9EfJdo70dYX4F4ihxbWpmWtGTVFqoFDsoeJ8YwvO7l
	rHwRZI1oF8k66KG7SQK/mn1uNVTgr0hxEukGSR5vjKIfFA9dc2SHquPoy+iA4C4SA3+G36fwTk1
	9Zf4q4DybKy7XBFArqHR/QZME7XCjuBF2RMBanN4ATZ8AHkGK8S2U6FIU51fskzI0u5GzOjiPhE
	N1snwsJXh8nXW+tU8gGFJUlZyME2PoVtEYxtUz2DNiE+NIOopSSwwN0EsC9GUxeKCdJyPlAFZDC
	O90AxgxGdUpYCSFoxSIcLKVrcCxpKujh+LiQymjf/iMDfYlrb5VcEhtWR38gR+EQ==
X-Received: by 2002:a17:90b:4a8f:b0:39e:6a82:afda with SMTP id 98e67ed59e1d1-3a8a1b3206emr4398317a91.44.1791455897384;
        Thu, 08 Oct 2026 03:38:17 -0700 (PDT)
Received: from cantal.lan ([58.136.72.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab0458bce8sm1008070a91.3.2026.10.08.03.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:38:16 -0700 (PDT)
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
	Nicolai Buchwitz <nb@tipi-net.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: stmmac: ptp: switch to gettimex64() interface
Date: Thu,  8 Oct 2026 17:38:09 +0700
Message-ID: <20261008103809.1848255-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
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
argument.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Assisted-by: LLM
Signed-off-by: James Clark <jjc@jclark.com>
---
Changes in v2:
- Read PTP_STNSR with readl() and drop the two rmb() calls
  (Nicolai Buchwitz, Maxime Chevallier)
- Fix the kernel-doc of stmmac_get_timex() and an over-long line
  in stmmac_adjust_time() (netdev CI)
- Link to v1: https://lore.kernel.org/netdev/20261006103610.98277-1-jjc@jclark.com/

Tested on a Radxa ZERO 3E (RK3566, DWMAC 4/5) running net-next.
Width of the interval between the two system clock readings
bracketing each PHC read (2000 calls of 25 samples each):

                                         min      median
Before patch (PTP_SYS_OFFSET):           875 ns   1167 ns
After patch (PTP_SYS_OFFSET_EXTENDED):   291 ns    583 ns

On this board the 24 MHz arch timer counter advances in steps of 7
(~292 ns), so all intervals are multiples of that.

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  5 ++++-
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  7 +++++--
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 21 ++++++++++---------
 .../stmicro/stmmac/stmmac_selftests.c         |  4 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  3 ++-
 5 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index a8a5c8fdd5e..6efbfe50102 100644
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
index b9a985fa772..870c740b4a5 100644
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
 
@@ -191,8 +192,10 @@ static void get_systime(void __iomem *ioaddr, u64 *systime)
 	sec1 = readl_relaxed(ioaddr + PTP_STSR);
 	do {
 		sec0 = sec1;
+		ptp_read_system_prets(sts);
 		/* Get the TSSS value */
-		ns = readl_relaxed(ioaddr + PTP_STNSR);
+		ns = readl(ioaddr + PTP_STNSR);
+		ptp_read_system_postts(sts);
 		/* Get the TSS value */
 		sec1 = readl_relaxed(ioaddr + PTP_STSR);
 	} while (sec0 != sec1);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3bfcc9760dc..e54a3c88782 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -89,7 +89,8 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		u64 cycle_time;
 
 		mutex_lock(&priv->est_lock);
-		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
+		priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops,
+					       &current_time, NULL);
 		current_time_ns = timespec64_to_ktime(current_time);
 		time.tv_nsec = priv->est->btr_reserve[0];
 		time.tv_sec = priv->est->btr_reserve[1];
@@ -114,15 +115,15 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 }
 
 /**
- * stmmac_get_time
- *
+ * stmmac_get_timex - read the PTP clock, with system timestamps if requested
  * @ptp: pointer to ptp_clock_info structure
  * @ts: pointer to hold time/result
+ * @sts: pointer to hold system timestamps around the read, or NULL
  *
- * Description: this function will read the current time from the
- * hardware clock and store it in @ts.
+ * Return: 0
  */
-static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
+static int stmmac_get_timex(struct ptp_clock_info *ptp, struct timespec64 *ts,
+			    struct ptp_system_timestamp *sts)
 {
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
@@ -130,7 +131,7 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	u64 ns = 0;
 
 	read_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_get_systime(priv, priv->ptpaddr, &ns);
+	stmmac_get_systime(priv, priv->ptpaddr, &ns, sts);
 	read_unlock_irqrestore(&priv->ptp_lock, flags);
 
 	*ts = ns_to_timespec64(ns);
@@ -200,7 +201,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 
 		target_ns = cfg->start.tv_nsec + ((u64)cfg->start.tv_sec * NSEC_PER_SEC);
 
-		stmmac_get_systime(priv, priv->ptpaddr, &ns);
+		stmmac_get_systime(priv, priv->ptpaddr, &ns, NULL);
 		if (ns > TIME64_MAX - PTP_SAFE_TIME_OFFSET_NS)
 			return -EINVAL;
 
@@ -304,7 +305,7 @@ const struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.pps = 0,
 	.adjfine = stmmac_adjust_freq,
 	.adjtime = stmmac_adjust_time,
-	.gettime64 = stmmac_get_time,
+	.gettimex64 = stmmac_get_timex,
 	.settime64 = stmmac_set_time,
 	.enable = stmmac_enable,
 };
@@ -321,7 +322,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
 	.pps = 0,
 	.adjfine = stmmac_adjust_freq,
 	.adjtime = stmmac_adjust_time,
-	.gettime64 = stmmac_get_time,
+	.gettimex64 = stmmac_get_timex,
 	.settime64 = stmmac_set_time,
 	.enable = dwmac1000_ptp_enable,
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 6097f312fce..2ae4f0e760c 100644
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
index 42a00446e9b..57ebeb2c19c 100644
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
-- 
2.56.0

