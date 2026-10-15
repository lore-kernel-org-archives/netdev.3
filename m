Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869C46C4AC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081365; cv=none; b=uf4jUB1e4DVDj/Th4/DG/UduxpMQMQaYoxg4CKtG/zHtYwVB50GyGW8oMDIVO3hVoKlze2WS8DdtUg3BwkIaX0KyP5w/xg3wL/CltgrWPDu8gWqzRd3Sv3qOKZ8jWHs+LMxtsbzvMTASRw1jnwrEMz4gcs5Qp82tif/0AuzCIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081365; c=relaxed/simple;
	bh=pBy1f4VSb3pvW4clcyc1Qy/2nViC1kPB548ufIhq5H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYT/+7b+Whi/rmxYl7/zE//B35sTN1Uz9A/WOqoK6kcesu4mS6m4tFiAcm7KO0tiw7X44w7qpSs7jtT8GquLxtJjuaPae9OuWUAgAfRYGOeZVpEaK/ryaeimzltqsyknAEqHiyxKkETKLD/4bMYxAZiEoFkAHj8A71Y9TnZ9ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=QGgQamKW; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="QGgQamKW"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35d0be18c71so154192eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792081345; x=1792686145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VxoANqrdqE06En2I4F3G1u8hzDyBoOsiup8bgRwGeec=;
        b=QGgQamKWwwM/ZiXBSkgkpkjaTBlTzkAq+SB1NpFz93iMzrlxEv2rPtXdZTJdoytSiz
         DjykKW2YRVd9iQhoGXpGyMCq1IvaTpysuRlkYd4/o43C0NvkQmcsYgmeZIOxMfB1nhbO
         9cdmbekh8oikZetA7Muzhsf0RXBC616gTIzaqpqdcXESFrFxfH5bkTmx8okK2YYOBp15
         AL5y2ORia4p5iu8U6Re8XgAnPm19fJMBCjSnf9N5a/pkdB5I7S9Y8B/RE2fdSRGk6DUg
         46AWuAD7QKyZUgapN/J2fbIM2ibmDRwMsBvUA1S6UmdwWWzSPlxUTwjdkAccFlUvyMCU
         3wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081345; x=1792686145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxoANqrdqE06En2I4F3G1u8hzDyBoOsiup8bgRwGeec=;
        b=XySxeQeY1DCnqbmrEvoXEdKqAhY/3tMCuUY7OYHvT/Qb/jEc2tkQUGEDcGwEfse/T6
         h/nW7Q/Ne9jZ5RK090UYJeKmR5V2/1VHrqFvlowfr8WcSTwNyCj0edSZFtupVBsOAhd/
         Rtxbuh4o7R/xTMV6P6oLkkjFjWMcDULFYhKUe6FpoeKr3IMWp8nuW4T84QyU89Gh8eZQ
         V+nbW5Gd7annkyG4nAPmBeps7loXSRK3+CzyTvqOPf0FuCxh71aGni4/aaTOIrF9eu7y
         KSsxrYd7SSCTsRjpnXNU0xugeb7OGlsJ3HPcvmrPAYzrlN+SC2TVl7A0vhYzFp43ncOZ
         bSjg==
X-Gm-Message-State: AFq9FYKZGn2nYEaH3V8o9FetcxV2AWE3yxCV1bnv1Zh41ORj22gFFOv9
	fudFWLP3hQwgtRMYZL1S59NmTdwCyepLcpfIEbRqpy5oPBaMJuGY9zDkjdPvvOkQxTXGmW8nVHV
	umukO6ldjpOTPAFl+ock9CCryBRkeTsi+FJBaxOq7rwUZkkVk1+lXbJKqe3fV2Ba1IjWrBBLwGq
	d6DM0qWEpgD4jBh0u8CngDNiTq4zuywwAMzioDmg==
X-Gm-Gg: AYBFou0/hwfFswVe63JJIAkxtIDh/zkgQPI2KNlps7s5S2YNV0G55bZ5fbUDLcYK3mP
	8htw3yxvRBmiVkl2ew10Nc5D5PczwOYviKONrkgUwlUXx7VvAclnL1JbkxuV7EBifEdvnzBWrDf
	Wbu2RuzIiX5IaioAwKPURHMMaaUkFqQXz3HKc8NP0dzD8opS5cDnS3JTQOLu4Ap9nAJ8yWQaW+D
	2NlnbwIDBjNu9p9Im/VHTcM1uNUoyRW9B+fUGb9/xXv13avfVetJEimyHEv53OyK2pSpLBGuLks
	t7rlGHLtzDwvE9SwOEolU8NB+iUUiGA4FogET0W4NFi4FRLAESXefUowP78nLsZPpDuREmj+88k
	M4wBOhE7ACjefMsDgz4+lJMAgzm+gXm/X1wl4aJdq5Jf2Fe65xvN5HxX2tk/a04cv+szWgA9LYw
	yo+xqhXYIOekL6hlGprLY1cwAH9wYjT61nk2W4Q2f39RhNRKKx7n1tvMuNCUuGxZJ0WyV1e02+5
	IIkFoe7Kgg=
X-Received: by 2002:a05:7022:b882:b0:13c:d071:f97c with SMTP id a92af1059eb24-18251e3f05bmr523257c88.11.1792081344438;
        Thu, 15 Oct 2026 09:22:24 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-182a6d6969asm23010c88.12.2026.10.15.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:22:23 -0700 (PDT)
