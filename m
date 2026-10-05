Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B04D9549
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225947; cv=none; b=Ywwhrg3wvb5xnYEamk5Q3q8HZLOKOxmosSGWv3VSvv7xcIVXd2u7MvIcNxFsXgJaEK4IXR/rpi/EE8ueJC2SE4X5J0vsJgzM154OEQxNp3GN+lqabddDzTSEX5sES+hlIbbcBjH5ej4CuxXtG/Ft1V7uT2ukX1tv5Pe9ZHwL6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225947; c=relaxed/simple;
	bh=ORc7MUkgA9AaI1NcbJwMNwTiFwkIRUzT3Qjs0GtB+QA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwBp7rdO+yawzjPr/AzAjT8XFjsCHbs5LWAaU3dGWNTjSgS7G4gPLa+wbQlsha3k1gMTSo1Z5LIBKWDi8CHQ6JMQr2t2nE6hDYZDCqxXKMqmJvNP0313pxZ5yLObacry4TWP7rVOrK/zFqXjVcYKKH4ifldQchl11AYsiA6zLZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGaAtVzu; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGaAtVzu"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so1093261fac.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791225940; x=1791830740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tP+U2ImTesMS/fPxz+75W5dQNrWLccz3UTfAM/GjxTo=;
        b=AGaAtVzuIYfarh0aFneOIxSsHmfziYdcipXU6/DJWW/Y3liwNP7S9uxz/v8bRnm/D6
         xMebWIovZPDYOS253UPKNrnwdxJq/QLvJo+Hkv99GE/920E+l1fj/En2cpt7HEvfVEU5
         YNeotRoV30tQ2PL4irmOXoxDnnKVbG/l5ocDDAeLmeNB/hPJZ5N4/PmvATWtmMmq3pOa
         LCS7sUz/dW+wSHKzpjyf1lak3E7gihTU0KL9Y41YS+wb+au2At/P2i9/RjJ0QmkomrtZ
         5z8d9KapBnRxFKsn0qoKJ9A1rtYzxK/TvkM7Aa+fTPTXBsNBfcFSZAk/V1dAFUK7xabw
         HCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791225940; x=1791830740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tP+U2ImTesMS/fPxz+75W5dQNrWLccz3UTfAM/GjxTo=;
        b=prwQs3VqeoPjDvP0S27QXWBlXjQ6cjhOL0D+PSenEgrihx9xXfcbft1EpwB8SRs5dz
         3kt0dnGxoqTcKuvpy70C9I+bhwsnsU0eTiSfwJWh4zFrxXdFvaw0lPdrNaiTfV8VeJAS
         HGB0MtYjKGsYqqcTqMvbvc6nKP09Rqen3w5F+XR+VzzkfaH80ol6eVMlOnc0YJBaJTNu
         78rMMmGj1KLHco8gXKHE5OGawDPbBOWsdSqjQodOM8NNZM14vw9TmG8qW50eXS61rNDM
         Q6uzzlFHSXYAN+/ogTPgQcP96w4H2hNc9FiEb2s9cQBtP2mFCnDDoLbNAum8wrNvC3lD
         YBhA==
X-Gm-Message-State: AFuF++mVzFYFP4PeQuKQ5pSVI5+eEAe604WY63SIRfXKMUk308XwskZZ
	tz7xQlGXMC8l3By3+5yaEIfLPBY8pSc0bKWmSShN4k60b3x8oS/ErwfT
X-Gm-Gg: AYBFou1vje1yS0K2lPfdXCw8z/XiNtELQPbWnGOe6BEh4igBp48lC5P4KDNdBh7UqoA
	hRrLp1Q7nwDPaaiLEm5WywgwNQg/L7kOwkblygxWfGut314c1H3X3GpOrl2Y6QDJr9FhoE/mccb
	eh0hk8F80li6jw+iXM1csd91eGDZcEtTFac1SD1apaHphgvKQ0iXbAuGEllmODJ/qe2WuoBLrdp
	t8drSKFjwONQ79u165cQx2N0vKMEjtOVuYkRo1GzRxLQ8x/DlXAEAULPuGZRMtXfHBn8CSmmPO1
	dSd69AYeB5SMFDngFu8dINdVuWPf/5Ms8hFx0bghKdFE5ZnK4jqZ5UUoZkpnbIYLHscpV2ycFFa
	t4wB2b0B6OyZm86ceHARemem6tIe/PPWCk96QImpstgqsNpO/1z2iHbFdixeMZjkCNYlTttxnXt
	h/FA6sFTUzdrxiZmTcnBx9+E3tHuRNnVSMn22IbeGRqmdw5nvSvQdEJ164yNGoPv5UwtKalpDnO
	F0npNWr2zBIZfeCbJ7rnPzv3JK+a6m1rj7DigrtdQ4MtA2lIKfTSGkn1KggM37J78a8TGixUvTZ
	5zCq09ceHMHb91fDegRyZOG8JmBqmcxUFgMXnRC4Hjeu5EbTD7EB9TeC5/JnI7EMxf9D/nCOBBi
	G7HIMQYK2M6dyJylfwLVr
