Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E753F6BB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919196; cv=none; b=sIATeFuhVJlBSFR0CdU3kE0n+/cxtL8aruMPaJ6o72insnXjykia/RKlTt9Pvixfl58Dl4xSn2edV6icMqM5BCNJGG9V6UokPmamns7uh50rwCOvVUm8ZFLHHTWpt4Yq+Z4Y8LJ4BqE4K2ACH78DuvfCQKeHU3l/2YawQfuogVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919196; c=relaxed/simple;
	bh=hLB9iIREQdRTkxWuZOfXaelUczjECboBhQUK9ZkYEUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHNH++Qk9wFKUtBjIz6YWXAjx+B5EeBBF/BIrww0yK/7hHHF9FbFy+kIXZA3UujGcRcXp3k5KpwOCpuRREHeA5tILoOKZpoZpVRZsvZwC2LBKaFjv2BzsrrQGFHGMN+LKeg2XoU9A0KyXlPt4qI1u8iV8iDlKl1Vlwt7ZvYHNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arWQXYwA; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arWQXYwA"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-81b54d0cb17so2614221a34.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791919192; x=1792523992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/M/UZry9pC3NdQaj6klwezszkFb09P0aYrxru7A7Vc4=;
        b=arWQXYwALKwVTSY/cFB0wzfvCEr+fcuR4lyGngU14kEp4keDpOy1+bfUP925b9BiG2
         Uf+f7EdoedNpuYbn0aaOR3ZzGLOqvbLD73Qqs0q4lr8Q9U/NyWPMXly9ZQQwQnvysVro
         T70wszSGyTyphrxDOczwqiQ+AU3zt8GBVm4dUHnTVAEJtQiQYo6eRqIFRS2LMeGKPfkq
         WgzOwK2fjf/Lz25A51I0Ug3kyZCTzCbfCmE0PC5wpQ9xOObBusZQjH8GnpPn3JlcYCw8
         OWO9vso2Q1E61kMYHK3gHedQieMAQ2a7g/mU4qnblhvwik9pleqNdOByzXp+4ORg/2D4
         oN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919192; x=1792523992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/M/UZry9pC3NdQaj6klwezszkFb09P0aYrxru7A7Vc4=;
        b=hnUbbavIpwSHvv+mdnaHXXOPA6MRN5LAL8N+yUIiagDRx1ewNqxoD8kGkQBnQStSwx
         ordD8MS6LAZSwBXbB9InC8QoJR90o/7qBvTk/mQkj/eI2ozkPuQHMouxaYSls61zdyof
         0sMO+3b/yF8MLwiqK4dvd+q3jVU1hMiocGm0+SKJdrbj8jDRIlVhGDTxTKJBjDuHl6gu
         fD11dm6tqfkO4ICZGnjU9qRCGsTJJ8ObC9cIhEufIqFL/Oh/s1e0G9HwyZzEoQKaf8Qi
         ODCyioyqJ5q0tdf4PpldNqqgjCZqs04HXzfL9o01HD1UkvD4kfm/i/zEIaK/KLK8y2sF
         fr2w==
X-Gm-Message-State: AFq9FYKSB1Btv5n5u3CJMdBBkmITDYQaXVbpfL/qs6lkp+Z+ee/wGrPy
	tuTmo9WdIzXiwkZsZedxMgSco1kbbjNPr/wAHSyoOfyY11WMtIJA7YxSkYo2MoKk
X-Gm-Gg: AYBFou2LlAQ0RueMDMMWLlUcS5yr09k8F17f5ZoXMbCy3rohSYNpW+6kJkKMCRQ44y7
	9qbgnwMjSeZv/jQdmv0d5j7hT7A9/LX92TlK45dh7diUULwnyZRhEeKUmublxoMWKEdMZqMvNRe
	7VTXNbMZTXdfLL8R8c0a8IewCIOWW+3sTatvuJKl4btVSWyiXHAUcxXmYX4RSrl6cIn0CNgFoO6
	OWbvCrMJ5TBskY9I/BwtDXINHurdm7MrdnzJcrBuJ69jYeBrNc2x6WCuiD7scR0G8K+DRE6Yy6/
	lLSAZywokdkjrmHwSBjsv+CcHyJrBapUUJ21LxAAMO+NhiRnFOmp85Z8AtTCTizP4dgcb78QRTI
	1JS/7/ySxrASt6Mq5Omotzhzd8ajp1ZRd0AWj1HgJgNcVJkwqi3oQtwsQ/CWPoh1O5lFHg14Jm3
	G0GLRzNZk42rsfakYK7e8DkicE+7TBLRsE78/TuiDcTqeN31gYFFSF7hPHEsmK7elsnOhtP15Us
	eYdlrDsR1CV85lnL+kECxt93FHeTmP7qnfRbLkW6pNvzUmnfR1yDniWfGdiq6eFC/1Nt7txELHU
	cgg3XmFMJRd1p69QyI7r3A6QwvGNHB09fofTZYOoS2gc/Xuijq77Iod/zhgjAgAxltm/b7kcVCx
	pMP3C1EiEDsoUEzgJL9wT
X-Received: by 2002:a05:6830:6aeb:b0:7f6:705b:ffe7 with SMTP id 46e09a7af769-83095a338eamr12524842a34.14.1791919192556;
        Tue, 13 Oct 2026 12:19:52 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3dfa1sm13280507a34.18.2026.10.13.12.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:19:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 13:19:48 -0600
Subject: [PATCH net v3 4/5] ptp: vclock: serialize extended samples with
 counter updates
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-ptp-vclock-sampling-v3-4-d3ee4ea62fc6@gmail.com>
References: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
In-Reply-To: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
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
index eea207e5a889..6675466bc307 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -113,20 +113,18 @@ static int ptp_vclock_gettimex(struct ptp_clock_info *ptp,
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
@@ -152,20 +150,18 @@ static int ptp_vclock_getcrosststamp(struct ptp_clock_info *ptp,
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

