Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E22E762C
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820614; cv=none; b=RDBEaCokQxHuwU66HBSP4dLwGKCIfRfakSd1Lupz606mDL7/nl+yxRh2w+hICt+tB/NbuR4yS3w94s1M47DYo4Vkp4XQ8AC4LNBB67KlX89uR3fIm0FHAfqNxYZfLWmY9spM4imSAj5N5MK6+WtsR5LO2pa2xR3SVDa+eXdd0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820614; c=relaxed/simple;
	bh=lM3BWOR6vzSULwsazHjYUUDiwYe+rANYpB5oMdjXZR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRfm20GW4VGyLeXpVKKhJ2USSJO+cIqxL+szTHwfcivFA26rI4vH9wz7iI1Fz6c/sVJoAqNz+O4ASFNrLrwG/BfD+HDYnFvkCmpyKKVFLsPtRhbcIUTcvrAkFQ8reSPS1zu0AZ5tb+ozjWQ1M5eoBKewMbJTMO1JI45mMqOtyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=cxdbZDgn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="cxdbZDgn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8534d507f59so2156154b3a.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787820612; x=1788425412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSblFh9SdygbWEmnMuHjuKCtBFjstfFno9Vc56UGwcA=;
        b=cxdbZDgnlCQ+qk6SxQYcyeMfEiHsOXAJHJPXUfIn+6CDMtV11NsDE9FH/CE5O5OfC/
         11b5Ohy4vZq56Znvsqcl7HFlcNc3mNRPE8wZq/osBN1tEvevLQQ9TfirICJB4ut7Ff8C
         r9lHiuuKbP2ggtnhMb6hTtasn52aqRXCGyNOzr0PkvqSJ0Yh5/RNM8v5nflimU2W7wed
         dZMP/lYu8Nlc7X/DMGZrTJASykidMnbWKx3wOiEjaW94X058fB3EUfpOs3B0QSd95On0
         NC0XEP8qn747TQcrsO9usUc28iqx+o9ZlTZe6OXIipAAYvuwtmj4U/MxvGCUj9QH5XOf
         T1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820612; x=1788425412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSblFh9SdygbWEmnMuHjuKCtBFjstfFno9Vc56UGwcA=;
        b=M2mIKbvL4w5F4Pq2AJFxmto+qu4jQzaJA83Tf4oPu3AYZB5RsBHConCdvn+xa+DlSw
         q7QfwKpBnGesQxQUCcW/UnJ7NsfpgHbJMvUJQAg+WNwQoJgjGD0J8kP+FH/vKhkOp4cR
         j2sGlILqeIX0CqysQKVeAsXMm/Pypu4SwCWN0ioWyXBTuYdpgRWWSdq1+D+t7Xr+LH8a
         D7Bb0nY9IKSSIA+ud4Bzdly6AvyqeQXsuO5VIEu2GFcuLgF8Ybgty210I4ewwgq2hHBq
         m64t3A2HFGRibZfiQ51M3sTK7r9lEFjr0PAfdpj9wRmfSJ3Y+B42Vt/8tGPvoZGKHj9k
         6MYg==
X-Gm-Message-State: AFuF++mmVMASYSvcR+8o/f0CGlZR/BBVYlcZG+vXHw1Jbkcts//zriBO
	8URIjNAycDE3h3JDeuV9DoqETLvaQ9bHRS4pnpZrq5IGQ/Kqd5rU1umz+g1YcQEgyz96QDG9WZG
	FBPgcEjD8HvrqJg==
X-Gm-Gg: AR+sD13yn/7Ekvvs18jJ2CZYGqXO8PD4TcejE3jpmuA9cTY+XPN/bfMvJSI2P6T2dyR
	9P/PuS8M//RM+c8/9rjObMZbumm8ZwjbCRKoB6uZ1A2IEzbfjAZtKntjuO4FY61SOLKMeu5+SUM
	CjOjpBFDtbsNFzN+depR8CXAIicU45H/WWsOUt49UXd+59X1EgTbr4N3VLELq4GGumo9hB3BXdm
	Q682SBZIxb5d3+FRcjg1SIAjmUtmUdjL3uylrT1QqblJM8QJOueaeNmJNdypSxQtHXO2rPg3EpY
	IIPhb3TmDauTUbOr1pEchSeix51OI23aUujdHmJvdjJSI0bY7UCGzUpzdXtO5CoiAUd2wMuKIf6
	ovfxz2Fj1JxNokbrikHhANgPmoVy5+zz76rcssK4GhOY9qxad/jLWzP3edAVJjb1Mb62nafqbN3
	MkIXjapzNx7uPG2CcIQ0SabL+t90MlPui+B+qATDFR5auoWAxbnPYOh8by0qz9ZwcDY6aXGGEkp
	uaCvZuScYGbQrnaOoN15w==
