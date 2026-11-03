Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745819;
	b=3iA2YM0NiXEa5GImy+Zdei5AryZRo/iyEKDiep43Vbo3nLcW5+FrDHA8qQRd0NRWwdeX
	 KkMA/V6hP6NH8mndyS8mUJm2f5H+iaHm290sFRQlISLH74MhaNQHfqoGFVDFJFyqxDYky
	 hdB8lsGW0mhugNmsDZNYD11YCiL0uzP1kCT2JiwXuJxlOmvu2TNaU7923hWyvfB0cN8K/
	 lpqUcuIxyjbdECRaBlqWEXESnwVlCf59BfFIKYXTXzWoFdyrKyqdNp/MlxiWCyr88v4+B
	 az4LSvvuhzK6u+n1sjzQ2X3RU0kI9s5oy2DjKrkOQvb0iEweqM/uOKoLLoirgc4sriQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IhCBPBTLwLGQ2yRs8VzMKJOKNOT0+JfZ5wDmbhkJDiQ=;
	b=ZYE3lFqlAZj9o5ostSOsX1RLb4bHw68cveJns6yWAdeZ7bYlHHdR2UHCgws4y1eTKbdO
	 mlk8KjKIzdMRUrv5vwNiOHiLXNzF22EpqE0j2ekmwlcZjQSBGsswdIYz7juXzN3EeMj4p
	 n6BlxKJsgTn08P2wh2SIp9XM78+eEeR7DdFKptg4FjYy7U7kz61XZ2fYeRh1bneD1P4XH
	 UWyQ1EMoPiAFZX8DUf8gcPspR5SzgqtMFPkGeJCtluVgNto2p9PgZGyHvv0LCZMeXoFkZ
	 vutnleQqm65LECU7kASBfuFD0UHgp9hFBSbWPk+R8SrlVJpvUR5c7Q2hLzXfW5NsOxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elZzqx0I;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59388606A33D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59388606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elZzqx0I
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso32666eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745818; x=1794350618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IhCBPBTLwLGQ2yRs8VzMKJOKNOT0+JfZ5wDmbhkJDiQ=;
        b=elZzqx0I9zUMK6X1CLUpsfa4tiVNA4Al3XQoNBswiAzn7PdnkFah/8QEJ78wE+73+6
         vcn4lTEjiGv5nQ2lU4XVFQC1Z+iAOcAtw2XjQuVRwOfN6os4LS3pSxrEHJdD49oka5qo
         /rzXXfKf5TyRoI9+yPg0GBcAMdBWGgPmqqBv/ym0Y/GjO99OCCJyxaisq6Jv+KcRwJNS
         kKZs5VE2vs73M8KiLA5B5S3AwP/uag67O7cQCXiUriJlXPwQT/A7NJivpSoGaBtFLmf6
         A1+/1gsnouh4JM/sLtAVWxBkzq0L9Kvfs7iIefUdIAejv+SYym/2GiHcN69H/0/3aXER
         SpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745818; x=1794350618;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhCBPBTLwLGQ2yRs8VzMKJOKNOT0+JfZ5wDmbhkJDiQ=;
        b=UklwvaLtk0tJBe3eOgNXvoLXG/1otlEuV7M6SMA161h9wBSqSPQhHjFMJjbPA8bBrg
         vsiFB22J/rl8JPYtg7yRQCGm19qeCwYUmzO2ovBe5JjhTlOzmwOX8rFfzpMA0dO+Ptck
         kSjiV2pQ4Z7Sgg0FcKkN4NKfE5hSfgYdR+C+qCveDeL3Zp4wHwPmbbzR/fN6m784rbep
         WGAaeFeUNBOrgru5r5Fkl75l/CujzG/tTm6U4uxy1rlXirgPs7AZGghmSqYPEcaTFAQx
         srGYhesiffyL3hmu0UOduuDZv/KCiAIPaWGzJcQXUMdsPd2u9l4jMdxEiKogM3Ak1KKZ
         j0/A==
