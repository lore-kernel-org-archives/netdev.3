Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038306;
	b=BdbCBf6kRU9VnieorGpIHjZDPFI1pgnoCuNh/iwUFCRPc7M+WmmwsCX/QNk4UBa50EUh
	 9i7AnvzbTiSa0jaRggUAGyWvG9CDVd7/NtJ09j6uI1SGZzbu+Pf4ErnYszKMXk0MwzxMk
	 utrsXSpCCkrUyGqPCh2mzTP+YiQa7fJKJF7+j23Vl3uN/PNNfYZVCPctaqNvVdtz1sakJ
	 2wJJWb1qQaF746o3hHnoNSBoA59Zmo4bhpbVOBlxiOt8eMcfZ4XW3y7v0LpPJM+gSgUn8
	 DA9+CcDyLcSjS9xKS9vZhyaFKpOvu5TtEahajrvJxpLITX09D4E8pqOcub/2hgJi/Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=bOkoHWGuOpgRmWACFRvEzWssB8GJAemNp1/k5sDiugU=;
	b=vB347NpxA9++1HQ8DVP7DnTKlmMWmHmLG0txdpsmMx7yjXQjM5e9upihSsWIZWmZeSwI
	 fh2VnX6zMYU6X0WFx8v+GP8aRRr5KQFWpJrY2uCoEfWnr34I4wvytnzWmeTnKzdTruUiU
	 hGgqcPvn00XUNCrD91M9IHA+IRz3Hs0zhaFV6TDQT0hLfi36pje8otTB0Onnvb3gpFRo2
	 efv11XqZ8WCPPFf2sre07id4E7vCYHDQqLJhx8d1TRJMAAWgOlurfrzemO/agdj52qaOd
	 Rz2uVEL5+nzfN6f5WwmR29hBjG5QPmsPetF5hjiwwxpbp9nE37uvC2vSq3ZAK7S6/5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rHRIvoVx;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A546606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A546606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rHRIvoVx
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-53ec2cc397aso2405098b6e.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793038305; x=1793643105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bOkoHWGuOpgRmWACFRvEzWssB8GJAemNp1/k5sDiugU=;
        b=rHRIvoVx8n1PVA4udVrpzyrWFGucX36ATP9DDKkXQ4v8oGM8tdl5k5v/sXnFXWqtuK
         FW7bNPLBP7NpjdSGK3SPdjayzMSxXGwwcmcJ7yYFJcwEU3T8yIp94HF/wzBym814dj1D
         g0DwdVcD+V1RhdCt2Z6+nxLDWR+mhsCeYWDSXFqswsng6zfCdzekUgMeiinY1cAI3ws9
         P/vLudHni14pkiygiD7Zo2gVg0CMKZi9W59SPPZCc3YAE0goWGR8MXL8xKHJEF0PC7vy
         s/KDDO+k9a/+dSxIEXZJagmLXZMgdAg/+quMzASIVOtHIlSLgmxlzqj2ZhYlkrgRiNlk
         XQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038305; x=1793643105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOkoHWGuOpgRmWACFRvEzWssB8GJAemNp1/k5sDiugU=;
        b=TF0gYlxHBzwevf3wRUkge7Ok2W339cdOI0vHpjDJVyqswKBUedsMf8SS54+V4e5+dI
         enbgF3UsvSIA0pJ4EEbwdpQKPn2M2KI5+6i1TzWjjtHHBvzA13xIjFlUOhIwtDpChVmH
         pbuvEbYwUvxkUtyyCBcYART9He8ISHA64Y+sofFAtF1iWDPskLQ1ZTZ/WXEU4ILtsfIb
         QVgnolfOXuzx8Hduh4k2RzcVWq4XZ6s98eIooO3R7VJ8xR6k5dPC94N245gZKuraWnHP
         vO23+iQh6AV40PpWUALqikZ/AmnqbD6SqGvhfLgr+kRSGNaFOIi5slw0cITpk33H4Zp+
         clzw==
X-Gm-Message-State: AFq9FYJcFVM98i+coZAYZcOidySNFe3D4l7ibZpPX356XfotjgBhKVdi
	j7pKZxBmcJ3EdewTEBazZkuOXqTSRwyYPjoZzxtWMvwxE5arFP3INnYM
X-Gm-Gg: AYBFou1GO0K44LRrKZAzxmAlYxEO5SyNmTDngwBVxuZzcE2yvRTAnf3Bd3rmbSbHaff
	RNRAX7D9U4cyqQUCCeNgziVtbC4qZ45M9xTPMtPs/Onhi4T08eODIQNNQwfFoZGPzF1GyKhcXqR
	6qFN1XgkyMo2YpJfz+WKuK8RY4VhpCmmvFchHMA5gyEb7UMjlODT5P9vPCiKpy+gLhp6/l9nYjn
	UbHQGiSVlnZLOahnp1rQZcZuhZLgZxKnS49P+ZytkkZYUc7WE51FJQo3fxQzfiClpG9D9e3yMnr
	UrxzIPg0q/RjUDkKllhzEaP6gq82yxTXAcNu6WkZWhoEWYks+36MTm+8rYO/ulKnTIUUXUPB+Bb
	pLVbxZIHf1PrtOrTL0cK4x9nZ5PXbvUuD+5LWvsdq11qfk/FITcgL1NvflQX5cf8RjLu9BUbsTC
	1bZUfZ/e1U/p2GXG72vYCIjJ7YXRotAx/JMFnNpVDqMjxSalOywPps/M03stVJo7w9mLqyKWnSZ
	G3T/fphiZLsPtVT3cFds6S/pXtSvjrXV5f5fociwEF9lkWN7YSqEuPAzsX/+MxOthCJxu2ZFNBV
	5ZfduOVHF01rhpdvksWT0sCdgTl/uSNHgrWuCmTQMoS+Ai6gBNHy6KQ1+lYt29/qt0/W9LFVaKP
	uz+tZZcjCLp5O/PKBirlzdU5YHBs8hvecs68ewSL71zormY0TgNBVwKoe20wsqwlNzmcECSlW2P
	788Q==
X-Received: by 2002:a05:6808:1b11:b0:4bc:336d:7494 with SMTP id 5614622812f47-55c002734bemr4688923b6e.30.1793038305593;
        Mon, 26 Oct 2026 11:11:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c043115bcsm5795251b6e.15.2026.10.26.11.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:11:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 12:11:30 -0600
Subject: [PATCH net v6 4/5] ptp: vclock: serialize extended samples with
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
Message-Id: <20261026-ptp-vclock-sampling-v6-4-e705612541f1@gmail.com>
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
index b97f3a877260..679ae40916f7 100644
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

