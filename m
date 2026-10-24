Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792862697;
	b=W92LCBz1pEz4f7x9ve5GD4D+meH+xeb9x6xpbrgxfNiA7IM5MqJyZvDfvfRO2evl6kBT
	 GYLJWJOGtqW1cNkhwrOchSG2sZWtmUkJ9GCFoaZ4tE+P4l8+OpsUoFz49mOAQFdu3z6w+
	 Wl0w7HuU+Zv1Pmpo7opE1obeWpceM3ibTGjO2DgOp3pS6rdKkY4gIZFJe12r6tGMxSaSj
	 /QV86/OzCuHv58gFRQSXOoKN0eCQ7ZV5Do2pBrN2Kkd8zzBvqUeDKbgCpvWrZbypn17MC
	 1ILX68r2nFtTtFKg8lZHO/ZihXBzz0CZGEdASFIjG1KLvvSvfU45/Tcfs7rIwJ+v5lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hByWglCgNXGSjXS1INVRmM21Twzzr1vFVwGQUO9sAN8=;
	b=2MrEC2+Khk+x4bEdNYRKXHpPrBgXUhgSVVsgjXNZibMJz+bVZdFvWxfm/cB5cMwOMejh
	 8oG4ZUnkK065LQ7v+uyJ/pSUi0/8yMNNvgteIjFOWkddFmwdgJwASWsKTl4lcKZhy4rbD
	 5WmtN+Jof4vr+OFqzxyPSOiL2o9nkyWe8iuuwBaH5MSbr6AkHCz+RiQ5g5qFuiAUUWlNc
	 gA3tF5FfTCxqxO8yJto0r+A/GU/YxYregfFmTXlmqsrVo/RaTsMxrwVc5+w+ES5NI/3I0
	 +H03FrpDuvZ7b5A7yXqLilF65SJahI071jkY5p+8kEkczGNqChm/OdG97bIaOZnci5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KLmsE4j3;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19985606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19985606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KLmsE4j3
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7a6e560f580so1246784137.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792862696; x=1793467496; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hByWglCgNXGSjXS1INVRmM21Twzzr1vFVwGQUO9sAN8=;
        b=KLmsE4j30S0AdXJMx1O8kh1lb4x96kc4GZ5wMxERVkOojp8uyiBmcI1DtlhrtXubF+
         JZgIR7RstdWNRbW3tArzg/csGakdMX7cgV4C2lIIQ/2SC4MsoN9IatdAj+Z4cNd4pzMZ
         AG3a/OCm9oBbSBqPzz4t++SeW0fYsDuB2FhWodakxjHLbg2OmQAT1wH765sHBjIRDYLY
         +KSO9o5keJIVQz3h7dUdQSQYIS5ePTJ1WZewiPZ2JRlS0zx4PMpfK6j7O/qIj1vcqJxe
         hGZZnNS0vZVfTfvLLl+6F3HDOEAOyu2aXT3zDyizvgKOprPZOPmQIHWKiODqxOAoklim
         8/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792862696; x=1793467496;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hByWglCgNXGSjXS1INVRmM21Twzzr1vFVwGQUO9sAN8=;
        b=L3nPv2PqlJD6vQ3TYakNamm7SU0klpWjxsLW05vCjIOmhhK4h/xGrEf4HRc3jZTF9R
         z3zCeOUubsDmbCy6y9fOfe3h8Ea/JzP3GgQRqCA7i703rq5AQUB3Rnsv8JwGSGANXvoi
         JsOZlxZnkq10Y2r1bwG5Exlv0/qTPz918NldAqNfZNPJ48bJjj5H78nklMsvYWVAMA2s
         YNlDrUbi7Q+KbtW/fTY4Gka62rLjcHcxPwlCzdLy/lIV8Hor9Dbjv7NpA207jGY+UQaX
         oxIXqTYZee8ElEUVcbSNgWJj54ySR4lsq39P4YyIJUPTxpfvh3xwNLUCQbuLLWjUFgAo
         zWxg==
X-Forwarded-Encrypted: i=1; AKwUvBzc4zhZMxbYRtAdx7zrf+K5X5Kmyvwi9vmtAif2zdoy+bqnMSHiGpAx3oLqar8q/u/Ss4bhPsE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuKb2zN3SqY8XPZ+3qJI0e9EZy+pxEf9Yyl6z93T7Hwu3FBQfy
	p4x9OHJchX7+s89A6c9jdOkqIm4F/ii0CoqquDL9aBk0EMyGXj382R6B
