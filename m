Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682218;
	b=Wc/Msr4ayLJHGqOacorohiZfPfK4Ub6i2l71z9lA6BRLTVHOST27w9X3HQa87+nGIHAQ
	 xXmPrfPiu4yDKJL/NbMAJBo2W8r8gtns+aYd4IGUwrZMWjB0friqd6hev5H4ZzaouAmCe
	 Hf2oeS+cyYFIDcFfdpxgPx/aDnaBnHjgZ5GzgAJdFLkFCDvBBRtPLZbbkJ0/HHEvtMSsW
	 IlyxB630LjSZJvi4TAuy8tBKLyJT33gpNXC6bZFQjRW10Ta23CflHoPT8SMR18xn2RvnO
	 zf/fDHJfPki4Pl3SfmOsjnvrVmxO9TxYJCBnK5IMUYx/7FRDb1NTl7ihsTz4mYYuqYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=ArZTwUoXYzov7eHPXGfSS3R5PEo5sgxcCtm/GX7TEww=;
	b=jSMh5mreO9yLQjU8QA41rAFFzqhqv/iV9m9aYfvrA65HoGEsB5OUEMuL2s3XMA72/TeB
	 gIIocsZif2ECNnrtuuUlYFaXK/KlX3+wtFv/u8lc5mDgrujQ7wh9zczeT0oLL3V1n0e7b
	 7SbRXZAFrrqjgUDrXhoGJoW37MkVUT4q5GxilglF932E31h+pt5szLpX/GFKuRBttehEM
	 cCHtlM6VPE81HvcO7J5CFdXMBDglVH79gdQfJ7tWFe4SeMkP7H4D4VoP4ESyf41zpmz77
	 uFJvxRbUk0ZQ/1zLD6boJLkz5iiTfTuZfUzhwkcJoRwYekl3tb/bkFce80TERUA6jKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pxAnD+jc;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712A606B39A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8712A606B39A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pxAnD+jc
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-47b47de8b4cso1151772fac.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682217; x=1793287017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ArZTwUoXYzov7eHPXGfSS3R5PEo5sgxcCtm/GX7TEww=;
        b=pxAnD+jc1lOVkSXjBuFvtopiKYPsS54zOLQbTxN/OOJM6oBZiH2/s6AOqwjfvltOX3
         v57BjOSJk9hYe4bHqvTDMjnEKuN+g9vBhVZ77RRgqa5l4HFRzWNASUW7HMK+9hrNgZeR
         GcAd3xpxqlSLBLl+hgXOhXzdzZgN0nC+v+iJxt9OHWZ4B2+AtAKl7Q3F6ga7IJJqh0lx
         HnEYhCnD06A3OmR1Da3DldTC9YbFg9JNLlCVoPsMm+zNcXG5nQZwGaiknf4OV5aeHudo
         is6kHqdhSjHcQg8PdsJYJNyFmbLzcpomOo51GE3NNh54Iw06Io1kVpNT56q12e8Z3Nbd
         C2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682217; x=1793287017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArZTwUoXYzov7eHPXGfSS3R5PEo5sgxcCtm/GX7TEww=;
        b=QpKcm0eghpLdActlWuTX2UZInFXbfy4iBNVgDN7cC8f9fpbuXv34VHQ6AZOARAVvDP
         DNs6KO18WKjfNWLY196MF1G8PEBuo3qz1pZJ2Zlq+G8D4TMRoQxMU+1a6S8fTTytgbmA
         odHk89UdmucGd/aWdClhQZeTPSJPpJEPDHlub4uKczh8ufvuEP5ziCFRBQL8P09EbmlE
         cGLzm4voeemD43Q/ABDbTkmhnZB/AqVO1OI/RxI5nHOEj/vwydNhfutqXVFZxYPKxfEy
         C3r8LJacL4fVJyyjn2gdPcENrM9okUyeL62IqPec3hsEZ9khouavQ1cngMT4pxVAYnbW
         rOlw==
X-Gm-Message-State: AFq9FYIS79OS6QtBYn2228o7MOFIoHTdGfcJDEaw3aJdz5hFtVn+4OnT
	vQUyksu0buIg+89TwanTGrSwXMY0ZI5v78R+/DZn3JV9VECNqKKK4Y8+sj7uypba
