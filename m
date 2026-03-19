Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D33348895
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941440; cv=none; b=QaX2Gwbsmanp/5dnWrf7xGqhC9xc4CR/r9p1UM4xiDqC9CrStzQNpWlOEOqTO2x9fCA+srsDA7psz+ZE7HyyGWHW4/K8wWMWDOztR9wxG4ij9k5JsbPpgHsSOD/pmw+er95rOoaZe1l0dhA9HAvxOEg4DFba1hL/bvuX++MNmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941440; c=relaxed/simple;
	bh=bnKHcjqSMB5G+DWkorqjAi9+m6/WCpSNCuHA+Cy7RUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1aOKmvbEnpTp7Othyq2rxBW7tO/zjsZ16+5nAAG5ZT9hcvJph8Zd43dEaMFKgZIrrfNEcwRiC7ThcxofuE6BlADfelKLNFz6CZaG5rrWi73f3p90yvVtVxODB8Oick1bDGB768xjwLaWtZ4VmhosoUKS4AKemxFpnjCDBFG1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa0cc6WU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa0cc6WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45CEC2BCAF;
	Thu, 19 Mar 2026 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941440;
	bh=bnKHcjqSMB5G+DWkorqjAi9+m6/WCpSNCuHA+Cy7RUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qa0cc6WUEHNXFN8BAUTwV8Y0rHe+FxKAGpC/MyUGXx5djGVe9NkvluxWixx4sS047
	 hjRo5pcgK0lq7GWuxrHpaCsJT0YRefM+Gnf6y4Dp3tR8LCan8W/eZzC0M/GmuiAj8B
	 casBlfJ9lUafbqTBhaOrAuTQ55ooj2LORpUoYQEVAZksXTdvWUs6cXYY1q7Q3RN1o8
	 DsSDfm4PdXwnU7Tbjn3w2t0p5G4qaUmPO+H1zgS/zvCm8fniqLwo1OKW++04jJodSj
	 mtTv/WCI9LIdHaMyPEqek8PO0hdoVy4hufiv2of1ACLjPDiHlBRPmthaAQhE6QTCZN
	 6x03ej+j/BNsg==
Date: Thu, 19 Mar 2026 17:30:36 +0000
From: Simon Horman <horms@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: fix use-after-free of CPPI
 descriptor in RX path
Message-ID: <20260319173036.GN1753385@horms.kernel.org>
References: <20260318092841.14453-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318092841.14453-1-devnexen@gmail.com>

On Wed, Mar 18, 2026 at 09:28:41AM +0000, David Carlier wrote:
> cppi5_hdesc_get_psdata() returns a pointer into the CPPI descriptor.
> In both emac_rx_packet() and emac_rx_packet_zc(), the descriptor is
> freed via k3_cppi_desc_pool_free() before the psdata pointer is used
> by emac_rx_timestamp(), which dereferences psdata[0] and psdata[1].
> This constitutes a use-after-free on every received packet that goes
> through the timestamp path.
> 
> Defer the descriptor free until after all accesses through the psdata
> pointer are complete. For emac_rx_packet(), this means freeing in each
> early-exit path and after emac_rx_timestamp() in the success path. For
> emac_rx_packet_zc(), move the free to the end of the loop body after
> emac_dispatch_skb_zc() (which calls emac_rx_timestamp()) has returned.
> 
> Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
> Signed-off-by: David Carlier <devnexen@gmail.com>

Hi David,

As a fix for code present in the net tree, this patch should be targeted
at net line this.

Subject: [PATCH net] DAnet: ti: icssg-prueth: ...
                ^^^

Unfortunately our CI tried to apply the patch to the default tree, net-next.
But it doesn't apply there. So the CI didn't run.

Please repost.

-- 
pw-bot: changes-requested
