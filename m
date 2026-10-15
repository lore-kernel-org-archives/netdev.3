Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA4470124
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107228; cv=none; b=SnT6X4L7LL11WcyiErkZ3lF/HsE8jMVvA4ITd/mYgJ7ZUOAkV902/A1jJNN0bIq2m7Gjf2PkIm3Bx5lgRAdncdmMc6xsuZa2FkhLfgI+TTR9DMszl8S5TxBNRANyldx0GIzUd2XzbquJfPS3MlYKtiRlaHcG7rUNNlx3LI/CG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107228; c=relaxed/simple;
	bh=8fFNiipPoEYTI9kJgYaXWKF/L91RircxH5iKO4nRQKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2T6yzz1ea+hHinZk71OVxAleJXphOKY6wpwXBA6vU6IaXRe6IZsODaWmjM0pRP4TapWJoVAvSACU9q6fId2YcLsploOuLm81RVKuRynv0NFoBFRwejs/U8/qXpWwRnWhXO4tcmB0XtUCkYKvXW4UsbNmVyzmOkKHjYk+/y8YLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJeYv7o7; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJeYv7o7"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6dcf573c429so3734422eaf.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107225; x=1792712025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+fARNsD1Pjz/B72o/CPW4A26RynJA7qBILUXZsof8Y=;
        b=DJeYv7o7HwsWAd4Nhu0AsUfXl/YAqXjXNAl+yxeHvHxWkOZ9OYHeHl0pv4DE8IQj6/
         l8KrWyJBlAjZvK4fAxmI5zxr00LUCWw0SDTdtl93iCp5S+kVH3K63HkHjuLnJKDjXDck
         ZfkOrRxQu4zgpHKtKc+V0g1RYf089vZptJWIZlum5k+iYqXnOINbvKjpXOya5gduUCHI
         qZ1RM465ZBqYy2JcRjKmapA36BWZXytakiBprrlko7Y8muPZrtxFRIPZyQGdAc5OazOG
         fLHNA2HyFyWVt4hPBuVJxcibKr+MaV9m9XtfTNpjR6qnRJjbCxlWnKV0bv09CC+7/o85
         ORjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107225; x=1792712025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+fARNsD1Pjz/B72o/CPW4A26RynJA7qBILUXZsof8Y=;
        b=gijGjtREeo6qD4Vi5+g3AkqC/VfzFSo3codH1FKDO5kkert60ugstfATpUDB/NfI/2
         33bOZasoIh//B8g6Mw4LcKp4GV3fVpQcjDkm804ZyXEVow4vahk6fFRu31HEVgV+wDoM
         EPLk7I3q7Y6ofDlEQob2uJOGTWPJyLmXn/mNX3T2GZ0j+HIbf6sOQyayw/GXJqL1r08B
         tj+BV+FuVvHyiEsoGmsj8R8xuKAfSOZNUFjc1J64hiVnNKjlxOc3azK3ZKVW7FkeLO5r
         MRQrykg/ZW1g6Zs/Gz41sl5y4LOrXM0jzjjsj5qs836PWspUMqGUg8C6FAfWdMU0VfXe
         KIUQ==
X-Gm-Message-State: AFq9FYJd5D1h54IsR3yQm8O5WW/Runt0ATykAecrOmOkMKoBiay9srAp
	lpFeB7Gb1ypincfwcmDI9uFEe8JlrEYXH/wlECIuzoFkaJCqCNkRTlAxPWRWNKE+
