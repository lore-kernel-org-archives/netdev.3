Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291745;
	b=Q3dfusgx66+R5UuDJ1Vcx/JOQckYLJw1H+ZosjZOKqO3vrqEK9KHrBGGVCA4TwRobN6F
	 tIJxp93I5N9tov6I9U43PWuUo43BWgh83t5kMTtBzwcjOxho0LKed0wZ9K6Ie0SLRV58I
	 11d7XokXzHgvkBh9L0PCkYlyy8M6xlB+T11mYzlw8wcTk7sjkrErr8wrmXzxT/I/829MQ
	 hb4zhFo67890o+oZVcBRzGdgo+D6UMnFx53lXmmivPDXFcKdPTucqHbfa+CpouMmlzsV9
	 Jm5c8fVckVq4t2KAlPf0BV4+8kU0ZNCUyQXjKJzzU2VswtS9ERTvrLDPS0RB0jJ4qZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cq+8LlRu4FfNVmN4rDDe1VjAuFHrpFWMROioS3TKhTw=;
	b=bLepMzNrEvttKDy+JjKmqgV9T9lbO6Z3Wr+zxB1XxjTNLXhITrto+JSybcPdkerOuIkr
	 uxJT+YxudYsnQsT8DcDUhpWkxlodpVvN1+cb4+bgJrHmvuGJATXt814NwZmymk+1Ztwyy
	 zvsthczgjHEPM7D9jgXtKVKwnWkZMVc65r0vkL4IwbgHeEvyeQ0A3dP+hs7wSsIVYJO0M
	 GULUSLtClCT6zocWOCK1Sv+yLfrCpUNWCyq1GIlEEnvV63kX4dpIkLe8y9IhoM8tdUKwq
	 81gupM/Ge/+hvJ2cewlUF04uMn010SPiyEchMQeDda3yzlbICv6/5MmsKuWf3dP+Ymg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=EIqzfx68;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824C606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9824C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=EIqzfx68
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1794553a34.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 22:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794291743; x=1794896543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cq+8LlRu4FfNVmN4rDDe1VjAuFHrpFWMROioS3TKhTw=;
        b=EIqzfx68XkEAlGC1NtD8CjG3JQD4sDvo8EFlgKedv81XabH1G3rmMMqC4mt+MP8nBB
         5OV3KYpQSZWzGW+MXm79YcqzrFukHBiPQa13v/beXPmMP5PYusYJ14iPRB+xR/oKvMXv
         ujPXl3gPHKNhMFw3sFbe9v/p9iVmuNDn9plbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794291743; x=1794896543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cq+8LlRu4FfNVmN4rDDe1VjAuFHrpFWMROioS3TKhTw=;
        b=y6ft08ytqRY/hbAVhkoMU54jxzA2WSSL4d6kXRAN00qRXw6Mvvq6VsOdf2Y+IGzjUQ
         2Ik2IexD7f8uOpki7OCdrE4KuWW/hghPdAe5YSfRUT+sQNZRF7ncjtU4RPm6JfwCMN2B
         hOZXZFE6g6ukG8WJVHPn2rgNXkU0JRORRv6nt2qXnWKyU0i1BuDKDs+YbrxUv6sUiFRV
         06MYdt2UtMSABZn74O2sCYP+pH10iFbC/2s3uh/leYyFjAESTJFVORX0iiP72Qct6iyb
         fTaicYAuULlxCyz2CJ0d1q/Dl/1L87DGZJJj1A0WFWW4/Oqa1mI3zHfXxkF4+kKoLBpJ
         XoZA==
X-Forwarded-Encrypted: i=1; AL+hErEVyNiHP2ESO5YPH/ZzIrZsI/9Nf/wr/jfIi3APhQ8agINobOVMt0bMARhwJXybLgFrES476fY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8aWBcFp39/OPJaqiGUGyzvBjj8w/QarEGgD3s3LzFjhWU6dIi
	mQ4V2bfO0+dgt0NC24VrhWhkS0Ijy5pQa0f6SOrD6eBUUtYbALyYg1jVQG39usWj07Y=
