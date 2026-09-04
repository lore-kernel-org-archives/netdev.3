Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D03A75A2
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520524; cv=none; b=SIFeMxV0QHTu1/IuAMHZAAS4txG2KdsNRfvgMUIBBzuYJrhsZ3QihFp3lvBy/bOBr/JWzVEXet092JC2MiNm62M1xYJ/rKv2Y2BeKbQMPi4hh4Zx4jwO7uwZ9Nu0XsUn3YpjI6PyokD5Y/GY7jPLeGMRqfVLVuprNJr26oqFidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520524; c=relaxed/simple;
	bh=laE+sia8mPgillYHXMIscme4r9eE9nE/nf5h2GbR4Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJyGz7tzSoq+Refpij7TLv36SXVBQXFFxl7gdS9bqgbwMNF99aA3rJJosokzjHjW1XJHPmDuL+SAQ0Xnibbb/e0btnYIbUl4xq4TLrhsbPdml6+iY4ulMTW/iip1grsnYA+MGRmM05IaQvgoWEJqmv+0JILy62UVFzNCttdgQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJvEuoGQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJvEuoGQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6f9d13f50so819195ad.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520522; x=1789125322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1FYMpVCeMLMTXdyiCXyvGERdlik2E3HPbOrHaGq/l0=;
        b=oJvEuoGQQeZCTzzG1Y4pVr3d4rXEkbvC2zvEPj5mCQRzGW1GJ7iTVmpmPSELFtDGJN
         5TeQa9Dl9D7ykIL+ipt+uCkzgd5vkd1qNrsZFtImZKDvFsBtlmf7iZuDaEN28TcFElEY
         jGk4Q9dfrO0Ve1zFo4yGATN7D0ML3o/QDFGIJn4gA3LBGPquhMVAbwPNUNJ8cR8uKsaj
         GZDJPK9mT0nXxQMwRQZ5HqMSz0eblyBTiiNbrDb4iFTgER81iKR1JfyCB46yhh/S4TjK
         FpIEBqX0uwbcQCn0+q10XMrc1mDyZNMfx+FiTfYqxoNSZe0c1xbwPwqBQVHmUPMPAhRn
         FGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520522; x=1789125322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1FYMpVCeMLMTXdyiCXyvGERdlik2E3HPbOrHaGq/l0=;
        b=aUDFfIY9t5Pz5/lZDyjRLsIFdlE7cOqElkwDs98cxpChFroYtzk7N+srzDcBW9rs4i
         4N9Vf48XK92iBJ1cESCMIl+IsILk0+3YwheFAhXD0l9ryxGi2TqPPrr8hUPZaNkopK7N
         6iZqlb01UDXaWCxT8f4Sdthxh+nXNgx2rTwteNSu5/p4ah7xUuZk5PUolc7P8GuZtbEd
         imof+d4B5QjffFUSZU4Yb5Pl7OpohoLeb/CdjoGzC5a8w9HNMuSQzmBQYlwaIqPJR++y
         bsYnqO2s1uteRq46wZzHQiFvbRHBUKpF4QLNSA+wCFt+fqVZKKdKq2uyWSP2DGWrChg0
         n+Bw==
X-Gm-Message-State: AFuF++nix6mzWqxvTY7ZET+Pbqwfux19ifCzMLYgCB/WU3NSKFbGSTEp
	PfqMUe9RzYVKWw7KNkFKFZygxazX+t1enrAGB0TOKyL7NNsb2Gltf2hS
