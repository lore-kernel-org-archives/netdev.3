Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC0344021
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566100; cv=none; b=ZP0bN3UGOoiGbqa+Vw0eipu+VMymFkHOpt0KW4if467BEYFiuYNF+vbW0XX7SFb/J7YnXJ0fg3opUGzQdbuBieqwSI8urg/rYA7Y2igzN9qH0VYFkLjqN41fduaIl87zUMHVdvzXnclUKtYOKuzXnAODB3UeBVgSvmFpsB9g2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566100; c=relaxed/simple;
	bh=38wGNto74bxu2WAODltZOq4OXWmmlq4ZJPERCjlRvkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juxB3fHYDZ+Gtn0K2adJdizBxAIlKPl7jYp6sLD10ggJmsaJOF6aval+IfWnGkjsskFlQgsfx2KO4mI6gpJ5hEeYrcC7fJl7AD2EVvvvBXcWIE0hCAK7qAy+ow46hzato0btXwe7U/KZMKsKAObu4EiStGMIVmXa5X8yfE1VmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0HbMVJV; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0HbMVJV"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c54dc3a91so314524d50.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791566097; x=1792170897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4z3PQQeohjx7UQf7qRiQ7smvRMOM7QoLpAb02qh/eo=;
        b=k0HbMVJVgZeiWe7HtFMywv66dHR2+X0wh/KUUU603KYsRjv5IY4wBYP5flUCRRfY/H
         BpV4kUEuVqbdlEiUJYC/EBNQcE1lWEzA0uySP83ugboGLLj+s+IohHW8VkpS8JU4NQWS
         897qM7aaU2UknQK3ro7zS1QaU1z0bczpl2XjVayM5DIJXkxZt2MuTawc8BGC4Yi6bfRd
         xlLM4o7X0aDCIOyHHB5Gq9Qm4WcPQiAkQ9/w3y2NU5s7wBgCXg3Qp3R65pdgDkEYGweb
         93ppbqHt3GN4Il9UjlibR4uQjWrftognTTlAY4+hrQ091pAO0sRVblD3IApnpNGb3RDG
         QSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791566097; x=1792170897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E4z3PQQeohjx7UQf7qRiQ7smvRMOM7QoLpAb02qh/eo=;
        b=CBMwr//Z4GcsdfK/F9IQFO4qqdXsra/Pe2jCIao+wXZHJxS8lCbmCVe8b+dDWe6kXs
         7DsxjvoPHsScE73zVCxyAfyNmz2tVTf8dJdqeWMDarf7ahbZuH9XO90iW/4O+RP28eIM
         S/hEY7h/w+Xr4QGbmpRQhEZMGMgIECgZqFTMSaE4JFqCoyQHslADF8pRtH6rut/dC88U
         VpZgV16gLDFb4j8OfZ5HuErDASf2O+1HBS+2Kgtav/+lyT5BHrcopdExlAnGTn11Aniy
         5ouzc4EM5TccA+FHp9RSyMsIGwf+6AFVyARM8nMymE5WON4mqSNC22plpNAHaysuyalx
         xfcA==
X-Forwarded-Encrypted: i=1; AKwUvBzWVkW9FSZc77kfvaYfE0jh7iLK1cOpG9anJzMm8qU8MT9JBCHXOnDou58z4kdmxFEk3aYCQdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJk7Y2ZvGb+zTkVDTGBN6PuMxtaeEh0jbb3kl/LRDWjcgyQli4Z
	DGgJwKJ1dC0lHANXry7N7d0R0EHvhH/3lst0Esq73TZfOOEJBS3tUmK6
