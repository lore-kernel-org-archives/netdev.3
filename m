Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC445A299;
	Fri, 14 Aug 2026 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698660; cv=none; b=k1mqMrcqsVyW8ByvDFYejVGd2Uq9Helj0BYXPv89dZo2MIt6Y+MZ8k1QsF5da36XDYdS69tB0UeJPGhsxM8nSHxS0sx2i4GScqjTtKtzErG6AxFy2WBtIrz7cx+CVlVNuoM+9NO9qPN+avGt0TKlxV7gkMG6b73YImunaeDDrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698660; c=relaxed/simple;
	bh=u41edZ0AxevLsnLsQvXY1uXJwA72FDwQfqpV0I1p0ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duj+J6J6TLyvMDdhz9+HPxuT1rZu1pFtnPZvBbUP5cTqH+0RrYYLv0QgHe5O44OIZJbs+mGQS8GIzaix88RRaOZ+OieFwDcK8sR4a3WTUKS62R6moejmebf4cfBj5/mk+sybtoQG/59BjZbNwgUh2o8zXY2v4F4GRNsOL00x8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHhwOMwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHhwOMwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BED31F000E9;
	Fri, 14 Aug 2026 09:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786698656;
	bh=EUh4fQFl28VhXNyK7IbMFFh/5WLjzUrBd04PKbeHBF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mHhwOMwLBwwwCHs7VZOws2Rx0rdRzsPe1EamDa6QnBN0fszzuanZSR7uOsBkFqqTC
	 zBL4n550CxvsxJLmbuDl0Jw5q5NAAsrWYyEIITt5adcqfEuoLu+MNnpEnSaRY+zjPb
	 P7I/p5ezEg/Rb6xG/mjer+yZiKHCa+Sqt/I2UXVmm7FZLxxaigKrG4mUAMK7ysEmUV
	 8ZKmjqkiFX9jucW2lfrJn4Vz2jmTDVzHLnvTBEcV6TjNBslFAlEquC+xIuZCS86EOK
	 Ywi+fZUqfnaBY4GpJlisuDwGUinV+1hYD60OwTh6ohD53XwryBcCSYI4udhLSJir2j
	 Cgj0wZ0QswAmw==
Date: Fri, 14 Aug 2026 10:10:51 +0100
From: Simon Horman <horms@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-af: initialize lmac_bmap in
 rvu_mcs_set_lmac_bmap()
Message-ID: <20260814091051.GK265046@horms.kernel.org>
References: <20260812060730.6181-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812060730.6181-1-kmehltretter@gmail.com>

On Wed, Aug 12, 2026 at 08:07:30AM +0200, Karl Mehltretter wrote:
> rvu_mcs_set_lmac_bmap() declares lmac_bmap without initializing it and
> only sets bits for valid lmacs with set_bit(), which ORs into the word
> without clearing it first. Bits for invalid or skipped ports keep
> whatever was on the stack, and the garbage is stored into
> mcs->hw->lmac_bmap.
> 
> Initialize lmac_bmap to 0 so only valid lmacs are marked.
> 
> Found with Clang's -Wconditional-uninitialized.
> 
> Fixes: ca7f49ff8846 ("octeontx2-af: cn10k: Introduce driver for macsec block.")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

