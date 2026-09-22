Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B175326C0
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075142; cv=none; b=Q6Ng5r5sT2m86vq06+mXJlTutkuCiwb445y1qvCrOzWsqz6wSPR3f9XahO3KWgVNq5Hy7Kc9DYkYnQBagk/Z8fJxSwuBeFsfePqTai6f7YhpJozzF/4c29S0e6lopOiE9MnQW9P1Ed86p2IYDY+IIQK1DQWxDqRw+MdWNri1nlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075142; c=relaxed/simple;
	bh=vdpJQTeEtOllcXQJjVMU7hXgz2GEeQqRp8Z+KE+fl0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeV6fRcJfLKzjsQ7a6EzWiBgaLg+VIEkWsBOR8aNhAvAVBMwRmTbQLzHO39prkCo1R92KFNaOis3Pg45K5FEKFHQ29X21PF4VfBFeMVQszb53iVbBUBnQrmktAF6Wd17QmrXwZWhPBdBBmSlAO8Z9ehpLy4eTdOiHKhFklS26oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=JGOk2WGh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="JGOk2WGh"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so3009196a91.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790075138; x=1790679938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8b3QDIzUD0LXnbEbF+81PEacSx/x7ZJ2mY8am2vDV8=;
        b=JGOk2WGh75RHixn5UJEXtfegl4zUG7EIIonmZvG+hBRTYV4njPIBa1Qm6rtDWEPlTw
         CV+K4sh8G3JXt0sxINHJUly6sPxfv4K/siWD0J6J8MvGm4W4akpLA1/CBw9NEZ9Km9ZX
         xRbcH5Mo1sV6xZAwI1vZKp5SRK93snujwpLRJlA6lbjrZB6gqGbYIxPUC3adZxC4BKTS
         LW1o8YulXApMP5/mcgnqZAa0pgS59HdawjHPR6/v1MGoaWyj9sSAJGiivMulDTWJ9QNX
         P0bkRnL6B1T2dzbVrKB5dW7NbIdmqudExZmv6JicLEyebObhFkZZvgmf4oU2Ajdmh6J0
         I/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075138; x=1790679938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8b3QDIzUD0LXnbEbF+81PEacSx/x7ZJ2mY8am2vDV8=;
        b=FJxo/Jb6o4vZGvIQFcC4g7cUNqJf0mAdpgHpCofD+JvJzna9KPOJA9YlUcZe5wOcJh
         t3tfJYg5b1FTcBQ2qHD2+PRnGjtY5AIx/IArX3HJ1z5pSE+oFdsWPz3MJzmNuFLDSEP+
         oiEtR8EF9GJh0+7g4UExnaGrV/AfuAfPdgsiT4O1W/3a8uuqMa7s3b3lkii0hWZ9mMb+
         CIjEbo2jpPT8g+FDmjIb60M9Y4MiF7SstIpHoEB87WupJzRMtQnsjDZn682u/ffwYEtt
         HNbx8SAxqfaDz8VMPiq9O7V3Uy5Qw9XGq6OspXll3B7w0WL8ZgHOpJ21M7vswfAP7yBT
         i95g==
X-Gm-Message-State: AFuF++mpnvTuqTq7/OnT8hk+P9h2CEs/D+2pLn106enUppcj0w7TnWWR
	rCUUrN6F7EfkUsrOuGIFKd/TmD+Qh1REvBfdIGNMWxGEX8gfx52gRdT2H2nTmdIsdrm2/LQ/F9n
	EaMIBRahXX90=
