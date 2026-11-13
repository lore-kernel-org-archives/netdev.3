Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604425;
	b=2i/UkHOlxlhk0UIBxtC8qUadwj0IdnpK7Sa2HhTDDHjBgOM3FJa1KJpoIN0FA/l4FNKH
	 mjvzl5SHkrH22BxdQ7fK5oYDEjhy9RBQHQWfNoq7uejaAnkBlLHvbRQZrkfHuLe2CVb1M
	 MFUmf+GZR9X5GaAweVEC+NZ4WDS12VEinDnBo1ClJyU/j1qwBicEO0K0b+Onm/8I9jh9L
	 P8MMGI07QewrksrVMEOJlyuGvg5zXkWmuGEn1wIT6nNm8Edb7kxJVZSWghdJA22uT8R/W
	 c8Nf32X8lfFj+xHZcwemBr9cfrR7VLn+ZicjV911KMHVvOnqF6FMPlKZxjWL48TIDOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0dHmRdnk/ATqwo/EsTbTcwWoDXKXa9dTSpvherQIWhM=;
	b=dPFpPZBDL23ZvT+28fH409QGdYqu6y6CjxeG3a0OEwl+sUxrw3z45uFGxFbRUyYckYkd
	 IqdTT8cPGAR/e9MDI0IGqQ8skxAu97+KPVKOSxr22xwNV9peQLl+3FYIdG1XyX9naedEv
	 cWUL8PjMAIKw/54+qeH2V1+amNUw1jL+DOp6AE/duobdUreblYfNx5HqGKUdAJZeXGo8g
	 Ffovnzu85Gy9p/Gcpv2gZLVJpYXnQbrqxMYPtfi3ngYmQmz2fGbVbU2St3cJIBJdmqakO
	 Kd+v4RRLjAMYC4Ez7EkQ/E/mIZED9KgCoAdGm63jKUfuZjQboo6nr4jPxgQyA6yFu1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=DvEoY+AP;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A4606A336
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 21:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 106A4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=DvEoY+AP
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4d7034a99a9so1737931b6e.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794604424; x=1795209224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0dHmRdnk/ATqwo/EsTbTcwWoDXKXa9dTSpvherQIWhM=;
        b=DvEoY+AP82+e8/1Co2xXayhA3H7nJwC/dDd+BsFkjRRoDnpkxsuzrJua9vVISSTSZZ
         f/yB5hdOz4TaF/WlCJelG1kVtSqhP02Q3JTYiBqWTltK/hJ70+ViDrQJiry+gPVi423w
         hgIsIHYyBoOZKZPd4jU9PriRbr76K0LUOXwDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604424; x=1795209224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0dHmRdnk/ATqwo/EsTbTcwWoDXKXa9dTSpvherQIWhM=;
        b=g8OxdRh5lJT+x8zfc9aUw+qh3f+ASomz0xa9lOvmdJXRh6dB9wad77eo+AQoxXnWeA
         jedfVlyf3ud3ydqLaYGLs3iQ/MGXkOAHpeGHa8WgFCDZ6sm8jxUWihV/gtzUSUK2JvsD
         69/nT5Hu5UoPlLl4RKL1WbYiiydcZspTbTbWU0REuIx6y8fyJ0TUvbTO4gLc8zOyX3+y
         WqZqSe0sdaNv3BfF3H860lArq+ZOKYhfywKe5qFiBCqeuM+HmIpi2U9e9+Higk3+bzBE
         BZ3zYlqMER+C9EPrvAb8nVjGScIy4tNJ+X4K4dPFbw2KQeZGOz0XSP92OchLJaZ9qblF
         IHFg==
X-Forwarded-Encrypted: i=1; AL+hErExh/L0QVLoYK4up6UlZpBd9yBBwWELMF5K/wSzuDHVIi/vBIP4qT0Yhx1thKEaC/JN5kipKLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Sl/LQ6RtQu+9EAdOupnUyxZcYE4/q4igrUEaowKfi72vgbWKw
	KHNDlV6237jHulFmkW+Cqqmxvwj6PdtTDJYihGaytv2fSAKa97D21l/qorkMiB+VMadLLXv9G9t
	dP/p3rEw=