X-Received: by 2002:a05:6a00:1392:b0:852:131f:b9d2 with SMTP id d2e1a72fcca58-853721a4ffamr23494315b3a.2.1787820596872;
        Thu, 27 Aug 2026 01:49:56 -0700 (PDT)
Received: from gmail.com ([42.88.197.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1beeb53absm1836637a12.32.2026.08.27.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:49:56 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v6 1/2] llc: fix listener child socket leaks before passive open completes
Date: Thu, 27 Aug 2026 08:49:37 +0000
Message-ID: <1114d39f0bbc2d39844817c1a0b89bb213e16ed4.1787752861.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787752861.git.zihanx@nebusec.ai>
References: <cover.1787752861.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_handler() creates and publishes a child whenever a listener
matches a packet. A non-SABME frame never completes the passive open, so
the child remains in the SAP tables, keeps its device reference, and
cannot be returned by accept().

Create children only for SABME commands. Handle the listener's required
DM replies directly, using the packet source address, and do not run the
listener through the connection state machine.

Keep SABME children in the SAP tables during the passive open so that
established lookup continues to select them. Track children until the
connection indication is queued for accept(), and release any child that
fails before then, including direct and backlog failures and listener
close. Reject redirected packets after the listener leaves TCP_LISTEN.

The child socket lock is acquired with bottom halves disabled whenever
the cleanup or backlog path runs in process context.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v6:
  - Hold a reference for children queued for accept() and release it when they
    are dequeued, while retaining SAP publication so tuple lookup still finds
    a pending child before the passive open completes.
  - Make direct receive, backlog, accept-queue, and listener-close cleanup
    symmetric, with bottom-half-disabled child locking in process context.
  - Keep the LLC_CONN_OUT_OF_SVC lower-bound check in its separate patch and
    use the ADM state boundary consistently.
  - v5 Link: https://lore.kernel.org/all/20260822082354.3109-1-zihanx@nebusec.ai/
changes in v5:
  - Make listener child cleanup unconditional so queued children are also
    released if the socket leaves TCP_LISTEN before close.
  - Serialize process-context child cleanup and backlog dispatch with bottom
    halves disabled, avoiding child-lock acquisition races with LLC receive
    and timer paths.
  - Drop packets redirected through a pending child after its listener is no
    longer listening, and release children left out of service instead of
    dispatching them.
  - Split the LLC_CONN_OUT_OF_SVC lower-bound check into a separate patch.
  - v4 Link: https://lore.kernel.org/all/20260814185843.4748-1-zihanx@nebusec.ai/
changes in v4:
  - Create a passive-open child only for SABME and generate listener-side DM
    replies directly for non-SABME commands.
  - Use an atomic incoming-child lifecycle and serialize pending-child lookup,
    backlog processing, rollback, and listener close with the child lock.
  - Keep immediate SAP publication for passive-open tuple matching, but release
    unaccepted children on direct and backlog failures and on listener close.
  - Defer final incoming-child cleanup to workqueue context so timer
    synchronization does not run in the receive softirq path.
  - Add an LLC state lower-bound check before state-table dispatch.
  - v3 Link: https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/
changes in v3:
  - Drop the unused llc_conn_handler() local rc variable reported in review.
  - Rebase the numbered patch and cover onto commit
    ede76849012e45ffb2193ad110b42027eec02c5c.
  - v2 Link: https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
changes in v2:
  - Rework the fix to preserve the existing passive-open tuple matching
    semantics instead of deferring child publication until LLC_CONN_PRIM.
  - Track listener-created children pending publication to accept(), and roll
    them back on every earlier failure or drop path.
  - Cover the original non-SABME leak and SABME paths which fail before
    LLC_CONN_PRIM, including backlog enqueue and backlog drop failures.
  - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the earliest
    locally visible history carrying the same root-cause fact.
  - Clarify panic_on_oom crash evidence and packetdrill selection.
  - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/
 include/net/llc_conn.h |  13 +-
 net/llc/af_llc.c       |  22 +++-
 net/llc/llc_conn.c     | 271 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 292 insertions(+), 14 deletions(-)

diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index e1a302696723..e8003db110ad 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -6,6 +6,7 @@
  * 		 2001, 2002 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  */
 #include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <net/llc_if.h>
 #include <net/sock.h>
 #include <linux/llc.h>
@@ -13,6 +14,10 @@
 #define LLC_EVENT                1
 #define LLC_PACKET               2
 
+#define LLC_INCOMING_NONE        0
+#define LLC_INCOMING_PENDING     1
+#define LLC_INCOMING_QUEUED      2
+
 #define LLC2_P_TIME               2
 #define LLC2_ACK_TIME             1
 #define LLC2_REJ_TIME             3
@@ -72,6 +77,9 @@ struct llc_sock {
 					      received and caused sending FRMR.
 					      Used for resending FRMR */
 	u32		    cmsg_flags;
+	atomic_t	    incoming_state;
+	struct sock	    *incoming_listener;
+	struct work_struct incoming_work;
 	struct hlist_node   dev_hash_node;
 };
 
@@ -93,7 +101,10 @@ static __inline__ char llc_backlog_type(struct sk_buff *skb)
 struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
 			  struct proto *prot, int kern);
 void llc_sk_stop_all_timers(struct sock *sk, bool sync);
