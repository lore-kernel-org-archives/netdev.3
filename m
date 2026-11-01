Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550483;
	b=U3VRqMvcm0KzUwRCTUxrx/sI+kqkD+61ukxTZN3o1a0Mln+tavaY2FweCDc4+LUHNMEW
	 JoCmG7Soz0WoMFgOLCS2GnyxotB6xiAn8ko0WlmBX2G3HUfsoJBkzwZbM/qJ2Ck8vsDf3
	 t62DV4qWF9QPPHYSYT5gP4Yn9XmPbqmHlLzAgRtKha3cwkEG2J8z/bSLVrs/Q9dPh9wTr
	 4VohxWSvp0pJp8GIcbWtgaw7VHIkrtgtVa4MSvUUP1DTGW0N9TdJfxJJYwjtRmLeIfNf5
	 vD4cqzu2z1+eLx8RXI7OIz1VsiTxWahGmycpSe0f/E8ljSxosG3kSDWeZ9gFZLcgAsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eABsnZ/xiMV1P1Hh0kfQ+K5UMrwNa1PfeTXL0+ks/DI=;
	b=fH3+Uk623C3kh43rsAEpS9tfrEc+HJCENCNP+pJi54ymUHXbVynNElwDfbGQWPyX4o0E
	 IBONzk6psM+hDY7X0wXK/aJREsBE1WTHHrN51rCzU8iTig/dTkPUxzAsLafABIza5XrfX
	 l3cY9Sf60RyHE+IzdNMLfvZgu9GV94gk363z7CZypN7kF8fGVFTms8hwnLAr4DLuLXUUy
	 heasf/GsIXFn+Znz1Gefut80Zunvpop+Iw7k660cT8cMSc2/i8lCmW1yrYx+knQwWtbPr
	 oUAQYkVZYafvQt985/G2yMERZQPdtB7UZHIe/TtVud9BoN1y2gvP3YOxQykxwos7HhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Qo+PtaK2;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A295606A32D
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A295606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Qo+PtaK2
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53c4b82919fso37461521cf.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793550482; x=1794155282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eABsnZ/xiMV1P1Hh0kfQ+K5UMrwNa1PfeTXL0+ks/DI=;
        b=Qo+PtaK214imZinwLDjHnJNrISIoM+sLJiagFv6ROgyQJhMr2RN4aV64ve8/5qblrZ
         8GGOcQcr55EpBzgh8UP3hdV2OQQhIiG6jOnCwAUpey8uqIATToLMXUm0YTYFw7FH2w5x
         W8mevxUxsiOkxX9Z1nHiCMbVkIFbfNjVBEdRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550482; x=1794155282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eABsnZ/xiMV1P1Hh0kfQ+K5UMrwNa1PfeTXL0+ks/DI=;
        b=dYFaoyVeCLZms/LdP7LluHGPT6z7nTtzk0U0e0g8lc7lbu0vtYRdN65RkVkZG714aS
         D297L1t1cw7lw4A3Up7MGKV1URsp6oxp3L24fgeiFSyzTJWP+oGnpPiC5UywD4/kSY4p
         KGxATFIaoU2ID9O5+1I+DQcjzLNSoScH4gN33AfdwRAtVeYqbFgWQz9dpg2U4C+F9Wtb
         NIjvprr9laVqkQUsccPQJLgbPP61w9jwCRTih0yzeCecTKxdQKxN+4fuYrgx9nklU13D
         n6UB8fwfkchYSleMvp21EfqXJCoXxvayfoatPLnhphuvrWxpBHT+Yp5sJDFoUXMEAYM9
         pdNQ==
X-Gm-Message-State: AFq9FYIy2Sc8SxEMW8jaqyLO8yEZ52jzbCemB0VigAfPqhhVc6wixx/M
	UhG2RqD6eHUoNjTbe8n54xmZBu5WaxrdXzcOasZ45wCcaXY+ML5QSimPjA2ViGB0uQz6OezhViL
	vVSI=
X-Gm-Gg: AYBFou2nH0NK26kMZH4i+fg3raQL0Sn9qNbVGJhkFjBQ4VOX6Q+aHO2O96aFambjXIP
	cb99cFfzwG8MDdonuiFLI21bXp2Yof6vC11AJFZISNtofOvBC0GiqYKQJfj/J2/00cyce1GlpRG
	o1/xrFbgDB/bS7jxEwwiwpF8WkaSYZB2Fxd0wtR5us6Vek0I/Bu9jX+yj7di96dnv29tPFeb5q/
	/Eyrflt2cs0u5L07cBlTjSr3FXt8NkOtf3wUiuzADo06kP1gqHNPe2A9P7EaV1hNIMqK3dkrNcQ
	19stbfdJ8mFLHpZAd8JdSad3H8oQcsFrXEA9jb4VcIBsWAvlxEIateh8l1cSDy6cmMXsSxst7lN
	UU2WDNuED5G0bsZBGpaeWQQ9md/rPQWtIvHEgAmliA53DocMDRsYN65RvS+KAyZ1g0Dv40q3Fiw
	cAKTnMPyWkmj1ELgEFAbTqYoRSCf6wVSCsJNhDIG+4FaIwJoImRb3/jJ1Q0tJEfrZlnFj4yf0xs
	u20yNKYqUSZ2imALmKZ1arnEJoO+EEgQ8Vavh9bCLheJeyMG20n8Y6EJxyg8qXq/tzIq5uCjLAL
	3sg8NZU16o+3PKFjZeF0PKV0SuvHSnH0BvSZZfN74lufYRpgy7nqdPnz+y89sgIiZtnDiHQprh6
	R1rvNVixyVAWIIms=
