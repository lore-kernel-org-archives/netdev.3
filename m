Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DC4756C0
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121082; cv=none; b=SmMNX8jCOdufcSbUkJUA/+KU8sCn+qpbr5ythIVg3lydk/Dqkgib2mrdwf7xwOhtit5sBhCL2LpdGra6/CydVlrjSH0Qo2/CYyJ8OUWjAa/Iq/TOYFvFczx+uUkN6nivKu5/eDWfYLHrJ4sO3/MTXjYTDHOgnanVRLj5T6Gi5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121082; c=relaxed/simple;
	bh=+LbwcBxTcVL6TE8Xa7VF9oYYHSPpansJnznnqPEwo64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKYPLzzNVSvGZGE/+NszIpbqjovzqlx0BeLDDjZb7qJsb6TKl2NZUfWLcRDWh3gRX9EugDJ2OBZCPMlHPnQR1PcOlGTbwCq3cz2qMiXc5gNEQN1aaCyX0AH3cmWFFkFx+vjm8Y4RKMk63KH29SwuguLocgfiVhZHyBVWPiKAt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8PSHLQH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8PSHLQH"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4798bea72f9so2244360f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121079; x=1786725879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vPWw2J266KWoCzUTs7KvPsgaoOdOp2O33Cr+Xyu+Z4=;
        b=E8PSHLQHGw/j+CuTVIAUl805DcGbM3iUEG+Q0rGXNZncL7mb64gaQJxPAXW1c/IFDn
         WsVjQbdDOhlsEZW2eBXj/sjRb4ba5FyTwVEC+scdS+h4UdXwMyaSchYYUiOR/TfW4UXG
         GRUR0VVXHeTjsLzixoECwg9EJw+5t/hXyt0YhcX66bbdXZ8/B2NaA+ckz9vZqHhZ81o0
         htYBCUOCSqddVBGlb/pmmL0Qy3wIXiaQxyhgmvT3vVlfF8o4SKiovNP+oQFoBdkvlyDt
         OrPRdt6Ue/kK2nnr7i/YSLwmdIaHLeKfeVjJkzWUldB9KcepD8AbK5K0nfgasOasMCgu
         MP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121079; x=1786725879;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vPWw2J266KWoCzUTs7KvPsgaoOdOp2O33Cr+Xyu+Z4=;
        b=EtBQpVQ/kZjGcV0a/jZZuiTtjLYJsyvHCebhGIQs+EMqzNI1QD5YWMXRFNjjiCCD6x
         itw2EgzokESXPje66Qbu/ZEAf8hdk91bwVjeNBxdjebVyNXcxEgYSPSsMqT73qA9Og4o
         YiWZisPnz8xrD80n5XqMcRv6p038V37WXF12X9qbOPjWNy8nx+27DAdlN70D6LjGfbeD
         vobrQTP9fVKjglOLNCXaRWwbpjqFYRKFdYrds/fsJhpMEJkUQllV/NKs72Kei8Qo5S11
         0YItxvC3XvIUzOXhvM3Rn4ndJOp6/iPUu2t3BLJtorC7hxCnzidbyczvdLPCY952Ufep
         ljIA==
X-Forwarded-Encrypted: i=1; AHgh+RqGg+d6/1MraerQAtKqVKftKqbHR64C7x3kSI7WwLZCQjZKD2dvrTqOd1UK8+XGB++ds56E5Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeo4gTcu7NeXr1jatFXMr0Va9zvSmZmFePaif/XZ9KBSDkKBae
	9k80wBHtLsM/RRXD7oNxK2TK9Q7SjaTlVQGruGXq2equFyW4Q/uvUCYK
