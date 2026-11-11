Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410258;
	b=xGy+QZoWuGCEXrttjclTC9xbJZ50+HAMZnpJkYV/vWc9FEiikkMTNqTxOIHhb8CNFSfz
	 ef4RQwXi5FSP9nOWQXSN9WKu1E8pJL07Am3lmUL+xW1VS3/oB3ksOMRzzftqd8J9yJVeZ
	 3AKBvVrNJQKk5ZGIiRS7RgxVz2vx5Yh+5+qvq257dDYrJDDuVWGH86qKzVb6UTBOQpi6j
	 oIVlvkc1mydHWamxo045UeaZF2mu/o4wIUcr1esmFED2XjRl80qwWUgcTInj/Sa01l6qO
	 ITuGFqW11kDRCW3IiXhwR1dS2R4AYpLkpCUi8ndS0um0WI3m24TCv7oQLhVhod55Few==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H0K9/2yWQc9yGlSZDG/efoWRwME1E9flXkl10e5iCWM=;
	b=1pbz0eOFydF2UghzoChs//OsFzfHXbgNgkNxRHw3x4zlb02KNSmt0faPSprjrV8SQI5m
	 RJchUPTrGUsPw66Y8hbD8Of1FnZM/MIci0V6keP9txBn6knX7sUQwBSCdJbpL5mL5+jU8
	 ZjIJktJAUN3uqTG4CnuqNRbLMNyS9vX0tAWIoCLXEMe31XklssL4m9Jy8DCA/prbeP9uw
	 72MVrnM2mb/pGDYRC89W/0KGyt7SYsXfSegMAe1gpFpSILbyqwDDT5rvDDr0Agwx3m0bg
	 hdOiXC9KAbTorAarwMPs9tHu4cY3Rkivag2pHEiyJqtG7gD9f+LC+W17E+rXXubgiww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="wW/zwBl6";
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A24606A336
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A24606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wW/zwBl6
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b3653df740so11020717b3.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794410257; x=1795015057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0K9/2yWQc9yGlSZDG/efoWRwME1E9flXkl10e5iCWM=;
        b=wW/zwBl6BRNfowmy2+Xmisuk6gUggNWb+udYXwP5kuBeWyqudLQo+MBdELJCVXjWgX
         G9IgE/gJDpJttZjdULhGDAcTFqmOZa2XJyUSuf8yWkm0WNSiyj7cmVr0Tj/ZfvS2xYvk
         7rEENF4N4U3r7dB0Yiu9gUrmy5m0AHM0BSvlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410257; x=1795015057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0K9/2yWQc9yGlSZDG/efoWRwME1E9flXkl10e5iCWM=;
        b=1SE65gWE/eZXUJgG022uFLerYqj6bv4wmacmZg7Sf8LcR+eRoRwy+FMiu01aQPUysQ
         IS8Estx20Otv7dTJHagz/SwvhwmceZj2LlV7OpgumnqRfxqT7j77rPdr/RxGxV1oJFvx
         p2YyUe8fZMCLn9Q33NGrYifCjLMM3XKMzJoA+srkjn5cuRV6YObh8R10gayZwqkdzmAt
         9ojZaD3q2rPmH4DtaQhtIjALCAhDrcg8pZ/XUJWYmpQWtdDYFm5chErscYT2Nt7ieydW
         BNS8kDqlPfxAJulQ2khtXGt9rK9VvqbTaGLbxIC7BUKTDajRjYUcGrx1fJ17T42IJoox
         C5Tw==
X-Gm-Message-State: APuU4Z/CPelOEp75jlDJgs7fxrvK6PzX4p1G7evtgY1wDXoSzkxPFeg4
	1bhvwNuBKMkChVHDlDBMEswbskoMQCzouaBHVHFQNnDVXwlmhN06fSfkbeQgeCAuTNe76SKY2h2
	5PNo=
X-Gm-Gg: AYBFou3h/giMmJI8jKpGv8w7re/2dXcxwTVIC+H+VBOWnYXOsEfn3lp/peNdUbVRC3c
	29rGWXBU4JIvwN6PyRJDviZTqQImT9XHvzMtvVETZD1jq47sAuGfnDmyfCSPn/7Rk7DskFf9Z1Q
	qIJiln5Wb/JPU7FZi46R4G+AkQC6lUPOVw1M8hyL4xXa3cZemATLs57UgprkFtvi7qFLQfPPWJu
	TmmC1VrN8LgADrcuODXrMYOsEFi5cQjvHo6bt4m0br+Qfej5moZODjqt7ElkHISktbr7DtU6zax
	03BZTQooUi6PgGJ0DPAJUhXXW55SPugM20/lwGJq2tLPvxJjhKuM0dod0qHvxznS7PEfIST8zM/
	BWPLpULFmHDWuOH+YYVfYY5v6G7MXEZFEdeq+cZRHYFYtD3cBG/jDe3T20By95ymFTiv4HJFVAu
	Ql8rRa7slppLAkzXEhsl2JFmObBtRolQilbRBuMEU5vDqYLKDwo28PEQIiuK1vNdaNGupm5cmjW
	xfWjIY+zE1a2Qxj3HhmN9RZJmi5n946S7PS5IWozhQyimJe/G8Y8BRKTQCCRWVc7uoXDLmPAwdv
	ApRR9JqFaCs5EhbpyeNIpjFfF/3mrRT8afNG7ndHJ51tyIZ2ghqMlMVlfZ5duUTSCXMdsjUaGYQ
	7ty4L2nqLbf1WyOQ=
X-Received: by 2002:a05:690c:e01c:20b0:8b3:5969:f279 with SMTP id 00721157ae682-8b3a7e06f55mr17465347b3.3.1794410256810;
        Wed, 11 Nov 2026 07:17:36 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm46499187b3.27.2026.11.11.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:17:36 -0800 (PST)
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
Subject: [PATCH net v4 1/3] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Wed, 11 Nov 2026 10:17:28 -0500
Message-Id: <QDISC-6HS9.v4.r0.20261111094338-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
References: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
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
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v3 -> v4:
- added Simon Horman's Reviewed-by, given on the v3 posting. The patch
  itself is unchanged; the series is resent because 2/2 had to be split
  as asked in the review of that patch.

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

