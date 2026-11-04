Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809743;
	b=nqW94TKZ4KnOCR/ZvSiv3IjS/Y6Hb7j7w6zQKR3d6wcd+wjl6DUtvQJkYuUWqXzSeoFd
	 jQFir1bTCCGMyYTiBc+1zu37lVnGl9wfPkfxkoZP7S91xJHAzQIGKRxiZZjOHl7UmcB1i
	 hPI463j/sg21xdoPCaYTaQ8sFimlMUOyiPWXp+aCPpTDlf8XtTo32pWfU6XrgvOrh90fi
	 L6CceRdo/jeg/jvDSYWlmloMMd34aQE/fbhvth/U+m/wDDxsBAUHcJwF4ZHFzJaYP4ofP
	 NLHV42CD+XE02KTh2i9Wq6T5bwHCz1JQaWPZBT+OT+YXSBwVcF/YY0aoZ9z1p8p0CFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=aMXCCZD/Ct0GmViTFWPgT1+QbEU503C2HJaGHUQ7IDQ=;
	b=grsvDmMmdzNk77jcNbMeesIaHueGB+VJy7W/T4feUuRX+TeBArzxW2/NGgzJ+VYWqXzw
	 nU4zhgaVSMZWMjXIhHplgxBmJh03S94g4MwAjDwFzmRgXlar4dNf8hBYuN7p4rlJtcnqJ
	 V77DZz0wBJKEWhsbLUEPoJFQ86UNpjP6Qf+tm9yihk40b3RDxm+Fu1jf5sxfjWDQvyGAR
	 P+dfTAwBX9F/49E994HG7xyGdtwTkpegt6EJYv1W/OlHQ95e19pelIdtsSeBwWcZbkOxj
	 AyZhhDi05divmwmnv27+p26TeEZLaj2zpCNkstCCBFaq6xJQcQG4t3zRo1Ug+g6g3ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jQy3xh7A;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D2606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B05D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jQy3xh7A
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0592d4539so1358115b3a.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793809741; x=1794414541; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMXCCZD/Ct0GmViTFWPgT1+QbEU503C2HJaGHUQ7IDQ=;
        b=jQy3xh7AM/EpJ8ATzYgmP7dFHvpCNxiEcvtsoX+LA4ZgGtE1DLTwsP8YI0/NT1Bjr3
         /ZBNo66ol0FL/xV9BqtXLoMGuZ9iQglymDGHkRXyojgzgVSiK8Ct9yB03L+hB4WXY8ij
         y2z7hNJ+tRaKDaCj9TltXJI3Zrim46uy/MNzBtQ0TiBlaNxejSHV7T03dNwRX1MNmlNh
         HF8WbCU1icygo4kLXZ3JjnwDFgDcq0M1/hJLDeZ9BTYpqOr5NMB0+pNjpa2nnJR8HGKr
         sqO1z/PDUQdD2q13Qn2WxRGr0w+VlPImMSY3L0sQpHOiQxj6AjS3dFJeHzacP1AD860F
         mnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809741; x=1794414541;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMXCCZD/Ct0GmViTFWPgT1+QbEU503C2HJaGHUQ7IDQ=;
        b=tiGuH52OJ/9zvrK+rLyD749Alarfnb/9ohDuRJZOAmbhmz0wzrDqn69IBEjdGgLnKu
         Quwc2SlpBtao5JPhAn03rCzzFJl8/Y54tBEoP+Oq93fTeqsXHvq1DxMrTWfJHW+emKKJ
         OPhf9ZxYUAmomYzTgjW/sYuHgJZn15Tp9KH01VYOlgAjfjs5bhLxMLGH8hv+lOYCDLZ3
         y+T1jMPO3UJSRbzDnw8UJlGgjtMADykmhZiWMtJ+AC1cOr5x4KqCx7Nv/yGFvUOyfsGA
         Pf+T/AGvcnMr/qucJ1G7FZvbv6zk9Zhrbphxx9Hof3hY57l1NsqZcQoNfcSsWO+G5jLM
         VLFA==
X-Forwarded-Encrypted: i=1; AKwUvBxR7oW7aIPedNtp0m+xZTdX6vOx7i16V/8n0rbjcURKIOnKWxaraoGcob4Yv6h1wwe50aH6PyE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+D6vkCSHUde6/uMi6jV02l+XO39/DQn5LmIyZdLm+SHoNt7SZa
	pvdKgNL1wGKLKGuY12PC9pSsjaOHL8BPj+Wz3R0yQf5WMg0OWkB+XxWxpx3XnOtyikWK08iGUVY
	FLOwDlA==
X-Received: from pgdo19-n2.prod.google.com ([2002:a05:6a02:6213:20b0:cd6:db2:b293])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0b:b0:3e0:e242:5ff
 with SMTP id adf61e73a8af0-3e928a29f0bmr15815926637.56.1793809741292; Wed, 04
 Nov 2026 08:29:01 -0800 (PST)
Date: Wed,  4 Nov 2026 16:27:56 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104162858.991930-1-kuniyu@google.com>
Subject: [PATCH v1 net] af_unix: Remove gc_in_progress check in unix_peek_fpl().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Qihang Tang <q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset="UTF-8"

unix_vertex_dead() and unix_peek_fpl() are synchronised
with unix_peek_seq to prevent GC from purging a live
socket's recvq.

unix_peek_fpl() skips the synchronisation if gc_in_progress
is false.

However, on weakly ordered arch, GC might have already
started working while the write to gc_in_progress is
buffered.

This does not occur on x86.

This is an unlikely path that happens only when AF_UNIX
fd is peeked so not worth complicating.

Instead of adding memory barriers in unix_gc() and
unix_peek_fpl(), let's simply remove the broken short-circuit.

Fixes: e5b31d988a41 ("af_unix: Give up GC if MSG_PEEK intervened.")
Reported-by: Qihang Tang <q.h.hack.winter@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
The reporter reproduced it on arm64 QEMU.
---
 net/unix/garbage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index a0b515354e8b..fbeabfb0db34 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -329,9 +329,6 @@ void unix_peek_fpl(struct scm_fp_list *fpl)
 	if (!fpl || !fpl->count_unix)
 		return;
 
-	if (!READ_ONCE(gc_in_progress))
-		return;
-
 	/* Invalidate the final refcnt check in unix_vertex_dead(). */
 	spin_lock(&unix_peek_lock);
 	raw_write_seqcount_barrier(&unix_peek_seq);
-- 
2.56.0.385.gac671c819a-goog

