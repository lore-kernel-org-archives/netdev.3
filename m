Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3627083C;
	Fri, 24 Apr 2026 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049175; cv=none; b=uFgCbBzYaRkbvbWdMC7Jazs/b97R6YYLUc2Cf7e+JELd12KIHgXxveDUWZMTKC+suoHjloC4R/GLDAOFJBBYWvndb0PIQp/YfBH3fCJ8mN/cB9hDN+crteCdbanWeSIohaa3i4PMtmoZb3PMIv487P8OwChmtA08BgTkPgGriYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049175; c=relaxed/simple;
	bh=1ZxVkCZkdOMj1e5Rit2RD7kElzYAiwzaV8stRbjw6uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9UDBdF/AQp0uiQIwfhhpovtGCypEczHTJW+2XUEVuzpbJQAyIl8nI+caeNLPWfZmgxfYQWAk7zLbi1IIb2Wns0aAJZiC5xVK+FjH9BN5/6C3VPxUTlo2m2yczmExueZuksnQA5j/nlq4JXexOayta3Lju7S+AFRjxwcG6p2Afk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKTzX9eq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKTzX9eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777049173; x=1808585173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZxVkCZkdOMj1e5Rit2RD7kElzYAiwzaV8stRbjw6uU=;
  b=JKTzX9eqPM+2M7qQvtGJlV/g3voKT6VqWjYTU3l00AdjtbTZ/3ew2S+M
   pNXjutUoi+yHVZr/L63jo1wAzby6z5A0KS1vmr2IXcBeQUNwFFSdB6AGy
   RGEqT48rO5Nbdqr5iEuIdaQjBwcpAXtzIpA5R9RBst60vCtz15pwe7m7/
   bDG9AdB3Csy+gLDsjaFH3eE2wsFeFgzlDGf2iCdmfIpWrDoLX0OYRvAQN
   RH23Mb1hU/cvaln0Cn3BZ0FmWaMXPqJTMMYkHK1UJSdsvxWQ8sjubwpf9
   soXr/QOjhq4ALpRzPxXuYkCqH+2l7ZkrWrNUh+bOmVjTFzn/kVnCzokMs
   Q==;
X-CSE-ConnectionGUID: Zgir9zHNQdqbi4qqcfltCw==
X-CSE-MsgGUID: rUwYFlGeTNaSzJtVTCoghg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="95595392"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="95595392"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 09:46:12 -0700
X-CSE-ConnectionGUID: TgpTLu0fTJScrpNryqOe/A==
X-CSE-MsgGUID: DmeG5Bk2RjeAqoQriW3ubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="233290857"
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 09:46:11 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
To: netdev@vger.kernel.org
Cc: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in kernel_sock_shutdown (4)
Date: Fri, 24 Apr 2026 09:47:17 -0700
Message-ID: <20260424164733.356003-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
References: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This report was analysed with the help of an automated kernel crash
analysis assistant. The analysis below is tentative and should be
reviewed by a human before any action is taken.

Decoded Backtrace
-----------------

1. kernel_sock_shutdown -- crash site (net/socket.c:3785)

  3783  int kernel_sock_shutdown(struct socket *sock, enum sock_shutdown_cmd how)
  3784  {
  3785      return READ_ONCE(sock->ops)->shutdown(sock, how);
              /* CRASH: sock->ops is NULL (R12 = 0x0); KASAN traps
                 null-ptr-deref at offset 0x68 = offsetof(proto_ops, shutdown) */
  3786  }

  Register context at crash:
    RBX = 0xffff888058587240  (struct socket *sock)
    R12 = 0x0000000000000000  (sock->ops, loaded from RBX+0x20 -- NULL)
    RDI = 0x0000000000000068  (= NULL + 0x68, address of shutdown fn ptr)
    RBP = 0x0000000000000002  (how = SHUT_RDWR)

2. udp_tunnel_sock_release (net/ipv4/udp_tunnel_core.c:196-202)

  196  void udp_tunnel_sock_release(struct socket *sock)
  197  {
  198      rcu_assign_sk_user_data(sock->sk, NULL);
  199      synchronize_rcu();
  200      kernel_sock_shutdown(sock, SHUT_RDWR);  /* <- calls crash site */
  201      sock_release(sock);
  202  }

