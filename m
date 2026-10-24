Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826602;
	b=ipk+omFzFrjY5349XXlhVbsH9VlFUxbC9BAGfTNnWhZcuAHsgumSfmWx7MEQL/FDITdR
	 t8VS9I81h6rQMH4Ro56uiRmo1hgQK/P+D49heebFBigyCRAn9KxEjWntVFbWg+yBHIpGh
	 lkW9lDFbqr/upS0vJ0AONxOLy0aVGETEKTZ9aSoP7rIsncIt8dA31odd8wP1iVRqCUaFm
	 A1yH++cbiIPV8bkL/c4dI5CwVPTNPWeGEGD7B7I+DcsT2PTsKG8aFgCFczThDT4Z8h2FK
	 e5yzruBgnNNJP6NhkklrZX1Izck+kMhWs6mrMZe7vix7WrQ7SsV/a+Tcl+Ybz5YFUVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1/2HEe55eMFDX8Gmv23BWgg7TrpxBiDWqlSJq+Qv36c=;
	b=EClrwpApPklc3Kann3lnvSyeBpJe6QaxY/fCldBoNBUi//zeBQaia9Ww0P2k9xRg1U90
	 GoscvS/P6qcT7MTz8FBrHYLNypmh/SIN4VC+fHRCtVNa10nTmXPTRLx4NY/R5wwxgU9Ms
	 RSUy1R9bxjuZ5XA3pfrFba6kMX2w5zeTSwEZX9tHEIQGoFSN2RFa/O3weylEZymkZUgNP
	 tmqkI4O9OTYoQrG/xUdCM+leQ08dUtoH5xMa/NgWzveuoqmX4De8mWJo6luQlba2f0mtb
	 HuJJc/JRuj11wFtGQ+WYNDi2t03xbJ8q3JCqTYYyJNVxfMksLSJMS7kAckfIlYJoi2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=lFVSsQnl;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094B606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D094B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=lFVSsQnl
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so546108a12.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 00:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792826601; x=1793431401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/2HEe55eMFDX8Gmv23BWgg7TrpxBiDWqlSJq+Qv36c=;
        b=lFVSsQnlqk7fNa/wLws5fx7t0y12bgQMbYmA3HZaO9678W4CKYvXmJQJChk7+zb9Ti
         yif3pWqvTdncufGTTlro4HO9rMylfQXRKFp2hqfm9zSivuRu6xIFWMh7AB/FOcHz9r0b
         accCQhdbmqp2ZMoezyUAMcmmCaMbm0xYYvMak6jm0dEqhUQ0N2ilypote3zAuSF7yo9a
         HyENeBfhcC3fumd8lvconRjFxcRVDQ9av6ccJajJ6p9WwXljFwdbwuk7N6HwlxuGBOOL
         OfEoyoTbUodtKndqpnCUhZn4ehc5zJNKgCkx3GxcUxPZw385R55CxGZlY3ktCA1g1xtV
         BATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792826601; x=1793431401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1/2HEe55eMFDX8Gmv23BWgg7TrpxBiDWqlSJq+Qv36c=;
        b=mScL5PesssZ5/64BgmSbtEhuKyTd3g0vIiDYh8NtbfEFekhxPF9ErSNfBajETVMTxq
         iDz0COpMi9bbettYmqBRBalItst/sGs3B+ps3EYmZhtxUJ1HW6mKgiiEoPcMPhcNfQZ7
         SeAlujUqmsw2zkpCHmoSXQk4OwtOg9thRf2BlFK1nOZueO9Vy7ymzU6N/rTDhEWAI5ZJ
         1Vdo4ztzanG+Ix9AYBSKzgkIsj/eRDh4yuPLlanofsyk6lk1mFzLBkV6JbhEEeJIRyxY
         WatTI87dcCC/PLx5SacyBJBNn8K0OgwcrdOt7xD0lkvu5nT6lvoxloHsDYUAArXPw1Fy
         1zAw==
X-Gm-Message-State: AFq9FYJfaIJjON/LRKbboN4fFx9sQm2WJaJkxK0hIYw8twDpSG8iYypG
	JkLcJ/vufQ3ch/9UdSglX6+a55jVLXktcgullHmUFTBh0IN7AdRDzCoSMQTsO+TQQw3G3RqY1/f
	1Nsj4pQ==
