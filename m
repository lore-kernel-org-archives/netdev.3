Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038302;
	b=aEPxUMdOlSAPWDqfX+ovmVBkjnN7KrGgjQPrQPuqC3xLwx0RXeslXhHIo7ZNZb99cytE
	 5Ba2rcbeNurIpcZ31E995XjFTMoig5FXy9pqZAxRYGBR196kD7IrWKytrYQITBNBeFwKq
	 8kGAIMB4L4j6utalzdGaSfMRT5I6FGF46pVeLEu8ok616clW9lKw4elRGbtSP2rDp9xlQ
	 4poq5bmi5GY5d+hPdX+gsRW1A+1quoZXJeqKeBtt9HgliUqDUz/JbOA3lNrOLBACJV+eq
	 g1fG8t6Rl9VGYMN72bu4/eFFL5OxQLGgsEdiqOASws7Q3cCe5NNg1yCay6KAsN2hmMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=6ZhyrV+giTXiCslB1TgJVt4vJnRQL84X1XGCprRbUQc=;
	b=nPbcDlMFO59hv/kbrWO9qD10r9HSvI+X1fsNsF4DnPCkpYsvSRYU9MpODWVsuhPhDPut
	 tSVh/oeJk98SbO3Wa8lkbRdVF19SW0v/7ZbbmEWZRIG5C/OIiV1vk+Gonk21XAUEZRwWX
	 x3vs4wuBVs/mAxTDO4wlUaNw9i0OvAKjJ2hdzwW5NLM6WKCoXfeAbB/pomkie0dHDgNdG
	 7y/JTnqO5Ex+9JZs7jTuqW2faWD/5etIrXDMgiT/h2eWfhKLlD2kTB01xc2krBcCZb/cG
	 zsSTbsqv9QiQH0lmxyq9YC/OXDhEtgTEn/Bz7+fTi/Y5sxbaq7wRKn0zScddp+Zy+9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S+O2NkAP;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADE606A328
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68ADE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S+O2NkAP
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4c5d8c7f326so1284627b6e.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793038301; x=1793643101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZhyrV+giTXiCslB1TgJVt4vJnRQL84X1XGCprRbUQc=;
        b=S+O2NkAP/soYUFaQZE4qkj7hNmq6UEpIcofNkG5USRefQX/AUKoJLjEaIoFYVVs1gO
         8u9Ak6CkS0Cm+V3YKKvYmWfu3kbdjDPNGuoI+wunRLHCxPU23D0kCfo+syGL1b6manGc
         pWpVakadvNBT+Cbcb9GGbxqLalekQN1JA+dheQw/uaMA40WIgqh4wNIp/ZGQcQ8nr6R3
         +6AnMSIkWDFly8gtcXctHE1VzEAId2Me2UJuzF7/g/Pc9Zv/7KzDAWCmk/sscKbgC2L1
         xVb/V2SEr2qPn7UAo23451UHfOlkeE7nhgd9Nvm6oZtm0GkEuc12l2QjN6uF5eMVdAHj
         DRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038301; x=1793643101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZhyrV+giTXiCslB1TgJVt4vJnRQL84X1XGCprRbUQc=;
        b=wdWmWnbhiPy4FYgldJyatVZD4I93yxWA1XZjK2l3EdDLDNqao5BLwtfanOyCuQtVwx
         SYfQaEyz4kgmHO6KP7r7kZ+9QLpzl3rXYP9A/ORnFXALuJD60RDxhBPOpNqfDO4I2uAD
         bn8UESnmsZI4/3UA51tkDvqsVY02Yo07yE+UAdSWBdFgbtv+EExM/9nSXCLSSs+xuD9Z
         Sk2vXjSvfhSaw/a5ArvFarjJ57Lb6GJdAXPa0mIXOqGJ8vhETFiugcAImjyQRBGF8L+W
         ccs4/fRkM8lzstvBbh+Gg4kvAM4EG5vL+X4SlFlsPm0Py7ARcU0cL9QoUfB3e0wNhB4R
         K82g==
