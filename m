Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4E2F49FD;
	Sat, 18 Apr 2026 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529218; cv=none; b=biETIoqba/kPTyu03C7sZTSFCIage71yBdOYKLQmyeO2Jxh/mMpQzzO0DS0nqY/BN1D/7ZzXwtyvvcws27gYb9BlIvzmRgIToOmAbOiiKqsHv8SMsxvkLu/kX++jhsjQlkrNBBmlJqQwgTU1ALh1aUpIECHWltS0fXd8D6Lw8jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529218; c=relaxed/simple;
	bh=EIjYDe0xPJOFXSYpMHjH8yUdClaex8bha0Dj2cNb544=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkB+KV/VfqpVDwW+A2NYTQeKOkj4GfRyHIViwYjn6r6++yKlUxBloqKDovvh/2NDq6uHjQ0cB39p9OpyWiSM9IKvxwhtwYOSS6EAcUyw0ypMjKWOHX1uhdiycuKKGobR0m0JPYQFygonwiCbXrxFnGBGW8XQsNokGwSSKUwrJ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIzdnpOG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIzdnpOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E837FC19424;
	Sat, 18 Apr 2026 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776529218;
	bh=EIjYDe0xPJOFXSYpMHjH8yUdClaex8bha0Dj2cNb544=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIzdnpOGm2Ko7fW6FUbzkT6YLm15XlLNsSeh/q/ZIpkhoQNlf52+nwKu7CkIrGnJb
	 iyWFVp8glbERWuZWGAGlPxN1YMaPXpdY/TgyHJOK9fm9SfjiqGnOWrmeKG6iozvLrQ
	 Lmj8ZjCeyWRRoTcuJoYzfPRvmK8UxWgG1ogCwJ4sUFyjeIyJ7rgssK/a2VX855QRx/
	 l1t08SpxXR6pp0hQGv/A691k71brDcTn7Pt0+nFKOwS6Az/1NZ1yyjOex7hCl/A4wj
	 z8i6ZytfheJpxLPBUkBtbZ/Nu9rAtdpn1BmCJjAW666Dc4uVrRi7AhZ4CCKblvOL4Q
	 hX6ZVlNcz4qTg==
Date: Sat, 18 Apr 2026 17:20:13 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	dan.carpenter@linaro.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH net 2/3] octeontx2-af: npc: cn20k: Drop
 debugfs_create_file() error checks in init
Message-ID: <20260418162013.GG280379@horms.kernel.org>
References: <20260416035352.333808-1-rkannoth@marvell.com>
 <20260416035352.333808-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416035352.333808-3-rkannoth@marvell.com>

On Thu, Apr 16, 2026 at 09:23:51AM +0530, Ratheesh Kannoth wrote:
> debugfs is not intended to be checked for allocation failures the way
> other kernel APIs are: callers should not fail probe or subsystem init
> because a debugfs node could not be created, including when debugfs is
> disabled in Kconfig.  Replacing NULL checks with IS_ERR() checks is
> similarly wrong for optional debugfs.
> 
> Remove dentry checks and -EFAULT returns from npc_cn20k_debugfs_init().
> https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/
> 
> CC: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/netdev/adjNGPWKMOk3KgWL@stanley.mountain/
> Fixes: 528530dff56b ("octeontx2-af: npc: cn20k: add debugfs support")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