X-Gm-Gg: AYBFou2VfB4eEul/F5yKtDVXNY7Rno0YZ1wMcCZ1dUUH8D9hUggRfkm4qN9hPFDRXy0
	N6kJbBhCKAnmLP4q9/L5xMf28rEf0E/7dXe2Y5tTNwLh3o/zO9PNgrioLIRJyp9tYd7URQMSYrR
	Hi2fj3IsMOBXyK0xJWWQMNyFWP24kKS9yWQYzaZg62nPvqR4BzAjtYWLWpksdYc31dKcBuGYFoo
	cRql9TaSB6JttN038UwGSQccUnfvC04oi28bIL52Jn+FAQm8hA/r2PHiQrMBEzrC2HwJy/Ogyii
	ml3VgPwNHEgv+QVgN1sfg/ffvOtnOXzexzeXxaq9XlLuKuwLEpoVEmmbPR4GDRyicNqu5ukwC0T
	zDGuodVFFSKTTqg9ffBFu/kxZtVJxqUsJqX23FFKNkXVK1WRQn+eDCmuSeKoCQ79tGj+5nemJCq
	waFnKxwoabvoCBX3Wsxm8u66C5OPJhE6IlLajvYKEjMwqZL7Vgp4+zR/B6H26YGspJoYKKfz+49
	qvWpVlxr7B8jQkLgx4FqBCDCZzepyL8o8CZ2CVc5m1r26qDcjKdi1r8bNw=
X-Received: by 2002:a05:690e:13cf:b0:677:d251:ccb8 with SMTP id 956f58d0204a3-6793605d268mr1693320d50.4.1791566097218;
        Fri, 09 Oct 2026 10:14:57 -0700 (PDT)
Received: from yes.c.googlers.com.com (215.177.86.34.bc.googleusercontent.com. [34.86.177.215])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1e8682sm10990557b3.19.2026.10.09.10.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:14:56 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: edumazet@kernel.org
Cc: davem@davemloft.net,
	horms@kernel.org,
	jiayuan.chen@linux.dev,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ncardwell.sw@gmail.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	nramaswamy@openai.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	ycheng@google.com
Subject: Re: [PATCH net v3 3/3] selftests: net: packetdrill: test RTO fallback after partial undo
Date: Fri,  9 Oct 2026 10:14:47 -0700
Message-ID: <20261009171447.291802-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <CAL4Wiip9RyA-2=p0SVwBcn-oe0864FqqF3QMTCX_7=+ErcJp6Q@mail.gmail.com>
References: <CAL4Wiip9RyA-2=p0SVwBcn-oe0864FqqF3QMTCX_7=+ErcJp6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

On Fri, Oct 9, 2026 at 1:47#AM Eric Dumazet <edumazet@kernel.org> wrote:

> Let me come back to tp->tsorted_lost_queue [1]. I was too terse there
> ("often") and it did not get discussed.

Thanks, Eric. Given that you are OK with the space overhead for a new
tp->tsorted_lost_queue field, I think it would be quite nice to use your
suggested approach, since it should give us better loss recovery behavior.

