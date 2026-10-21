Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583746;
	b=K+3Asi/0SYhkvw4QYlhIWM+k8RJP8jbRBhG4fuSecpkkrr9BXgpmDO1SvV02ZCcuCdHy
	 U31VBdzwakJzjliRjqeKuVI4TcTFVBuTw8BBf5IHMCjliY7p6UWloUBPxU18/t861xr7U
	 etEqF7cuLmLpfxgvdfsfFmGPJj1RpFIzBSHSrTDWUAfmng28kVCkgc3qW8NhyQi+H9MJW
	 TMVJN1R6ckFRZoAPEYUXfxB4Wr6Gf+ie9M4wyXdD23VJNLQEz3nv6cggodLDYXmoYzd32
	 KMfhKszxERN8BYTYvsczD4iUIDpoKzfCpa/OmZr+9WBb9j42v/y6sWInVc/wc2aN5Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583746;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=ZNdCeQ9XS2Flnfv4lzRM2sIK+csUFPPvzL/2db4vShQ=;
	b=0wwIoTTgXFFUThWVU5P/y1xyNXWZUzbpM/owyoOyeDvr3InhmlXfD1DIyc98dmM4gU0G
	 TqA9KtZyglM/FgVp/nYhlpjMAG5ceql+FyJJWShiv8Bf22y6xSDqOi/LfWBnJ+wZFPgLP
	 DKuQxqdHkItwDzTfNtyzsPtz8KU3kgc67fRTL+idVZFtbND2+hM0SwhicybrCVsfTAGUh
	 wwwn2vHIonUnGRoEEz67kfuILNPG8GwXjK5LDy80KRGCE3+RleegntpbPQcX7YyQUqkht
	 /6rHxfTEsBs58KmUBwPMT8a5aiFRNSLGNozZQVBGiWt9MPA0lZO6EMTIr0izVQe55tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=Ws2U6S4c;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0EC04606A32A;
	Wed, 21 Oct 2026 11:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC04606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=Ws2U6S4c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1792583742;
	bh=ZNdCeQ9XS2Flnfv4lzRM2sIK+csUFPPvzL/2db4vShQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ws2U6S4cm6HdM2RjSxhp0xr0WAR/N531fqehEQTWHmclX2acBiwRCFPVhVYrqgSXi
	 E+wcHZnClZ0ICxMpF91GC2a/XBskE9yaBdLjulJI2AJ3nERp+iI2WpXMWLofEOoIXt
	 kmpP6FRF0tTMEskXIGuVS2D6KtcIyxu5oVgmVJ0C2DPK//d06fEQsyvr25bAiI+OvC
	 8hUHuFJNtUTYvUFg2zRY/oZG12pQdl1R4w0AfDa3AvCnanLncuhe5iaepvQW/saEjj
	 3z2g90vPvwu0GZrTp8x7tarbIQjr+Fy9maiDiyVjVODSTHZrr7Ligp6TPndVll0WjB
	 NmtY6lj9eB10g==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 5579360052;
	Wed, 21 Oct 2026 13:55:42 +0200 (CEST)
Date: Wed, 21 Oct 2026 13:55:40 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Mark Brown <broonie@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Liu Chao <liuc63@xiaopeng.com>, Networking <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Piotr Kubik <piotr@kubik.pl>
Subject: Re: linux-next: manual merge of the bluetooth-fixes tree with the
 net tree
Message-ID: <atioPA8ofnC-PCGi@chamomile>
References: <atiblfL12VddJgjU@sirena.co.uk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atiblfL12VddJgjU@sirena.co.uk>

Hi,

@netdev maintainers: Please, see below.

On Wed, Oct 21, 2026 at 12:01:41PM +0100, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the bluetooth-fixes tree got a conflict in:
> 
>   net/netfilter/nf_conntrack_netlink.c
> 
> between commit:
> 
>   cd37ab22a74e0 ("netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter")
> 
> from the net tree and commit:
> 
>   1ae2d094b0200 ("netfilter: ctnetlink: fix inverted IPv6 address match in dump filter")
> 
> from the bluetooth-fixes tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Sorry for this: This patch is duplicated, one variant went into
net.git and another into net-next.git.

Two possibilities:

- Revert 1ae2d094b020 ("netfilter: ctnetlink: fix inverted IPv6
  address match in dump filter") in net-next.git

or

- Revert cd37ab22a74e ("netfilter: nf_conntrack_netlink: fix inverted
  IPv6 tuple filter")

before net-next.git gets merged into net.git, because these two
patches address the same issue.

Apologies for this.

> diff --combined net/netfilter/nf_conntrack_netlink.c
> index cc8695d5356d2,4b6abe36028e3..0000000000000
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@@ -911,6 -911,7 +911,7 @@@ struct ctnetlink_filter 
>   static const struct nla_policy cta_filter_nla_policy[CTA_FILTER_MAX + 1] = {
>   	[CTA_FILTER_ORIG_FLAGS]		= NLA_POLICY_MASK(NLA_U32, CTA_FILTER_F_ALL),
>   	[CTA_FILTER_REPLY_FLAGS]	= NLA_POLICY_MASK(NLA_U32, CTA_FILTER_F_ALL),
> + 	[CTA_FILTER_ZONE]		= { .type = NLA_FLAG },
>   };
>   
>   static int ctnetlink_parse_filter(const struct nlattr *attr,
> @@@ -930,6 -931,9 +931,9 @@@
>   	if (tb[CTA_FILTER_REPLY_FLAGS])
>   		filter->reply_flags = nla_get_u32(tb[CTA_FILTER_REPLY_FLAGS]);
>   
> + 	if (tb[CTA_FILTER_ZONE])
> + 		filter->zone_filter = true;
> + 
>   	return 0;
>   }
>   
> @@@ -1006,6 -1010,7 +1010,7 @@@ ctnetlink_alloc_filter(const struct nla
>   	if (err)
>   		goto err_filter;
>   
> + 	/* CTA_ZONE is allowed without CTA_FILTER_ZONE. */
>   	if (cda[CTA_ZONE]) {
>   		err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
>   		if (err < 0)
> @@@ -1020,6 -1025,12 +1025,12 @@@
>   	if (err < 0)
>   		goto err_filter;
>   
> + 	/* CTA_FILTER_ZONE cannot be set without CTA_ZONE. */
> + 	if (filter->zone_filter && !cda[CTA_ZONE]) {
> + 		err = -EINVAL;
> + 		goto err_filter;
> + 	}
> + 
>   	if (filter->orig_flags) {
>   		if (!cda[CTA_TUPLE_ORIG]) {
>   			err = -EINVAL;
> @@@ -1098,13 -1109,13 +1109,13 @@@ static int ctnetlink_filter_match_tuple
>   		break;
>   	case NFPROTO_IPV6:
>   		if ((flags & CTA_FILTER_FLAG(CTA_IP_SRC)) &&
> - 		    ipv6_addr_cmp(&filter_tuple->src.u3.in6,
> - 				  &ct_tuple->src.u3.in6))
> + 		    !ipv6_addr_equal(&filter_tuple->src.u3.in6,
> + 				     &ct_tuple->src.u3.in6))
>   			return 0;
>   
>   		if ((flags & CTA_FILTER_FLAG(CTA_IP_DST)) &&
> - 		    ipv6_addr_cmp(&filter_tuple->dst.u3.in6,
> - 				  &ct_tuple->dst.u3.in6))
> + 		    !ipv6_addr_equal(&filter_tuple->dst.u3.in6,
> + 				     &ct_tuple->dst.u3.in6))
>   			return 0;
>   		break;
>   	}


