Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417295;
	b=ToYZ9h0xAOTe4/pU0Ocp4XPSLc9w+HTT8T0/Rb92q5fbaeZzLIzaHkmy3H9/oEBfRL6/
	 CJnkrXsfPJNfC0d1h0vc9GH/0nAa2bampS6zMjjhJ7HGuvOmNSbbH6mlSSLTcpf9uH5t2
	 gOAuZDQOg6A4pWBS6OGuOugJh/a21dZmgIj1u3cGHULnlvdyPOPRsqpHNxYYUMEfoq9zd
	 W6gEvS2Pnd3n6c1v1hzIiefBi1V5croGLslxlviv+K6kZJWuYHTG4JlEpK1D75lEtauRf
	 hSX2UZhKzjqKKj2cu5hDQzrUFiCZ6afFFXQNciTCKHlKUnr08vn2XOyANStxOKfFoVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JOUfXRcikYW9u7KTVEt4MRIJ4ALs6TSrzjsUtuiLhEk=;
	b=g+rjVMwO7/0QzxA8yaY86KriJbq8J4glf1q4pJa6SbIXNm6wgqRzZZcOzq3J67LGDa9d
	 vuBOMrQ0hnP5Y5GmhgTjERT2ooumfH1Ak1M2Ck489S1HB7DHkHsK8+eYuFyt2S6bPlg8Q
	 rADdihPQ8RbYRTRWercbneDdvtOIrRgkj/lnw3wbX4D6WXN1jn6BUOj3H/6vkQOoCV6Lc
	 qqEddfFvL3jgdK/4OMEB/GiLGXA6HQRQiCoPAHM/OM19wlvlWk+Pe5ixpyXBo8Vb8IlnD
	 2ZlpA7CmngMf5Co0XtCqJ6IU9VrVWXnSRQleuxvvueNN9dOmGubWyC4orhFDOElW3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=QF8bLc+T;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAD606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 03:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38FAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=QF8bLc+T
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-369f33df08eso2749590eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793417294; x=1794022094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JOUfXRcikYW9u7KTVEt4MRIJ4ALs6TSrzjsUtuiLhEk=;
        b=QF8bLc+TkDbb/G4QSSWzhvroxhdK1yz/N5T2wzcayT1fuLX3ZgU9lyMHey3HQvRK3f
         RXdsKCotCc/emtDJpmiSEZGiZ305UKfrQLL2GSIXoBUcHpdwwu86VMYZbXyoSMlVAtiV
         xiggi+jdFjND6PzSe0NFHJqCZioK09JyuDQtIGmEy8ZnnXYTypxZH/TqwPrXvRYPyFUp
         2KVraTAgKe/HYSaoobij7bR7TVVFgF1/4lXSG96FOnAaMvbrz0KNYQc1RPTB1uoEJCN4
         OLxqkS1BBd91qPO4TfyvaDdPaNB3HZtzdRCNBIFwRAPk4lqcia3vkO+O+VZOlwFXSRCW
         BgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417294; x=1794022094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOUfXRcikYW9u7KTVEt4MRIJ4ALs6TSrzjsUtuiLhEk=;
        b=eKwt7J3INNQ9YFHSNFJrZVDH7O4MRcd62XLuY7XvmJUwaSgW25ty+AWhwubdYd/ZGy
         jCS2euOUWvnj3OKg5/DvsW88kovlC2Xc5qq8Y6MQfsXEXZ8srW/dUlfp/C4jfqJzaGv1
         JlLtjohADxNxrv7ABwl7BZ2OYIXDTGBfdrriuF469uOYfaq6pg/hklbnaQnJXnRlvLwp
         FgcuQiRshMD3aBSOehmz582Ho9E//uCG1EPIXdyIHoarPjqVyersB+DkSzAC/ZIKTun1
         83RPVPChBNTW69BGxlmgQeyndLeaMga0d4WtbguyA4etTxY0qJpE3PSi5rLVRzULHKrL
         rfqw==
X-Gm-Message-State: AFq9FYJeO/zcSdMzpN/+IWwfvM0hR/nPKMcdEEcJT0ed4gQTA1E4gVyL
	3TuwmqaNsNJt7FyXvHjvaMcwo+t/jKvyRzRdhCRTCG9wjdAXTTHUWy986e+hudfHyjcGcyxRrhE
	Afm4dRRRw
X-Gm-Gg: AYBFou3PzlmvDgqoHxqlM79pOh185olxGjq92HJAMT3wkTF647KdFspDo354sht6Aam
	gQJis0SELEwxXYxTTdErj0D+09M41RtPSMzlEOhQeF4a+uktV4MshQMYZqxfxXji8pw3y+bMQ+1
	HXpyEp0EZXW4Z0RmEow/6rnsQVFW0Sz/y9vX1OZW65OxyMCb62YRiQfu0YcRqWFA+PiZRm3hLdT
	nexOdGHALCBpxXJ8qQMg0lpBW5LJCQt+C2B70Kg6wkpzlJwg7MkW3JKbhTIiRFtjivzGX75uegX
	8oIXTgBBIWt7im3nmhbVsGiQvJyfwX29ohU1bIgiAHsAwJmVLAz96AkhpUTOgWmltN3dimRRoC+
	007QmHHMXrSF+pTzk2ad4XFtfv83lZXr+P8Syl9VYxEJo77rilFvTVQiqKcHwJa6UkUNYelx430
	MHmRRE6BEbjubUI4wGPI0aCRlXSNYJW+SCuHdaT60My4zpy1/vtED7XggHFko/xJCbkFwrzOFYF
	crFC7HGNyhtst70vlIUrbBi9r/qtnw2kf03d+bZWECA6FXxFtkBjVugEGiCY2YgVy/env2kCwv+
	R0olIudZBWe0hn9WU64OdWXV
X-Received: by 2002:a05:7300:c39f:b0:368:3568:9866 with SMTP id 5a478bee46e88-36a42203e20mr6151534eec.5.1793417293957;
        Fri, 30 Oct 2026 20:28:13 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([2a05:dfc1:8bc4:feda::14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm11740841eec.18.2026.10.30.20.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:28:13 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	andrea.mayer@uniroma2.it,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	pablo@netfilter.org,
	contact@proelbtn.com,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	petalzu987@gmail.com,
	weir@nebusec.ai,
	liuhangbin@kylinos.cn
Subject: [PATCH net v4] seg6: validate state in netfilter continuations
Date: Sat, 31 Oct 2026 11:26:44 +0800
Message-ID: <c9ec4da483c6c17dda703bcd6fc425ef2b53e320.1793207060.git.petalzu987@gmail.com>
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

Netfilter hooks can replace or drop skb_dst() before SRv6 continuation
callbacks resume. Validate the current destination and lwtstate in each
hook continuation, dropping packets with missing or incompatible state
while preserving direct no-hook paths.

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
index 0d39a38a5dd2..846df1fef0ae 100644
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
@@ -622,6 +638,17 @@ static int seg6_input_core(struct net *net, struct sock *sk,
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
index 0c3d1be7f129..234bc2e2f284 100644
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

