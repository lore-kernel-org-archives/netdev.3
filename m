Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26E3E0255;
	Mon, 17 Aug 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959351; cv=none; b=GHzGTfNLM1xukQO/m3T9MPCi/qk8EdEYxOzAEgyt2xZSO+giFDf2v253lbP2bc6ne7Rs3Nb3j1AeLRCJaJnHq0Z/wdUeM/goYMdVaLecSZO9lVpxZRXF8O/r2W1l0jcF4ZMIJfGpa5vz/0hnChZVz99KKMY1YCA8G1hu8mKjFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959351; c=relaxed/simple;
	bh=s6cZ5OlhmhSIHVxSGQJlmFwZCfc5QbGjS61PxpZFzrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY9/eC8To3mC1n/fiULpzCAfjQl3qfdWDnOuYf5PxAGgZqXatFKZtExY3N/vzTIWIF0egT5/WUeDH+BrN9CRHjn1vm+5tJFY3uv3DeWS8t8JrqVzlPt4lGEpo7YI5HIADGTD4tmF8tjyvFNGVBgcZcOEGLxVoDYWe0OA0Up+87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBwNCm0r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBwNCm0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622421F000E9;
	Mon, 17 Aug 2026 09:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786959345;
	bh=OZFIrUTfmcLA0aBdxifw/G1V2+al2FZYFpSPhR7o95I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cBwNCm0rgj390FwBKO4V+GmYOUjunbKaTTWOOkAIXFn+3Kn1FxJ9MIuE/qIwOab1X
	 sCG6e6csZ48C6W5gGug80rwjqy6WuWaSHgmw78GGHGVkXXPrrkf7VKyWsELzAvKZUd
	 ReOForq4NOF5GriXeOIttIi9lcwudlJlrCTx27HjFJ86pnUvMtfiAcT7bRz5nxv48e
	 VCmIUaQyvGbbAdlkyHCMushtKenpYCgJH6f0L5XFaQJ9fQKlt8rRn/181Jawhu/Fs5
	 Nb8S0wjkoqcCipHYKU7dpGeDFE/pyYaRsrt0rDlhEBkEV/BTL8u1a+4bsM+QAn4HZ8
	 wkN5axELmZOHg==
Date: Mon, 17 Aug 2026 10:35:41 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Sercombe <sercombe.joel.mark@gmail.com>
Cc: cooldavid@cooldavid.org, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: jme: fix typos in comments
Message-ID: <20260817093541.GW265046@horms.kernel.org>
References: <20260813173634.461011-1-sercombe.joel.mark@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813173634.461011-1-sercombe.joel.mark@gmail.com>

On Thu, Aug 13, 2026 at 07:36:34PM +0200, Mark Sercombe wrote:
> Fix several spelling mistakes in code comments in the jme driver:
> These are comment only changes with no functional impact.
> 
> Signed-off-by: Mark Sercombe <sercombe.joel.mark@gmail.com>
> ---
>  drivers/net/ethernet/jme.c | 4 ++--
>  drivers/net/ethernet/jme.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Thanks,

With these changes these files are now codespell-clean.

Reviewed-by: Simon Horman <horms@kernel.org>

...
