Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879D43F4CD
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497380; cv=none; b=DtVtGxGoqLpV/0xQv+B4oIbTOKJpkYWRw42p6wxl6WXo3ZCKcxKA92pBdOfPy8qg9iEPjMDfNytkkg329LYhUBbxP9c9lw3KMEujJvOmT11E00wnDYAgR5W/pMDFjpHYu1UxzNiybSswoDoSFjnTQRahe9b0i4UWz7dFiH9k3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497380; c=relaxed/simple;
	bh=8k95RK6Zf52oGbmUpDyrJ6APv7VVAvduP/WK/ehltQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiJEEd6IU2GabTDvKx1KQgUi+FjydWPIQF0dlwRcRhh51+Z9xC59nfTL5g8lLUAklJsQKz3Sco9hk+PjUYUqSxh1B1yCACUMAtOJH2H6Fy6KZhaWSGQinxmF90M23LIr9LSkcNJlFbyIQxV7obKg28V8Okz78zraeCfPyKSUMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=Kcnjjl+0; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="Kcnjjl+0"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4949f037131so1945349fac.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791497375; x=1792102175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6q2ZgKyEielHB9fMBeVKRfxouhNXO4dRwouPOAg0k8=;
        b=Kcnjjl+0e9NfQtjEwjvSVZ/NklLQF5Efi2XlsKnJ6AgxJIqYfLfOVtyzAJF0pVf6l1
         fPonOh2QDO4dm1r6HJx4ksCpVtQbUKzNg+ZZvGh6APmEXt2eGG2OJ8ewZ2qCEQqVVxOP
         r8OifMVTRaO7rNTuVGjcL1UIRe32OCuP6YpdTwRmNh6DacXwF2NRx9icFsfeArXUPIay
         e7fH9DaTz0z2+B9ShRO6vbvykoCE8BiQGThNPxAprX2Y5B3hL0YzFEHbKnLWYSilgUyV
         IcAzmhFzBEOa5eNyyn4x8ILSdSpm8134yjYQOz7HAvnQfCyz75UbSH7Cut3zzFprLkkz
         bDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497375; x=1792102175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6q2ZgKyEielHB9fMBeVKRfxouhNXO4dRwouPOAg0k8=;
        b=ZUoS5+If/4h3tDYROrTWspb4bkRLvGGUiy+fjfmyGtMuY8kDR1VKLYvhBQDXUTqdYM
         L65LLjhhvzVi18Euj1zquCRrOZjVcZWkUaD3ssVAHcno+HDgDoBtotxBCurnVMmQ2Tw3
         CN/7PligjEnigoV04pMwV25A4rPGu2kLbjgTOLTeAvtcGlqy3h1JMElSOtsVw3FtakKD
         7VRsCOo3r/rdhz6/Dt6a1NTGlwkTVw492Le2KOORDicJ3r1I/stBfq7r0Rk3hW6xK6j+
         fTjGVkoajviaybGLo2+/PVIBcMlfXBo4SiNOjzsUxbXPY3oZV6TToOq7M3oS5+95eXy0
         kAlQ==
X-Gm-Message-State: AFq9FYKpJk9CSlp05FMkPLUncmJ5JlXvAAbXSpanYfTxDCmRb4DuZf4W
	wI6DnQCwijg6qi/6teS+NrqsmHRR5yWio1mv6eS+lzwYrebepTR11w3y9SLN6T0BC3IoxAgYnYr
	xuHnohAX7SSOCQzsi3LN3epW3LeO1nsOjTwmnpPaiR6ozBbAwDXNW7Txo/JAm4G/pL0mielYSZX
	50YU730//CNc9zSNBrlRyDSKzRqNEpFzMIuRXvNg==
