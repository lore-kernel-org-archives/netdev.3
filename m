Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2540B109
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275524; cv=none; b=nx9ROYkSv1j3c0zxpYcYZOiE38pi/QDH3SexVXk/odPEAKP1VWVZfXgbmBIOd1dj9k7ETymn79paSdJ0GyXao3rSgWno+aDabnwP5H+UOO32nV//AErvGrWeTgOkjq840xjXTU1H8A8mrMgMc3yKsiE3RPO48TYlYbqAY8mWo6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275524; c=relaxed/simple;
	bh=T62LpPJN0ck3TL808JRXrDukK+psEpSg0at2nWHO5t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKpDVGGUnTQLmvAlQlbF7C4GnNtYQU+eDcsXGGnrgCsT+TeaN4bX30eLday4UOiE3jRGLL72t2RUpzCIVxS3zGEGIZFuCaaegJU8eXLkLEplX3+Ly/HUfW+T6IYZuoUr2OmlHUOn/f48C2VIQtIuEIv5JNvQL9yUJCQFz7Y1aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qU+pNz8y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qU+pNz8y"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce7d2adef4so5016695ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785275523; x=1785880323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RicKy7wRKMFJKZWyD4sW8NJN47udmPE0cZHUVuqyc5M=;
        b=qU+pNz8y2YNMUEx6rELLakiHRe3SOzfi1JphcdFxeD4axYbzF/LKKGcU9gu02CnFeU
         33SKiiN+tmtY/icB4ZQX8hPuXkHmMeOtuc180waEwwydN6LlUiLda4cgtDqynoujmP4M
         RzyYNv0ByU8pvm0SCHepPkbMjcOW8Ncaa6Ce3YccUb9lqDwzqpp3yhvybX5jFyhv0llk
         PWJBfM2/PoYHfGzWe0UUFITD37VB3liC0I7FhgXEJqZXAZK01D0D5FJt9s+tz88guRbP
         pjzoCurLXOX/M640SOefeOewwDWXwdA3loTfe01Kcs+sZBAccPazsNpt+7buZ4sbiHd9
         n2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275523; x=1785880323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RicKy7wRKMFJKZWyD4sW8NJN47udmPE0cZHUVuqyc5M=;
        b=NztA1YKsjok3I5sSQMoSsSQDmEwOq+uS7m/axydkWqEMKdeNPUraETMmgAMQuEPrNz
         yJOwRFa3mctq8nQIgoLKSm4vKTkRjaxlncLjKTDrPTBGaD3Nnf7Kwp2AWT50mCgVLwAq
         Rx5cBXy68XVG05qjBuQgo9zQlHV7+MQWzhkz/H6VNfjHOZOEu7SP/Adpykf7r1rlfzMG
         6pPD/2TNY68JduS6ljURNx95V002sV6lUw0kLzuqgObYNOxJdgI4sOdT1WNdBwpcCeQ6
         cpPsXvCLGM46GX1D0KH0ZdEvE+QejLlJbOGL41OMuVKaU9RpFBWTTlZDBg2FVbfxGzMU
         JqAQ==
X-Forwarded-Encrypted: i=1; AHgh+RruKsKPdnL69ThuF0g6qmAQKJrUeXkaaHeAoYpT0DcvZgQxNgdvOO3iY4vTdYOlXpWJ4SrTg0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiAlTCVJMAUP+zN4h/Txm6n1sUKJG6iHN9aiOOodjXco1yvP/
	Th0ZBkj6DQ7+DjgQjo2rDSwozMNGTJXTckHz/F0P12XUxOH1nhq3Z/Fb
X-Gm-Gg: AR+sD10hRarwk1Z6llPKdbY1xWOeOudesf3cU7LUqc9Wh+GbV8A+TA9nPIiUTDm68Kv
	zy50uMCVFBvS60WZ1n9tep+6KbaY++K2j3AKyoSAqRhhHhfKUDKbKwHgc4RNMN/8vtuYMgGrBPd
	pAVzRmB/x9PA/TqdPu9GSRs2n3R8ydEy6oFQNJIi/41XcgmSvv3ba4JeSdbz5GedR3eA0OC4o1I
	tkW4ieO84GInfg4qfPo3sFPsXnT4WZHKIlaA9sA0H5da81DG1kYBA0RIfmYAHIq8Mpkc/W5jVFa
	9/KoLmV5XMfnTDtFj2OZoPzAaE/BhKULFdd/xoifDjRa/yjfTcIrubO/91W1ryFC1LL8MtkEO3b
	WCYjXAEssy56cO7+Pr11FoGSS9e/EOsSYTg1BlQ939qbLUVq62GQ3nGV4n7XoUghLnTd5TPByKh
	aSinWGIyk7MvbQfXInwNR15l1cLh9R9RNNVsD0bdZpdaN3FTWKN2c7I921XepZAno4LCWX1Fk0a
	MD1Z551zwOsTKze4cQ=
X-Received: by 2002:a17:902:e945:b0:2cc:ee78:3236 with SMTP id d9443c01a7336-2d015f38fe1mr44996295ad.33.1785275522879;
        Tue, 28 Jul 2026 14:52:02 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc5afasm2026425ad.46.2026.07.28.14.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:52:01 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:51:58 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
Message-ID: <amkkfkXmNvbNxs3k@devvm29614.prn0.facebook.com>
References: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>

On Mon, Jul 27, 2026 at 12:19:37PM +0100, Pavel Begunkov wrote:
> We should either have net_iov or page backed frags in a single skb,
> otherwise it blows up down the stack. Don't allow mixing in
> zerocopy_fill_skb_from_devmem().
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: EEXIST -> EFAULT, as skb_zerocopy_iter_stream() doesn't handle
>     the former + for consistency. 
> 
>  net/core/datagram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..173b5d97bd40 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>  	size_t virt_addr, size, off;
>  	struct net_iov *niov;
>  
> +	if (i && skb_frags_readable(skb))
> +		return -EFAULT;
> +
>  	/* Devmem filling works by taking an IOVEC from the user where the
>  	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
>  	 * send from. We do not support other iter types.
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
