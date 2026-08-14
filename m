Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFA33B6CC
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733960; cv=none; b=PLApqy77EqQuYhLhFUMKfN+RKnK5jxO+gHbbjR6j2KVMeCYhGUpDnDnxwDhRwxBrafbpI9UtUnh121tOooPA4LsTBKYYHPhT7U/HcmxtQk80InmisfulZL7AebIdyuIH4S9gbPpo6Q28DKuve1STD0B0g/FUCUO3fImYO7VbVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733960; c=relaxed/simple;
	bh=t4pjXXld1sQN4Tpe+ali5GcWFHj+tCSy5sEnU8NFAJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qST6DP3XnSuFSZpp9eKZruqN4fPHtzLJMztX/iZwnOCQfBZZjc2HzjG/SK9ln/z/tvVrZ3WPwbbw9/5rJEoQXNbymEsN1hV/sBCO4d80bIn63gBbMzTOhhYMQW2A8JVJeAnC6FOTZaSGRr3Js1cekbJ6UeXSlMOc11HDo/BCzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=c0WQ6qH0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="c0WQ6qH0"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1147276a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786733958; x=1787338758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dw+9AA1b6YHhHWuiGNZeZODpowDgdTQwWhIq2oFyUf4=;
        b=c0WQ6qH0tCCsMHOjgQtB017dkc2GC0aR0Kz6JocqjpI5fFSYqLaIu1D9XEQgP5qpKe
         ObY9hVNjyijA90ZqRmGmcTv0DXYt+8iEC1V/C2CPmcdH/j/G1t3+gLMMebwYHd+XNhek
         S+bqCi+wI5DQ2l/lbSnl+wLFEa0+PbF6J2pgeAXnn7KfpLj4KdCQX2QEXQEm46D/NC6E
         s8ELI0HQoVhrZkeUiuu3TMCpTWIueIWBgb6Ic+n1mMT8hEC+zS4GxGDAA64RV5s2K3qf
         v6DUcPm0l3xIgRDq+sDfp8IMC195qDosRanw2ab1eySfa3Hg8x8Ox2rvERy4TwxjSmL1
         O5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786733958; x=1787338758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dw+9AA1b6YHhHWuiGNZeZODpowDgdTQwWhIq2oFyUf4=;
        b=qJkmlULJ3MugXdiP9r4T0aqkd5m9PRdpGDFJCSaiQboJqGROOX44wOn3vQMGbPvbe2
         kWusgaEZ5yv0SJgOdAjJYdgUA37r2gVu4jcDUGeuMSjZZLFJ/iMtqm1oMXt9e+iFah7g
         l09d253lk+MPsi0TVDgQy5R0rzaRC2FiNACaXRBRLnLNCBxB88jdyTCwc+mBIu6bYADy
         A3vvdSg5S+Ql8mAyLC0UdibB5zkFKEhUI2Ka7zv/g/KQ1XwuMmeD0S02U1DQ1U3h4z+O
         yowRUuA1eK9ocdnu86PlNEjPtyMVu69MWdLWagcyeubwYzQG421M/Yg0HGwQuGQUB/jO
         GEiw==
X-Gm-Message-State: AOJu0YyMQZPhhGDoF1OjKKaxbLLZxuhNkEKRrORygwUa+WIKfg2mi8N2
	BrOmZtlaAYOmLyGuxSBfa/T+x+Obu1kpcB7tMQaPaXSLbj7x86gfqUzb9TJGDrgmuJiS8pn3nwY
	zC4LGPZ/PuoI=
X-Gm-Gg: AR+sD11yt9MSq0kFd9AFkxKKlFztyVO+JSz3YBYrGPjcJFvDFAfCwxWz9brcw7doGbX
	EKtAmotuiXRe7xopv9djbXNmJCR+4P9qk1tVpBVQFYaey0JgsesCrxxPnfna0oDips6k4FY/Log
	RFbAEZahD4UA9jNS9OgSOHhPc3235qiW3gOHU0Y5TR3zWGo7kuQ1kGGk46Xd/senszFI6Ui+Idy
	2ZbS/msKv0cW36DWydr9lnmOr8wtvk89N43zhMrPiNBWPsqk3xUqWTWmfglM1896mND6LoJTwib
	yAMIaxZxsyTBiVQzifkimTT5Ol8Mbcn7eWEyxNfUjy4qb4VZhE5lqulTSwxMKanEMBWfL+neOEc
	AlYF0WDXMc+UmSWNSB54ai+TnZ+FuXvEiTgORCrJcXkVktnsqfOfMHFmZYkpHsvU1pOualjJzOy
	4V/RA8ontai5FMFjzIRPs6l+emWuFHd3NJ5nGhm5jBUMpJ21kIZkv7KKt6v9x5BPSRpoEMaqM=
