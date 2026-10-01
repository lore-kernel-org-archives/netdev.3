Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140143DEB8
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790832995; cv=none; b=Gj/UpTAQaJhdM8uqgjPn7HW2oqZwtxHwQu5KUiNG9gszSIRmaTRhAP8p32+LF+69Sz0ce6z72FUPpvFL/TeLKLT8F2xwEqfb02g+x+aTE/QKMuP1pEnhYMQrM4+xLCOmY/8BlGiDxuhx4faqvA+al6jUpNyE+3V013/ak5cMhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790832995; c=relaxed/simple;
	bh=17IbOXgpu5qvWpe9DfmWVZGYpsQSD8J7hEMJ7OZBgJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rnb+UR1CSfurrbhhs77iCsu3cA6GKkSt0rrX3A97z7hBxJTvTUWdJUazVkQmnr3gpcEBcSOc8c2FFnSIJQZkWB5RVxyF5L5e0X6/afP+SZzBOJa49eZs7c+7WsIh3G6IU/HSwr7LgxmLZOfV5iAHoWOyxpFX7QxVqw9BW3ODmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApodtGjW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApodtGjW"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-8198a3a54d7so2318698a34.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790832992; x=1791437792; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ImG2NcKaeowgbT7GRdQdhpYB5WGVuiPpUhMg0VIHXxc=;
        b=ApodtGjWVsBnPYbVbKbjqd0gc89wGHVHRySRWHW+kpkKA5TwpkT+In8/v2Rowq2AZb
         GM1PuHgbUszsUz+WLSkJZAVyvZBL02Wug0v4XBl+o3gSydrEN7c2nVDxbde8irO9cskV
         i7sX8Fvhn+yENNllGnkXHKHL44cFkyiHawhwNYuRU71QfCU1uL4cMEqB9iEqYpwt5GSS
         51UlhmeTzfKF1pLn/oLy2r15iPd9vzaA9xXSxhzUjE46uN+xkYKWDrSUbRKx1izmNmIS
         Bj7O8kDxvEg9YK9zFYRc3+Qyj7lOzrHoLZosgmytgqpllwiTxrgDY7f+vrtwxBJ2KZYR
         J56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790832992; x=1791437792;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ImG2NcKaeowgbT7GRdQdhpYB5WGVuiPpUhMg0VIHXxc=;
        b=i+Jdb8sv9CLDWHHF6OpaKdtOCj7f6EKbz9s3H5o4n4g+uVyamI9bQmEkeOS8ogdgCM
         aOmSMnMLcwzavSGXrv7ArN+sGVDsH5XwvMnfijUUwWIweOm5zX5LIn6fzwCgKm1YcYpm
         fWQ+0S8QKfkk71A0w+IJndIl28IpHNRwOSLF6dXZsjlw7UuVQRUcwRuibevq9SlxNhwB
         JSaB6N5HbVJ+RHvNrZ9zgCbUk7gsMBaxxoqfpUpqpPksbxJ2iWYZm8b9o17PI7xVR8tJ
         DTDY96IYZna5hPpcKZ+9xVaqG+wmm1sXiNqlA7Xi6L+aotUc/fbD0zWShYH8proQkqDI
         ilLw==
X-Gm-Message-State: AFuF++nKfNjSBh5F1a+T4ZWAkqDWJhCVAP85Ea1MHf4YsiED/Ha8YCbn
	m6H1L0eHoK1K4gq+v9zT0w6vwdBgTdHAnwLv1F7JCa/9MM44laVVtHmy
X-Gm-Gg: AYBFou1TjHqenR7rDmjjYBPxH5mej7hYgqqB/vviwZTxI9CpBodjxw4ZAPKxvZWJBvH
	YmoBvfHGAHaoHsVbV3azgTQ4RdNhve49oWzHbARONv0AdS0m3XPu6TGOcPPkOarVkqRiRWnQWA6
	eDHGHegmb7jNWUC9iykUFBd2Iu1sB8vzYaLS1nr1Dc1yw+seTLOAr0UUriwk/gBH/+zr+rhe+oh
	3B5TViCW6C1NzlwrttLIFhKFVtq878rHShIpfCygljUiu9QHcJMQcOzepNanRIh3W5aYBcqEzyp
	ciODhxNSPSikc6O2kJfDmSGlo5PnnFDBK/FQrinWc0CGgjhKtG/aPSWwIUtsnNJ0+uoMaK7k94v
	WCyy3KpmhOXTT+AoFMuMjcmBfKzWWqjBu+ToqCo7605u1JVOaoArOfdcn6mKLNk/QHZcbkOQAma
	zJmO2c9KAEYftxrKb9lnZMoGfT/44VtKsXYJGnEElRgZMpAb0ic5U8ptyuYugs22sKvWn23pr7q
	Z3bQPfCcjGQ2Oh/oYJXxEDarMKCPJVoxrlb4CSuXGJYPlWORY6IKlpNM2iho7QNwPGbT3b+OhAN
	vZ0LvhPqabSV8ZcN8K8AIdvN0wZo7Vyhd1hlnRlgBWqdg3WDv+2JXIVg/k9/cIYLYzszLLkGbdN
	A2ydiKVtlhLGxXGUxg2E7Bg==