3. rxe_release_udp_tunnel inlined (drivers/infiniband/sw/rxe/rxe_net.c:290-293)

  290  static void rxe_release_udp_tunnel(struct socket *sk)
  291  {
  292      if (sk)
  293          udp_tunnel_sock_release(sk);
  294  }

4. rxe_sock_put (drivers/infiniband/sw/rxe/rxe_net.c:632-643)

  632  static void rxe_sock_put(struct sock *sk,
  633                            void (*set_sk)(struct net *, struct sock *),
  634                            struct net *net)
  635  {
  636      if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
  637          __sock_put(sk);
  638      } else {
  639          rxe_release_udp_tunnel(sk->sk_socket);  /* <- release BEFORE clear */
  640          sk = NULL;
  641          set_sk(net, sk);                         /* <- clear AFTER (too late) */
  642      }
  643  }

  Caller: rxe_net_del (rxe_net.c:644-666), triggered via:
    nldev_dellink -> rxe_dellink -> rxe_net_del -> rxe_sock_put

Tentative Analysis
------------------

sock->ops is set to NULL by sock_release() (net/socket.c:726) after
calling ops->release(sock). The crash in kernel_sock_shutdown() means
the socket was already passed to sock_release() before this call.

Two independent code paths can release the same UDP tunnel socket stored
in the per-network-namespace rxe_ns_sock structure:

 Path 1 -- namespace teardown (rxe_ns.c, rxe_ns_exit()):
   rcu_assign_pointer(ns_sk->rxe_sk4, NULL);   /* clears pointer FIRST */
   udp_tunnel_sock_release(sk->sk_socket);      /* then releases */

 Path 2 -- RDMA link delete (rxe_net.c, rxe_net_del() -> rxe_sock_put()):
   sk = rxe_ns_pernet_sk4(net);                 /* reads pointer (no ownership) */
   rxe_release_udp_tunnel(sk->sk_socket);       /* releases FIRST */
   set_sk(net, NULL);                           /* clears AFTER */

The following TOCTOU (time-of-check time-of-use) race is possible when
namespace teardown and RDMA link deletion occur concurrently:

  Thread A (rxe_net_del):
    rxe_ns_pernet_sk4() -> sk = X  (non-NULL)

  Thread B (rxe_ns_exit):
    rcu_assign_pointer(sk4, NULL)
    udp_tunnel_sock_release(X->sk_socket)
      sock_release(X->sk_socket)
        X->sk_socket->ops = NULL       <- clears ops

  Thread A (rxe_net_del) continues:
    rxe_sock_put(sk=X, ...)
      rxe_release_udp_tunnel(X->sk_socket)
        kernel_sock_shutdown(X->sk_socket, SHUT_RDWR)
          READ_ONCE(sock->ops)->shutdown(...)
                                       <- CRASH: sock->ops == NULL

The bug was introduced by two commits in March 2026 that added
per-network-namespace support to the Soft RoCE (RXE) driver:

  13f2a53c2a71e  RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets
  f1327abd6abed  RDMA/rxe: Support RDMA link creation and destruction per
                 net namespace

Neither commit provides synchronisation between the two teardown paths.

Potential Solution
------------------

Replace rxe_ns_pernet_sk4() calls in rxe_net_del() (and rxe_notify())
with an atomic exchange that simultaneously reads and clears the pernet
pointer, so only one of the two teardown paths can ever obtain a
non-NULL socket pointer:

  struct sock *rxe_ns_pernet_take_sk4(struct net *net)
  {
      struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
      return unrcu_pointer(xchg(&ns_sk->rxe_sk4, RCU_INITIALIZER(NULL)));
  }

Whichever path (rxe_ns_exit or rxe_net_del) wins the xchg gets the
socket and releases it; the loser gets NULL and skips the release.

More information
----------------

Oops-Analysis: https://lore.kernel.org/r/69ea344f.a00a0220.17a17.0040.GAE@google.com
Assisted-by: linux-kernel-oops-x86 skill (Claude Sonnet 4.6)
