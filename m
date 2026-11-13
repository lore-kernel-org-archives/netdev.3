Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574188;
	b=EqVxWa26p42TE8ot7o2CGvG2eSiR2PvvGSQG345/mSnceGjQL/U7HrkEeTVWQ02ov6YL
	 Mv/T5VXjpPjFROmM7z49E7y651+sxW4tkqyjQ8Yn6VTaHZSZyTweFhsu3Ze9D22dLdoCZ
	 DR5A5UVcJWGL5pYxylEeP32zt4NojH2CDYoymnBeng/byBIyPnauj7MSqHCghMg/yLNwJ
	 IVcsqfQFmjHv13pB4q/xNneZjOExXE2RnbHp4gLYXQE9SILwf0CJ+G9aLTo3hz+0yw9qT
	 7UwC1Uui1Qzt/x1M3PZw9zd5EpnX7qo46CakPSOSl2pX2D1y1lsw+gPHaIiroz1oxgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574188;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/AX9Mf5J+3aeVkpwh4J/8EgCykn4MsRJKSbKY+Cu0H4=;
	b=Ce3wfjyV8IMWtw2pfPnbFVfkhJ4U+iGX+C7Cog3sRQe6EIKU2fmt6gMk6z5diUnohDJs
	 FaH/GozbgG3GS+rC0AVxmNM58/LaEvJezav6nC9erBSqM4zALmBnH77BZ6IW1GhIwJw7s
	 eu52tKmS+3aq0nvQ8usaSfR32Xycqla1gb5pb7dceOrfzILoGEykCCxJ3X7gyHXldKb6o
	 V//vNxc9LlWqjrgEhe8aTU3zynq5e+0a2CibXb0NePUWriur5tvIb8R6avxQwaR+FTF6d
	 CfvJeog1A4RKLB702wcc2xzZrJal+vHGP6nVCNeEqehaSuKgtMtahdTl6LNk+jDDnSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eoJgTS28;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="o4bed+/j";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C10606A88E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26C10606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eoJgTS28;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=o4bed+/j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AX9Mf5J+3aeVkpwh4J/8EgCykn4MsRJKSbKY+Cu0H4=;
	b=eoJgTS289JxHNCLmsLMet5aFS9jw6JoLx+IRwroTLF8oGWvxZUgz3mcgwiYR45+Yt8t+Vk
	0AG7su4b9v5BSPDMClfF5HH+KqX58qFoQQhxMs0c12/1cprWT2EtnkPIuugBMBmEcdf04f
	ykomcxJ7BQ1Ck/lFks2AqxeG5LaIR6I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-AFIP_AVbNW-KNlvwv0vvMQ-1; Fri, 13 Nov 2026 07:49:46 -0500
X-MC-Unique: AFIP_AVbNW-KNlvwv0vvMQ-1
X-Mimecast-MFC-AGG-ID: AFIP_AVbNW-KNlvwv0vvMQ_1794574185
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso5064695e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794574185; x=1795178985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/AX9Mf5J+3aeVkpwh4J/8EgCykn4MsRJKSbKY+Cu0H4=;
        b=o4bed+/j0DsxoIEmxXDrQDox3rXYOhI06cHiAAw/VMBG4e4G4vsh/iOzV5asf9mYmU
         61ZteDevGxnIDL5XKXFFhNzrlNASmmn8GKy//oswAyPwICUoh37SDVdTRFu0c0Qm9BBL
         X8pIp9vTanmyoq0HPZW7dBe4dqQceuk4wiOAS1/L1RrvWDmramPtBBCRxJ8hgCIV+RtP
         UJOremD3ylX+mocqXXROrhmEFH86f3RGrkCN4WYBNoq8OJGZ8qbiWH2xwlNG+t8mSD2w
         aX3UVHydztMI2JhDzhnU8Skn6/nbulyu5tUTrGZ8Vl8hKRL45HkSBaTU2Sct+d2QXe09
         kuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574185; x=1795178985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AX9Mf5J+3aeVkpwh4J/8EgCykn4MsRJKSbKY+Cu0H4=;
        b=ohlcsECbTtGsM/CEMMFtG7PtdAp3VnDJECg10b4orPW1egeR4ia/EpG8UWhEzU0pJ1
         leqNhpXReNhKDqLDKkZM+pKzBuqUDPdzwEQnsmwuqn1EvFeTOd4n7qT68a4diPy5SWz/
         4tgEA09zl165o+lhtx4oOCZSfUXEVjiz08eLBUWto+nK/mn7b6jir7KS2/Sa48S+VVvX
         C1qHiMyaGdtp6TCsqmK1gaeiLMSFx2l3IUXiz4RXKzOVQsJm1wqNMuJSoe417lHUNNiP
         sd+qNSgVy1deBASlgLAbJT2OmEql/sCRHodMos10FEcp3VmfzP8pdj0R71o8EME+GKCR
         BGMA==
