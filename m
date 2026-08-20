Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE0469840
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240276; cv=pass; b=R/bFqBDLzK5mkMeC4woXTcqVDfhhVboScUEDqpI6lbdL8On9FRaG/mkaEIrZA5G++a8nxP7KIcJKHRfJjenBKalQNBTHPE8CbevOmUNS5Ag9PXLBAUF8eZ09aiK6iu0g6oPLIvhDhsflGXTTDeRHQlSBGydRoNVIBX+Abe68njo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240276; c=relaxed/simple;
	bh=/oxZkxFAEHCqx9LDeQeRQTe9kGwQJLteh0MJCekMPWw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ejkxius1QSdwPJu9PFKP8QVE3GGHDdcIyQ/RlkOMdh1v0rAgelxF/KC1Cxz9z4KcGlgFPbmsipGDk0zgiRZhOLavB8rT1yJP3wBzdUCQhxblaQAmQyJnjd4aAQaLzSm8C0mLOxgUrwfv1PqrHgo5OXk61f+NloMxhRc5JbzSdtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEQ0ZMyg; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEQ0ZMyg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso26933615ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787240274; cv=none;
        d=google.com; s=arc-20260327;
        b=APahVc+sn70/ipC/OqOyXgflC3R8LjmLE1RzaqToHigvQ/bK+LJUU3zng/buNi2wxT
         TqtG6856wo7b7IZnTq8nnyAMxEYth9q7VfjA2ZV7K4XpHjELaOFtwPUKyX822/HPmlMo
         lCHjXV2T5jDy0rJ10GoGdxcRbWkPwz9lmTs1Vn4odyDTuwTRzQ3qX3BihaLnaJ7SddT0
         vQV+3ZT4Hf055cjfH6tvyoTOkbyAEjhzCNhLd+i0Lmd9DP+vYDzXqBh12A7hNJ8bEJzx
         khyE9Eo6fGwmGB40qTc6zZtJoCRCkDixcZHZ66EpUuQwTbzkLRqK5lCpzST8Ja4zn//S
         h3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/oxZkxFAEHCqx9LDeQeRQTe9kGwQJLteh0MJCekMPWw=;
        fh=KV2fMU4Fowr/Cb3pBghBew0BJehsjn/9Aeqnyy3xtFo=;
        b=So33wMgl1yER17AB9EpTwVWczCQb9DblxEtDnloGQHEsFrXrStXL5cTu83U6y4iSJ6
         WMvxCKRmWzQHK4m/AHJb58khyu76B1LJ3e9igWtL3QBr3MLYW9szdLwKkRwT7o8WD9IY
         +xgIeM3IEIPLVlsunZ4v2ThTD9Af3XtfBaPKDwjvlO+3lcwznNnYOtbz7fLe5M4xtbho
         +zB2xwrrGaz8jN3ftAhx8jmv1W04ZowFsleaH6RJ29D/6VFwbIhezf6fSbDn7yXfyO/P
         MhrzqVYMg+VTtyn5nkqqqaM0C7ht28f3SumQJnxn2Dpeuqo/6CuLwmLIMDfFJef4SM2z
         HYvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240274; x=1787845074; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/oxZkxFAEHCqx9LDeQeRQTe9kGwQJLteh0MJCekMPWw=;
        b=UEQ0ZMygyGSFRKBUU1wbN0pKXSgubnB4P15kc1IE4OhLPrrlP22KrNIB9lCAwsg56O
         AzlEIw80ZfHlV2yTnEtkoh/d5lNJpPG44H3j40BLM1+Yb2GdU9LTs7/RSMm+WTFN6EDr
         +4BPRHxk6P2w3Win7nc/xuzLpWsUBYgLvsgg56VPy/L/UFPWffVaWWDfWuVDEDV295V4
         qHddcsfHG+nFo+7oQbadS5+TCjwBeix/zKuqg2Qgx7SRJJH29ijIU3FBbFX9Fd28ggFT
         ShQ8nSBMqoPWJ2+pJ6UUS9eiIt7U/TiOT1ZCAVkDWOhT+O0kyNH+3L1Sy+BYv89vPtvI
         Y6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240274; x=1787845074;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/oxZkxFAEHCqx9LDeQeRQTe9kGwQJLteh0MJCekMPWw=;
        b=PdIZs3ez2KAvYzX4TdnjSvGU/Z6p6MHjLt8sJ7/npiBNDXK9I4/i1SrHYf9UYQh+Uv
         Q6HJHURiUJHoaJPpKb2cR8/SI4AfAt8Bb/k6jtfiIW1WT/sK8yuYmUMEINDP1fCf4+BF
         wy2MgYkRQIPKQbZn45jx3KW10CDrf9wzP7AQh2xbLtaC+gYq6brfcwt86XoGaBmLLmWy
         tuTtJ1F5M4fAhJz/k0FNGpCL6hFBK7ErQc4iMdOTHmsT2rzHSn9tLi2C3pAsNiy5NMyG
         bX8ywcxYBvyAn+8zRzdKPm/Q27ugpLRrUzJUhrl5N9HodPG6dbFH7lSc9pU4n955wIPn
         i1BQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTeroJfRQWW0zAP5nGYIHKCBfc6TL/5JbYvmalRJ6if/h9BXeRNJlxlzILdRHefrx2WstMEZ8=@vger.kernel.org
