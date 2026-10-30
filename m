Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793404397;
	b=V4HW0QOYRBuv474sT0Hm9zSwUJNiABm0T8qOJPc6XSELcAa8Gwc3+cltOU/4VdWV/l51
	 kf88rOa4GsYrwAVpY+0g7UMj/dnXzE8AbsHqwoagN0oG9fdXJbi4dMPt2nIcLbsN2Q8if
	 0C0eUuoZPdA4y15Kz9JDAJlfsBGmof0n+GEy6SDAQUcWraTQLaTxwNvQq5l5cxUKwMxqG
	 FhfXf3h7o/Cs4gwlBQg2lYe1qlX4QhmDkGKSPzR6rx/O2hGA+g1mDrsn8/ZbDX8EycfC2
	 jVLoXVmdj7hhwILmSrk1LDiKZukcgT/EXJTwFL5ETX/oUkiGFREB1PT4Lnbb2I9kBqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793404397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GIw+GF4eDiJHFNgm2i3uIASD3dg9+F+UqVRzru91FIs=;
	b=K0aoEPrMNf0TuJslrTo/9o+c5ES+AAHPXDIIJvj7R2HK+4dL0z224+6hNalVzL2lJRa3
	 YdEN5qsbK+gkj/MrwL07eQRq476+BEmahuqxK0PV7rI8YukcJrG09xk15K3zXBcVNiwL+
	 DL2g2tOATMu3Ne0o3Ei7TpDYGAT5a0b8QR7XV/FA3XvUH626r1F3fjNNXj8WHh/0rhC5G
	 kxJCscheLvW5U6HAHCp0Hd0lAQ7yHOyyPV4sPW1Svj8HJZYty6/P5S71yGZ/dbVcHigfk
	 SrARHC7XVH5ThJ5nwBthdYI5Rwku6oOG8EJ5RrQY1rXr/6O1R8PE5rSf1ZI1RhvyAcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y3sBVQy4;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3D606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 23:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A3D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y3sBVQy4
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so355075241.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793404395; x=1794009195; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIw+GF4eDiJHFNgm2i3uIASD3dg9+F+UqVRzru91FIs=;
        b=y3sBVQy4LTLycTmihHwYtv2ty18Lq4GTe5BJ0lR/E+byARC3KXK6AmBMkLrIoblDT/
         ADKKljABW84gLk9X1k7kxAgt/sbIuF5yO+8A2/1winSvRr9L+gUD5QMmOQrRagqmlF1g
         zPf0Ox1fsUUt9FcN+Lh98lwkDNmTJCYjyV2x4qo641aAGnQhUlT4bLwgcq+moY7OwXI3
         dAP/kFxynsm6i5NArItkz6Q38e9Drs90HgAL1YScpT79ofm0H/ihojTZ9Y88PYPMi5BW
         O3vH9KhyxexgybrALnKJNKPAZhCk+w29nG1qZkPoJgpvbLVAk6u0Aluyg0cOpgDplrc/
         Fozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793404395; x=1794009195;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GIw+GF4eDiJHFNgm2i3uIASD3dg9+F+UqVRzru91FIs=;
        b=n670EqgkKdORJc7aayhK381X+lmTEtd4XCBWBw8D/as3h7NSQLA7Mr//MBywiDoVUE
         btw3M/WaOcwznPrDFS3tAsbhCVYv+12MkFxq3okkDC4I1nwbc3dwrvGXj8olzCpXK87b
         s5VFIfBeVOx/fTGSg4LPKAmNOttVkdR8I1woXi0oIyGISAJDraaKi+nk8pF8XM7FjAMq
         xaOi9io49eHneBO8Y3Cl9smSBmmQeko7vEdEfyNH8ZACPj3H0I/0LUtUGCuw4vLYsm0V
         Xlt5Yz+wth/C2+nE1zv2ripEedQSrygCr3aRiVAOhh9s11tcXKIHkNI7zhzicjrFZhAG
         U/hg==
X-Forwarded-Encrypted: i=1; AKwUvBy/FRd1hDyMnxhHQn2DyimMG/8bNSvFQcDoMlCzupHXBHlrQ31RVxFXlwlhYLz5gqPQw+ao4q8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoNkfn18pGOqIe83OHI7D2nLU9OSiqWSJHAvEEKtCU/F6LZoL8
	DjnqiiP/tGlv+I+RoJOYuEJxKIC1T/2npWsNuZKv+CNfMvE68/Kp7Uep9zc71eB514Y=
