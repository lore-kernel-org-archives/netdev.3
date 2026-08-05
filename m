Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2753CBE66
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952820; cv=none; b=CHXPoFFgcdcoeKijrCc+uSi6LpZ9WDtRPLM8SqsLOkK0snuczmnt3EB9OEgyZEQGWSZFrO81HfUPYBAwFmxoanu8f+V6iC4iRVLNJaVlr8VePlnl/Pad02vu7k1VtkugWFNpYC0W3NUS74+qq8YBpirzLaIHkwXCHMiwOZt4deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952820; c=relaxed/simple;
	bh=o2x4O3nXVP0jPfjlAt4R8g2yTqTrSanI0Y24T6z341k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWAKRfR+7eDoxRP+PvHRxw7yqH94AYanl77Y9TPy+U9x4RgNUdu7ybxFxp6JOmpWvh1QnIO9Ol46KZmKfCnE/ukedyc5whotJeiv/qMPSPUOlnkwKuTfVTDB4Nu+3FYmollEd13ej2j1tEfhFchebnNVn+5aa5NZRRz02ILvUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ZadL8mgK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ZadL8mgK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso1674154b3a.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785952818; x=1786557618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cH9MQie+IfriZJTxAI+WsEHeF0tH0Zs+jbzsWJtdpSM=;
        b=ZadL8mgKJbm/IMIV6TcZRSo4hl+Q4JXT6NflR1MYkvROe5y3rtGfmK8Y9Fj6BUdhBt
         Y+pp+Hbojr1FSwSGXibxN1vd/MWEpDFyeaJIx7FBIKv20XKEClMkKZ6jdSItu/vlFxrJ
         PaOgNAc/ECNvTpqRt2n6nQqQR/lJSMth+jK/9xYS8RrQXc0DU8Gtb9Iozk+6EqXrVO/k
         x5NTrmhmhoNFq7XVOxQOX+4UfCBRe6syTIzhE+scgl5kP7fEiOYF2kIpHzJtfM+ijaJ6
         BN5Kcc69can+OFM7eqzcJ5u3+CdCiOh7Xz25SwQYk+J0PTkoOs9mDaRac3gTG+hSNWmE
         UxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952818; x=1786557618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cH9MQie+IfriZJTxAI+WsEHeF0tH0Zs+jbzsWJtdpSM=;
        b=MWzYK/AMQeRPmAj9mdc5FPEHxdX8Vr4iSbc5MhxujSYfnnN1RvUV9tPQFdcFiLHjXA
         JjBB3CQUZZlORps5VU3wyso5jBYN2W1+JKtOb8UKbCreIxERGtsN+IT3D2To3DK9bo7Q
         plUKmyuy9SPJUneWP3LZo0g17YHhk628DSJP3/zavwZFcJEaXUsXE3IowhGILj+DAxr8
         qz4p/iiBVQ9ITESr9/ybu8xulvoNFPAAiDzWYKj+YInakCxw4GanjZf0ZPk2ZlPtdzzr
         /6+xC3pQe2MH5zGJzAo4EEcuorYvNLwk06IB4yO4qJgljP4O5+W9IxPNJ/fTYg40ri4N
         6Chg==
X-Gm-Message-State: AOJu0YxJypaekFvyJ9FdaEV6M6AavUMdTTldLz95oSFpzzxkRYi6rwUI
	Xrek4mG+EltPpPjjtMkXDw8Nf5jck1GuzGH9vfDO8RcGRRbD3WEWj33p1yCbkSEyOG1K0qM3hTS
	/obxpPleOJF0=
X-Gm-Gg: AR+sD13JbWDaXIdO3ukxJAA6eaFaNvOEfCTzuC4Lv+jwMz94JPMNlET4QaDxj1RbCRi
	xh0XxrtPvqdCZy4q1u2Z29b48L+HjdbYmvAcq+8I10Y07f6IjyIJU3N0vE8wvTGVVeXBBV/9Feq
	atfXOBBHnS4t18wUhNMZB2tXwjVp0mjnuSg7yV6Ek7VszSt0te3/7hfp7XAVEuLu9NYzBcN7EfJ
	uGg+4QKePUkNz/af6E7GjMK8/9ax3K9vdwiLW8yc2JOGvSs8VYuDPgKPKucN5+yYhbuj5T9JWjo
	aRyEClW3DLLqoD9g4VdxhO9GFL2/iDU+qYSHoL9lnZtEF2Q5r3kbcx57s41XUSQiB+by1Ahc0rP
	ZTxcSoEeV5BOj9Z41KncedxPBnU3EYGKikJwTOITvBdsqHTIl4EN7kKgOCSFvtvqyiCslFY5rq3
	/DyO9yw9FoJbjTmOt2q/kbkMnk7/599iLbweu9Vm4nNv8xa9OtZXD0DkuCGGSVd1x/yR6OzxbUQ
	pjSnhBz
X-Received: by 2002:a05:6a00:2e06:b0:848:75a1:a0fe with SMTP id d2e1a72fcca58-84f2e051953mr9203686b3a.18.1785952818171;
        Wed, 05 Aug 2026 11:00:18 -0700 (PDT)