X-Gm-Gg: AYBFou2syqItp2hVVuJAokecuGfJg5Pkucc6hxsllZUgXcxoo1YjLDKYG6NKX+vaYo4
	ozTEtT7KYN6qsYDAIYBCTq0y6HDFKvfpt5znKC4Gx1q9+GwLl3W/uc5F/Qnyw3nizqUagVOGynf
	wlarDT9HKizD3btJLPY8IN3RLzoTPDeu5J9cJSnQZmPhIX5J90SiNggXJsv+la+utYm8LxsNtJ4
	r0exA38oPUWl66lnSriVhKz88wZuxna6tBTOYfzZbE9zagU9RiN64UXlxyzbqHVlfmE7uBSHQTK
	9mHvZhdLAMaOPKlcgG5Ug7vz4VyeGw1BZoBhihvkh5C084C3+zSjVnQShMNYhN5YtdjWQFKOnxY
	sEf6899+Kz4M/n1aJc69hFRMMQSfgA3BFWpcYTWjuB+Q2q+psb7Z2N8jFTQ0m0UVJPXjLxBAt9+
	F0vQSYYLeqhNb09lYGgUq8lfGSp6YO4kD8rlGEmGrUlIk8PyUlcje6catVp/mfPkgVrRFgzFSEi
	YrDFZ1I6csXoR9KdRj99VGPeouuywZ2e2/4H7QRpS3LHNV2vpr72jbGJS31Ajlln+QS
X-Received: by 2002:a17:90b:134b:b0:3ac:ffb8:1809 with SMTP id 98e67ed59e1d1-3adeb0f6cedmr1005290a91.39.1792826600978;
        Sat, 24 Oct 2026 00:23:20 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0639bsm1985167a91.12.2026.10.24.00.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 00:23:20 -0700 (PDT)
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
	weir@nebusec.ai,
	liuhangbin@kylinos.cn
Subject: [PATCH net v3 1/1] seg6: validate state in netfilter continuations
Date: Sat, 24 Oct 2026 15:23:04 +0800
Message-ID: <6edcb09db8ec3dda9e26ab5c5be45769907011d5.1792660496.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792660496.git.petalzu987@gmail.com>
References: <cover.1792660496.git.petalzu987@gmail.com>
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

From: Zixuan Chai <petalzu987@gmail.com>

Netfilter hooks can replace or drop skb_dst() before an SRv6 continuation
resumes. The continuation callbacks then assume that the current dst still
contains the expected lwtstate, which can lead to invalid state access.

Validate the current dst and lwtstate in each NF_HOOK() okfn wrapper.
Drop the skb when the state is missing or has the wrong type. Keep the
direct core calls unchanged when nf_hooks_lwtunnel is off.

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Changes in v3:
- Move the five dst/lwtstate checks into NF_HOOK() okfn wrappers;
	preserve direct no-hook calls.
- Fix the stale orig_dst reference in the seg6_input_core comment.
- Add clean XFRM and End.DX4 results plus independent forwarding tests.
- Remove the private tracker Closes URL.
- v2 Link:
	https://lore.kernel.org/netdev/cover.1792230570.git.petalzu987@gmail.com/

Changes in v2:
- Add unlikely() to the new checks.
- Validate the current dst/lwtstate type in both seg6local and
	seg6_iptunnel continuations; drop invalid state.
- Do not walk through XFRM dsts or take an extra lwtstate reference.
- Retain the seg6_input_core() loop-detection comment.
- Document both reproducer setups and clean/patched KASAN results.
- v1 Link:
	https://lore.kernel.org/all/cover.1790748418.git.petalzu987@gmail.com/

 net/ipv6/seg6_iptunnel.c | 62 +++++++++++++++++++++++++++++++---------
 net/ipv6/seg6_local.c    | 55 +++++++++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 7cbe0685f8bb..19df8a772fdb 100644
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
@@ -557,18 +573,15 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
 static int seg6_input_core(struct net *net, struct sock *sk,
 			   struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	/* We cannot dereference "orig_dst" once ip6_route_input() or
-	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
-	 * need the address of its lwtstate. So, save the address of lwtstate
-	 * now and use it later as a comparison.
+	/* Save the lwtstate address before replacing the dst to detect a
+	 * dst reference loop.
 	 */
-	lwtst = orig_dst->lwtstate;
+	lwtst = skb_dst(skb)->lwtstate;
 
 	slwt = seg6_lwt_lwtunnel(lwtst);
 
@@ -616,6 +629,17 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	return err;
 }
 
