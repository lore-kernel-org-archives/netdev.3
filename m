Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087815;
	b=ZTkU4PZCXnUQ+1yYOPZ7uPbwzQsJAgxGpc7rXaKkmgWSTD1XoqmytQRH5c+8b7VJF0LY
	 Mz/vQ61lvp3rO/D1Bc+Y+6GJkNzlixkNcskinfCwWeL5VCBEji6r1183/yVxz9r1YGQjo
	 +YNBl4kKCxo2CU5yiK3JJVKZUH/hJu03My6eVJDViejT163rymDnBW+BzjaDqn9tCfkzU
	 j7sn2OW+m3D7nc69c+Ij5kThT7rBWaHn1U0kisy+kZs8tV2Vz6rJvkdH10M6Hjg3dZNy9
	 rpGGQzhahE2zVZycDUzY5JyD7HAomGz9pf2fhvxZX8zjAaUplI7zDG2atsdOT8sTITw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vi6rDNDccrxXPa1zbQgFmr5dJFtiIk0+PH3s9JJRU8I=;
	b=iH6mh5jrvYUeeeCKc+UxBgCCmr2HHMWyGO/ouxUT3/cnKYPtq/B5j3oSvLMd0oEsXLsN
	 0MWKjTJRiHCtxNpWtGUituLQIMtusmfH9mZ/HNCus/3iV7Ig5N7gpmaEXSoeujv9yw5Hw
	 Vel8t9Nbb/r9GD7RDjEF1thdzmJCzSUyuvyNcHkojtE2A8dcwQTiTL9+CoQg72zlpaaqk
	 MEoRVbqTLYDTbGkFSFKt4vYQuYmkenEPgY6qxMh2snBNW4Qi9C9qePvCUFVpkBvdIlfHB
	 SoM3T6bmeVG7dqbsVBkpCz63keskY8/hcDSBYvq97GLbAbQbCmutJ6LkM95/awt1Bpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mU3i849Y;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B55606A322
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B55606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mU3i849Y
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f1ca4132bso325888085a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793087814; x=1793692614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vi6rDNDccrxXPa1zbQgFmr5dJFtiIk0+PH3s9JJRU8I=;
        b=mU3i849Yg3Ns/g1fPqUQOYEc7THM3TQ7JnHEcQ4I8ZhNR9m6n5+7dvXtwbmAeXEN4w
         YAPcSyRh4VLlHnGXAt0OYPO4jorVmfHxk9nDtEmreAVbOWOmXFbObqISianzcjIdS1gH
         uqARHsoAGomgjCLV+sxZOpglMo/2KaL8OTgDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087814; x=1793692614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vi6rDNDccrxXPa1zbQgFmr5dJFtiIk0+PH3s9JJRU8I=;
        b=Nn7PKp0WBEtV1d7t7mgZqJ2Qi56eFKLTQM92U55Age+RN06B0ROrbyzJxA+e7lvapZ
         hkzlogS7n3Yow0vVglrhT+qCyVm5TF7rOrnIDqcLTD315aaGJ2oBb6FyukfmxVjkWk6V
         nPOGUV9jzyDmXePuFHg3+aWRtZHsObDq+Kgkx5Ik0hA2JK0c/Ek1UL5hsntur93eQs/x
         Xf2htgfG3Viu3N96E9r8QfLxfdXa2g518J0EhSV9ZXeThf3dtJ9+ESnZnc8ORYQxElm2
         +k2lNqDE7QqVEsv1txCEggWP4zJq5vpu/kTmc5rmPtCm04BbARBpQaNrk64ZGgr/FOhr
         vrzg==
X-Gm-Message-State: AFq9FYIEZyoBpRbumULX4QI1NUtUxMUkMG7WF5Cc1kORb6YaqGHcWimE
	Q7wkrO6/DIxloClxL06SfjvNpZKSLLN+x8XhuTCVEBDGoZIkKZabsu1faMNBVa4qdfo17JBIi5D
	t2Aw=
