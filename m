Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A94367B89;
	Wed, 20 May 2026 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257389; cv=none; b=cQdItFdNNYjWerMfZYEyehmrfoG43cyp2MWt/u8fRPXYW+ez3V7l8CccBLTAINKne8gPZeBUQsJzz+738Av3PeTybT8HeteqRfZtyJjfz+Hi0ZrecMeC8ID/xdnKZ27XdBCMFooVNfJx1VZl2ABFckZ8l43hkoFZ8t02uhK9oHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257389; c=relaxed/simple;
	bh=7nR2cYffKzn3qblezAod83dMu6CUoczj+RqdOYSGxjA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqdOahDkwf1qI8cI0VxXw0Zwq0zR3q0ESpa7tLOUjjYkaX2LJemi7z0NEcuPRvy93DnfekBi/T0sDG2AMBGDHqfpLTDE43W/r8Iiuo2/XFSp+aDok8LA6W4HrxpQ9KcOxt8BvDFuq0NQlwvow/clsQV1GUqtKV75QR+Sv39m8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ProQkrXY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ProQkrXY"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1F5E120799;
	Wed, 20 May 2026 08:09:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Du88w6aKsKCr; Wed, 20 May 2026 08:09:38 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8E28A20590;
	Wed, 20 May 2026 08:09:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8E28A20590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779257378;
	bh=fbylmkt8HIQ0X9dmRIkRb1AWUPMxAQGRqJQUMooYfIk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ProQkrXYWVolmy1kde8WL0DGPLeQ7iybKKvd16Q2Ryp3K31Y5Blxmwo9eGWwef33X
	 nFl2WOUoMIjPnpl1ZPRPnooC7gxLlBRdOO74L29qSZPwGaA+iqhhvaUaXHLCg2qyC3
	 yrGnJAMTIpYA0H7pP9PrzsskeNcR3yXnXVdpXciGt6JTSN+cFXTOdpimjXN5fL386A
	 1U7C0OueXcStPE5y6e4njcgrJt5egBuJ4JVSIiDhArImMfuIx4o9oC99mlpqNCTAG+
	 1LjdM3huWEp+tauB5jdSbHVEO6QGEjg1urE+quhGsbAXz1NQldVO3CqI3bR9SahVmT
	 vhMtKOpk7/QXw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 08:09:37 +0200
Received: (nullmailer pid 1101168 invoked by uid 1000);
	Wed, 20 May 2026 06:09:37 -0000
Date: Wed, 20 May 2026 08:09:37 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Aaron Esau <aaron1esau@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>, "David S .
 Miller" <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <stable@vger.kernel.org>, Sabrina
 Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH] xfrm: espintcp: fix sg.size corruption on partial send
 error
Message-ID: <ag1QIbm4yrK_b_Ic@secunet.com>
References: <20260518032109.616327-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260518032109.616327-1-aaron1esau@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, May 18, 2026 at 12:21:09PM +0900, Aaron Esau wrote:
> espintcp_sendskmsg_locked() calls put_page() and sk_mem_uncharge() for
> each scatterlist element it successfully sends, but never decrements
> sg.size. If tcp_sendmsg_locked() then fails partway through, the error
> path advances sg.start past the freed elements while sg.size still
> accounts for them. A subsequent sk_msg_free() in espintcp_close() loops
> until sg.size reaches zero, overshoots sg.end, hits zeroed entries with
> NULL pages, and crashes in put_page().
> 
> Fix this by decrementing sg.size as each element is freed. Also use
> sk_msg_iter_var_next() instead of raw addition for sg.start, so it
> wraps at NR_MSG_FRAG_IDS.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
> ---
>  net/xfrm/espintcp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index e1b11ab59..6755f6df6 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -237,7 +237,8 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
>  		ret = tcp_sendmsg_locked(sk, &msghdr, size);
>  		if (ret < 0) {
>  			emsg->offset = offset - sg->offset;
> -			skmsg->sg.start += done;
> +			while (done--)
> +				sk_msg_iter_var_next(skmsg->sg.start);
>  			return ret;
>  		}
>  
> @@ -250,6 +251,7 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
>  		done++;
>  		put_page(p);
>  		sk_mem_uncharge(sk, sg->length);
> +		skmsg->sg.size -= sg->length;
>  		sg = sg_next(sg);
>  	} while (sg);
>  

I'd like to see an Ack from Sabrina (she authored espintcp) before
applying this.
