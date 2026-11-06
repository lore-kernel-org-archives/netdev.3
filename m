Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935832;
	b=nMs4cGxU2sVq5t6zJBscJEAv1s5khAicfGy4ABAW/KjeMjsTRS3Aw46oq8I2kBc9PRyU
	 VRNCIOL5HsXWlsqmv4OpDqvNK69N3ZlXyoy9Gy3xBjucFEbmq3xYeQU9M5rj4cfU+O7mS
	 ATuEfaCRrux4c+77tYTxl0pTt51Gw5Au2wgsYqHZM0jDv6X5AF0qmF6iRJZuCqFvVH8vh
	 m2/hCsHFjQGP6Q3fQGrXia1zv/6pyD7y8p5AjOEH0AFkjE0Z9NGeDDpbTMcjqCs2j5jFh
	 fqjxpWcDn/Y2duSTqQGCA0dqbCEl47Kr1caOHgIleFDStcz0ALbUCVp9eH7ETtUeG8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dmbwsLRLKAFUyVOTZe1uI4UnnEXzurY1RexHLL/dBJQ=;
	b=oO3uDA7gjF9jA/Z9BFKQr4bHPjdvtp8DSEBe9Mdbdw9G//Cc41MRnIy4WpykSLHIvnyt
	 3JbMzjFL6riyNq5n+Qe1E7utNAhFthZlRzMnlOH78QnaCZwRBn+Trfutk5s+SQ37//UA0
	 ArFARtu4hL0gEFu6L4fqEpxa8jBo45HPKaovJRryKpV/HQZAx6CYjA0/CCeCE/wAjNfwm
	 6ktdfqERZqcdkhJOWgilQM3x38Y/7h7YtBgMFjjwBC+6cb32CZk/gdi774uYR+U8hRtNK
	 30+Or4wHiQRl/Dw1PdiKPsNcp8YfEokXkQZ5/vKmAbrbU8QgY7Z3MEp3wfS0G0n9Fww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=sr7w+g8E;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5E606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 03:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE5E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=sr7w+g8E
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae58d17cd9so37758c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 19:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793935831; x=1794540631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dmbwsLRLKAFUyVOTZe1uI4UnnEXzurY1RexHLL/dBJQ=;
        b=sr7w+g8ECW481PE4DEu93svQFUB2IMyZvKmhc2kpVOOc7FsE4dyuE5cvE1zzJs+M5w
         3rncfyV2wrIaszYrhXiEpXsEkXweH/+O6v4/XUyJyzXpU99+t89HiaxTyR3VO0RJJpN7
         iGtbjIofh7mBKtyUzkhUJNqGP/oqZ4PCt6k4GpwSLJpjenbjKrQMOKJlbsROWcjZ1Y5l
         opSFvt9zzx2QX72/qKPD8VOU8oJy2oGHAl1hecF/kqCkw6uV+1dN923/IsYPG6sDIyYj
         UrulvsBM3z3vHQZB+vKABP7D1Gd/4aEV+LRyb1ldelL8idnTtaYECxPPRxODFrXa6wPP
         P/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793935831; x=1794540631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmbwsLRLKAFUyVOTZe1uI4UnnEXzurY1RexHLL/dBJQ=;
        b=yhzs6KcxLkSLi5oUogF3GEHd0u8rFOI2ZSblYJOQZl5fiJWVuQs8DIWjtnfgjI024p
         +cS1+NggjBdXxFJF/iUxsOhem5FPP3EiGg91OLyIL4FSKe+pq7fXzEcoqt++YzzopjDm
         +yp6tP+uvP4CalZxL2/u3GByvS8NUSyykq7OBGvXyx3g23tXLL+0dz5VJwDygKe83N1f
         tAH+k0QIbfgdm1usN/EhhSd1aPPyR8a43trtEDRcUYdU6rTd8Ryz0zu03g8gHPd2JK1I
         6loUamU5wGnQbOqvMs1uuZylCgiT4ztFbZ8bhVY64uhR3QsQUFk02Ykmdm/lb+1Rf+lU
         irsw==
