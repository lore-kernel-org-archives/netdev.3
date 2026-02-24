Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E636AB50
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925194; cv=none; b=Z494/rxRJFvPelHJc7s9IIhSrfydC3JXzpQ0wX7ilNlLv/z4E38PAib/NICBlGy9ruvSFN48wcYnT63x20secx+mDdcMocYcXTXwHYHMXCfI5H1uu7ZlFpMds0NdehveEikMuh1k0IRrx+mlG7JWF1fivo9PO+OZ+1YcZx7CPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925194; c=relaxed/simple;
	bh=gW2ll+nM74bEEmCgEWg3HfAkPc+LIWHPoFwS1UekeLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpmKaEIuJF8pw/HUKnhXKrWDBRsVMulQ66diIkoKBGdoN2JlrafTv6Fh72rs41KGDt9UEZEQmkjuLJ3MWkW0lysmngpf6bg5zUqJzvzZE9cb2bVVqw2bX8pVjSNQzClmMNa3hdsNVH/YWtteBmYhwF1jzgI3KfwGBflvmfD+qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3VM8b64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3VM8b64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A62C116D0;
	Tue, 24 Feb 2026 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925194;
	bh=gW2ll+nM74bEEmCgEWg3HfAkPc+LIWHPoFwS1UekeLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3VM8b648NiVpQDtl9iPxAXS0gQlH5thDEvogxog0EJOhz+ITQDgwa9p0gao+iKDo
	 al1jP6hrqySPLW/wyuN1yT9ItX+41Z326O5Iq9n0MY9fvZ4ZA956D4M1WvTmzx0XOz
	 ZEr6Z+uKu0h8yOsKpAf+o5DDDUSRZFh3z1HL6aC32bfaMYlc2oNlPUDirxUUmvoll/
	 7B9cYh6gPrHjI0q1mTQ/MxE+PhgNHq5WGMHsn1NEJD0RwY/XFIxXB7fUmsHW2WTFQz
	 cVs95gf/TAbBQzFcW/Y2yTdOae7YG6qEAGvufiafJzjr2iOFCnIH2SJdKpxJOwQahh
	 3ubd300ARbsjA==
Date: Tue, 24 Feb 2026 09:26:29 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: ptp: limit n_per_out
Message-ID: <aZ1uxX_fddwO7UYD@horms.kernel.org>
References: <E1vuUvf-0000000AfhS-0lJR@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vuUvf-0000000AfhS-0lJR@rmk-PC.armlinux.org.uk>

On Mon, Feb 23, 2026 at 12:20:47PM +0000, Russell King (Oracle) wrote:
> ptp_clock_ops.n_per_out sets the number of PPS outputs, which the PTP
> subsystem uses to validate userspace input, such as the index number
> used in a PTP_CLK_REQ_PEROUT request.
> 
> stmmac_enable() uses this to index the priv->pps array, which is an
> array of size STMMAC_PPS_MAX. ptp_clock_ops.n_per_out is initialised
> using priv->dma_cap.pps_out_num, which is a three bit field read from
> hardware.
> 
> Documentation that I've checked suggests that values >= 5 are reserved,
> but that doesn't mean such values won't appear, and if they do, we
> can overrun the priv->pps array in stmmac_enable().
> 
> stmmac_ptp_register() has protection against this in its loop, but it
> doesn't act to limit ptp_clock_ops.n_per_out.
> 
> Fix this by introducing a local variable, pps_out_num which is limited
> to STMMAC_PPS_MAX, and use that when initialising the array and setting
> priv->ptp_clock_ops.n_per_out.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> 
> This could be a user exploitable bug (although one has to be root
> so the gun is already pointing at one's foot.) This is the commit
> which introduced the problem:

Hi Russell,

From the description I assumed that for this problem to manifest
out-of-range values would need to be turned by hardware.
But maybe I misunderstand things.

Could you elaborate on the vector you have in mind?

> 
> Fixes: 9a8a02c9d46d ("net: stmmac: Add Flexible PPS support")

...