X-Received: by 2002:a05:6870:2101:b0:448:d78b:17d0 with SMTP id 586e51a60fabf-49e3a84d7demr6823411fac.13.1791225940537;
        Mon, 05 Oct 2026 11:45:40 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16ead0dbsm10666593fac.12.2026.10.05.11.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:45:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 05 Oct 2026 12:45:34 -0600
Subject: [PATCH net v2 2/2] ptp: vclock: preserve time across failed
 physical clock samples
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-ptp-vclock-sampling-v2-2-8ed12d4d10af@gmail.com>
References: <20261005-ptp-vclock-sampling-v2-0-8ed12d4d10af@gmail.com>
In-Reply-To: <20261005-ptp-vclock-sampling-v2-0-8ed12d4d10af@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The cyclecounter read callback cannot report errors. Passing an
unsuccessful PHC read through it consumes an invalid sample, and a zero
sample followed by the real counter can add an extra 32-bit wrap to
virtual time. This was identified by code inspection of reset-time PHC
access and the virtual clock callers.

Read the parent clock before updating or initializing the virtual
counter, propagate failures from clock operations, and leave its state
unchanged on failure. Initialize it before publishing a new virtual
clock.

Simply skipping failed reads is insufficient: the next successful read
can arrive after the 32-bit counter has wrapped, while timestamp
conversion has an even shorter half-wrap window. Use the full physical
nanosecond sample with a wide frequency-adjustment multiply and retain
fractional nanoseconds. This also allows delayed packet timestamps to be
converted without truncating their distance from the last sample.
Serialize extended and cross-timestamp sampling with adjustments and
advance the anchor on each successful clock read.

The initial sample can also fail partway through a sysfs request to create
multiple virtual clocks. Unregister any clocks created by that request
and clear their index entries, preserving the previously installed clocks
and count. Otherwise the failed request leaves registered children that
are not included in n_vclocks. This cleanup also handles existing
allocation and registration failure paths.

Fixes: 5d43f951b1ac ("ptp: add ptp virtual clock driver framework")
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_private.h |   9 +--
 drivers/ptp/ptp_sysfs.c   |   8 ++-
 drivers/ptp/ptp_vclock.c  | 148 ++++++++++++++++++++++++++++++----------------
 3 files changed, 109 insertions(+), 56 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index ec8633126d6b..e08272335da0 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -71,17 +71,18 @@ struct ptp_clock {
 };
 
 #define info_to_vclock(d) container_of((d), struct ptp_vclock, info)
-#define cc_to_vclock(d) container_of((d), struct ptp_vclock, cc)
 #define dw_to_vclock(d) container_of((d), struct ptp_vclock, refresh_work)
 
 struct ptp_vclock {
+	u64 cycles;
+	u64 nsec;
+	u64 frac;
+	u32 mult;
 	struct ptp_clock *pclock;
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct hlist_node vclock_hash_node;
-	struct cyclecounter cc;
-	struct timecounter tc;
-	struct mutex lock;	/* protects tc/cc */
+	struct mutex lock;	/* protects the virtual counter */
 };
 
 /*
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 53388b123198..fabc1c9b1752 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -225,7 +225,7 @@ static ssize_t n_vclocks_store(struct device *dev,
 		for (i = 0; i < num - ptp->n_vclocks; i++) {
 			vclock = ptp_vclock_register(ptp);
 			if (!vclock)
-				goto out;
+				goto err_register;
 
 			*(ptp->vclock_index + ptp->n_vclocks + i) =
 				vclock->clock->index;
@@ -257,6 +257,12 @@ static ssize_t n_vclocks_store(struct device *dev,
 	mutex_unlock(&ptp->n_vclocks_mux);
 
 	return count;
+err_register:
+	num = i;
+	if (num)
+		device_for_each_child_reverse(dev, &num, unregister_vclock);
+	for (num = 0; num < i; num++)
+		ptp->vclock_index[ptp->n_vclocks + num] = -1;
 out:
 	mutex_unlock(&ptp->n_vclocks_mux);
 	return err;
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 84cb527f59cc..52201c6b4d1f 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -6,10 +6,12 @@
  */
 #include <linux/slab.h>
 #include <linux/hashtable.h>
+#include <linux/math64.h>
 #include "ptp_private.h"
 
 #define PTP_VCLOCK_CC_SHIFT		31
 #define PTP_VCLOCK_CC_MULT		(1 << PTP_VCLOCK_CC_SHIFT)
