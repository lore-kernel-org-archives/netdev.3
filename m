Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD243DDDBC;
	Wed, 19 Aug 2026 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128656; cv=none; b=Bp8qoXEeMHmmspDaw6NwKikjjwx1B7SSea/znFqq6hbjn6QeGKjQM7QL38GjGqjZdAF5qzZ9i8/fXUousgNxMsrRndFoaQnTiHcrdXc0Zpt0RR9TYn8nDb+uzEEEMsvrQEzPudwcbovrhNMk6HLiwp8ZAEi4LS8XBgCnoTTlgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128656; c=relaxed/simple;
	bh=oxuiYfZWfOAthZUIJeC8ZRg37dUpJRtDCeKexWtsF1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHxho4Yy6OyYs0qY5ORQNYevpkdwr9uadmmVVfHQmDShV72cb5PsaMlds2iUdAnvzzEMAWXzDHuKh50mN7R1psNRjH/VhmzNiZrCMoOOVJJfsHt9YHDCsGUln0cDKBVqlr+wusKRDxw1KBzt67twurFF5/rVn3ilKsrmpazoZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keaG995z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keaG995z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D161F000E9;
	Wed, 19 Aug 2026 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787128655;
	bh=E017y2b0y9pp0CAPlqPubdWc9gIY66WMivHwzwfjA0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=keaG995zJOeiQ1TPyrz6Ve4Ge9ENx010f+DFE87mEI7GgT56Ws9BlNW2CWy8Bsqod
	 hT46ITwV4juY9v7cdUYEqk+UFbuZovTGLxRovLEYr3202kba97t4Fc9I1Pl4At/cR8
	 b1lmJvSn1ufdEJYPfE1yNp5Fjc2CDvI6XQMDsNyPDe0LzSGw6r4s2mg/le4tQiUwL5
	 SRn1V/PH3GUm8SQNcaciV9ZBsTtA13ZAnEF5952P8MsrtXVR+Bs1v1jDt4MlKMAkdI
	 UOVp/CiOpMdBrgU9fwQXkmot+tEOt5uh9KRegJBDZNgY+L8KDMsxrpdqWBDxtJFY+I
	 g5/pV2jWvFrXQ==
Date: Wed, 19 Aug 2026 09:37:31 +0100
From: Simon Horman <horms@kernel.org>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: Ion Badulescu <ionut@badula.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: starfire: fix ioaddr sign-extension causing
 ioremap() failure
Message-ID: <20260819083731.GL265046@horms.kernel.org>
References: <20260815192432.38951-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815192432.38951-1-skunkolee@gmail.com>

On Sat, Aug 15, 2026 at 01:24:32PM -0600, Ivy Lopez wrote:
> ioaddr is declared as a signed long, but is assigned the result of
> pci_resource_start(), which returns an unsigned resource_size_t.
> On configurations where the BAR address has its high bit set, the
> value sign-extends when passed to ioremap(), producing a bogus
> 64-bit address and causing device probe to fail:
> 
>   ioremap: invalid physical address fffffffffe480000
>   starfire 0000:08:04.0: cannot Remap 0x80000 @ 0xfe480000, aborting
> 
> Change ioaddr to unsigned long so pci_resource_start()'s value is
> preserved correctly.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198035
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
> 
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>

I guess this is a minor tooling mishap, but one Signed-off-by is enough.

> ---
>  drivers/net/ethernet/adaptec/starfire.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
> index f1109d90e1fc..b72b393e6fb2 100644
> --- a/drivers/net/ethernet/adaptec/starfire.c
> +++ b/drivers/net/ethernet/adaptec/starfire.c
> @@ -634,7 +634,7 @@ static int starfire_init_one(struct pci_dev *pdev,
>  	int i, irq, chip_idx = ent->driver_data;
>  	struct net_device *dev;
>  	u8 addr[ETH_ALEN];
> -	long ioaddr;
> +	unsigned long ioaddr;
>  	void __iomem *base;
>  	int drv_flags, io_size;
>  	int boguscnt;

I'm wondering if you considered using resource_size_t (and %pa[p]).
Given that is the both type returned by pci_resource_start() and
the type of the phys_addr parameter to ioremap().
