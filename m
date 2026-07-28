Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11DB4756CF
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275706; cv=none; b=QC3m2Vg2YHY+EWlbsRO0Tk1HFX5SecvP0vWtxBAINNDciQR/Jlwfzth6hds8ThE3xe6M5v7POM8iYf+NqZeood7bNE4fgGGwdmXs9GVdd4PhsPODwD5nMDhjjcmblvj3P4NWnrlpmPp7rSfWO8vPUW8BHXIN+4kH7TQBQYm31TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275706; c=relaxed/simple;
	bh=rNMXt/vq9cI98358QQUrArCK4TwA+krhdZKltyixius=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jax7SNxcqEH43DWta1xbOWDGG/pd7uCD2Y0dcSfehIIT3jisHM+LiY8tX+3ENf8fjXCxtI4bzKCtJsMEiJyiCuzkxSZZR0m6XOj9MgjLbYQxMYuq5ZwleZsAba4Wu7HekpDY1r/UmDWJkxAz/UDJaqjCZ5C7M7IA7aICeY5uIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=o4Rwh5lN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="o4Rwh5lN"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf27856f9cso4095915ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785275704; x=1785880504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pXqMQeSrWlNasYXGsNFZe3vmZwhVRv3WhzGzTNZmZo=;
        b=o4Rwh5lNfJ8D6okapP3v2cGVQaA250jDnKt4YY3YP1FzLPL6b0Xe8ao8frcIK5Od8h
         mBrh/f5okc6REkaAxMUim7BkdHH9Odt1DJPsyoT8gNo3RWzKuq2YcYk4RKPGILcVhrf7
         EAho8cJRY6cA+yfrIDsM0IFOCNs/u/j4sAwHs+v89Yx8CSge5zK0UxlSaQgVD95KL0SH
         QwHhqxMiaUl4tKqvbDJRbKREK+xXc5Xzxz5uPyXoIbcd1fPNzXkDird5Po++uPtcY4uM
         ZsQqmm66lGGCCtwIf6Mvg+MB3Qb+kJpLxi1/A8PgDdp6x+pzZ/VqKTbyS8dw3ZI0Ohlr
         VR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275704; x=1785880504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4pXqMQeSrWlNasYXGsNFZe3vmZwhVRv3WhzGzTNZmZo=;
        b=rpoWY/TTJ5WGY6Wa9lWgfnPQAUZkko4Pni2MkJ/GBSqskRKkH8qkh4Hh8f8wDzGgaT
         h5lz7fbtuBrtGG1svGP2rRoXDbtDk+W8iDE7+Si6du+Q2+W1wZYNn0fQHYeOgwF//0Bc
         gB+67x8CeYkn6YnwmSW1kqCANAj0sv4DLPKUPyCix0Nouyt43n3wwGNQvpex9oaS3jok
         J2Jd3NhlT2hAwzGNqLETUrigHMT1nTFmNK2Ch6tlWmiU9luJr79QP5iKch5kMdaXjZn1
         D2uf7v52OEnGPYUw5hidvgQFP8vUS+VxCMzfseq6d3QDZMSpBXN63D90X93wYFSerPui
         GTGA==
X-Forwarded-Encrypted: i=1; AHgh+RqvXibDG8wdKT+vAouK1zZtnmNQTRk1H4KK3TtirepLYt32HVyORZLgA1oCyrnZtTVGrZcMZ6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5HlEVoiTJqXlkMWggWj4xWsjBl/PjB7tgXJzxt+TOcMH82Zi
	iNK+79AW8Om8eGfzmmRNE7pbCI1IStCws2zwyC8Jer49TBiwwD6BD5s5/5E543E0Yw==
X-Gm-Gg: AR+sD10wwpNlKmJ5CKqMZ4pZq49ampy1MiwhzHq1nLvGaZliJy/uzG2GpyO2aXA3a2n
	NB4dcdog4ko5vwsk47loUFe4KrN3P2u/2yO3MLGQyMLZEurZCKgCMMAFH+pOr9uOjxINh5I7jHZ
	8FkdPLcyCmvd+Xf4SRbg3pIzCZvSWLpAepvDQgsG5fv027qKHfXIQpJ8g57fCCax1uaZ3rRYHXS
	R0p+wvYVLJqJRIlN7ZWqY5ecn1Ox8LK0usg4VwI3XgAb/J2Ral+M0YMglmhkRarBCpw/F44GowP
	Ism9dFBdtQlH8ydXPdN9TC55LLirpdU4Qob8uTpnsIdYSlL8Su6xlRaUo/VMm23R+czxBgkxFEt
	mTwhu+dycBcAP2v9X/SBWOyMT3fiOa/2GU58rXKKfrs2FpJ3fMK/p2DlEKFMFRTJta4h6CHreLk
	a0XMPxOjQX+B7pzjX4T8P+nVTiFx1nqwkGAV6dY1WjXfBQ6TF9HHDVLIkjO2OxkY+0OvMIIcdO7
	YeC2Q==
