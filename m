Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FED1FECAB
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415000; cv=none; b=MRjFH8SRc1Xu8nY5SxE0eHIds5hpGxHiIaTEXnpitq4eP9cto2STlB9SUmpnjBAZMCkwypKcRsll+hnpQe4Op6iwTrmEcRDs2wy6e+UJt/hAyEZTxJlgUmoynyD2CWrqD37fRiy9xGGkHjm1BwPdws7iVGaNr/r/Socz3HbhElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415000; c=relaxed/simple;
	bh=pTmF0Guujw0s6CmIdxzEoIC9Je0b8k+MRoMv0WSFnaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ0c/kdui17wolxPGarPMoeBmV8xe7aP3ayBI/cC/iIGDSKC9NVTmqK2Ag2X9IpqoTmcUsGl1hZCwSHVIX+HlGaX+QOGL0rJZhfWTXzv2qeAhEjyHry7iPtNb0HzKllPE7sHYvAOzPS50dRuu8ttYozx1T7Gtb+3k4d7c07AEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N376upZn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N376upZn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IrDzzT/FY/jCDAF8lEmO9H5qh+sJYR4kUJwwKyn3ZTs=; b=N376upZnmeDvdSX0hZwCAAe12W
	DnnmfnfiJeO6kkZ1JNKvqkBCLBX+MrlMjPXgZ1+P3cZmKCLiEslALCHl48RpgsRjvSqbDoZ1NSNld
	s+MJwUkjG9TdJzlVpSq1qUB9FXbwIXCid9MCHwK1Xrz57tGqn5UGnq57KsjkJyvmaWi0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHqpm-000Q2P-Sz; Wed, 29 Apr 2026 00:23:14 +0200
Date: Wed, 29 Apr 2026 00:23:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next 2/2] net: bcmasp: Keep PHY link during WoL sleep
 cycle
Message-ID: <cf941a1d-efe0-4692-b627-2dc529ff2bec@lunn.ch>
References: <20260428220858.2076469-1-justin.chen@broadcom.com>
 <20260428220858.2076469-3-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428220858.2076469-3-justin.chen@broadcom.com>

On Tue, Apr 28, 2026 at 03:08:58PM -0700, Justin Chen wrote:
> We currently more or less restart all the HW on resume. Since we also
> stop the PHY, it takes a while for the PHY link to be re-negotiated on
> resume.

So you are just interested in getting networking working faster. This
is independent of WoL? Clearly, if you have WoL enabled you need to
keep the PHY powered, but faster networking should be orthogonal to
WoL.

> -	bcmasp_netif_deinit(dev);
> +	wake = device_may_wakeup(kdev) && intf->wolopts;
>  
> -	if (!intf->wolopts) {
> +	bcmasp_netif_deinit(dev, !wake);

So given your commit message, this i don't understand. For the fast
restarting of networking, it does not matter if WoL is enabled, or if
the PHY is capable of waking the system.

    Andrew