X-Gm-Gg: AYBFou29lP+mfHnjl0pj+9Jwhtd3kIpnR9EmA4HaVajNNuQzm27B3ISXgxhcUSlQjky
	kVneJvNE6YgfTcPXMtokzDdNSMENRwqXyhSOoFd8hz443FS5QTGMErdyl/p35rhB3DD+R/KIl9D
	R2vBS3b+b5mHrTJ4BcVSU76h1hNDCACQc0gPb7bbFWrOj+oly6fTGYA+l7xTUYGQ9fo0u9fSuGp
	fUrFy8F2/dwPG9YzUxM/fz5G2JFzUWs9KXVBwknC6WEbzuCAMGdwnCPIpcGEriLtxm8Xru0EgpI
	ZTJ36dIAWWnG9lvezyMsWdAwVay4FgTiiZYZ/bh/cfneP+vh8D//+BtJrRm2sm4L8BXMZCXau8x
	OOQWc+sdErPbkHEAQwi+qlocozRBoC3YB/yok/ITPDSQmg2R8GDLK1OlwVyMy802eq2hRiy3rnq
	RHBRu87pqQM+afmDg9KELhWH/1bquKz1R29x71fprL+Sp6C2G3mZYf1s+JA9eHi0mYEPwHbTXmG
	t3xKTwT//j6ItG71NXy/1I/jTy1Bg==
X-Received: by 2002:a17:90b:4a88:b0:39e:6c68:1557 with SMTP id 98e67ed59e1d1-3a07324b450mr790008a91.31.1790075138203;
        Tue, 22 Sep 2026 04:05:38 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06741d485sm4382985a91.8.2026.09.22.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:05:37 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: zihanx@nebusec.ai,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net v11 1/1] llc: fix listener child socket leaks
Date: Tue, 22 Sep 2026 11:05:24 +0000
Message-ID: <8e9a9b20d10d978ac91105fa0eac4ee370d38189.1790062133.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790062133.git.zihanx@nebusec.ai>
References: <cover.1790062133.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_handler() used to create and publish a child socket for every
frame that matched a listening socket. Non-SABME frames never complete a
passive open, leaving the child in the SAP tables with its device
reference held and no path to accept().

Valid SABME frames could also accumulate without accounting for the
listener's accept backlog. A state-machine failure could strand a
published child, while listener teardown could free its connection
indication skb without releasing the child and its device reference.

Create children only for SABME commands. Answer DISC and other P=1
commands directly from the listener and drop the remaining non-SABME
frames. Defer child creation for listener-owned packets until backlog
admission succeeds, roll back children when passive-open processing
fails, and release queued children during listener teardown after freeing
their indication skbs.

Serialize child publication and teardown with the socket lock. Keep
bottom halves disabled while a backlog-created child is published and
processed, and use bottom-half exclusion for process-context teardown.
Reject stale or out-of-service lookup results before state-table dispatch
while keeping a pending SABME child hashed until passive-open processing
completes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v11:
  - Keep bottom halves disabled while a backlog-created child is locked,
    published, and processed, preventing same-CPU receive deadlock.
  - v10 Link:
    https://lore.kernel.org/all/cover.1789824800.git.zihanx@nebusec.ai/
changes in v10:
  - Reclaim SABME children when direct or backlog passive-open processing
    fails, and account successful indications against the accept backlog.
  - Defer child creation for listener-owned packets until backlog admission
    succeeds.
  - Release queued child sockets during listener teardown after freeing the
    indication skbs, including bottom-half-safe child locking.
  - Serialize child publication and packet processing with the child socket
    lock, and reject stale or out-of-service lookup results.
  - Keep the llc_ui_accept() NULL-dereference concern out of scope as a
    separate issue.
  - v9 Link:
    https://lore.kernel.org/all/cover.1789216793.git.zihanx@nebusec.ai/
---
 net/llc/llc_conn.c | 183 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 170 insertions(+), 13 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54c..eacc8c3ecc636 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void __llc_sk_free(struct sock *sk, bool sync);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -90,6 +91,8 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 */
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
+		if (sk->sk_state == TCP_LISTEN)
+			sk_acceptq_added(sk);
 		sk->sk_state_change(sk);
 		break;
 	case LLC_DISC_PRIM:
@@ -765,16 +768,101 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
-	dev_hold(dev);
+	netdev_hold(dev, &newllc->dev_tracker, GFP_ATOMIC);
+	/* Serialize packets that can find the child after it is hashed. */
+	bh_lock_sock_nested(newsk);
 	llc_sap_add_socket(llc->sap, newsk);
 out:
 	return newsk;
 }
 