X-Gm-Gg: AYBFou0MeDpIw5jxblgYWpzFJ2POS4we/8h7p/KXh3yu+wCB7X0QTr+i23TsawYPLZV
	zO+WJ37oBrylgc1bN8kjhluvt/o0jqgRSeCph55zsuO6GhqCJ7vopHyyeyOy+dBcThe4YtrSRQN
	hAm/mM87GS1WHq3ZDWUfq8k/Dx0bdkjDadIJEEFrIBJrl20qKP6Y9XZ3zzay04v2hAgHC7Iz7I5
	X2rEVorqGcgcPBvdDKjtbBeplGh3cZYSdp8LXf6SLzeVn0gctJCQubnwwUTq0bddenOa8kIn/+L
	nm/8cdievR4Ujiu+OvTaFZe37lzfPRItUEJ3w1Gp9wbKEioqELmJvsayA3V2TDlLRpJNVyk6fsR
	ybAUtmTnNUcbeLFL3yzU+pvYTWD6kmcvLBUDV57vzsL1YZ0VhPxifiHnHsS+QUZAtD70nXcoco/
	RwpSdE2aqrAGeQYWLs4wse5iruq9pdNcCLi1W75qK3gxxbQGjXcuEYRPz63QL1Vcab7awJFSED/
	BqkSj4tXqYe7PgaTARigwCOFXt3LgMkSFPnSYrJu4dofjfwcgwciD3/VOhNMe8qm/fgrrZ3KbuB
	oWJgT1YhC9uT8WqYOQpF6uxQWWOhbpnYkHHB2YQ2WYFqsDWWW9P+UO058if3OYiXK6EXRJ4Ajgl
	Lte9VwXnDZ69paZs=
X-Received: by 2002:a05:6102:3746:b0:7cc:9d46:f061 with SMTP id ada2fe7eead31-7d07273ecc6mr1784920137.26.1793404395194;
        Fri, 30 Oct 2026 16:53:15 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:91d7:81fb:defa:df94])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992edfb5511sm4688493241.0.2026.10.30.16.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 16:53:14 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To:
 Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH net v5] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Date: Fri, 30 Oct 2026 20:53:04 -0300
Message-ID: <179340438471.4412.6707287163192409104@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
table items, and add tipc_bearer_mtu_floor(), which adds EMSG_OVERHEAD
on top for CONFIG_TIPC_CRYPTO=y.  Use it for the device MTU check
(tipc_mtu_bad()), the UDP MTU check, the netlink MTU setting and
tipc_bearer_min_mtu(), which also bounds the max_pkt negotiation.

Found by manual code review and reproduced with KASAN using two network
namespaces joined by a veth pair (see below).

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Fixes: 2320bcdae628 ("tipc: fix changeover issues due to large packet")
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
Changes in v5:
- Drop the Assisted-by trailer; it is deprecated, see commit 1e035297ffda
  ("docs: remove Assisted-by references").  No code change from v4.
  Tool-use note: this patch was prepared with LLM assistance (code review
  and drafting); the analysis was checked and the reproducer was built and
  run by me.

Changes in v4:
- Rebased on net/main, on top of 592d0fdb02df ("tipc: bound the device
  MTU accepted for L2 bearers"); tipc_mtu_bad() keeps the new
  TIPC_MAX_BEARER_MTU upper bound and only the lower bound changes.
  No functional change otherwise.

Changes in v3:
- Keep the CONFIG_TIPC_CRYPTO dependency in one helper,
  tipc_bearer_mtu_floor(), instead of #ifdefs at each call site, as
  suggested by Paolo.  tipc_mtu_bad() and tipc_udp_mtu_bad() use it, so
  tipc_mtu_bad_crypto() and the crypto.h include in udp_media.h are gone.
  The bounds are unchanged: 172 with crypto, 140 without.

Changes in v2:
- Derive the crypto bound from EMSG_OVERHEAD instead of a hard-coded 32:
  TIPC_MIN_BEARER_MTU_CRYPTO in crypto.h and tipc_mtu_bad_crypto(), as
  suggested by Tung.  Drop the BUILD_BUG_ON().
- Apply the crypto bound to the UDP MTU check and the netlink MTU
  setting too.

v4 builds cleanly on net/main with W=1, with and without
CONFIG_TIPC_CRYPTO.  The runtime results below are from v3, retested on
602042bf29f6 (arm64, QEMU, KASAN); the rebase does not change the
bounds.  With the reproducer
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

 net/tipc/bearer.c    | 17 +++++++++++++++--
 net/tipc/bearer.h    |  9 ++++++---
 net/tipc/udp_media.h |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 774f68d..8b82101 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -546,9 +546,22 @@ int tipc_bearer_mtu(struct net *net, u32 bearer_id)
 	return mtu;
 }

