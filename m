Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C042E7BB6
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881837; cv=none; b=XvTwaYepZqsAAqpKCR7wJYKxNumAYxoXFJ9y2FjjCcGteHNmyu5BeBj+4yuN0VtmZuVp4eCyllo05vXIlmGV1COjzXWVTvCSx+QSvQ6g0Drtq9U//uDAFjRfhO124IQn9foWdGlfB9kIxhgE7IPF2kC1haenNcvKONmDEfVJFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881837; c=relaxed/simple;
	bh=bMwMT7lON0y7CIGbcCN9vu9X2Xfdqp7xMQNiMGzPsQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3xRBzl6b1a7uNOvCQ9XIIUt5WWeIDgBY6Ebx9iLjOyUoWqtzECIwftdeI3jvKDlv1dM4lw7uYmhT9ewMFHh4VHflUpWBWtO4ZT8S7ocotbmRxCyWSixRWO4n+xtiXBc2THS5o0sPgBJwxlVesLEIgDGmOe6EYDSzw9OAitLmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LFIcGSfZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJ/W+yCt; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LFIcGSfZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJ/W+yCt"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CFB817A0181;
	Mon, 30 Mar 2026 10:43:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 30 Mar 2026 10:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774881832; x=
	1774968232; bh=TVgwWzC98O9JJ07tqs/JeVGRYZaiUT/cn6TNW2863Ms=; b=L
	FIcGSfZqMYQQr5kouaQ61avt77Wg6EctHDNtDvUuHuoAAZFDRIgAzPQFNZYgJ9lZ
	JalIV4PLPerEWPLOTXvMfKQHWmW9hQzhMd8z4X1uUl+u4o46exkSDkiKJXRcui+f
	es4qPjN3w2yv/kJ3S3ylz9OMR+tS/pycDPMNf01qUYhSr4RWBR1hpmwGILEzQxQg
	gLKpdSmUvHrT/RduAAbj5h2/pRntgY34x5GxPlYAo7ZXcQg0X1SJUstQIZ84sMc4
	BDd5iqP1fAWKuxMnPXeUX2lgp5+8XOokDBEO7Cdk6ybHhG/MUKIUdNdXGw2/4iNg
	++XJlH4WKTL9ASTrcQSTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774881832; x=1774968232; bh=TVgwWzC98O9JJ07tqs/JeVGRYZaiUT/cn6T
	NW2863Ms=; b=iJ/W+yCtv2CaNm5YgShrcyeL113ekUw3pAGUiUoORvESgflwb0A
	fWQek/OOvnySU82x7XsWgzsA6FQ4K9HvoHDCDTUMKd7QCC70FPwfUZk6AGImqCFv
	fWAyyfTAgTFWviZEn16qPkMkuK0EWAUEC5oxlvmIS+kx57yp++UsN5rLd4bZhCcM
	IRBXGO53uPby0I/u0w7empySiaSP8SYKjtFYNay4WPS9RmvNLQs050b0juwzFRLp
	sk/Fy72WAHn5ifxBjp2MVdGjy6FGmkl4bgWQSWFJ3IQDpojEcIdZAfYdJ3aC/0pW
	pD0hJ3EsWK2ctGg4ULGfrPvceRBkzCcl18g==
X-ME-Sender: <xms:J4zKaSC2VvzmjgyU9diwKTVFtVKfQgtyFOzejFQ0Xouy9sTztGSPBQ>
    <xme:J4zKaWhp9XLthw9o2yjnTc1DmhE_HfYQNRo9SfmOw0tpXjrvtsfAkmOsFjxLXmJ8q
    wpRzPWcoZlaUVIFOxsmnU3UgbJfGr-AiQI4RLLALEr7FDlv3GnyWfYd>
X-ME-Received: <xmr:J4zKacPfT_NbxQ7xXZhm1lNo-s9IZOMVd7ToWo1LfKRuiE4Yvt8kO9mzMAAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgr
    nhgtihhsseifuggtrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:J4zKae91h573YcszvwSK3S60_TlNpkmnFzjdkuRdNXLqLe60KI9piw>
    <xmx:KIzKaVdBubC464yJFGKzDKvKraZl5tgZtcHlAM3w52EC7N3p-hEPYA>
    <xmx:KIzKaVzcfJCCXSoyBTAYn0kzN8ds0l_kGDGmyAWOZnCuHe3v91gekw>
    <xmx:KIzKaSJQEicjy-63PHCiAodJ1d0jo3LOkySsQTsGluVfbNYdBLGlKA>
    <xmx:KIzKaRwl9SWiVbLlz7ZfOjBdHcaGSnCNoq1GLmYVKtknLSzMzt0RrYBb>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 10:43:51 -0400 (EDT)