X-Gm-Gg: AYBFou26jG2t44dPNtNEQl1+yHiZ/fV6Al52HBer2mRfZn47VnzGypYcbPhcXq9fR/p
	rPO16lqMEK6uYs+xboVtWuhE88obRX8kh9v2pR7M5gyxPyB3dBTik1Hetb+zXDTCLUnyEB5+GsT
	5d9pgsguxqaTayNnlIWCdRraaNFIZtxm9urJbi2UtLENjKVapKLPzcDX4NA7sbKRah2x+FILrPD
	lDkDQYgiVSnGjekrIv81iRmm30RONf06m6F/kW2ZgytdnuMLGioP1YdzH4BcUdO/4MzPjyyQtTX
	YUV/JWnmqM8kbKu0ZrNAzYKHjj7SLGe/hKlWQchJ8Ji94eIeS7YxPSs0CxJ0y0M71Dp545QEzpU
	7YDwolKCHA+XaD6T3zK9NLM/GnBtziEAlCUie12Y9Hc9D8B9YS41cZirQTTs4C9O4BMpnBoRWE/
	hYZ78AKE9H4fa0/3Hy7N5sEGK9vsDqRqinhI7sRMurOa/75QtSOSsJk8tw0RXLBWjbE8I7l6nlG
	UBo8UDX7Xye6ENsZv3kIXilQkm30x89TdIQA+SpNFGuu2kMlg8OXTj61Q==
X-Received: by 2002:a17:90b:4b86:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39b26252efemr5210672a91.4.1788520521754;
        Fri, 04 Sep 2026 04:15:21 -0700 (PDT)
Received: from localhost.localdomain (45.78.64.189.16clouds.com. [45.78.64.189])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm6081862eec.13.2026.09.04.04.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:15:20 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: pin protocol module before inet socket allocation
Date: Fri,  4 Sep 2026 19:15:14 +0800
Message-ID: <20260904111514.584264-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_create() and inet6_create() look up the protocol under
rcu_read_lock(), then drop RCU before using the resulting proto.
sk_alloc() uses GFP_KERNEL, so RCU cannot be held across it.

A loadable protocol can be unregistered in that window.
inet_unregister_protosw() waits with synchronize_net() only for readers
still in the RCU section. After rcu_read_unlock(), module exit can run
proto_unregister(), destroy prot->slab, and free the module. inet_create()
then uses a dangling proto pointer:

  CPU 0 inet_create                     CPU 1 l2tp_ip_exit
  rcu_read_lock()
  answer_prot = answer->prot
  rcu_read_unlock()                     inet_unregister_protosw()
                                          synchronize_net()
                                        proto_unregister()
                                          kmem_cache_destroy(slab)
  WARN_ON(!answer_prot->slab)
  sk_alloc() -> kmem_cache_alloc(stale)

This was reproduced with socket(AF_INET, SOCK_DGRAM, IPPROTO_L2TP)
racing delete_module("l2tp_ip"):

  Oops: general protection fault, probably for non-canonical address
  KASAN: maybe wild-memory-access in range
  RIP: kmem_cache_alloc_noprof+0x63/0x370
  Call Trace:
   sk_prot_alloc+0x74/0x2c0
   sk_alloc+0x2b/0x6c0
   inet_create+0x2cd/0xd40
   __sock_create+0x1c3/0x430
   __sys_socket+0x116/0x1d0

A protosw can also be published while its owner is in
MODULE_STATE_COMING. try_module_get() accepts modules in that state, but
module initialization failure does not wait for such references before
freeing the module. A protocol initialization unwind can therefore destroy
the slab and module image despite the reference.

Cache the proto and its owner while still under RCU. Reject an owner in
MODULE_STATE_COMING, then pin it before leaving the RCU section. The RCU
section protects the rejection path against initialization failure, while
the module reference protects the allocation path against normal unload.
sk_prot_alloc() obtains the socket-lifetime reference. Drop the temporary
reference after sk_alloc(). In inet6_create(), use the cached proto rather
than dereferencing the protosw after leaving RCU.

Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable protocol modules")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v3:
- Reject protocol owners in MODULE_STATE_COMING before taking a temporary
  module reference.
- Cache the owner under RCU and use that pointer for module_put().
- Use the cached proto for the IPv6 backlog callback instead of
  dereferencing the protosw after RCU unlock.

