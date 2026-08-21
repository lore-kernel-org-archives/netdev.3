Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E95423A80
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330446; cv=none; b=PxI2WRhd6tguo/vqnLgJy38cctDNhjdENX3b4Kti4UyAdOTbQTysqhqD1J4vZhZ12keQstYI84DKCcF1BG7c3u91NdFnWZTMwwg0BNEG0yHCwFbnDohrfWuW06yF8bf7dJhU7ZymJM+SEmSrt/BlF0Y/AaD+QwLbW1JYzgFlrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330446; c=relaxed/simple;
	bh=/6+/lhuz5xzPudOrZKGVsGZRmqWP/6/ybAj7yl52MiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLBX6GgxnWy7jev7dqoxD7IEohzVTpzgH1MMvivcfXKEOY49KEgDqkZ5RJW7NvpqamcNLInisNRcylMfgSQ9ueiVrl8eM2OE/njZFUeAfKsuFkPqhRVM+XtDKZ9XdHPkKQi8iS6wekkaHs4qnTQMzJ3pz7tHnTZBL4CGN/B7J2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=hqBepTEV; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="hqBepTEV"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso514617e0c.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787330443; x=1787935243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vYGE653Z0XuZDAicCYtFCqWmL3u6iBMJ3HczDQx4UqQ=;
        b=hqBepTEVCQqtaya159W1FglPKfHeaVgb2xdmn2yu+0dkUxBpdl3+3T2Qqv+od/w1yC
         +BWbUEDKzwRQqJpxDL5FErCCEi66uTYMfQ/RyE6ZLMmCfWh2M40tNfcodSl84OtB2Nns
         AGeQH/42TpRUSOyPIT2+P0jyeIwV2x3h8WXwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787330443; x=1787935243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vYGE653Z0XuZDAicCYtFCqWmL3u6iBMJ3HczDQx4UqQ=;
        b=E8B/Vbjvj2t2844ZHme8+3IZpl7k2b0+xK/YJHeEjxBOwQGSv1E/rSekg0lyWz4ai1
         xvb6HXnERFLhyN6kR4Nrz+IzWUJocbFMSFsqdirsw30bW6IDinauDPpjcYhIYLpF3uMT
         mzSkVvAYE/71SqwFp8k0o3jTwcv7r8jbH5qutmI4yDBpjzgQ8zmPEftvcTckB8Xtitrz
         IFscWUWQkcGVnHXWPhzta9Nff/on15s/tR20VY25JfFlg+6y/gfpC58ZH4S/hQiQsZjK
         EPR1jLsdB6J2HZIP9/TEVUeglTvqxhPNx4NQohbss77RLFlX4MNDkxK0SdzkfjQkxGbV
         BkvA==
X-Forwarded-Encrypted: i=1; AHgh+RpgUmZCqDtaiaAVq630ETt9H+mm2N/J0aesgrzxZw49/AV86HowmDQS7qpgUZzCpJePyA2rFF4=@vger.kernel.org
X-Gm-Message-State: AFuF++kXhzvrgsIaUkAU1DRFX3pvy39NtLCamHnuBD0lYCqeQLt37Ti9
	FwmHlhQt/P5wK43sz7pU6H2J/nRDiabPEIDg/Y04nVtdUkGJoveHHfzib5HXCkwE9w==
X-Gm-Gg: AR+sD13e7Fb2zVylxT7wuL+cBJ81lzfm94CJrJ4tcayLZYyB46cF8zXx5XAUciLPsIa
	gL8rSxMZdIrdsUoZxlGXuNH467SxaqR6ReLFyl2ys+qT2VWcp7gUBB1aNoiZOiX7TLVTRLW43qy
	++ZEov4uLc9s1aw9BU/HWSkVIxu1LGC205t1PG3d7KChhn9EINfRs6pASJ9FiCG/Hzm6wY+L2XL
	MN5B4bcD+79aTlJN6hhVqzU/4eBvgt1KUrAzpr55NQlNnn3O+v4FcrIQWXG3GK6b552+HzeVdMA
	N/QvNaA+JYYhZ0FoeA+2LhTD8EMB2QEx9byINJaU34/Zm3d50BAM3YXmfGNSrqZWNwVjh5J0V+M
	0j6A/j+h987+vt9XnFG7Eqnf6rcBe6G5xHO2HqI7DzpakWOU0bDuDB2WEiVrouQL8o43INmra2n
	/3/Bb6gP2YMPR2kS5gyoPdlDhsomWgBnlXgpE1xj2VMub8LVSEDGCz6s4MhIVZRV7uig+YbH0Dc
	7bKqwMCcDBv7JEqRtqr2tbIMts/Qy7nNDRxJw==