X-Gm-Message-State: AFq9FYI2bRAYKUb8zkjWKMwbuzH0ALBfxBBtcO2ic2pOww9X2e+w6dwI
	ebI7h+N3qdrXzGMh/jVHlHIZux7ErsB+gXTyBv+yzTT1C9RqCGzwd6jo
X-Gm-Gg: AYBFou06OgxkqX3p0TE8LbAlWj+Is4G5UgdS6ZkNJPqSoAftyInjY6iuDVt4ccMI7q6
	jjMmV2HzKZc19HuXmmwstTyOWHAxAMzrmM/KBzU4Di5gSI9zvZrIPxHtHwZ//1iLcDIxKs8e2JA
	bkHDc1eEvAZgqmnECafkCgGbuqqJAUQMoRlT6BrkN8vbo9x/4ceM9UiXvZHVWdTXN9ZeWtVP72J
	/ea6CGhyJ1z5gc7yOdoG/RhoeUmeZfWIn5rxNtcUG3Go1/VsinnvoX5+itx75uPi+Y9toshZXMo
	2Jc5h9/Kov1sPVkztHdRzwaWYHK9NpDKlYGKjcyY46KQ7FFA/RaixMtoV6u+6IuExiBV78UFGoP
	SU1CW3IWd+bEqG550Xi+mkTDVmC21q9dNQ4bJwZefMs6ovlZJ+Ykq+JrxIx/xPotndmVt/fCt0E
	y+YX3FS9YKzVI5DDOlXQvUDHfRWNpNBHYjCV2tP9zZSSxAdcFiP9j2RRzd65wsdeCdssRxd7kg5
	7fdELTOCiCxDkVwUqygAO0CAmyl8y/dWOKR2WGwdmiKhRC9ezywR9IUYTfcJbEJwU6YCSNeWBXs
	qswF1zGcAteOazs7okyBVQVU+FjQnyzvhdu5NB16w7ooYP8cAyGuNHKsRCKqXD65EgbjNwkneWU
	/CHiojcq9ghsL1tmk2jItVhHEKX2kesqm2CY8vcu15/Gf6xl0lfZKGlwL3WvAU3P4yJVN+edCOw
	Q2jvg=
X-Received: by 2002:a05:6808:2387:b0:55b:f890:c1d4 with SMTP id 5614622812f47-55c003074ecmr4768788b6e.29.1793038301188;
        Mon, 26 Oct 2026 11:11:41 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c043115bcsm5795251b6e.15.2026.10.26.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:11:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 12:11:29 -0600
Subject: [PATCH net v6 3/5] ptp: vclock: propagate physical clock sampling
 errors
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ptp-vclock-sampling-v6-3-e705612541f1@gmail.com>
References: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
In-Reply-To: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The cyclecounter read callback cannot report errors. ptp_vclock_read()
ignores the return from the physical clock and consumes its output even
if the read failed. A zero sample followed by the real counter can add
an extra 32-bit wrap to virtual time. This was found by code inspection
of reset-time PHC access and the virtual clock callers.

Sample the parent before calling timecounter_read() or timecounter_init()
and have the cyclecounter callback return the cached successful sample.
On failure, leave the counter and frequency adjustment unchanged and
return the PHC error to the caller.

Retry the first failed refresh after 10 ms instead of waiting another two
seconds. With the existing 32-bit nanosecond mask, timecounter_cyc2time()
can interpret a fresh timestamp as being in the past once the last
successful refresh is about 2.147 seconds old. An isolated read failure
should not deliberately defer the next attempt until that sample is four
seconds old.

Double the retry delay after consecutive failures, up to the normal
two-second refresh interval, and reset it after a successful refresh.
Each virtual clock has its own worker, and a failed parent read can involve
bus traffic and error logging. Backoff limits that repeated work during a
persistent failure while retaining a prompt first retry.

Limit each retry delay to the next regular refresh deadline. Otherwise,
backoff can skip the next two-second refresh opportunity and lose a full
counter wrap even when the parent has recovered before that refresh was
due. Advance the deadline when an attempt reaches it without resetting the
backoff, so sustained failures still settle at the normal refresh interval.
Keep the retry state private to each clock's auxiliary worker.