X-Received: by 2002:a17:90b:48c1:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3933b792c20mr9735179a91.9.1786733957847;
        Fri, 14 Aug 2026 11:59:17 -0700 (PDT)
Received: from localhost.localdomain ([115.204.183.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea96947dsm3636887a91.1.2026.08.14.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 11:59:17 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	leitao@debian.org,
	tim.bird@sony.com,
	shuangpeng.kernel@gmail.com,
	ernestas.k@iconn-networks.com,
	luoxuanqiang@kylinos.cn,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v4 1/1] llc: fix listener child socket leaks before passive open completes
Date: Fri, 14 Aug 2026 18:58:43 +0000
Message-ID: <20260814185843.4748-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814185843.4748-1-zihanx@nebusec.ai>
References: <20260814185843.4748-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_handler() creates and publishes a child whenever a listener
matches a packet.  A non-SABME frame never completes the passive open, so
the child remains in the SAP tables, keeps its device reference, and
cannot be returned by accept().

Create children only for SABME commands.  Handle the listener's required
DM replies directly, using the packet source address, and do not run the
listener through the connection state machine.

Keep SABME children in the SAP tables during the passive open so that
established lookup continues to select them.  Track children until the
connection indication is queued for accept(), and release any child that
fails before then, including direct and backlog failures and listener
close.  Defer the final release to process context so timers can be
safely synchronized.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---

Notes (llc-reroll-v4):
    changes in v4:
      - Create a child only for SABME and send listener-side DM responses directly
        to the peer for non-SABME commands.
      - Replace the unlocked pending flag with an atomic incoming-child lifecycle
        and serialize lookup, rollback, and backlog processing with the child lock.
      - Keep immediate SAP publication for passive-open tuple matching, while
        releasing unaccepted children on direct and backlog failures and on
        listener close.
      - Defer final child cleanup to workqueue context so timer synchronization
        does not occur from the receive softirq path.
      - Guard state-table dispatch against LLC_CONN_OUT_OF_SVC.
      - v3 Link: https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/
    changes in v3:
      - Drop the unused llc_conn_handler() local rc variable reported in review.
      - Rebase the numbered patch and cover onto commit
        ede76849012e45ffb2193ad110b42027eec02c5c.
      - v2 Link: https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
    changes in v2:
      - Rework the fix to preserve existing passive-open tuple matching instead
        of deferring child publication until LLC_CONN_PRIM.
      - Track listener-created children pending publication to accept(), and
        roll them back on every earlier failure or drop path.
      - Cover original non-SABME and SABME paths which fail before
        LLC_CONN_PRIM, including backlog enqueue and backlog drop failures.
      - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the
        earliest locally visible root-cause fact.
      - Clarify panic_on_oom crash evidence and packetdrill selection.
      - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

 include/net/llc_conn.h |  13 ++-
 net/llc/af_llc.c       |  11 +-
 net/llc/llc_conn.c     | 243 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 250 insertions(+), 17 deletions(-)

diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index e1a302696..9acda0a6f 100644
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
+void llc_accept_incoming_sock(struct sock *sk);
+void llc_release_incoming_children(struct sock *sk);
 
 void llc_sk_reset(struct sock *sk);
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b0447c33d..837b8e034 100644
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
 
@@ -214,16 +218,20 @@ static int llc_ui_release(struct socket *sock)
 		 */
 		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
+		if (listener)
+			llc_release_incoming_children(sk);
 		release_sock(sk);
 		llc_sap_put(sap);
 	} else {
+		if (listener)
+			llc_release_incoming_children(sk);
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
@@ -722,6 +730,7 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 		goto frees;
 	rc = 0;
 	newsk = skb->sk;
+	llc_accept_incoming_sock(newsk);
 	/* attach connection to a new socket. */
 	llc_ui_sk_init(newsock, newsk);
 	sock_reset_flag(newsk, SOCK_ZAPPED);
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50..bc05a5f66 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void llc_incoming_sock_work(struct work_struct *work);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -88,6 +89,11 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 * skb->sk pointing to the newly created struct sock in
 		 * llc_conn_handler. -acme
 		 */
+		if (sk != skb->sk &&
+		    atomic_read(&llc_sk(skb->sk)->incoming_state) ==
+		    LLC_INCOMING_PENDING)
+			atomic_set(&llc_sk(skb->sk)->incoming_state,
+				   LLC_INCOMING_QUEUED);
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
 		sk->sk_state_change(sk);
@@ -354,7 +360,8 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
 	struct llc_sock *llc = llc_sk(sk);
 	int rc = 1;
 
-	if (llc->state > NBR_CONN_STATES)
+	if (llc->state < LLC_CONN_STATE_ADM ||
+	    llc->state > NBR_CONN_STATES)
 		goto out;
 	rc = 0;
 	trans = llc_qualify_conn_ev(sk, skb);
@@ -765,27 +772,146 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
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
+void llc_accept_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (atomic_xchg(&llc->incoming_state, LLC_INCOMING_NONE) !=
+	    LLC_INCOMING_NONE)
+		sock_put(llc->incoming_listener);
+}
+
+void llc_release_incoming_children(struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+		struct sock *newsk = skb->sk;
+
+		if (newsk != sk)
+			bh_lock_sock_nested(newsk);
+		if (newsk != sk) {
+			llc_release_incoming_sock(newsk);
+			kfree_skb(skb);
+			bh_unlock_sock(newsk);
+		} else {
+			kfree_skb(skb);
+		}
+	}
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
+	if (unlikely(sock_flag(sk, SOCK_DEAD)))
+		goto drop_unlock;
+	if (newsk_lookup_ref) {
+		bh_lock_sock_nested(newsk);
+		newsk_locked = true;
+		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+		    LLC_INCOMING_PENDING)
+			goto retry_unlock;
+	}
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,10 +921,25 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
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
@@ -813,18 +954,38 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
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
@@ -852,12 +1013,38 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *newsk = NULL;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
+		newsk = skb->sk;
+		if (newsk &&
+		    atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING) {
+			bh_lock_sock_nested(newsk);
+			if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+			    LLC_INCOMING_PENDING) {
+				bh_unlock_sock(newsk);
+				goto retry;
+			}
+			if (sock_flag(sk, SOCK_DEAD) ||
+			    sk->sk_state != TCP_LISTEN)
+				goto out_unlock_newsk;
 			rc = llc_conn_rcv(sk, skb);
