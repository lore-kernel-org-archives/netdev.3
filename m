Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028E4963B2
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771345; cv=none; b=jpawA240J6fdszkmccjnJsrNmuHcIH+5lpuc2rnUQ/I8HmOWntxRN0Zxp+VGA1VkHc3gYngWDSpstz10oEXKQ8BxjXM5mpxn3g5JeWvwj7bk3RfZabdqQv8BEgzWHKES31Zgs+4tPUiaEsrPQrtxA3C1ND23FumgHbPYRMv07og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771345; c=relaxed/simple;
	bh=wG2mMLIJhp0/44FsuwS/QTfDrgmWvzBVXbJyNWr/eTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfXHLZSOvpXx7XEQnXQ2l9LL4x5aYy631ycZA8iFySzrY9TSbbpkiLd8etHyqNcYK/hoslOaiy+rCz7TBTD84LBRIVIFZGKbRNo8LQJBpHOjgQEq0glgwgNKBrHP/dwiI6tDBn6jjvLUQZGumQt0Azk4sY+qgkEl9LQZx6xruHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9ZilC2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9ZilC2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531411F000FF;
	Wed, 30 Sep 2026 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790771340;
	bh=FDHBij0drzDs1JEAV7Z7bG01VjSdaIwWnBWeHN1aKOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n9ZilC2DIFyW6x18TWYVVKN47ZVyv5zD45OZ1gtU9m3qA+kEZcBAsloqKpa3s6UrJ
	 g510qirFbKwEVJgUNjj39CDTcafbhaywpI1DO/uJ2n8C7MQjBNVo8fYZVhATkOF+7b
	 /vyU86BlKO6HELhdeFTjBC/OBogiwYX5wZwnpcr/sGcOnmcnqKSQobo/zJ9CFHkcUO
	 K0bttsCCaTMAOb/hVLaRfNUyoT0ecnn53hnODSNTLnryYPepqKWZOflGae9oRC3Wlv
	 uBcBXMhHNnhdPcszGw3+LtPZB+9Nldix8uhnY2KCsCc21+vFIUnAVifJf7uhYrRCbK
	 DKierjnuuUfkg==
Message-ID: <a6f0e657-8674-4216-a1aa-88045c19643b@kernel.org>
Date: Wed, 30 Sep 2026 06:28:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ipv4: reserve one IP ID per segment for UDP GSO
 packets
Content-Language: en-US
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, edumazet@google.com
References: <20260929131247.401104-1-edumazet@kernel.org>
 <20260929131247.401104-3-edumazet@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260929131247.401104-3-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/26 8:12 AM, Eric Dumazet wrote:
> @@ -1464,7 +1465,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>  	iph->ttl = ttl;
>  	iph->protocol = sk->sk_protocol;
>  	ip_copy_addrs(iph, fl4);
> -	ip_select_ident(net, skb, sk);
> +
> +	/* UDP GSO packets are segmented later (see udp_send_skb()):
> +	 * reserve one IP ID per segment.
> +	 */
> +	segs = 1;
> +	if (cork->gso_size) {
> +		int datalen = skb->len - skb_transport_offset(skb) -
> +			      sizeof(struct udphdr);

hard coding a specific transport header in L3 code is crossing layers.


> +
> +		if (datalen > cork->gso_size)
> +			segs = DIV_ROUND_UP(datalen, cork->gso_size);
> +	}
> +	ip_select_ident_segs(net, skb, sk, segs);
>  
>  	if (opt) {
>  		iph->ihl += opt->optlen >> 2;

