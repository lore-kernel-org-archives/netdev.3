Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002146AEFA
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550408; cv=none; b=I5fkt1n87enqAaUyPa4MTJGufUYPHR1f5qwviaDA/zdqrF+LDBB7rp2dP4fY0RRp5Ttp8TiBJapBtn9pJEy1tmcNzyxskceh38d/OlCDdJEb0tAXp3g9+0GZPb28OsdKTCKWRQfeTyYxiKNTQ7W2HjA3n7bAlg5a8HPf3lHZ6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550408; c=relaxed/simple;
	bh=yHiQc8gsZbQVMsnZMG1z6FqwDOOKYeaaKXiOjNtEHts=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O6Tmd1Iw0IjCZJr7LLfuYhLBn4IxT/7cgaqASewQ2PNVGLe4kwRf2R8V5oAseaAC/a5LjAo3X1Z22MzLv/ghFZkPPlSWoruYgyk0SjdkM6xPAk7CmllkLQ0+3JCRbbkn+yYcWUpEUjhM8UsiFev8CsMub4z3EkYVnt+0OwACIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs99RsDX; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs99RsDX"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so1248222241.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791550400; x=1792155200; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8HL6hry0zapYHOiD3NkrNVLaI8PZnFiE/7eFrWRJvU=;
        b=bs99RsDXtotXocgvkWg+IH8tJOzjvqz2hcj7saZBKVf76FZPM7Zjxj1cX0XMMdpozy
         hkocAZjoqoKOYtTtCyTYEMsVaR0j6auGj9Mu4IIdHXwplfrcEDCD+zUo1zm+NSlbpVnp
         tfMHh5+a9Nf7nyBz9OiVb2l8LVrZYZnRF+G6KDUUZCIWwdrmLhQXjvuZU38LRxlXbaS8
         8GuQo0edksfzfjgi0gxn6F2OKh8FuH5//Ab3hXdo7f6WgF2anRRrOQQqSqkzBi/vqX7h
         ORBBtu5BELqrDU44ikfS/JvRdBD1s1ZjeKR+7LNOBbr3xgKfn/zwustT4Z1seHmV7zSk
         I2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791550400; x=1792155200;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8HL6hry0zapYHOiD3NkrNVLaI8PZnFiE/7eFrWRJvU=;
        b=dQJBODNhgHca9/D5POPGyNuwdT1cjMI8LrDOrZ0BihrDeUDHAjWAxrJHhLs3EXNjAs
         6jtXbgp6S/W10hFEmtzyN5egCXx9c3cXX7FlNCg8lMWGRYIL8FtiMkxbxhIdDuf2zOe8
         elVho21MMz3W4AzmMsoCrJBXrIZuK942+KD1XeDUy6A+Tn6VT/LTvd+pS2FXjnwPDjt8
         pD0HqS1rpxOix5/S5omoYJ+YdI+DZduej0YMhaZe6RI08jjppjEacbgv0dTIBEK32WsV
         vlPfJWCvS6zRMskDSmpAzoI4UKy5bJA9ggKOrjXbpG+cEoX4AutYPERfg+rn0CaTikTE
         UfMA==
X-Forwarded-Encrypted: i=1; AKwUvBx+wVpGbZhnhCRLTySZW/cEKwMD6V1xtO0qq01P/SSZ7tr49a5eRKMeBhMtjQSTMYztsB2HbzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7TGGPUSETV6jBvNxuD0gZXBxWR1BLkaNv1rYuDW9w+FTBai+v
	E730f0trvcrL0cyWc4fYBplxLe6kwE+Ag5HhZat8ipumkYIQT9DZG3iZ
X-Gm-Gg: AYBFou2HM9BeDhLNA5CTMwxjTHMvqqkfWUNO5HyjAdgCgWQyakSr2fy2/zPtc1gyg6+
	btFKSR0fx96vhpGus3jFte2JQMYb943BIH0G6TSaOnn1GedoTSrWi8rf8M/lIGTUXmWzT9qyb97
	R+3CRb5lI3Tme6CDWe6xo3Rx9myuDQlsb6gLxjiuP8IpNC+W1txtnv2jOLlLN9MTwBFQgC/p0Dp
	WZvqW4AQPDsHQcTbwdrrcZQhWlfyLYf6nNkfaYwGBl59ZCKoE4EL6zVsrkb7aB1MH59yPMcc+Ny
	VGBLWawiVxhtKec5hj2kVmoQ4DIB1RPjbyOmkfqsz00mKb9W/Oblj901po4SDEcvC+cxOGJHwlX
	8+rHtfGnn+aPbLoT0Figu9Bf1Nlwv12CJ7cT98TAnrKEVzQSUdJTm8CwLjkHLEqN4RvXa189Fn8
	gM2TMBuH5Xez05lxsLnuRabQPUwzw0P+XCwORVt55MSiNGnvuqPzr9Ie5BWXNeH5tGITx5CGNX9
	PHiX6B0dzgpXJUoYaFE/Zpok6rChCYHradbD0bhs7rE7r4GpYYQ9KtNS1tVGmwgkDxYt2p1nhDa
	0cjs/zwI6etwM2tVH/Foou+1qn/cne6cK2GCmeAb/ZzO4dRLZ/q+7uNQSjhw
