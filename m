Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EF4D5997
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396200; cv=none; b=UL5RoCM8hI4BxzJt3gxrwBMTUaamV+cY1cvt/jWEYDG3ajwTUwl9alU+1c9Ww8ndlI1t8N0NDvPySBbzc+V5K2MBnBXdmzZesg9QPJhZfGHesQRXPntrW6PM/duqPgOqCK4ANM1v1gJpBs8HPPjNJS3IzhuAVIA5IqkWcTLibeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396200; c=relaxed/simple;
	bh=Ltv/RLIwQoMYY8n388CV2rbSvSpwVLlUtRxsUfEVhTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcPj/hyLgniGeIHy7Jr+f0O4dS2SuEru4Q64th1xfcMVC1BX1GrZ2Qi0jJzDUSitrW5RwyDZjat+UU5zd/U1ZGjEx7GB+4DqtCt2ddItYKZ73IDjWJjlB2lW/Rd32SOW3gruEdpefZJhTQNqoZgbBPKIyoCiWudaPqYxjqbMkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=hCJxI8Qj; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="hCJxI8Qj"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14fd9dafb0dso1799570c88.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791396197; x=1792000997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgm5+nCeTJXdCx0TLpkqzAsPIchFKXrgB4ZQJsFcySE=;
        b=hCJxI8QjVL5mROnMaZi+vhsDYn2eYHFtPqTf3hXZW/FtMlLpxfcA6mvu/HkC0POiJA
         EchUvCvUmPcXPDpQXB0qguwK7UKVLzlEa9YzNHIT+Qz3mcNgruj5mAtQokuCu8S8WOpk
         MzfpGKzbwbh1lOFfAQnZdGVTSWS1Oz3SA+Q+J1fBd5ePi0gr0M2Ft2cJJDNlMaO9hYQH
         OlT9JcxU7x87SpEqYKAZhUEDx2p4w7TO2xjGdO8pjeh8IXnfMQuD+B1+6xrSbKYuJM24
         4ZcbNIo7IKUvejxooHWDbhUDGTzWtrne+dOIouIub3/vqYKt8O4/ysYg3wdKGiFSJ4xr
         9FXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396197; x=1792000997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgm5+nCeTJXdCx0TLpkqzAsPIchFKXrgB4ZQJsFcySE=;
        b=wA7umyZs4syOy81lqaOXUaKwFlbzTL4CjIqJvrvqhW2WNwOgim+vLcdsjaX+RgthhV
         4p4/+5s6cOLJ11AxyhH9lChCgBFmFZ+GWV81PYfIiZI3bWs59AYiWeXrWSflksv09Yjd
         6l9LZdlhLMUkKXQanpNhogb0CysCsyuazPUWku17AgYXffCdhS1Ah3QXvtYHorkdLCoC
         TCXwYHsjUCppMlxl5JMx/cszkkTaHG+Qa/i2bhQKfVvF98KxpaDJlcOT7qPJYr06e8FT
         pUEk9VMAfG8QndPMC698BKZz2X6Uc7Xs0tHVt8Qmn5bW8Qz4lteFtw6BX4Pl3fkw/7Ih
         IYzQ==
X-Gm-Message-State: AFuF++mEY3+VYMiJodbixNIP/Hs5ldmJFB7DtyIO8TIzBlq9Etzvgn2H
	D6qDAxwBzJvsEbrZGtnAbURXvvCTBkMsaDVme/x4pBAH2xH9qN8iJGo+1qidQPINLE1wYcRnSnm
	Mcek+ftKHaKt0jo68L40/kn49gcG2GKVE7Hj1KGXm5+z0o2pFsgHRywcf3JkWnb4vTPNbYy60n0
	Qqmg28k5i/3SlW5gpGfXxlPcmJYqm+0CfQg6gGFg==
X-Gm-Gg: AYBFou3W6VFkq/XhQKAfnjWG9yisPJW1HVSehNg2KgskoAYzyHFbxhTBZhcOrNEsF9/
	GnTc9PTMuCiADrFfbdajoYJTy5nkUOtlvr27YFwCVEqHXeEQHbqKbnb4yzK1sKqGfSt4kUlGM2g
	faoK0raPonvSzB8BEzw5+1E/FLgqMp+Om5qG/KzNC1YIcmcYgyV31w50gQGDU6upKG3jE6no3yK
	4tMxud218pxsvqC7PenBDz/DG9+ZpXc30vG9eIDWbVVzFMZzt7Uk6W+o50P/LNLOZshXivFCx9w
	MI4zI5vw64PQa7KeaFtHeUDfKx4MZzdoAoe3BZagLnPUbCyx4csrXWJiepnoUila7kSGwmRpwwo
	QtlRxSqIeZsbgxTREDVEPsoJiKWuUQ6w3tIiVcN7+IvNarv8I+1+jFQhbcTc3y1wDTET9NkbSdu
	8NXqYM7E2KyVrfjkMFAhRsxvEyVu8kTSUIiXePFFvF0IAqFqp/ph4y1w2Yo/wrSvr4XlsoC7opH
	s8Xinc2cEs=
