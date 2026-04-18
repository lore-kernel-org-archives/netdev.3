Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B91529E110
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776482454; cv=none; b=bQqrD23taZqjRuE38j7v274LPG+wZbZW32v+BNW75r9xqDHQvcUxbrflujh6tw5D1fleTPwodfDiicM7TKqhHWWmWX4ek5CmWdXIgWmMVtkUrVgFm+rNVgBIoWRxHBPUeqC9FNpS2FuoJIO43doVTj9jdMQu1lQa/wxMPIPpsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776482454; c=relaxed/simple;
	bh=iSQeicGfHcT12F+PCiqevYyDMfIu47Wx4dh4JyJvmk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkcE6WaNQ2C28Hzlo96h96NAbG1vydaWb2cDV1qmRk7OKwVuiIO3zcQXP0pnSr7/FRtbHTUNTBGfA1YhPbYPoVbBau7ya9XnkNqQ3viPpnQpOWXKn5HbTNvwmD8dLBw8oR0igWWtJIdJ4ApV0OObbdSgjr3b1Xzkj7+bsIo9AO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=R2WJ9MMQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="R2WJ9MMQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7fdb922a5so1209696a34.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776482440; x=1777087240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0RtOKpwKkJAZRKtprSGgHKvMJmG6LxXXrPMdSSL/fI=;
        b=R2WJ9MMQaaFG5RwV8KvJi5vE0eqe4xO8mLMQxICUL7YdwLtID5Inrql1/kyQp6//Rk
         P0+Bn4Zjo6W0fe1QveSAzqVqMb69U9JQjZoyWQx5+9H3AG8/qmoD6iDLUA6rwRkoBAx/
         ls29KL+/t/p0QrbUWli3ULsOOaFaWjk8D7QEZuyUflxopEjhRDbb2aBKO4TxL0Zdl82n
         L7RaOp8V5/d58KL/aRJ5VpICXGCjkz1jfQp4yEaRnR8V7RVvjwfZ4kebDQDKVWDcAS+r
         D0wPwXwTwa7L9Xu9CVISUw+WHJ+UrI1ciOPsNUUbPnTSrTPjMcS0d70nqVcGXzTvKCGu
         kGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776482440; x=1777087240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0RtOKpwKkJAZRKtprSGgHKvMJmG6LxXXrPMdSSL/fI=;
        b=pFsCTzJF2jKIlixrmw52wKFMCGWjgmIvaU89a0WfYwFvPQiVL3wpqTVi9rAQtWp9Af
         vBuqfUnFGNi9In14u1ouLah824zDfeeBkRTOgUaJnlXujFOvJeIlUA9EcGzQBk2bTFcY
         DJP6V4pSMk0urQhOQ+mviLUWtdwy+MuinEkWew2EmNmd46XzY6GXIiokTdjyXPme/3r1
         P9MWlxcfX8mY+SRpEXiJ4mNeQk3/3iWo6I4a3Vf4wGjPrqW4ZoDxoJRuI7rzmq1YhJT/
         TJcaL/BWBr9QfK3dm7Mb46uxW0qnl2K+3Ogiuik0CDK0rVhoMBICcFUeZq+66hgw8sY2
         wVag==
X-Gm-Message-State: AOJu0YzcuuYfjng2GA2UYSyTG+ZYXQVqgPTZTJq3xY1N4xQWOmp4gWME
	xQ96WIAJPs/fFX+6Aq++0aUsncl9Z9588YdsOmr56fZ4CaRel/2W4HmHJqpZi4jkS3xEEjJWWzb
	CWoMD
X-Gm-Gg: AeBDievVPds4U7okTnzXm0GGFmdYXFwhqd3XdID2oFfDQkb0AjlvphL9No8eaERtIKt
	h3YMlAn9uwHv8z7DzhVpDJounqdj+KNPjKkEOeqJ+iiZohCIMYl/EuIITuS5WYe9+10vRK2ZioY
	pYQ66U5w+cwaquhqa64Iu0GbLSfmM18OkAeFJt3Sibu1sAtCNqI+JBCu+0GGbzfmrCgNYr+Mrvz
	CBaLCi0T/fDlfFHwA0R0l1CxPSN2a4YWcxtslW+FbM7+TlMHtckfg+xTq9HCLNCmXSETkmkZ0So
	9c6p/ZgDbyten1Vj7/ZvUryGESDswdGzzk2jjMl3Upqpr8cb6MtdIMkEPcxfUTDZ6hvoYw8Cffd
	WOf0Se0Yk6JgopZ4ie2LWjiQqWVO0B6HdPdSODVkUCv3Gq0C2ydA2PRLrfN8jIfsxRPfDMF/2wJ
	xldeT3kI/1p1K//3QsVuFmkMjdSVA0sz5hM3rBUofRDIk=
X-Received: by 2002:a05:6830:82eb:b0:7d1:9da9:c6c with SMTP id 46e09a7af769-7dc951ca7d6mr3520693a34.17.1776482440097;
        Fri, 17 Apr 2026 20:20:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dca7b6b5bdsm276902a34.5.2026.04.17.20.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 20:20:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	horms@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yousuk Seung <ysseung@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v8 5/6] net/sched: netem: fix slot delay calculation overflow
Date: Fri, 17 Apr 2026 20:19:43 -0700
Message-ID: <20260418032027.900913-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418032027.900913-1-stephen@networkplumber.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_slot_next() computes a random delay between min_delay and
max_delay using:

  get_random_u32() * (max_delay - min_delay) >> 32

This overflows signed 64-bit arithmetic when the delay range exceeds
approximately 2.1 seconds (2^31 nanoseconds), producing a negative
result that effectively disables slot-based pacing. This is a
realistic configuration for WAN emulation (e.g., slot 1s 5s).

Use mul_u64_u32_shr() which handles the widening multiply without
overflow.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 640b51be807a..475c14b3dbdb 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -659,9 +659,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
 	if (!q->slot_dist)
 		next_delay = q->slot_config.min_delay +
-				(get_random_u32() *
-				 (q->slot_config.max_delay -
-				  q->slot_config.min_delay) >> 32);
+			mul_u64_u32_shr(q->slot_config.max_delay - q->slot_config.min_delay,
+					get_random_u32(), 32);
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
-- 
2.53.0