X-Gm-Gg: AYBFou348k4AhSqKW1XW8dqXUE/fv8BKiVhbSpwmcpNWdl+o7TsAAk1+g7KW8wtwe0q
	/Fixv3HKQRXN+pgrKvkrIcvT2z1+F2UrkiJX3Zi/J4xz2AOFUxPJoVGiChsu9c3h/EDo2AO7nAm
	vz0TWRE3Ai3ZNzIw0cnfCXrpS953VSJCJqcXxOCcMYio01esWdk2JtwPzXEoj+9jG/KQalnqXOj
	UfhrGTL2GS4wH3JOmJVFoHgNgVlZa2/H/KVFXfbjikmvB+cfEIUJ4QOKg+eOG5N8TAHVM58trP7
	15qNfjesPZD6vbwgOcR+AvPfgP8pZSZfrBwpBHtZS/LRwweZncTXEBvzGbHQdwZjvLQeMjG/OQi
	N3CGUkcWsQX+C2PGRK7JIdr8GtfM322PBT8p3fpLjYYsDMXNjPvRZCipRLb5c5SKhxh9U7H8jGp
	v4zsAFgdOZyA+ZREVLObdee7kJFID1AmoXm7jzpFPP91hGGHucMYKHf6V8l80OsWKv8Y9/y/0ks
	gDVlCSAnmXlJ5743+cRw9O9fXxVcRzHXBeDZq6uq5/lONVsL3L4GiaaJrHSY7QORhEHIGWXRcVp
	JUm5y8ILXZM3dKMN+HTRUgKe3bs=
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:9dc6 with SMTP id af79cd13be357-940ef9c39f3mr1380355085a.70.1793087813677;
        Tue, 27 Oct 2026 00:56:53 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066629dsm906675585a.7.2026.10.27.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:56:53 -0700 (PDT)
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
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2 repost3] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Tue, 27 Oct 2026 03:56:42 -0400
Message-Id: <QDISC-6HS9.v1.r3.20261027034729-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com>
References: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com>
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

teql_master_xmit() writes the slave's link header into the skb in
teql_resolve() and on retry pulls it back with __skb_pull().  Two bugs:

1. When the skb's header is cloned (e.g. a tc-mirred action on a
   physical device's clsact egress redirects to the teql master), the
   write corrupts the other clone.  Call skb_cow_head() first.

2. The pull always removes skb_network_offset() bytes.  For an
   AF_PACKET/SOCK_RAW frame with no dst entry, teql_resolve() adds no
   header, so the retry strips the user-supplied one.  Pull back only
   the length this slave added.

Track the added length per iteration; a header-cloned skb is unshared
before the write and an AF_PACKET frame retries with its header intact.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..acd03f9afc6b 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -245,7 +245,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 static int
 __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	       struct net_device *dev, struct netdev_queue *txq,
-	       struct dst_entry *dst)
+	       struct dst_entry *dst, int *hlen)
 {
 	struct neighbour *n;
 	int err = 0;
@@ -265,15 +265,28 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	}
 
 	if (neigh_event_send(n, skb_res) == 0) {
+		int off = skb_network_offset(skb);
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
+		/* The skb may be shared (e.g. a packet tap clone); make the
+		 * headroom private before dev_hard_header() writes into it.
+		 */
+		if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
+			err = -ENOMEM;
+			goto out;
+		}
 		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
 				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
+		/* The header, if any, is prepended above skb->data, so the
+		 * network offset grew by exactly the bytes to undo later.
+		 */
+		*hlen = skb_network_offset(skb) - off;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
 	}
+out:
 	neigh_release(n);
 	return err;
 }
@@ -281,11 +294,13 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
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
 
@@ -293,7 +308,7 @@ static inline int teql_resolve(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	res = __teql_resolve(skb, skb_res, dev, txq, dst);
+	res = __teql_resolve(skb, skb_res, dev, txq, dst, hlen);
 	rcu_read_unlock();
 
 	return res;
@@ -305,6 +320,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct Qdisc *start, *q;
 	int busy;
 	int nores;
+	int hlen;
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
@@ -332,7 +348,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		switch (teql_resolve(skb, skb_res, slave, slave_txq)) {
+		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
@@ -374,8 +390,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			nores = 1;
 			break;
 		}
+		/* Undo only the header teql_resolve() pushed for this slave.
+		 * Pulling skb_network_offset() instead would strip a
+		 * userspace-supplied header when the slave added none, e.g.
+		 * an AF_PACKET/SOCK_RAW frame with no dst entry.
+		 */
+		if (hlen > 0)
+			__skb_pull(skb, hlen);
 		skb->dev = dev;
-		__skb_pull(skb, skb_network_offset(skb));
 	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
-- 
2.43.0

