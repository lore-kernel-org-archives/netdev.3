Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B555419FC3
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551711; cv=none; b=Id8S7W04PlF5gTqWnp/mBsb0+Y2aweFPdnsDlD0bDPQrTSwx9RTootYSjU2KbhaUcHptjFIoNglz59weboG1byf1ZX9CNPtKZRJzluBzG/6ikcWbgRgRYYyRXg7o8XhVB/uNPwlwXa/Dowm1TQRSzAR9ozyJAZvBYgO10r917kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551711; c=relaxed/simple;
	bh=N+9ZTE+CayXuFy5Id8G4dwE2VT+tccB0IvDa7S0SoEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHw8Q+NWE78EAmzCz0EWMoRvcQSmzWxOX0eCRFh9X1ja7zKh4Htfx5U4EhJe5XTP/QujOmK731zJ78JFG3+Cp8e8RKOJD4aM9ZYde0MMaDmKeMCK1P7DONH5zcSlO/PC61obRcvWscV2kXS9oTiVaHUzY7WbV8YcbMxARdA8CSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=eUYr3WeE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="eUYr3WeE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so59794495ad.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784551710; x=1785156510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddopxXSq+Kxxg3/7llv7uobPDFFxIZ93j3ihboSU6WM=;
        b=eUYr3WeEmcBBtngiiLo6kxI9d88a9hzbgIRU/Dwble8XPL1pHmh0bPUxk7kZNSYkvr
         1MZ4YOcqW5QGClg5bfTabbbiR0uWVRdRiOxXQFFBOuvuYFAvmo9TVbdqi4A3T8rAVu2P
         2Cd5NkRM4R6aDOM3CbdgjA1JYrjI7Hg6FUry2+gGPsaGJdDm1Isxq8IgvetaYUXu+RbO
         3QjIQ1++/RcJgJDfIWV/4fPXHTkG/scKI5upWraeAQwOfGeZK3pOGzDuRxV1G3wfCWSk
         oIVSJbqUCFt2dXId/HwQTSarmZVWctcW8qGCVRj7w4HjkgHhBu25JaYndmuFqPGP/iXe
         8BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784551710; x=1785156510;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ddopxXSq+Kxxg3/7llv7uobPDFFxIZ93j3ihboSU6WM=;
        b=m6+7ueKO+ZZkaMOSRjUcOWyNEraj2qP2fqUIvnBesOslBOMidQ9K3t4b+JMh2GALAY
         1U2zPc5oU0RFDbGaaalgQMHs41oDpF9yzs154fxJkU1sCl4d2ekknxQIl1GDld7neqCo
         xgAWopYXRswS7VJTpt6h41m/V8345JPsAPzkv5qxauOya3VILzBoRlVfZk4Tvd21pZG1
         i4P9hXIiEXPjlm8kfl7fdzK/ELf/zEivSOp9ALIHlLEt4MUp21XQGOYsaiUTDjyrBlK9
         IWAYnJLAf1DjWsLvYAWVWhNJHtMbpCtGtlVAbcBSrwtMph3R7c9dkn7GAZBJbS0dKjff
         HGYA==
X-Forwarded-Encrypted: i=1; AHgh+RpVi/hvCsZPyeQGAreibGNHzkTvs9quVRSVMecCYzmE0H857ybwmvrf5t61fCzb7eiRQfRBldw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYdYS6ApKeBbRfRYvchUIHjeEAZZGgK2NYXCIoCleNu2onyEQE
	QkEkEc20I1IR6kG4Sr6eIa442vmJSeMrZ8xDdn/8GRXBOnrRLFSeijWBAmJbVSSnsEo=
X-Gm-Gg: AR+sD13e25ZhyuabLXbXxEhM8oEKsB/5fcD1bWzW4U5pPSNHnrMwa99l6pAzH2nuq+9
	w+Acm7vQa3sYW927ihDkt0MKX0rM5afFGxjPzdUIrzgixSXwpEkYH/rEHAYnpFug0H4kdQcRvM6
	88NRsYhy1QRl5hbRl3yt9nmBTQaEjLHnLSek7nvkLEP2/Zsn7hO+c7OvMmI3GL+3xncrEuJ/ef4
	aDzhFX2+5EyhiDyhvh9NOu7pLiZ4Ek9Vtb0mFf1w63u+I5zssbK1Ox2DcCMofSJ58SUyJHeWV7Z
	8NyZ1tsfqF0Sre9Iah2mcx/w13wmru4qHcBd2zGsKxzrapVnJosTeFv/NE2vXV0FKIteuyEzqPf
	Wt0Rf4VNIiIMBn0+zjWaQqQKjyLyRhECLDZf4idC10SWk/nrHJHCd6xCtZSQVgeCa7z87
X-Received: by 2002:a17:903:291:b0:2c9:d8c6:1db8 with SMTP id d9443c01a7336-2cf3496c0c1mr141277275ad.28.1784551709723;
        Mon, 20 Jul 2026 05:48:29 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9f9dsm57557185ad.41.2026.07.20.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:48:29 -0700 (PDT)
Date: Mon, 20 Jul 2026 05:48:28 -0700
From: Joe Damato <joe@dama.to>
To: lirongqing <lirongqing@baidu.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: fix dif and sdif mismatch in raw6_icmp_error
Message-ID: <al4ZHPdZYTEWckkk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	lirongqing <lirongqing@baidu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260717143230.1836-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717143230.1836-1-lirongqing@baidu.com>

On Fri, Jul 17, 2026 at 10:32:30PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In raw6_icmp_error(), raw_v6_match() is called with inet6_iif(skb) passed
> to both the 'dif' and 'sdif' arguments. This is a copy-paste or typo error,
> as the last argument should represent the secondary interface index (sdif).
> 
> This mismatch breaks ICMPv6 error handling for IPv6 raw sockets in VRF
> (Virtual Routing and Forwarding) environments. When a raw socket is bound
> to a VRF master device, raw_v6_match() fails to find a match because it is
> not given the correct sdif value, causing the socket to miss relevant
> ICMPv6 error notifications.
> 
> Fix this by properly passing inet6_sdif(skb) as the last argument to
> raw_v6_match().
> 
> Fixes: 5108ab4bf446fa ("net: ipv6: add second dif to raw socket lookups")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  net/ipv6/raw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 3cc5869..b88d364 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -349,7 +349,7 @@ void raw6_icmp_error(struct sk_buff *skb, int nexthdr,
>  		const struct ipv6hdr *ip6h = (const struct ipv6hdr *)skb->data;
>  
>  		if (!raw_v6_match(net, sk, nexthdr, &ip6h->saddr, &ip6h->daddr,
> -				  inet6_iif(skb), inet6_iif(skb)))
> +				  inet6_iif(skb), inet6_sdif(skb)))

Looking at the commit under fixes, this does look like a copy/paste bug to me.

I wonder if a future contribution would be a test to exercise this path?

Reviewed-by: Joe Damato <joe@dama.to>
