Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546337;
	b=CWVNmj5UOD6BtRrf+kG+rfT82Nc+wE96uSJKA0BAWpT/QjRM8uWR/kGI0d68UpktEXLG
	 AZypr0W7rJmvW41ViyiRILJW7rqL9T8x1pCK7LvvLbjWEaKjq9IAXJf4VJ+uRsy9z/V8L
	 y3pguF2+borvD0rqmhu2DdCRt8s7bOoGM9l56CPvuvplKEl+p2LfIeHXdei1lbbeNwc7j
	 k8Y2yavw5TeKmO7B1Yuwuco9fcRRud7Tlmlo35WEz92cuxO2sLsRhti+wEPoBNlPAKAh5
	 oTGRM0qZQp95Frw6CxBuy31mOWHsnntEIg89iKmCxbv+P2An7ih0Au1neIHvGxACfnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546337;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=viKjkxwm6w/datGgSuiR2vSrkOeCSUfzz8GH4AKZkPg=;
	b=XceKfyuNgauOAYjXMijyfFHWB3Hdl7BGir8meWpvTwkbZSfoYhIbvheMYkZHV6xNm/Nm
	 C+VuQbnnh/rH1Tq7VhtEBGGBSfd2RfXmf/ww1M2UXoR0LAXJqun9TLlileN+tBKCufwCA
	 IHqErQFjdV3VjkqwBiG+C4kqPbGLZxNaVjlfEEayKK3KI5SYr1GH3JAbEsyRGlfa92W8a
	 ZtqlNKDpcKG/pusj4bFddwCQyn30oTW9ZB8sux3ZZT0R7ZyRDJFKgBQ9ongr18O2PsPub
	 Dc8t1XxfDi1NCpjLQqx2N1xo2f5+d77WzuMorcyr+gOsg30poOgfE5TMpl1fUlE96TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pRZOoeXX;
	arc=none smtp.remote-ip=95.215.58.97
