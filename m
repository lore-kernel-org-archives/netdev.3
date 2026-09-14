Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B374A4779A8
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397952; cv=none; b=DMZwb6oWyNQ42hFP8KXUM7DwkYO4m4l8EoYbirC6cdysrg0QWIVFy2wqK5XDumzmHq7hEF0m/ieaNKyqFCVncaLqw6JmSmGgCRn0B9SnOUWXOynhWgBfUTDrZlDM6XcUSpIJhAm/bz1ZuWz+ldABSaaB8/xhMPbjThzaiPe+SOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397952; c=relaxed/simple;
	bh=ZNOD6+4hqNM2nt5VGIIwf/qOclBeKSLS7GIko0DWTv0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FUEV6Pt6Qy+Bbu3FlODaeO9ZpfelBYOGqI4b+UokkU1yIyG2Lxc3IignjEr558lEqp0ZHvmRi/gYJmfDRZMvb3yIKuutbRvOOEc2fzaMF/HO6QtUgNHzW2herwxL80WSPpgaKc6SYGTSMS8TGPcFakyBotKbYF56dwXDWnpVGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IT0KcJpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IT0KcJpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789397949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3APg9kiuMcI56GFb8ibKwpqhTdagUXiD858HDOe6yc=;
	b=IT0KcJpm0l/m0oJXA09ILcneT47GCp3YIVyFeqEZftc7b1u9HkkNh3hXmMDPAOyjihNlRr
	HyGFbUYTjVyCGC9BD7Tfxa32uFY15wwktDp3Re83AcKBgvpLWa//DeTcr4R3FjO/x8iU/O
	b9Z9ldu/GaLG7kELIcnIn8lChKCRZNg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-8ynCyAPCO_--RBiC_uvupg-1; Mon,
 14 Sep 2026 10:59:05 -0400
X-MC-Unique: 8ynCyAPCO_--RBiC_uvupg-1
X-Mimecast-MFC-AGG-ID: 8ynCyAPCO_--RBiC_uvupg_1789397942
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB30B19541A8;
	Mon, 14 Sep 2026 14:59:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FC9A40E;
	Mon, 14 Sep 2026 14:58:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260824150220.216067-1-nicoyip.dev@gmail.com>
References: <20260824150220.216067-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Take write lock when publishing the initial RxGK key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3226751.1789397935.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:58:55 +0100
Message-ID: <3226752.1789397935@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Chengfeng Ye <nicoyip.dev@gmail.com> wrote:

> On a client connection, a second sendmsg can observe
> RXRPC_CONN_CLIENT through a lockless load of conn->state,

I wonder if I need something like the attached also...  Or if it might do
instead, though I think there's no harm in doing your writelock suggestion
anyway.

David
---
commit 21a0c0765f5d2654379f3a0065b059e676d7c761
Author: David Howells <dhowells@redhat.com>
Date:   Mon Sep 14 14:40:13 2026 +0100

    rxrpc: Fix lack of conn->state barriering
    =

    Because rxrpc can manipulate the connection state in one thread and th=
en
    read it in another, but it also guards access to some members in the
    struct, it needs to have release/acquire barriers.  Fix this by using
    helpers to read/set the connection state.
    =

    Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O th=
read")
    Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/202609071137=