X-Gm-Gg: AR+sD13knV/iKAMN5U2C0yIX5ikU9xxudt6uZoIIdgifyV7BirMsnpmqDG0n21FUS6K
	89iKiFv3WRIOm3ZNY58+7smEia5UlUzZgdMM6ZyA98OiNAjltrsXv84dqzn6LZNX1PRh3sQ+SfY
	IRuRjGyRIH6kORVwesUmWy0UDy8AcpN5BraGRK4Ej9OT0HGQqF20Q+iY1PBoPFaVpH7dGvDdi4W
	GbLlkzrwqEmiUWXmcARlWVSXZCsnHm100WmUxIPt4YCf4ybFprDp0MtUSaCt6nC4ylVjQO8MASF
	QiknAxbr0UUNBc7aeIFCIdGqg9R5IudizfcrLQ3OSqxXZQ79JN19vJ4CjCPjIqOli6v4+B/Ityg
	EyNVGD53uog10stG+0MM6cvi4Y1wzFgzseFWoCAx48YCmwEAs/zKtVb4iBodiI2Duk8gTZJx8Yu
	l26+4cyGe44mri24vYnp3JRyGenqkYuj+oYawZnbZgCQMIhDNYE2xKDjRz5LTW2sELFVBzVJlS+
	6bpZxUYG1hAXmhqfsJrIB9A+fDCbDXr34X+
X-Received: by 2002:a5d:59c4:0:b0:47f:4919:d5b2 with SMTP id ffacd0b85a97d-47fec4e887dmr36634353f8f.1.1786121078631;
        Fri, 07 Aug 2026 09:44:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8cd0sm7470652f8f.17.2026.08.07.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:44:38 -0700 (PDT)
Date: Fri, 7 Aug 2026 17:44:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] ipv6: mcast: do not write past optlen in the
 source filter getsockopt
Message-ID: <20260807174437.01bf2e33@pumpkin>
In-Reply-To: <20260806-mcast_fix-v1-2-bed0a5518e57@debian.org>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
	<20260806-mcast_fix-v1-2-bed0a5518e57@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 02:42:01 -0700
Breno Leitao <leitao@debian.org> wrote:

> getsockopt(MCAST_MSFILTER) on an IPv6 socket overruns the caller's buffer
> the same way the IPv4 one does. ip6_mc_msfget() fills the source list from
> the numsrc left in optval, and nothing compares that against optlen, which
> ipv6_get_msfilter() has already reused for the length of the reply.
> 
> Clamp numsrc to what optlen holds, as the IPv4 side now does.

Nak, same as IPv4.

	David

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ipv6_sockglue.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index b4c977434c2e0..2c3fbde7cb058 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -1012,6 +1012,7 @@ static int ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
>  {
>  	const int size0 = offsetof(struct group_filter, gf_slist_flex);
>  	struct group_filter gsf;
> +	unsigned int max_numsrc;
>  	int num;
>  	int err;
>  
> @@ -1021,6 +1022,11 @@ static int ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
>  		return -EFAULT;
>  	if (gsf.gf_group.ss_family != AF_INET6)
>  		return -EADDRNOTAVAIL;
> +
> +	/* Number of sources that would fit in the userspace buffer */
> +	max_numsrc = (len - size0) / sizeof(gsf.gf_slist_flex[0]);
> +	gsf.gf_numsrc = min_t(u32, gsf.gf_numsrc, max_numsrc);
> +
>  	num = gsf.gf_numsrc;
>  	sockopt_lock_sock(sk);
>  	err = ip6_mc_msfget(sk, &gsf, optval, size0);
> @@ -1041,6 +1047,7 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
>  {
>  	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
>  	struct compat_group_filter gf32;
> +	unsigned int max_numsrc;
>  	struct group_filter gf;
>  	int err;
>  	int num;
> @@ -1050,6 +1057,10 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
>  
>  	if (copy_from_sockptr(&gf32, optval, size0))
>  		return -EFAULT;
> +
> +	max_numsrc = (len - size0) / sizeof(gf32.gf_slist_flex[0]);
> +	gf32.gf_numsrc = min_t(u32, gf32.gf_numsrc, max_numsrc);
> +
>  	gf.gf_interface = gf32.gf_interface;
>  	gf.gf_fmode = gf32.gf_fmode;
>  	num = gf.gf_numsrc = gf32.gf_numsrc;
> 