-void llc_sk_free(struct sock *sk);
+void llc_sk_free(struct sock *sk, bool sync);
+void llc_release_incoming_sock(struct sock *sk);
+bool llc_accept_incoming_sock(struct sock *sk);
+void llc_release_incoming_children(struct sock *sk);
 
 void llc_sk_reset(struct sock *sk);
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b0447c33dbf0..e8054809cf0c 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -27,6 +27,7 @@
 #include <net/llc_sap.h>
 #include <net/llc_pdu.h>
 #include <net/llc_conn.h>
+#include <net/llc_c_st.h>
 #include <net/tcp_states.h>
 
 /* remember: uninitialized global data is zeroed because its in .bss */
@@ -196,6 +197,7 @@ static int llc_ui_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
+	bool listener;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -206,6 +208,9 @@ static int llc_ui_release(struct socket *sock)
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
+	listener = sk->sk_state == TCP_LISTEN;
+	if (listener)
+		sock_set_flag(sk, SOCK_DEAD);
 	if (!sock_flag(sk, SOCK_ZAPPED)) {
 		struct llc_sap *sap = llc->sap;
 
@@ -214,16 +219,18 @@ static int llc_ui_release(struct socket *sock)
 		 */
 		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
+		llc_release_incoming_children(sk);
 		release_sock(sk);
 		llc_sap_put(sap);
 	} else {
+		llc_release_incoming_children(sk);
 		release_sock(sk);
 	}
 	netdev_put(llc->dev, &llc->dev_tracker);
 	sock_put(sk);
 	sock_orphan(sk);
 	sock->sk = NULL;
-	llc_sk_free(sk);
+	llc_sk_free(sk, true);
 out:
 	return 0;
 }
@@ -722,6 +729,17 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 		goto frees;
 	rc = 0;
 	newsk = skb->sk;
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM ||
+	    !llc_accept_incoming_sock(newsk)) {
+		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+		    LLC_INCOMING_NONE)
+			llc_release_incoming_sock(newsk);
+		release_sock(newsk);
+		sock_put(newsk);
+		rc = -ECONNABORTED;
+		goto frees;
+	}
 	/* attach connection to a new socket. */
 	llc_ui_sk_init(newsock, newsk);
 	sock_reset_flag(newsk, SOCK_ZAPPED);
@@ -737,6 +755,8 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 	sk_acceptq_removed(sk);
 	dprintk("%s: ok success on %02X, client on %02X\n", __func__,
 		llc_sk(sk)->addr.sllc_sap, newllc->daddr.lsap);
+	release_sock(newsk);
+	sock_put(newsk);
 frees:
 	kfree_skb(skb);
 out:
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54..885a5c33024c 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void llc_incoming_sock_work(struct work_struct *work);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -88,6 +89,13 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 * skb->sk pointing to the newly created struct sock in
 		 * llc_conn_handler. -acme
 		 */
+		if (sk != skb->sk &&
+		    atomic_read(&llc_sk(skb->sk)->incoming_state) ==
+		    LLC_INCOMING_PENDING) {
+			sock_hold(skb->sk);
+			atomic_set(&llc_sk(skb->sk)->incoming_state,
+				   LLC_INCOMING_QUEUED);
+		}
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
 		sk->sk_state_change(sk);
@@ -765,27 +773,162 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
+	newllc->incoming_listener = sk;
+	atomic_set(&newllc->incoming_state, LLC_INCOMING_PENDING);
+	INIT_WORK(&newllc->incoming_work, llc_incoming_sock_work);
+	sock_hold(sk);
 	dev_hold(dev);
 	llc_sap_add_socket(llc->sap, newsk);
 out:
 	return newsk;
 }
 
