Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A23E959A;
	Fri, 17 Jul 2026 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291374; cv=none; b=ndbamBEmtdLkGvfVWWSTxnlLnnS8PwqXBcPbgJlvo2pht101L01QNHqVj3Xur5qqwfxey7jXsMXbQxQcvPygwUfGIWGontz1h9mKhipRBSz/F/qzeB+ZjSG7ecdknkm37P0hkp+E88b7wT5K9vlA+MrwlgN9OOWHnbOC1hRjdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291374; c=relaxed/simple;
	bh=pfdO8NB7AQEpYryfNGrHPU/ABCuyTHahnCB84YpXMEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcQPg16pQTbHseApDy22sfNsG27FSCRrhvbYzjDHlF2+bG1dkVs7DjEK0+lNdHI9zurZ86SxFfR9ABsQGv1vf2TfPq8LHPXUCXNTGtZjwssvRcosSNrsQMYbaw5hnyQ5/DqRg/w1SptSIUvBibP4QUYKdSculGfSjjYsVWSI488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=owG/i9u5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="owG/i9u5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9cr7cS1QxmmUdiqojtYTDFGDzXB4/dgRIGNVUHz+gVk=; b=owG/i9u5AkDBEiVP6IYwAVnXMu
	tyl5wLowel/gdLxuZpJgP1VNofR+NAf9zllaOrVo2ru4Uvyv/f2NNO7bLJ4Uqv+939HAI8anpCrpu
	78KT7Okk8yn5KCWGzF24WeWiuIJ1sUYgktL/d5gJjh9ftcgsB2bVZoOgy2wBfp4BvNb9XbCjJxn29
	ss/nBs5IIKbiv8vHN1O7ohcrVc72AI7pHLdK62Yh2vyMAzH53voloLbBQPcm5+tOCUHgdwAWBDo0c
	Ci41HsNT7Z8OnR5iy0ZAiojC3z6F9J+ISRVk7maVNyORFqxQWSa+2DpsSNvQKg8QwNfEV9OGDwYLZ
	ncT8f1DA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkhgz-004azz-1n;
	Fri, 17 Jul 2026 12:29:25 +0000
Date: Fri, 17 Jul 2026 05:29:21 -0700
From: Breno Leitao <leitao@debian.org>
To: David Lee <david.lee@trailofbits.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netconsole configfs target release NULL dereference
Message-ID: <alofTTGY0Pbk9nk3@gmail.com>
References: <20260717103903.38514-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717103903.38514-1-david.lee@trailofbits.com>
X-Debian-User: leitao

Hello David,

On Fri, Jul 17, 2026 at 10:39:02AM +0000, David Lee wrote:
> configfs target release can call netpoll cleanup with missing netpoll state.
> 
> Mark targets as disabled before releasing their netpoll state and skip
> cleanup when no netpoll device is present. This prevents teardown races
> from reaching netpoll cleanup after nt->np.dev has already been cleared.
> 
> Fixes: 97714695ef90 ("net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal")
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> Assisted-by: Codex:gpt-5.5
> ---
> 
> drivers/net/netconsole.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 862001d..ad30e2e 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -287,6 +287,8 @@ static bool bound_by_mac(struct netconsole_target *nt)
>  
>  static void netcons_release_dev(struct netconsole_target *nt)
>  {
> +	if (!nt->np.dev)
> +		return;

I am not sure we get here with nt->np.dev unset, otherwise it will
panic in the next lines:

netcons_release_dev() calls do_netpoll_cleanup(), which calls calls
__netpoll_cleanup() which dereferences dev, as in:

	static void __netpoll_cleanup(struct netpoll *np)
		...
		npinfo = rtnl_dereference(np->dev->npinfo);

Are you hitting this NULL pointer dereference, thus, we need the early
return above?

Thanks for the patch,
--breno