Take the initial sample and initialize the counter before publishing the
clock. Return an error pointer from registration and propagate its errno
through n_vclocks, including when the initial sample fails. Queue the first
refresh immediately after registration so registration latency is not
followed by another full refresh interval.

Keep the existing cyclecounter mask and scaling. These scheduling changes
do not guarantee timely samples: prolonged read failures or worker delays
can still exceed the half-wrap conversion window, and a gap of about
4.295 seconds between successful samples can lose a full counter wrap.
Do not assume that getcycles64() exposes a full-width nanosecond counter.

Fixes: 5d43f951b1ac ("ptp: add ptp virtual clock driver framework")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_private.h |  6 +++-
 drivers/ptp/ptp_sysfs.c   |  4 ++-
 drivers/ptp/ptp_vclock.c  | 89 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index ec8633126d6b..99e7eb241336 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -81,7 +81,11 @@ struct ptp_vclock {
 	struct hlist_node vclock_hash_node;
 	struct cyclecounter cc;
 	struct timecounter tc;
-	struct mutex lock;	/* protects tc/cc */
+	u64 cycles;
+	struct mutex lock;	/* protects tc/cc and the cached sample */
+	/* Owned by the auxiliary worker. */
+	unsigned long retry_delay;
+	unsigned long refresh_deadline;
 };
 
 /*
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index fabc1c9b1752..026220b112c2 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -224,8 +224,10 @@ static ssize_t n_vclocks_store(struct device *dev,
 	if (num > ptp->n_vclocks) {
 		for (i = 0; i < num - ptp->n_vclocks; i++) {
 			vclock = ptp_vclock_register(ptp);
-			if (!vclock)
+			if (IS_ERR(vclock)) {
+				err = PTR_ERR(vclock);
 				goto err_register;
+			}
 
 			*(ptp->vclock_index + ptp->n_vclocks + i) =
 				vclock->clock->index;
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 84cb527f59cc..b97f3a877260 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2021 NXP
  */
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/hashtable.h>
 #include "ptp_private.h"
@@ -13,6 +14,7 @@
 #define PTP_VCLOCK_FADJ_SHIFT		9
 #define PTP_VCLOCK_FADJ_DENOMINATOR	15625ULL
 #define PTP_VCLOCK_REFRESH_INTERVAL	(HZ * 2)
+#define PTP_VCLOCK_RETRY_INTERVAL		msecs_to_jiffies(10)
 
 /* protects vclock_hash addition/deletion */
 static DEFINE_SPINLOCK(vclock_hash_lock);
@@ -42,21 +44,39 @@ static void ptp_vclock_hash_del(struct ptp_vclock *vclock)
 	synchronize_srcu(&vclock_srcu);
 }
 
+/* The caller holds vclock->lock, or has not published the clock yet. */
+static int ptp_vclock_sample(struct ptp_vclock *vclock)
+{
+	struct ptp_clock *ptp = vclock->pclock;
+	struct timespec64 ts;
+	int err;
+
+	err = ptp->info->getcycles64(ptp->info, &ts);
+	if (!err)
+		vclock->cycles = timespec64_to_ns(&ts);
+
+	return err;
+}
+
 static int ptp_vclock_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
 	s64 adj;