+/* tipc_bearer_mtu_floor - smallest bearer MTU, excluding the media
+ * encapsulation header, that leaves room for a fragment header plus a
+ * full message header after the link MSS reductions (see tipc_link_mss())
+ */
+u32 tipc_bearer_mtu_floor(void)
+{
+#ifdef CONFIG_TIPC_CRYPTO
+	return TIPC_MIN_BEARER_MTU + EMSG_OVERHEAD;
+#else
+	return TIPC_MIN_BEARER_MTU;
+#endif
+}
+
 int tipc_bearer_min_mtu(struct net *net, u32 bearer_id)
 {
-	int mtu = TIPC_MIN_BEARER_MTU;
+	int mtu = tipc_bearer_mtu_floor();
 	struct tipc_bearer *b;

 	rcu_read_lock();
@@ -1164,7 +1177,7 @@ int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
 			}
 #ifdef CONFIG_TIPC_MEDIA_UDP
 			if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) <
-			    b->encap_hlen + TIPC_MIN_BEARER_MTU) {
+			    b->encap_hlen + tipc_bearer_mtu_floor()) {
 				NL_SET_ERR_MSG(info->extack,
 					       "MTU value is out-of-range");
 				return -EINVAL;
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index f9bfcc9..72abfca 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -60,8 +60,10 @@
 #define TIPC_MEDIA_TYPE_IB	2
 #define TIPC_MEDIA_TYPE_UDP	3

-/* Minimum bearer MTU */
-#define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + INT_H_SIZE)
+/* Minimum bearer MTU, not counting the crypto overhead, see
+ * tipc_bearer_mtu_floor()
+ */
+#define TIPC_MIN_BEARER_MTU	(MAX_H_SIZE + 2 * INT_H_SIZE)

 /* Maximum bearer MTU
  *
@@ -241,6 +243,7 @@ void tipc_bearer_cleanup(void);
 void tipc_bearer_stop(struct net *net);
 int tipc_bearer_mtu(struct net *net, u32 bearer_id);
 int tipc_bearer_min_mtu(struct net *net, u32 bearer_id);
+u32 tipc_bearer_mtu_floor(void);
 bool tipc_bearer_bcast_support(struct net *net, u32 bearer_id);
 void tipc_bearer_xmit_skb(struct net *net, u32 bearer_id,
 			  struct sk_buff *skb,
@@ -265,7 +268,7 @@ static inline void tipc_loopback_trace(struct net *net,
 /* check if device MTU is usable for tipc bearers */
 static inline bool tipc_mtu_bad(struct net_device *dev)
 {
-	if (dev->mtu >= TIPC_MIN_BEARER_MTU &&
+	if (dev->mtu >= tipc_bearer_mtu_floor() &&
 	    dev->mtu <= TIPC_MAX_BEARER_MTU)
 		return false;
 	netdev_warn(dev, "MTU not usable for tipc bearer\n");
diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h
index e7455cc..030e00a 100644
--- a/net/tipc/udp_media.h
+++ b/net/tipc/udp_media.h
@@ -48,7 +48,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb);
 /* check if configured MTU is too low for tipc headers */
 static inline bool tipc_udp_mtu_bad(u32 mtu)
 {
-	if (mtu >= (TIPC_MIN_BEARER_MTU + sizeof(struct iphdr) +
+	if (mtu >= (tipc_bearer_mtu_floor() + sizeof(struct iphdr) +
 	    sizeof(struct udphdr)))
 		return false;

--
2.39.5