X-Received: by 2002:a05:6102:5114:b0:7c0:e591:4da4 with SMTP id ada2fe7eead31-7cb37317c8fmr343647137.18.1791550400308;
        Fri, 09 Oct 2026 05:53:20 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:655c:c59b:456c:2d4d:2359])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb3539092esm1465114137.3.2026.10.09.05.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:53:19 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To:
 Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net
Subject: [PATCH net] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Date: Fri, 09 Oct 2026 09:53:14 -0300
Message-ID: <179155039490.29136.3966310214361645960@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

A peer can lower the link MTU to TIPC_MIN_BEARER_MTU (100 bytes, plus
the UDP encapsulation header) with the max_pkt field of a RESET or
ACTIVATE message; tipc_link_proto_rcv() only checks the lower bound
returned by tipc_bearer_min_mtu().  The same bound is applied to the
device MTU when a bearer is enabled.

That bound predates two later reductions of the link MSS:

  tipc_link_mss() = mtu - INT_H_SIZE                    (tunnel header)
                         - EMSG_OVERHEAD               (CONFIG_TIPC_CRYPTO)

With CONFIG_TIPC_CRYPTO=y, which is the default, an MTU of 100 gives an
MSS of 28.  Once the link comes up, tipc_named_node_up() calls
named_distribute(), which computes

  msg_dsz = ((tipc_node_get_mtu() - INT_H_SIZE) / ITEM_SIZE) * ITEM_SIZE;

For an MSS of 28 the subtraction is negative and the result truncates to
0xfffffff0; for an MSS between 40 and 59 it is 0.  named_prepare_buf()
then allocates a buffer with no room for any item (the u32 size wraps),
and msg_rem never reaches zero, so every cluster-scope publication on
the node is written with publ_to_item() past the end of that one skb,
over skb_shared_info and into adjacent memory.

Without crypto the MSS is at least 60, which still does not hold the
first fragment built by tipc_msg_build(): INT_H_SIZE fragment header
plus a message header of up to MAX_H_SIZE.  With pktmax below that, the
header copies run past the pktmax bytes allocated for the fragment.

Raise the minimum so the MSS can always hold INT_H_SIZE + MAX_H_SIZE,
which also leaves room for name table items: MAX_H_SIZE + 2 * INT_H_SIZE,
plus EMSG_OVERHEAD when crypto is enabled.  EMSG_OVERHEAD is defined in
crypto.h, which bearer.h cannot include, so the value is spelled out and
checked with BUILD_BUG_ON() in tipc_bearer_min_mtu().

Found by manual code review, assisted by an LLM, and reproduced with
KASAN using two network namespaces joined by a veth pair (see below).

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Fixes: 2320bcdae628 ("tipc: fix changeover issues due to large packet")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Reproduced on 602042bf29f6 (arm64, QEMU, KASAN, CONFIG_TIPC_CRYPTO=y)
with two network namespaces joined by a veth pair.  Node A binds 40
cluster-scope services, node B enables its bearer on a veth with MTU 100,
so A negotiates a link MTU of 100 (a remote peer can do the same with
max_pkt=100 in RESET/ACTIVATE).  As soon as the link comes up:

  BUG: KASAN: slab-out-of-bounds in publ_to_item+0x23c/0x288
  Write of size 4 at addr fff000001036ad00 by task ksoftirqd/1/22
   publ_to_item+0x23c/0x288
   tipc_named_node_up+0x2b0/0x714
   tipc_node_write_unlock+0x330/0x44c
   tipc_rcv+0x94c/0x2188
   tipc_l2_rcv_msg+0x118/0x1f4
  Allocated by task 22:
   ...
   tipc_buf_acquire+0x24/0xd4
   named_prepare_buf+0x3c/0x1dc
   tipc_named_node_up+0x528/0x714
  The buggy address is located 0 bytes to the right of
   allocated 704-byte region [fff000001036aa40, fff000001036ad00)
  tipc: Too large msg, purging xmit list 1 11 0 860 100!
  Unable to handle kernel paging request at virtual address 001fe000022e18a9
  pc : kfree_skb_list_reason+0xa4/0x32c

The final oops is the purge freeing the frag_list pointer that the
overflow wrote into skb_shared_info.

