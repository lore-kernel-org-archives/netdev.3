Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA63B2D1A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791749; cv=none; b=H7TF6zLmX489oJef4dCTOk/MSKj46M9LfV6EDEnqPM9gz6Zsnv7rVpr2W+kT7b3YmKcs8lE+EhkPw//g0ivwXY8AwJ2nR0Mc6FyknE/WsyPIjIjBV7FFoWrUi5QHr8+WQJRRA9g7zdrPPLfTSn/7ZM8NwhzMvnsJ4bhwJPpbZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791749; c=relaxed/simple;
	bh=Wfh1e2X1iy61QAxxc4mgPFRv7H7QQN2h+DcRAOZ0QVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiPSX9lGl/B8s4w6LJ0UYsVRBUTondGH44P7Bi8c4FBxLrmbLuGXM0EvUbl/mVqgHlMTw1kcha4Hzn9yssgcITf1JzrKkgg98h+r3C+KmFy/Ote7xNsSg7GCL4Ow3cuT3I32icO8NvbxteudTCMSX2ouLcGTuyfQ2NgD9XKQHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=qEtcCUsN; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="qEtcCUsN"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5f63c54eso370574585a.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790791746; x=1791396546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sy3y5OoFodPaz04jCA0MNETpKBOZdMmsKTP6LIIgrPU=;
        b=qEtcCUsN/aHbABC/59nTiWPzGSo8g5sNFZeEm8/x/bepj8qenYFApdhERqG1oo8DZf
         UkIzkxvBuAoiSRnCbL6Za6ZHWiGLTZJ9ndxKxhWttYALPWdE7It3Abj9HmaBQWyhKIFP
         D8a1vWfvs8Iq3eA55sn/Fm7wuSIqwLHa16QFZxC/XOM9K1j1qaKLHZXenRFXPrTI+GVS
         y3J5reMAhVHlgRLvrRjAitJ0wAnUhr+qDH8HP2j0exIzbCz5iGhQ+IZYOFxqwrf7f64A
         NecTsjphhcBatZxMFSsxSzGsSPo3XXTp+VaR5XyuEcWscH9kfQX+bQm6637ARA7Q6PUs
         KGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790791746; x=1791396546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sy3y5OoFodPaz04jCA0MNETpKBOZdMmsKTP6LIIgrPU=;
        b=yhFWForDMkaUDtQr6/2MjFOT4z+hv6HMnv7oDSanMSrfWhl9di5VhyWo5MwGOeizTJ
         WFESw/HzgQh5XGGIdMLicLNOrWiDcjBRPrYvkiDahDBFmAkrfVrqkYWUnd3S9CDwpKDa
         Km8t/Y979WUCdx8xVnFSXDESEbLN98Kw5E7y9Dn+LtsYb4zQ3672twbwEr9DAP9L3UTJ
         lbDpbg3BulM2BRg93a6/ioQd27g2YBseRAfakcG0c2t5Y6oV+Xnju26kMhrMD6HWE2Sx
         4BG5/x2CsnrHoduGKxB6Wy91aV+KDLxRHj2slFCklo6r6R7kABUBcSdRxdxnHyPuAhaa
         dGuw==
X-Gm-Message-State: AFuF++lAM5JRx9s4SWCoV9pQQW44Gmy1GpjXWuwhWnwxLBeO2/ocFQcG
	QMKs4LLEVZqbEfTOy0Uk6UMwXlJVNqAbEJBMg2aOMWogyAtRBCixDRMWLBENYgypBuL/fBVFipa
	Fdk0CX8qZ