Date: Mon, 30 Mar 2026 16:43:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH net-next v7 4/5] tls: Suppress spurious saved_data_ready
 on all receive paths
Message-ID: <acqMIKWFmx6B1lD8@krikkit>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
 <20260328-tls-read-sock-v7-4-15678415dfc1@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260328-tls-read-sock-v7-4-15678415dfc1@oracle.com>

2026-03-28, 11:17:11 -0400, Chuck Lever wrote:
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 5fdd43a55f1e..8fb2f2a93846 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1373,7 +1373,11 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  			return ret;
>  
>  		if (!skb_queue_empty(&sk->sk_receive_queue)) {
> -			tls_strp_check_rcv(&ctx->strp);
> +			/* Defer notification to the exit point;
> +			 * this thread will consume the record
> +			 * directly.
> +			 */

That's a really nice improvement over the comment you had here
before. Thanks.

> +			tls_strp_check_rcv(&ctx->strp, false);
>  			if (tls_strp_msg_ready(ctx))
>  				break;
>  		}

[...]
> @@ -2142,7 +2146,7 @@ int tls_sw_recvmsg(struct sock *sk,
>  		err = tls_record_content_type(msg, tls_msg(darg.skb), &control);
>  		if (err <= 0) {
>  			DEBUG_NET_WARN_ON_ONCE(darg.zc);
> -			tls_rx_rec_done(ctx);
> +			tls_rx_rec_release(ctx);
>  put_on_rx_list_err:
>  			__skb_queue_tail(&ctx->rx_list, darg.skb);
>  			goto recv_end;
> @@ -2156,7 +2160,8 @@ int tls_sw_recvmsg(struct sock *sk,
>  		/* TLS 1.3 may have updated the length by more than overhead */
>  		rxm = strp_msg(darg.skb);
>  		chunk = rxm->full_len;
> -		tls_rx_rec_done(ctx);
> +		tls_rx_rec_release(ctx);
> +		tls_strp_check_rcv(&ctx->strp, false);

Not strictly an objection against your patch, but after those changes,
calling tls_strp_check_rcv() at this point in tls_sw_recvmsg() is
starting to look like a leftover from the transition from generic strp
to custom strp. We're not going to do anything with the next record
until we call tls_rx_rec_wait(), so it seems it would fit better
before the loop in tls_rx_rec_wait().


[...]
> @@ -2290,7 +2296,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>  		if (err < 0)
>  			goto splice_read_end;
>  
> -		tls_rx_rec_done(ctx);
> +		tls_rx_rec_release(ctx);
>  		skb = darg.skb;
>  	}
>  
> @@ -2317,6 +2323,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>  	consume_skb(skb);
>  
>  splice_read_end:
> +	tls_strp_check_rcv(&ctx->strp, true);

This is in effect adding a

if (strp->msg_ready)
    tls_rx_msg_ready(strp);

[a bit more than that]
in case we dequeue from the rx_list but don't use the record (or only
part of it).

I wonder if that should be seen as a problem (another spurious wakeup)
or an improvement (wake up because there's data ready)? Or if we
should wake up anyway if we exit with rx_list non-empty, regardless or
the parser's state, since there is data to read (tls_sk_poll looks at
both rx_list and msg_ready).

[this applies to all 3 RX functions, but this one is the simplest,
which makes it more visible]

>  	tls_rx_reader_unlock(sk, ctx);
>  	return copied ? : err;
>  
> @@ -2382,7 +2389,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			tlm = tls_msg(skb);
>  			decrypted += rxm->full_len;
>  
> -			tls_rx_rec_done(ctx);
> +			tls_rx_rec_release(ctx);

With this, there's no tls_strp_check_rcv() call inside the
tls_sw_read_sock() loop, so in the next iteration, tls_rx_rec_wait()
will have to go for at least one round of its own loop. [this points
back to the recvmsg comment above, and a bit to the "cold path"
discussion we had earlier]


(Sorry that I'm only thinking about all this at v7...)

>  		}
>  
>  		/* read_sock does not support reading control messages */
> @@ -2412,6 +2419,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	}
>  
>  read_sock_end:
> +	tls_strp_check_rcv(&ctx->strp, true);
>  	tls_rx_reader_release(sk, ctx);
>  	return copied ? : err;


-- 
Sabrina