X-Gm-Message-State: AFuF++lb8T6vfiZAroEs3PxYNMbSvI7kC/EURYfQZYbYEWo11f+DcMEo
	PCN139a5mH/LTxomvrqSPlrlAJy54cPGBDTv9S5yqaFaO9x66Jt1Sms4FMOVuEZpvRCds6CMLs8
	FQD7Su7gQFLfcHSOJoXbeSE2CqMXXdNW+tWbFr/g=
X-Gm-Gg: AR+sD106+1ETjpnpuNzJBMCaLZ9nG6CxjtIkpCKHsODZHBwAZq1XTCKUfFBwfRNU8R6
	yVR0lrOeZRTFeHFEtgy69deechQjke1ZrPFhbBcgxSU8z3HoNwSFmi/ronZaucYDQQ053sihvnm
	o0hPgrG+Dv/k6hO9tpmawmAeU14X7y4I7WbhgvC3GKP3V1YrtGYBDNMRLN+J3BnVX7iihkU5lwC
	ssNEaB7WeraWkyVXM9JcLsNRr4l0um+y+4kmLMFnx3Bni/sfaBuvjEeo9UfFSeYo32jhCrIUmRF
	SpkKZRH7Q64MmiRMMNRCJDI029t9AkHL3prYSnHAXBrEVdOGnMpqrMyoDULDcEupROhW2ZF80tF
	3thY=
X-Received: by 2002:a17:903:38c3:b0:2c9:8f4a:90b with SMTP id
 d9443c01a7336-2d5fd64494emr260634925ad.3.1787240273987; Thu, 20 Aug 2026
 08:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Giuseppe Piscitelli <ooonea@gmail.com>
Date: Thu, 20 Aug 2026 17:37:41 +0200
X-Gm-Features: AcwNN1WFgFPTmMMp-erXz7xwrQhUWpenAY8086vGvZ_ImDJaxwIXQJ9qLdqQPpY
Message-ID: <CACmoRBZFvapVjPEiWfFjn94gdAWOz8VqD8p7=d_7TRdLeiNG0A@mail.gmail.com>
Subject: [PATCH net v2] net/sched: sch_cake: fix autorate reconfiguration throttling
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CAKE's autorate-ingress path intends to limit shaper reconfiguration to
once per 250 ms, but last_reconfig_time is only checked and never updated.
Since the field stays zero, every qualifying capacity-estimate window can
call cake_reconfigure(), causing avoidable rate churn and scheduler work
under bursty traffic.

Store the current timestamp when autorate actually reconfigures the qdisc
so the guard enforces the intended interval.

Fixes: 7298de9cd725 ("sch_cake: Add ingress mode")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Giuseppe Piscitelli <ooonea@gmail.com>
---
v2: spell out my full name in From/Signed-off-by (Paolo Abeni)

net/sched/sch_cake.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index f25f60978..dc9326702 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1907,6 +1907,7 @@ static s32 cake_enqueue(struct sk_buff *skb,
struct Qdisc *sch,
ktime_add_ms(q->last_reconfig_time,
250))) {
q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
+ q->last_reconfig_time = now;
cake_reconfigure(sch);
}
}

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
--
2.54.0
