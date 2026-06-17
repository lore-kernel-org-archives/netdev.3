Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DE17BCA;
	Wed, 17 Jun 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684666; cv=none; b=OuYQa+k9KGqQzPK1UmvGFsUL0s3b2K2he87ddfqokSpo9Gf3eW0LLAxGpGxs/pS5TBK9aujCV9R2cHFXO/Z4SY2IGkD/jstAPB5vfdTKXhzikq1jPI3cDcLPgHX4/NQivJRZELZxXnrZ4CtajbAa46SU1/RXV3vWp2dJz8qKpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684666; c=relaxed/simple;
	bh=kuBApJ0y7Vi88cCvSqzgNTYzLnc0J2FB38jctZzfGg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuJhWlsWjXOfG1I2xo7Q8PFoEdQ1rnqRB2/7zdYIO/u7RFh2JnmbRLBCWLppQnVcSTXuTCFf0SGxqJ5QNJSAIfAJsFZEffRAHwCO79KlhUBiljw5dL4G5PgOXXmBd5bFYzRdukR+gUmf3hVmhZOutpDECGAEBTwddSX8BfCbHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJWE13wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJWE13wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D404C1F000E9;
	Wed, 17 Jun 2026 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781684664;
	bh=SuzyLArYe5bj+f7+Tp/IYxWPm7dZk8dVDaRvB9u0vM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJWE13wkvsj53uRMwF+qNTzbENIExxm1mw03vCAc7ZAxBamTeiUoVbH99HJjzd9Q8
	 lvmUJz2JAH2Qe1m9/FndJ3qrqoM31Yoaw7hjTvRQ9Nv8R0OZHGAEr5uENW/1EhdPE3
	 LrSg3vo4uV5KxJjVdIZYJXvcoivt95jw74yIDIMQeXVuakjeMLlPXWZqyMCjlOQpCx
	 /G6IiAvnQ2jOC1TFU5YLn6RbuMtpoCblH2ybG94EMpMfNAVo6zUx3YDH3M7sxvJTsY
	 l1Hdn7vhJCfiyG1H+B+LGO4CZorVrAGiVhmd3MYm9hniNVFrr0WhkH8DUTEd5V2CIn
	 6VSO4bqJUy3Cg==
Date: Wed, 17 Jun 2026 09:24:20 +0100
From: Simon Horman <horms@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: pch_gbe: handle TX skb allocation failure
Message-ID: <20260617082420.GA840150@horms.kernel.org>
References: <20260615125043.3537046-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615125043.3537046-1-ruoyuw560@gmail.com>

On Mon, Jun 15, 2026 at 08:50:42PM +0800, Ruoyu Wang wrote:
> pch_gbe_alloc_tx_buffers() allocates an skb for each TX descriptor and
> then passes the returned pointer to skb_reserve(). If netdev_alloc_skb()
> fails, skb_reserve() dereferences NULL.
> 
> Make pch_gbe_alloc_tx_buffers() return an error when an skb allocation
> fails. On failure, let pch_gbe_alloc_tx_buffers() clean the partially
> allocated TX ring before returning the error. While bringing the device
> up, release the RX buffer pool through a shared cleanup helper before
> unwinding the IRQ setup.
> 
> Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> Changes in v3:
> - Move the partial TX ring cleanup into pch_gbe_alloc_tx_buffers(), as
>   suggested by Simon Horman.
> 
> Changes in v2:
> - Add the kernel-doc return value description for
>   pch_gbe_alloc_tx_buffers().

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