X-Gm-Gg: AYBFou2Pwy21j+WC7pLWML8tc2JGKn4/xXGiSc35IKCAclLNi+LKehFXgJ+DdlDcLxk
	xpnmPc5kfLr01pRs9fxTIJaECdCHs+/Nu2p9YoU1geALeWZlhBuqqjeT6l2DllynP/wQElCsHeD
	gIIa5c5P5B2aAh2qajkrOiAf6QuVZspjzx3pwxUYx878H/KhXiq3e3QyjXXC7JJYhlpHdq49/mS
	tPSPuAl/+HN0f/5NAFlnh8KYJ33lGnF2DoflMiaWkpx/8U8Mxj2N4SH7YEXAH2hV2ahvWnkPmQG
	TnG7ROf4uIOvcvGINwPBqMra0Vzat/fG3RoP5Dl/jAbYsfi9fW3rdbOHXFtE2hHvqSqYS4ZYCq6
	aNyiR6O0rbF7apgWEDWMIzZAVBwWpEbXlMIpXamT4WePMVVNbK8rgBsWOKpJbamo6l0Bo/0vyjG
	vC4o7XHFhtUNh/5Yw/CuicRYsMjQtq+7LzAKKQCZPwfq4V4BlSL13RXIk06bSnzIsDzVsWHNmzv
	4axqJFi
X-Received: by 2002:a05:620a:2712:b0:939:c71d:8d15 with SMTP id af79cd13be357-93ca9779e87mr408777485a.14.1790791746369;
        Wed, 30 Sep 2026 11:09:06 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cb64e2fb6sm21862185a.20.2026.09.30.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:09:05 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pablo@netfilter.org,
	contact@proelbtn.com,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] seg6: validate state in netfilter continuations
Date: Thu,  1 Oct 2026 02:08:53 +0800
Message-ID: <8e22f1e0a04d4a48bd990872490e21bfc61f9223.1790748418.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790748418.git.petalzu987@gmail.com>
References: <cover.1790748418.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

Netfilter hooks can drop or replace the dst while an SRv6 packet is
queued for continuation. The seg6local callbacks must not assume that
skb_dst() still carries the state for the route being processed.

Validate the destination and SEG6_LOCAL state before using it in the
End.DX4/End.DX6 continuations and seg6_local_input_core(). The
seg6_iptunnel continuations must also resolve the SEG6 state beneath
an XFRM dst and hold a reference while processing the SRH.

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260720204430.1886091-1-xmei5@asu.edu/
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv6/seg6_iptunnel.c | 62 +++++++++++++++++++++++++++++-----------
 net/ipv6/seg6_local.c    | 34 ++++++++++++++++++----
 2 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 61c6a27bf202..e3d36fb0f290 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -18,6 +18,8 @@
 #include <net/ip6_fib.h>
 #include <net/route.h>
 #include <net/seg6.h>
+#include <net/dst_metadata.h>
+#include <net/xfrm.h>
 #include <linux/seg6.h>
 #include <linux/seg6_iptunnel.h>
 #include <net/addrconf.h>
@@ -60,6 +62,26 @@ static inline struct seg6_lwt *seg6_lwt_lwtunnel(struct lwtunnel_state *lwt)
 	return (struct seg6_lwt *)lwt->data;
 }
 
+static struct lwtunnel_state *seg6_lwt_state(struct dst_entry *dst)
+{
+	dst = xfrm_dst_path(dst);
+	return dst->lwtstate;
+}
+
+static struct lwtunnel_state *seg6_lwt_state_get(struct sk_buff *skb)
+{
+	struct lwtunnel_state *lwtst;
+
+	if (!skb_valid_dst(skb))
+		return NULL;
+
+	lwtst = seg6_lwt_state(skb_dst(skb));
+	if (!lwtst || lwtst->type != LWTUNNEL_ENCAP_SEG6)
+		return NULL;
+
+	return lwtstate_get(lwtst);
+}
+
 static inline struct seg6_iptunnel_encap *
 seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
 {
@@ -395,14 +417,12 @@ static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 	return 0;
 }
 
-static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
+static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst,
+		       struct seg6_lwt *slwt)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	struct seg6_iptunnel_encap *tinfo;
-	struct seg6_lwt *slwt;
 	int proto, err = 0;
 
