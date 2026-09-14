Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C43161A1;
	Mon, 14 Sep 2026 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375681; cv=none; b=gTTx1OUwMpyPYnO5ww+zZwkFmgC32hOwuUADv1sa4xuZXFQlNLds6ivRlpNTPyIV/dVhqW5aKOStlclxc6Q2Q9t037ezsxj6S1BjNKZTHMG+bzwkfZQjzSfjS9088O9Txf02OgX5Rkz+R54zMW+gYY7yoNbkScAKKU7uXAUJw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375681; c=relaxed/simple;
	bh=/fJ3Bjorf/NleseI92TkjKeDt7CxoCOG/cPGwtCTGe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfFp59kdtFZeGonKRUXxf8qpvkSlxKSsRMing9xijPPoAGWsbVbmw+Jfh5W9AVTLCd0uzHNrk69esylCa63lD0b7zIJjiktZQQbA/8X9XhR9K14zBt62jfgq6USLiADd1at3ZClJRH4CK90JxqOMURIkbeSKyqyCA6BMFk6fRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QlpYsUsi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QlpYsUsi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fwbCBzbmNhPmD4Q/Lgp3uEk8K5u7Eq6ZRNLrsuqS6k4=; b=QlpYsUsil7ezmrIpKXpdkW/lTJ
	uklCwmbh+iiclWvYHiQqw46YnVAQwd1l8Hx3hL5N8GgwpfsvzeutyLh2mXJqUVUoUuI4sGvMFcWKZ
	gRvZEVFLQH58LKC7WGU9vc+qUR0KEitQnFQhjZy5YaA0Szuxk97ptmay9A7gP0yfW2Fq4ZR0GvKEN
	K50Hz0tXUpjyRnPyomo4VN+lXoBJmeprrROaK38BNSQn+KDHIOuQbd+8uH2j9PNutvDqTvXHl0Hlu
	P4fm/561VJecHnIro9mBcro2VCJE/P3/BaDhS4aeRXDS6o2PIZwdIWJLwZcD8XU9xmtA/0PWAh65c
	lLtVAyJA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x62Ln-003UlR-2z;
	Mon, 14 Sep 2026 08:47:44 +0000
Date: Mon, 14 Sep 2026 01:47:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Zack Gomez <zack.gomez@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netpoll: bound the deferred transmit queue
Message-ID: <aqeyvaw06I2883Fo@gmail.com>
References: <20260914041221.1028092-1-zack.gomez@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914041221.1028092-1-zack.gomez@gmail.com>
X-Debian-User: leitao

On Mon, Sep 14, 2026 at 12:12:21AM -0400, Zack Gomez wrote:
> A producer that outruns that drain therefore grows the queue until the
> host is out of memory.
...
> Observed with netconsole forwarding a GPU driver
> that logged one line at ~1e5/s after a firmware hang.

I know what you mean, I'm seeing the same issue on my side.

> Cap it at 1024 skbs and drop new skbs beyond that.

I don't think netpoll should be the one doing rate limiting here.

I think the rate limiting should live on the netconsole side, not
netpoll.

I have a patchset that does exactly that, which I wrote after
hitting a similar issue in production. Would you mind having a test?

https://lore.kernel.org/all/20260910-netcons_ratelimit-v2-0-ebf0dd91e26e@debian.org/

> @@ -314,6 +322,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
>  	}
>  
>  	if (!dev_xmit_complete(status)) {
> +		if (skb_queue_len(&npinfo->txq) >= NETPOLL_TXQ_MAX) {
> +			dev_kfree_skb_irq(skb);
> +			goto out;

If we do end up also rate limiting at the netpoll side, I'd like to
see a WARN_ON_ONCE() here, since it shouldn't be the main ratelimit
path, but rather something to flag that something is off.

--breno
