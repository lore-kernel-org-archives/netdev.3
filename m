Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709562;
	b=xcqqktCp4SFtIp4QUTDHAl/+23HwPA6u/O1HxQrpEoZYcb32AJcNJOv/4SvM7vSUkS4b
	 ABq332WTs3BUAxMQ16VDQq5NT1MqQk9TUaZ1keM5SnUL41/Kyx4tuOJ3zEnwL9ModRDhP
	 GTP1jVmCwV85eCHdejA0b5ie/f3bmZ6U8D49gdzdPK1L6ffxR6kavtDfFdFtf5OyGxOwd
	 zP3jGcwnV85/nDD007Vci0YZdPxUEbMJFOVQUAsBd1h2YG4FhGamo7JN1hNlaWzAf9OoP
	 ZFjJIYb/Zsvx6riE5qtHhQk/LHk8RFXm/eKabwa6KVKzSHZ6U8NflynuSA0nzaCO8+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tm2LiE4/DJlGbRR1Qduao2CPxUSYAOE/zxSX5BBGV6Y=;
	b=2/GeZArG2ODM1Rqluoc3VnxgX/Qg32li0XbPbHmAkWC5r7uv6s5h4/sT/YqHuUjPL9vR
	 Mjd11zbQRRyqoClzxoi2zBzJZt6nETJK9jPGVy1X0IYoctbFx3Yy2RYzRTJI9kTT+3fpg
	 MYlB7M2u/fp3vkgVm63CCiQKblmtbs8iNf0AoLrLGK5JEvq//SPj6ouJwPU18RpYm7DWy
	 CDUoRuGhNU7N3Xj7a/0Xm7hf1XELYkhhHQFfA2pWBvNmCde9XNVKGJxJSHbzXNZ3TR3sM
	 PjBOcpusIfGkRFMsB0+2XhIu2W9Y4afkjbQZ99fmBEnEcOSbPe5r1LaZyoTv2AHMwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=irhBASRD;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFF606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EFF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=irhBASRD
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab3d3c5761so39072127b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793709561; x=1794314361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tm2LiE4/DJlGbRR1Qduao2CPxUSYAOE/zxSX5BBGV6Y=;
        b=irhBASRDKUcKRumnEaAmTY2ljeO5oCcgsk6kEBR8a2L4NCX98cPcs9ddKJ7VCMF0bB
         /NPLlHLqyZ3pxOvGm4BNU6TcS+ZBe3qgRwutMuR8kZZCVxDvq7EYK3JKyijVasvpZhI3
         ZKRwvNW5+q2TepaNm+aUKPjdfo+joRe9qGLAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709561; x=1794314361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tm2LiE4/DJlGbRR1Qduao2CPxUSYAOE/zxSX5BBGV6Y=;
        b=K/4SrjwFrj45rj/cDRM1xTcYVd6M1YyejlskZpr5gX+st4tovb07cH/hZ/BKkyA0hc
         ZdcwihdZezfz2J22sfsMWjcuZA0hgwoQ76i6VAJbtlaIdVUFkEUVDU398JWSwLKJAmZu
         oXBpkXyIVrqXflJ8+34jfHzc55Lb6Qf6uk7Qi1D0XaVn79nunjRAGl2+jxPCuu/oOW+2
         4xwjErHifKRMbthaQ7XHG/8egs4cmABnlb57Y0Az14rJ3bgF65tBkoxd5NBsep/zyoGM
         wIec7x16EZGD0WWVBrkln5RQ+PNFID0v4PAZiZPxRpjagyo+RSGsBoKb5b1zkXWo0gIM
         4Fzg==
X-Gm-Message-State: APuU4Z928ghay1oT1n7QMKZWRnslrUbao3H1FD31iPmZkijk1SoJX4Ij
	nrqGeOyhxUO+5z6aiqcmCtb9CSel+Sg6Bw+9+xNpoVU/9y66gGtg3UBXLRNqXm6a7Ph5kc46kDv
	hLSo=
X-Gm-Gg: AYBFou1zDWCCM79x4ElhEeD2Vt/EKE2WuErAAp18ZhZj7dz486Qir2aM9GL/Nlmjo1b
	IXxhS2IpAxXH4/IEm9F0mJ7kQOIiUo6oIzpaDgInxFPkFcIAlQe7NpzBWr7tkO6t/hSev75IRxg
	9xWxNSSoXYkgunuEDw9axkpUCPHLiRxHcrZ3OADNTozPGg4Pwr5OtnVxPrghyXrCFM/QtYIIeh7
	q4mxfA+fC8ZAui32C2QAatpJZIQZG0P733KdJ43bmM/NRb5n7VVu9FnUE0CTRwZ4AXiHrHbveRx
	SKKRzCUnw+oBkT3BUh4fa+qPtOuiMukWn+k+XAs/p+1Y4Xn0b/Wl8B6WE3TOS7lJg/eMOSWkBly
	gaPPlEMds/rJGt9mmgIYT/AeWFBS7WM/mFi9VOS673S0yBsGRe98ga1KOL3c0Y+5EwKhFB9bt5s
	q3MXctz+MheI4NM5NJ0SohwlNjfUKH7t4HkHzPoYp8hrNDnjGT1w53OpmmLBaCKW8q+vlg12KSS
	KURub7gCrw2ranFzG3zne6EbsRrfGtFSxYg42m3iPojv8qSd+w96LVjUy/MmGW9MUt/WX/jMEYn
	XTSNlwTL30RLMriVA8WFkR0lDtk4Lsg8W6mvb1qRf11uF0dE6d/V3EGQe03xUFOTVljSRCmLUpn
	alfgUmQKp7rBpCdI=
X-Received: by 2002:a05:690c:3481:b0:8b0:c71d:2b2b with SMTP id 00721157ae682-8b2b67a315bmr89336457b3.45.1793709561190;
        Tue, 03 Nov 2026 04:39:21 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b716d420sm72011827b3.33.2026.11.03.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:39:20 -0800 (PST)
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
Subject: [PATCH net v3 1/2] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Tue,  3 Nov 2026 07:39:15 -0500
Message-Id: <QDISC-6HS9.v3.r0.20261103073017-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
References: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
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
Cc: stable@vger.kernel.org
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
