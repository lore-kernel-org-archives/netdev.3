Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999A46EC62
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037690; cv=none; b=ffOtUWbCTLpFUJWsVwNLcspEhyyKnSGMaF1SRjWoxF6caU1uIqsPRSqSudO+IFX1dPe9MRZVdqOn+TFvhi0Jcc3nezK3XzceGHya/72FbqJMVk+rb/57CATq2F3Vtj9zvdq6UvYvKIzzhy5VH7bv5sDkU7IIRbCIZ304JxIl7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037690; c=relaxed/simple;
	bh=xKvECS4AWJ/NnpQ+/FwuwBj8vEnB+psTFAUs/VtHBb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSWg8vKDNf1c0olFaia6q62EKryMb56mwpPvhYFOmd0Itkx0zpbsTpE3pn+JI3JFKdNc+THhbnp6b/lcEpsD3Rz/43GIro17Gb7BImAd+0m4gfcObw4IJNO/M+wGkotlbl3xRuK3KmVbPJ4YUtvkI3XM4lEGb52lQR1Py93InEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnSp8Jhs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnSp8Jhs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so13168055e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789037680; x=1789642480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=maPLp8fgO9tG0pRsQXjfvEJQO2luldihuXf6kOsu+hQ=;
        b=WnSp8Jhsjr6jbN1na12RUETkmZlKrzObJ2iV9Zz1JmgNzQ8I4BQK1zUGnf/UJHvBlc
         tq47wWP/Xh9g7mH0zSUGIWbbIqJIeAjOtI3obHcKDGHiY5qfifoJDbja1MQi5oLvPxsp
         clZFbkgHIZIAyMev2Zp8e5MRT24R3nYKZSv3kNy0fP0hZkRb1kmVb6XJ990f9Trqjoi5
         FuXTfe03YTLDPUtWZPCAUqEZndCAPZ4CaS+HMKGXnuAtlEZo6P5iBlMeEAefmU5P8bPD
         4JEQ4Yx9BWm76HyXUrUSK7R8Llv57c8YRY7WLdY1Cgxqwp+fYxwnJ4wtiCXYa9In0d2Z
         /rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789037680; x=1789642480;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=maPLp8fgO9tG0pRsQXjfvEJQO2luldihuXf6kOsu+hQ=;
        b=aGZOOOyCfZvT6eLlyRc/bYs2O88uNpXJlQdSd1LA6HFl6T/ULDe2FYd6MB/hjGc0Xc
         jOsiPi+1hq6SxfZ+DqInWlBd+dZ/29CCXHkJ9F2gdanTMauiNHONruf91HsyAHED0QdT
         ogRoeGKrXR5vF2BVdeT6KtSxGm/sadJdvgwRvK7pdae0UmYscWrEPBa4MJcMnuE4VNV+
         HQ9oLBr+wA+XxYWw0e6Fy7s4jeFZ4H3Htp8W5e0opO5lrN2viid8EWTTVKP+L/Y/2xqw
         JJebC4OdD5jp009NzZwJeV20veBZxFHwGOzw7GaivuuJmRvq3rnfrs70f4yBl8WS/y3C
         UQUg==
X-Forwarded-Encrypted: i=1; AKwUvBzU9+Jb0fRzc6FF/7hnLmKXs2wzC3f3QJ9tC3vN14Qh8iJW1AKBlpKfagMNbNlGLzdjmJDxusg=@vger.kernel.org
X-Gm-Message-State: AFuF++kRnf62IQoSN1QTHqTqAlZ+pnI/qcwXUCGvUiqcrCeBBLqhTlz/
	Lt0XP+m60d72pXjVXBo8vFfeNtlXIeIuEc4UDsHPdZuo8IcuHXCjmtNf
