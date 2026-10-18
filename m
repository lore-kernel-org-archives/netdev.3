Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602951684B0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304864; cv=none; b=JPH8cCMRxvb6amEU5utKcukrt+cNchBufyFOZCDIMVytHCgw9MDaHC+0bY/yvMGbiY96hThMSuZnbdaB7On1Gri9Bu4N6fS1yvryUCwRdvLpIZ+Iy0RAqcCpteN9YgW3i6XjVQWRoSu2DB9ogjOICxqWgjaAP2Xq2F+7sIWxvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304864; c=relaxed/simple;
	bh=lCFFB4pV5H/XHQACIHJ/BoCCUm6Feur4EhpOrtLpHkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkNncB9vs27x6PT0Cbow9UfJj13dxJ/4nYe/azfOp1aPpRuBpd0C2zID+anZJUoWWzoJdyM31tDufQmtyg2UY7ynldrAEnuoivMUbKybm4n8oUVvVtnRVB7DaVSPUNH7eQrky5BRaBT3qDo5OAC5rDrnGievQXkYdBqxpmBe1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=EqfYBvFC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="EqfYBvFC"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-872024e2b4eso393439b3a.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 23:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792304863; x=1792909663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUnMpzHoOmlLOylGPg+nyrfPmTh49epnZT9M2r8jGB0=;
        b=EqfYBvFCrOZDA9UEXbMN18ZJe//thmA1fR7sT2bLdLuzU9eXEBsShGIh+PRVKKp0em
         sczxngVJYUwjC88mYda9rqn0Hsj+tMdDa+mYkw4EAsydITkYu73MqQLYil4q0zlxpph6
         9nQxHs7UU99EUJmSa2f2snCJZuaxeckrky2N9/+IMiiLZjpPPUgnjzxXmAErkjaM+h+O
         vFMk/Tu5Anal+bEUXGUruivYaPodQjQaWIKPMfkAA0nFYf/n1js2WYl1bTKluZ7iX52Z
         tE4f9JKMJ0xgKXVvP/Zy33T+eUj9dhAAQhQBW+Q10AKA+llZmQ7k2MJQ/5uKQWXoxKFe
         z+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304863; x=1792909663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fUnMpzHoOmlLOylGPg+nyrfPmTh49epnZT9M2r8jGB0=;
        b=vH4u4mxilQF2+6r3baBo3Y73O1tvImGE8wS43Rp/QepFNbyjPxxDU7b4UGKvMqsvcL
         ODynphpZ1V1B6nMe0rBqfl2oF/Oz/NyHhq5r7XiQUgBDfA9GJX1rELOc+iGx0XXpPgHd
         kveMXTKvbe8qS+VGLvda+6FrxlDZuoanlr+gbpmrdWO3C+RX8dxV9mpbB2FEVaM7TFDv
         3Y9D8qxczEASj0Ya9e/mTZyz7XfkXG2dA9JGS8dIO5vb4Z/etwjPZj0EZ5mEr7EP0j9J
         6am8Avftn1Fz2tj9nsroSdVwqtmTaxFlVwnnq6mjx088Y54bLYVGd38VBXPNJMu1tpMS
         SNLw==
X-Gm-Message-State: AFq9FYIHnEt9Gu15x7GhVTRtVKeY080+WvBZFJiXRfUtGpq1BIFHGDM7
	KYHtj5T5A4bJSVzRrxOA8imT5sEp2gOGFktmD8mg719IhINcfml/zCn52WcTghs3hXSAn5J5XJp
	XLlAfgg==
X-Gm-Gg: AYBFou1RhX5ZNv9k6iAZF9LuE/a7CIvvHapBNo6B40I1ZsBs6xezHBNoBZjKM1rUzUt
	x7gd1ZBA7oS5jv60Z88QSjR2Vp2uxED+5D4wZl8ES4P00LC9Oy5VU95PrnWC4tjhUX+8CI8Ss4M
	e7EgjbWyCWcwY2LitGTRnC3+ar3FEsS4YKHdFlpFuLbv7SAwrcvCKbzYh9ktmbOzbQMpj++NLXu
	ekBkORAbZmnNsI/2tjBa//H3XKglBufFETjhilzUAOJXlzTa1G5Z+gaz4o0zYBvs4X5oxoCCRLv
	2OgEv99PK1VCFLjUOnFBeGQo1VgUM5rqzvmwNbtgxQzaf+eZ7FI99VRrilVxnyItuN5NCJ0+38T
	GaItHazBSWRPaQoa14+ujmTs0uU1Ko/hJ/KJVPblS9+R3ICzTmHuFqNU3MipLn/3A6q2HAHZFZE
	GEof1V8n/oDCZKvGr7sOxTAOIhsCjbunfKTI7urqUjYdGllIv+zLXckVbilOuQIkXWONn6y6kC7
	MI7SG8j5HU=