X-Gm-Gg: AYBFou3UMXpxkdlp1EPtWQMVe8CGCJkLoIe+PyqM/L92dnMHH8yDKonTwyYUTAcLRF8
	cGMa4/C5IuSB4YcHCaoeEhtBl/KmGn3q34rMLEjRVBqvJwtE2f+hWR+9gxy83girEiNwrG27wkF
	giKDq4IoWgsyqxyLfknM2cTikF7HcAE/WUtqJ6+6mzv+ZXROIg1O2iaBZZlLUK7RwAGULFOL+l4
	UFoZoJADhf2SM18S5tymosssI61e9B1m0porhkKpMYk/MXkBKY+t4vAwZTsGUI/tZ4kdKvadujQ
	9VS8dV70yuCvzl/IMTw5r7r5ubHjp2k5EzcwjjdlLnSohMCFgVgSXjZ6V+MF5rc5gGWSFIvGI5t
	apKIt+0XL85SpAEsFfkI91sTobwpS1iI2ARJRZbb/IB7itBkXfFr3uRqGvMqUMeCvDfuU1RKOdx
	dDphI4aOxd80dP06/3Oc81irgRRn6YGWjnjTrT/LGkuEw7igTaSqzy0mv12ieT1LDKYjguGc9Np
	ZHCb/vYF/uAgz2TdDf3dKbsvmJ4AowNUydg7vLBwVqeQlMpPaL4KDOhBiXZYt4cCQ3//RW9USYb
	bXud9LCWoOecsd6d011naMJMuPakj2NXRzsQAkhxz71liE8M+GGaezTKcCTQSlmOzHbsXyGk65L
	4ddQHGBTHMuZYXwN+7mNGLc2mdKIR5g==
X-Received: by 2002:a05:6830:6810:b0:822:6f0d:d04d with SMTP id 46e09a7af769-860dc746fd3mr1126251a34.16.1794291743387;
        Mon, 09 Nov 2026 22:22:23 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860e5978892sm111726a34.12.2026.11.09.22.22.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 22:22:23 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: linux-afs@lists.infradead.org
Cc: dhowells@redhat.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] rxrpc: Serialize client connection IDR updates
Date: Mon,  9 Nov 2026 22:22:21 -0800
Message-ID: <20261110062221.96452-1-kylebot@openai.com>
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

Service connections use peer-selected CIDs and do not own client IDR
entries, but the common destructor removes those IDs. This can delete a
live client connection or race allocation and corrupt the IDR and its
RCU callbacks. Client destruction can also repeat an earlier removal
and delete a reused ID.

Restrict client cleanup to clients. Restore a per-local writer lock and
an ownership flag so each ID is released once. Release IDs at idle
retirement even if the bundle slot was replaced; otherwise deferred
final puts can leave the IDR nonempty at endpoint teardown and trigger
BUG(). Keeping IDs until retirement preserves active calls and terminal
retransmissions. Client-only cleanup also prevents nr_client_conns
underflow and restores the intended expiry selection without changing
the timeout values.

The issue was found by an LLM.

Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O thread")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v2:
  - Release a retired client connection's ID even if its bundle slot
    has been replaced. Keep the ID until retirement so active calls
    and terminal retransmissions remain reachable.
  - Describe the nr_client_conns accounting correction and its effect
    on normal-versus-fast expiry selection.
  - Repeat the RxRPC module and targeted x86 allmodconfig/allyesconfig
    W=1 builds. The reproducer was not rerun for v2.

v1: https://lore.kernel.org/r/20261030042129.73690-1-kylebot@openai.com
Review: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030042129.73690-1-kylebot%40openai.com