43.1453210-1-dhowells%40redhat.com
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Marc Dionne <marc.dionne@auristor.com>
    cc: Eric Dumazet <edumazet@google.com>
    cc: "David S. Miller" <davem@davemloft.net>
    cc: Jakub Kicinski <kuba@kernel.org>
    cc: Paolo Abeni <pabeni@redhat.com>
    cc: Simon Horman <horms@kernel.org>
    cc: linux-afs@lists.infradead.org

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index cb36a709f540..dde262ffc7fe 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -601,7 +601,7 @@ struct rxrpc_connection {
 	unsigned long		events;
 	unsigned long		idle_timestamp;	/* Time at which last became idle */
 	spinlock_t		state_lock;	/* state-change lock */
-	enum rxrpc_conn_proto_state state;	/* current state of connection */
+	enum rxrpc_conn_proto_state _state;	/* current state of connection */
 	enum rxrpc_call_completion completion;	/* Completion condition */
 	s32			abort_code;	/* Abort code of connection abort */
 	int			debug_id;	/* debug ID for printks */
@@ -1185,10 +1185,23 @@ void rxrpc_process_delayed_final_acks(struct rxrpc=
_connection *, bool);
 bool rxrpc_input_conn_packet(struct rxrpc_connection *conn, struct sk_buf=
f *skb);
 void rxrpc_input_conn_event(struct rxrpc_connection *conn, struct sk_buff=
 *skb);
 =

+static inline void rxrpc_set_conn_state(struct rxrpc_connection *conn,
+					enum rxrpc_conn_proto_state state)
+{
+	/* Order write of conn info before write of state. */
+	smp_store_release(&conn->_state, state);
+}
+
+static inline
+enum rxrpc_conn_proto_state rxrpc_conn_state(const struct rxrpc_connectio=
n *conn)
+{
+	/* Order read of state before read of conn info. */
+	return smp_load_acquire(&conn->_state);
+}
+
 static inline bool rxrpc_is_conn_aborted(const struct rxrpc_connection *c=
onn)
 {
-	/* Order reading the abort info after the state check. */
-	return smp_load_acquire(&conn->state) =3D=3D RXRPC_CONN_ABORTED;
+	return rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_ABORTED;
 }
 =

 /*
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 47824120f1da..1dcfd9e5fca4 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -398,8 +398,8 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local=
,
 		rx->app_ops->notify_new_call(&rx->sk, call, call->user_call_ID);
 =

 	spin_lock(&conn->state_lock);
-	if (conn->state =3D=3D RXRPC_CONN_SERVICE_UNSECURED) {
-		conn->state =3D RXRPC_CONN_SERVICE_CHALLENGING;
+	if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_SERVICE_UNSECURED) {
+		rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE_CHALLENGING);
 		set_bit(RXRPC_CONN_EV_CHALLENGE, &call->conn->events);
 		rxrpc_queue_conn(call->conn, rxrpc_conn_queue_challenge);
 	}
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 817ed9acb91e..29f9a01394c1 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -459,7 +459,7 @@ void rxrpc_incoming_call(struct rxrpc_sock *rx,
 =

 	spin_lock(&conn->state_lock);
 =

-	switch (conn->state) {
+	switch (rxrpc_conn_state(conn)) {
 	case RXRPC_CONN_SERVICE_UNSECURED:
 	case RXRPC_CONN_SERVICE_CHALLENGING:
 		__set_bit(RXRPC_CALL_CONN_CHALLENGING, &call->flags);
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..3055ef6fd11d 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -182,11 +182,12 @@ rxrpc_alloc_client_connection(struct rxrpc_bundle *b=
undle)
 	conn->upgrade		=3D bundle->upgrade;
 	conn->orig_service_id	=3D bundle->service_id;
 	conn->security_level	=3D bundle->security_level;
-	conn->state		=3D RXRPC_CONN_CLIENT_UNSECURED;
 	conn->service_id	=3D conn->orig_service_id;
 =

 	if (conn->security =3D=3D &rxrpc_no_security)
-		conn->state	=3D RXRPC_CONN_CLIENT;
+		rxrpc_set_conn_state(conn, RXRPC_CONN_CLIENT);
+	else
+		rxrpc_set_conn_state(conn, RXRPC_CONN_CLIENT_UNSECURED);
 =

 	atomic_inc(&rxnet->nr_conns);
 	write_lock(&rxnet->conn_lock);
@@ -206,6 +207,7 @@ rxrpc_alloc_client_connection(struct rxrpc_bundle *bun=
dle)
 static bool rxrpc_may_reuse_conn(struct rxrpc_connection *conn)
 {
 	struct rxrpc_net *rxnet;
+	enum rxrpc_conn_proto_state state;
 	int id_cursor, id, distance, limit;
 =

 	if (!conn)
@@ -215,8 +217,9 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connecti=
on *conn)
 	if (test_bit(RXRPC_CONN_DONT_REUSE, &conn->flags))
 		goto dont_reuse;
 =

-	if ((conn->state !=3D RXRPC_CONN_CLIENT_UNSECURED &&
-	     conn->state !=3D RXRPC_CONN_CLIENT) ||
+	state =3D rxrpc_conn_state(conn);
+	if ((state !=3D RXRPC_CONN_CLIENT_UNSECURED &&
+	     state !=3D RXRPC_CONN_CLIENT) ||
 	    conn->proto.epoch !=3D rxnet->epoch)
 		goto mark_dont_reuse;
 =

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..f60bceff0bad 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -25,14 +25,13 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_connec=
tion *conn,
 {
 	bool aborted =3D false;
 =

-	if (conn->state !=3D RXRPC_CONN_ABORTED) {
+	if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_ABORTED) {
 		spin_lock_irq(&conn->state_lock);
-		if (conn->state !=3D RXRPC_CONN_ABORTED) {
+		if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_ABORTED) {
 			conn->abort_code =3D abort_code;
 			conn->error	 =3D err;
 			conn->completion =3D compl;
-			/* Order the abort info before the state change. */
-			smp_store_release(&conn->state, RXRPC_CONN_ABORTED);
+			rxrpc_set_conn_state(conn, RXRPC_CONN_ABORTED);
 			set_bit(RXRPC_CONN_DONT_REUSE, &conn->flags);
 			set_bit(RXRPC_CONN_EV_ABORT_CALLS, &conn->events);
 			aborted =3D true;
@@ -272,7 +271,7 @@ static int rxrpc_process_event(struct rxrpc_connection=
 *conn,
 	bool secured =3D false;
 	int ret;
 =

-	if (conn->state =3D=3D RXRPC_CONN_ABORTED)
+	if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_ABORTED)
 		return -ECONNABORTED;
 =

 	_enter("{%d},{%u,%%%u},", conn->debug_id, sp->hdr.type, sp->hdr.serial);
@@ -286,7 +285,7 @@ static int rxrpc_process_event(struct rxrpc_connection=
 *conn,
 =

 	case RXRPC_PACKET_TYPE_RESPONSE:
 		spin_lock_irq(&conn->state_lock);
-		if (conn->state !=3D RXRPC_CONN_SERVICE_CHALLENGING) {
+		if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_SERVICE_CHALLENGING) {
 			spin_unlock_irq(&conn->state_lock);
 			return 0;
 		}
@@ -302,8 +301,8 @@ static int rxrpc_process_event(struct rxrpc_connection=
 *conn,
 			return ret;
 =

 		spin_lock_irq(&conn->state_lock);
-		if (conn->state =3D=3D RXRPC_CONN_SERVICE_CHALLENGING) {
-			conn->state =3D RXRPC_CONN_SERVICE;
+		if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_SERVICE_CHALLENGING) {
+			rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE);
 			secured =3D true;
 		}
 		spin_unlock_irq(&conn->state_lock);
@@ -548,7 +547,7 @@ void rxrpc_input_conn_event(struct rxrpc_connection *c=
onn, struct sk_buff *skb)
 		conn->tx_response =3D NULL;
 		spin_unlock_irq(&conn->local->lock);
 =

-		if (conn->state !=3D RXRPC_CONN_ABORTED)
+		if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_ABORTED)
 			rxrpc_send_response(conn, skb);
 		rxrpc_free_skb(skb, rxrpc_skb_put_response);
 	}
