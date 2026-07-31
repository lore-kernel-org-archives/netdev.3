Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AF2E6CB8;
	Fri, 31 Jul 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507622; cv=none; b=AWLwwTnvLxLcSrNV07Rce87w87jo3/XrBvBbmqSNJuRfp5j+00dlsd2+UXi6TjdHmw4vB7zZxmYyeBQKQZJncDCYNziTl3tAI/aRA3NRhDZAGB/9u931q4ibz5JdxcdEPBRAE1Usn15IfteI+KriF/HqSxCfV74KrRythZU5ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507622; c=relaxed/simple;
	bh=wMin3KJ0aPPNmBSLV9r7hz5EDoI0uDRXnakFch1RhJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaWH/DguBccli5csToFcAQGjHSgbxEoCR3RGai+89yj24K7tYIyvZUq7i0BIpJapRwGh61BXVwL0WCFuNXUQdK22V73TZgfy5MLPhJ76H2j+xsLPK57lmeK0rSyusv6GPfRFyCOxVehHwvgfoDYzSzw2V/6uI+I0Nb81IZWtrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SZRXvn82; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WeZlsi3f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SZRXvn82";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WeZlsi3f"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785507618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWDlHXXVddCcYCT037cFxDN1q4w7agXJWRgt4HwA/tI=;
	b=SZRXvn82APLW+PHcqRI9qbYqpmVMRR/gLJfKD4S7jOvYV0tSDzvD2ARia+xZ3Ry2sLGSjy
	vcR9RAyPLP2IZliCxLcoBXi0skUrNBMGvnkS1xPYsaVCdVo3ZF54wJYvgThjl98TBH/G9Y
	NGmfq8yfNcwuZHsvxVMwv66cbq5M8ApGmmrrKi713c3fPMmOdWWN94Q8y9j7n4vW2LQCOQ
	ZCS3CopwbvwsVHnhUxCdElmCmX6ZZ1jPpFNUg5ycwpmLlSihtST2s++PuNaCcjSzKNj2Wu
	AZV24K2gPtj7+7KPQDC2tNZfMjp9ESVkRQodOezjp/sBpOKRshgXHUvuWYGS3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785507618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWDlHXXVddCcYCT037cFxDN1q4w7agXJWRgt4HwA/tI=;
	b=WeZlsi3fy7GmRIV4ab8IqWaUlqJFmt7ySq2JrqmStIiAOvbYn0MxQveoMCx3m9zK7d1EML
	SFILXRh6GdZeWvCw==
Date: Fri, 31 Jul 2026 16:20:14 +0200
Subject: [PATCH 1/2] timekeeping: Remove the unused ktime_get_clock_ts64()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-timekeeping-aux-must-check-v1-1-11ae93068497@linutronix.de>
References: <20260731-timekeeping-aux-must-check-v1-0-11ae93068497@linutronix.de>
In-Reply-To: <20260731-timekeeping-aux-must-check-v1-0-11ae93068497@linutronix.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785507617; l=2218;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wMin3KJ0aPPNmBSLV9r7hz5EDoI0uDRXnakFch1RhJc=;
 b=9o0KdoXqAGSTdFiMOl+Nt5Cl/BrSEXs/G2rY5aRURqF81gDg1WKqOST2fnHtbTYjS16b5PZEf
 RtiO3JQHpjmChe3ysy0VzD64zahf8yacTlDe5N+TRCzv88IdoadHvvr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The last user was removed in commit a6d799608e6a ("ptp: Switch to
ktime_get_snapshot_id() for pre/post timestamps").

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 include/linux/timekeeping.h |  1 -
 kernel/time/timekeeping.c   | 34 ----------------------------------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b4191a873c39..ca4a881e622f 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -44,7 +44,6 @@ extern void ktime_get_ts64(struct timespec64 *ts);
 extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
-extern void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts);
 
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 97db2e9393f9..29b2a38b27b4 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1937,40 +1937,6 @@ void ktime_get_raw_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_raw_ts64);
 
-/**
- * ktime_get_clock_ts64 - Returns time of a clock in a timespec
- * @id:		POSIX clock ID of the clock to read
- * @ts:		Pointer to the timespec64 to be set
- *
- * The timestamp is invalidated (@ts->sec is set to -1) if the
- * clock @id is not available.
- */
-void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts)
-{
-	/* Invalidate time stamp */
-	ts->tv_sec = -1;
-	ts->tv_nsec = 0;
-
-	switch (id) {
-	case CLOCK_REALTIME:
-		ktime_get_real_ts64(ts);
-		return;
-	case CLOCK_MONOTONIC:
-		ktime_get_ts64(ts);
-		return;
-	case CLOCK_MONOTONIC_RAW:
-		ktime_get_raw_ts64(ts);
-		return;
-	case CLOCK_AUX ... CLOCK_AUX_LAST:
-		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
-			ktime_get_aux_ts64(id, ts);
-		return;
-	default:
-		WARN_ON_ONCE(1);
-	}
-}
-EXPORT_SYMBOL_GPL(ktime_get_clock_ts64);
-
 /**
  * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres
  */

-- 
2.55.0