Received: from localhost.localdomain ([115.192.254.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2e06a6sm1281316b3a.15.2026.08.05.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:00:17 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	tim.bird@sony.com,
	luoxuanqiang@kylinos.cn,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v3 1/1] llc: fix listener child socket leaks before passive open completes
Date: Wed,  5 Aug 2026 17:59:45 +0000
Message-ID: <20260805175945.10698-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805175945.10698-1-zihanx@nebusec.ai>
References: <20260805175945.10698-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_handler() creates and publishes a passive-open child before the
listener-side LLC state machine finishes the handshake and emits
LLC_CONN_PRIM to accept(). That child is inserted into the SAP tables
and takes a device reference immediately, so any listener path which
stops before LLC_CONN_PRIM leaves behind a published but unreachable
socket.

This is not limited to non-SABME traffic. Non-SABME frames can still
leave the child unpublished to accept(), and valid SABME traffic can do
the same when direct processing fails, backlog enqueue fails, or backlog
processing later drops the skb before LLC_CONN_PRIM is reached.

Keep the existing immediate publication semantics so established-socket
lookup continues to win over the listener during passive open. Instead,
track whether an incoming child is still pending publication to
accept(), clear that state only when LLC_CONN_PRIM is emitted, and roll
such children back out of the SAP tables on every failure and drop path
which exits earlier.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/net/llc_conn.h | 11 +++++++++++
 net/llc/llc_conn.c     | 41 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index e1a302696723..ba40194899fd 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -72,6 +72,7 @@ struct llc_sock {
 					      received and caused sending FRMR.
 					      Used for resending FRMR */
 	u32		    cmsg_flags;
+	u8		    incoming_pend;
 	struct hlist_node   dev_hash_node;
 };
 
@@ -90,6 +91,16 @@ static __inline__ char llc_backlog_type(struct sk_buff *skb)
 	return skb->cb[sizeof(skb->cb) - 1];
 }
 
+static __inline__ void llc_set_incoming_flag(struct sk_buff *skb, bool incoming)
+{
+	skb->cb[sizeof(skb->cb) - 2] = incoming;
+}
+
+static __inline__ bool llc_incoming_flag(const struct sk_buff *skb)
+{
+	return skb->cb[sizeof(skb->cb) - 2];
+}
+
 struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
 			  struct proto *prot, int kern);
 void llc_sk_stop_all_timers(struct sock *sk, bool sync);
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54..d2913b2164cd 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void llc_release_incoming_sock(struct sock *sk);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -88,6 +89,7 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 * skb->sk pointing to the newly created struct sock in
 		 * llc_conn_handler. -acme
 		 */
+		llc_sk(skb->sk)->incoming_pend = 0;
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
 		sk->sk_state_change(sk);
@@ -765,16 +767,32 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
+	newllc->incoming_pend = 1;
 	dev_hold(dev);
 	llc_sap_add_socket(llc->sap, newsk);
 out:
 	return newsk;
 }
 
+static void llc_release_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (!llc->incoming_pend)
+		return;
+
+	llc->incoming_pend = 0;
+	llc_sap_remove_socket(llc->sap, sk);
+	dev_put(llc->dev);
+	sock_orphan(sk);
+	llc_sk_free(sk);
+}
+
 void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_addr saddr, daddr;
 	struct sock *sk;
+	struct sock *newsk = NULL;
 
 	llc_pdu_decode_sa(skb, saddr.mac);
 	llc_pdu_decode_ssap(skb, &saddr.lsap);
@@ -795,11 +813,11 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
+		newsk = llc_create_incoming_sock(sk, skb->dev, &saddr, &daddr);
 		if (!newsk)
 			goto drop_unlock;
 		skb_set_owner_r(skb, newsk);
+		llc_set_incoming_flag(skb, true);
 	} else {
 		/*
 		 * Can't be skb_set_owner_r, this will be done at the
@@ -812,14 +830,22 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		sock_hold(sk);
 		skb->sk = sk;
 		skb->destructor = sock_efree;
+		llc_set_incoming_flag(skb, false);
 	}
-	if (!sock_owned_by_user(sk))
+	if (!sock_owned_by_user(sk)) {
 		llc_conn_rcv(sk, skb);
-	else {
+		if (newsk && llc_sk(newsk)->incoming_pend)
+			llc_release_incoming_sock(newsk);
+	} else {
 		dprintk("%s: adding to backlog...\n", __func__);
 		llc_set_backlog_type(skb, LLC_PACKET);
-		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
+		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {
+			if (newsk) {
+				skb_orphan(skb);
+				llc_release_incoming_sock(newsk);
+			}
 			goto drop_unlock;
+		}
 	}
 out:
 	bh_unlock_sock(sk);
@@ -852,6 +878,7 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *newsk = llc_incoming_flag(skb) ? skb->sk : NULL;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
 		if (likely(llc->state > 1)) /* not closed */
@@ -868,10 +895,14 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 		printk(KERN_ERR "%s: invalid skb in backlog\n", __func__);
 		goto out_kfree_skb;
 	}
+	if (newsk && llc_sk(newsk)->incoming_pend)
+		llc_release_incoming_sock(newsk);
 out:
 	return rc;
 out_kfree_skb:
 	kfree_skb(skb);
+	if (newsk && llc_sk(newsk)->incoming_pend)
+		llc_release_incoming_sock(newsk);
 	goto out;
 }
 
-- 
2.43.0

