Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C12517BCF
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902936; cv=none; b=hAnz5l3t6mrNlW+yBHxbPOSwX574rcNGsVKGd71DAhDnMjSnuL8bvRhQ2vCV25vNbQf3M8MJHRyY/pT2njN8s1h00yaqvWAPizt6zAcsu1dSmkZ0ALrTZx1Xnl51IalQQkd7GehKUd5RtjbOyfKEFVi9qa42JRLt2CraAMR3smU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902936; c=relaxed/simple;
	bh=E8RQqupLJPfpG3jAktu3E/48imrQiGWVjKD4tHSeVM0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NtLZnbR2oWsCtriJAySki3AsDxxxDy9BG6U9iPth9HkVg48O0pJyzMWNjlsQEC6wlqpV/9QeIEcr//drn9f5tlhyGO5Fm7WXT20G0u/13RQ/BaPUK+BF5OA97BhrJu+jeVlUDjWDtMdicbG8L77a4yFYfvap+hH0NpC5myo2O7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSFJ95PE; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSFJ95PE"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6df1eeb43feso1267278eaf.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902933; x=1792507733; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGzdiXhMgkKl3fTmv+eX/XxMwO4CDixTDgjBYXLhFV8=;
        b=VSFJ95PEonSKuUdTBPmz33xt5sqtOGSdysdCzHpFX+hMvD2TuB/GbvR/0KmVe2Fx/h
         675hfHmnBbFjUd6ErEk0NT75S5cn23lI25DmqTDA31LhzrxmErCNJ6mGcY2Ee4z0UEL5
         fUfE1vwVaQgqCViJ2uMIRlokyYHDZ8xXYPNurNDe0aQEsmdsh3Mqp41/NLDiYwgMvm7c
         CfjmNWlS3s38skrP6S5iQWIo+N3TeMi93VyyGOySGxfDvnESdkuStFE09slyil6aeQRP
         lshtd4HE4Q3LC2VO/2M8EpNQxDI+NiQABEx9QlNBFH3rz+e/6EJVGPWJJFp6/+j+pEY/
         5aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902933; x=1792507733;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wGzdiXhMgkKl3fTmv+eX/XxMwO4CDixTDgjBYXLhFV8=;
        b=jABYMYNHZnM1dvDitrNRHCtk3fPTNWNeU1uxrDBiFbZ3VKGmLbaPlb5ujf7J1Mpuad
         fEdzJ1bb4/6jT5ZyUxTVLb6N3cfF+ZqhCSNdB7qfpiF+DlTiNnyDkeMNszNwNZBAbwAH
         xMgS4kGW/kL5e2BkSxTF2Vh5nSAll38Y+J1IFzEz+Cuq/78yWUR+Lbrps8DTOHOFYYHD
         mqEuP04ePufIh8150wOpj6KpNbX0TxsMXXmz1LZ+ZlmBJSu1qdyvecvkYdsUqZiR17e7
         gbcqFxFuEkXvaZDUrrsq4pHFyTrjWxLtIC+SYuEHdAFbI4adgGFBCoHtePoYujdn2D8a
         Tf1g==
X-Forwarded-Encrypted: i=1; AKwUvBwxrfwVGDbmVj/byG3q+wQSPcAk/qobTk4wNsLhd/xjM/vXIH4gj6ZxDTAuH9tNU2em/6LRb78=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvgoFZ2ayYRNjdcmt900vKPTzkJllpTNaBqjfZOiM/k7jrTGsQ
	1yDxX5b749zupkiqykzIcXp4A2Vj5JxGB01PMBmIGkwKLiEmF3CMlrjW
X-Gm-Gg: AYBFou1rg6HIzyqXB5lcVOBoFzSa14ZDa4dzug5vYFEwmlzTjUSa2ygG1wq7zt7Vaiw
	2QZ8LYMTMKPsXQ3mY/iNE59z3iyKiplasRRzgXCEiG9XSASHtKFIOaYKQgIwjb2vgydTyy1psZY
	kLOCtwUm8mGn/APRVw4JrXhZ4Qzk7et5zwNjjV0Y4U8ad+ih6CZ4GRnHxQax6GhWTSpCi5FnwWm
	rwOdE9Ml7NyCjzGPfZ+RdvpdH6LXz+B3RVU2/lFoLj4e+Ma2Wm4Dv0Hb8IYwNbHYhehLpK8dIfA
	HoOd5ul1JyLwv2aVdKISUmlw8s+MLu0Qi8H2f3tuzvhZFOeud1AgZacLTpX6zmyGbCcTDTeizWk
	c97CTCkOFAfHXcwYe5gZE1LWphqGGsFO2Bb3qJrrlGHLJ4K9BWhaBO6SCwRcQ66ODxYISc/RE10
	j/Tp85nLStxHEwfIaO0geYCiPtFwe/aK7G2nSgWytCTy2UOnYeBaDDPZMgnmZ0OIsKmh5Hxw+XN
	aQQYZS9eM7WaCCPL5KD2MT13dUBDIC+nGOGMuM+Dxt/jlHCFbCGwArySAqJ6mFa3EZpjZReRLCL
	W5gEgOs5iVXuqIZCitE8OqxGRWz5qv06iY6Hque7b1PQjhb8DBHm+KFBvTLK