X-Gm-Gg: AYBFou20Rwv76hJZXKyQfuUSvmQUiRUtp63fHn6DU5Q43vFYZKJhFQq0fbEH2KklOsV
	t82lwp5YsTO9Gsu0OWWPdTUmN7fTAcsB0Ubqc0i2IuJZ6/kAOZwt2h+n1zADXj1QldD+3eog1uZ
	2bGNwPCAkKQzi3F/qcqPs7okcneOIP+Rb+JKVMClp+1edJTa/mZwxA+oF3fmwcUwGYpZNC/YFiu
	QIL0/FUOFjSYQLGKIoiYw9RUnwtAj9JFht99B5PSYGONyirtIrdaI0Cxw3EptIjj/ONUchMvnVG
	68cVthH5E3eC+P8YKE0HaGYNhX5oxEQVm+hKciwiIs8772z3Yp8yInVTo9ho3ShZt0M0VaGVVuK
	STitHfCiXbd0eEYjnTN5d7m1m7ZenRvs8MxnfUnjV/VnKJIaJ4uwAAY83aJ4FuoDeQn0eTL2c8I
	fuaEH1wGhjVyheZDhYQr5F3PN0bTcvo9OAvxx2K/ojIkl4wnS5bMrx585srb9NlUGOQIkn3WOKb
	CkxehXiOzoOlu2bnKRtvM3r1bt3Scc1+UgYNMHO96Aw+StHwKYrwMvXdjUn7wYMF8IVahZS7o/G
	bdMWe28BRCqq8+fWbob6XhPWFbtOvSpg0+GxhWS0a+BtdwOMwl+XrswMcX+QeiVCavV0Mj6ZbH2
	takFG4hQTWyfMQ25dHq7RPkjHgN6y6m8c
X-Received: by 2002:a4a:ee10:0:b0:6ca:46e:b06 with SMTP id 006d021491bc7-6ef0f1b83b6mr14516002eaf.52.1792107225019;
        Thu, 15 Oct 2026 16:33:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70188bd9ecdsm525519eaf.2.2026.10.15.16.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:33:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 17:33:34 -0600
Subject: [PATCH net v4 4/5] ptp: vclock: serialize extended samples with
 counter updates
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ptp-vclock-sampling-v4-4-cba6ffc8ceb6@gmail.com>
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

The extended and cross-timestamp callbacks sample the physical clock
before taking the virtual clock mutex. A concurrent frequency adjustment
can advance the timecounter and change its multiplier in between, so the
older sample is converted using a different frequency than the one in
effect when it was taken.

Take the mutex before sampling and keep it held through the conversion.
Retain timecounter_cyc2time() and its existing conversion window. A PHC
sample need not advance the counter: for example, e1000e explicitly
allows non-monotonic SYSTIM readings. Treating a slightly older sample
as a forward delta would instead advance virtual time by nearly a full
counter wrap.

This race was found by code inspection of the virtual clock sampling
paths.

Fixes: f0067ebfc42b ("ptp: add gettimex64() to virtual clocks.")
Fixes: 21fad63084c2 ("ptp: add getcrosststamp() to virtual clocks.")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_vclock.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 5f49f81891ef..88161be5eabc 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -115,20 +115,18 @@ static int ptp_vclock_gettimex(struct ptp_clock_info *ptp,
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
-	mutex_unlock(&vclock->lock);
+	err = pptp->info->getcyclesx64(pptp->info, &pts, sts);
+	if (!err) {
+		u64 ns = timecounter_cyc2time(&vclock->tc, timespec64_to_ns(&pts));
 
-	*ts = ns_to_timespec64(ns);
+		*ts = ns_to_timespec64(ns);
+	}
+	mutex_unlock(&vclock->lock);
 
-	return 0;
+	return err;
 }
 
 static int ptp_vclock_settime(struct ptp_clock_info *ptp,
@@ -154,20 +152,18 @@ static int ptp_vclock_getcrosststamp(struct ptp_clock_info *ptp,
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
-	mutex_unlock(&vclock->lock);
+	err = pptp->info->getcrosscycles(pptp->info, xtstamp);
+	if (!err) {
+		u64 ns = timecounter_cyc2time(&vclock->tc, ktime_to_ns(xtstamp->device));
 
-	xtstamp->device = ns_to_ktime(ns);
+		xtstamp->device = ns_to_ktime(ns);
+	}
+	mutex_unlock(&vclock->lock);
 
-	return 0;
+	return err;
 }
 
 static long ptp_vclock_refresh(struct ptp_clock_info *ptp)

-- 
2.53.0