X-Gm-Gg: AYBFou0DYvJ2qd8jgLHrOARgXS2rRoak/gAUr3yU/HmVp3+hcU8SbkqLaUZrsJQoX2i
	xYkiSFNAcdzTDZyrvq8DS+dA6F8MZOb4Nq7G2uFoOnGw6IyS7oILtyDiVyrBvn6ztDytq0dkxBm
	Dojj3CPCCiKd8EzblmmFWN9OvhuouCTegO0rxmouWJK4ulhzU5pt8hHprD4SRu/lBtkF1ty80uo
	09211ESqeyHSXG6KcQslwmvdF154U42Uosm0rcTLEzREQcZ7tqUcfuST3MNiinp0nuJFlulDOCr
	HW04U3i3oD/gyh/V5iRV+NRkKAAvI5A/r4bhKJV7J1pbESljxcZYQMAaSLmdEqNLx90u1VxQFEA
	LHurLOF8J0aPLGwFLdVJnzlhgaF8a0RRo1wn9r4w/KbAwi9ixJQpyPtK4v7mQ4QCIyNL+3EaBTa
	8iqogLxQnk75AfVBBtJKq26VxV+94Cvnz5Js/RpRxRU15QoWb75irqJDH7M+ptRBQpi+K/4aC2b
	kHnVGxn2jU=
X-Received: by 2002:a05:7301:78ca:b0:351:750d:dd3b with SMTP id 5a478bee46e88-3537dde75a7mr339836eec.4.1791496985629;
        Thu, 08 Oct 2026 15:03:05 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm920601eec.20.2026.10.08.15.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:03:05 -0700 (PDT)
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
Subject: [PATCH net v2] net: do not let defer_count outlive an empty defer_list
Date: Thu,  8 Oct 2026 15:02:56 -0700
Message-ID: <20261008220256.1844072-1-jkain@nuro.ai>
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

skb_attempt_defer_free() increments before testing the limit and does not
undo the increment when it rejects, so a rejected free leaves the counter
raised with nothing queued.

The flush clears defer_count before llist_del_all() rather than together
with it under defer_lock as it did before. A remote producer that queues
between the two has its skb drained by that same llist_del_all() but its
increment retained.

That part is not cumulative: any later flush finding a non-empty list
clears the counter again, so lost increments do not build up across
flushes. Reaching the limit takes skb_defer_max - 1 queued increments
inside a single clear-to-drain window. At a small skb_defer_max that
needs nothing special. At the default of 128 the flusher has to be
interrupted or preempted between those two lines for long enough, which
is where PREEMPT_RT matters: local_bh_disable() does not disable
preemption there, so the flusher can be scheduled out at that point.

Once the counter is stuck at or above the limit with an empty list,
nothing lowers it again, and that half needs no race at all:

  sysctl -w net.core.skb_defer_max=1    # frees increment, then reject
  sysctl -w net.core.skb_defer_max=128  # does not recover

skb_defer_max has .extra1 = SYSCTL_ZERO and no .extra2, so 1 is settable.
From v7.1 on, 0 is safe because proc_do_skb_defer_max() flips
skb_defer_disable_key and the producer returns before incrementing. On
6.18 through 7.0, which carry the llist conversion but not commit
08dc30de1a40 ("net: add skb_defer_disable_key static key"), setting 0 and
restoring the previous value strands the counter the same way -- and 0 is
the documented way to turn the feature off. Recovering needs a
skb_defer_max above the accumulated count, which an operator has no way
to determine.

Drain before clearing, so the error can only under-read, is bounded by
the producers in flight, and self-heals on the next flush. Clear the
counter on the empty-list path as well, so no count can outlive an empty
list and an already-stranded counter recovers.

llist_empty() has already loaded that cache line, so the added read is
free; the unlikely() keeps the store off the hot path, where it would
otherwise bounce the line against remote producers.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Joseph Kain <jkain@nuro.ai>
---
v2:
 - Reworded the drift description: it is not cumulative, since any later
   flush finding a non-empty list clears the counter again. Reaching the
   limit takes skb_defer_max - 1 queued increments inside a single
   clear-to-drain window, and said where PREEMPT_RT actually matters
   (Eric Dumazet).
 - Noted that 6.18..7.0 strand the counter via skb_defer_max=0, the
   documented way to disable the feature, since they carry the llist
   conversion but not 08dc30de1a40 (Eric Dumazet).
 - Dropped the paragraph describing where this was first reproduced
   (Eric Dumazet).
 - Added Assisted-by.

Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT. On
v7.3-rc6 with skb_defer_max=1 and a cross-CPU TCP load, defer_count
reached 1918118 unpatched and did not recover when the default was
restored; with this patch it peaked at 1.

v1: https://lore.kernel.org/netdev/20261007180056.1394868-1-jkain@nuro.ai/
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