+static struct sock *llc_create_incoming_sock_from_skb(struct sock *sk,
+						      struct sk_buff *skb)
+{
+	struct llc_addr saddr, daddr;
+
+	llc_pdu_decode_sa(skb, saddr.mac);
+	llc_pdu_decode_ssap(skb, &saddr.lsap);
+	llc_pdu_decode_da(skb, daddr.mac);
+	llc_pdu_decode_dsap(skb, &daddr.lsap);
+
+	return llc_create_incoming_sock(sk, skb->dev, &saddr, &daddr);
+}
+
+static bool llc_sk_unhashed(const struct sock *sk)
+{
+	return hlist_nulls_unhashed_lockless(&sk->sk_nulls_node);
+}
+
+static void llc_release_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	local_bh_disable();
+	bh_lock_sock_nested(sk);
+	llc->state = LLC_CONN_OUT_OF_SVC;
+	llc_sap_remove_socket(llc->sap, sk);
+	bh_unlock_sock(sk);
+	local_bh_enable();
+	netdev_put(llc->dev, &llc->dev_tracker);
+	sock_orphan(sk);
+	/* llc_sk_free() drops the allocation reference. */
+	llc_sk_free(sk);
+}
+
+static void llc_abort_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	/* The passive-open child is still locked by its creator. */
+	llc->state = LLC_CONN_OUT_OF_SVC;
+	llc_sap_remove_socket(llc->sap, sk);
+	bh_unlock_sock(sk);
+	netdev_put(llc->dev, &llc->dev_tracker);
+	sock_orphan(sk);
+	/* No child timer is armed before passive-open setup completes. */
+	__llc_sk_free(sk, false);
+}
+
+static void llc_conn_send_dm_rsp(struct llc_sap *sap, struct sk_buff *skb,
+				 const struct llc_addr *saddr, u8 f_bit)
+{
+	struct sk_buff *nskb;
+	int rc;
+
+	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, 0);
+	if (!nskb)
+		return;
+
+	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
+			    saddr->lsap, LLC_PDU_RSP);
+	llc_pdu_init_as_dm_rsp(nskb, f_bit);
+	rc = llc_mac_hdr_init(nskb, skb->dev->dev_addr, saddr->mac);
+	if (unlikely(rc))
+		kfree_skb(nskb);
+	else
+		dev_queue_xmit(nskb);
+}
+
+static void llc_listener_send_dm(struct llc_sap *sap, struct sock *sk,
+				 struct sk_buff *skb, const struct llc_addr *saddr)
+{
+	if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
+		u8 f_bit;
+
+		llc_pdu_decode_pf_bit(skb, &f_bit);
+		llc_conn_send_dm_rsp(sap, skb, saddr, f_bit);
+	} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk, skb)) {
+		llc_conn_send_dm_rsp(sap, skb, saddr, 1);
+	}
+}
+
 void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_addr saddr, daddr;
+	struct sock *newsk = NULL;
 	struct sock *sk;
+	int rc;
 
 	llc_pdu_decode_sa(skb, saddr.mac);
 	llc_pdu_decode_ssap(skb, &saddr.lsap);
@@ -786,6 +874,10 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		goto drop;
 
 	bh_lock_sock(sk);
+	if (unlikely(llc_sk_unhashed(sk)))
+		goto drop_unlock;
+	if (unlikely(llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC))
+		goto drop_unlock;
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,11 +887,18 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
+		if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+			llc_listener_send_dm(sap, sk, skb, &saddr);
 			goto drop_unlock;