+static void llc_incoming_sock_work(struct work_struct *work)
+{
+	struct llc_sock *llc = container_of(work, struct llc_sock,
+						    incoming_work);
+	struct sock *sk = &llc->sk;
+	struct sock *listener = llc->incoming_listener;
+
+	lock_sock(listener);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+	llc_sk_free(sk, false);
+	sock_orphan(sk);
+	release_sock(sk);
+	llc_sk_stop_all_timers(sk, true);
+	release_sock(listener);
+	dev_put(llc->dev);
+	llc->dev = NULL;
+	sock_put(sk);
+	sock_put(listener);
+}
+
+void llc_release_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (atomic_xchg(&llc->incoming_state, LLC_INCOMING_NONE) ==
+	    LLC_INCOMING_NONE)
+		return;
+
+	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
+	sock_hold(sk);
+	llc_sap_remove_socket(llc->sap, sk);
+	schedule_work(&llc->incoming_work);
+}
+
+bool llc_accept_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (atomic_cmpxchg(&llc->incoming_state, LLC_INCOMING_QUEUED,
+				  LLC_INCOMING_NONE) != LLC_INCOMING_QUEUED)
+		return false;
+
+	sock_put(llc->incoming_listener);
+	return true;
+}
+
+void llc_release_incoming_children(struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+		struct sock *newsk = skb->sk;
+
+		if (newsk && newsk != sk) {
+			int incoming_state;
+
+			bh_lock_sock_nested(newsk);
+			incoming_state =
+				atomic_read(&llc_sk(newsk)->incoming_state);
+			if (incoming_state != LLC_INCOMING_NONE) {
+				llc_release_incoming_sock(newsk);
+				if (incoming_state == LLC_INCOMING_QUEUED)
+					sock_put(newsk);
+			}
+			bh_unlock_sock(newsk);
+		}
+		kfree_skb(skb);
+	}
+	local_bh_enable();
+}
+
+/*
+ * This mirrors the ADM-state DM actions, but a listener has no peer
+ * address in llc->daddr yet.
+ */
+static void llc_conn_send_dm_rsp(struct llc_sap *sap, struct sk_buff *skb,
+				 struct llc_addr *saddr, u8 f_bit)
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
 void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_addr saddr, daddr;
-	struct sock *sk;
+	struct sock *sk, *newsk = NULL;
+	bool newsk_lookup_ref = false;
+	bool newsk_locked = false;
 
 	llc_pdu_decode_sa(skb, saddr.mac);
 	llc_pdu_decode_ssap(skb, &saddr.lsap);
 	llc_pdu_decode_da(skb, daddr.mac);
 	llc_pdu_decode_dsap(skb, &daddr.lsap);
 
+lookup:
 	sk = __llc_lookup(sap, &saddr, &daddr, dev_net(skb->dev));
 	if (!sk)
 		goto drop;
 
+	if (atomic_read(&llc_sk(sk)->incoming_state) ==
+	    LLC_INCOMING_PENDING) {
+		newsk = sk;
+		bh_lock_sock(newsk);
+		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+		    LLC_INCOMING_PENDING) {
+			bh_unlock_sock(newsk);
+			sock_put(newsk);
+			newsk = NULL;
+			goto lookup;
+		}
+		sk = llc_sk(newsk)->incoming_listener;
+		sock_hold(sk);
+		newsk_lookup_ref = true;
+		bh_unlock_sock(newsk);
+	}
+
 	bh_lock_sock(sk);
