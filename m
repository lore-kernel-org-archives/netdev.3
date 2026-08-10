Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A43F8226
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372931; cv=none; b=PBfSY0W+BAKC0Aj0JQT7kwB2aTt1i0oKTb+HYduP7yPSnUd5KbvwbX9reBSidCl5fyFO+QOolUyC+Cx2icpAwp7FQfOLS5LoFjvokAWeu1wuiwrQeWAbIO13nnBwGy3sto2/0kOAGlnNwMeAit/BA4nc6DhY/vtFVoWHCVEbeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372931; c=relaxed/simple;
	bh=+lKlgnHd68Bk0WE3MOpB1ktRz2ooHjvciQsLZG5c0Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3vwH1muF/wQW9ufBZ+Bil4P9rRK4dHkc9yBz6ZIYKmB1PDgEUyN/75YrUPBCX8eNi9G7YPixdWqi5DDPO2UpnVD0S2r7dJvINmGkV9TIYPg8H/KoxgZNMA5khdEZzWkCcmCL171vSoHgyIUU1qkGyspjWHGhbRhrzeMQAj35Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=LiiZLriZ; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="LiiZLriZ"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664db84f074so2422072d50.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786372929; x=1786977729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJ5262BTTXyhqH37c3gMBS/5OQviz7zN7oyZ+2VH+H8=;
        b=LiiZLriZDSFuIrWguxibj2rsfMHYZPX7aYOXjXCu45owuxTG94nj5O1sRav/2oZ0ON
         eqOkNH3KvGvjnH5fLzjJo4jbEJ4ar7qxLwjGxzMDGLxggLc/h+KOWW9j7ae3fplHKfI8
         0Xo1sM/JJQsgI3/6ZjdTyEtQPgLVHMf1Phvro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372929; x=1786977729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJ5262BTTXyhqH37c3gMBS/5OQviz7zN7oyZ+2VH+H8=;
        b=k3TWc7BzJIf0K7XeM/OlpsopwABprWK1GRiKk3GxC3wfK5IBIkGvElgk8ES/s+3gyF
         b020c2LMpWrZB7TDehOGIN6cz+5UdZ62T4Gv1isgsZ+fojTub/XjyD/Vfgw7A2cF5PE4
         JtUf3tgJwjItIuJzbDV99M/E/oj8tFOidz/jQc6oO9bsvPGnsqN3kqZdCAgFn8TWg5zQ
         ckC057uLoJkM8fWkrvg6WOmKtJX7hZrB+wih/qpiFeUMCuC0Q5pGYkWwMQ/R2aaXTkwF
         vUTVkUn3jWL/oohO/HV4OssnIldiTAL0wA0Wb7oGa0C8fzAUKhj6FRvUKMuqbREXDgBt
         iaQw==
X-Forwarded-Encrypted: i=1; AHgh+RrImzAPQ/h4aVONp5OOdyjju1ncka1dEmX8Eh2u7mJImdoXNkASW3elR0/5+6vy2t96unL6UL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfI8w/m7YOXOjab7mmVwxqj44vHsQLVGmdRtNFVmtfI0TPiCe
	vgT15qKWPLpmzxXwWqrGs7K4v3qioXNFLUQPIc/ukrKu6G+XBrC1W7imor0v2BhttA==
X-Gm-Gg: AR+sD12DgV435xI4eGTkoMJ3kfRVwAtV/RkhJwhtavW4qyBDkFnBvaPQC/1BV4xo5xu
	mfdYduAf01NqGNd8MEtHTK5ymMIIkPnSj9aLOiqQvYIbZf8W0UG4FvceOPef0gefUXqO3LTyF+R
	fZKdDR/G2TkrBdL2IDBgCHrovmL9ZDd9Gyhq2hgRAOHfegWl9nKn2alsphNkivm6bOpppCq7rkQ
	zwnKA1pRy45rSgwCOJTJ5qxxbDIC68MEgMgoQbRzS4mzufJahx7wBBzzENSoWrcdi4YFVKGloYR
	j87G3l3cd46RcMQLIJnPKH6pL0hwD7IrpaTPKmBBHtVc8AoGKaLga54L04a3caCLaxqPpLBeuJM
	Byv1PPnDK8uEyh7ruMRoLqkUGfTlmV77QD0y+ZG9vc8nTtKZRpZMlpffWcaLnbQuW+8oaS/f9GR
	PCQNFbO3o9Vq5aGgX6EH9wLW4zt1WLbtoFBP7PhTGiRvE=
X-Received: by 2002:a53:d055:0:10b0:668:96a9:e6b with SMTP id 956f58d0204a3-66b1253405dmr1249442d50.45.1786372928807;
        Mon, 10 Aug 2026 07:42:08 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acd49c910sm6121209d50.12.2026.08.10.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:42:07 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	yotam.gi@gmail.com,
	edragain@163.com,
	vega@nebusec.ai,
	netdev@vger.kernel.org