X-Received: by 2002:a05:620a:370b:b0:93f:1af1:7951 with SMTP id af79cd13be357-94421729826mr1240941485a.66.1793550482129;
        Sun, 01 Nov 2026 08:28:02 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm627354885a.1.2026.11.01.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:28:01 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v2 1/2] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Sun,  1 Nov 2026 11:27:55 -0500
Message-Id: <QDISC-6HS9.v2.r0.20261101105945-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v2.r0.20261101105945@mojatatu.com>
References: <QDISC-6HS9.v2.r0.20261101105945@mojatatu.com>
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

The issue:
teql_master_xmit() writes the slave's link header into the skb in
teql_resolve() and on retry pulls it back with __skb_pull().  Two bugs:

1. When the skb's header is cloned (e.g. a tc-mirred action on a
   physical device's clsact egress redirects to the teql master), the
   write corrupts the other clone.  Call skb_cow_head() first.

2. The pull always removes skb_network_offset() bytes.  For an
   AF_PACKET/SOCK_RAW frame with no dst entry, teql_resolve() adds no
   header, so the retry strips the user-supplied one.  Pull back only
   the length this slave added.

The Fix:
Track the added length per iteration; a header-cloned skb is unshared
before the write and an AF_PACKET frame retries with its header intact.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y and CONFIG_VETH=y, run as root. A teql master with
two veth slaves, the first slave returning NETDEV_TX_BUSY without
consuming the skb so that teql retries the frame on the second one:

  ip link add vethBAD type veth peer name vethBADp
  ip link add vethGOOD type veth peer name vethGOODp
  ip link set vethBAD up;  ip link set vethBADp up
  ip link set vethGOOD up; ip link set vethGOODp up
  tc qdisc add dev vethBAD root teql0
  tc qdisc add dev vethGOOD root teql0
  ip link set teql0 up

Send a SOCK_RAW frame that carries its own link header on teql0 and
capture it on the second slave's peer. A veth transmit does not return
NETDEV_TX_BUSY on its own; to hold the skb pending this reproduction used
a test-only IFF_DEBUG accelerator in veth_xmit(), which is not part of
this patch and was applied to both the unfixed and the fixed build.

On the unfixed tree the captured frame arrives with its header stripped
(176 of the 208 bytes sent, starting at the payload) because the retry
pulls skb_network_offset() bytes while this slave added none. With the
patch the frame arrives intact.

The shared headroom case needs a cloned skb: a PF_PACKET tap on the
master whose socket is never drained keeps the clone alive across the
transmit. A kprobe on eth_header then reports cloned=1 on the unfixed
tree and cloned=0 with the patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 70c948a26f80..ed8faa848f18 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -257,7 +257,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 static int
 __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	       struct net_device *dev, struct netdev_queue *txq,
-	       struct dst_entry *dst)
+	       struct dst_entry *dst, int *hlen)
 {
 	struct neighbour *n;
 	int err = 0;
@@ -288,15 +288,24 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	}
 
 	if (neigh_event_send(n, skb_res) == 0) {
+		int off = skb_network_offset(skb);
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
+		/* Unshare the header before dev_hard_header() writes to it. */
+		if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
+			err = -ENOMEM;
+			goto out;
+		}
 		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
 				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
+		/* The bytes prepended above skb->data, pulled back on retry. */
+		*hlen = skb_network_offset(skb) - off;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
 	}
+out:
 	neigh_release(n);
 	return err;
 }
@@ -304,11 +313,13 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 static inline int teql_resolve(struct sk_buff *skb,
 			       struct sk_buff *skb_res,
 			       struct net_device *dev,
-			       struct netdev_queue *txq)
+			       struct netdev_queue *txq,
+			       int *hlen)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	int res;
 
+	*hlen = 0;
 	if (rcu_access_pointer(txq->qdisc) == &noop_qdisc)
 		return -ENODEV;
 
@@ -316,7 +327,7 @@ static inline int teql_resolve(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	res = __teql_resolve(skb, skb_res, dev, txq, dst);
+	res = __teql_resolve(skb, skb_res, dev, txq, dst, hlen);
 	rcu_read_unlock();
 
 	return res;
@@ -330,6 +341,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct Qdisc *start, *q;
 	unsigned long flags;
 	int nores;
+	int hlen;
 	int busy;
 
 restart:
@@ -356,7 +368,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		switch (teql_resolve(skb, skb_res, slave, slave_txq)) {
+		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
@@ -403,8 +415,10 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			nores = 1;
 			break;
 		}
+		/* Pull back only the header this slave added. */
+		if (hlen > 0)
+			__skb_pull(skb, hlen);
 		skb->dev = dev;
-		__skb_pull(skb, skb_network_offset(skb));
 	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
-- 
2.43.0