X-Received: by 2002:a05:6122:daa:b0:5c2:b001:db5b with SMTP id 71dfb90a1353d-5c5ff6fd04cmr3385440e0c.6.1787330442684;
        Fri, 21 Aug 2026 09:40:42 -0700 (PDT)
Received: from bhairava.tail33bf8.ts.net (177-71-66-225.ptr.quick.com.br. [177.71.66.225])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e25e34b9sm9568103e0c.3.2026.08.21.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:40:42 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	yotam.gi@gmail.com
Cc: horms@kernel.org,
	edragain@163.com,
	netdev@vger.kernel.org,
	vega@nebusec.ai
Subject: [PATCH net v2] net/sched: act_ife: Only operate on Ethernet frames
Date: Fri, 21 Aug 2026 13:40:31 -0300
Message-ID: <20260821164031.32824-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

act_ife encapsulates/decapsulates the original Ethernet header and uses
skb->dev->hard_header_len as the length of that header. That is only
correct for Ethernet devices: on a device where hard_header_len does not
match the L2 header that was actually pulled (PPP reports PPP_HDRLEN
while nothing is stripped on ingress), the ingress skb_push()/skb_pull()
use the wrong length and can hit skb_under_panic when headroom is tight.

IFE is Ethernet-only by design - it builds an outer ethhdr, rewrites
h_source/h_dest/h_proto, and calls eth_type_trans() on decode - so
instead of trying to make the offsets work for arbitrary link types,
simply drop packets that do not carry an Ethernet header.

Checking skb->dev->type alone is not enough. We have to cater for a
corner case where mirred can redirect an skb from a non-Ethernet device
to an Ethernet one, and skb->dev then says nothing about the framing the
skb actually has: an skb redirected from ppp0 reaches the target's ingress
hook with mac_len 0 and no Ethernet header at all. So at ingress also
require mac_len to be ETH_HLEN. On egress mac_len is not maintained, so
the device type is all we have; a bogus redirect there yields a malformed
frame rather than an out-of-bounds push, and it would be malformed with or
without IFE.

That corner case is not theoretical - redirecting from ppp0 into a veth
that has an ife encode action on its ingress hook panics without this
patch:

  skbuff: skb_under_panic: len:98 put:14 head:ffff88800e410000
          data:ffff88800e40fff5 tail:0x57 end:0x640 dev:veth3
  kernel BUG at net/core/skbuff.c:214!
  Call Trace:
   skb_push (net/core/skbuff.c:224 net/core/skbuff.c:2657)
   tcf_ife_act (net/sched/act_ife.c:829 net/sched/act_ife.c:874)
   tc_run (net/core/dev.c:4463)
   netif_receive_skb (net/core/dev.c:6463 net/core/dev.c:6522)
   tcf_mirred_to_dev (net/sched/act_mirred.c:248 net/sched/act_mirred.c:328)
   tcf_mirred_act (net/sched/act_mirred.c:489)
   tc_run (net/core/dev.c:4463)
   process_backlog (net/core/dev.c:6728)

With Ethernet framing guaranteed, use ETH_HLEN instead of
hard_header_len.

Fixes: 295a6e06d21e ("net/sched: act_ife: Change to use ife module")
Reported-by: vega@nebusec.ai
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2:
  - retitled; v1 was "net/sched: act_ife: use mac_len for ingress header
    offset".
  - use ETH_HLEN throughout rather than hard_header_len/mac_len
  - Reject skbs mirred-redirected here from non-Ethernet devicec - Jakub
  - Also reject skbs where skb->dev is Ethernet but the framing is not
v1: https://lore.kernel.org/netdev/20260810144201.1563259-1-victor@mojatatu.com/
---
 net/ife/ife.c       | 14 +++++++-------
 net/sched/act_ife.c | 32 ++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/net/ife/ife.c b/net/ife/ife.c
index 7a75947a31e3..2ddf725d3389 100644
--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -37,7 +37,7 @@ void *ife_encode(struct sk_buff *skb, u16 metalen)
 	 * where ORIGDATA = original ethernet header ...
 	 */
 	int hdrm = metalen + IFE_METAHDRLEN;
-	int total_push = hdrm + skb->dev->hard_header_len;
+	int total_push = hdrm + ETH_HLEN;
 	struct ifeheadr *ifehdr;
 	struct ethhdr *iethh;	/* inner ether header */
 	int skboff = 0;
@@ -50,9 +50,9 @@ void *ife_encode(struct sk_buff *skb, u16 metalen)
 	iethh = (struct ethhdr *) skb->data;
 
 	__skb_push(skb, total_push);
-	memcpy(skb->data, iethh, skb->dev->hard_header_len);
+	memcpy(skb->data, iethh, ETH_HLEN);
 	skb_reset_mac_header(skb);
