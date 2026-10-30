Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334093;
	b=efROXM2V8wULca+Q8+EA7smv/70upgWnHRfWHZvlP+ju72nvCuXtK2PPCSbT7j04/lrF
	 hA5gjMV3hyueCnJq57qyXMMYjo/DBAAJ/EoV7100I1Q62FSjNr2gmLfAYmcOgS4jMeSaz
	 eFISnFwCepFEjtk2mXGpSojvsUPRxK1tAzQoV9ZR1YJT+fNdfPvao7K2mt8sbzuITYkcB
	 F13rEaOb0Y39TR1JR9DR/8xJwJj3t9oYs1X6bcgiXR4PXsucCiCDx8dp2f3j+91G3nWyD
	 N+PwzyVyj0Gw8Dww4GjmhPWrrBHONVbMQpWMsTY1/cc0cJ4eUxY3o9WdSjrLwJSyeKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m+UvCR40zLeBZiNhlvIBvCGxKCDmbVOiWwxKAegnpmc=;
	b=4ieqUt3or1lcxVAsMbUag488KWZ/HOrTlQLm5mgEj84lVt2p6/at8YPJ7S5FR0e/JWCd
	 Jy3z+O26oa3HaM1m/PxMB3ptP8kK77vA2zyQYR7yadR67NycNN7Tko6qASZ6gzSa2RG55
	 m36I+xKFqrctPP4T4EIbizrSS0EWDVktXCKuTaqQDPc89kdLntNfA1kzhX/3WvsPzCAIU
	 pdbDzmu07KH/oaiqg/b8St35yBPaI6tR1GoWoPmUBPLW8s19AoFIE7Q7BCi36HCnrqMjl
	 TkZtNUdGUjNE21/+o+bbgOIBEmwzXJEa6/Tdp4Dd6m0eGxHk0YWeoS5o+43F6RFgxfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=aw21dDBZ;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A92606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9A92606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=aw21dDBZ
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6de1fd5f572so108347eaf.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334092; x=1793938892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+UvCR40zLeBZiNhlvIBvCGxKCDmbVOiWwxKAegnpmc=;
        b=aw21dDBZ39a0BZ1Pwg/laBtRlVRZ9zJrcVN/8T3X44Th5/D73o9RLTgP1OBRddcEfI
         GV26wzWBoEuuw7MH/35MaEL1fB9tx69z7D9OMTt3GHMNFayr42/D+aUMMnA/J27N9oO8
         pE9GhNIdop9I5hAIL3PXyHU62WrcVThEkHHJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334092; x=1793938892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+UvCR40zLeBZiNhlvIBvCGxKCDmbVOiWwxKAegnpmc=;
        b=RXSYit4PFMXKsYhHrMuX3UZlQWHMYpg0Tq7B1F3NyM7OEUMR5aZ3EpQYO167o4DKUx
         oXCdnZS9OpP4slzsZQfzPfPzanjPd1xPEABYQu0vRcrvwib24taabkRd9GXFterPf2fA
         URLPbl7kSwio2J5LXOV1KvHcaXBao+ZLfMnLohnvPo8H/G4N6OqmOrUoIvyScbp3Np0E
         GgSfzpT2gLPKze+v2pquZGm41Y20m5RT1OTL2keX2gP0EaJJID5cB+If9G5vfMRoBjsL
         WOf6eXNL1YgzniiEwU6THXlQEM2tyKHUYqh/Yg7gnV0idLuGmXYpZ/pneJHYDFbpqMrl
         5/TA==
X-Forwarded-Encrypted: i=1; AKwUvBxsA4IuSjSFZa56ZkTGCqs/syXQsm/c7ZHwbpuLR/OEgcvvzQ631hDh3WxcaxQdPCokJD9Pyxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJQkxTJs1ilq/sCbdkqaNcI/m5u9ryYBq6L+wqKdtyyZiowN1t
	ITC2ggawrQCepl122kUST8Tave6vO8TjDqzt3leBh8yDofxL1Epo+JfZj8L9P2rV1eA=
X-Gm-Gg: AYBFou0gHjuhlv44RiLLvM19f0kEx9DR/8sKnuMgONAOr9ivUkxfc9ZERxC8BTwQTuj
	rp4TXw+WXJ7IYCdR4Q+Xz+C/e4khlub7dj7o4yK/02/hE/iBH5FW0Pnc4FMSJUL2BO0eSX4lVYT
	Qe5r+S4ZBcJAIKADS/cBpzr7C2rnoEkbxI794CaonsysQKHQA7Lk5+OIbOWYWSQzbtdXqIW8qES
	Sb8CNGwrulfDoIcqBndA1kXil7Rk/WxYUA0iLJGw5ENtY65Emsnp8ng8XTtWMjknOxZUQwicYQf
	blxR8/88Ge+IH9BOX1aZot9jsuWjRN5p+diFcVbkB3zt5jFXhS6lUX4bxXDWOeHHZFApkfes3Cv
	O/8CFh0N5o9VKVeQnWFcx0SQ6NGrJRfzQa9mhj9d4lNvsjoXLJ+qoHL8edfH8clrfsgVfOByrEV
	p1CXBtaaam1K7J9nx2rEdt4fAnQQgPtwcq/IQgWsrrbZWrqN3DKht0OB9lzdEs5l0qWzn6clqeN
	2WMQamMD726XJm2f6fSvpn8SNITAqIwyVsYabfg/ft95wD9/71589A8BZhNbb0PdXUfBam9/TES
	lFvceEmeVvfP9Nh2uw+1jmAT+BCqZNTK0kbEs2p3YdnXBUvlydni6aywhvIXbjAED33jDkfaBFe
	m8DmyyTwTdlu/LNEyrDbL3n14s9pKnQ==
X-Received: by 2002:a05:6820:806:b0:701:e4ae:d394 with SMTP id 006d021491bc7-714f2a0774bmr778691eaf.75.1793334091650;
        Thu, 29 Oct 2026 21:21:31 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90af4c879sm807971fac.13.2026.10.29.21.21.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:21:31 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-afs@lists.infradead.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] rxrpc: Serialize client connection IDR updates
Date: Thu, 29 Oct 2026 21:21:29 -0700
Message-ID: <20261030042129.73690-1-kylebot@openai.com>
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

The common connection destructor calls rxrpc_kill_client_conn() for
service connections as well as client connections.  A service connection
gets its CID from the peer and never owns an entry in local->conn_ids.
Its destruction can therefore remove an unrelated client connection.

The final reference can be dropped by the service reaper or a call
destruction worker, outside the owning local endpoint's I/O thread.
Client connection destruction can also run off-thread, and can remove an
ID already released by rxrpc_unbundle_conn().  These writers can race
idr_alloc_cyclic(), corrupting the radix tree and its RCU callbacks.  A
second removal can also delete a new owner after an ID has been reused.

Only run client cleanup for client connections.  Restore a per-local IDR
writer lock and the client-ID ownership flag, clearing the flag under the
lock when releasing the ID.  Serialize IDR destruction with the same
lock.  This covers deferred final puts without changing connection
expiry or the RCU lookup path.

Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O thread")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/rxrpc/ar-internal.h  |  2 ++
 net/rxrpc/conn_client.c  | 17 ++++++++++++++---
 net/rxrpc/conn_object.c  |  3 ++-
 net/rxrpc/local_object.c |  1 +
 4 files changed, 19 insertions(+), 4 deletions(-)

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
index 48519f0de185..4c2db83fceae 100644
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

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
