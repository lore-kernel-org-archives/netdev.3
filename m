Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A043E07C
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702169; cv=none; b=DFi/SpYl5X+W2aubPXi7udPaPpU7+e2w7vbLco1/bj4H/+LI+CDjk0IPazX1p2I4R/GwxXJsyS3FbfvEZMmZRjJbxRZ/QaEJ1c2gDdx/3K9WDHOaDV6Dwk/7UgQVMUNGXt5C3ZELW0Yvayz130bRaBAWV7xo6pZWcszNtHinc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702169; c=relaxed/simple;
	bh=W7maDIwRiEbTiFE7oRhqopPBwGeTkGXGat1Tm2CawbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTcnzCHqtOTYdmQI1oPYvbEaX2rrrgN6QYO8j7zaMILLLJQTU+lF0yjIsZxdG2rS/bTtD4X0tVHI0a2zMnNY4IQMEt1qkQ4iW87Ff0pLEDzXFdVOqN1vTTDGIA5vqSQHdKOf1L0LOWzVeYkosWsffI3ztTslnbmpgIUDSDwX5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om7/KKZ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om7/KKZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF73C1F00A3A;
	Fri, 14 Aug 2026 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786702159;
	bh=BmO+e8w20lWCsOzUVF4VqrI1B2H6EAsv4F89uq6Z0F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=om7/KKZ8PphrNLrTCTO6PThX7NqE1HnZ79MVhVfEStOKXk/pwuASTxk5KrNS7/OZg
	 oW/4/D8oRXDnJJvs4FDv4Dal61pueUX+4TEhy/urWGznKvda3or7rGOQH7azZmUIl5
	 ie+KsYXx7oq2P0dUZ/n0jURf1Xw7Mfo//zxHU8O18RL4BebloLDwh8SmfKHqXuRhEC
	 PH0F5zQWKb5CCSOeCD4LbaqGBTU8oy8/PvjHxshK3ejRMB8tSaMml0Q0Sv9Q7emuDt
	 8NNCruW0/22KxJHFmdYQDw+wIR+hYeE9Dd1t/5nQKvTYyOgSIR4MfraF4o6cxcyeRo
	 5b0D6WnwBE3Ow==
Date: Fri, 14 Aug 2026 11:09:16 +0100
From: Simon Horman <horms@kernel.org>
To: James <aslan.jnn@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	netdev@vger.kernel.org, Thomas.Lendacky@amd.com
Subject: Re: [PATCH net] net: amd-xgbe: support receiving packets with bad FCS
Message-ID: <20260814100916.GL265046@horms.kernel.org>
References: <20260812091616.35811-1-aslan.jnn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812091616.35811-1-aslan.jnn@gmail.com>

On Wed, Aug 12, 2026 at 09:16:16AM +0000, James wrote:
> From: James Nugraha <aslan.jnn@gmail.com>
> 
> The driver currently sets the MAC_RCR.DCRCC bit whenever RX is enabled.
> This disables hardware FCS validation, causing packets with a bad FCS to
> be accepted unconditionally. Users cannot control this behavior because
> the driver does not advertise NETIF_F_RXALL.
> 
> Advertise NETIF_F_RXALL and disable it by default. Update DCRCC when the
> RXALL feature is enabled or disabled, and preserve the selected state
> across RX and link stop/start cycles.
> 
> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")

FWIW, I lean towards this being an enhancement for net-next without
a Fixes tag. Rather than a fix.

> Signed-off-by: James Nugraha <aslan.jnn@gmail.com>
> ---
> Tests:
> - Verified invalid-FCS packets are dropped with RXALL disabled.
> - Verified invalid-FCS packets are received with RXALL enabled.
> - Verified invalid-FCS packets are dropped again after RXALL is disabled.
> - Verified the RXALL setting survives RX stop/start.
> - Verified the RXALL setting survives link down/up.
> - Verified RXALL is disabled by default.

Thanks for noting the testing.
I might have even included that in the patch description.

The above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


...