+static int seg6_input_core_nf(struct net *net, struct sock *sk,
+			      struct sk_buff *skb)
+{
+	if (unlikely(!seg6_lwt_state_from_skb(skb))) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return seg6_input_core(net, sk, skb);
+}
+
 static int seg6_input_nf(struct sk_buff *skb)
 {
 	struct net_device *dev = skb_dst_dev(skb);
@@ -624,10 +648,10 @@ static int seg6_input_nf(struct sk_buff *skb)
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		return NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING, net, NULL,
-			       skb, NULL, dev, seg6_input_core);
+				       skb, NULL, dev, seg6_input_core_nf);
 	case htons(ETH_P_IPV6):
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING, net, NULL,
-			       skb, NULL, dev, seg6_input_core);
+				       skb, NULL, dev, seg6_input_core_nf);
 	}
 
 	return -EINVAL;
@@ -667,12 +691,13 @@ static struct dst_entry *seg6_output_dst_lookup(struct net *net,
 static int seg6_output_core(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	lwtst = skb_dst(skb)->lwtstate;
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
@@ -720,6 +745,17 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	return err;
 }
 
+static int seg6_output_core_nf(struct net *net, struct sock *sk,
+			       struct sk_buff *skb)
+{
+	if (unlikely(!seg6_lwt_state_from_skb(skb))) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return seg6_output_core(net, sk, skb);
+}
+
 static int seg6_output_nf(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct net_device *dev = skb_dst_dev(skb);
@@ -727,10 +763,10 @@ static int seg6_output_nf(struct net *net, struct sock *sk, struct sk_buff *skb)
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		return NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING, net, sk, skb,
-			       NULL, dev, seg6_output_core);
+				       NULL, dev, seg6_output_core_nf);
 	case htons(ETH_P_IPV6):
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING, net, sk, skb,
-			       NULL, dev, seg6_output_core);
+				       NULL, dev, seg6_output_core_nf);
 	}
 
 	return -EINVAL;
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 53f7b2452575..ae0a5191652e 100644
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
@@ -1028,6 +1044,17 @@ static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 	return dst_input(skb);
 }
 
+static int input_action_end_dx6_finish_nf(struct net *net, struct sock *sk,
+					  struct sk_buff *skb)
+{
+	if (unlikely(!seg6_local_lwt_from_skb(skb))) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return input_action_end_dx6_finish(net, sk, skb);
+}
+
 /* decapsulate and forward to specified nexthop */
 static int input_action_end_dx6(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
@@ -1048,7 +1075,7 @@ static int input_action_end_dx6(struct sk_buff *skb,
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
 			       dev_net(skb->dev), NULL, skb, skb->dev,
-			       NULL, input_action_end_dx6_finish);
+			       NULL, input_action_end_dx6_finish_nf);
 
 	return input_action_end_dx6_finish(dev_net(skb->dev), NULL, skb);
 drop:
@@ -1082,6 +1109,17 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 	return dst_input(skb);
 }
 
+static int input_action_end_dx4_finish_nf(struct net *net, struct sock *sk,
+					  struct sk_buff *skb)
+{
+	if (unlikely(!seg6_local_lwt_from_skb(skb))) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return input_action_end_dx4_finish(net, sk, skb);
+}
+
 static int input_action_end_dx4(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
@@ -1098,7 +1136,7 @@ static int input_action_end_dx4(struct sk_buff *skb,
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
 			       dev_net(skb->dev), NULL, skb, skb->dev,
-			       NULL, input_action_end_dx4_finish);
+			       NULL, input_action_end_dx4_finish_nf);
 
 	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
 drop:
@@ -1741,6 +1779,17 @@ static int seg6_local_input_core(struct net *net, struct sock *sk,
 	return rc;
 }
 
+static int seg6_local_input_core_nf(struct net *net, struct sock *sk,
+				    struct sk_buff *skb)
+{
+	if (unlikely(!seg6_local_lwt_from_skb(skb))) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return seg6_local_input_core(net, sk, skb);
+}
+
 static int seg6_local_input(struct sk_buff *skb)
 {
 	if (skb->protocol != htons(ETH_P_IPV6)) {
@@ -1751,7 +1800,7 @@ static int seg6_local_input(struct sk_buff *skb)
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
 			       dev_net(skb->dev), NULL, skb, skb->dev, NULL,
-			       seg6_local_input_core);
+			       seg6_local_input_core_nf);
 
 	return seg6_local_input_core(dev_net(skb->dev), NULL, skb);
 }
-- 
2.34.1