+	if (unlikely(sk->sk_state == TCP_LISTEN &&
+		     sock_flag(sk, SOCK_DEAD)))
+		goto drop_unlock;
+	if (newsk_lookup_ref) {
+		bh_lock_sock_nested(newsk);
+		newsk_locked = true;
+		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+		    LLC_INCOMING_PENDING)
+			goto retry_unlock;
+		if (unlikely(sk->sk_state != TCP_LISTEN ||
+			     sock_flag(sk, SOCK_DEAD))) {
+			llc_release_incoming_sock(newsk);
+			goto drop_unlock;
+		}
+	}
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,10 +938,25 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
-			goto drop_unlock;
+		if (!newsk) {
+			if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+				if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
+					u8 f_bit;
+
+					llc_pdu_decode_pf_bit(skb, &f_bit);
+					llc_conn_send_dm_rsp(sap, skb, &saddr, f_bit);
+				} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk, skb)) {
+					llc_conn_send_dm_rsp(sap, skb, &saddr, 1);
+				}
+				goto drop_unlock;
+			}
+			newsk = llc_create_incoming_sock(sk, skb->dev, &saddr,
+							 &daddr);
+			if (!newsk)
+				goto drop_unlock;
+			bh_lock_sock_nested(newsk);
+			newsk_locked = true;
+		}
 		skb_set_owner_r(skb, newsk);
 	} else {
 		/*
@@ -813,18 +971,49 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
+	if (unlikely(llc_sk(skb->sk)->state < LLC_CONN_STATE_ADM)) {
+		if (newsk) {
+			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
+		} else if (atomic_read(&llc_sk(sk)->incoming_state) ==
+			   LLC_INCOMING_PENDING) {
+			llc_release_incoming_sock(sk);
+		}
+		goto drop_unlock;
+	}
+	if (!sock_owned_by_user(sk)) {
 		llc_conn_rcv(sk, skb);
-	else {
+		if (newsk &&
+		    atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING)
+			llc_release_incoming_sock(newsk);
+	} else {
 		dprintk("%s: adding to backlog...\n", __func__);
 		llc_set_backlog_type(skb, LLC_PACKET);
-		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
+		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {
+			if (newsk)
+				llc_release_incoming_sock(newsk);
 			goto drop_unlock;
+		}
 	}
 out:
+	if (newsk_locked)
+		bh_unlock_sock(newsk);
 	bh_unlock_sock(sk);
 	sock_put(sk);
+	if (newsk_lookup_ref)
+		sock_put(newsk);
 	return;
+retry_unlock:
+	bh_unlock_sock(newsk);
+	newsk_locked = false;
+	bh_unlock_sock(sk);
+	sock_put(sk);
+	sock_put(newsk);
+	newsk = NULL;
+	newsk_lookup_ref = false;
+	goto lookup;
 drop:
 	kfree_skb(skb);
 	return;
@@ -852,12 +1041,52 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *newsk = skb->sk;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
+		if (newsk &&
+		    atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING) {
+			local_bh_disable();
+			bh_lock_sock_nested(newsk);
+			if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+			    LLC_INCOMING_PENDING) {
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+				goto retry;
+			}
+			if (sock_flag(sk, SOCK_DEAD) ||
+			    sk->sk_state != TCP_LISTEN ||
+			    llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
+				llc_release_incoming_sock(newsk);
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+				goto out_kfree_skb;
+			}
 			rc = llc_conn_rcv(sk, skb);
-		else
+			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
+			bh_unlock_sock(newsk);
+			local_bh_enable();
+		} else if (newsk &&
+			   atomic_read(&llc_sk(newsk)->incoming_state) ==
+			   LLC_INCOMING_QUEUED) {
+			local_bh_disable();
+			bh_lock_sock_nested(newsk);
+			if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+				goto out_kfree_skb;
+			}
+			rc = llc_conn_rcv(newsk, skb);
+			bh_unlock_sock(newsk);
+			local_bh_enable();
+		} else if (likely(llc->state > 1)) {
+			rc = llc_conn_rcv(sk, skb);
+		} else {
 			goto out_kfree_skb;
+		}
 	} else if (llc_backlog_type(skb) == LLC_EVENT) {
 		/* timer expiration event */
 		if (likely(llc->state > 1))  /* not closed */
@@ -870,6 +1099,23 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 out:
 	return rc;
+retry:
+	if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+	    LLC_INCOMING_QUEUED) {
+		local_bh_disable();
+		bh_lock_sock_nested(newsk);
+		if (llc_sk(newsk)->state >= LLC_CONN_STATE_ADM)
+			rc = llc_conn_rcv(newsk, skb);
+		else {
+			bh_unlock_sock(newsk);
+			local_bh_enable();
+			goto out_kfree_skb;
+		}
+		bh_unlock_sock(newsk);
+		local_bh_enable();
+		goto out;
+	}
+	goto out_kfree_skb;
 out_kfree_skb:
 	kfree_skb(skb);
 	goto out;
@@ -960,16 +1206,17 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
 /**
  *	llc_sk_free - Frees a LLC socket
  *	@sk: - socket to free
+ *	@sync: whether to synchronously stop timers
  *
  *	Frees a LLC socket
  */
-void llc_sk_free(struct sock *sk)
+void llc_sk_free(struct sock *sk, bool sync)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
 	llc->state = LLC_CONN_OUT_OF_SVC;
 	/* Stop all (possibly) running timers */
-	llc_sk_stop_all_timers(sk, true);
+	llc_sk_stop_all_timers(sk, sync);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
 		skb_queue_len(&llc->pdu_unack_q),
-- 
2.43.0

