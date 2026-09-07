Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3A3EFFB9
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788752902; cv=none; b=QKyv2cZuj+dTIN9s0skF71gUc36iaj4+B+lCpJUfugJN95W9HxNHVjMqtSX8+6eXicLaKtaIW39Z/8aN7UD8qYARCRqIaEt9Ehce+nk1CxY9nXxFeZ5zKl6diT5UyraPHy//m+PEbH/O5Q8VC94TzBcW8GyUwcoFWnkGg3I6yQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788752902; c=relaxed/simple;
	bh=0OxDm3sX+okiJe42msPHCGrrex8siP7UYanpmyNJEhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEy396t01w8u+LAdSD8vfvM4LARmn9c8Lv/3L7QiWRNyNDomOIkzC3eVq9zzzNPIO6BBtom3xZ08d78kPodDUx3wXFk3NdKQJwE5bjNZrqMj4z07tcnCmN/BDxBWkPyP5zIk/2eafAd92l+ZVGKy5gWL1IZdouJchvg76twX1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=SlZYCZyP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="SlZYCZyP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d5335cf904so29952685ad.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788752899; x=1789357699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BoFVKvJRDYVdLtdp35MMper0mFagPmSwGXwn39mutLw=;
        b=SlZYCZyPb2KxMcRndrgbKgfTLb1GeXvoJDBrFrMJ7Dd9ImZ1kXBA+OcDtO+KI58Kuv
         lOZruKPvcdgeqoSETSO1mNDZidW4BxoR2WhHooIzftEXj/d0Utz+dUiNGLZ9MvcbIj+e
         44kRFMhgX4zD+Lznfqk4POWWRG7rRwj8BGw4PieuQstvyMNAP+FGGT95bBQDdscWjatv
         48aqMksqC6mqd3OQeNtkr+wec8NMEx/Ga6wN5mu12A/adI9v7EfGHzhCe4ST3ZTL88QS
         lM8Q4w50hJg5wjsoUJfalYiip3Vfj2d5tIS7QIagWX48j303M8ITbshwF3FxD8tzvPbV
         ugSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788752899; x=1789357699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BoFVKvJRDYVdLtdp35MMper0mFagPmSwGXwn39mutLw=;
        b=InZzdHsRM7xlSNEsib55iE1LkqVSRRTKC2BVEsRiboOXHrEUIvX28Ogcdv3LO2dKRs
         +yRdhKSpCkhEN+z+yO+5x4yFYCw0bjuM9fuk1r5Yp8e9rcdIH8LMIRSIto36qo9Q9SRa
         i6L6GYzCciN+4t5Tu9T+1UnwBbmZiqzABDFbvMCvzagxI+SczXiznP/rlXwwtzaEHVFm
         EVuecmRsOmlHGdeHK6GYB7jbyBr5YaG6ruPBYeW/Oi6xTCknAmQphtoAV48frKB0tEzB
         P5D1jBPvh6/kqAVLvmVugkqc25RTjCMr9+FLIARYth4Bw74u77UJqPq6RfumIytBfuyY
         /KgA==
X-Gm-Message-State: AFuF++k9EvVFzvMkJ2S+kJCuhKn5Y4QsD6yOWvmW1OQARf4/dhfzYHTB
	rCiyBl40ciDKXNvdfjkjINFHh1E5N32sziH/rhkhYT7Y/VkaAetVIi+laGb+XEmBbb7Ua6+BlQ8
	Wc8GWkUU9
X-Gm-Gg: AYBFou3BFO7QNLawp6vzqEzaX6Dddp9WsyD2mPUBqvquy09WPmFla+YRAlCLowAG8sS
	lQekaDa/O2DZrZhYnDXNwWy1uoLEl2vBOKyxy03sJznbrod0R2Z6CrB4B0NfPlK52gsDd1cNS/z
	JA+w5kxKleSD8/nl0GeUzsR5ZLJMFshHKr+MSWa6XWIKCsioTekueFmOpRwBxvhmUhkk9JNNq2f
	FcCwc83kL4C91Y59ZibcDEFYaoCMsX/5jiMtbj8tTwMuJFJ9RBKUmxSiOItgdCTvbaQn5XRLPXB
	L/ERPX98LaGG1YCZJp9J0jQIxHUhC8bxUtrH/h020vqB7+RjERAIszpodJHUYQJjxRLiMnBz67n
	C5suXBzWG8iK6Yaq4uMdEVVtFJIeO57es/qblCKkUDW7UnpwMjACgGkjr/xZFOCxOHlaEtfHa/A
	u0ELM5r9iHrpc4t2c8sgaeUkS1ndyvZ/bxH0lsMyO2ApzxwvWkWTidCD0EfF7OCt8rDJFk1Fi40
	AkLuB2ocU6aQJUoFSo=