Received: from mta1.migadu.com (out-97.mta1.migadu.com [95.215.58.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF4606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36DF4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pRZOoeXX
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZJaoww9Yi8saFthd8Kvxn1L7Jb1aehO9JTRyFYDD/lo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792546331; v=1; x=1793151131;
 b=pRZOoeXXD90geBNE8Qj8axj8ytIe5gJDNYsa5XyrMoi47KcpUtiteOHeBNTa1qI/uQr2mCd6
 RhGWshmVxNoGxY0VTK+B41mnMiUKKgqu6XsqUGwdS5mlR3GZw20eBwUAlLbIJUTpr+VO4lLCvwe
 wZQyWG8GLNrKyypIRx5b6rZg=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 987630b6f72007a2;
	Wed, 21 Oct 2026 01:32:11 +0000
X-Mizu-Trace-ID: 987630b6f72007a2
X-Migadu-Flow: FLOW_OUT
Date: Wed, 21 Oct 2026 09:32:00 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lebrun <david.lebrun@uclouvain.be>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Hazley Samsudin <hazleycryilis@gmail.com>,
	Stefano Salsano <stefano.salsano@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix transport header for inner IPv4 with IP
 options
Message-ID: <atgWEBZ5J9LQyULx@fedora>
References: <20261020023336.34-1-andrea.mayer@uniroma2.it>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020023336.34-1-andrea.mayer@uniroma2.it>

Hi Andrea,
On Tue, Oct 20, 2026 at 04:33:36AM +0200, Andrea Mayer wrote:
> The End.DT4, End.DT46 (its IPv4 path only) and End.DX4 behaviors set the
> transport header of the decapsulated IPv4 packet at a fixed 20 bytes, the
> size of an IPv4 header without options. They do not validate the header
> length either. With options, the transport header points at the first
> option byte. The effects include:
> - ping -R sends an echo request with a 60-byte IPv4 header to a local
>   address through an End.DT4 or an End.DX4 SID. Since icmp_rcv()
>   computes the ICMP checksum from the first option byte, the request
>   fails the check and is counted in IcmpInCsumErrors.
> - A UDP datagram can reach a port that an iptables rule drops. The rule
>   checks the UDP header after the full IPv4 header, while the socket
>   lookup reads it at the fixed 20-byte offset.
> - With an inbound AH state, ah_input() reads the AH header at the fixed
>   20-byte offset, but copies the IPv4 header over it with the length in
>   the IHL field. A packet shorter than that length can make ah_input()
>   write past the end of the data, into skb_shared_info when the skb has
>   no tailroom.
> 
> Validate the inner IPv4 header length with the new helper
> seg6_validate_iphdr_len() and set the transport header at that length. A
> packet that is not IPv4, whose header length field is below 5, or whose
> header is truncated, is dropped with a drop reason. The fix is limited to
> the header length, which the transport header relies on. Other checks done
> on IPv4 input, such as the header checksum, the total length and the IP
> options, are not addressed here.
> 
> Found by code inspection while reviewing commit 44930446dde4 ("ipv6: seg6:
> clear IPv4 control block on IPIP decapsulation"), as a pre-existing issue
> that Sashiko also reported on v2 of that patch. Without this patch, a
> bpftrace probe on ah_input() shows the reporter's reproducer packet
> written into skb_shared_info. With it, that packet is dropped before
> ah_input(), ping -R no longer fails the ICMP checksum, the UDP datagram
> reaches its real port, and the SRv6 selftests still pass. These effects
> reproduce on an unmodified kernel, without error injection.
> 
> Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
> Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
> Reported-by: Hazley Samsudin <hazleycryilis@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260809221915.2ffc1ecd0f445fcb70270e31@uniroma2.it/
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_local.c | 56 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 53f7b2452575..c249f7751d41 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1056,6 +1056,40 @@ static int input_action_end_dx6(struct sk_buff *skb,
>  	return -EINVAL;
>  }
>  
> +/* Validate the length of the IPv4 header at skb->data (which must point to
> + * the network header) and report that length, options included.
> + * Only the version, the header length and the presence of the whole header
> + * are checked.
> + * The length is written only when SKB_NOT_DROPPED_YET is returned.
> + *
> + * skb pointers may change: after this call, the caller must evaluate again
> + * any pointer into the packet data.
> + */
> +static enum skb_drop_reason
> +seg6_validate_iphdr_len(struct sk_buff *skb, int *hdrlen)
> +{
> +	enum skb_drop_reason reason;
> +	const struct iphdr *iph;
> +	int len;
> +
> +	reason = pskb_may_pull_reason(skb, sizeof(struct iphdr));
> +	if (reason)
> +		return reason;
> +
> +	iph = ip_hdr(skb);
> +	if (iph->version != 4 || iph->ihl < 5)
> +		return SKB_DROP_REASON_IP_INHDR;
> +
> +	len = ip_hdrlen(skb);
> +
> +	reason = pskb_may_pull_reason(skb, len);
> +	if (reason)
> +		return reason;
> +
> +	*hdrlen = len;
> +	return SKB_NOT_DROPPED_YET;
> +}
> +
>  static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
>  				       struct sk_buff *skb)
>  {
> @@ -1085,14 +1119,18 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
>  static int input_action_end_dx4(struct sk_buff *skb,
>  				struct seg6_local_lwt *slwt)
>  {
> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
> +	int hdrlen;
> +
>  	if (!decap_and_validate(skb, IPPROTO_IPIP))
>  		goto drop;
>  
> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> +	reason = seg6_validate_iphdr_len(skb, &hdrlen);
> +	if (reason)
>  		goto drop;
>  
>  	skb->protocol = htons(ETH_P_IP);
> -	skb_set_transport_header(skb, sizeof(struct iphdr));
> +	skb_set_transport_header(skb, hdrlen);
>  	nf_reset_ct(skb);
>  
>  	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
> @@ -1102,7 +1140,7 @@ static int input_action_end_dx4(struct sk_buff *skb,
>  
>  	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
>  drop:
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, reason);
>  	return -EINVAL;
>  }
>  
> @@ -1234,6 +1272,7 @@ static struct net_device *end_dt_get_vrf_rcu(struct sk_buff *skb,
>  static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
>  				       struct seg6_local_lwt *slwt, u16 family)
>  {
> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;

Nit: We can use SKB_DR(reason) without the long definition.

>  	struct seg6_end_dt_info *info = &slwt->dt_info;
>  	struct net_device *vrf;
>  	__be16 protocol;
> @@ -1246,7 +1285,9 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
>  	switch (family) {
>  	case AF_INET:
>  		protocol = htons(ETH_P_IP);
> -		hdrlen = sizeof(struct iphdr);
> +		reason = seg6_validate_iphdr_len(skb, &hdrlen);
> +		if (unlikely(reason))
> +			goto drop;
>  		break;
>  	case AF_INET6:
>  		protocol = htons(ETH_P_IPV6);
> @@ -1260,6 +1301,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
>  
>  	if (unlikely(info->family != AF_UNSPEC && info->family != family)) {
>  		pr_warn_once("seg6local: SRv6 End.DT* family mismatch");
> +		reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  		goto drop;
>  	}

And maybe move this checking upper before switch(), then we don't need
to reset reason.

No need to post another patch if you don't want.

>  
> @@ -1273,7 +1315,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
>  	return end_dt_vrf_rcv(skb, family, vrf);
>  
>  drop:
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, reason);
>  	return ERR_PTR(-EINVAL);
>  }
>  
> @@ -1286,9 +1328,7 @@ static int input_action_end_dt4(struct sk_buff *skb,
>  	if (!decap_and_validate(skb, IPPROTO_IPIP))
>  		goto drop;
>  
> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> -		goto drop;
> -
> +	/* end_dt_vrf_core() validates the inner IPv4 header length */
>  	skb = end_dt_vrf_core(skb, slwt, AF_INET);
>  	if (!skb)
>  		/* packet has been processed and consumed by the VRF */
> -- 
> 2.43.0
> 

Others looks good to me. Thanks!

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