+	int err;
 
 	adj = (s64)scaled_ppm << PTP_VCLOCK_FADJ_SHIFT;
 	adj = div_s64(adj, PTP_VCLOCK_FADJ_DENOMINATOR);
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	timecounter_read(&vclock->tc);
-	vclock->cc.mult = PTP_VCLOCK_CC_MULT + adj;
+	err = ptp_vclock_sample(vclock);
+	if (!err) {
+		timecounter_read(&vclock->tc);
+		vclock->cc.mult = PTP_VCLOCK_CC_MULT + adj;
+	}
 	mutex_unlock(&vclock->lock);
 
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_adjtime(struct ptp_clock_info *ptp, s64 delta)
@@ -75,15 +95,16 @@ static int ptp_vclock_gettime(struct ptp_clock_info *ptp,
 			      struct timespec64 *ts)
 {
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
-	u64 ns;
+	int err;
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	ns = timecounter_read(&vclock->tc);
+	err = ptp_vclock_sample(vclock);
+	if (!err)
+		*ts = ns_to_timespec64(timecounter_read(&vclock->tc));
 	mutex_unlock(&vclock->lock);
-	*ts = ns_to_timespec64(ns);
 
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_gettimex(struct ptp_clock_info *ptp,
@@ -115,13 +136,16 @@ static int ptp_vclock_settime(struct ptp_clock_info *ptp,
 {
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
 	u64 ns = timespec64_to_ns(ts);
+	int err;
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	timecounter_init(&vclock->tc, &vclock->cc, ns);
+	err = ptp_vclock_sample(vclock);
+	if (!err)
+		timecounter_init(&vclock->tc, &vclock->cc, ns);
 	mutex_unlock(&vclock->lock);
 
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_getcrosststamp(struct ptp_clock_info *ptp,
@@ -151,8 +175,24 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
 	struct timespec64 ts;
 
-	ptp_vclock_gettime(&vclock->info, &ts);
+	/* Retry transient failures promptly, but back off during long outages. */
+	if (ptp_vclock_gettime(&vclock->info, &ts)) {
+		unsigned long now = jiffies;
+
+		/* Retries must not postpone the next regular refresh attempt. */
+		if (!vclock->retry_delay || time_after_eq(now, vclock->refresh_deadline))
+			vclock->refresh_deadline = now + PTP_VCLOCK_REFRESH_INTERVAL;
+
+		if (!vclock->retry_delay)
+			vclock->retry_delay = PTP_VCLOCK_RETRY_INTERVAL;
+		else
+			vclock->retry_delay = min_t(unsigned long,
+						    vclock->retry_delay * 2,
+						    PTP_VCLOCK_REFRESH_INTERVAL);
+		return min(vclock->retry_delay, vclock->refresh_deadline - now);
+	}
 
+	vclock->retry_delay = 0;
 	return PTP_VCLOCK_REFRESH_INTERVAL;
 }
 
@@ -174,12 +214,9 @@ static const struct ptp_clock_info ptp_vclock_info = {
 static u64 ptp_vclock_read(struct cyclecounter *cc)
 {
 	struct ptp_vclock *vclock = cc_to_vclock(cc);
-	struct ptp_clock *ptp = vclock->pclock;
-	struct timespec64 ts = {};
-
-	ptp->info->getcycles64(ptp->info, &ts);
 
-	return timespec64_to_ns(&ts);
+	/* The cyclecounter callback cannot report a failed PHC read. */
+	return vclock->cycles;
 }
 
 static const struct cyclecounter ptp_vclock_cc = {
@@ -192,10 +229,11 @@ static const struct cyclecounter ptp_vclock_cc = {
 struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 {
 	struct ptp_vclock *vclock;
+	int err;
 
 	vclock = kzalloc_obj(*vclock);
 	if (!vclock)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	vclock->pclock = pclock;
 	vclock->info = ptp_vclock_info;
@@ -214,20 +252,29 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 
 	mutex_init(&vclock->lock);
 
+	err = ptp_vclock_sample(vclock);
+	if (err)
+		goto free_vclock;
+	timecounter_init(&vclock->tc, &vclock->cc, 0);
+
 	vclock->clock = ptp_clock_register(&vclock->info, &pclock->dev);
-	if (IS_ERR_OR_NULL(vclock->clock)) {
-		kfree(vclock);
-		return NULL;
+	if (IS_ERR(vclock->clock)) {
+		err = PTR_ERR(vclock->clock);
+		goto free_vclock;
 	}
 
 	ptp_vclock_set_subclass(vclock->clock);
 
-	timecounter_init(&vclock->tc, &vclock->cc, 0);
-	ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);
+	/* The initial sample predates registration; refresh without more delay. */
+	ptp_schedule_worker(vclock->clock, 0);
 
 	ptp_vclock_hash_add(vclock);
 
 	return vclock;
+
+free_vclock:
+	kfree(vclock);
+	return ERR_PTR(err);
 }
 
 void ptp_vclock_unregister(struct ptp_vclock *vclock)

-- 
2.53.0

