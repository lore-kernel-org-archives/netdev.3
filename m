Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671382;
	b=fQFnxDczU3n6S/tpshxEA/NULZHAKj73SEHDVGfql6f7/umgivORflOaIilRVUpTtBez
	 Uq6bj2/ZsksZArxMrajK3szqtQrSKYkZksb+RmYux5BtAax6D6I/wZ73cagN1y78jEH4+
	 MG9UwcWSHByrYvCsCpiL7/mbsQRomHQTmTx0UNjS0mkHUdgl4DG/H/nSrjtaW4+1b7tR3
	 nvgXX6+qa37Ttyi+20WANo3/ZGRUgM+u/V11viah2ykwK5RSBlUbUKpzbphFNHbfRzQxS
	 liDS4V+Ycty+lmWChNc4mah6auPbFLejanQwysqJ7huOVUktYG0KxMe8th0UU5sjoOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vIPhS8DwvcQG0pi15UwBlmuo6rGqkjQxdAWMcWGTY80=;
	b=Mq78JCf+sgw3ZQjxLPWhS3scuQhdHCt6J3hmIADAedPEQNPqQaHkRqSvTCqEU7w5Rdor
	 brZywFwVIwrCacgHcxb0zRRYpKNQBntIVc7HkiAZJQ483R9sVnQ+3YE9PBPYGaoHkSLY9
	 WNAisv/7bZA85TLtBxugucNMeiG4ZXj8CFpGAGh5p/rkGcgtWAqnlSdmkbYECZD9h0DY9
	 Znen0vdjnMLme8cj/O7PEuTLZu5ugW4dWy0vNEZoJyPk+27d5+3lHwv1L26gNLskeiWVs
	 vmmjLF2kQguDqQJgw4aldHJOQYkCcZXvpY7HwBvqToEivhJRjv7avafYcEn6MMaCKkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XlytGEsO;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B1606A328
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E1B1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XlytGEsO
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso15337915e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671373; x=1793276173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIPhS8DwvcQG0pi15UwBlmuo6rGqkjQxdAWMcWGTY80=;
        b=XlytGEsORuC9UE1h5WdqB5QWHEIIQJ0h01edFcwj0vD9sx/SxZTggL4WV11DUDO2Da
         CniEBB8o/Qy0uWxMR4yB4sXH8gZxCdI/vzB4BjXKlPR8PXCoB3GBvEaMlAYRfcNF0rjC
         LhHwJ22c9R75nEWvbm85q+ovqzvwG/tsV28BWIviOygfIAnMRyzcpTUQQ6IGFY9uz/w5
         cZewgDt/q5Ag9QTXZqtuLjb/XqPQ/2DLLlZ0vwI3hpUS+oaeVFm0vKwEFQRu1U0YXsZ3
         szbMJS7vTel5XFhS8Bbm2UNv9nzNcSLw3dIsVYZjZBESVXLuKlcCcB3beMVDh0l1H7dr
         IZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671373; x=1793276173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIPhS8DwvcQG0pi15UwBlmuo6rGqkjQxdAWMcWGTY80=;
        b=Xhzrq4QLtqds2UtL9CwoAo5OdNvJjS5sHC/bI1cGwbdPvj26ieVI3vfcA09UrP5y4M
         7zGPhTP9KLyighOOyD3jNkH1x093CrIBu5cYzzEW5YIwr03SGUzHAZrUZ7c/NR12vhnT
         c76+T/4ToQ1b8fDmeItx87+84Va7j5xYlZvP9KpB+rcyeBsLIDMNpGyFV5vRWFmGF5Nm
         UUqh3VN7KVv7sQMSst5K7gUIm8VGHNnLtJhHAJO9dckW3o7dZeb4axSHuuHCuqjqDLlc
         fOz1/smJnkHvMHh3F+7GpdGM3LWTZq5ljX2oIiVLi05z4Cue5tf1Q4Tf8p5lH4QwTRoG
         Yrnw==
X-Gm-Message-State: AFq9FYIUW01/y8sm856Sr6p58o7jjqkBtaUbRm9iBYuwoDxQAw0O3ReX
	mW9CzxuMORmpBLJYDP/I6t+7IOgDQkIBvEZK6EEVTfK+RtWDgq9VVSS6Br3WcDLp/jOf/Rbd8Uv
	xLli5wzgZHpfPy/TBYrTSBPZ7U8VDQLaFMoKaKp/Mn+hkQIP4nH/YPM58dwHg6/SR3LQ=