X-Gm-Gg: AYBFou33Wk/ak/VgvC3bP5I+icsy3KSRWO7ziYv9WldLCJjoibSl/vn+beq0M9sk/z3
	Mwp1IZ8z9aPOXUtNC6jifBpKPQEyyGrOlQ6pfIixuh1wKrgnFubSSpeaozJ+uubmSbiJwXo9/Uw
	Dv6l+H8XD7hfEsGMTDJGLTYuA0msDT2f/VP3OcPiGb8Wt6cv2ZFhaJYP4zrqnXqpX4MfL/hzQ1A
	rpEPAe2uZPAC+a1YWr/lpmIDXWlrIuCfaiXdKciA85QNqEcYOuxW71eDd4hvx2S78pEc+mE5qkT
	63qY9RdRbf5pJB1OAbcycPuzyVthcuozHnuTB8gf+gTH8+Xn7NClhfH55LIMOsO03Wbk2sK3two
	ySOaC0u0LFGpGIgHTutRutrwLudGkLoyYYYDFXxe10W/dHEPWWqBZIyPmzKG73HS3X0qLH/ajiR
	2KqAdbv16I+QAgbrXPxNzHRAaDP85G56/Q9QfviT2YyJeXKVziypLX9ACv3aF8Tq4JH/X0UX/aa
	71ickGChCbkWKTa++3BFL5ZV8I3tzcIhkBC2Q==
X-Received: by 2002:a05:600c:698c:b0:49c:edfe:d525 with SMTP id 5b1f17b1804b1-49d1f35366fmr250743805e9.10.1789037680290;
        Thu, 10 Sep 2026 03:54:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be64a5sm62886595e9.6.2026.09.10.03.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 03:54:39 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:54:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] ipv6: replace sprintf() with no format specifiers with
 strscpy()
Message-ID: <20260910115438.1c89b372@pumpkin>
In-Reply-To: <20260909210552.51828-1-lalitshankarch@gmail.com>
References: <20260909210552.51828-1-lalitshankarch@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 21:05:52 +0000
Lalit Shankar Chowdhury <lalitshankarch@gmail.com> wrote:

> Multiple instances of sprintf() have no format specifiers. Replace
> them with strscpy().
> 
> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
> ---
>  net/ipv6/ip6_tunnel.c | 2 +-
>  net/ipv6/ip6_vti.c    | 2 +-
>  net/ipv6/ip6mr.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index d5ff50a2ac01..ef3a6d931c9e 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -294,7 +294,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
>  			goto failed;
>  		strscpy(name, p->name, IFNAMSIZ);
>  	} else {
> -		sprintf(name, "ip6tnl%%d");
> +		strscpy(name, "ip6tnl%d", IFNAMSIZ);
>  	}
>  	err = -ENOMEM;
>  	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,

That code is silly, there is no need for the copies at all.
Something like:
	if (p->name[0] && !dev_valid_name[p->name])
		return ERR_PTR(-E2BIG);
	dev = alloc_netdev(sizeof(*t), p->name[0] ? p->name : "op6tnl%d",
			   NET_NAME_UNKNOWN, ip6_tnl_dev_setup);
	if (!dev)
		return ERR_PTR(-ENOMEM);

David

> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index ab94b3a4ba9c..182a7949d830 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -210,7 +210,7 @@ static struct ip6_tnl *vti6_tnl_create(struct net *net, struct __ip6_tnl_parm *p
>  			goto failed;
>  		strscpy(name, p->name, IFNAMSIZ);
>  	} else {
> -		sprintf(name, "ip6_vti%%d");
> +		strscpy(name, "ip6_vti%d", IFNAMSIZ);
>  	}
>  
>  	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN, vti6_dev_setup);
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 3f2ed9b77deb..20ac8cb87468 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -692,7 +692,7 @@ static struct net_device *ip6mr_reg_vif(struct net *net, struct mr_table *mrt)
>  	char name[IFNAMSIZ];
>  
>  	if (mrt->id == RT6_TABLE_DFLT)
> -		sprintf(name, "pim6reg");
> +		strscpy(name, "pim6reg", IFNAMSIZ);
>  	else
>  		sprintf(name, "pim6reg%u", mrt->id);
>  