X-Gm-Message-State: APuU4Z8+5Q92tYpanYy1rm48TX1sISZCo8b/lKileaGSu1ViH0Ehi9Qf
	/wT/joUYHhAW4s2KaX18xDOGTELBtW9pBS6JBiOmGAYIg3myg5UlWkAI/7AB3JdtCOUUZvAbJQg
	rf35erjRpnOw=
X-Gm-Gg: AYBFou0gszMCkJZFMzPhlfqdBPcXBTaqeYtcivks/2J2oWkeld+p1c40csNjvfxA5L9
	XWytleCWjQuSsIEix7WssmmQvx5xN/IQ9MWj1ZY/JPmSwVM7plAqVU/2QuiGVGzhFbM56113bZ2
	IryofEpybQD8pGJb44T5HiG1PF3vouDkknVS2S1cUEehkcVhEbgQDCyQWTzyZ5XSZkfV1jr8Yoa
	q7WX7aywTmFiVjfcNIUNNy7wWHS69U13N7PudJkxYw9Tlf6u4dTJODwgG9ou05k9riYrBHGMckD
	DlZ9TSjL+jnaimNearB8lGo2/FbRVuU76dE6wO6ccaRl2VTzu9pkWD/8pOmXDujwmpN2lDio25E
	EQtrRx2OYrBM9vC8icYDOFjRu+V1QF8HVJrHCHwLAdFfhID7D8IrfcHAjTKuGrLlSPHnWbbNk4d
	sudBNaVeqH1a2b13NgBe+lnmCXBpfrUlExOiQk5ksNwmo6xldJ85Qvq+vOy9eIvS4SgJX7B5UUq
	kydR/geF3dVhW2cosU631LX8510F3Mr3U1yOaRmwGJVcY1EzDmA3ep9wN2GbGsqYO3yzH9XxRK3
	2CCoNyvvyAWWktNywyFmALQDOU5ykkraUUrh