X-Forwarded-Encrypted: i=1; AL+hErGo+vKE+5DEh0xn4oOlSfrTIRAXFuXg1Xt03HiMZ734hqHXQwBEmxqqnSefc/CRcI7SV575Kes=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bcGZp7tyNMjnHFF29lZ5e6ATc5xkry2h2cN5/mjnnQdiEmjsx
	49lggeCJoGi6Cp984n7xLRopd56F2KZFsgYeTq8n9hUVMJrrMcna96raXe9DU240sQZ2UfjYtaS
	AYiZaROEm7HMUJJr13vxWThrmWfpXzRLaK2+q+JlXdUe4XVwER2FL3ye5PZCKIDlvWOOg
X-Gm-Gg: AYBFou213Ni5V69KwFOfjK8PBE13BDZHZor2eSL9FQAZJm/TsWt6/8KU9VsNNlrdfnd
	rBbEKQmLhWMC/7MUFBpzJoRsTdnrpC7dFn7z2WO0ai9EwN40tN+cNkp0CVNop4XVaiApErnwbzS
	3ZR5HBCjaqDqXeiSqF6PW6QLrqU2FoItAS3qXGmhGjQ54IHU3dzB506K98hU8verE2Vin8R/LlB
	p1ZMwl+IVpeB1dl2cPWxH0l7KLP1LnXxYCzjIHcBP7pMbN0ceRPM2aqvTbUn6xtMMo7nAMWkeq7
	QRm3MLbCuZwFBxXacdUgiJluV7fPT9tsXLxADZSwjCy23KruOoNOITRKX6CrxwUI+YgJG0SUhob
	2taYzblIt24FjK6wtqMflbtpLNTqIcy3ijM4XrbqutIL2nkiVf60zslNHODkVD2f0xbNLoX7qOS
	i+B3+l1tEtMWI=
X-Received: by 2002:a05:600c:871a:b0:4ba:a5:b920 with SMTP id 5b1f17b1804b1-4bb55a4baa8mr49654475e9.16.1794574184546;
        Fri, 13 Nov 2026 04:49:44 -0800 (PST)
X-Received: by 2002:a05:600c:871a:b0:4ba:a5:b920 with SMTP id 5b1f17b1804b1-4bb55a4baa8mr49653835e9.16.1794574184084;
        Fri, 13 Nov 2026 04:49:44 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:43 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:34 +0100
Subject: [PATCH RFC v2 1/8] vsock: expose the core port allocator to
 transports
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vsock-dgram-support-v2-1-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9250; i=slp@redhat.com;
 h=from:subject:message-id; bh=H6wwDTbNUOfIU+6gW7svNy8mFx/ZAcmIgQ8rPn9Y61E=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdbu7Fqo4+Y3Ih83ph51vRcmSPmYLyAgKiCZ
 38/wu0mBHWJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHWwAKCRD0aSeNLwwC
 NYWwD/9HiHzXIt7IctG79N1tVijhsqKGqpflmZW8jWDNk2GMciv1CXrhNS86Kd20RZsWklMlO9b
 hYnwxWDjmAGPElnLRcsobCQslH2vxzOQMGbqTE9sMDD3gSNsdaL/2MDJBIgfXKVAB6UUZPM1VAM
 jKI/2LwlzGbIvjlEKT0/5uas7urYEFfGxPA6wBRBwK54l8MpqFQt0wrn1/V1OIneop/jG+a969v
 xsoC2UIO0Q5Pk8bhpX+xF8w3X4MUrDtTWqnZgaDbSh34D5yWsfEysNrJpc9X7f3eHX2YKn1WVVQ
 2mg61fk18nPlX1N/jexki3PyeRfozXMgn3hLbbt2C/hrEOncyF2urCR/Ni9GF1dcuZlQ37u5HJs
 l9CrKKz7UeXPAZekm172/88+UaLXLv/KfFNIMPklk+skQt2k2iwtMsCIHQfHv8kzmw2/Ik9uRd2
 wIyDkiXW4KaVz6+Z8et9emBAh/oRyNqOQ1Ct264iRhLfEZEm+ifN8YAlPGyoQuy9eXmttoDiS29
 KPAg4bAil1SJljP+8T96vVnR3bY6AO7uNJmClHROedNs+OVY7XBo4pcBCG6DXz5DZDmNRQpAanE
 jcQ0FgwhUBC2YfoUoFQMjIPBSTMlGplsy/CruKt2+UXBUMhCOkxEqdde1qOGImZxr11+kXPGQc3
 gCqDxMi5xsJhPRw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