X-Received: by 2002:a05:6820:7088:20b0:6df:baf1:fb15 with SMTP id 006d021491bc7-6f41ed2cb16mr3655389eaf.14.1791902933422;
        Tue, 13 Oct 2026 07:48:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:655c:317d:13b:b7be:f046])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8302f625a10sm12619106a34.0.2026.10.13.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:48:52 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To:
 Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net
Subject: [PATCH net v2] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Date: Tue, 13 Oct 2026 11:48:47 -0300
Message-ID: <179190292783.42615.15864971875396706456@gmail.com>
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

Raise TIPC_MIN_BEARER_MTU to MAX_H_SIZE + 2 * INT_H_SIZE so the MSS can
always hold INT_H_SIZE + MAX_H_SIZE, which also leaves room for name
table items, and add TIPC_MIN_BEARER_MTU_CRYPTO, which adds
EMSG_OVERHEAD on top, for CONFIG_TIPC_CRYPTO=y.  Use the crypto bound
for the device MTU check (tipc_mtu_bad_crypto()), the UDP MTU check,
the netlink MTU setting and tipc_bearer_min_mtu(), which also bounds
the max_pkt negotiation.

Found by manual code review, assisted by an LLM, and reproduced with
KASAN using two network namespaces joined by a veth pair (see below).

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Fixes: 2320bcdae628 ("tipc: fix changeover issues due to large packet")
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Changes in v2:
- Derive the crypto bound from EMSG_OVERHEAD instead of a hard-coded 32:
  TIPC_MIN_BEARER_MTU_CRYPTO in crypto.h and tipc_mtu_bad_crypto(), as
  suggested by Tung.  Drop the BUILD_BUG_ON().
- Apply the crypto bound to the UDP MTU check and the netlink MTU
  setting too.

Tested on 602042bf29f6 (arm64, QEMU, KASAN); net/tipc/ builds cleanly
with W=1 with and without CONFIG_TIPC_CRYPTO.  With the reproducer
below (node A with 40 cluster-scope publications and MTU 1500, node B
enabling its bearer on a veth with the given MTU):

  config            peer MTU   bearer on B         link   KASAN
  unpatched            100     enabled              up      slab-out-of-bounds
                                                            in publ_to_item()
  TIPC_CRYPTO=y        100     refused (too low)    -       none
  TIPC_CRYPTO=y        171     refused (too low)    -       none
  TIPC_CRYPTO=y        172     enabled              up      none
  TIPC_CRYPTO=y       1500     enabled              up      none
  TIPC_CRYPTO=n        100     refused (too low)    -       none
  TIPC_CRYPTO=n        139     refused (too low)    -       none
  TIPC_CRYPTO=n        140     enabled              up      none
  TIPC_CRYPTO=n       1500     enabled              up      none

The reproducer exercises the bearer-enable check; the max_pkt
negotiation in tipc_link_proto_rcv() uses the same bound through
tipc_bearer_min_mtu() but was not hit separately with forged messages.

This edits lines next to the ones touched by Yunpeng Tian's
"tipc: bound the device MTU accepted ..." (upper bound, posted
2026-10-03); the two are independent and I can rebase if that one is
applied first.