Subject: [PATCH net] net/sched: act_ife: use mac_len for ingress header offset
Date: Mon, 10 Aug 2026 11:42:01 -0300
Message-ID: <20260810144201.1563259-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ingress, the L2 header stripped from the frame is skb->mac_len, not
skb->dev->hard_header_len. Use it for the skb_push/skb_pull offsets in
tcf_ife_encode()/tcf_ife_decode() and the matching header length inside
ife_encode()/ife_decode(). On egress keep hard_header_len.

For devices where hard_header_len differs from mac_len (e.g. PPP, which
reports 4 vs 0), the previous code pushed/pulled the wrong amount and
could hit skb_under_panic on ingress when headroom was tight.

Fixes: 295a6e06d21e1 ("net/sched: act_ife: Change to use ife module")
Reported-by: vega@nebusec.ai
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/ife/ife.c       | 18 +++++++++++-------
 net/sched/act_ife.c |  6 +++---
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ife/ife.c b/net/ife/ife.c
index 7a75947a31e3..3d31d68114ef 100644
--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -36,8 +36,10 @@ void *ife_encode(struct sk_buff *skb, u16 metalen)
 	/* OUTERHDR:TOTMETALEN:{TLVHDR:Metadatum:TLVHDR..}:ORIGDATA
 	 * where ORIGDATA = original ethernet header ...
 	 */
+	unsigned int hdrlen = skb_at_tc_ingress(skb) ?
+			      skb->mac_len : skb->dev->hard_header_len;
 	int hdrm = metalen + IFE_METAHDRLEN;
-	int total_push = hdrm + skb->dev->hard_header_len;
+	int total_push = hdrm + hdrlen;
 	struct ifeheadr *ifehdr;
 	struct ethhdr *iethh;	/* inner ether header */
 	int skboff = 0;
@@ -50,9 +52,9 @@ void *ife_encode(struct sk_buff *skb, u16 metalen)
 	iethh = (struct ethhdr *) skb->data;
 
 	__skb_push(skb, total_push);
-	memcpy(skb->data, iethh, skb->dev->hard_header_len);
+	memcpy(skb->data, iethh, hdrlen);
 	skb_reset_mac_header(skb);
-	skboff += skb->dev->hard_header_len;
+	skboff += hdrlen;
 
 	/* total metadata length */
 	ifehdr = (struct ifeheadr *) (skb->data + skboff);
@@ -65,16 +67,18 @@ EXPORT_SYMBOL_GPL(ife_encode);
 
 void *ife_decode(struct sk_buff *skb, u16 *metalen)
 {
+	unsigned int hdrlen = skb_at_tc_ingress(skb) ?
+			      skb->mac_len : skb->dev->hard_header_len;
 	struct ifeheadr *ifehdr;
 	int total_pull;
 	u16 ifehdrln;
 
-	if (!pskb_may_pull(skb, skb->dev->hard_header_len + IFE_METAHDRLEN))
+	if (!pskb_may_pull(skb, hdrlen + IFE_METAHDRLEN))
 		return NULL;
 
-	ifehdr = (struct ifeheadr *) (skb->data + skb->dev->hard_header_len);
+	ifehdr = (struct ifeheadr *)(skb->data + hdrlen);
 	ifehdrln = ntohs(ifehdr->metalen);
-	total_pull = skb->dev->hard_header_len + ifehdrln;
+	total_pull = hdrlen + ifehdrln;
 
 	if (unlikely(ifehdrln < 2))
 		return NULL;
@@ -82,7 +86,7 @@ void *ife_decode(struct sk_buff *skb, u16 *metalen)
 	if (unlikely(!pskb_may_pull(skb, total_pull + ETH_HLEN)))
 		return NULL;
 
-	ifehdr = (struct ifeheadr *)(skb->data + skb->dev->hard_header_len);
+	ifehdr = (struct ifeheadr *)(skb->data + hdrlen);
 	skb_set_mac_header(skb, total_pull);
 	__skb_pull(skb, total_pull);
 	*metalen = ifehdrln - IFE_METAHDRLEN;
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 065228026c58..ea7df36ab7e3 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -723,7 +723,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 	tcf_lastuse_update(&ife->tcf_tm);
 
 	if (skb_at_tc_ingress(skb))
-		skb_push(skb, skb->dev->hard_header_len);
+		skb_push(skb, skb->mac_len);
 
 	tlv_data = ife_decode(skb, &metalen);
 	if (unlikely(!tlv_data)) {
@@ -826,7 +826,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	if (skb_at_tc_ingress(skb))
-		skb_push(skb, skb->dev->hard_header_len);
+		skb_push(skb, skb->mac_len);
 
 	ife_meta = ife_encode(skb, metalen);
 	if (!ife_meta)
@@ -856,7 +856,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 	oethh->h_proto = htons(p->eth_type);
 
 	if (skb_at_tc_ingress(skb))
-		skb_pull(skb, skb->dev->hard_header_len);
+		skb_pull(skb, skb->mac_len);
 
 	return action;
 }
-- 
2.55.0

