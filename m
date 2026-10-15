Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60954AA402
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107228; cv=none; b=iMi7F8Zy+fqBsrj6LWa7C5T4mpg/ZsHc/dRDrFb5pPmO9FxKNJv/Gr3O3eHtQ9N8J1Nn1gUhGbABRAyS+BWpEo0ecPaRMcZ82SFNlrzY6igWe/RuKrGx7fz5A+9fL8z+/NGr7l/+rEdq1TKvsgPAz2bfJ5ZcxHanKTnmNcl12VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107228; c=relaxed/simple;
	bh=zeTuem/EFd0e5dPXUbBvOgo4KaTIpTu/O3JnA8vvJ6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnmIy3CXoEXx4HCjWMKHuwUUskD1jSrDLY0GvWwrh/qW4jOxGqDET+etqH6bGxJLFUZPh/F/cvwvK1vrQF/37pNk+oZPnKQMEBtGF4PiSj6pdlOPv+N6YScZALKvy4E8OzR9ZLPGmMOvHqCbJRdK13/d2m2cilnFsrnIKpNT7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdB0OL4Q; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdB0OL4Q"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6d290b10a35so2286316eaf.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107223; x=1792712023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWS9GelrPFPg86HBO/QEntBoFChHC1yKG7vt7gVjm0U=;
        b=qdB0OL4Qji2ZU92WJ3gK/VwQLi+4EqSnBoWXLwzXNNDZwiu0yxT6t2QXKqxM9dfFC1
         KWVAjQ34Q1UY9I+NOTAJvYFfpn5vk93u68burPsMF3lhtQRWsNR7Pc4O1d0tIsjfzmAb
         QagOqLJ3iako2Qu9WrVC+qYypxZlwdJaoF0rhQDAuhDLJeMcr/+4SrN1q/iqy0WPV51X
         96IEFT01ytLcZfA3TxiEbtxLChx6WwVF40cHwqO63mMGdUeFGbO4Co28FqhpLjmpS6b4
         N01IvBa+/MEJdQFWIRcbsrz+FlubAvpn7Y1FAuOt9dkpVVp2cKKPxWIjarHw8Rtd1Xuj
         xRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107223; x=1792712023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWS9GelrPFPg86HBO/QEntBoFChHC1yKG7vt7gVjm0U=;
        b=yq1dO3d/L5/aXcaVtyBE8J70PtodFHpgm6QwagUBMGgYRkEDcUb1/IlTQjJA09BmAM
         5gTpMCG7cn1Pigcr7wqfpxBW1UWGTmc0pW9SIIKfgnYkaTxCc/MQIEyNOUIsGUK+OCyZ
         KWmF6ctG+Jxs3CRlj79695ll9g+nRn5D4Dx8xTFbOJrB4MfcqZ12pb6O9EdKD3g1UObo
         OnhnRwThgqX+4NU89hHdb1KeHWUmUHElNIy8ycBZMfq0vmFpsm6mI3miH6/r9zttxtcX
         Ka3HLRSVaIhNZzv6RLYQIeCrO94burtnx5x+s/FR6tVUOc93S5vCvDr3iMJ/hBbMWJh8
         +uUQ==
X-Gm-Message-State: AFq9FYItHYYDiOV1rGhRQ97sMQdxDA15c5fchCZLAzObTUXavadEXN+4
	utvi3Ph6xJPqmJm7p8ZcUjdracH1ZVnx4kaNAaDMp8cpnt5N9h7t8sQu
X-Gm-Gg: AYBFou2LFRHHopY0WjpomVsRwPaL/btGHic8hkkR5bi9dfbat0IyjYdeZXSvOAnMldU
	MEPfQ26tDYGquurIsNcanLLl41+zjNlBB3TFZ0ADt24dPFa6qAmbfCLb3obVnbQNWRlpX66BPV5
	wa1eOpHI5OlGiNTgEWf7FUsNygd5W8tk6F+Wk96nISOeOXCpoAx6yhRGxsj5DhOjBMJGiEMSimf
	BLtUym7kZ0sfVx3RxchtZPr18gnV4XwcxDx/3FJmyDDn5jcEZ5E16fvQ33TZEOjpI+9APDwoYYo
	y8afR58JoxKLAbch7iT78+OcQhQ+ua2K8hA1agVz3dSnBFufSSPC6WbIUtxY1mRDNNYrETJgtts
	EznOaDT49cCtcgWKCqCoKOi8PQTFbuZip1B4a6z25aIIA6qvwkstXWwC2vkLa9mieIqfoVP0Bb8
	A0wzZUPfOlwkhuS2YMBLlJ0OYKX1edHFoHEzRzQYBA33CjfPgXZdZfBhVLGiStstjzYLsPTvIdi
	e3+IAwc5GHENVICLxPAiEKFljhXg4WmeT4whlj+DRy69ZDfA4+ecRQELbAaZ/JIPyJZfhcDEcEM
	4WnEXs8X51d7Haaw5b012c3YS2UY/NBTOxuvqNHy1vE5U1YZW9ilwOCVnUDP6VN1mEdJsQPRZcC
	eduv7RmXVQLj+gKO0uMq7szl35zgKIuMU
X-Received: by 2002:a05:6820:c95:b0:6d7:e3ab:14f6 with SMTP id 006d021491bc7-6ef0e6e532bmr14462959eaf.44.1792107222841;
        Thu, 15 Oct 2026 16:33:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70188bd9ecdsm525519eaf.2.2026.10.15.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:33:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 17:33:33 -0600
Subject: [PATCH net v4 3/5] ptp: vclock: propagate physical clock sampling
 errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ptp-vclock-sampling-v4-3-cba6ffc8ceb6@gmail.com>
References: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
In-Reply-To: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
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

Retry failed refreshes after 10 ms instead of waiting another two seconds.
With the existing 32-bit nanosecond mask, timecounter_cyc2time() can
interpret a fresh timestamp as being in the past once the last successful
refresh is about 2.147 seconds old. An isolated read failure should not
deliberately defer the next attempt until that sample is four seconds old.
Keep the normal two-second refresh interval after a successful read.

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
 drivers/ptp/ptp_private.h |  3 +-
 drivers/ptp/ptp_sysfs.c   |  4 ++-
 drivers/ptp/ptp_vclock.c  | 75 ++++++++++++++++++++++++++++++++++-------------
 3 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index ec8633126d6b..e389e0653afd 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -81,7 +81,8 @@ struct ptp_vclock {
 	struct hlist_node vclock_hash_node;
 	struct cyclecounter cc;
 	struct timecounter tc;
-	struct mutex lock;	/* protects tc/cc */
+	u64 cycles;
+	struct mutex lock;	/* protects tc/cc and the cached sample */
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
index 84cb527f59cc..5f49f81891ef 100644
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
@@ -151,7 +175,9 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
 	struct timespec64 ts;
 
-	ptp_vclock_gettime(&vclock->info, &ts);
+	/* Do not wait another full interval with a stale cycle_last. */
+	if (ptp_vclock_gettime(&vclock->info, &ts))
+		return PTP_VCLOCK_RETRY_INTERVAL;
 
 	return PTP_VCLOCK_REFRESH_INTERVAL;
 }
@@ -174,12 +200,9 @@ static const struct ptp_clock_info ptp_vclock_info = {
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
@@ -192,10 +215,11 @@ static const struct cyclecounter ptp_vclock_cc = {
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
@@ -214,20 +238,29 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 
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