Changes in v2:
- Pin answer_prot->owner in inet_create()/inet6_create() under RCU instead
  of reordering try_module_get() in sk_prot_alloc().

Link: https://lore.kernel.org/netdev/20260825172349.232794-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/netdev/20260823171311.3857087-1-nicoyip.dev@gmail.com/ [v1]
---
 net/ipv4/af_inet.c  | 16 +++++++++++++---
 net/ipv6/af_inet6.c | 18 ++++++++++++++----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..6b87f0b6cc22 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -263,6 +263,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	struct inet_protosw *answer;
 	struct inet_sock *inet;
 	struct proto *answer_prot;
+	struct module *answer_owner;
 	unsigned char answer_flags;
 	int try_loading_module = 0;
 	int err;
@@ -322,9 +323,16 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	    !ns_capable(net->user_ns, CAP_NET_RAW))
 		goto out_rcu_unlock;
 
-	sock->ops = answer->ops;
 	answer_prot = answer->prot;
+	answer_owner = answer_prot->owner;
 	answer_flags = answer->flags;
+	if (answer_owner &&
+	    (module_is_coming(answer_owner) ||
+	     !try_module_get(answer_owner))) {
+		err = -EPROTONOSUPPORT;
+		goto out_rcu_unlock;
+	}
+	sock->ops = answer->ops;
 	rcu_read_unlock();
 
 	WARN_ON(!answer_prot->slab);
@@ -332,7 +340,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	err = -ENOMEM;
 	sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
 	if (!sk)
-		goto out;
+		goto out_module_put;
 
 	err = 0;
 	if (INET_PROTOSW_REUSE & answer_flags)
@@ -398,6 +406,8 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		if (err)
 			goto out_sk_release;
 	}
+out_module_put:
+	module_put(answer_owner);
 out:
 	return err;
 out_rcu_unlock:
@@ -406,7 +416,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 out_sk_release:
 	sk_common_release(sk);
 	sock->sk = NULL;
-	goto out;
+	goto out_module_put;
 }
 
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a11999..1df8b2e7e243 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -110,6 +110,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	struct sock *sk;
 	struct inet_protosw *answer;
 	struct proto *answer_prot;
+	struct module *answer_owner;
 	unsigned char answer_flags;
 	int try_loading_module = 0;
 	int err;
@@ -167,9 +168,16 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	    !ns_capable(net->user_ns, CAP_NET_RAW))
 		goto out_rcu_unlock;
 
-	sock->ops = answer->ops;
 	answer_prot = answer->prot;
+	answer_owner = answer_prot->owner;
 	answer_flags = answer->flags;
+	if (answer_owner &&
+	    (module_is_coming(answer_owner) ||
+	     !try_module_get(answer_owner))) {
+		err = -EPROTONOSUPPORT;
+		goto out_rcu_unlock;
+	}
+	sock->ops = answer->ops;
 	rcu_read_unlock();
 
 	WARN_ON(!answer_prot->slab);
@@ -177,7 +185,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	err = -ENOBUFS;
 	sk = sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern);
 	if (!sk)
-		goto out;
+		goto out_module_put;
 
 	sock_init_data(sock, sk);
 
@@ -201,7 +209,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	sk->sk_family		= PF_INET6;
 	sk->sk_protocol		= protocol;
 
-	sk->sk_backlog_rcv	= answer->prot->backlog_rcv;
+	sk->sk_backlog_rcv	= answer_prot->backlog_rcv;
 
 	inet_sk(sk)->pinet6 = np = inet6_sk_generic(sk);
 	np->hop_limit	= -1;
@@ -251,6 +259,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		if (err)
 			goto out_sk_release;
 	}
+out_module_put:
+	module_put(answer_owner);
 out:
 	return err;
 out_rcu_unlock:
@@ -259,7 +269,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 out_sk_release:
 	sk_common_release(sk);
 	sock->sk = NULL;
-	goto out;
+	goto out_module_put;
 }
 
 int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
-- 
2.43.0
