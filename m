Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D845342517
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776549; cv=none; b=dpijwnhkx0GLFfR2iFVgtj28iJlUnzC1sl5wb6i0nLcH5G5gu+KXym908F4RtlYVEPzai4LJlaOAVAcU2ETMJ+lEB6EcG9Plmz9GIsEcGmlf0Q3+s+zRSiPGYKzs56c+YorRX/j8EZHJ5NEb/7c5ZPIsjLUcH3/oZVE2Nt0gcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776549; c=relaxed/simple;
	bh=8v0bkqpq04Zoro8Gk9P1+D2UFHff2TDCo6MaSPEpI/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU/8nBq/nEZlT+fVYLQkoZd6fnIZNL8sleIZRSdVG3ETxBQgcUXsAzt1fwY5RpAlR+D4tiThVgpn2r9aXSvyQz5Th/40Cw4clfOLq8rjD14rDRzTeqXcmChPow+OU8hpm/i0hfFON/n2cpAA3/M+eI3b6PVFnoCt0g1rWHxJLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Qo2ar6v5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Qo2ar6v5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JxrGPLoHP6jjNOpRSJAJJ6cHZmgAETlbZ9QiMFvN838=; b=Qo2ar6v54C720+VDgyetSX6yX2
	BKhRP4jfIEVY9y1j9S9B9TWhA1KAHt2FdQ0+bBTG7wteO6b4l1F3epVibewDDAZAqlIQhlCCSJKwz
	8fzp4TS5MkngcvAcIx4St3s+P9Ck04OlAPkeO58iyylLHUC4ENvDz/wFnPkRwNVyQgshicPxwN5Jh
	FkPegNjS7MFqfIboOo/5GdikvJbNr7PrchNYGzjIId6dxMu5UHF8pVu0m4uRnPj/Nbv32QxczeQe6
	LcRq5u9xSFa4cZyJkKjRTcKqif8kk4sLX3Vn8C+uMYHKMvukmVdlOLInM65ydTn5EYPHx+UnUVwVr
	iiI8uvDw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2aIt-0037Hf-3h; Tue, 17 Mar 2026 19:42:09 +0000
Date: Tue, 17 Mar 2026 12:42:04 -0700
From: Breno Leitao <leitao@debian.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the
 interface is running
Message-ID: <abmtcI4NX_zFyAwA@gmail.com>
References: <20260316092720.39198-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316092720.39198-1-nb@tipi-net.de>
X-Debian-User: leitao

On Mon, Mar 16, 2026 at 10:27:20AM +0100, Nicolai Buchwitz wrote:
> macb_change_mtu() currently returns -EBUSY if the interface is running,
> requiring users to bring the interface down before changing the MTU. This
> is unnecessarily restrictive.
> 
> Instead, close and reopen the interface around the MTU change so that RX
> DMA buffers are reallocated for the new MTU. This is the same approach
> used by many other network drivers (e.g. igb, tg3, stmmac).
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 5e27e0e87a55..8dd01031250d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3262,11 +3262,16 @@ static int macb_close(struct net_device *dev)
>  
>  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>  {
> -	if (netif_running(dev))
> -		return -EBUSY;
> +	bool was_running = netif_running(dev);
> +
> +	if (was_running)
> +		macb_close(dev);
>  
>  	WRITE_ONCE(dev->mtu, new_mtu);
>  
> +	if (was_running)
> +		return macb_open(dev);

Would you like to keep the new_mtu set, even if macb_open() fails?

Other than that, it looks good to me.
--breno