X-Received: by 2002:a17:903:2b06:b0:2db:3729:22de with SMTP id d9443c01a7336-2db372924demr125899405ad.0.1788752895575;
        Sun, 06 Sep 2026 20:48:15 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1484105fsm37841105ad.10.2026.09.06.20.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 20:48:15 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v8 1/1] llc: fix listener child socket leaks before passive open completes
Date: Mon,  7 Sep 2026 03:47:51 +0000
Message-ID: <abc8b115321dbd417b8491d9e51f1988998ff50e.1788707641.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788707641.git.zihanx@nebusec.ai>
References: <cover.1788707641.git.zihanx@nebusec.ai>
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
close. Keep a listener-owned list of those children so close() can
release PENDING sockets that never reached the accept queue, instead of
relying only on later packets or backlog drain. Release pending children
for redirected packets after the listener leaves TCP_LISTEN or is marked
SOCK_DEAD. If a later redirected frame fails to enqueue on the listener
backlog, drop that frame only; do not tear down the already pending
child.

Do not queue a connection indication on the same socket that produced
it. That skb would make accept() call lock_sock_nested() on the listener
it already holds. Drop the extra QUEUED hold only when it was taken, both
on the accept() abort path and when close() walks leftover children.

Do not nested-lock a child against itself in llc_backlog_rcv(). A
QUEUED handshake skb can later be drained from that child's own
backlog, which already holds the socket lock.

Leftover listener-backlog frames for an incoming child run on that
child. If teardown has already moved it out of service, drop the frame
instead of using the listener's llc->state to drive the child's state
machine. If established lookup still returns that child during the RCU
grace period after unhash, drop the frame instead of running the state
machine with state 0. This is not a generic llc_conn_service bounds
check.

Handshake skbs keep a child socket reference with
skb_set_owner_sk_safe(). skb_set_owner_r() does not hold the socket, so
kfree_skb() on drop, accept-failure, and close paths could race
asynchronous teardown through sock_rfree().

Finish sock_orphan() and the device put before llc_sk_free(). That
helper already sock_put()s, so those steps must not run after its put
and rely only on the extra hold from llc_release_incoming_sock().

The child socket lock is acquired with bottom halves disabled whenever
the cleanup or backlog path runs in process context. Deferred child
teardown does not lock the listener; the child already holds a reference
to it until that work drops it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v8:
  - Reject a connection indication whose skb->sk is the listener itself
    so accept() cannot lock_sock_nested() the socket it already holds,
    and drop the extra QUEUED reference only when it was taken.
  - Drop the extra QUEUED hold from the incoming_children close walk,
    matching the receive-queue walk.
  - Do not run the connection state machine on a released incoming child
    from the listener backlog; leftover in-service child frames run on
    that child under its lock.
  - Limit out-of-service tests on the receive path to incoming children
    and to a looked-up child already marked out of service. SAP unhash
    is RCU, so drop that later lookup instead of indexing the state
    table with state 0. This is not a generic llc_conn_service bounds
    check.
  - Do not nested-lock a QUEUED child on itself in llc_backlog_rcv().
  - Sort the new locals in llc_release_incoming_children() reverse
    xmas tree.
  - Drop the unused #include <net/llc_c_st.h> from af_llc.c.
  - Keep this as the listener child leak and lifecycle fix only. The
    listen(2) accept-queue bound raised against v7 is independent of the
    leak and is not included here.
  - v7 Link: https://lore.kernel.org/all/cover.1788414881.git.zihanx@nebusec.ai/
 include/net/llc_conn.h |  15 +-
 net/llc/af_llc.c       |  27 +++-
 net/llc/llc_conn.c     | 353 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 379 insertions(+), 16 deletions(-)

diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index e1a3026967234..4fb5dedd46c4b 100644
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
@@ -72,6 +77,11 @@ struct llc_sock {
 					      received and caused sending FRMR.
 					      Used for resending FRMR */
 	u32		    cmsg_flags;
+	atomic_t	    incoming_state;
+	struct sock	    *incoming_listener;
+	struct list_head    incoming_node;
+	struct list_head    incoming_children;
+	struct work_struct incoming_work;
 	struct hlist_node   dev_hash_node;
 };
 
