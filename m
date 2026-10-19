Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431795;
	b=FypWTLz62jS8OqUKAH+0KPnZ3eDp1qgnI2j9XhpU0SCsW93e+dtVDnNDLEWCzoM5qf5x
	 RMws9t6WwIPDFmH8LoG9DkORepFA0LEixki/3iI9mNoLz1N6qlfuXkTdDdrjObKKz30wW
	 UhxCcTLyrf0zXN9t0ftbsHuMh4OsUiIcL9R+YUNjR1LbGuOAJogU36pzERtS6nyb165JY
	 7jXN0XdctdKvycH2sZyAVhFBEIM7+I5BfcObjRJ43oygK/P2sbhlAIovaXGlCs/UJZrxv
	 kfbVmiBTzfPMtGOrrGsmXwK3mr564C6qhtwsgxxzcA5RLnb/vCGEYyWQp3ESFl0q/ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
	b=LJtVJMdJBRyIB+5Kt58JzsIk7mDYca+rj0OC+8D4suRit0SIalxjq15bT+bN/gjLZ5IL
	 8GPdR1/7KZ+3T6qhu20vHgx5QlkgVPMknNNFkSt5kiYv3KygPzq56ZN/RGNI1JDps9cCX
	 a7s5VYi7yfQQy9TMML6H2DsH67M+VzUzYzxiTctZrW4g6pnSnuten6zW/JPNLC4LTe4e7
	 uIsLx7rEqQ/FHYtx5jF+OyRWVotOy+rahR89zwgvmXyxeyFR5HvmHXPhG4hn5ah3mBVc8
	 s2+AAhUDuqgFBEHvf/Ica8cF4pXqSWYVydJkzNG7hr4VXifA6QzFkKMSIbfoVVvQIhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=ficIIt+N;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B648606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B648606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=ficIIt+N
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35ef6b49813so4522836eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792431792; x=1793036592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
        b=ficIIt+NPp6tgyB8yAbe5nZygud4PSWThg22Tosn8JbTYmqBAqOJnzBWLf9+W/+eCp
         hJIM1EvlDnsz1MP3x/xntFErMbRhu5orxOebxpu9ELzywWos2iRZEZMf8q9SR/bD9OO9
         aqpNYzfAZac37tfecQl+kZia12r5yI+0MkqMYVJlCDBBkmCZRb/2kI91achwYWhHdZG5
         nQ8BOTuwRBBSoqLk3Tcy5uUAKtzonJ+tevOklxfooLoINdhfpjclf6pHHZuZ8Czveswg
         +b0xsyWQtblrUwdw0DeGiYrQZ3fwXOW7LjbLSoq5tGgJod5tAPKvNx9SAzt0GufFQRK/
         SNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431792; x=1793036592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
        b=d2TdnyEhKCIPRDSA71Ax+4mIsn6uLF+4zKHJ0GgdnCa4ngkfFp40++ctjCYzo166hh
         0kV019CjP4YICobiy6AMue3qDFKt5g8hL6oPQG4JH1Spw5JlkkjkxIgq+4TP6aKXlElM
         rpkomjmFq1XKm5fCxmGx6MyGeC2NPqTJPqzzR2YHDb00d6bfCspaRWQJmx/sxH7EDPP/
         XKt2Drqy7klM+t2kYVT09i9MqdQ3n9Tvm6wxk0pvCtsRr9YqH6Gaktwq0DafEhXtgFBa
         dX3WEETG0kdR5ZX/31MqC/jnW+YQllrbFEDlQ84nQpVwsKSyAQrNRGqdPxGo3nB0ilXH
         lxOA==
X-Gm-Message-State: AFq9FYL+d0AbrACBMz1AP93sgu5lcy7Cj6YV/fmFAULLi4Tjla1v2jCt
	ZjzAbcCswC1N0S45xiUMUmg7MhA78vOMnaPYXc3c9m/JYHSa2FpxQq4F0QyE7FK/d6rysjiGsNk
	BZl1Pc3YazRPOwGUAmdxWT8Agz8VeUz+tvtAEp+O/Y1xO4BTJ45qs+aEX4uzC4LLE3v3ODeYOog
	31dgUglrwQyEyPurSzx0C8Rg9k1NPkL7s+VzGLjQ==
X-Gm-Gg: AYBFou0tmngtwcxdodvqbyBsgBwJ1p2a9DS4gxF2ncor25wX/md0D+r+AHdmzC29QXX
	iTqdtjm01D3NfgZ7XG8tobHpENivaVRoDZ1Mb9T/Vh4gRLaAwib/d+bkPcvpRadVT6uTUnaGU9h
	czzeuPdL8Gb3vdfEkvb7koBFcX8s4iNuMzN86nBTlHjDGZisAMq2Gq1r9nL0mdkw0/u7U1kvXmD
	A2quEx8DU9qEt9NhCJkZgIM9xFxrW1xeIE/bYYchwCiO9Mxn7/gel4hR2f1FhHIwKjTlAyNylBd
	3DPL+hYu436dZ+vyqD6J9KfVOJRed7EWY98A9CYW0cI+30UWzN6AQWLqOXSQ/bJ3FQX9TxMXHED
	qbZiSLIIyPrnHuq0QqHuxEUbyG0xFYySYCNOmpdjN2z7je8moBlHg6wcJz2ZrQCAKbuoNCN+hc6
	EjQNRz6Ze2gGyjyaPq6bV2pfzYNz2WzAyJxqkQDSdw2cd1iNHNE1dyV+4BmNH7pcfnwnroAujlq
	1tpAffsLRw=
