Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2C1EFFA1
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210009; cv=none; b=R8smAb98Xvwq08LqeKfeEzJozTmd2gf5XrK9F4Qu0cloo8/4edy2tcxL3ltVTp1DOtzQPVe82OYJAfhWMqRB0yFZyR0tDUA/rUuhBQJO0lBerBPFezpLsGoYQguDdFjwX61HO6lhDkMPF5i0GTLIc6Hlb67cfbdeH8y9d3ouG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210009; c=relaxed/simple;
	bh=DTSdPrlzYqQ2DeSoFyguMKcJxzLlwx7zDWW0X4p5BRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISMBTBUz8lxg9PU75t4EICpuUQcupnfXTHXx/kM7kmdJw+JJkuGrU0JypCeYiCgaLr6Rb9xlFGRP/tkMCO08cPUawR2OyZfw8CuKQUj26Lu1fvSZEoRnFmhnazKqyhYWz5aiKoEAOnRffdnzJ1W0ut1YnNiHwKEGhrkhxU11kRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XEgw4fhC; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XEgw4fhC"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so494155a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790210008; x=1790814808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UuQ0CZhhQu+eQJU1hc3HsftVbbZi60pDfaLFdUL4LGw=;
        b=XEgw4fhCjWv1d2ekUdjSkbPnMg7Uvf+yfBn7+mxQV/d443qq9Hwy4U6PAbZDjw6hYg
         M0RfN4BlLcsANa1HbCoqa21NB6H4oeweUc66KNcUg26uIaarqHoofWRjU3v+tdtvKxq8
         eTwdQ5DR9lTSnSfoeRGAqlDaXwaog4A0iX8/h9Wr1Bjrg0fNFGClJhq9IIwOpkCkO9de
         jHYuRL4Z8Emfbdhg2SdqOLABD0u7j7vsWjtrwd95V9KYGFihkusz4RqYfim3UZ1rTOUH
         6UhmWXTACpYgJMBJcM+FvuWQ3X5cGKZyOurlIQP0F8806xud4B5p7wVz47UqQi2aXYOI
         KbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790210008; x=1790814808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UuQ0CZhhQu+eQJU1hc3HsftVbbZi60pDfaLFdUL4LGw=;
        b=u0FRh0V3LCdDgmf+aN19TFKWmx6rxWvOglF5KKPdShSGZU9ibjihqv6StdrVXe3oRk
         ZpRTjzWR5QAhVD9VqCr9TRnkuACraXu/poluQcca2TgDiLG3hjKBBLUqTt7DTcJBJPDJ
         1M7vSBFe6JrXCUtQoo1UzYAwGSBpC03Z4QTO235Rd0k19c1m4pFZWkIKAzekfCyhS42P
         rAMKRBsu7sYETjWrxUQclvMUKdL5lmA0/LfyPVc2fg5R37nMw3Iafq6PGDIp/kpVSF4q
         r9qsaK/oWKu/0AJaX1IPwNrlysO0jJWC6pNFIXfjjYk8v0u5sWJS4yT01/Yyo6BH0GTO
         y29w==
X-Gm-Message-State: AFuF++mJEA/2WXWK75Wbpw+ztVcQDnr43O2JEy0PcinLEdXqRNLLtXY1
	3soxILyh59WyJjLucOvQ1XsTZZYAdPHiJSOqbBUxh2BMJeCNCJARtLsDF3NDSoLbz+oGb4w9Bfl
	ihZE7G4/a
X-Gm-Gg: AYBFou00dCiceLr89FZxACQIHaY/+Q7Ui7x8Xy1Qr46p8ZWmiORz/ANSSr8B+Sv3m0s
	PqfPyaDdedbr+4kzrl7M/DrivfzDYjszusgzUcvqdP1oyrKg62Fb7K0bwL0hghA7DRzA8UCO70W
	+gRFawuwF0/nVxhppn8r2dujUcIh6gU82vKsGrWQL+a/3Nz0IQ3cCh6i0xq6r0+KGipBKjGPLMl
	iCM56qIcQ7D8qKSWgNhuvvbwFL4nx9Xd+Fphn8EkV0UpzuS3H4qPeDpBDT9gsrMMnWJBnfW2XlQ
	Qz8CRfoZqFdU7iKzFl6rnK5UZ6l98oH38wAf/7z0cfNl/IAX5z1JGzVqzt2Ad+1xkPVOa8cqncb
	ND2DLHd42EJuDcs0FIejdMG2f5St/wCzeYTeCKIzSneuRGnd1bkMzayTjQmrr0TabRm4HNdiMPY
	M3juNvjzW7KC0SqbOAu854lgsS4KvYV/WEuj0/d0doPibr36mmhyAsSVtZA3AcDOx3
