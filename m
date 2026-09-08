Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9643CE42;
	Tue,  8 Sep 2026 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864780; cv=none; b=oe4Y63CuWFHKQk9ibvEbZ0lxSO9+B1X00mjby3UMNRpXf5KlbzvCE7IL7wf06uNfAQLnTgeS06DexxkRKG5mhV9Z6ked3M3OUKpFCBfHDF5HRYGc+qpEXW0RvEQNHgGlg2LXdHm1hJGdv6ENuo+9HVVj+cPXWUR+7Az4Y8vRkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864780; c=relaxed/simple;
	bh=Ra2t7zEnqkRWuYeek1PLxNIYGZxdxVDXZpfKjQp842Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho5PRix1ge2CxC63tnypRoxrz87Epzj7CiU3sU5cMIsiafA1sAmCZSOyotVoI/JbfNab/uys6PFS5vqzdLLO0Vlmgu7Rs52jiNH1X6+Q/iGSGvAu05jO3D8IsBoTLhBHz76CJWoxO/K4TWMxP21W52CDLUuTcbJcVI6TTCNbEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/7Lc15P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/7Lc15P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A7F1F00A3A;
	Tue,  8 Sep 2026 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788864776;
	bh=jh4q2SfgrC2c/XwzGGucjV51ZrTlQ89D6bANP8tu94Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z/7Lc15PlfN84qXwn3HlKZJV7xTgIEYtPKOWG8o4WOJhQZNVp/eAERxk3LML3IqA5
	 WDofUWIQ+GGCdGJVHtjuKABxIIi6Pb7/6xAgjiIzdmjKJXjlq1BFRKdcNLiLJVYjXX
	 ajstaYZgpluwgOYkiYVIDoMLjA79Sj3Kjm6Mhf0WSi6dCcxbYg2X0/8Akmj0Bwgglr
	 hB2Fys4lnitDpiHAfceJuuloPG7z1xKZ8idO8Ngn01oN6NKWx/66esvvX/u5GzVusp
	 cDl5ycU6xeUIYTcJJrQ1B8uwanLVCJtdaFJ1/7CLNLJ05ciN5UEroGNLLTomdz2HyS
	 I6hfxBL7PxosA==
Date: Tue, 8 Sep 2026 11:52:52 +0100
From: Simon Horman <horms@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: smc91x: Remove stale documentation
 reference
Message-ID: <20260908105252.GS40544@horms.kernel.org>
References: <20260905051944.11604-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905051944.11604-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 07:19:44AM +0200, Karl Mehltretter wrote:
> smc9.rst was removed with the separate smc91c92 driver. Stop
> pointing SMC91X users to the nonexistent file.
> 
> Fixes: a3fb9a5bf660 ("drivers: net: smsc: smc91c92: Remove this driver")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