@@ -556,7 +555,7 @@ void rxrpc_input_conn_event(struct rxrpc_connection *c=
onn, struct sk_buff *skb)
 	if (skb) {
 		switch (skb->mark) {
 		case RXRPC_SKB_MARK_SERVICE_CONN_SECURED:
-			if (conn->state !=3D RXRPC_CONN_SERVICE)
+			if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_SERVICE)
 				break;
 =

 			for (loop =3D 0; loop < RXRPC_MAXCALLS; loop++)
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 1be50e0c9cee..12914fb72345 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -407,7 +407,7 @@ void rxrpc_service_connection_reaper(struct work_struc=
t *work)
 		ASSERTCMP(atomic_read(&conn->active), >=3D, 0);
 		if (likely(atomic_read(&conn->active) > 0))
 			continue;
-		if (conn->state =3D=3D RXRPC_CONN_SERVICE_PREALLOC)
+		if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_SERVICE_PREALLOC)
 			continue;
 =

 		if (rxnet->live && !conn->local->dead) {
diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index 39c908a3ca6e..04a8206f3a44 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -126,7 +126,7 @@ struct rxrpc_connection *rxrpc_prealloc_service_connec=
tion(struct rxrpc_net *rxn
 		/* We maintain an extra ref on the connection whilst it is on
 		 * the rxrpc_connections list.
 		 */
-		conn->state =3D RXRPC_CONN_SERVICE_PREALLOC;
+		rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE_PREALLOC);
 		refcount_set(&conn->ref, 2);
 =

 		atomic_inc(&rxnet->nr_conns);
@@ -161,10 +161,6 @@ void rxrpc_new_incoming_connection(struct rxrpc_sock =
*rx,
 	conn->security_ix	=3D sp->hdr.securityIndex;
 	conn->out_clientflag	=3D 0;
 	conn->security		=3D sec;
-	if (conn->security_ix)
-		conn->state	=3D RXRPC_CONN_SERVICE_UNSECURED;
-	else
-		conn->state	=3D RXRPC_CONN_SERVICE;
 =

 	/* See if we should upgrade the service.  This can only happen on the
 	 * first packet on a new connection.  Once done, it applies to all
@@ -174,6 +170,11 @@ void rxrpc_new_incoming_connection(struct rxrpc_sock =
*rx,
 	    conn->service_id =3D=3D rx->service_upgrade.from)
 		conn->service_id =3D rx->service_upgrade.to;
 =

+	if (conn->security_ix)
+		rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE_UNSECURED);
+	else
+		rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE);
+
 	atomic_set(&conn->active, 1);
 =

 	/* Make the connection a target for incoming packets. */
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index e9a27fa7b25d..99d2c850b94e 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -146,6 +146,7 @@ static int rxrpc_connection_seq_show(struct seq_file *=
seq, void *v)
 	struct rxrpc_connection *conn;
 	struct rxrpc_net *rxnet =3D rxrpc_net(seq_file_net(seq));
 	const char *state;
+	enum rxrpc_conn_proto_state cstate;
 	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 =

 	if (v =3D=3D &rxnet->conn_proc_list) {
@@ -159,7 +160,8 @@ static int rxrpc_connection_seq_show(struct seq_file *=
seq, void *v)
 	}
 =

 	conn =3D list_entry(v, struct rxrpc_connection, proc_link);
-	if (conn->state =3D=3D RXRPC_CONN_SERVICE_PREALLOC) {
+	cstate =3D rxrpc_conn_state(conn);
+	if (cstate =3D=3D RXRPC_CONN_SERVICE_PREALLOC) {
 		strcpy(lbuff, "no_local");
 		strcpy(rbuff, "no_connection");
 		goto print;
@@ -168,9 +170,9 @@ static int rxrpc_connection_seq_show(struct seq_file *=
seq, void *v)
 	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &conn->local->srx.transport);
 	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &conn->peer->srx.transport);
 print:
-	state =3D rxrpc_is_conn_aborted(conn) ?
+	state =3D (cstate =3D=3D RXRPC_CONN_ABORTED) ?
 		rxrpc_call_completions[conn->completion] :
-		rxrpc_conn_states[conn->state];
+		rxrpc_conn_states[cstate];
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %08x %s %3u %3d"
 		   " %s %08x %08x %08x %08x %08x %08x %08x\n",
diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index 2bfbf2b2bb37..f64acaa6cf53 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -114,12 +114,12 @@ int rxrpc_init_client_conn_security(struct rxrpc_con=
nection *conn)
 =

 found:
 	mutex_lock(&conn->security_lock);
-	if (conn->state =3D=3D RXRPC_CONN_CLIENT_UNSECURED) {
+	if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_CLIENT_UNSECURED) {
 		ret =3D conn->security->init_connection_security(conn, token);
 		if (ret =3D=3D 0) {
 			spin_lock_irq(&conn->state_lock);
-			if (conn->state =3D=3D RXRPC_CONN_CLIENT_UNSECURED)
-				conn->state =3D RXRPC_CONN_CLIENT;
+			if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_CLIENT_UNSECURED)
+				rxrpc_set_conn_state(conn, RXRPC_CONN_CLIENT);
 			spin_unlock_irq(&conn->state_lock);
 		}
 	}
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index ed7ff32da184..dcbd2033ca01 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -336,7 +336,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	if (ret < 0)
 		goto out_unlock;
 =

-	if (call->conn->state =3D=3D RXRPC_CONN_CLIENT_UNSECURED) {
+	if (rxrpc_conn_state(call->conn) =3D=3D RXRPC_CONN_CLIENT_UNSECURED) {
 		ret =3D rxrpc_init_client_conn_security(call->conn);
 		if (ret < 0)
 			goto out_unlock;