X-Received: by 2002:a05:6a00:4504:b0:886:ead5:6d3b with SMTP id d2e1a72fcca58-8a04c437ae2mr2929629b3a.53.1792304862558;
        Sat, 17 Oct 2026 23:27:42 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58017244sm2707319b3a.47.2026.10.17.23.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:27:41 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	andrea.mayer@uniroma2.it
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	contact@proelbtn.com,
	pablo@netfilter.org,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v2 1/1] seg6: validate state in netfilter continuations
Date: Sun, 18 Oct 2026 14:27:29 +0800
Message-ID: <ec7399b424e82f050a1ff5dc79537aee1d93723a.1792230570.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792230570.git.petalzu987@gmail.com>
References: <cover.1792230570.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

Netfilter hooks can drop or replace skb_dst() while an SRv6 packet is
queued for continuation. The End.DX4 and End.DX6 finish callbacks and
the seg6local input continuation currently dereference the destination's
lwtstate without validating it. The seg6_iptunnel input and output
continuations make the same assumption after POST_ROUTING hooks.

Validate skb_valid_dst(), a non-NULL lwtstate, and the expected
LWTUNNEL_ENCAP_SEG6_LOCAL or LWTUNNEL_ENCAP_SEG6 type before using the
state. Drop the skb when validation fails. This check is by type, not by
identity of the original state. It does not walk through an XFRM dst or
take an additional lwtstate reference. Retain the loop-detection
explanation for saving the lwtstate address in seg6_input_core().

The End.DX4 reproducer creates a SEG6_LOCAL End.DX4 SID, enables
nf_hooks_lwtunnel, installs an IPv4 PREROUTING DNAT rule, and injects an
outer IPv6/inner IPv4 frame through AF_PACKET from a non-root user in a
fresh user/network namespace. DNAT drops skb_dst() before
input_action_end_dx4_finish() resumes.

A separate root-only reproducer exercises seg6_output_core(): an SRv6
encap route, POST_ROUTING SNAT, and an ESP transport policy replace the
route destination before the continuation resumes.

On a clean KASAN kernel, the End.DX4 reproducer triggered a NULL pointer
dereference in input_action_end_dx4_finish from packet_sendmsg(). On the
patched kernel, the End.DX4 reproducer completed with exit status 0. The
SNAT+ESP/XFRM reproducer ran twice; one run returned exit status 0. No
target KASAN report, Oops, or kernel panic was found on the patched
guest. Tests used QEMU TCG because KVM was unavailable to the test user.

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Closes: https://bugtracker.nebusec.ai/f/11977
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>

---
Changes in v2:
- Add unlikely() to the new checks.
- Validate the current dst/lwtstate type in both seg6local and
  seg6_iptunnel continuations; drop invalid state.
- Do not walk through XFRM dsts or take an extra lwtstate reference.
- Retain the seg6_input_core() loop-detection comment.
- Document both reproducer setups and clean/patched KASAN results.
- v1 Link: https://lore.kernel.org/all/cover.1790748418.git.petalzu987@gmail.com/

 net/ipv6/seg6_iptunnel.c | 35 ++++++++++++++++++++++++++++++-----
 net/ipv6/seg6_local.c    | 38 ++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 7cbe0685f8bb..75ceeb127337 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -18,6 +18,7 @@
 #include <net/ip6_fib.h>
 #include <net/route.h>
 #include <net/seg6.h>
+#include <net/dst_metadata.h>
 #include <linux/seg6.h>
 #include <linux/seg6_iptunnel.h>
 #include <net/addrconf.h>