-	slwt = seg6_lwt_lwtunnel(dst->lwtstate);
 	tinfo = slwt->tuninfo;
 
 	switch (tinfo->mode) {
@@ -557,18 +577,16 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
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
-	 */
-	lwtst = orig_dst->lwtstate;
+	lwtst = seg6_lwt_state_get(skb);
+	if (!lwtst) {
+		err = -EINVAL;
+		goto drop;
+	}
 
 	slwt = seg6_lwt_lwtunnel(lwtst);
 
@@ -576,7 +594,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	dst = dst_cache_get(&slwt->cache_input);
 	local_bh_enable();
 
-	err = seg6_do_srh(skb, dst);
+	err = seg6_do_srh(skb, dst, slwt);
 	if (unlikely(err)) {
 		dst_release(dst);
 		goto drop;
@@ -590,7 +608,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 		}
 
 		/* cache only if we don't create a dst reference loop */
-		if (!dst->error && lwtst != dst->lwtstate) {
+		if (!dst->error && lwtst != seg6_lwt_state(dst)) {
 			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache_input, dst,
 					  &ipv6_hdr(skb)->saddr);
@@ -605,6 +623,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 		skb_dst_set(skb, dst);
 	}
 
+	lwtstate_put(lwtst);
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
 			       dev_net(skb->dev), NULL, skb, NULL,
@@ -613,6 +632,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
 drop:
 	kfree_skb(skb);
+	lwtstate_put(lwtst);
 	return err;
 }
 
@@ -667,18 +687,24 @@ static struct dst_entry *seg6_output_dst_lookup(struct net *net,
 static int seg6_output_core(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	lwtst = seg6_lwt_state_get(skb);
+	if (!lwtst) {
+		err = -EINVAL;
+		goto drop;
+	}
+
+	slwt = seg6_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache_output);
 	local_bh_enable();
 
-	err = seg6_do_srh(skb, dst);
+	err = seg6_do_srh(skb, dst, slwt);
 	if (unlikely(err))
 		goto drop;
 
@@ -695,7 +721,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		}
 
 		/* cache only if we don't create a dst reference loop */
-		if (orig_dst->lwtstate != dst->lwtstate) {
+		if (lwtst != seg6_lwt_state(dst)) {
 			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
 			local_bh_enable();
@@ -708,6 +734,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
+	lwtstate_put(lwtst);
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
@@ -716,6 +743,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	return dst_output(net, sk, skb);
 drop:
 	dst_release(dst);
+	lwtstate_put(lwtst);
 	kfree_skb(skb);
 	return err;
 }
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index d1070aec7b72..ac01e3032973 100644
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
@@ -213,6 +214,17 @@ static struct seg6_local_lwt *seg6_local_lwtunnel(struct lwtunnel_state *lwt)
 	return (struct seg6_local_lwt *)lwt->data;
 }
 
+static struct seg6_local_lwt *seg6_local_lwt_from_skb(struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+
+	if (!skb_valid_dst(skb) || !dst->lwtstate ||
+	    dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6_LOCAL)
+		return NULL;
+
+	return seg6_local_lwtunnel(dst->lwtstate);
+}
+
 static struct ipv6_sr_hdr *get_and_validate_srh(struct sk_buff *skb)
 {
 	struct ipv6_sr_hdr *srh;
@@ -924,11 +936,14 @@ static int input_action_end_dx2(struct sk_buff *skb,
 static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct in6_addr *nhaddr = NULL;
 	struct seg6_local_lwt *slwt;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwt_from_skb(skb);
+	if (!slwt) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	/* The inner packet is not associated to any local interface,
 	 * so we do not call netif_rx().
@@ -975,13 +990,16 @@ static int input_action_end_dx6(struct sk_buff *skb,
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
+	if (!slwt) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	iph = ip_hdr(skb);
 
@@ -1628,13 +1646,17 @@ static void seg6_local_update_counters(struct seg6_local_lwt *slwt,
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
+	if (!slwt) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	desc = slwt->desc;
 
 	rc = desc->input(skb, slwt);
-- 
2.34.1