I have a reproducer for this issue and can share via DM

 net/rxrpc/ar-internal.h  |  2 ++
 net/rxrpc/conn_client.c  | 21 +++++++++++++++++----
 net/rxrpc/conn_object.c  |  3 ++-
 net/rxrpc/local_object.c |  1 +
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab..5e49fe0f4a6f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -377,6 +377,7 @@ struct rxrpc_local {
 	bool			dead;
 	bool			service_closed;	/* Service socket closed */
 	struct idr		conn_ids;	/* List of connection IDs */
+	spinlock_t		conn_ids_lock;	/* Lock for conn_ids */
 	struct list_head	new_client_calls; /* Newly created client calls need connection */
 	spinlock_t		client_call_lock; /* Lock for ->new_client_calls */
 	struct sockaddr_rxrpc	srx;		/* local address */
@@ -472,6 +473,7 @@ enum rxrpc_call_completion {
  * Bits in the connection flags.
  */
 enum rxrpc_conn_flag {
+	RXRPC_CONN_HAS_IDR,		/* Has a client conn ID assigned */
 	RXRPC_CONN_IN_SERVICE_CONNS,	/* Conn is in peer->service_conns */
 	RXRPC_CONN_DONT_REUSE,		/* Don't reuse this connection */
 	RXRPC_CONN_PROBING_FOR_UPGRADE,	/* Probing for service upgrade */
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..201a50caeaca 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -40,12 +40,16 @@ static void rxrpc_activate_bundle(struct rxrpc_bundle *bundle)
 }
 
 /*
- * Release a connection ID for a client connection.
+ * Release a client connection ID exactly once.  The final reference may be
+ * dropped outside the local endpoint's I/O thread.
  */
 static void rxrpc_put_client_connection_id(struct rxrpc_local *local,
 					   struct rxrpc_connection *conn)
 {
-	idr_remove(&local->conn_ids, conn->proto.cid >> RXRPC_CIDSHIFT);
+	spin_lock(&local->conn_ids_lock);
+	if (test_and_clear_bit(RXRPC_CONN_HAS_IDR, &conn->flags))
+		idr_remove(&local->conn_ids, conn->proto.cid >> RXRPC_CIDSHIFT);
+	spin_unlock(&local->conn_ids_lock);
 }
 
 /*
@@ -56,6 +60,7 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
 	struct rxrpc_connection *conn;
 	int id;
 
+	spin_lock(&local->conn_ids_lock);
 	if (!idr_is_empty(&local->conn_ids)) {
 		idr_for_each_entry(&local->conn_ids, conn, id) {
 			pr_err("AF_RXRPC: Leaked client conn %p {%d}\n",
@@ -65,6 +70,7 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
 	}
 
 	idr_destroy(&local->conn_ids);
+	spin_unlock(&local->conn_ids_lock);
 }
 
 /*
@@ -162,15 +168,20 @@ rxrpc_alloc_client_connection(struct rxrpc_bundle *bundle)
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
+	spin_lock(&local->conn_ids_lock);
 	id = idr_alloc_cyclic(&local->conn_ids, conn, 1, 0x40000000,
 			      GFP_ATOMIC | __GFP_NOWARN);
+	if (id >= 0) {
+		conn->proto.cid = id << RXRPC_CIDSHIFT;
+		set_bit(RXRPC_CONN_HAS_IDR, &conn->flags);
+	}
+	spin_unlock(&local->conn_ids_lock);
 	if (id < 0) {
 		kfree(conn);
 		return ERR_PTR(id);
 	}
 
 	refcount_set(&conn->ref, 1);
-	conn->proto.cid		= id << RXRPC_CIDSHIFT;
 	conn->proto.epoch	= local->rxnet->epoch;
 	conn->out_clientflag	= RXRPC_CLIENT_INITIATED;
 	conn->bundle		= rxrpc_get_bundle(bundle, rxrpc_bundle_get_client_conn);
@@ -682,6 +693,9 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)
 	if (conn->flags & RXRPC_CONN_FINAL_ACK_MASK)
 		rxrpc_process_delayed_final_acks(conn, true);
 
+	/* A replaced connection is no longer in the bundle. */
+	rxrpc_put_client_connection_id(bundle->local, conn);
+
 	bindex = conn->bundle_shift / RXRPC_MAXCALLS;
 	if (bundle->conns[bindex] == conn) {
 		_debug("clear slot %u", bindex);
@@ -689,7 +703,6 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)
 		bundle->conn_ids[bindex] = 0;
 		for (i = 0; i < RXRPC_MAXCALLS; i++)
 			clear_bit(conn->bundle_shift + i, &bundle->avail_chans);
-		rxrpc_put_client_connection_id(bundle->local, conn);
 		rxrpc_deactivate_bundle(bundle);
 		rxrpc_put_connection(conn, rxrpc_conn_put_unbundle);
 	}
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db0f8..bae95cadd72b 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -332,7 +332,8 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	rxrpc_purge_queue(&conn->rx_queue);
 	rxrpc_free_skb(conn->tx_response, rxrpc_skb_put_response);
 
-	rxrpc_kill_client_conn(conn);
+	if (rxrpc_conn_is_client(conn))
+		rxrpc_kill_client_conn(conn);
 
 	conn->security->clear(conn);
 	key_put(conn->key);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 169f9dfdaa77..5a7acd595e11 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -140,6 +140,7 @@ static struct rxrpc_local *rxrpc_alloc_local(struct net *net,
 		memcpy(&local->srx, srx, sizeof(*srx));
 		local->srx.srx_service = 0;
 		idr_init(&local->conn_ids);
+		spin_lock_init(&local->conn_ids_lock);
 		get_random_bytes(&tmp, sizeof(tmp));
 		tmp &= 0x3fffffff;
 		if (tmp == 0)

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.55.0.openai.911.g06873a30d2f3