The core port allocator is currently private to connection-oriented
sockets. Virtio datagrams need the core bound table and port allocation,
while VMCI datagrams must keep their own endpoint creation and port
namespace.

Export vsock_bind_common() with the bound-table locking inside the
helper, and use it for stream and SEQPACKET binds. Keep datagram binds
delegated to the transport so a transport can opt into the core
allocator without changing other transports' binding behavior.

Keep datagram and connection-oriented sockets in separate logical port
spaces within the core bound table. Filter bind conflicts and bound-socket
lookups by class, including wildcard CIDs and automatic port allocation,
so datagram and stream/SEQPACKET sockets can share a CID and port. Stream
and SEQPACKET sockets continue to conflict with each other.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/net/af_vsock.h   |  3 ++
 net/vmw_vsock/af_vsock.c | 98 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 66 insertions(+), 35 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index e8481f12312e..ac061115ed30 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -220,6 +220,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending);
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
 void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
 void vsock_insert_connected(struct vsock_sock *vsk);
+int vsock_bind_common(struct vsock_sock *vsk, struct sockaddr_vm *addr);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
@@ -227,6 +228,8 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
 struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
 					 struct net *net);
+struct sock *vsock_find_bound_dgram_socket_net(struct sockaddr_vm *addr,
+					       struct net *net);
 struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
 					     struct sockaddr_vm *dst,
 					     struct net *net);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d0508887a2fb..d5cf240d4ece 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -14,14 +14,10 @@
  * specified an address that they are responsible for) and one for connected
  * sockets (sockets that have established a connection with another socket).
  * These tables are "global" in that all sockets on the system are placed
- * within them. - Note, though, that the bound table contains an extra entry
- * for a list of unbound sockets and SOCK_DGRAM sockets will always remain in
- * that list. The bound table is used solely for lookup of sockets when packets
- * are received and that's not necessary for SOCK_DGRAM sockets since we create
- * a datagram handle for each and need not perform a lookup.  Keeping SOCK_DGRAM
- * sockets out of the bound hash buckets will reduce the chance of collisions
- * when looking for SOCK_STREAM sockets and prevents us from having to check the
- * socket type in the hash table lookups.
+ * within them. The bound table has an extra entry for unbound sockets.
+ * Transports with their own datagram endpoint table can leave their datagram
+ * sockets there; virtio datagrams use the bound hash buckets. Datagram and
+ * connection-oriented sockets have separate logical port spaces within them.
  *
  * - Sockets created by user action will either be "client" sockets that
  * initiate a connection or "server" sockets that listen for connections; we do
@@ -295,12 +291,16 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 }
 
 static struct sock *__vsock_find_bound_socket_net(struct sockaddr_vm *addr,
-						  struct net *net)
+						  struct net *net, bool dgram)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
 		struct sock *sk = sk_vsock(vsk);
+		bool socket_dgram = sk->sk_type == SOCK_DGRAM;
+
+		if (socket_dgram != dgram)
+			continue;
 
 		if (vsock_addr_equals_addr(addr, &vsk->local_addr) &&
 		    vsock_net_check_mode(sock_net(sk), net))
@@ -372,28 +372,41 @@ void vsock_remove_connected(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_connected);
 
-/* Find a bound socket, filtering by namespace and namespace mode.
- *
- * Use this in transports that are namespace-aware and can provide the
- * network namespace context.
- */
-struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
-					 struct net *net)
+static struct sock *vsock_find_bound_socket_type_net(struct sockaddr_vm *addr,
+						     struct net *net, bool dgram)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_bound_socket_net(addr, net);
+	sk = __vsock_find_bound_socket_net(addr, net, dgram);
 	if (sk)
 		sock_hold(sk);