+#define PTP_VCLOCK_FRAC_MASK		((1ULL << PTP_VCLOCK_CC_SHIFT) - 1)
 #define PTP_VCLOCK_FADJ_SHIFT		9
 #define PTP_VCLOCK_FADJ_DENOMINATOR	15625ULL
 #define PTP_VCLOCK_REFRESH_INTERVAL	(HZ * 2)
@@ -42,21 +44,74 @@ static void ptp_vclock_hash_del(struct ptp_vclock *vclock)
 	synchronize_srcu(&vclock_srcu);
 }
 
+/*
+ * Physical clock samples already contain full-width nanoseconds. Do not
+ * truncate them to a 32-bit counter: failed reads can postpone a refresh
+ * beyond its wrap period. Use a wide multiply and retain fractional ns.
+ * Packet timestamps may precede the last sample; conversion must not move
+ * the clock's anchor in that case. The caller holds vclock->lock.
+ */
+static u64 ptp_vclock_convert(struct ptp_vclock *vclock, u64 cycles, u64 *frac)
+{
+	u64 delta = cycles - vclock->cycles;
+	bool backwards = delta > S64_MAX;
+	u64 nsec, rem;
+
+	if (backwards)
+		delta = -delta;
+	nsec = mul_u64_u32_shr(delta, vclock->mult, PTP_VCLOCK_CC_SHIFT);
+	rem = (delta * vclock->mult) & PTP_VCLOCK_FRAC_MASK;
+	if (backwards) {
+		nsec = vclock->nsec - nsec - (rem > *frac);
+		*frac = (*frac - rem) & PTP_VCLOCK_FRAC_MASK;
+	} else {
+		rem += *frac;
+		nsec += vclock->nsec + (rem >> PTP_VCLOCK_CC_SHIFT);
+		*frac = rem & PTP_VCLOCK_FRAC_MASK;
+	}
+
+	return nsec;
+}
+
+static void ptp_vclock_update(struct ptp_vclock *vclock, u64 cycles)
+{
+	vclock->nsec = ptp_vclock_convert(vclock, cycles, &vclock->frac);
+	vclock->cycles = cycles;
+}
+
+/* The caller holds vclock->lock, or has not published the clock yet. */
+static int ptp_vclock_sample(struct ptp_vclock *vclock, u64 *cycles)
+{
+	struct ptp_clock *ptp = vclock->pclock;
+	struct timespec64 ts;
+	int err;
+
+	err = ptp->info->getcycles64(ptp->info, &ts);
+	if (!err)
+		*cycles = timespec64_to_ns(&ts);
+	return err;
+}
+
 static int ptp_vclock_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
+	u64 cycles;
 	s64 adj;
+	int err;
 
 	adj = (s64)scaled_ppm << PTP_VCLOCK_FADJ_SHIFT;
 	adj = div_s64(adj, PTP_VCLOCK_FADJ_DENOMINATOR);
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	timecounter_read(&vclock->tc);
-	vclock->cc.mult = PTP_VCLOCK_CC_MULT + adj;
+	err = ptp_vclock_sample(vclock, &cycles);
+	if (!err) {
+		ptp_vclock_update(vclock, cycles);
+		vclock->mult = PTP_VCLOCK_CC_MULT + adj;
+	}
 	mutex_unlock(&vclock->lock);
 
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_adjtime(struct ptp_clock_info *ptp, s64 delta)
@@ -65,7 +120,7 @@ static int ptp_vclock_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	timecounter_adjtime(&vclock->tc, delta);
+	vclock->nsec += delta;
 	mutex_unlock(&vclock->lock);
 
 	return 0;