-	skboff += skb->dev->hard_header_len;
+	skboff += ETH_HLEN;
 
 	/* total metadata length */
 	ifehdr = (struct ifeheadr *) (skb->data + skboff);
@@ -69,12 +69,12 @@ void *ife_decode(struct sk_buff *skb, u16 *metalen)
 	int total_pull;
 	u16 ifehdrln;
 
-	if (!pskb_may_pull(skb, skb->dev->hard_header_len + IFE_METAHDRLEN))
+	if (!pskb_may_pull(skb, ETH_HLEN + IFE_METAHDRLEN))
 		return NULL;
 
-	ifehdr = (struct ifeheadr *) (skb->data + skb->dev->hard_header_len);
+	ifehdr = (struct ifeheadr *)(skb->data + ETH_HLEN);
 	ifehdrln = ntohs(ifehdr->metalen);
-	total_pull = skb->dev->hard_header_len + ifehdrln;
+	total_pull = ETH_HLEN + ifehdrln;
 
 	if (unlikely(ifehdrln < 2))
 		return NULL;
@@ -82,7 +82,7 @@ void *ife_decode(struct sk_buff *skb, u16 *metalen)
 	if (unlikely(!pskb_may_pull(skb, total_pull + ETH_HLEN)))
 		return NULL;
 
-	ifehdr = (struct ifeheadr *)(skb->data + skb->dev->hard_header_len);
+	ifehdr = (struct ifeheadr *)(skb->data + ETH_HLEN);
 	skb_set_mac_header(skb, total_pull);
 	__skb_pull(skb, total_pull);
 	*metalen = ifehdrln - IFE_METAHDRLEN;
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index ff2b16e35b9b..9cea71fc1db3 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -28,6 +28,7 @@
 #include <uapi/linux/tc_act/tc_ife.h>
 #include <net/tc_act/tc_ife.h>
 #include <linux/etherdevice.h>
+#include <linux/if_arp.h>
 #include <net/ife.h>
 #include <net/tc_wrapper.h>
 
@@ -723,7 +724,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 	tcf_lastuse_update(&ife->tcf_tm);
 
 	if (skb_at_tc_ingress(skb))
-		skb_push(skb, skb->dev->hard_header_len);
+		skb_push(skb, ETH_HLEN);
 
 	tlv_data = ife_decode(skb, &metalen);
 	if (unlikely(!tlv_data)) {
@@ -795,7 +796,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 	   where ORIGDATA = original ethernet header ...
 	 */
 	u16 metalen = ife_get_sz(skb, p);
-	int hdrm = metalen + skb->dev->hard_header_len + IFE_METAHDRLEN;
+	int hdrm = metalen + ETH_HLEN + IFE_METAHDRLEN;
 	unsigned int skboff = 0;
 	int new_len = skb->len + hdrm;
 	bool exceed_mtu = false;
@@ -826,7 +827,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	if (skb_at_tc_ingress(skb))
-		skb_push(skb, skb->dev->hard_header_len);
+		skb_push(skb, ETH_HLEN);
 
 	ife_meta = ife_encode(skb, metalen);
 	if (!ife_meta)
@@ -856,11 +857,27 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 	oethh->h_proto = htons(p->eth_type);
 
 	if (skb_at_tc_ingress(skb))
-		skb_pull(skb, skb->dev->hard_header_len);
+		skb_pull(skb, ETH_HLEN);
 
 	return action;
 }
 
+/* IFE encapsulates the original Ethernet header and, on decode, expects to
+ * find one, so it can only ever work on skbs that carry one. Loopback carries
+ * Ethernet header as well, so it qualifies here.
+ * At ingress, also verify that the L2 header about to be pushed back really
+ * is an Ethernet header because the skb could've been redirected with mirred
+ * from a non-Ethernet device.
+ */
+static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
+{
+	if (skb->dev->type != ARPHRD_ETHER &&
+	    skb->dev->type != ARPHRD_LOOPBACK)
+		return false;
+
+	return !skb_at_tc_ingress(skb) || skb->mac_len == ETH_HLEN;
+}
+
 TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,
 				  const struct tc_action *a,
 				  struct tcf_result *res)
@@ -869,6 +886,13 @@ TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,
 	struct tcf_ife_params *p;
 	int ret;
 
+	if (unlikely(!tcf_ife_is_eth_skb(skb))) {
+		bstats_update(this_cpu_ptr(ife->common.cpu_bstats), skb);
+		tcf_lastuse_update(&ife->tcf_tm);
+		qstats_cpu_drop_inc(ife->common.cpu_qstats);
+		return TC_ACT_SHOT;
+	}
+
 	p = rcu_dereference_bh(ife->params);
 	if (p->flags & IFE_ENCODE) {
 		ret = tcf_ife_encode(skb, a, res, p);
-- 
2.43.0