X-Gm-Gg: AYBFou1a+C+ATkPEMvlWHufsUCw4sYu/zhiAvG3ZtHVwqPOsM75FDdOnn7I9efPU9Fk
	UNp9wM8oceubLwxKlLj96FZguDqDj4fjZkJBxSvAoISOEmJW2dQJC+qZB+aNOl15zy7Pn+7Ttg8
	UiHe7v0icIJ0mJNtdCW28vH/hgQQQ5T6qqfOSrydlhDQwLTtporwPkhvr9pCXJ/JYsaBn05+s4S
	ZaC84JGFhY6ArsG33ujCbrFpfE9j39dlydw689dqFojYoEOcc73NPbO9CCUEM/O4oo7zr7EpXQg
	QYr6QLcEjXz7+98ySbkzd5rhnI9wbqKr3VxrVUXXttrfCbDGbpUiR3VHQdl+GGeGQtrIl+3wLzh
	JjIwA2379DT/HVX9blN02qp/jsEn78reW2ZxhxVKLCO0p28OT3yakmKCwRNpjje0Qwgaoke0afU
	pDFi9+hGThsZDmPToaGhywyUqIoFs6pzsHqMhLkD7TGJyn8T19Cnx2ivRjlH89+lcipgTQjhU9u
	J4d3wH929087kEH3SaLOnh2/VC6CLgzfw3ZKmiDxPESSJgGpUmm91pMdfHEJ0iGch49Rv7kW98j
	dZITR6wx/0yX
X-Received: by 2002:a05:600c:3f0c:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-4a1fdd3bdeamr99740355e9.31.1792671373487;
        Thu, 22 Oct 2026 05:16:13 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:13 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 4/7] ovpn: recheck UDP socket family before transmit
Date: Thu, 22 Oct 2026 14:15:47 +0200
Message-ID: <20261022121606.732029-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
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

From: Ralf Lici <ralf@mandelbit.com>

ovpn validates UDP peer remotes against the socket family when the
remote endpoint is configured through netlink. The socket itself,
however, remains owned by userspace and some socket options can still
change the family seen by the transmit path.

For example, IPV6_ADDRFORM can turn an AF_INET6 socket into AF_INET
after ovpn accepted an IPv6 remote. Conversely, IPV6_V6ONLY can make a
dual-stack AF_INET6 socket unable to send to an IPv4 remote.

The IPv6 TX path relies on the socket carrying IPv6 state, as
ip6_dst_lookup_flow() dereferences inet6_sk(sk), which is NULL for
native AF_INET sockets. Checking the family at transmit time
guarantees that ovpn_udp6_output() is only reached with a socket that
has valid IPv6 state, regardless of how the peer remote was installed.

Recheck the socket family in ovpn_udp_output before selecting the UDP
transmit path. When the peer remote family no longer matches the socket
state, emit a ratelimited warning, drop the packet with -EAFNOSUPPORT
and delete the peer with TRANSPORT_ERROR.

Peer deletion is deferred through a common transport-error work item,
because the UDP transmit path can run from non-sleepable contexts while
ovpn_peer_del may release sockets and sleep. Use the same helper for TCP
transport errors instead of keeping a TCP-only deferred delete work
item.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
[antonio: use queue_work(ovpn_wq) instead of schedule_work() to
 follow the module-owned workqueue conversion]
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 19 +++++++++++++++++++
 drivers/net/ovpn/peer.h |  5 +++--
 drivers/net/ovpn/tcp.c  | 23 +++--------------------
 drivers/net/ovpn/udp.c  | 24 +++++++++++++++++++++---
 4 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2067825bb5b6..5e22015351eb 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -83,6 +83,24 @@ static void ovpn_peer_keepalive_send(struct work_struct *work)
 	local_bh_enable();
 }
 
