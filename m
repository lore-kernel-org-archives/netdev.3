Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904DD4CDDE8
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672153; cv=none; b=GfWxGogN0xqQSS4vkOfc4FvbYuqmPcnkrrwSwcgEj8e0h43d7pY1e4D36/NUfvEoQOjuqoe36VnqWD50YUeqaIvgcWW1aSUKkxuf0QITOM2V33b1Bd27adl9EygMPFTa9k4Fx/OzijzX+fE3AVWi9fc8iNprJETbUSVQ9f/MFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672153; c=relaxed/simple;
	bh=Q4fDDhH3Z8JgN71X9oU7Qq69MFEH2EgdxOXf9uD2UtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ov3TExPwBglxchUMn57JjNy/5oaawCw6D+Uw8jEWyfdQdiJUK4F0M5+xFliox0k83yz6n11Kwsv27dY33890RO7Q/d82KReLP6gjU4WavJnD6ZBgP6VlXCssV4vhtGKmti3cNRORbWOtcof0mbzybEQWc8VmWii/QxqjvDxyGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpP9aaAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpP9aaAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ED51F000FF;
	Thu, 17 Sep 2026 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789672151;
	bh=9bmUONqwyUlmKEcE3poN+tvONnv1emUWwYoOD5jclLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MpP9aaApxQb8t1XTIu1Ng/3Dg1QJBbNcnuc3vjKNDrkG48yX4ygFso4D7CQRx9ncd
	 yVB8h/W305LrcHGzZ4X2ejxuBvux/Yw/+/vmudhf9DU1YkRmv9IMfjXUEpQ+zgVKB4
	 mcS8+yUsSDMdUzw4TOJTakL6gdsP940a0PccztEjb4g1vrElSPbGpYiSOBJj6XgBP6
	 7MtRiBSewjRRUN7sgMC5tZJHNWaGgbJ5tcd7aTfbgRYNjHKli3FWSDxySDVMHWCemb
	 DZGj4Wu0+CnnwhcnrY9BZ1sREt2dkfMi40p1JTUxkbWPXNxRozV1fhWycFRMo1+24k
	 NFroeAY4aocww==
Message-ID: <58147155-1763-4e10-a3af-f8751c1505d5@kernel.org>
Date: Thu, 17 Sep 2026 13:09:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB
 changes
Content-Language: en-US
To: Ralf Lici <ralf@mandelbit.com>, netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
References: <cover.1789639346.git.ralf@mandelbit.com>
 <65f8ed83f2aa154b985731c10c6c6b20060dd198.1789639346.git.ralf@mandelbit.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <65f8ed83f2aa154b985731c10c6c6b20060dd198.1789639346.git.ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 4:09 AM, Ralf Lici wrote:
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index 7f69e8890b5b..a28974cc36e8 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -250,7 +252,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>  		dst_cache_reset(cache);
>  	}
>  
> -	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
> +	gen0 = rt_genid_ipv6(net);

this detail about routes should not be buried here. rt_genid_ipv6 really
should be local to net/ipv6/route.c