With the patch: MTU 100 is refused at bearer enable ("MTU too low for
tipc bearer"); MTU 172 and 1500 bring the link up with no KASAN report.
Builds cleanly with W=1 with and without CONFIG_TIPC_CRYPTO.
This was first reported to security@kernel.org; Tung Nguyen reproduced
it with the reproducer below and asked for the patch to go to netdev.

Reproducer (as root, CONFIG_TIPC=y, CONFIG_TIPC_CRYPTO=y; build with
"gcc -Wall -O2 -o pub pub.c", run "sh tipc_repro.sh"):

pub.c:

  /* Bind N TIPC services with cluster scope, then sleep. */
  #include <linux/tipc.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/socket.h>
  #include <unistd.h>

  int main(int argc, char **argv)
  {
  	int n = argc > 1 ? atoi(argv[1]) : 40;
  	for (int i = 0; i < n; i++) {
  		struct sockaddr_tipc a = {
  			.family = AF_TIPC,
  			.addrtype = TIPC_SERVICE_RANGE,
  			.scope = TIPC_CLUSTER_SCOPE,
  			.addr.nameseq = { .type = 1000 + i, .lower = 0, .upper = 0 },
  		};
  		int s = socket(AF_TIPC, SOCK_RDM, 0);
  		if (s < 0 || bind(s, (struct sockaddr *)&a, sizeof(a))) {
  			perror("tipc bind");
  			return 1;
  		}
  	}
  	printf("pub: bound %d cluster-scope services\n", n);
  	fflush(stdout);
  	pause();
  	return 0;
  }

tipc_repro.sh:

  #!/bin/sh
  # TIPC named_distribute() overflow reproducer.
  # Needs root, CONFIG_TIPC=y, CONFIG_TIPC_CRYPTO=y (default), KASAN recommended.
  # Usage: ./tipc_repro.sh [peer_mtu]   (default 100; 100..131 trigger it)
  PEER_MTU=${1:-100}

  ip netns add A
  ip netns add B
  ip link add va type veth peer name vb
  ip link set va netns A
  ip link set vb netns B
  ip -n A link set lo up
  ip -n B link set lo up
  ip -n A link set va mtu 1500 up
  ip -n B link set vb mtu "$PEER_MTU" up

  # node A: 40 cluster-scope publications (any number >= 1 overflows;
  # more publications write further past the buffer)
  ip netns exec A ./pub 40 &
  sleep 2

  # node A uses MTU 1500, node B uses PEER_MTU; the link MTU is
  # negotiated down to PEER_MTU, the link MSS becomes PEER_MTU - 72
  ip netns exec A tipc bearer enable media eth dev va
  ip netns exec B tipc bearer enable media eth dev vb

  # the overflow happens in tipc_named_node_up() as soon as the link
  # comes up (a few seconds)
  sleep 20
  dmesg | grep -A30 -E "KASAN|BUG:|Oops"

This edits the lines next to the ones touched by Yunpeng Tian's
"tipc: bound the device MTU accepted ..." (upper bound, posted
2026-10-03).  The two are independent; I can rebase on top of it if
that one is applied first.

tipc_msg_build() / named_distribute() could also get local sanity
checks; I kept this to the MTU floor so there is one fix point.

 net/tipc/bearer.c |  4 ++++
 net/tipc/bearer.h | 16 ++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e..bcf031fdd 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -549,6 +549,10 @@ int tipc_bearer_min_mtu(struct net *net, u32 bearer_id)
 	int mtu = TIPC_MIN_BEARER_MTU;
 	struct tipc_bearer *b;
 
+#ifdef CONFIG_TIPC_CRYPTO
+	BUILD_BUG_ON(TIPC_MIN_BEARER_MTU !=
+		     MAX_H_SIZE + 2 * INT_H_SIZE + EMSG_OVERHEAD);
+#endif
 	rcu_read_lock();
 	b = bearer_get(net, bearer_id);
 	if (b)
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 41eac1ee0..b99dcd23c 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -60,8 +60,20 @@
 #define TIPC_MEDIA_TYPE_IB	2
 #define TIPC_MEDIA_TYPE_UDP	3
 
-/* Minimum bearer MTU */
-#define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + INT_H_SIZE)
+/* Minimum bearer MTU
+ *
+ * The link MSS (see tipc_link_mss()) is the MTU minus a tunnel header
+ * (INT_H_SIZE) and, with encryption, minus EMSG_OVERHEAD (32 bytes, checked
+ * in tipc_bearer_min_mtu()).  The MSS must still hold a fragment header
+ * (INT_H_SIZE) followed by the largest message header (MAX_H_SIZE), which is
+ * what tipc_msg_build() puts in the first fragment, and leaves room for at
+ * least one name table item in named_distribute().
+ */
+#ifdef CONFIG_TIPC_CRYPTO
+#define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + 2 * INT_H_SIZE + 32)
+#else
+#define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + 2 * INT_H_SIZE)
+#endif
 
 /* Identifiers for distinguishing between broadcast/multicast and replicast
  */