X-Gm-Gg: AYBFou0rjQ1LGSwub2ynraYFL+W+43sK4AYLzTjDt9zDMb4Ybc1lQwlW0BIfp3mTpaL
	J1LWzll2VYs96eJFhYgtPOCM2ZHwXvFpd7tzTLag1+sbmUHXgBwJs5fqVAdbCiOpIWqu6MkaM92
	ZCSiTafz1CLT+MDmGWfsC9jAT0pPg5On8tbJi+RCwuO7+8sOGfqzBbJnklvFn3K9EhcNsU/VD/b
	erjh9pLK25H7XJ3/O6QgCeQPzrrQyki5UH/lJLg32fL45wLTjtsDmgh4dZU1QcsIwhSamgHVjsi
	O9NZUIyBkrjyGpESwGSaYt/NBjmsrDynfwS0DZ5m3Okg/vd8piskKe0hBIM7YIjS3RqZd3dFS28
	Lo93g5kRYtJcW23rl20u9HVQcSaag2iz27ZL/PeyTnCI4Oh1+aiSaUsHIEeh9I3CyuexW1+c/jM
	t13x2lMI4nmpyBs0Imhm6ZhLk/69gclkdQOeFkkXVxbYA0exU3cUc7+UTrBXP9WZuSeIez7ks3o
	/NVtZD2Xbn4N7Rj40JS2sdHeE2ydexbPF/YtwwBwWWPlGh/Ju3GOHBXizEoa2OHmRPmyuhl/tqr
	dpgBCYaU7+SdSb9L0a4/qOzZRy7c/BzdporXaI4M2//yv5JT0Vk0WdQDncN+V+U9o+xlqSBJtlb
	FmobsbucijEO+z1tNXFF4qkc4XCzbAOVp5YDVw27ix0P4PnV0OcJ5U4nNTVI+VYKr3f5fct+57m
	LL2g8=
X-Received: by 2002:a05:6870:75cd:b0:48f:e3d4:d45e with SMTP id 586e51a60fabf-4a7dc2bb1aamr4035590fac.61.1792682217381;
        Thu, 22 Oct 2026 08:16:57 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5eb8fc0sm4685631fac.1.2026.10.22.08.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:16:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 09:16:43 -0600
Subject: [PATCH net v5 3/5] ptp: vclock: propagate physical clock sampling
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
Message-Id: <20261022-ptp-vclock-sampling-v5-3-06ceace17bac@gmail.com>
References: <20261022-ptp-vclock-sampling-v5-0-06ceace17bac@gmail.com>
In-Reply-To: <20261022-ptp-vclock-sampling-v5-0-06ceace17bac@gmail.com>
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
persistent failure while retaining a prompt first retry. Keep the retry
state private to each clock's auxiliary worker.

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
 drivers/ptp/ptp_private.h |  4 ++-
 drivers/ptp/ptp_sysfs.c   |  4 ++-
 drivers/ptp/ptp_vclock.c  | 83 +++++++++++++++++++++++++++++++++++------------
 3 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index ec8633126d6b..9c458c2d50de 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -81,7 +81,9 @@ struct ptp_vclock {
 	struct hlist_node vclock_hash_node;
 	struct cyclecounter cc;
 	struct timecounter tc;
-	struct mutex lock;	/* protects tc/cc */
+	u64 cycles;
+	struct mutex lock;	/* protects tc/cc and the cached sample */
+	unsigned long retry_delay; /* owned by the auxiliary worker */
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
index 84cb527f59cc..c10eba6443f9 100644
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
@@ -151,8 +175,18 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
 	struct timespec64 ts;
 
-	ptp_vclock_gettime(&vclock->info, &ts);
+	/* Retry transient failures promptly, but back off during long outages. */
+	if (ptp_vclock_gettime(&vclock->info, &ts)) {
+		if (!vclock->retry_delay)
+			vclock->retry_delay = PTP_VCLOCK_RETRY_INTERVAL;
+		else
+			vclock->retry_delay = min_t(unsigned long,
+						    vclock->retry_delay * 2,
+						    PTP_VCLOCK_REFRESH_INTERVAL);
+		return vclock->retry_delay;
+	}
 
+	vclock->retry_delay = 0;
 	return PTP_VCLOCK_REFRESH_INTERVAL;
 }
 
@@ -174,12 +208,9 @@ static const struct ptp_clock_info ptp_vclock_info = {
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
@@ -192,10 +223,11 @@ static const struct cyclecounter ptp_vclock_cc = {
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
@@ -214,20 +246,29 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 
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