X-Gm-Gg: AYBFou3L5NJpUE2g4QWKj+gJBG+TJNA9wYcFerLZdpa7hmDzCuDfFXoyTYcnndE3AX2
	d7MdhXVI6SbxvKARpoLLQNsh1/YkU81qdObDsVZrfaftZsSy4uP7u5pPNaL/skqPYKJ8C+d4chs
	ZROZL2gvIaBXcgdnBSqE1vsi85fZaDdQQ7Ig08JmdHw/rBVBaToi/Ahy0xvWMcTwh0jYoMjFRig
	qrYxMebGr0YEI+lXQ4A/w2J4hug9ivC2vG+42YlvKONYi4XHPWD6TYAwEK+sfdtIedajxWPgoVh
	4iH872AaQPkOJpbgdAqimM1sqQACP4/GOG/bryBsMuhCA6f5wJ2nEo0YdZ/Y2QO5TC/dpYLNN27
	YYIJV0TONugZLd3RVXCzJ4T/nMmkrJhbgbxglbVIYcIgGurW3bQjef04uYFdLwtDEDMB6S9UKHp
	8cEt206FvbelNW8hBdMMDsbFfu2BVRqcLNFnLe6IQx9cGBnGHBqsI4L/rma74UXW4NLxbIQ0TUx
	bPI2Un118BhoycrHHb3B+F5a5Hux9cEjhSJ+3KkLVi3YXgdSxkChCaom6vsZguksG988L+HtYbs
	O52fcArwaQzmSYcZKIjJ4LDiCs6YWWgm2mENQu3xTxfMZG3TmCfbTQWpdON4vgfZ+VQgwmQJOY5
	NJ/Xs9sGy/psvdUISI5M5zPqhiEiscg==
X-Received: by 2002:a05:6808:1a03:b0:56b:4351:49bd with SMTP id 5614622812f47-56e647dfc6dmr3129683b6e.52.1794604423720;
        Fri, 13 Nov 2026 13:13:43 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e71262becsm2809890b6e.17.2026.11.13.13.13.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 13:13:43 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: linux-afs@lists.infradead.org
Cc: dhowells@redhat.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] rxrpc: Serialize client connection IDR updates
Date: Fri, 13 Nov 2026 13:11:30 -0800
Message-ID: <20261113211130.86092-1-kylebot@openai.com>
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
an ownership flag so each ID is released once. Retire IDs even if the
bundle slot was replaced, preventing deferred final puts from leaving
the IDR nonempty at endpoint teardown. Keep IDs until retirement to
preserve active calls and terminal retransmissions. Unlock before the
existing leak BUG() so later destructors cannot get stuck.
Client-only cleanup also corrects nr_client_conns and restores the
intended expiry selection.

The issue was found by an LLM.

Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O thread")
Fixes: 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v3:
  - Unlock conn_ids_lock before the existing leak BUG().
  - Add the Fixes tag for the earlier service/client accounting bug.

v2: https://lore.kernel.org/r/20261110062221.96452-1-kylebot@openai.com
v1: https://lore.kernel.org/r/20261030042129.73690-1-kylebot@openai.com

I have a reproducer for this issue and can share via DM

 net/rxrpc/ar-internal.h  |  2 ++
 net/rxrpc/conn_client.c  | 22 ++++++++++++++++++----
 net/rxrpc/conn_object.c  |  3 ++-
 net/rxrpc/local_object.c |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)

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
index 48519f0de185..2da6460472a7 100644
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
@@ -56,15 +60,18 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
 	struct rxrpc_connection *conn;
 	int id;
 
+	spin_lock(&local->conn_ids_lock);
 	if (!idr_is_empty(&local->conn_ids)) {
 		idr_for_each_entry(&local->conn_ids, conn, id) {
 			pr_err("AF_RXRPC: Leaked client conn %p {%d}\n",
 			       conn, refcount_read(&conn->ref));
 		}
+		spin_unlock(&local->conn_ids_lock);
 		BUG();
 	}
 
 	idr_destroy(&local->conn_ids);
+	spin_unlock(&local->conn_ids_lock);
 }
 
 /*
@@ -162,15 +169,20 @@ rxrpc_alloc_client_connection(struct rxrpc_bundle *bundle)
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
@@ -682,6 +694,9 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)
 	if (conn->flags & RXRPC_CONN_FINAL_ACK_MASK)
 		rxrpc_process_delayed_final_acks(conn, true);
 
+	/* A replaced connection is no longer in the bundle. */
+	rxrpc_put_client_connection_id(bundle->local, conn);
+
 	bindex = conn->bundle_shift / RXRPC_MAXCALLS;
 	if (bundle->conns[bindex] == conn) {
 		_debug("clear slot %u", bindex);
@@ -689,7 +704,6 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)
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

base-commit: 2800868f63227c8237d70c41e70d441c919620d6
-- 
2.55.0.openai.911.g06873a30d2f3