@@ -75,15 +130,19 @@ static int ptp_vclock_gettime(struct ptp_clock_info *ptp,
 			      struct timespec64 *ts)
 {
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
-	u64 ns;
+	u64 cycles;
+	int err;
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	ns = timecounter_read(&vclock->tc);
+	err = ptp_vclock_sample(vclock, &cycles);
+	if (!err) {
+		ptp_vclock_update(vclock, cycles);
+		*ts = ns_to_timespec64(vclock->nsec);
+	}
 	mutex_unlock(&vclock->lock);
-	*ts = ns_to_timespec64(ns);
 
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_gettimex(struct ptp_clock_info *ptp,
@@ -94,34 +153,37 @@ static int ptp_vclock_gettimex(struct ptp_clock_info *ptp,
 	struct ptp_clock *pptp = vclock->pclock;
 	struct timespec64 pts;
 	int err;
-	u64 ns;
-
-	err = pptp->info->getcyclesx64(pptp->info, &pts, sts);
-	if (err)
-		return err;
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	ns = timecounter_cyc2time(&vclock->tc, timespec64_to_ns(&pts));
+	err = pptp->info->getcyclesx64(pptp->info, &pts, sts);
+	if (!err) {
+		ptp_vclock_update(vclock, timespec64_to_ns(&pts));
+		*ts = ns_to_timespec64(vclock->nsec);
+	}
 	mutex_unlock(&vclock->lock);
 
-	*ts = ns_to_timespec64(ns);
-
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_settime(struct ptp_clock_info *ptp,
 			      const struct timespec64 *ts)
 {
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
-	u64 ns = timespec64_to_ns(ts);
+	u64 cycles;
+	int err;
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	timecounter_init(&vclock->tc, &vclock->cc, ns);
+	err = ptp_vclock_sample(vclock, &cycles);
+	if (!err) {
+		vclock->cycles = cycles;
+		vclock->nsec = timespec64_to_ns(ts);
+		vclock->frac = 0;
+	}
 	mutex_unlock(&vclock->lock);
 
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_getcrosststamp(struct ptp_clock_info *ptp,
@@ -130,20 +192,17 @@ static int ptp_vclock_getcrosststamp(struct ptp_clock_info *ptp,
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
 	struct ptp_clock *pptp = vclock->pclock;
 	int err;
-	u64 ns;
-
-	err = pptp->info->getcrosscycles(pptp->info, xtstamp);
-	if (err)
-		return err;
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	ns = timecounter_cyc2time(&vclock->tc, ktime_to_ns(xtstamp->device));
+	err = pptp->info->getcrosscycles(pptp->info, xtstamp);
+	if (!err) {
+		ptp_vclock_update(vclock, ktime_to_ns(xtstamp->device));
+		xtstamp->device = ns_to_ktime(vclock->nsec);
+	}
 	mutex_unlock(&vclock->lock);
 
-	xtstamp->device = ns_to_ktime(ns);
-
-	return 0;
+	return err;
 }
 
 static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
@@ -171,24 +230,6 @@ static const struct ptp_clock_info ptp_vclock_info = {
 	.do_aux_work	= ptp_vclock_refresh,
 };
 
-static u64 ptp_vclock_read(struct cyclecounter *cc)
-{
-	struct ptp_vclock *vclock = cc_to_vclock(cc);
-	struct ptp_clock *ptp = vclock->pclock;
-	struct timespec64 ts = {};
-
-	ptp->info->getcycles64(ptp->info, &ts);
-
-	return timespec64_to_ns(&ts);
-}
-
-static const struct cyclecounter ptp_vclock_cc = {
-	.read	= ptp_vclock_read,
-	.mask	= CYCLECOUNTER_MASK(32),
-	.mult	= PTP_VCLOCK_CC_MULT,
-	.shift	= PTP_VCLOCK_CC_SHIFT,
-};
-
 struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 {
 	struct ptp_vclock *vclock;
@@ -205,7 +246,7 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 		vclock->info.gettime64 = ptp_vclock_gettime;
 	if (pclock->info->getcrosscycles)
 		vclock->info.getcrosststamp = ptp_vclock_getcrosststamp;
-	vclock->cc = ptp_vclock_cc;
+	vclock->mult = PTP_VCLOCK_CC_MULT;
 
 	snprintf(vclock->info.name, PTP_CLOCK_NAME_LEN, "ptp%d_virt",
 		 pclock->index);
@@ -214,6 +255,11 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 
 	mutex_init(&vclock->lock);
 
+	if (ptp_vclock_sample(vclock, &vclock->cycles)) {
+		kfree(vclock);
+		return NULL;
+	}
+
 	vclock->clock = ptp_clock_register(&vclock->info, &pclock->dev);
 	if (IS_ERR_OR_NULL(vclock->clock)) {
 		kfree(vclock);
@@ -222,7 +268,6 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 
 	ptp_vclock_set_subclass(vclock->clock);
 
-	timecounter_init(&vclock->tc, &vclock->cc, 0);
 	ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);
 
 	ptp_vclock_hash_add(vclock);
@@ -280,7 +325,7 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
 	struct ptp_vclock *vclock;
 	u64 vclock_ns = 0;
 	int srcu_idx;
-	u64 ns;
+	u64 ns, frac;
 
 	ns = ktime_to_ns(*hwtstamp);
 
@@ -293,7 +338,8 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
 
 		if (mutex_lock_interruptible(&vclock->lock))
 			break;
-		vclock_ns = timecounter_cyc2time(&vclock->tc, ns);
+		frac = vclock->frac;
+		vclock_ns = ptp_vclock_convert(vclock, ns, &frac);
 		mutex_unlock(&vclock->lock);
 		break;
 	}

-- 
2.53.0