@@ -60,6 +61,21 @@ static inline struct seg6_lwt *seg6_lwt_lwtunnel(struct lwtunnel_state *lwt)
 	return (struct seg6_lwt *)lwt->data;
 }
 
+static struct lwtunnel_state *seg6_lwt_state_from_skb(struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+
+	if (unlikely(!skb_valid_dst(skb)))
+		return NULL;
+
+	dst = skb_dst(skb);
+	if (unlikely(!dst->lwtstate ||
+		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6))
+		return NULL;
+
+	return dst->lwtstate;
+}
+
 static inline struct seg6_iptunnel_encap *
 seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
 {
@@ -557,7 +573,6 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
 static int seg6_input_core(struct net *net, struct sock *sk,
 			   struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
@@ -568,7 +583,11 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	 * need the address of its lwtstate. So, save the address of lwtstate
 	 * now and use it later as a comparison.
 	 */
-	lwtst = orig_dst->lwtstate;
+	lwtst = seg6_lwt_state_from_skb(skb);
+	if (unlikely(!lwtst)) {
+		err = -EINVAL;
+		goto drop;
+	}
 
 	slwt = seg6_lwt_lwtunnel(lwtst);
 
@@ -667,12 +686,18 @@ static struct dst_entry *seg6_output_dst_lookup(struct net *net,
 static int seg6_output_core(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	lwtst = seg6_lwt_state_from_skb(skb);
+	if (unlikely(!lwtst)) {
+		err = -EINVAL;
+		goto drop;
+	}
+
+	slwt = seg6_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache_output);
@@ -695,7 +720,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		}
 
 		/* cache only if we don't create a dst reference loop */
-		if (orig_dst->lwtstate != dst->lwtstate) {
+		if (lwtst != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
 			local_bh_enable();
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 53f7b2452575..79c27e467c2b 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -24,6 +24,7 @@
 #include <net/addrconf.h>
 #include <net/ip6_route.h>
 #include <net/dst_cache.h>
+#include <net/dst_metadata.h>
 #include <net/ip_tunnels.h>
 #ifdef CONFIG_IPV6_SEG6_HMAC
 #include <net/seg6_hmac.h>
@@ -213,6 +214,21 @@ static struct seg6_local_lwt *seg6_local_lwtunnel(struct lwtunnel_state *lwt)
 	return (struct seg6_local_lwt *)lwt->data;
 }
 
+static struct seg6_local_lwt *seg6_local_lwt_from_skb(struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+
+	if (unlikely(!skb_valid_dst(skb)))
+		return NULL;
+
+	dst = skb_dst(skb);
+	if (unlikely(!dst->lwtstate ||
+		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6_LOCAL))
+		return NULL;
+
+	return seg6_local_lwtunnel(dst->lwtstate);
+}
+
 static struct ipv6_sr_hdr *get_and_validate_srh(struct sk_buff *skb)
 {
 	struct ipv6_sr_hdr *srh;
@@ -1008,11 +1024,14 @@ static int input_action_end_dx2(struct sk_buff *skb,
 static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct in6_addr *nhaddr = NULL;
 	struct seg6_local_lwt *slwt;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwt_from_skb(skb);
+	if (unlikely(!slwt)) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	/* The inner packet is not associated to any local interface,
 	 * so we do not call netif_rx().
@@ -1059,13 +1078,16 @@ static int input_action_end_dx6(struct sk_buff *skb,
 static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	enum skb_drop_reason reason;
 	struct seg6_local_lwt *slwt;
 	struct iphdr *iph;
 	__be32 nhaddr;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwt_from_skb(skb);
+	if (unlikely(!slwt)) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	iph = ip_hdr(skb);
 
@@ -1722,13 +1744,17 @@ static void seg6_local_update_counters(struct seg6_local_lwt *slwt,
 static int seg6_local_input_core(struct net *net, struct sock *sk,
 				 struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct seg6_action_desc *desc;
 	struct seg6_local_lwt *slwt;
 	unsigned int len = skb->len;
 	int rc;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwt_from_skb(skb);
+	if (unlikely(!slwt)) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	desc = slwt->desc;
 
 	rc = desc->input(skb, slwt);
-- 
2.34.1

