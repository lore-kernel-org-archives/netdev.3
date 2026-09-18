Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFF282F34
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770911; cv=none; b=WL0NXtyVMNuck7Qz7r3foVmG6OGJcVwcnw8DnYv0pwV1122KTpztPX6Ymh8QQnbPdN95aDy6ZnKYDm+tXpH5upq4dI4znNum+cKp+y043Ar8pg10oiGSFgSbml3guOIR4XUsiI1gs/HitvR/E9MjNaN25JtQ5T6r/83OdrOoJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770911; c=relaxed/simple;
	bh=xb3is1fg4psSzmWQVGNvDz1BjKNyE4uEP1bxnTlEH8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alp64TKsqoL4wtZ8sN52oAzwp+mrd7KjfuJY3zJqNx3ZNN4hnHia6/mYFQNuI0WjA9e+E/E/p7L4cEgySLqtI+k1sVmejhbAoJo1x8+oKmhNKn1VHhJ77SleeqiUtJxqpXNwzfj+5XKyvE6WNt2uUMt+AWDhHQWe3CP1cMkrgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o728Ieje; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o728Ieje"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1177524a91.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789770909; x=1790375709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D06tmXj1uCfo6BIbxIXyOm4hxr/YiUTBkFpE3eRGCw0=;
        b=o728Ieje85fiV2UpC+/ha0mSSzmSr50+AW4ZUZErNf8FkinKLRZfwibZUmlMw7KUMH
         2rnZN0e0XHnZjgl3kr/Q9CF0ec0EqgYdTJfo3fZz97bF9Rfpp/QWtl3JKgdRZtKDSX/y
         TOkJy0PBUAG+ef9FnN8Ww/NB+hHL/BeY7DJP3LjWTzE1I2x6wAGd2PAGEqwPF853Xa6L
         8rqw+0RmaCIxDu2Oj5cYb/a+QiQlZEY75/y7kIDy5JpP92QF5J5+seI/Sp1B3P8QMANB
         fZJwD1PsDUBARBND45bqZYwtDr31Luo4J4QtApXNuDzsrfakuC+zCB93XeeB6DWvAmye
         QCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789770909; x=1790375709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D06tmXj1uCfo6BIbxIXyOm4hxr/YiUTBkFpE3eRGCw0=;
        b=W2iT/ROloONNEX8tFtmS/tHjFXKzrJtHLGwea6xSnhIMoJ/fLj5TnkbuLTAoa0zppa
         pQ9eY7HFGjzUm6UiX54nSFuKlcUagTstmGfnTparmhGnnZXhZu0z78A9WJoMDM+XehQb
         49alK2aPuuzUld3liHDXt3H0y6YzdTdMAAgl4eN227RuhOduuUYB2WR3J2RdfvIM8X7q
         3kWVhG5GfwYd2Db3G7YU+pfU0g0qt+ydk/4fVNeE0VvH4Nc3X9ccgvG74faEfuhIhYHv
         +WPmD3eChLZwxOWF3ORCI5BSM73jDKs5R0LHBn7GOZX5mOOXQ8IfDdOHzYbonEWY/d8Q
         U39Q==
X-Forwarded-Encrypted: i=1; AKwUvByEsnqD6aZtRTRpiOhoUg0fJTLi8AInehorycAPc8rkD0mUivsDiWsSj/wRCZ+8bBydE3vC5vE=@vger.kernel.org
X-Gm-Message-State: AFuF++mAxYrItc06Nzdhwk4HZzxMt9sMBMTy1FcfZzfHqQjEYL3uRgGA
	b5+rbiE7c+Jei0mg55X2En3g357+y7xG6XeL0d3pY5JdmtjelgXWXNvkwoM51w==
X-Gm-Gg: AYBFou19U/Tl+6NHl3WgdkCoqdvtE6edHbfF9hPp16g17ydewc3E0ujLQ2rTUIdMWJh
	JG1VbexUZfiSWWXDWO9Q6EknC7C66B2JC5VEYjpQeN5yy1tF0ZtWqGAp/CiaY+YiqNtPmwF7DSq
	NMzars6/rjQDBHRNT/x708WRVmFSOfWNi4FmZVbc5IkiQfuVTucceIMD3ClBHFRY+OswfCM646S
	KXo94xid7s19MxXD0t4DUvB3EuzSsXgrGRd94nJXFNbcZKI8fn309QR93HGarWrJVkk/VNbQ/P1
	vsnfeCMsZZbBE0XILtxEyNotyuuATQZ8OVfsmuhT+JSzkZVT0+FKipzVBTkYEXhykDAIAkpnXJ3
	vgoIjr4cKOuK8vTzn11iOy6ku/rbvlvxqcrZutAH40WUCzU9aZlJ7bKs69ikASTdKY5I5NVvds/
	NOKeVhJ8kEz5pMSpglE0AsqmdhJKfTDFlGMITAD4SvbbPWvy+z7boLSjqOwEhnnsjDy5czNlB7k
	pkwBgg/UQVRxdrtEw==
X-Received: by 2002:a17:90b:134f:b0:39d:febe:7460 with SMTP id 98e67ed59e1d1-39e54d3651cmr7716214a91.22.1789770909387;
        Fri, 18 Sep 2026 15:35:09 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c379c4bsm1375753a91.7.2026.09.18.15.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 15:35:09 -0700 (PDT)
Date: Sat, 19 Sep 2026 07:35:05 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH v1 net-next 0/2] net: Disallow buggy TCP transitions and
 IPV6_ADDRFORM.
Message-ID: <aq28mdNpi3ssjgXz@v4bel>
References: <20260904033543.2635540-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904033543.2635540-1-kuniyu@google.com>

On Fri, Sep 04, 2026 at 03:35:27AM +0000, Kuniyuki Iwashima wrote:
> The following operations have recently received a lot of AI-driven
> bug reports:
> 
>   * listen() + shutdown() + connect()
>   * connect() + connect(AF_UNSPEC) + listen()
> 
>   * setsockopt(IPV6_ADDRFORM)
> 
> They are not worth fixing by churning the fast path, so this series
> disallows the transitions and removes IPV6_ADDRFORM.
> 
>   https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com/
>   https://lore.kernel.org/netdev/5832ba17-c096-4f07-aa73-2e2bb6f79856@redhat.com/
> 
> I did not add Fixes tags, but if we want to backport, the tag
> would be:
> 
>   Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Hi netdev maintainers,

What is the plan for stable backports here? Does the uapi change rule
this series out for stable?

> 
> 
> Kuniyuki Iwashima (2):
>   tcp: Do not allow buggy transitions between ehash and lhash2.
>   ipv6: Remove IPV6_ADDRFORM.
> 
>  include/linux/net.h                |  2 +-
>  include/net/inet_connection_sock.h |  1 +
>  net/core/sock.c                    |  4 +-
>  net/ipv4/af_inet.c                 |  3 --
>  net/ipv4/inet_connection_sock.c    |  1 +
>  net/ipv4/inet_hashtables.c         | 11 ++++
>  net/ipv6/af_inet6.c                |  4 --
>  net/ipv6/ipv6_sockglue.c           | 87 ------------------------------
>  8 files changed, 15 insertions(+), 98 deletions(-)
> 
> -- 
> 2.55.0.1003.g10538fe699-goog
> 

Best regards,
Hyunwoo Kim