-		skb_set_owner_r(skb, newsk);
+		} else if (!sock_owned_by_user(sk)) {
+			if (sk_acceptq_is_full(sk))
+				goto drop_unlock;
+			newsk = llc_create_incoming_sock(sk, skb->dev, &saddr,
+							 &daddr);
+			if (!newsk)
+				goto drop_unlock;
+			skb_set_owner_r(skb, newsk);
+		}
 	} else {
 		/*
 		 * Can't be skb_set_owner_r, this will be done at the
@@ -813,9 +912,15 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
-		llc_conn_rcv(sk, skb);
-	else {
+	if (!sock_owned_by_user(sk)) {
+		rc = llc_conn_rcv(sk, skb);
+		if (unlikely(rc) && newsk) {
+			llc_abort_incoming_sock(newsk);
+			goto out;
+		}
+		if (newsk)
+			bh_unlock_sock(newsk);
+	} else {
 		dprintk("%s: adding to backlog...\n", __func__);
 		llc_set_backlog_type(skb, LLC_PACKET);
 		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
@@ -852,12 +957,44 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *newsk = NULL;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
-			rc = llc_conn_rcv(sk, skb);
-		else
+		if (unlikely(sk->sk_state == TCP_LISTEN)) {
+			struct llc_addr saddr;
+
+			if (llc_sk_unhashed(sk))
+				goto out_kfree_skb;
+			if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+				llc_pdu_decode_sa(skb, saddr.mac);
+				llc_pdu_decode_ssap(skb, &saddr.lsap);
+				llc_listener_send_dm(llc->sap, sk, skb, &saddr);
+				goto out_kfree_skb;
+			}
+			if (sk_acceptq_is_full(sk))
+				goto out_kfree_skb;
+			/*
+			 * The child is locked before it is published.  Keep bottom
+			 * halves disabled until that lock is released so a packet
+			 * received on this CPU cannot deadlock on the child lock.
+			 */
+			local_bh_disable();
+			newsk = llc_create_incoming_sock_from_skb(sk, skb);
+			if (!newsk) {
+				local_bh_enable();
+				goto out_kfree_skb;
+			}
+			skb_set_owner_r(skb, newsk);
+		} else if (unlikely(llc->state <= 1)) {
 			goto out_kfree_skb;
+		}
+		rc = llc_conn_rcv(sk, skb);
+		if (unlikely(rc) && newsk)
+			llc_abort_incoming_sock(newsk);
+		else if (newsk)
+			bh_unlock_sock(newsk);
+		if (newsk)
+			local_bh_enable();
 	} else if (llc_backlog_type(skb) == LLC_EVENT) {
 		/* timer expiration event */
 		if (likely(llc->state > 1))  /* not closed */
@@ -964,18 +1101,38 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
  *	Frees a LLC socket
  */
 void llc_sk_free(struct sock *sk)
+{
+	__llc_sk_free(sk, true);
+}
+
+static void __llc_sk_free(struct sock *sk, bool sync)
 {
 	struct llc_sock *llc = llc_sk(sk);
+	struct sk_buff *skb;
 
 	llc->state = LLC_CONN_OUT_OF_SVC;
 	/* Stop all (possibly) running timers */
-	llc_sk_stop_all_timers(sk, true);
+	llc_sk_stop_all_timers(sk, sync);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
 		skb_queue_len(&llc->pdu_unack_q),
 		skb_queue_len(&sk->sk_write_queue));
 #endif
-	skb_queue_purge(&sk->sk_receive_queue);
+	/* Pending accept indications do not hold a reference to their child. */
+	if (sk->sk_state == TCP_LISTEN) {
+		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+			struct sock *newsk = skb->sk;
+
+			if (newsk && newsk != sk)
+				sk_acceptq_removed(sk);
+			/* sock_rfree() still needs skb->sk to charge the child. */
+			kfree_skb(skb);
+			if (newsk && newsk != sk)
+				llc_release_incoming_sock(newsk);
+		}
+	} else {
+		skb_queue_purge(&sk->sk_receive_queue);
+	}
 	skb_queue_purge(&sk->sk_write_queue);
 	skb_queue_purge(&llc->pdu_unack_q);
 #ifdef LLC_REFCNT_DEBUG
-- 
2.55.0.windows.3