X-Received: by 2002:a05:6a21:4514:b0:3dd:a008:575e with SMTP id adf61e73a8af0-3de0e8cb487mr512275637.28.1790210007600;
        Wed, 23 Sep 2026 17:33:27 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([2a05:dfc1:8bc4:feda::14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c163bsm1987516b3a.28.2026.09.23.17.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 17:33:27 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	kuniyu@google.com,
	alice.kernel@fastmail.im,
	michael.bommarito@gmail.com,
	mail@david-bauer.net,
	jchapman@katalix.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] l2tp: bound the reorder queue
Date: Thu, 24 Sep 2026 08:32:57 +0800
Message-ID: <f0d62dc44f984114abe09f9b1d0432c98de7dbbf.1790136447.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790136447.git.caoruide123@gmail.com>
References: <cover.1790136447.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

The receive-window check accepts every sequence number in the large
window. If the peer omits the expected packet, distinct future packets
can therefore fill the ordered reorder queue. Since insertion walks the
queue and expiration was checked only while receiving another packet,
this allowed unbounded memory and CPU use.

Reject duplicate sequence numbers and cap the reorder queue at 64
packets. Packets beyond the cap are discarded, except that the expected
sequence number is admitted so an in-order packet can drain the queue.
The existing timeout recovery then skips a missing sequence number when
the queue limit is reached.

Use a session timer to run the existing dequeue path at the head
expiration and shut it down before purging a session. This bounds the
queue and services expiration even when the peer stops sending.

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/l2tp/l2tp_core.c | 57 +++++++++++++++++++++++++++++++++++++++++---
 net/l2tp/l2tp_core.h |  2 ++
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index f940914959b1..c92d4392f9b0 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -82,6 +82,7 @@
 #define L2TP_SL_SEQ_MASK   0x00ffffff
 
 #define L2TP_HDR_SIZE_MAX		14
+#define L2TP_REORDER_MAX_QUEUE	64
 
 /* Default trace flags */
 #define L2TP_DEFAULT_DEBUG_FLAGS	0
@@ -637,7 +638,22 @@ static void l2tp_recv_queue_skb(struct l2tp_session *session, struct sk_buff *sk
 	u32 ns = L2TP_SKB_CB(skb)->ns;
 
 	spin_lock_bh(&session->reorder_q.lock);
+	if (skb_queue_len(&session->reorder_q) >= L2TP_REORDER_MAX_QUEUE &&
+	    ns != session->nr) {
+		atomic_long_inc(&session->stats.rx_seq_discards);
+		atomic_long_inc(&session->stats.rx_errors);
+		kfree_skb(skb);
+		goto out;
+	}
+
 	skb_queue_walk_safe(&session->reorder_q, skbp, tmp) {
+		if (unlikely(L2TP_SKB_CB(skbp)->has_seq &&
+			     L2TP_SKB_CB(skbp)->ns == ns)) {
+			atomic_long_inc(&session->stats.rx_seq_discards);
+			atomic_long_inc(&session->stats.rx_errors);
+			kfree_skb(skb);
+			goto out;
+		}
 		if (L2TP_SKB_CB(skbp)->ns > ns) {
 			__skb_queue_before(&session->reorder_q, skbp, skb);
 			atomic_long_inc(&session->stats.rx_oos_packets);
@@ -651,6 +667,20 @@ static void l2tp_recv_queue_skb(struct l2tp_session *session, struct sk_buff *sk
 	spin_unlock_bh(&session->reorder_q.lock);
 }
 
+static bool l2tp_recv_queue_tail_skb(struct l2tp_session *session,
+				     struct sk_buff *skb)
+{
+	spin_lock_bh(&session->reorder_q.lock);
+	if (skb_queue_len(&session->reorder_q) >= L2TP_REORDER_MAX_QUEUE) {
+		spin_unlock_bh(&session->reorder_q.lock);
+		return false;
+	}
+	__skb_queue_tail(&session->reorder_q, skb);
+	spin_unlock_bh(&session->reorder_q.lock);
+
+	return true;
+}
+
 /* Dequeue a single skb.
  */
 static void l2tp_recv_dequeue_skb(struct l2tp_session *session, struct sk_buff *skb)
@@ -687,6 +717,7 @@ static void l2tp_recv_dequeue_skb(struct l2tp_session *session, struct sk_buff *
  */
 static void l2tp_recv_dequeue(struct l2tp_session *session)
 {
+	bool dequeued = false;
 	struct sk_buff *skb;
 	struct sk_buff *tmp;
 
@@ -706,6 +737,7 @@ static void l2tp_recv_dequeue(struct l2tp_session *session)
 			trace_session_pkt_expired(session, cb->ns);
 			session->reorder_skip = 1;
 			__skb_unlink(skb, &session->reorder_q);
+			dequeued = true;
 			kfree_skb(skb);
 			continue;
 		}
@@ -720,6 +752,7 @@ static void l2tp_recv_dequeue(struct l2tp_session *session)
 				goto out;
 		}
 		__skb_unlink(skb, &session->reorder_q);
+		dequeued = true;
 
 		/* Process the skb. We release the queue lock while we
 		 * do so to let other contexts process the queue.
@@ -730,9 +763,22 @@ static void l2tp_recv_dequeue(struct l2tp_session *session)
 	}
 
 out:
+	if (skb_queue_empty(&session->reorder_q))
+		timer_delete(&session->reorder_timer);
+	else if (dequeued || !timer_pending(&session->reorder_timer))
+		timer_reduce(&session->reorder_timer,
+			     L2TP_SKB_CB(skb_peek(&session->reorder_q))->expires);
 	spin_unlock_bh(&session->reorder_q.lock);
 }
 
+static void l2tp_recv_dequeue_timer(struct timer_list *timer)
+{
+	struct l2tp_session *session = timer_container_of(session, timer,
+							 reorder_timer);
+
+	l2tp_recv_dequeue(session);
+}
+
 static int l2tp_seq_check_rx_window(struct l2tp_session *session, u32 nr)
 {
 	u32 nws;
@@ -774,7 +820,8 @@ static int l2tp_recv_data_seq(struct l2tp_session *session, struct sk_buff *skb)
 	 * sequence number to re-enable packet reception.
 	 */
 	if (cb->ns == session->nr) {
-		skb_queue_tail(&session->reorder_q, skb);
+		if (!l2tp_recv_queue_tail_skb(session, skb))
+			goto discard;
 	} else {
 		u32 nr_oos = cb->ns;
 		u32 nr_next = (session->nr_oos + 1) & session->nr_max;
@@ -793,7 +840,8 @@ static int l2tp_recv_data_seq(struct l2tp_session *session, struct sk_buff *skb)
 			trace_session_pkt_oos(session, cb->ns);
 			goto discard;
 		}
-		skb_queue_tail(&session->reorder_q, skb);
+		if (!l2tp_recv_queue_tail_skb(session, skb))
+			goto discard;
 	}
 
 out:
@@ -986,7 +1034,8 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 		 * reorder queue. This ensures that it will be
 		 * delivered after all previous sequenced skbs.
 		 */
-		skb_queue_tail(&session->reorder_q, skb);
+		if (!l2tp_recv_queue_tail_skb(session, skb))
+			goto discard;
 	}
 
 	/* Try to dequeue as many skbs from reorder_q as we can. */
@@ -1748,6 +1797,7 @@ static void l2tp_session_del_work(struct work_struct *work)
 						    del_work);
 
 	l2tp_session_unhash(session);
+	timer_shutdown_sync(&session->reorder_timer);
 	l2tp_session_queue_purge(session);
 	if (session->session_close)
 		(*session->session_close)(session);
@@ -1804,6 +1854,7 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 			tunnel->tunnel_id, session->session_id);
 
 		skb_queue_head_init(&session->reorder_q);
+		timer_setup(&session->reorder_timer, l2tp_recv_dequeue_timer, 0);
 
 		session->hlist_key = l2tp_v3_session_hashkey(tunnel->sock, session->session_id);
 		INIT_HLIST_NODE(&session->hlist);
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index ffd8ced3a51f..6e4c1ef6a0a2 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -4,6 +4,7 @@
  * Copyright (c) 2008,2009 Katalix Systems Ltd
  */
 #include <linux/refcount.h>
+#include <linux/timer.h>
 
 #ifndef _L2TP_CORE_H_
 #define _L2TP_CORE_H_
@@ -80,6 +81,7 @@ struct l2tp_session {
 	u32			nr;		/* session NR state (receive) */
 	u32			ns;		/* session NR state (send) */
 	struct sk_buff_head	reorder_q;	/* receive reorder queue */
+	struct timer_list	reorder_timer;
 	u32			nr_max;		/* max NR. Depends on tunnel */
 	u32			nr_window_size;	/* NR window size */
 	u32			nr_oos;		/* NR of last OOS packet */
-- 
2.47.3

