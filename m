Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396853;
	b=b+bpVQXSOcPbm3JEjXPScFvO+Dds2QZHXe38uRQ2GZF6X1lyd//Wm9FOPO4YX4bxKxS9
	 hxydoTkkMeR4PIRhAf2r1c+bB/8CgVg7sp7d64Pc94XQmGQrm0nWECElNAEd/XAILMU5A
	 8BrYDTqiVnZgC3okrUJh1cKIZVIBWqK/fbuqP75ud+W7LrSezTNI031xeTkG0utPWL25A
	 30w+DgHcFg+NgsquYPcahihyzKQcMwaNpbviIU2MEBC+GDvISna51ywyNNSbLMBbb4QC8
	 Ip3MRchb83l/f8dZBgIcogdWVlItwZeRR7OxArris1Yg6ca7w1myBgWYDKbEXc7bMGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
	b=4bdpx+tNeWjyqrQ31fuVSRj8bM2IEC6Gm6QBFenRaRpJYBGFNHM1r0+Nck6xN72Re0I4
	 J7bCK6S8jAJ2QlnpdvM7lbUDTdA4MTFrIRyj4L5xkmkwjUhul/pzLosCVE9bF3p9ZAWfB
	 ybjBWp64N64DqZRyoPX6vkxf05wEDMIEAtdJaArWnGS8k8kyN/4o9CGOdde3/v8I2+qNX
	 PhVJMm7Di7/0NNc8xeIHiXFEdWRpGs8J52l0R9VUo5d/eIvAVe09NVM6UzBIGHcYfk1Ed
	 e1qbPZc2WjWHEZ3zQwc9EqmTmA3M5dkIxK9ozrbrpteEgfuCY2c4Q/AsMt6QwR48XTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwLgp5NI;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBB606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFBB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwLgp5NI
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ea0efd636dso10764595ad.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793396852; x=1794001652; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
        b=QwLgp5NIIMg4AA8/Z8CtU3veu8cREA/NoPqO23FoHKGC2AvsPNQmzks5z8NjAGnG/7
         BD+ScScN5uJUv8ITeksQDGK+fqx3rm7eK5nu5JL35HXr5EeDTZqo8H6lUhoriOU0kp3T
         n4Cr6obn1rdNu4BtmuGD/0gHHQOz/9joE+tLRnTxTz3OpMJ8aym3QAdjy+0zl7O+2L0w
         OcJWym7XY8P4pwpSMytqPjqzLzyaJmqOxy6zVKYr8aq3T+f039sSxExWB+CFDlN8z0yd
         uiAKWbQYezGYKcGlBy2DHE+7yOcvR6xCHyhfPmirxfPFcswd06xFfor8tls/BoU2Rz6I
         NofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396852; x=1794001652;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
        b=bt/CK6zexG7ckSjUfck6KnbGw0sMr+AhJddVYpzjKF2H3jnNKrz+ctwKAujGtR+G23
         Id3xY1Uyk8m7sAyMEdrqHuotqyE2IjqQ58vv/hWhdtICLJpwTQQdtbz5nzWd0YWcQb0j
         3q59zhVh/NA2fhrrxdEpjKfGEgpOjzwLCTzD67OtEamhCQ2iv3nCtlSTq1Wee2AGNhI+
         L7ZNXb9sx+x2Bowazm5RuOk9iaSqvcjNQNxtFxMm0umeJM+i7JGB1eaUgawaRiWzmBm0
         tHWXLnGkJ5nsw5uwgMM47EeSgn95Y+oV6SMSHn2aPGkx5T5gy74BkjiMF6g+Rx8c9se9
         nbKA==
X-Forwarded-Encrypted: i=1; AKwUvBzkcGuXXoR+39xp3mc6j/qIhCI0zECnNr8J6BASqaAzvZDKfnvolx1/Dj4+PntiwdeUri40ZVA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUcJmGtQgQHh55GF5H8/qq/s4Ty6bHlDZBpbsTCyZlogJrgzf1
	5JdXClwB5620wfIWhpek57M7eGtN0wf+MPb/mOoK6XvwJd6yU1+gPWVLhSUvZA==