X-Received: by 2002:a05:6a21:2d8f:b0:3c3:8600:f0a with SMTP id adf61e73a8af0-3c8ba60f566mr4914429637.46.1785275703984;
        Tue, 28 Jul 2026 14:55:03 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b670cfsm2232736eec.8.2026.07.28.14.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:55:03 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: kuba@kernel.org,
	pablo@netfilter.org,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryoga Saito <contact@proelbtn.com>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net v2 2/2] seg6: check lwtunnel state after nf hooks in iptunnel
Date: Tue, 28 Jul 2026 21:54:48 +0000
Message-ID: <20260728215448.1543553-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728215448.1543553-1-xmei5@asu.edu>
References: <20260728215448.1543553-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

seg6_input_core() and seg6_output_core() are the okfns of the
POST_ROUTING hook that seg6_input_nf() and seg6_output_nf() dispatch
through when nf_hooks_lwtunnel is enabled, and they read
skb_dst(skb)->lwtstate on the assumption fixed for seg6local in patch 1.
A hook may drop the dst, replace it with a metadata dst, or leave a route
whose lwtstate is NULL; the last is reachable with SNAT plus an XFRM
policy.

Validate the dst and the encap type before use. seg6_do_srh() reads
skb_dst(skb)->lwtstate too, but these two are its only callers and
neither touches the dst in between.

In seg6_output_core() the validated lwtstate also takes over the dst-loop
comparison, so "orig_dst" is gone, matching seg6_input_core().

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Reported-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
v2: new patch, split out from the seg6local fix (Andrea Mayer).

 net/ipv6/seg6_iptunnel.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 4c45c0a77d75..60883dae5ae9 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -23,6 +23,7 @@
 #include <net/addrconf.h>
 #include <net/ip6_route.h>
 #include <net/dst_cache.h>
+#include <net/dst_metadata.h>
 #ifdef CONFIG_IPV6_SEG6_HMAC
 #include <net/seg6_hmac.h>
 #endif
@@ -65,6 +66,17 @@ seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
 	return seg6_lwt_lwtunnel(lwt)->tuninfo;
 }
 
+static struct lwtunnel_state *seg6_lwtst_from_skb(struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+
+	if (!skb_valid_dst(skb) || !dst->lwtstate ||
+	    dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6)
+		return NULL;
+
+	return dst->lwtstate;
+}
+
 static const struct nla_policy seg6_iptunnel_policy[SEG6_IPTUNNEL_MAX + 1] = {
 	[SEG6_IPTUNNEL_SRH]	= { .type = NLA_BINARY },
 	[SEG6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
@@ -488,18 +500,21 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
 static int seg6_input_core(struct net *net, struct sock *sk,
 			   struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	/* We cannot dereference "orig_dst" once ip6_route_input() or
+	/* We cannot dereference the incoming dst once ip6_route_input() or
 	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
 	 * need the address of its lwtstate. So, save the address of lwtstate
 	 * now and use it later as a comparison.
 	 */
-	lwtst = orig_dst->lwtstate;
+	lwtst = seg6_lwtst_from_skb(skb);
+	if (unlikely(!lwtst)) {
+		err = -EINVAL;
+		goto drop;
+	}
 
 	slwt = seg6_lwt_lwtunnel(lwtst);
 
@@ -581,12 +596,18 @@ static int seg6_input(struct sk_buff *skb)
 static int seg6_output_core(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	lwtst = seg6_lwtst_from_skb(skb);
+	if (unlikely(!lwtst)) {
+		err = -EINVAL;
+		goto drop;
+	}
+
+	slwt = seg6_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache_output);
@@ -614,7 +635,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		}
 
 		/* cache only if we don't create a dst reference loop */
-		if (orig_dst->lwtstate != dst->lwtstate) {
+		if (lwtst != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
 			local_bh_enable();
-- 
2.43.0