Reproducer (as root; build with "gcc -Wall -O2 -o pub pub.c", run
"sh tipc_repro.sh [peer_mtu]"):

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

 net/tipc/bearer.c    | 16 ++++++++++++++++
 net/tipc/bearer.h    |  2 +-
 net/tipc/crypto.h    | 19 +++++++++++++++++++
 net/tipc/udp_media.h | 10 ++++++++--
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e..02b2e9f56 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -433,7 +433,11 @@ int tipc_enable_l2_media(struct net *net, struct tipc_bearer *b,
 	dev = dev_get_by_name(net, dev_name);
 	if (!dev)
 		return -ENODEV;
+#ifdef CONFIG_TIPC_CRYPTO
+	if (tipc_mtu_bad_crypto(dev)) {
+#else
 	if (tipc_mtu_bad(dev)) {
+#endif
 		dev_put(dev);
 		return -EINVAL;
 	}
@@ -546,7 +550,11 @@ int tipc_bearer_mtu(struct net *net, u32 bearer_id)
 
 int tipc_bearer_min_mtu(struct net *net, u32 bearer_id)
 {
+#ifdef CONFIG_TIPC_CRYPTO
+	int mtu = TIPC_MIN_BEARER_MTU_CRYPTO;
+#else
 	int mtu = TIPC_MIN_BEARER_MTU;
+#endif
 	struct tipc_bearer *b;
 
 	rcu_read_lock();
@@ -711,7 +719,11 @@ static int tipc_l2_device_event(struct notifier_block *nb, unsigned long evt,
 		test_and_set_bit_lock(0, &b->up);
 		break;
 	case NETDEV_CHANGEMTU:
+#ifdef CONFIG_TIPC_CRYPTO
+		if (tipc_mtu_bad_crypto(dev)) {
+#else
 		if (tipc_mtu_bad(dev)) {
+#endif
 			bearer_disable(net, b);
 			break;
 		}
@@ -1158,7 +1170,11 @@ int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
 			}
 #ifdef CONFIG_TIPC_MEDIA_UDP
 			if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) <
+#ifdef CONFIG_TIPC_CRYPTO
+			    b->encap_hlen + TIPC_MIN_BEARER_MTU_CRYPTO) {
+#else
 			    b->encap_hlen + TIPC_MIN_BEARER_MTU) {
+#endif
 				NL_SET_ERR_MSG(info->extack,
 					       "MTU value is out-of-range");
 				return -EINVAL;
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 41eac1ee0..c8ac42cb2 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -61,7 +61,7 @@
 #define TIPC_MEDIA_TYPE_UDP	3
 
 /* Minimum bearer MTU */
-#define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + INT_H_SIZE)
+#define TIPC_MIN_BEARER_MTU    (MAX_H_SIZE + 2 * INT_H_SIZE)
 
 /* Identifiers for distinguishing between broadcast/multicast and replicast
  */
diff --git a/net/tipc/crypto.h b/net/tipc/crypto.h
index ce7d4cc8a..1b8b78608 100644
--- a/net/tipc/crypto.h
+++ b/net/tipc/crypto.h
@@ -156,6 +156,8 @@ struct tipc_ehdr {
 #define EMSG_OVERHEAD	(EHDR_SIZE + TIPC_AES_GCM_TAG_SIZE)
 } __packed;
 
+#define TIPC_MIN_BEARER_MTU_CRYPTO     (TIPC_MIN_BEARER_MTU + EMSG_OVERHEAD)
+
 int tipc_crypto_start(struct tipc_crypto **crypto, struct net *net,
 		      struct tipc_node *node);
 void tipc_crypto_stop(struct tipc_crypto **crypto);
@@ -196,5 +198,22 @@ static inline void msg_set_key_mode(struct tipc_msg *m, u32 mode)
 	msg_set_bits(m, 4, 0, 0xf, mode);
 }
 
+/**
+ * tipc_mtu_bad_crypto - check if device MTU is too low for encrypted headers
+ * @dev: the net device that its MTU needs to be checked
+ *
+ * Return:
+ * * false - valid MTU
+ * * true  - invalid MTU
+ *
+ */
+static inline bool tipc_mtu_bad_crypto(struct net_device *dev)
+{
+	if (dev->mtu >= TIPC_MIN_BEARER_MTU_CRYPTO)
+		return false;
+	netdev_warn(dev, "MTU too low for tipc bearer\n");
+	return true;
+}
+
 #endif /* _TIPC_CRYPTO_H */
 #endif
diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h
index e7455cc73..43f895bec 100644
--- a/net/tipc/udp_media.h
+++ b/net/tipc/udp_media.h
@@ -40,6 +40,7 @@
 
 #include <linux/ip.h>
 #include <linux/udp.h>
+#include "crypto.h"
 
 int tipc_udp_nl_bearer_add(struct tipc_bearer *b, struct nlattr *attr);
 int tipc_udp_nl_add_bearer_data(struct tipc_nl_msg *msg, struct tipc_bearer *b);
@@ -48,8 +49,13 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb);
 /* check if configured MTU is too low for tipc headers */
 static inline bool tipc_udp_mtu_bad(u32 mtu)
 {
-	if (mtu >= (TIPC_MIN_BEARER_MTU + sizeof(struct iphdr) +
-	    sizeof(struct udphdr)))
+#ifdef CONFIG_TIPC_CRYPTO
+	int mtu_min = TIPC_MIN_BEARER_MTU_CRYPTO;
+#else
+	int mtu_min = TIPC_MIN_BEARER_MTU;
+#endif
+
+	if (mtu >= (mtu_min + sizeof(struct iphdr) + sizeof(struct udphdr)))
 		return false;
 
 	pr_warn("MTU too low for tipc bearer\n");
-- 
2.43.0

