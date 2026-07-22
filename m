Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C1442B04
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743158; cv=none; b=bUkFbCSzGZleAL/B10Jf8Dus8lPTU4sOpmBpVS147NFeR4x3amQHmXOAvTHej3x8Bv3x+n9IjsqtLFQbJtPzhiMZ/3rcI5cwm1GFaay5cdEA2z8jEitSNiticZlKpbj9hXoXvaSWIoXUPkOT3CouQPIbSgvWOkPIBNWJev8ZRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743158; c=relaxed/simple;
	bh=Z2h7peujV2pr8EL6kKYt9wNPM/H8UeNQCzuBzwm0t4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei3JPuFdZT7+q+mZYjqzQ6RyPbyz7+8K+w2Fh8OKTd0sY4SJjwOtjKQOpyu/dxdWMTe5iGR75/OdgQYqSY+NIBxOjALdgaCnedcBaz6HV3JL0mMniDhEz9uf9Dq2ea+vF+NqiSjkehrNlAOM8MQt8IYB37cWKwQ9td7cgE1+HaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/NxZk4A; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/NxZk4A"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so9719991a12.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784743153; x=1785347953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aMxgZWcBXr59Z4+lqJhvUfRMoXmVJXAUBeK/HKN8tdw=;
        b=J/NxZk4AvaldWDwp7fBv3BWw6/axkGw/L/SS4iAOiNmCDy4C6pyk/73vASjvUaf0f6
         JuxDOdIABbMtxFcWbRUgYkBO7rJRnVU4hJuMCi3IVNiY1Mab/JO7xHkJ9Yir21m3ZWX/
         2X8ncxKXQ/NXxWANEJy+ql684PILZmeRIt3O9Gr8h07NcvmbDXd0XbO2/nxt3ONins0D
         pn8qf3Z9EiYr0TJ7hevO2g7WeaXJXHoTDLjdqNtyAthR5xzgEy152KiTpPPugagRrUej
         GCHyZlm4tFAvhzuiEtYZ975aVMywms+e14ktN0q3apmmQUCpZVOOKNOcNjKjcA2KDGRo
         sF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743153; x=1785347953;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMxgZWcBXr59Z4+lqJhvUfRMoXmVJXAUBeK/HKN8tdw=;
        b=n5lMpfVNVv7m/uVSkJH0owGp4Clcs8CTARhVRhKt6vIIzg/+dN6e3WLVbrlQ+yn7Of
         shyZLgrZrRGBn5qavo7Sjd1CBZ9OYzYlftLowBwRUbamyEauz9RJ8BXX7STAxHk6VvTK
         ZsemXdyA6nArDVubh1G9O4C0qPalElBCaSI1NbY3IKa3p62dQ+pCSkm71AUsNOP2IcmY
         9jhYu+DPSJgN4bNOseShIAN0EQ0bmBAxY2ijC62ZFKaw1yv4yon5TtRqS4/3A9ONzRAZ
         3Ug0NJMdsnbE2cXxc5G9N0qSuA5QykUi6qPH6gPHqnKT5kYn/wxv3mG7s5lUEDPbOB3H
         b85Q==
X-Forwarded-Encrypted: i=1; AHgh+RqPb4WZM/xLbEtILGecvCN4DyWGbJz1WHPYQVdz/0sqz//4yrxFcF46vCWnXSen1CjRg07PRZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rXJqv6wnXfPE8gR9zH2JrI3vinvxrkhhGleeFK76hZd1qqSm
	i5DnC6VPDUzn793DN96fhBZoEjoLI6IFQu/2gunQipzNzPRcRH40W9Zl
X-Gm-Gg: AR+sD12MdmgyPswSCOKm6xRQezAMsz1LobxIvP+cuCtZL+NTNSVWDd1D2sgWfbtBG+n
	hU8ShSMkdh1PuxLSYmA0WFV4ULxPjP7Ek47y+2EZplT0cxrChM4uoQuqWk+MsHVJB/9ppHFvg9A
	bkn+u86oA9aJflfUaMxa3/agHBlWknKE33f1sDk4tNwINYzWLPbWJVBEfoj8iSLGpmEecyDCA6P
	/LSQ5bMQ5jr1e0gHPX/Of9y7DssZOUvXHA5lZVJnplIwV2YBgQgTa423YGWpN2wO/HzHwx5qAWj
	OH5uirooK7DPY1hGr4VtNoIdGCO4fsOfsj3nDWXhoBpTLi1FRs2Sm6o1Z8QLqYu0BiJ42QQuMmA
	7vt2aY04YptL1QuHDHwauVitx0ZtaGKfcUEfI9veUmOe8mhYdadOnP8oOe8IMecVUAxiLgg8gOy
	+iLgwBTu717aPdxTPl0QKCP4s9LAGWZvjXyw==
X-Received: by 2002:a05:6a21:101:b0:3c3:7df6:536e with SMTP id adf61e73a8af0-3c3adaa1ea8mr29500794637.67.1784743153160;
        Wed, 22 Jul 2026 10:59:13 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a884esm1556276a12.23.2026.07.22.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:59:12 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:59:10 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
Message-ID: <amEE7qImKgy4sWKf@devvm29614.prn0.facebook.com>
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>

On Wed, Jul 22, 2026 at 11:58:46AM +0100, Pavel Begunkov wrote:
> We should either have net_iov or page backed frags in a single skb,
> otherwise it blows up down the stack. Don't allow mixing in
> zerocopy_fill_skb_from_devmem().
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  net/core/datagram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..35febc1c25fa 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>  	size_t virt_addr, size, off;
>  	struct net_iov *niov;
>  
> +	if (i && skb_frags_readable(skb))
> +		return -EEXIST;

Are we trying to hit the -EEXIST handler in tcp_sendmsg_locked() so that
we start a new skb? If so, I think we might need to plumb this -EEXIST
case through skb_zerocopy_iter_stream() too?

Best,
Bobby