X-Received: by 2002:a05:7022:fa06:b0:160:6a5b:7edf with SMTP id a92af1059eb24-18514bf8439mr15393776c88.44.1792431791947;
        Mon, 19 Oct 2026 10:43:11 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm38312096eec.6.2026.10.19.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:43:11 -0700 (PDT)
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
Subject: [PATCH net v6] net: schedule a purge when the defer queue rejects a free
Date: Mon, 19 Oct 2026 10:42:58 -0700
Message-ID: <20261019174258.1375583-1-jkain@nuro.ai>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__skb_defer_free_flush() can leave defer_count at or above skb_defer_max
with an empty defer_list. That state is absorbing: every producer then
takes the nodefer path without queueing, so the list never refills.
Deferred freeing stays off for that (cpu, node) until reboot, and
cross-CPU frees fall back to the page allocator, which is the contention
deferral exists to avoid.

skb_attempt_defer_free() increments before testing the limit and keeps
the increment when it rejects, so a rejected free leaves the counter
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

Kick the purge from the reject path instead. The reject is the one place
that observes a full queue, so scheduling the flush there is what stops
the counter outliving the list, and it does not depend on the owner CPU
ever raising NET_RX on its own. kick_defer_list_purge() already coalesces
through sd->defer_ipi_scheduled, so a burst of rejects costs one IPI.

This also covers the case where skb_defer_max is lowered below the
current defer_count. The kick condition tests equality with half the
limit, so a reduction can move that point behind the counter and no
later producer ever reaches it; rejecting without a kick then strands a
non-empty list the same way. The reject-path kick recovers both.

While here, test the limit with > rather than >=, so the effective limit
is skb_defer_max rather than skb_defer_max - 1, matching what
Documentation/admin-guide/sysctl/net.rst describes.

That also makes the half-capacity kick reachable at small limits. At
skb_defer_max = 1 nothing was ever queued, so no kick was ever sent, and
at 2 the equality was never hit; both now kick. That is what commit
c09b0cd2cc6c ("net: avoid strange behavior with skb_defer_max == 1") set
out to allow.

Also drain before clearing in the flush. A producer that queues between
the clear and the drain currently has its skb drained but its increment
kept, which over-counts and costs deferral until the next flush.
Draining first matches the ordering __dev_xmit_skb() already uses for the
qdisc defer_list.

Found by manual code inspection, LLM-assisted, while backporting the
llist conversion to 6.1 after hitting the sd->defer_lock contention it
removes. The latch itself was not hit in production; it was reproduced by
lowering net.core.skb_defer_max.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Joseph Kain <jkain@nuro.ai>
---
v6:
 - Keep the increment and kick the purge from the reject path, rather
   than testing before incrementing as v4 did. One atomic instead of a
   read followed by an RMW, the increment still reserves the slot so the
   limit stays exact, and it also recovers the case where skb_defer_max
   is lowered below the current defer_count, which v4 did not
   (Kuniyuki Iwashima; also reported against v3 and v4 by
   netdev-bot sashiko, whose suggested fix this is).
 - Describe the two resulting behaviour changes -- the effective limit
   and the kick at small limits -- in the commit message rather than
   only here, since git am drops this part (netdev-bot sashiko).

Measured on v7.3-rc6 in a VM, 8 cpus, cross-CPU TCP load, sampling
defer_count via bpftrace. Dropping net.core.skb_defer_max from 128 to 1
and then restoring 128:

  7b63ef2d55f2 (unpatched)  defer_count climbed 701404 -> 3244783 and
                            stayed at 3244783 after restoring 128
  this patch                defer_count stayed within 0..1 throughout
                            and returned to 0

With skb_defer_max=1 and a cross-CPU TCP load, kick_defer_list_purge()
is called 0 times before this patch and ~756k times after, over ~750k
skb_attempt_defer_free() calls; at skb_defer_max=2, 0 before and ~163k
after.

Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT.

v4: https://lore.kernel.org/all/20261015162209.485940-1-jkain@nuro.ai/
v3: https://lore.kernel.org/all/20261013205416.3417296-1-jkain@nuro.ai/
v2: https://lore.kernel.org/all/20261008220256.1844072-1-jkain@nuro.ai/
v1: https://lore.kernel.org/all/20261007180056.1394868-1-jkain@nuro.ai/
 net/core/dev.c    | 5 ++++-
 net/core/skbuff.c | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index 4aea06d5167d..643666d9f4c9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7388,8 +7388,14 @@ nodefer:	kfree_skb_napi_cache(skb);
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
 	defer_count = atomic_long_inc_return(&sdn->defer_count);
 
-	if (defer_count >= defer_max)
+	if (unlikely(defer_count > defer_max)) {
+		/* The kept increment only comes back down when a flush zeroes
+		 * it, and this is the one path that sees a full queue.
+		 */
+		if (!llist_empty(&sdn->defer_list))
+			kick_defer_list_purge(cpu);
 		goto nodefer;
+	}
 
 	llist_add(&skb->ll_node, &sdn->defer_list);
 
-- 
2.55.0

