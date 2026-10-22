Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682221;
	b=MVORVFlvC/wtMjY3dH4lU9u+BXG9d9OiXie9HS7Sq8rp6j7ss+eR9WmBQo/9hNQ9MxEI
	 fnb4T5y6/iiFH9W0x2OYoPYbZXkZmOXKIrWWJZe2DlFlShNOfdf8BaW6LyxSKxkZ2r8CI
	 2Yrsp8YncNxBWEiaiL45Q5Mt9t1MrT+wS0bVbReupYaDpeGsF3PvsijupAdZiAgEiP4nO
	 9A1PtKfdCzcgmAT0r87lJpma/88JuFn9Y1XPdV3/kCSGtMcw0O84jV1VB6egi13gq2zC7
	 lm+AtRjdUNDqkIMIw3R6IQGCUoqpCFjlStZv5FfvZl2zf9AaUUbi+IIhyRXaNKF+G0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=jDEb6h8puAPE3QoM8kSfzOL4afpqMiINRrdEonSGo6c=;
	b=u+dL8dh3M/4wbOOSSV9LAbkUYpd8DaNeIkidbdUMiD7BV89RNaXrMmWqoFmGh7FQs0kh
	 kG4WHzPiHyz3GOxHY39QntdNgEyoZGJ+M0VpSMa7Mq2k8b5qT2QUsNsUI2a9v6sgGn3pC
	 nkt0zAW7e9EGgj+yFXo8VxZ9xYblEsiM9LXVbcsSEB+vehsaabqeDMQYMvPLB5ljeZjXm
	 cxndRN+9jNDSeYWDUrrOtADlYgxsu+MlTXUrVLcgXVpRMoAQht9jCpaDs04PK2AufFk7p
	 ftfepAzYTkGCSUSX0AxtntViirqYv9Zm0IIa4WqSvK5agGLVjx7utKbRk7+oTmCz1Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mElLrz1D;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C34606B3AA
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C34606B3AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mElLrz1D
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-704597ef1d8so883178eaf.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682220; x=1793287020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jDEb6h8puAPE3QoM8kSfzOL4afpqMiINRrdEonSGo6c=;
        b=mElLrz1D0tMQTj8eeBUtaNFdVWOi1zEYMq1azUxAqmnnAvs5XpTFgfKlUlOZu3shM7
         7H1rrFEOlcWGvHPIcnOLZ2RXyKpklWvmFPSnagd+TYKMfurUTzANwrM498DKbbOTRYTz
         wHLoBqAcx65ETDcEgIBAoR3IlFHGQWanuQ+RF21DTNlCDIbQTu83W8UIms1khS7LZwVQ
         iRgIrR2Gl3KiEQZLWaMmLV82gZnuGR9zUQjRHCjnOtsM5lsinUpVLjPXVhovcz8AfVbR
         mH+H+GjNgparOncAnS8FCcT+WKec12jDCysFyzbhhqUM5RUgXSCLYDoSuvugB6STkPZV
         gBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682220; x=1793287020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDEb6h8puAPE3QoM8kSfzOL4afpqMiINRrdEonSGo6c=;
        b=YO1/NS7ji9nPaB831aUcHED98SxqPzF7LDGO2f5XYM3/vmTy0fqJLCDVszf2AJf5Es
         YjnGOV8ThGdI6ibCdlVGiPTFO+nP6oEqufi+scCZmuIagMBraPqdcUmLU7Is6vAoh8Gf
         uEFLUHCKXdSROmYS5NhvJQ2lW1EqACFZgJfE1ZWns1lFRdvJ+vSc2w9gpY5GtXylZs4L
         4i5DN51onP8zO8ofdHZ3/Rl/RS5sliIG2PTfcxUec3hRuLS/l3Ecc+BR0J1D7uCYWobh
         R93f7bfjEnvlnTNntFWV2PcbyHgjHfbEiDdZ0Aq/ARPJ/oRBD5PgtyCcUqGBF+Bjkntt
         vHFw==
X-Gm-Message-State: AFq9FYKLYfqrtobvmL8b75GUSonCReZzTs6uFQtbeagzxzF4S7n826gB
	KBfIen6H7B1VlXt73FCOvT0wPukabIu/beXigiylHMrIBR4AZHLVIkwc
X-Gm-Gg: AYBFou0DJNdiMWmK72i1rkzDxjgpwqcIyIM4pBdkvlLXzyKa9dCa8nr7krVVb1T/gjD
	whguC1bgGH4NzFJUD5PR44pR9dsOSnM6ukNEVjkaNawJLitl9uWHGM3KeuT33h7uZx4uJEUGoc4
	xVpbGTk5nXonp/yScdfSvpe8HzAYSInGLMdXT+nE/xeT2fLEUBUVVNwP0/nYTOaIBjlyLO5iOa/
	+WtrpNXgPltoSa7uwZqUXr5FchWVd5yn+2a65lplmDbD4/8u3CS8psNKp4bDNRBRirhmzowi5br
	kC22gL9kBhJ+AqzaM1A4EzCpkvfh7h4zgrjSeFtBIvmyqpXZNzkHoIZ/WqmGkU5qyVOP10KdyWT
	C3gap9GWv4N03Ek5xU+r7WeI5o0u9FhszIMETyXLWgjYad/fW0Wj7FfOEt+GB5lG0Xc53ubhZ69
	gQ43v0LW8TFXlBPMjE0CDG0nfRjYjA10ORP2eOHZvlTyO0XW3xEHLN+CAkYLaSUXRykrEzfvzxH
	ytzqQv7IGMXMF+SbmBHpRJJnxm5diFQNoKybtzTW7YDs5xKBnZ3BR60a879UiXFvjVUEQmg/OEx
	e9PUPPpIfhe+y3S+gn5Uqow1vr8FQg0EcBaCldB2TbZzr4fzhCwM0XeWs4dia5/5RwOlrtl0qNL
	/iTdcpCilJruBPs6r1XxetMeDHEFTj18BXAOOML1Mh/dTPsB1j5TKUdKLVM4xectmkKJt+fluqh
	+Lpey+0tU/P37CKcUNJb2ivUH0
X-Received: by 2002:a05:6820:4b8d:b0:703:27e0:356 with SMTP id 006d021491bc7-7094283046dmr3279957eaf.73.1792682220019;
        Thu, 22 Oct 2026 08:17:00 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5eb8fc0sm4685631fac.1.2026.10.22.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:16:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 09:16:44 -0600
Subject: [PATCH net v5 4/5] ptp: vclock: serialize extended samples with
 counter updates
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
Message-Id: <20261022-ptp-vclock-sampling-v5-4-06ceace17bac@gmail.com>
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
index c10eba6443f9..4e98f119de72 100644
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