X-Gm-Message-State: APuU4Z/kF59q01I1WYtHhP9qp7kxqvaRCk4ts1kklDBqh7Z7Qowz97fG
	Rp1Ix0DfTmrtMoND3UNGKe5zcMVzeJj6B91pJcmK0PCuw3PLXAfKDIo9
X-Gm-Gg: AYBFou3L0s37LqYxVeK/kMn6egkZ1oGsIuquecGDEpxYesEB56mi1xH0FLdvLjSEp6O
	zuvmJ0Sgbl3jGzvPPyf5Gl7j8SHsdAYKFOyXYy9+LlB5f34qKX2lgpPAizcBBcsuTHTqFxmuKqH
	s+ShDOro44AY/5cBFx2bxk37xG+V+qxnkD1mZczI5FDMdOgx4qckrBo25eKiTZuxweViTaEpcGU
	BCjle0wYh7Hxfb8mqRqGRXBOvgCSOVK/42CqqW/dsJflYcZt5ZI3vodG6Gd9oR4YeZRKIkRf4aj
	UwqxGAAp0JJvCTKMiollFZDOpuJ1txOaQnI5wc38Ezbh7NoiARIXnwkOCbMVIBx3Z68CRlCNsba
	T81qdcb3qmf6NgPOrFN1/OdKAS1Cz+jd70imbI1arAC4Rw6rygYvnAvm+D0rYV4brw6sC4cvaYV
	NZv1Ms3O3jzGTycE/rjUFPHDAQuvfM5hicLZE/1ISMGKRlDSUlzfuZp4C5X6V+7flPnFeRma2JM
	HDKYNNR3GhTVUCdYhjVXLPvv7a4BkvOTVsu31cur6+CuJYdBFgx8SxG3hE/C+nP1oqDcuksdoFS
	GtPfBdA+gcRuQq5iPjSFxg==
X-Received: by 2002:a05:693c:8204:b0:369:f3e3:4277 with SMTP id 5a478bee46e88-36a424596e2mr23371850eec.38.1793745818528;
        Tue, 03 Nov 2026 14:43:38 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:69::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6d3dsm1323591eec.7.2026.11.03.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:43:37 -0800 (PST)
Date: Tue, 3 Nov 2026 14:42:22 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, io-uring@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next v2 1/4] net: fix skb->unreadable propagation in
 skb_split() and skb_shift()
Message-ID: <aupjSE3HVsbuEzsh@devvm16445.scu0.facebook.com>
References: <20261102231827.4088254-1-almasrymina@google.com>
 <20261102231827.4088254-2-almasrymina@google.com>
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
In-Reply-To: <20261102231827.4088254-2-almasrymina@google.com>

On 11/02, Mina Almasry wrote:
> skb_split() and skb_shift() do not accurately maintain skb->unreadable
> when moving fragments between skbs:
> 
> - skb_split_inside_header() moves all fragments out of skb into skb1
>   (leaving skb with nr_frags == 0 and only host-readable linear memory),
>   but leaves skb->unreadable set on skb.
> - skb_split_no_header() unconditionally copies skb->unreadable to skb1
>   even if 0 fragments were moved to skb1 (k == 0), and leaves
>   skb->unreadable set on skb when splitting at skb_headlen(skb) moves
>   all fragments into skb1 (!skb_shinfo(skb)->nr_frags).
> - skb_shift() neither propagates skb->unreadable to target skb when
>   shifting unreadable fragments into an empty skb, nor clears
>   skb->unreadable after all fragments are shifted out of skb.
> 
> Fix all three cases so skb->unreadable accurately tracks whether the
> remaining fragments in each skb are unreadable.
> 
> This issue is theoretical and was found by manual code inspection and
> LLM review; it was not triggered in production. Verified with the
> net_core KUnit test suite; not tested on real hardware.
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