X-Received: by 2002:a05:7023:a56:20b0:148:4522:560c with SMTP id a92af1059eb24-16205bcce04mr3445142c88.11.1791396196809;
        Wed, 07 Oct 2026 11:03:16 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616602b33asm7842425c88.3.2026.10.07.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:03:16 -0700 (PDT)
From: Joseph Kain <jkain@nuro.ai>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joseph Kain <jkain@nuro.ai>
Subject: [PATCH net] net: do not let defer_count outlive an empty defer_list
Date: Wed,  7 Oct 2026 11:00:56 -0700
Message-ID: <20261007180056.1394868-1-jkain@nuro.ai>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__skb_defer_free_flush() can leave defer_count at or above skb_defer_max
with an empty defer_list. That state is absorbing: every producer then
takes the nodefer path without queueing, so the list never refills, and
the flush keeps returning early without clearing. Deferred freeing stays
off for that (cpu, node) until reboot, and cross-CPU frees fall back to
the page allocator, which is the contention deferral exists to avoid.

Two changes from commit 844c9db7f7f5 ("net: use llist for sd->defer_list")
combine to produce it.

skb_attempt_defer_free() now increments before testing the limit and does
not undo the increment when it rejects, so a rejected free leaves the
counter raised with nothing queued.

The flush clears defer_count before llist_del_all() rather than together
with it under defer_lock as it did before. A remote producer that queues
between the two has its skb drained by that same llist_del_all() but its
increment retained, so the counter drifts upward until it reaches the
limit.

Neither needs PREEMPT_RT. The drift needs no preemption at all: the
flush normally runs in NAPI poll on the CPU that owns the list, while
skb_attempt_defer_free() only ever defers to a remote CPU, so producers
cannot be excluded by disabling preemption on the flusher. PREEMPT_RT
only widens the window, because local_bh_disable() does not disable
preemption, so the flusher can be scheduled out between the clear and
the drain.

The latch is also reachable with no race at all:

  sysctl -w net.core.skb_defer_max=1    # frees increment, then reject
  sysctl -w net.core.skb_defer_max=128  # does not recover

skb_defer_max has .extra1 = SYSCTL_ZERO and no .extra2, so 1 is settable.
0 is safe, because proc_do_skb_defer_max() flips skb_defer_disable_key
and the producer returns before incrementing, but that guard covers 0
only. Recovering from the latched state needs a skb_defer_max above the
accumulated count, which an operator has no way to determine.

Drain before clearing, so the error can only under-read, is bounded by
the producers in flight, and self-heals on the next flush. Clear the
counter on the empty-list path as well, so no count can outlive an empty
list and an already-stranded counter recovers.

llist_empty() has already loaded that cache line, so the added read is
free; the unlikely() keeps the store off the hot path, where it would
otherwise bounce the line against remote producers.

Found on an arm64 PREEMPT_RT system running the two commits backported to
6.1. With skb_defer_max lowered, defer_count reached 788,888 on one host
and 122,399 on another with the list empty throughout, and restoring the
default did not re-enable deferral.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Signed-off-by: Joseph Kain <jkain@nuro.ai>
---
 net/core/dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 18dc88990510..043a7f9166a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6938,10 +6938,13 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
 	struct llist_node *free_list;
 	struct sk_buff *skb, *next;
 
-	if (llist_empty(&sdn->defer_list))
+	if (llist_empty(&sdn->defer_list)) {
+		if (unlikely(atomic_long_read(&sdn->defer_count)))
+			atomic_long_set(&sdn->defer_count, 0);
 		return;
-	atomic_long_set(&sdn->defer_count, 0);
+	}
 	free_list = llist_del_all(&sdn->defer_list);
+	atomic_long_set(&sdn->defer_count, 0);
 
 	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
 		prefetch(next);
-- 
2.55.0