X-Gm-Gg: AYBFou3Aw4ueehBralq5fbR0JhhRffkGVj0OR+pnpZSRtghko5OV2MPDM3KwLdYDjAT
	XuthBOCZd5eW2SRxWwGB4SPASCeTStqUotO/zwS+2xzRoGARlL2QE+9GR3PjGdG3LNUoK3MKY8r
	YrTVjFjblJUhXPaYddXeTF6l1qRiwPMpWtFUIYUMEqRJAGcUpffVZwxjjFhUUny4RKaoPeqo+ID
	7LTUKz0gPDmpKNlInwSTDk6TOUb3kAJaIU58c4uXcmYUs40w81kmojzJej1HkOvJB7IP06aIha7
	Xabrf1zuzix2WS45enMjwfjcRN9OjGvwhAzCfdviLkEqUcspCel7mCxHTiLKfQrLY6lCllNCw7c
	g0+6ZXKMNw8THloQuCleyXFmm3ob0Rdsg9+7bWFFeys8xlilHgCCukXLfhYLC16c+EzfoXoPc/e
	63EMoCoJoKcfh1gMUcW6YOI47vUTcRWGnMHG/aPd9qsHf7vlwGSio8oqZrvgFgotMX6KnIDoBx6
	IV2vbXANIR3c9r5VFa2XlvYCpOyRqvHO6tkTrC1ErEGk1adBPm9rao0qVx4B8UnDvdPYTLa0ig3
	Ka4HyfHty4aCW9TlJgtg5uvwPxZKJYTyC4Gds0rzreMw90MRpw/1
X-Received: by 2002:a05:6102:5243:b0:7c3:90db:ed50 with SMTP id ada2fe7eead31-7ce5cd5f369mr780231137.17.1792862695851;
        Sat, 24 Oct 2026 10:24:55 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2804:7f0:b101:277b:c08d:c9f9:7c08:79c4])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e6cfa14sm3017295241.1.2026.10.24.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 10:24:54 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To:
 Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH net v3] tipc: raise the minimum bearer MTU to fit tunnel and
 crypto overhead
Date: Sat, 24 Oct 2026 14:24:49 -0300
Message-ID: <179286268997.95651.12726720970940214765@gmail.com>
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

Found by manual code review, assisted by an LLM, and reproduced with
KASAN using two network namespaces joined by a veth pair (see below).

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Fixes: 2320bcdae628 ("tipc: fix changeover issues due to large packet")
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
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

v3 retested on 602042bf29f6 (arm64, QEMU, KASAN); net/tipc/ builds
cleanly with W=1 with and without CONFIG_TIPC_CRYPTO.  With the reproducer
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

 net/tipc/bearer.c    | 17 +++++++++++++++--
 net/tipc/bearer.h    |  9 ++++++---
 net/tipc/udp_media.h |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e..3a55ee96f 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -544,9 +544,22 @@ int tipc_bearer_mtu(struct net *net, u32 bearer_id)
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
@@ -1158,7 +1171,7 @@ int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
 			}
 #ifdef CONFIG_TIPC_MEDIA_UDP
 			if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) <
-			    b->encap_hlen + TIPC_MIN_BEARER_MTU) {
+			    b->encap_hlen + tipc_bearer_mtu_floor()) {
 				NL_SET_ERR_MSG(info->extack,
 					       "MTU value is out-of-range");
 				return -EINVAL;
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 41eac1ee0..5b7b8c4a0 100644
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
 
 /* Identifiers for distinguishing between broadcast/multicast and replicast
  */
@@ -233,6 +235,7 @@ void tipc_bearer_cleanup(void);
 void tipc_bearer_stop(struct net *net);
 int tipc_bearer_mtu(struct net *net, u32 bearer_id);
 int tipc_bearer_min_mtu(struct net *net, u32 bearer_id);
+u32 tipc_bearer_mtu_floor(void);
 bool tipc_bearer_bcast_support(struct net *net, u32 bearer_id);
 void tipc_bearer_xmit_skb(struct net *net, u32 bearer_id,
 			  struct sk_buff *skb,
@@ -257,7 +260,7 @@ static inline void tipc_loopback_trace(struct net *net,
 /* check if device MTU is too low for tipc headers */
 static inline bool tipc_mtu_bad(struct net_device *dev)
 {
-	if (dev->mtu >= TIPC_MIN_BEARER_MTU)
+	if (dev->mtu >= tipc_bearer_mtu_floor())
 		return false;
 	netdev_warn(dev, "MTU too low for tipc bearer\n");
 	return true;
diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h
index e7455cc73..030e00ad1 100644
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
 