-		else
+			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
+			bh_unlock_sock(newsk);
+		} else if (newsk &&
+			   atomic_read(&llc_sk(newsk)->incoming_state) ==
+			   LLC_INCOMING_QUEUED) {
+			bh_lock_sock(newsk);
+			rc = llc_conn_rcv(newsk, skb);
+			bh_unlock_sock(newsk);
+		} else if (likely(llc->state > 1)) {
+			rc = llc_conn_rcv(sk, skb);
+		} else {
 			goto out_kfree_skb;
+		}
 	} else if (llc_backlog_type(skb) == LLC_EVENT) {
 		/* timer expiration event */
 		if (likely(llc->state > 1))  /* not closed */
@@ -870,8 +1057,33 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 out:
 	return rc;
+retry:
+	if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+	    LLC_INCOMING_QUEUED) {
+		bh_lock_sock(newsk);
+		rc = llc_conn_rcv(newsk, skb);
+		bh_unlock_sock(newsk);
+		goto out;
+	}
+	goto out_kfree_skb;
+out_unlock_newsk:
+	kfree_skb(skb);
+	if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+	    LLC_INCOMING_PENDING)
+		llc_release_incoming_sock(newsk);
+	bh_unlock_sock(newsk);
+	goto out;
 out_kfree_skb:
 	kfree_skb(skb);
+	if (newsk &&
+	    atomic_read(&llc_sk(newsk)->incoming_state) ==
+	    LLC_INCOMING_PENDING) {
+		bh_lock_sock_nested(newsk);
+		if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING)
+			llc_release_incoming_sock(newsk);
+		bh_unlock_sock(newsk);
+	}
 	goto out;
 }
 
@@ -959,17 +1171,18 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
 
 /**
  *	llc_sk_free - Frees a LLC socket
- *	@sk: - socket to free
+ *	@sk: socket to free
+ *	@sync: whether to synchronously stop timers
  *
- *	Frees a LLC socket
+ *	Frees a LLC socket.
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