-
 	spin_unlock_bh(&vsock_table_lock);
 
 	return sk;
 }
+
+/* Find a connection-oriented bound socket, filtering by namespace and mode.
+ *
+ * Use this in transports that are namespace-aware and can provide the
+ * network namespace context.
+ */
+struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
+					 struct net *net)
+{
+	return vsock_find_bound_socket_type_net(addr, net, false);
+}
 EXPORT_SYMBOL_GPL(vsock_find_bound_socket_net);
 
-/* Find a bound socket without namespace filtering.
+/* Find a datagram bound socket, filtering by namespace and mode. */
+struct sock *vsock_find_bound_dgram_socket_net(struct sockaddr_vm *addr,
+					       struct net *net)
+{
+	return vsock_find_bound_socket_type_net(addr, net, true);
+}
+EXPORT_SYMBOL_GPL(vsock_find_bound_dgram_socket_net);
+
+/* Find a connection-oriented bound socket without namespace filtering.
  *
  * Use this in transports that lack namespace context. All sockets are
  * treated as if in global mode.
@@ -832,11 +845,13 @@ static void vsock_pending_work(struct work_struct *work)
 
 /**** SOCKET OPERATIONS ****/
 
-static int __vsock_bind_connectible(struct vsock_sock *vsk,
-				    struct sockaddr_vm *addr)
+static int __vsock_bind_common(struct vsock_sock *vsk,
+			       struct sockaddr_vm *addr)
 {
-	struct net *net = sock_net(sk_vsock(vsk));
+	struct sock *sk = sk_vsock(vsk);
+	struct net *net = sock_net(sk);
 	struct sockaddr_vm new_addr;
+	bool dgram = sk->sk_type == SOCK_DGRAM;
 
 	if (!net->vsock.port)
 		net->vsock.port = get_random_u32_above(LAST_RESERVED_PORT);
@@ -854,7 +869,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = net->vsock.port++;
 
-			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
+			if (!__vsock_find_bound_socket_net(&new_addr, net,
+							   dgram)) {
 				found = true;
 				break;
 			}
@@ -871,16 +887,15 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket_net(&new_addr, net))
+		if (__vsock_find_bound_socket_net(&new_addr, net, dgram))
 			return -EADDRINUSE;
 	}
 
 	vsock_addr_init(&vsk->local_addr, new_addr.svm_cid, new_addr.svm_port);
 
-	/* Remove connection oriented sockets from the unbound list and add them
-	 * to the hash table for easy lookup by its address.  The unbound list
-	 * is simply an extra entry at the end of the hash table, a trick used
-	 * by AF_UNIX.
+	/* Move the socket from the unbound list to the hash table for lookup
+	 * by its address. The unbound list is an extra entry at the end of
+	 * the hash table, a trick used by AF_UNIX.
 	 */
 	__vsock_remove_bound(vsk);
 	__vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
@@ -888,11 +903,26 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 	return 0;
 }
 
-static int __vsock_bind_dgram(struct vsock_sock *vsk,
-			      struct sockaddr_vm *addr)
+/**
+ * vsock_bind_common - bind a socket using the core port allocator
+ * @vsk: socket to bind
+ * @addr: local address to bind to
+ *
+ * The caller must hold the socket lock.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int vsock_bind_common(struct vsock_sock *vsk, struct sockaddr_vm *addr)
 {
-	return vsk->transport->dgram_bind(vsk, addr);
+	int ret;
+
+	spin_lock_bh(&vsock_table_lock);
+	ret = __vsock_bind_common(vsk, addr);
+	spin_unlock_bh(&vsock_table_lock);
+
+	return ret;
 }
+EXPORT_SYMBOL_GPL(vsock_bind_common);
 
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 {
@@ -914,13 +944,11 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	switch (sk->sk_socket->type) {
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		spin_lock_bh(&vsock_table_lock);
-		retval = __vsock_bind_connectible(vsk, addr);
-		spin_unlock_bh(&vsock_table_lock);
+		retval = vsock_bind_common(vsk, addr);
 		break;
 
 	case SOCK_DGRAM:
-		retval = __vsock_bind_dgram(vsk, addr);
+		retval = vsk->transport->dgram_bind(vsk, addr);
 		break;
 
 	default:

-- 
2.56.0