+static void ovpn_peer_transport_error_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
+					      transport_error_work);
+
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	ovpn_peer_put(peer);
+}
+
+void ovpn_peer_del_transport_error(struct ovpn_peer *peer)
+{
+	if (WARN_ON(!ovpn_peer_hold(peer)))
+		return;
+
+	if (!queue_work(ovpn_wq, &peer->transport_error_work))
+		ovpn_peer_put(peer);
+}
+
 /**
  * ovpn_peer_new - allocate and initialize a new peer object
  * @ovpn: the openvpn instance inside which the peer should be created
@@ -117,6 +135,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
+	INIT_WORK(&peer->transport_error_work, ovpn_peer_transport_error_work);
 	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 1879bfb76992..4b20a421cd40 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -72,6 +72,7 @@ struct ovpn_route_key {
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
+ * @transport_error_work: work used to delete peer on transport error
  * @keepalive_work: used to schedule keepalive sending
  */
 struct ovpn_peer {
@@ -107,8 +108,6 @@ struct ovpn_peer {
 			struct proto *prot;
 			const struct proto_ops *ops;
 		} sk_cb;
-
-		struct work_struct defer_del_work;
 	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
@@ -128,6 +127,7 @@ struct ovpn_peer {
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
+	struct work_struct transport_error_work;
 	struct work_struct keepalive_work;
 };
 
@@ -156,6 +156,7 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
+void ovpn_peer_del_transport_error(struct ovpn_peer *peer);
 void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
 		     enum ovpn_del_peer_reason reason);
 
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 8fe8a8e750a4..5340860c0b82 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -148,11 +148,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	ovpn_recv(peer, skb);
 	return;
 err:
-	/* take reference for deferred peer deletion. should never fail */
-	if (WARN_ON(!ovpn_peer_hold(peer)))
-		goto err_nopeer;
-	if (!queue_work(ovpn_wq, &peer->tcp.defer_del_work))
-		ovpn_peer_put(peer);
+	ovpn_peer_del_transport_error(peer);
 	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
@@ -240,7 +236,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
 {
 	struct ovpn_peer *peer = sock->peer;
 
-	/* NOTE: we don't wait for peer->tcp.defer_del_work to finish:
+	/* NOTE: we don't wait for peer->transport_error_work to finish:
 	 * either the worker is not running or this function
 	 * was invoked by that worker.
 	 */
@@ -283,9 +279,7 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			/* in case of TCP error we can't recover the VPN
 			 * stream therefore we abort the connection
 			 */
-			ovpn_peer_hold(peer);
-			if (!queue_work(ovpn_wq, &peer->tcp.defer_del_work))
-				ovpn_peer_put(peer);
+			ovpn_peer_del_transport_error(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
@@ -497,15 +491,6 @@ static void ovpn_tcp_build_protos(struct proto *new_prot,
 				  const struct proto *orig_prot,
 				  const struct proto_ops *orig_ops);
 
-static void ovpn_tcp_peer_del_work(struct work_struct *work)
-{
-	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
-					      tcp.defer_del_work);
-
-	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
-	ovpn_peer_put(peer);
-}
-
 /* Set TCP encapsulation callbacks */
 int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 			   struct ovpn_peer *peer)
@@ -538,8 +523,6 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 		goto err;
 	}
 
-	INIT_WORK(&peer->tcp.defer_del_work, ovpn_tcp_peer_del_work);
-
 	__sk_dst_reset(ovpn_sock->sk);
 	skb_queue_head_init(&peer->tcp.user_queue);
 	skb_queue_head_init(&peer->tcp.out_queue);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 30c7eb261e7b..7672094a6766 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -416,6 +416,7 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 			   struct sock *sk, struct sk_buff *skb,
 			   struct ovpn_route_key *key)
 {
+	unsigned short sock_family;
 	struct ovpn_bind *bind;
 	int ret;
 
@@ -432,18 +433,35 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 		goto out;
 	}
 
+	sock_family = READ_ONCE(sk->sk_family);
+	ret = -EAFNOSUPPORT;
 	switch (bind->remote.in4.sin_family) {
 	case AF_INET:
+		/* userspace might have set IPV6_V6ONLY */
+		if (unlikely(sock_family == AF_INET6 && ipv6_only_sock(sk))) {
+			net_warn_ratelimited("%s: peer %u: IPv4 remote, IPv6-only socket\n",
+					     netdev_name(peer->ovpn->dev),
+					     peer->id);
+			ovpn_peer_del_transport_error(peer);
+			break;
+		}
+
 		ret = ovpn_udp4_output(peer, bind, cache, sk, skb, key);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		/* userspace might have set IPV6_ADDRFORM */
+		if (unlikely(sock_family != AF_INET6)) {
+			net_warn_ratelimited("%s: peer %u: IPv6 remote, IPv4 socket\n",
+					     netdev_name(peer->ovpn->dev),
+					     peer->id);
+			ovpn_peer_del_transport_error(peer);
+			break;
+		}
+
 		ret = ovpn_udp6_output(peer, bind, cache, sk, skb, key);
 		break;
 #endif
-	default:
-		ret = -EAFNOSUPPORT;
-		break;
 	}
 
 out:
