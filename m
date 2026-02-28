Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF313C1F
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772245982; cv=none; b=oV2g7Pzs6GHhugmG9TjNfqafnvykmDIb5aJkIJpkAhsIt2dEDuWarxQcOq+kF/ZxnBV56FOzqQePmQrZsdVjvIGKLRT0LHvE0Ia14x6g4WTvW3Hu4gKI4HiIcKJb9WDzu/x0UfX2d8QfNzTGOCSDXFEEJTDjx5+W35kTlPQkMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772245982; c=relaxed/simple;
	bh=yEyfz+MLheKG7FKad8hCjJKqYXd5MIqTopBanRzPx7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gngRYXjtyYvhUYpMDNsskfrP3pHzfTjIgGCVXG9HR1jt+iVU0P84JQ79vrQFYLbNoi8vMVWrEmSUp+4Xrn2OhLv9gSEdARfbs3mUnS05VnvzMCLhxAkgDGnfgE1h/gGsO3NE4rquOzBAsGoP6YlTG6cNhz8KDl+oKft6SYeMnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esd41S5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esd41S5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABE8C116C6;
	Sat, 28 Feb 2026 02:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772245981;
	bh=yEyfz+MLheKG7FKad8hCjJKqYXd5MIqTopBanRzPx7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Esd41S5wn3jRV0JfcbLKCKc9uKm99wHiEEeVx/j/gxTsq+jooFgP770EPkfA18hc1
	 dKEV2LvtpoW2qFOHJ30NoNSkZ00CeMdkGD3GpkqGzRgnKvruZNjd45fkGl7Sgfz/C1
	 bALCVCJj9PsjNtYYf1V6vHuI/7n1C5H7D/NkPVhyRVCHKwTSHD2VFn9kPcxBhdIS/R
	 f+m8/Qgh9hHAa5w4FhqQr5s5DPzxm4G2DtSw1yOA4gaaBS0bBFrKMscAupTN13WuWp
	 2lKb05elcL/+JNT0Cgd9lvRg7qdBWEA8gna/uJ+ZWiuWNwJQ9T70zWaYFBHLPF+oyO
	 2RHRuDpnOcb1g==
Date: Fri, 27 Feb 2026 18:33:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny@fb.com>
Cc: <netdev@vger.kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 9/9] selftest/net: psp: Add test for
 dev-assoc/disassoc
Message-ID: <20260227183300.7a813cd4@kernel.org>
In-Reply-To: <20260224002410.1553838-10-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
	<20260224002410.1553838-10-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 16:24:09 -0800 Wei Wang wrote:
> Add an env NetDrvContEnPsp which is based on NetDrvContEn, but add an
> additional bpf redirect program on nk_host to redirect traffic to the
> psp_dev_local. The topology looks like this:
>   Host NS:  psp_dev_local <---> nk_host
>                 |                |
>                 |                | (netkit pair)
>                 |                |
>   Remote NS: psp_dev_peer      Guest NS: nk_guest
>              (responder)             (PSP tests)

Can we not have a param in ContEnv to control if the return program is
installed? Is there more to it? The PSP binding can presumably be done
by the PSP test.