@@ -93,7 +103,10 @@ static __inline__ char llc_backlog_type(struct sk_buff *skb)
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
index b0447c33dbf09..eea4c5e4b2c9e 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -196,6 +196,7 @@ static int llc_ui_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
+	bool listener;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -206,6 +207,9 @@ static int llc_ui_release(struct socket *sock)
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
+	listener = sk->sk_state == TCP_LISTEN;
+	if (listener)
+		sock_set_flag(sk, SOCK_DEAD);
 	if (!sock_flag(sk, SOCK_ZAPPED)) {
 		struct llc_sap *sap = llc->sap;
 
@@ -214,16 +218,18 @@ static int llc_ui_release(struct socket *sock)
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
@@ -718,10 +724,23 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 		llc_sk(sk)->laddr.lsap);
 	skb = skb_dequeue(&sk->sk_receive_queue);
 	rc = -EINVAL;
-	if (!skb->sk)
+	if (!skb->sk || skb->sk == sk)
 		goto frees;
-	rc = 0;
 	newsk = skb->sk;
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	if (!llc_accept_incoming_sock(newsk)) {
+		int incoming_state =
+			atomic_read(&llc_sk(newsk)->incoming_state);
+
+		if (incoming_state != LLC_INCOMING_NONE)
+			llc_release_incoming_sock(newsk);
+		release_sock(newsk);
+		if (incoming_state == LLC_INCOMING_QUEUED)
+			sock_put(newsk);
+		rc = -ECONNABORTED;
+		goto frees;
+	}
+	rc = 0;
 	/* attach connection to a new socket. */
 	llc_ui_sk_init(newsock, newsk);
 	sock_reset_flag(newsk, SOCK_ZAPPED);
@@ -737,6 +756,8 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 	sk_acceptq_removed(sk);
 	dprintk("%s: ok success on %02X, client on %02X\n", __func__,
 		llc_sk(sk)->addr.sllc_sap, newllc->daddr.lsap);
+	release_sock(newsk);
+	sock_put(newsk);
 frees:
 	kfree_skb(skb);
 out:
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54c..7f9616afbd42f 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void llc_incoming_sock_work(struct work_struct *work);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -87,7 +88,19 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 * Can't be sock_queue_rcv_skb, because we have to leave the
 		 * skb->sk pointing to the newly created struct sock in
 		 * llc_conn_handler. -acme
+		 *
+		 * A connection indication belongs on the listener. If sk and
+		 * skb->sk are the same socket, queueing it would later make
+		 * accept() lock that socket against itself.
 		 */
+		if (sk == skb->sk)
+			break;
+		if (atomic_read(&llc_sk(skb->sk)->incoming_state) ==
+		    LLC_INCOMING_PENDING) {
+			sock_hold(skb->sk);
+			atomic_set(&llc_sk(skb->sk)->incoming_state,
+				   LLC_INCOMING_QUEUED);
+		}
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
 		sk->sk_state_change(sk);
@@ -765,27 +778,203 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
+	newllc->incoming_listener = sk;
+	atomic_set(&newllc->incoming_state, LLC_INCOMING_PENDING);
+	INIT_WORK(&newllc->incoming_work, llc_incoming_sock_work);
+	sock_hold(sk);
 	dev_hold(dev);
 	llc_sap_add_socket(llc->sap, newsk);
+	spin_lock_bh(&llc->sap->sk_lock);
+	list_add_tail(&newllc->incoming_node, &llc->incoming_children);
+	spin_unlock_bh(&llc->sap->sk_lock);
 out:
 	return newsk;
 }
 