X-Received: by 2002:a05:701b:21ce:b0:144:fb87:5b91 with SMTP id a92af1059eb24-1b25d3aae5emr1151850c88.44.1793935830263;
        Thu, 05 Nov 2026 19:30:30 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([74.52.12.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4fad14sm1286250c88.22.2026.11.05.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:30:28 -0800 (PST)
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
Subject: [PATCH net v5] seg6: validate state in netfilter continuations
Date: Fri,  6 Nov 2026 11:30:19 +0800
Message-ID: <8574739acd6f5d9eb0a5640e893122619e9f79ef.1793726355.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When nf_hooks_lwtunnel is enabled, End.DX4 sends decapsulated packets
through NF_INET_PRE_ROUTING. If DNAT changes the inner destination,
nf_nat_ipv4_pre_routing() drops skb_dst(), and the continuation then
dereferences the missing dst's lwtstate. This causes a KASAN NULL
pointer dereference and fatal exception panic.

End.DX6 has the same issue with IPv6 DNAT. In seg6_iptunnel,
POST_ROUTING SNAT with an outbound XFRM policy can replace the dst before
the continuation resumes.

Validate the current dst and expected lwtstate type in each NF_HOOK()
continuation before calling the existing handler. Drop packets with
missing or incompatible state while preserving direct no-hook paths.
The helpers return bool because callers only need a validity check.

Testing shows that the End.DX4 DNAT reproducer triggers a KASAN NULL
pointer dereference without this change and no longer does so with the
fix. The SNAT+ESP/XFRM reproducer also completes without the reported
fault. The in-tree End.DX4 netfilter forwarding selftest passes all four
bidirectional checks with nf_hooks_lwtunnel disabled and enabled.

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Changes in v5:
- Explain the End.DX4 DNAT trigger and KASAN fatal-exception impact in the
	commit message.
- Return bool from both skb lwtstate helpers because callers only test
	validity.
- Add current clean/patched runtime results and an independent forwarding
	selftest result to the validation record.
- Retain the v4 wrapper-only checks and direct no-hook behavior.
- v4 Link:
  https://lore.kernel.org/netdev/c9ec4da483c6c17dda703bcd6fc425ef2b53e320.1793207060.git.petalzu987@gmail.com/

Changes in v4:
- Keep seg6_input_core() and seg6_output_core() unchanged; validate state
  only in their NF_HOOK() continuation wrappers, addressing the review
  comment on the unnecessary core refactoring.
- Remove the Assisted-by: LLM trailer as requested.
- Preserve the original NF_HOOK() continuation indentation.
- Omit the cover letter.
- v3 Link:
  https://lore.kernel.org/netdev/cover.1792660496.git.petalzu987@gmail.com/

Changes in v3:
- Move the five dst/lwtstate checks into NF_HOOK() okfn
	wrappers; preserve direct no-hook calls.
- Fix the stale orig_dst reference in the seg6_input_core()
	comment.
- Add clean XFRM and End.DX4 results plus independent
	forwarding tests.
- Remove the private tracker Closes URL.
- v2 Link:
  https://lore.kernel.org/netdev/cover.1792230570.git.petalzu987@gmail.com/

Changes in v2:
- Add unlikely() to the new checks.
- Validate the current dst/lwtstate type in both seg6local and
	seg6_iptunnel continuations; drop invalid state.
- Do not walk through XFRM dsts or take an extra lwtstate
	reference.
- Retain the seg6_input_core() loop-detection comment.
- Document both reproducer setups and clean/patched KASAN
	results.
- v1 Link:
  https://lore.kernel.org/all/cover.1790748418.git.petalzu987@gmail.com/
 net/ipv6/seg6_iptunnel.c | 46 ++++++++++++++++++++++++++++++---
 net/ipv6/seg6_local.c    | 55 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 0d39a38a5dd2..3bc47c5614ff 100644
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
 
+static bool seg6_skb_has_lwtstate(struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+
+	if (unlikely(!skb_valid_dst(skb)))
+		return false;
+
+	dst = skb_dst(skb);
+	if (unlikely(!dst->lwtstate ||
+		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6))
+		return false;
+
+	return true;
+}
+
 static inline struct seg6_iptunnel_encap *
 seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
 {
@@ -622,6 +638,17 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	return err;
 }
 
+static int seg6_input_core_nf(struct net *net, struct sock *sk,
+			      struct sk_buff *skb)
+{
+	if (unlikely(!seg6_skb_has_lwtstate(skb))) {
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
@@ -630,10 +657,10 @@ static int seg6_input_nf(struct sk_buff *skb)
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		return NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING, net, NULL,
-			       skb, NULL, dev, seg6_input_core);
+			       skb, NULL, dev, seg6_input_core_nf);
 	case htons(ETH_P_IPV6):
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING, net, NULL,
-			       skb, NULL, dev, seg6_input_core);
+			       skb, NULL, dev, seg6_input_core_nf);
 	}
 
 	return -EINVAL;
@@ -726,6 +753,17 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	return err;
 }
 
+static int seg6_output_core_nf(struct net *net, struct sock *sk,
+			       struct sk_buff *skb)
+{
+	if (unlikely(!seg6_skb_has_lwtstate(skb))) {
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
@@ -733,10 +771,10 @@ static int seg6_output_nf(struct net *net, struct sock *sk, struct sk_buff *skb)
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		return NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING, net, sk, skb,
-			       NULL, dev, seg6_output_core);
+			       NULL, dev, seg6_output_core_nf);
 	case htons(ETH_P_IPV6):
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING, net, sk, skb,
-			       NULL, dev, seg6_output_core);
+			       NULL, dev, seg6_output_core_nf);
 	}
 
 	return -EINVAL;
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 0c3d1be7f129..156df33e054d 100644
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
 
+static bool seg6_local_skb_has_lwtstate(struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+
+	if (unlikely(!skb_valid_dst(skb)))
+		return false;
+
+	dst = skb_dst(skb);
+	if (unlikely(!dst->lwtstate ||
+		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6_LOCAL))
+		return false;
+
+	return true;
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
+	if (unlikely(!seg6_local_skb_has_lwtstate(skb))) {
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
+	if (unlikely(!seg6_local_skb_has_lwtstate(skb))) {
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
+	if (unlikely(!seg6_local_skb_has_lwtstate(skb))) {
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