FWIW, I asked an LLM to code up your idea, and below is what it came up with,
in case that is useful for discussion or using. It also proposed 2 packetdrill
tests (one that claims "This is the case that Eric suggested for segments with
TCPCB_EVER_RETRANS."), which I can post if there is interest.

---

From 919ec4af823300734104e42e855793ebd958c401 Mon Sep 17 00:00:00 2001
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 9 Oct 2026 07:18:41 -0700
Subject: [PATCH 1/2] tcp: restore RACK-lost skbs to tsorted_sent_queue on undo

RACK unlinks each skb that it marks lost from tp->tsorted_sent_queue, so
that later scans do not walk it again. The skb only returns to the list
when it is retransmitted. If an undo clears TCPCB_LOST before that, the
skb is on no list at all: RACK can never mark it lost again,
tcp_xmit_retransmit_queue() skips it, and only an RTO repairs it. This
happens for example after a partial undo in fast recovery, when PRR has
not yet retransmitted all the skbs that RACK marked lost.

As suggested by Eric, move the skbs that RACK marks lost to a new list,
tp->tsorted_lost_queue, instead of unlinking them. RACK scans the sent
queue in send order, and the skbs that a later scan marks lost were sent
later, so the lost queue stays sorted by send time without any sorting.
Nothing else needs to change: a retransmit moves the skb to the tail of
the sent queue, a SACK or cumulative ACK unlinks it, and tcp_fragment()
links the new skb next to the old one, in whichever list that is.
(Today, for an skb that RACK unlinked, tcp_fragment() builds a two-node
ring that is on no list.)

On undo, put the lost queue back into the sent queue. Usually every lost
skb was sent before every skb that is still in the sent queue, and one
list_splice_init() at the head does it. But the skbs that
tcp_timeout_mark_lost() marks stay in the sent queue, and RACK may later
move skbs sent after them to the lost queue. In that case, merge the two
sorted lists in one pass.

Unlike skipping skbs with TCPCB_EVER_RETRANS, this also restores skbs
that a TLP probed, or whose retransmit was lost, so that they do not
have to wait for an RTO either.

The cost is one list_head in tcp_sock, outside the fast path cache line
groups.

Fixes: 043b87d7599e ("tcp: more efficient RACK loss detection")
Reported-by: Neil Ramaswamy <nramaswamy@openai.com>
Closes: https://lore.kernel.org/netdev/cover.1791506907.git.nramaswamy@openai.com/
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Link: https://lore.kernel.org/netdev/CAL4Wiip9RyA-2=p0SVwBcn-oe0864FqqF3QMTCX_7=+ErcJp6Q@mail.gmail.com/
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  3 ++
 net/ipv4/tcp.c                                |  2 +
 net/ipv4/tcp_input.c                          | 51 +++++++++++++++++++
 net/ipv4/tcp_minisocks.c                      |  1 +
 net/ipv4/tcp_recovery.c                       |  9 +++-
 6 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 0f6088c4ab8bb..c5a4c06a5765d 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -34,6 +34,7 @@ u32                           compressed_ack_rcv_nxt
 u32                           tsoffset                read_mostly         read_mostly         tcp_established_options(tx);tcp_fast_parse_options(rx)
 struct list_head              tsq_node
 struct list_head              tsorted_sent_queue      read_write                              tcp_update_skb_after_send
+struct list_head              tsorted_lost_queue
 u32                           snd_wl1                                     read_mostly         tcp_may_update_window
 u32                           snd_wnd                 read_mostly         read_mostly         tcp_wnd_end,tcp_tso_should_defer(tx);tcp_fast_path_on(rx)
 u32                           max_window              read_mostly                             tcp_bound_to_half_wnd,forced_push
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a8c77719322f..98699d599f11e 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -377,6 +377,9 @@ struct tcp_sock {
 				 */
 	u32	compressed_ack_rcv_nxt;
 	struct list_head tsq_node; /* anchor in tsq_tasklet.head list */
+	struct list_head tsorted_lost_queue; /* time-sorted skbs that RACK
+					      * marked lost, until resent
+					      */
 
 	/* Information of the most recently (s)acked skb */
 	struct tcp_rack {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 562752352afe4..6cbf4d79824e2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -428,6 +428,7 @@ void tcp_init_sock(struct sock *sk)
 	tcp_init_xmit_timers(sk);
 	INIT_LIST_HEAD(&tp->tsq_node);
 	INIT_LIST_HEAD(&tp->tsorted_sent_queue);
+	INIT_LIST_HEAD(&tp->tsorted_lost_queue);
 
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
 
@@ -3352,6 +3353,7 @@ void tcp_write_queue_purge(struct sock *sk)
 	}
 	tcp_rtx_queue_purge(sk);
 	INIT_LIST_HEAD(&tcp_sk(sk)->tsorted_sent_queue);
+	INIT_LIST_HEAD(&tcp_sk(sk)->tsorted_lost_queue);
 	tcp_clear_all_retrans_hints(tcp_sk(sk));
 	tcp_sk(sk)->packets_out = 0;
 	inet_csk(sk)->icsk_backoff = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 92bc60716f33d..a18ee1bcf0138 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2840,6 +2840,56 @@ static void DBGUNDO(struct sock *sk, const char *msg)
 #endif
 }
 
+/* Was @a sent after @b, in the order of tp->tsorted_sent_queue? */
+static bool tcp_tsorted_after(const struct sk_buff *a, const struct sk_buff *b)
+{
+	return tcp_skb_sent_after(a->skb_mstamp_ns, b->skb_mstamp_ns,
+				  TCP_SKB_CB(a)->end_seq,
+				  TCP_SKB_CB(b)->end_seq);
+}
+
+/* Undo cleared the lost marks, so move the skbs that RACK marked lost back
+ * to tp->tsorted_sent_queue, in send order, where RACK can detect their
+ * loss again.
+ */
+static void tcp_tsorted_restore_lost(struct tcp_sock *tp)
+{
+	struct list_head *sent = &tp->tsorted_sent_queue;
+	struct list_head *lost = &tp->tsorted_lost_queue;
+	struct sk_buff *skb, *tmp, *pos;
+
+	if (list_empty(lost))
+		return;
+
+	/* Usually every lost skb was sent before every skb that is still in
+	 * the sent queue, so the lost queue goes back at the head. But the
+	 * skbs that tcp_timeout_mark_lost() marks stay in the sent queue,
+	 * and RACK may later move skbs sent after them to the lost queue.
+	 * Then merge the two queues, which are both sorted by send time.
+	 */
+	pos = list_first_entry(sent, struct sk_buff, tcp_tsorted_anchor);
+	if (list_empty(sent) ||
+	    !tcp_tsorted_after(list_last_entry(lost, struct sk_buff,
+					       tcp_tsorted_anchor), pos)) {
+		list_splice_init(lost, sent);
+		return;
+	}
+
+	list_for_each_entry_safe(skb, tmp, lost, tcp_tsorted_anchor) {
+		/* Find the first skb in the sent queue sent after skb. */
+		list_for_each_entry_from(pos, sent, tcp_tsorted_anchor) {
+			if (tcp_tsorted_after(pos, skb))
+				break;
+		}
+		if (list_entry_is_head(pos, sent, tcp_tsorted_anchor)) {
+			list_splice_tail_init(lost, sent);
+			return;
+		}
+		list_move_tail(&skb->tcp_tsorted_anchor,
+			       &pos->tcp_tsorted_anchor);
+	}
+}
+
 static void tcp_undo_cwnd_reduction(struct sock *sk, bool unmark_loss)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -2850,6 +2900,7 @@ static void tcp_undo_cwnd_reduction(struct sock *sk, bool unmark_loss)
 		skb_rbtree_walk(skb, &sk->tcp_rtx_queue) {
 			TCP_SKB_CB(skb)->sacked &= ~TCPCB_LOST;
 		}
+		tcp_tsorted_restore_lost(tp);
 		tp->lost_out = 0;
 		tcp_clear_all_retrans_hints(tp);
 	}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0ddfd5af6e58f..e73db6b70d079 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -580,6 +580,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	INIT_LIST_HEAD(&newtp->tsq_node);
 	INIT_LIST_HEAD(&newtp->tsorted_sent_queue);
+	INIT_LIST_HEAD(&newtp->tsorted_lost_queue);
 
 	tcp_init_wl(newtp, treq->rcv_isn);
 
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index 1396467510736..4258b00e28570 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -84,7 +84,14 @@ static void tcp_rack_detect_loss(struct sock *sk, u32 *reo_timeout)
 		remaining = tcp_rack_skb_timeout(tp, skb, reo_wnd);
 		if (remaining <= 0) {
 			tcp_mark_skb_lost(sk, skb);
-			list_del_init(&skb->tcp_tsorted_anchor);
+			/* Move the skb to the lost queue instead of just
+			 * unlinking it, so that undo can put it back. Each
+			 * scan marks skbs in send order, and the skbs a later
+			 * scan marks were sent later, so the lost queue stays
+			 * sorted by send time.
+			 */
+			list_move_tail(&skb->tcp_tsorted_anchor,
+				       &tp->tsorted_lost_queue);
 		} else {
 			/* Record maximum wait time */
 			*reo_timeout = max_t(u32, *reo_timeout, remaining);
-- 
2.56.0.385.gd3acb90ef8-goog