+static void llc_incoming_sock_work(struct work_struct *work)
+{
+	struct llc_sock *llc = container_of(work, struct llc_sock,
+					    incoming_work);
+	struct sock *listener = llc->incoming_listener;
+	struct sock *sk = &llc->sk;
+
+	lock_sock(sk);
+	llc_sk_stop_all_timers(sk, false);
+	sock_orphan(sk);
+	release_sock(sk);
+	llc_sk_stop_all_timers(sk, true);
+	dev_put(llc->dev);
+	llc->dev = NULL;
+	llc_sk_free(sk, false);
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
+	spin_lock_bh(&llc->sap->sk_lock);
+	list_del_init(&llc->incoming_node);
+	spin_unlock_bh(&llc->sap->sk_lock);
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
+			   LLC_INCOMING_NONE) != LLC_INCOMING_QUEUED)
+		return false;
+
+	spin_lock_bh(&llc->sap->sk_lock);
+	list_del_init(&llc->incoming_node);
+	spin_unlock_bh(&llc->sap->sk_lock);
+	sock_put(llc->incoming_listener);
+	return true;
+}
+
+void llc_release_incoming_children(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
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
+	if (llc->sap) {
+		spin_lock(&llc->sap->sk_lock);
+		while (!list_empty(&llc->incoming_children)) {
+			struct llc_sock *child;
+			int incoming_state;
+			struct sock *newsk;
+
+			child = list_first_entry(&llc->incoming_children,
+						 struct llc_sock,
+						 incoming_node);
+			list_del_init(&child->incoming_node);
+			newsk = &child->sk;
+			sock_hold(newsk);
+			spin_unlock(&llc->sap->sk_lock);
+
+			bh_lock_sock_nested(newsk);
+			incoming_state = atomic_read(&child->incoming_state);
+			if (incoming_state != LLC_INCOMING_NONE)
+				llc_release_incoming_sock(newsk);
+			bh_unlock_sock(newsk);
+			if (incoming_state == LLC_INCOMING_QUEUED)
+				sock_put(newsk);
+			sock_put(newsk);
+			spin_lock(&llc->sap->sk_lock);
+		}
+		spin_unlock(&llc->sap->sk_lock);
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
+	struct sock *sk, *newsk = NULL;
+	bool newsk_lookup_ref = false;
 	struct llc_addr saddr, daddr;
-	struct sock *sk;
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
+		     sock_flag(sk, SOCK_DEAD) &&
+		     !newsk_lookup_ref))
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
+	/* SAP unhash is RCU; a torn-down child may still be looked up. */
+	if (!newsk &&
+	    unlikely(llc_sk(sk)->state < LLC_CONN_STATE_ADM))
+		goto drop_unlock;
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,11 +984,31 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
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
+		if (!skb_set_owner_sk_safe(skb, newsk)) {
+			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
 			goto drop_unlock;
-		skb_set_owner_r(skb, newsk);
+		}
 	} else {
 		/*
 		 * Can't be skb_set_owner_r, this will be done at the
@@ -813,18 +1022,45 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
+	if (newsk &&
+	    unlikely(llc_sk(newsk)->state < LLC_CONN_STATE_ADM)) {
+		if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING)
+			llc_release_incoming_sock(newsk);
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
+			if (newsk && !newsk_lookup_ref)
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
@@ -852,12 +1088,79 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *newsk = skb->sk;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
+		if (newsk &&
+		    atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING) {
+			if (newsk != sk) {
+				local_bh_disable();
+				bh_lock_sock_nested(newsk);
+			}
+			if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+			    LLC_INCOMING_PENDING) {
+				if (newsk != sk) {
+					bh_unlock_sock(newsk);
+					local_bh_enable();
+				}
+				goto retry;
+			}
+			if (sock_flag(sk, SOCK_DEAD) ||
+			    sk->sk_state != TCP_LISTEN ||
+			    llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
+				llc_release_incoming_sock(newsk);
+				if (newsk != sk) {
+					bh_unlock_sock(newsk);
+					local_bh_enable();
+				}
+				goto out_kfree_skb;
+			}
 			rc = llc_conn_rcv(sk, skb);
-		else
+			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
+			if (newsk != sk) {
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+			}
+		} else if (newsk &&
+			   atomic_read(&llc_sk(newsk)->incoming_state) ==
+			   LLC_INCOMING_QUEUED) {
+			if (newsk != sk) {
+				local_bh_disable();
+				bh_lock_sock_nested(newsk);
+			}
+			if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
+				if (newsk != sk) {
+					bh_unlock_sock(newsk);
+					local_bh_enable();
+				}
+				goto out_kfree_skb;
+			}
+			rc = llc_conn_rcv(newsk, skb);
+			if (newsk != sk) {
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+			}
+		} else if (newsk && newsk != sk) {
+			if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM)
+				goto out_kfree_skb;
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
@@ -870,6 +1173,29 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 out:
 	return rc;
+retry:
+	if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+	    LLC_INCOMING_QUEUED) {
+		if (newsk != sk) {
+			local_bh_disable();
+			bh_lock_sock_nested(newsk);
+		}
+		if (llc_sk(newsk)->state >= LLC_CONN_STATE_ADM) {
+			rc = llc_conn_rcv(newsk, skb);
+		} else {
+			if (newsk != sk) {
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+			}
+			goto out_kfree_skb;
+		}
+		if (newsk != sk) {
+			bh_unlock_sock(newsk);
+			local_bh_enable();
+		}
+		goto out;
+	}
+	goto out_kfree_skb;
 out_kfree_skb:
 	kfree_skb(skb);
 	goto out;
@@ -906,6 +1232,8 @@ static void llc_sk_init(struct sock *sk)
 	llc->rw = 128; /* rx win size (opt and equal to
 			* tx_win of remote LLC) */
 	skb_queue_head_init(&llc->pdu_unack_q);
+	INIT_LIST_HEAD(&llc->incoming_node);
+	INIT_LIST_HEAD(&llc->incoming_children);
 	sk->sk_backlog_rcv = llc_backlog_rcv;
 }
 
@@ -960,16 +1288,17 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
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