X-Gm-Gg: AYBFou01lJxuHipf1TDzVPh5oMVlpcLBGmjJEYvMhGaOvSDfwBLK2eAc6zGE8q7sTUd
	5CM/cpAV7accCC0ewa5gZ4qY+5E3rMfLPSdtEYNuZ9/XRehebBaPp9PE3AWLGomUtf7Vp6smixr
	NgcoOSR8TCQyrwOyfs1KfNK8JOs05PM5iKD/ml7Ao5/OwOC03Mi/USUqhZ8BD6BOHEElqeK6zJh
	fXKDYhwRqYVmIgAzICeRDgf98UNJFJ0uMlyBjrnNqqfcIrhUniCi94DjMP3K/fMRlLNM7LvwqN6
	xa5DGjV7N/SsgQ7BIwNh7PamTIMgXhOl4pzq+fZlU1gBzgr3QP4qO64JZ31aDVF02aIfbMsOFtB
	QzaSkBBzO8DjjjLqgXO3ihOWSmxXRPl9EL5UlVEbbyZqtYsld8s68d8NOSZAjhoCcADorMEucOO
	2T9u8/umDWUtMmbsmBBF3JrkufeS6PwHPG9DGwWMeW4CMxzXiU/D/kC+7Sjnh3xgk29FZyRSsLC
	+Bk5UJ44LcgqJMWuwWGRvvP1RfqbcUduqR2wWe5LMFNQHx4E07tI8NGTiSxZqRhgdWz3V10ICKm
	YA+u3nKZbaevR6KtJZeWn0xQPDq7/0e+b1Ltc8l8PNYuujtCd28ei9dbEjh0fNurLn8q2OHME4t
	xW071ab58wbnCwXDuZNJ6c6lLNI7u5CSPvA==
X-Received: by 2002:a17:903:144b:b0:2e9:42d8:48d3 with SMTP id d9443c01a7336-2eb364d2529mr35787295ad.36.1793396851935;
        Fri, 30 Oct 2026 14:47:31 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39230bbfsm11775285ad.19.2026.10.30.14.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:47:31 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 21:47:30 +0000
Message-Id: <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
Cc: "Eric Dumazet" <edumazet@kernel.org>, <bpf@vger.kernel.org>,
 <bot+bpf-ci@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "David
 Ahern" <dsahern@gmail.com>, "Martin KaFai Lau" <kafai@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jiri Pirko" <jiri@resnulli.us>, "Victor
 Nogueira" <victor@mojatatu.com>, <linux-kselftest@vger.kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] bpf: Fix skb_pull() BUG in
 __bpf_redirect_neigh()
In-Reply-To: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
References: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 02:36 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Add egress coverage to tc_redirect_neigh: the existing test only attaches
> redirect_neigh at ingress, where mac_len is populated.

This test cannot hit the BUG.
Just drop it and respin as [PATCH bpf v3].

>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
>  				struct bpf_nh_params *nh)
>  {
> -	struct ethhdr *ethh = eth_hdr(skb);
> +	struct ethhdr *ethh;
>
>  	if (unlikely(skb->mac_header >= skb->network_header))
>  		goto out;
> +	if (unlikely(skb_mac_header_len(skb) < ETH_HLEN ||
> +		     !pskb_may_pull(skb, ETH_HLEN)))
> +		goto out;
> +	ethh = eth_hdr(skb);

ETH_HLEN is not enough.
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() read ip_hdr()
and ipv6_hdr() right after the pull. Nothing makes these headers linear.
Take the AF_PACKET frame from the commit log without pop_eth and
bpf_skb_change_head():

  packet_snd()                     headlen == 14, IP header in frags
  skb_pull(skb, ETH_HLEN)          headlen == 0
  skb_reset_network_header(skb)    network header == skb->tail
  ip4h->daddr, ip4h->saddr         read past skb->tail

The route lookup runs on garbage.

Eric's skb_network_offset() check also covers
mac_header >= network_header. No need for two checks.

Something like this:

diff --git a/net/core/filter.c b/net/core/filter.c
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2290,10 +2290,14 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
+	const struct ipv6hdr *ip6h;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
+		goto out_drop;
+	ip6h = ipv6_hdr(skb);
 
 	if (!nh) {
 		struct dst_entry *dst;
 		struct flowi6 fl6 = {
@@ -2399,10 +2403,14 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
-	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
+	const struct iphdr *ip4h;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
+		goto out_drop;
+	ip4h = ip_hdr(skb);
 
 	if (!nh) {
 		struct flowi4 fl4 = {
 			.flowi4_flags = FLOWI_FLAG_ANYSRC,
@@ -2451,15 +2459,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
 {
-	struct ethhdr *ethh = eth_hdr(skb);
-
-	if (unlikely(skb->mac_header >= skb->network_header))
+	if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
+		     !pskb_may_pull(skb, ETH_HLEN)))
 		goto out;
 	bpf_push_mac_rcsum(skb);
-	if (is_multicast_ether_addr(ethh->h_dest))
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
 		goto out;
 
-	skb_pull(skb, sizeof(*ethh));
+	skb_pull(skb, ETH_HLEN);
 	skb_unset_mac_header(skb);
 	skb_reset_network_header(skb);
 

pw-bot: cr