X-Received: by 2002:a05:6820:150b:b0:6d9:5232:1774 with SMTP id 006d021491bc7-6ddbb1b07cemr1677261eaf.28.1790832992092;
        Wed, 30 Sep 2026 22:36:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212a4139c7sm1860223a34.7.2026.09.30.22.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:36:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 23:36:30 -0600
Subject: [PATCH net] ptp: vclock: reject failed physical clock samples
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2N2w7CIBBEf6XZZ0m2UKH4K6YPsC6V2AtCbUya/
 ruN+nhmcmY2KJwjF7hUG2ReY4nzdEB9qoDubupZxNvBIFFqtApFWpJYaZjpIYob0xCnXliUwbY
 NtmQVHGbKHOL7u3qFiRfofmHm5+t4WP6Nd4UFzeMYl0vljA/Ou6aVihXV+uy9RGzINByCIbRaG
 +nJQLfvH4nkS1i2AAAA
X-Change-ID: 20260930-ptp-vclock-sampling-902f98408c93
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
virtual time.

Read the parent clock before updating or initializing the timecounter,
propagate failures from clock operations, and leave its state unchanged
on failure. Cache only the successful sample for the infallible
cyclecounter callback. Initialize this state before publishing a newly
registered virtual clock.

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
 drivers/ptp/ptp_private.h |  1 +
 drivers/ptp/ptp_sysfs.c   |  8 ++++++-
 drivers/ptp/ptp_vclock.c  | 56 +++++++++++++++++++++++++++++++++++------------
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index db4039d642b4..4ff22adda652 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -75,6 +75,7 @@ struct ptp_clock {
 #define dw_to_vclock(d) container_of((d), struct ptp_vclock, refresh_work)
 
 struct ptp_vclock {
+	u64 cycles;
 	struct ptp_clock *pclock;
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index dc398c6b7528..9c25d897be19 100644
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
index 84cb527f59cc..6378e9a8cd80 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -42,21 +42,41 @@ static void ptp_vclock_hash_del(struct ptp_vclock *vclock)
 	synchronize_srcu(&vclock_srcu);
 }
 
+/* Sample before changing the timecounter. Its read callback cannot return an
+ * error, so passing a failed PHC read through it would fabricate a wraparound.
+ * The caller holds vclock->lock, or has not published the clock yet.
+ */
+static int ptp_vclock_sample(struct ptp_vclock *vclock)
+{
+	struct ptp_clock *ptp = vclock->pclock;
+	struct timespec64 ts;
+	int err;
+
+	err = ptp->info->getcycles64(ptp->info, &ts);
+	if (!err)
+		vclock->cycles = timespec64_to_ns(&ts);
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
@@ -76,14 +96,18 @@ static int ptp_vclock_gettime(struct ptp_clock_info *ptp,
 {
 	struct ptp_vclock *vclock = info_to_vclock(ptp);
 	u64 ns;
+	int err;
 
 	if (mutex_lock_interruptible(&vclock->lock))
 		return -EINTR;
-	ns = timecounter_read(&vclock->tc);
+	err = ptp_vclock_sample(vclock);
+	if (!err) {
+		ns = timecounter_read(&vclock->tc);
+		*ts = ns_to_timespec64(ns);
+	}
 	mutex_unlock(&vclock->lock);
-	*ts = ns_to_timespec64(ns);
 
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_gettimex(struct ptp_clock_info *ptp,
@@ -115,13 +139,16 @@ static int ptp_vclock_settime(struct ptp_clock_info *ptp,
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
@@ -174,12 +201,8 @@ static const struct ptp_clock_info ptp_vclock_info = {
 static u64 ptp_vclock_read(struct cyclecounter *cc)
 {
 	struct ptp_vclock *vclock = cc_to_vclock(cc);
-	struct ptp_clock *ptp = vclock->pclock;
-	struct timespec64 ts = {};
-
-	ptp->info->getcycles64(ptp->info, &ts);
 
-	return timespec64_to_ns(&ts);
+	return vclock->cycles;
 }
 
 static const struct cyclecounter ptp_vclock_cc = {
@@ -214,6 +237,12 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 
 	mutex_init(&vclock->lock);
 
+	if (ptp_vclock_sample(vclock)) {
+		kfree(vclock);
+		return NULL;
+	}
+	timecounter_init(&vclock->tc, &vclock->cc, 0);
+
 	vclock->clock = ptp_clock_register(&vclock->info, &pclock->dev);
 	if (IS_ERR_OR_NULL(vclock->clock)) {
 		kfree(vclock);
@@ -222,7 +251,6 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 
 	ptp_vclock_set_subclass(vclock->clock);
 
-	timecounter_init(&vclock->tc, &vclock->cc, 0);
 	ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);
 
 	ptp_vclock_hash_add(vclock);

---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20260930-ptp-vclock-sampling-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

