Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4DF3C13E5;
	Wed, 19 Aug 2026 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159686; cv=none; b=RkD4VVAfR/g7J5a+BMWxHmvqozfpgAq4QBULPkVbta3npCaZNAmh/44hBzjYDl7zrOE/oCkhUpcEpHKJppzl5PFa7rHlXjV57Nj9ZcCPT+b/9u7Ox0Cbi3QrTW6QTFqsBdePm2O3GggjhUFYBYB0kmg40Fse44+uEXT4MGDl8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159686; c=relaxed/simple;
	bh=r/UHRch10PzjNpQEOHPS6Y6IcivdXelYUFUhHf2I6Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avoiuSF1gkcwMQTYjj8Mpq/gpdDJ11mfGcgEV6sTHR6wgsOU9UqEX02bwMqGiB1v5xZ8hxUEv47e7qTDKTsDs1mFGeg+68uxBO0wwTjvL8G7piU2J+SkPqw/k0qDiyr2x0tZTQ5XhhSaVbbTvzKQcingjZ2jnFq+DJhc0HETsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1775obI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1775obI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA161F000E9;
	Wed, 19 Aug 2026 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787159684;
	bh=tK0C3IzWs+FE2jPcLTxNVhFgfPw9syCnJG4vxnJ8D0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E1775obIb9jZgzcE0ytRwWMHczrDaA0qZ7m03H2M+iQEqgNWnI6Ys+nJD1N7tYr+O
	 wEGcG7K9X/MB3y5feaWjHMEvP/fWpfmmxFaXjNcHiQR5FVkEqo2pV6akIGXuQQx3a4
	 KOSVcom+ZpDPXxAQ4HuKFS4DWKKAuLnAS6pMGRzOrCPmLrjRDsj+0iEjlPIJaqGGVP
	 BJ46EIhnmWiRFF0bpZcb7dNiDeuuy289WDYN7UHEdlcVc6KxYNjSWuh7Yg98S+baDS
	 4wASaHydkz6PgGXhW6eV1U35Am2BgDM23CWzCqwT0jZIbbgd68MK/NZNrzsg+Gck47
	 sqnhJx9TQJPcg==
Date: Wed, 19 Aug 2026 10:14:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of
 CONFIG_OF block
Message-ID: <20260819171439.GA3138944@ax162>
References: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
 <bd7082e6-fc4e-45f5-bd0a-505be79b05d5@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd7082e6-fc4e-45f5-bd0a-505be79b05d5@linux.dev>

On Wed, Aug 19, 2026 at 03:10:32PM +0800, luoxuanqiang wrote:
> 在 2026/8/19 09:14, Nathan Chancellor 写道:
> > Commit 5262eab9462a ("net: macb: allocate tieoff descriptor once across
> > device lifetime") moved macb_alloc_tieoff() and macb_free_tieoff() into
> > a CONFIG_OF block, breaking the build when it is disabled:
> > 
> >    drivers/net/ethernet/cadence/macb_main.c: In function 'macb_probe':
> >    drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit declaration of function 'macb_alloc_tieoff' [-Wimplicit-function-declaration]
> >     5951 |         err = macb_alloc_tieoff(bp);
> >          |               ^~~~~~~~~~~~~~~~~
> >    drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit declaration of function 'macb_free_tieoff' [-Wimplicit-function-declaration]
> >     5973 |         macb_free_tieoff(bp);
> >          |         ^~~~~~~~~~~~~~~~
> > 
> > Moving macb_alloc_tieoff() from its original positive does not appear to
> 
> nit: s/from its original positive/from its original position/

Whoops, good catch! I can send a v2 later unless one of the maintainers
don't mind fixing that during application time. Thanks for taking a
look.

-- 
Cheers,
Nathan