From: Joseph Kain <jkain@nuro.ai>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joseph Kain <jkain@nuro.ai>
Subject: [PATCH net v4] net: do not let defer_count outlive an empty defer_list
Date: Thu, 15 Oct 2026 09:22:09 -0700
Message-ID: <20261015162209.485940-1-jkain@nuro.ai>
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
takes the nodefer path without queueing, so the list never refills.
Deferred freeing stays off for that (cpu, node) until reboot, and
cross-CPU frees fall back to the page allocator, which is the contention
deferral exists to avoid.

skb_attempt_defer_free() increments before testing the limit and does not
undo the increment when it rejects, so a rejected free leaves the counter
raised with nothing queued.

Nothing brings it back down. The reject path returns before
kick_defer_list_purge(), so once the counter is stuck no producer
schedules a flush on the owner CPU. A CPU that never raises NET_RX itself
-- an application CPU doing TX while NIC IRQs are pinned elsewhere and
RPS is off -- then never runs the flush at all, so clearing the counter
inside the flush cannot help it either. proc_do_skb_defer_max() neither
resets the counters nor schedules a flush when the limit changes.

It is reachable with no race at all:

  sysctl -w net.core.skb_defer_max=1    # frees increment, then reject
  sysctl -w net.core.skb_defer_max=128  # does not recover

skb_defer_max has .extra1 = SYSCTL_ZERO and no .extra2, so 1 is settable.
From v7.1 on, 0 is safe because proc_do_skb_defer_max() flips
skb_defer_disable_key and the producer returns before incrementing. On
6.18 through 7.0, which carry the llist conversion but not commit
08dc30de1a40 ("net: add skb_defer_disable_key static key"), setting 0 and
restoring the previous value strands the counter the same way -- and 0 is
the documented way to turn the feature off.

Test the limit before incrementing, so the counter is only ever raised by
a producer that goes on to queue. It then cannot outlive the skbs it
counts, and the absorbing state is unreachable without depending on a
flush ever running on the owner CPU.

This makes the limit advisory. The test no longer reserves the slot it
checks, and the recvmsg callers run in preemptible context, so the
overshoot is bounded by the number of producers in flight rather than by
skb_defer_max; the post-increment test reserved the slot and bounded the
queue exactly. The counter is already approximate -- the flush zeroes it
without regard for producers in flight -- and the next flush erases the
overshoot, where the latch it replaces never recovered at all.

Undoing the increment on the reject path instead would be wrong: a flush
that zeroes the counter between a producer's increment and its undo
leaves the counter negative, and the producer's local is an unsigned
long, so every later test reads it as enormous and rejects. That is the
same dead end, reached more easily.

While here, drain before clearing in the flush. A producer that queues
between the clear and the drain currently has its skb drained but its
increment kept, which over-counts and costs deferral until the next
flush. Draining first matches the ordering __dev_xmit_skb() already uses
for the qdisc defer_list.

Found by manual code inspection, LLM-assisted, while backporting the
llist conversion to 6.1 after hitting the sd->defer_lock contention it
removes. The latch itself was not hit in production; it was reproduced by
lowering net.core.skb_defer_max.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Joseph Kain <jkain@nuro.ai>
---
v4:
 - v3's "undo the increment on reject" was wrong: a flush that zeroes the
   counter between a producer's increment and its undo leaves the counter
   negative, and the producer's local is an unsigned long, so every later
   test reads it as enormous and rejects forever. Test the limit before
   incrementing instead, so there is no decrement to underflow
   (netdev-bot sashiko).

Note this changes the effective limit from skb_defer_max - 1 to
skb_defer_max, because the test now runs before the increment rather than
after it. That matches what Documentation/admin-guide/sysctl/net.rst
describes. It also means the half-capacity kick can now fire at
skb_defer_max = 1, which commit c09b0cd2cc6c ("net: avoid strange
behavior with skb_defer_max == 1") set out to make possible.

Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT. On
v7.3-rc6 with skb_defer_max=1 and a cross-CPU TCP load, defer_count
reached 1918118 unpatched and did not recover when the default was
restored; with this patch it stays within the limit.

v3: https://lore.kernel.org/all/20261013205416.3417296-1-jkain@nuro.ai/
v2: https://lore.kernel.org/all/20261008220256.1844072-1-jkain@nuro.ai/
v1: https://lore.kernel.org/all/20261007180056.1394868-1-jkain@nuro.ai/
 net/core/dev.c    | 5 ++++-
 net/core/skbuff.c | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 18dc88990510..60d86bc21632 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6940,8 +6940,11 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
 
 	if (llist_empty(&sdn->defer_list))
 		return;
-	atomic_long_set(&sdn->defer_count, 0);
 	free_list = llist_del_all(&sdn->defer_list);
+	/* Racy on purpose, as in __dev_xmit_skb(): a producer landing between
+	 * the del_all and this store stays queued but uncounted.
+	 */
+	atomic_long_set(&sdn->defer_count, 0);
 
 	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
 		prefetch(next);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4aea06d5167d..25f82b7dcf01 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7386,11 +7386,14 @@ nodefer:	kfree_skb_napi_cache(skb);
 	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);
 
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
-	defer_count = atomic_long_inc_return(&sdn->defer_count);
-
-	if (defer_count >= defer_max)
+	/* Test before incrementing: the reject path returns below without
+	 * reaching kick_defer_list_purge(), so a kept increment never flushes.
+	 */
+	if (atomic_long_read(&sdn->defer_count) >= defer_max)
 		goto nodefer;
 
+	defer_count = atomic_long_inc_return(&sdn->defer_count);
+
 	llist_add(&skb->ll_node, &sdn->defer_list);
 
 	if (unlikely(!cpu_online(cpu) || my_cpu != raw_smp_processor_id())) {
-- 
2.55.0

