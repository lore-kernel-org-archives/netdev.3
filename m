Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE0431A41;
	Thu, 16 Jul 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212533; cv=none; b=M9W6AFF398mylRkCL2UYF0NJkXZq4qtCkn5HejkqRzKB9r3LbrHfPiy7JFtn0HwxVYq57YAH4hZcd6Q/FlTC4LgqnVqho4jhjCV8XB9AckioiBcdCj8Q0aZIapdfSCZRaAPkWf/fCQC/Sh5f1a3/aGuYT2juECFqVTbc93E9LWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212533; c=relaxed/simple;
	bh=QnyyYZAw3BAZXQq4kuAEMR6OjgpOQzxAzxKnZ2HiD2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mxeJPdV7dULxzCX2t5FH79vvRn2IuZKiz0RIDh5Ue5daw+/uKg9B61V05Wafz8gnninbpAwZA3EYJ9XkATbOuMOVF0uHywzDRhOx/ORpSM8JhlFAwSguxObY8pdymeXBA+z4vOO9NN3wJ+tdfkbGOwNdQ5cAhykpmONCFe2DNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=XeL2mdAl; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="XeL2mdAl"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4675f5e23;
	Thu, 16 Jul 2026 22:30:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net v4] raw: annotate lockless match fields in raw_v4_match()
Date: Thu, 16 Jul 2026 22:29:58 +0800
Message-Id: <20260716142958.3064224-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6b55b8b503a1kunme8cc079a6e14
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUpKVkJMQhhMH0oYTRkZGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XeL2mdAlNMfgvNlc4v37oYboUNpwZvO+YjBmO5TFL461qvAnxG7GBlENaG3VP08Q3PN5htWxgQzeogHj6/VoGtVn/86Vklexnj0aATNvjFky0hh/Om+AMGrNTwyHLf14pOyNV8qghJPkEEvZmpYnhf0BYgVtAs17n1coAvhKBOI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9v7Z/bdV62n5iKi1DVBgcg9dQLXbtUDHd1e2VQIBcgM=;
	h=date:mime-version:subject:message-id:from;

raw_v4_match() is a lockless match helper under sk_for_each_rcu(). It
still reads inet->inet_daddr, inet->inet_rcv_saddr and
sk->sk_bound_dev_if with plain loads while bind, connect and
bind-to-device paths can update the same match fields concurrently.

Annotate only those mutable match fields in raw_v4_match(), and do so
at the point of use instead of hoisting the bound-device read before
the earlier short-circuit tests.

Also annotate the raw bind writer and the shared IPv4 datagram connect
writer used by raw sockets, so the address fields updated on bind and
connect match explicit WRITE_ONCE() updates.

This version intentionally leaves the shared disconnect-side IPv4
writers to follow-up cleanup and limits the writer changes here to the
raw bind path and the datagram connect path directly exercised by raw
sockets.

Fixes: 0daf07e52709 ("raw: convert raw sockets to RCU")
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v4:
- drop the __udp_disconnect() annotation
- drop the inet_reset_saddr() annotation
- keep writer changes limited to raw_bind() and __ip4_datagram_connect()
- previous version: https://lore.kernel.org/r/20260611035318.1091442-1-runyu.xiao@seu.edu.cn

v3:
- drop the inet_num annotation for raw sockets
- cover inet_daddr as well
- avoid hoisting sk_bound_dev_if into a temporary variable
- annotate the matching IPv4 writer paths

v2:
- note that inet_num and sk_bound_dev_if already have WRITE_ONCE() writers
- add WRITE_ONCE() in raw_bind() for inet_rcv_saddr
- previous version: https://lore.kernel.org/r/20260601073937.1137673-1-runyu.xiao@seu.edu.cn

 net/ipv4/datagram.c |  4 ++--
 net/ipv4/raw.c      | 23 ++++++++++++++++-------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 1614593b6d72..7d25519a6cdd 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -63,12 +63,12 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int
 	}
 
 	/* Update addresses before rehashing */
-	inet->inet_daddr = fl4->daddr;
+	WRITE_ONCE(inet->inet_daddr, fl4->daddr);
 	inet->inet_dport = usin->sin_port;
 	if (!inet->inet_saddr)
 		inet->inet_saddr = fl4->saddr;
 	if (!inet->inet_rcv_saddr) {
-		inet->inet_rcv_saddr = fl4->saddr;
+		WRITE_ONCE(inet->inet_rcv_saddr, fl4->saddr);
 		if (sk->sk_prot->rehash)
 			sk->sk_prot->rehash(sk);
 	}
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 5aaf9c62c8e1..dfb294b5c794 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -120,13 +120,21 @@ bool raw_v4_match(struct net *net, const struct sock *sk, unsigned short num,
 		  __be32 raddr, __be32 laddr, int dif, int sdif)
 {
 	const struct inet_sock *inet = inet_sk(sk);
+	__be32 daddr, rcv_saddr;
 
-	if (net_eq(sock_net(sk), net) && inet->inet_num == num	&&
-	    !(inet->inet_daddr && inet->inet_daddr != raddr) 	&&
-	    !(inet->inet_rcv_saddr && inet->inet_rcv_saddr != laddr) &&
-	    raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
-		return true;
-	return false;
+	if (!net_eq(sock_net(sk), net) || inet->inet_num != num)
+		return false;
+
+	daddr = READ_ONCE(inet->inet_daddr);
+	if (daddr && daddr != raddr)
+		return false;
+
+	rcv_saddr = READ_ONCE(inet->inet_rcv_saddr);
+	if (rcv_saddr && rcv_saddr != laddr)
+		return false;
+
+	return raw_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if),
+				   dif, sdif);
 }
 EXPORT_SYMBOL_GPL(raw_v4_match);
 
@@ -724,7 +732,8 @@ static int raw_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
 					 chk_addr_ret))
 		goto out;
 
-	inet->inet_rcv_saddr = inet->inet_saddr = addr->sin_addr.s_addr;
+	inet->inet_saddr = addr->sin_addr.s_addr;
+	WRITE_ONCE(inet->inet_rcv_saddr, addr->sin_addr.s_addr);
 	if (chk_addr_ret == RTN_MULTICAST || chk_addr_ret == RTN_BROADCAST)
 		inet->inet_saddr = 0;  /* Use device */
 	sk_dst_reset(sk);
-- 
2.34.1
