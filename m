Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6E3CF043
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787227259; cv=none; b=u4kH3oOuaFcdEZaNkPudVGF9lj/lsqRQcrbFARMQvSPGEAMDkS+6yppJ9zAxp3w8V9fCyaZT9UKu73ltWHThSny1Z9xq5vQJko0pnsOVVM4bzVyafjfuCLteyfzqCt1+ywh8POzGFuEexp9jgPlahodEVYDjupBxTfcvxdSkX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787227259; c=relaxed/simple;
	bh=jIGHJo64KZ1/8bcaU2EUHe/Bg6Onm9NSgiFw9RGZNXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiB4ZHxpzSogRcxCLiwxkKqM8o0ralq2SH7Y3hoFINGpAem3K9O1ZPIwpsJSr5/zgxAFPnz7OaPZ5WQtHLbsYVsAe3T+epqREXj9QIIFKGf8goOpdKvbVGQbssYMkRGGG20w5iPxA5SQdOTv139TF+FifVa9HpE7itN+k/hFcCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYdPTSUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYdPTSUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721E41F000E9;
	Thu, 20 Aug 2026 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787227257;
	bh=v1GgjO49qIdTTyVmp80qX+fSPRSpSnmapfgIEyG26Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fYdPTSUKucTX0y9N6fHQT5nXfcvSaqKkqGUebtfK6fIVSTEBC2hq56OJTOVEXDSHF
	 rJEIgOAit4V0lxwCT1BoaC7YgpBTRzOTj2BHFVEOtWutDqMARB8vL98PCTa/a5qYms
	 OQJ01uAxhNGXNy5ENlolvebQo6IcD/Yo6cJ9tqBjP5UYrcC/MqDiGYkKPHO2tmniOe
	 kf+RH4aLgBjLbBAxmuDX6cqhogMmRu7wGol9z9uTVjz80KZU1rG0KcqJEGonY/a2Zc
	 l51ZJ2GXnwQ5gGMxRHchQbYdkipVO43V6D+dOVovzfwKRwY0WhspQvhHyOczIZ/2/7
	 l0cQg/nMBZGPA==
From: Simon Horman <horms@kernel.org>
To: juny24602@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	david.lebrun@uclouvain.be,
	netdev@vger.kernel.org,
	junvyyang@tencent.com,
	stable@kernel.org,
	corvus@tencent.com
Subject: Re: [PATCH net] ipv6: sr: restore network header before forwarding
Date: Thu, 20 Aug 2026 13:00:35 +0100
Message-ID: <20260820120035.816230-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817104128.22681-1-juny24602@gmail.com>
References: <20260817104128.22681-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260817104128.22681-1-juny24602@gmail.com?part=1
---
--- Patch [1]: [PATCH net] ipv6: sr: restore network header before forwarding ---
commit afc1a14387ef1e89c0ab5549e08d7004f0646b94
Author: Jun Yang <junvyyang@tencent.com>

ipv6: sr: restore network header before forwarding

ipv6_srh_rcv() runs with skb->data at the Segment Routing Header while
skb_network_header() points at the fixed IPv6 header. It restores the
data position by pushing sizeof(struct ipv6hdr) before dst_input(),
which assumes the SRH immediately follows the IPv6 header. If another
extension header precedes the SRH, skb_network_offset() remains negative
and neighbour output passes it to __skb_pull() as an unsigned length.

Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>

> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 9c677eb1d1a61..4c407520e9daa 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -452,8 +452,6 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
>  	hdr->segments_left--;
>  	addr = hdr->segments + hdr->segments_left;
>  
> -	skb_push(skb, sizeof(struct ipv6hdr));
> -
>  	if (skb->ip_summed == CHECKSUM_COMPLETE)
>  		seg6_update_csum(skb);
>  
> @@ -462,6 +460,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
>  	ipv6_hdr(skb)->daddr = *addr;
>  
>  	ip6_route_input(skb);

[Severity: High]
This is a pre-existing issue, but does removing this push expose a BPF flow
dissection bug for all SRH packets?

When the skb data pointer is left at the SRH instead of the network header,
skb_network_offset(skb) becomes negative.

ip6_route_input() passes the skb to fib6_rules_early_flow_dissect(), which
eventually forwards this negative offset as nhoff to bpf_flow_dissect() in
net/core/flow_dissector.c:

bpf_flow_dissect() {
    ...
    flow_keys->nhoff = nhoff;
    flow_keys->thoff = flow_keys->nhoff;
    ...
}

Because flow_keys->nhoff is a u16, the negative offset wraps around to a
huge positive offset before BPF execution.

Later in the same function:

    flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);

After BPF execution, clamp_t() operates on the wrapped u16 values,
permanently capping the offsets to hlen.

While this previously affected packets with multiple extension headers, does
delaying the push until after routing cause BPF flow dissection to fail for
all SRH packets?

[ ... ]
