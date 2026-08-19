Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E44078D9;
	Wed, 19 Aug 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165693; cv=none; b=Q7pi01CbZdjVaLX9fIt9eMJwiUjlqdFvUImI6R4caV+Xi2PAQ2R0xwMk+xg9L5KQ5evrO2EuBFHUrFz0CbDLIVE8R9b5zX0wI4LaQtPvtEbJmEiiKszEoyrfbpT4+dpm1RWwJY9elUN32Ht9w6K0JogKYZ3JUr6/aFAPKjeGsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165693; c=relaxed/simple;
	bh=DqcoOFLlXSXv/BN1rxl1Xq6+iQ/9iTjan+k229L8apE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVnGtb4i0duOCh+yHNuo0ynRXWDAOmxrexyJE3LPg6a0jWX5YZR1MqJW44wn+o58jnWutopgS/ghTxmrLhlTLeflx8EHHy5FAufIHBWr9dHfjB3GE2f0n429okDthE0bps3PhbVPxxnVpRSPump0fSKZd1/OtJtaZ8paTT/hF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfJWKt4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfJWKt4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2866B1F00A3A;
	Wed, 19 Aug 2026 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787165691;
	bh=Hn0UEhp2cSzsu9ulbcVN7XtKz3XcxaVEV3FtysADyy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BfJWKt4HZeaWRSqf/+j5Rk49ZXapRaDbb0kG7SO5fMSPfR6DPPj2qPU87xts1k4Yz
	 bkDN2XyUg3PlmNVJeKPop86Y6Aghdc1/ZDIL9g7inivtH4h/EwloyJ+mpyf6OHQNFm
	 fRPEeOSo6QLJtXc53kMFbSlxWDYe0bEaVdlWZEEjnkG1f9iK3KYrAEJd0QBuSOdxtj
	 TWWCTL7TIknQH2CPUzEjAgogmSM3t6h3IizxApsPuI/TKK2sV8Q7s2pVR9RtY5vKsB
	 lLVW6EU4wKPL/FRwSzy6EIG3uAX/nfWQCckqG6XbOvj9izHBDiPdbYqC+2PdvhAGMF
	 7RB+KzXKKm9GA==
Date: Wed, 19 Aug 2026 11:54:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of
 CONFIG_OF block
Message-ID: <20260819185446.GA12505@ax162>
References: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
 <DKT4CBU8YB5G.2W0766H2NU6Y8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DKT4CBU8YB5G.2W0766H2NU6Y8@bootlin.com>

Hi Théo,

On Wed, Aug 19, 2026 at 08:06:48PM +0200, Théo Lebrun wrote:
> On Wed Aug 19, 2026 at 3:14 AM CEST, Nathan Chancellor wrote:
> > Commit 5262eab9462a ("net: macb: allocate tieoff descriptor once across
> > device lifetime") moved macb_alloc_tieoff() and macb_free_tieoff() into
> > a CONFIG_OF block, breaking the build when it is disabled:
> 
> That commit message is somewhat off: the commit created the two
> functions, it didn't move them around. But indeed I was wrong in the

Oh correct, I misread macb_init_tieoff() as macb_alloc_tieoff() so
considered it a "move" but "placed" would definitely be more accurate.

> location where I created them (argh I hate #if/ifdef blocks, especially
> long ones).

Yeah, I had to grep for the pairs because this one was so big.

> Can reproduce using my host toolchain easily:
> 
>    ⟩ unset ARCH CROSS_COMPILE
>    ⟩ make mrproper
>    ⟩ make defconfig
>    ⟩ ./scripts/config -e COMMON_CLK -e MACB
>    ⟩ make olddefconfig
>    ⟩ make drivers/net/ethernet/cadence/
>    ⟩ echo $?
>    2

Yup, same exact reproducer I used.

> Here is an alternative fix proposal: let's drop the #ifdef. It will
> avoid any future error. Almost all drivers have no #ifdef as such:
> 
> ⟩ git grep -l MODULE_DEVICE_TABLE drivers/ | wc -l
> 7458
> ⟩ git grep -l MODULE_DEVICE_TABLE drivers/ | xargs git grep -l CONFIG_OF | wc -l
> 391
> 
> Yes, I know this means the match table land in the module in !OF case.
> Almost everyone on the ML I've seen seem to consider that it's trivial.
> Apparently it's even useful because some ACPI can match on compatible,
> somehow.
> 
> Opinions?

I am always in favor of dropping #ifdefs to make it easier to avoid
compile issues like this. If that is the route we want to go, please
feel free to send a patch for it (or I can if you prefer).

-- 
Cheers,
Nathan
