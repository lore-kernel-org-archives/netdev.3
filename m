Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431843;
	b=vZHv5I9z8PSo0FM1LY1A4dM3qp90MnP6ZehoyVZEk6YGZ+fpcgq7KbATYTU7ya+iocPz
	 B34rRJALYjRIPdeumsLwAs6uwJydfji+MuhUNo71Xo6iw0PeNTXyIejAWfRhPpImDhCLk
	 oXeFhmWi3vK9LmI/3KK7a8KHf0tfrJaHcaiDssUSHHGw92X88SvzIONGZKfuqnMU12IyQ
	 rq4PGIKBwDkVgSDY2GOdZKQZ10mOIIjze7MrVMqn2Jeht9PjStT0xgV93Rc1jBgWoHK1Q
	 YdazBUwypQPaAYO7gleVZA9zEjDS34wE3gM7Aapo9J7OaYsKphWmvMnb6GOoKMtwQ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
	b=SKeZ3ZFqEP+C7MlIWwsJFtMJ/NFsqEjazIWfO3M3nFffzX4ouxRyK6IwFHLyEC9ZLSt/
	 YEUp4lDENuyeTmOe61q3j2x0EJwX72/TmQdsXUklsjOMPl44BPu0mArMIAJOpU9rZqxSQ
	 bayL+vUdKj/qUl/4u2Q9cUrUGVWj6Vytrm2tcCM4UBgtecEf5Pd0BlMRDDcggv8iP6/Hf
	 dotHMkXcCCienlETvr+VAQWE8uwMhurAjlYe+jAwdEB+mpIYCGzsuQpnL1L2MTSmutF+i
	 G2vi6JIvuiS6GgTuV6koXAw+YdOP27NYr39440p0RxjL9LHoB9dLGj3DFXZUQsDlwBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=XWibj6mf;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8E606A31D
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE8E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=XWibj6mf
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so2086472a91.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792431842; x=1793036642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
        b=XWibj6mf97Dl5MQ9HVMCmbYBw5FhZgkhf3TSzZI9GSbNO+FFmw/6G3I8ETbdsMnOpi
         zYRbnjB3qN2EmHf7mvTwR3Gjspvh/2E/LxCewlcCq6ZVd2/rkx0fWFDTAM6dXscU1Vg5
         xAhPyLgWSKDjJJHYhnvGqR5mBfqg2v74/tMaYN5xhWzc6pEEzToN9JnjO7RS8McWGXIp
         o13tdOB7hq1vKdUIdbQF71M0CKh2TYzZfllo9885LsxfFFqPtH9Co4cbxLzaDeUzGUaT
         sNpajKB1KJfU82T4kiIMZ1K/mRXuBADjBWa1LUSlJL5PfWreSmJfmgsv7fY+vaoUuk5T
         7yHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431842; x=1793036642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
        b=MNlfyADE1tEgMASp7j20Pnjsx/Njc6guV5SKMrttkdgk5TN1g3tyce51ZCVStBmH/T
         YDQSFnQ+IqmIIc5xmBx2SPCfEBrJ/6RezL65K4gczZCnORneQiv5umdGlaS/JwQQgq+B
         gnNnN0WDCnC8frBDhpuIy5Rw6WBf+wC38k54pwdx7NSfAhKWWlU6ATaaUFvtExb6Reb7
         P+s9DsrkwsAyLRvpmWxRflv1OSxBU0qArUfYSjxVcZIkJYQ88x1EV8nBlVIg96GHUQ8h
         EknSr6cUCQ5X5vYbP+M282EaJjcrmsoPlbuTNlt0cCyZY3obSCqY9ikZpORofPFFqCkY
         fm1g==
X-Gm-Message-State: AFq9FYJbY+c2xmx4yypLCKTmYkHvta7RGOL4Qm/E0LMd3SPlKjH0gRyS
	qaOZFWttjOpxxndl2DYB5v3/wU6hjSrM/X2jUtBBvpZvYxVtDsF6TNst77KmRoRZq2QKaZIbEHy
	QWty/uKE3i0M1t+qC1koAypQ/asKZYdR3nuv1X63W/SfHrxgggD165XFbF9oR+/7PgxLBrSL8CN
	ElEnISUI3im6qbsLwbifsEtNZBF+G4zK+Vel0=
X-Gm-Gg: AYBFou0oxHvc7mHkmmWgxcqyhSUVjyx7+dRvAYKNYs7R4SNTfC4QYmeY404ItJlxqj3
	0gVHxK2JAGfQOCIn1rxgYy01sYOf2UjnzSlX+EdR6Pd65o8HmxCjdncCsWFKnCtC3yaIL0O0TWw
	fqZXPd+rgV49LsHIOmJ190PgQiPX2M7JADUB6T5SMJoCC3o4GJOXpqOv83f/VEJLLbXHk9VeoYB
	qq3NTaVjtmCEQpVIsDZo65vr82WhfcfyHW0VkostT+GxXaQRaXg56Vmn7cYJGIpD4f22RKabLCZ
	OAtL4dmGZTF5YLLuUoBDrzYl5FAr/YphVGLxZpMNmtDCYyCeoUmJWMjY6AHcRBb9XeQ8A5v6j1c
	T7XX4spZBb4bjonZFb8e32xto68ccQLDUZCjFGhyR+qqo87VxIjbIVulHx6f8ISvRrw3GPxqY0L
	8ZyF+na0JSBY0Hyabvbg4/eyyLyxZFyVdr3pTZGzPfuX/LkFS2ok88hdG+OBD874HsqncdZOMJK
	jibcfksfs8=
X-Received: by 2002:a17:90b:4c4c:b0:3ac:450b:164c with SMTP id 98e67ed59e1d1-3acef15a266mr8174170a91.47.1792431842342;
        Mon, 19 Oct 2026 10:44:02 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d400505sm453912a91.4.2026.10.19.10.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:44:01 -0700 (PDT)
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
Date: Mon, 19 Oct 2026 10:44:00 -0700
Message-ID: <20261019174400.1377093-1-jkain@nuro.ai>
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

