Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9C23ED5E;
	Tue, 18 Aug 2026 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787013069; cv=none; b=QPoXipLQ+sZZ9nsBYMaUwOdH2TigvZbP6Vmbnjb/v+DG7Une3Qa2SoOX/mGNPUNhaq6pIgUqtKXJC01UeuOFzXW3Fr0+LaVyuyU9lXdgjIScWsLQMNkQ0MoGR5lWImQnyZ8h6JrGUdpDV4m7G63K2x4pECZy5OoVgyJfcwzhq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787013069; c=relaxed/simple;
	bh=F1C/wvDrBOLaW3dhT9g9RwqRaWHGQebWdh762rWmVq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DkFSiTVclj5YXX4ZLMLvSEAGQlYzVEmeZhYAXcyOu+qGXLHTUJNt2ZDwbHCNWloJdOzufpZ9/dlAizL5eQuhPyyq7D17VNK1e9W9mrD6+LWTtADgfoQ29+50GEzinqsrjRc9XLFZ20LL5F7Il+mJYqeOkAmdYC+lSdETPBx1txY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFrrX+Vs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFrrX+Vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A2F1F00A3A;
	Tue, 18 Aug 2026 00:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787013067;
	bh=SKYcvn8RCS01ccsdVsQV9z86TtK77AjiZq/ZsyzcqGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nFrrX+Vs/5hq3r5l0GRA+4GuXUsnSzBA/Qejp7zaX7mgccsGYBLhYcrss9cWRrAVa
	 NyhvlypkPuNfygvpWJ2+L58yDvo14bZIrk6eqenaEctYjxApODwv3VUUBbNizyZe/U
	 GO3BVYtfJLQOpdWduRupBkxrX+4zR1aeGru9eFZyS+ifWk0RwKAP93GP0OJw8YqWmH
	 P/pJCFLGrBMw8iC4NcrWWGIO08QYsGXAym5Y8FOG2QJyuCDw7PCmNgy8j2TgjNty0b
	 ZKK82ytrr/KmZ3mEDqHI7/GtcEqYyLpUItO9/nLqHcHS0T7qVahZXDAt/paHMlL50d
	 lQJnR6XtVfegg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199023926278;
	Tue, 18 Aug 2026 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 00/17] net: macb: implement context swapping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701301964.1803591.848691156619425357.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 00:30:19 +0000
References: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
In-Reply-To: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, pvalerio@redhat.com, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 benoit.monin@bootlin.com, tawfik.bayouk@mobileye.com,
 thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 10:03:14 +0200 you wrote:
> MACB has a pretty primitive approach to buffer management. They are all
> stored in `struct macb *bp`. On operations that require buffer realloc
> (set_ringparam & change_mtu at the moment), the only option is to close
> the interface, change our global state and re-open the interface.
> 
> Two issues:
> - It doesn't fly on memory pressured systems; we free our precious
>   buffers and don't manage to reallocate fully, meaning our machine
>   just lost its network access.
> - Anecdotally, it is pretty slow because it implies a full PHY reinit.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,01/17] net: macb: drop "consistent" from alloc/free function names
    https://git.kernel.org/netdev/net-next/c/ba6f76db61fc
  - [net-next,v9,02/17] net: macb: unify device pointer naming convention
    https://git.kernel.org/netdev/net-next/c/07362f68e61d
  - [net-next,v9,03/17] net: macb: unify variable naming convention in at91ether functions
    https://git.kernel.org/netdev/net-next/c/075663a6ceb6
  - [net-next,v9,04/17] net: macb: unify queue index variable naming convention and types
    https://git.kernel.org/netdev/net-next/c/2434dc6e1c9c
  - [net-next,v9,05/17] net: macb: enforce reverse christmas tree (RCT) convention
    https://git.kernel.org/netdev/net-next/c/2cedfce238c3
  - [net-next,v9,06/17] net: macb: allocate tieoff descriptor once across device lifetime
    https://git.kernel.org/netdev/net-next/c/5262eab9462a
  - [net-next,v9,07/17] net: macb: refuse set_ringparam on EMAC
    https://git.kernel.org/netdev/net-next/c/227fdb2fe6f9
  - [net-next,v9,08/17] net: macb: introduce macb_context struct for buffer management
    (no matching commit)
  - [net-next,v9,09/17] net: macb: avoid macb_init_rx_buffer_size() modifying state
    (no matching commit)
  - [net-next,v9,10/17] net: macb: make `struct macb` subset reachable from macb_context struct
    (no matching commit)
  - [net-next,v9,11/17] net: macb: change caps helpers signatures
    (no matching commit)
  - [net-next,v9,12/17] net: macb: change function signatures to take contexts
    (no matching commit)
  - [net-next,v9,13/17] net: macb: introduce macb_context_alloc() helper
    (no matching commit)
  - [net-next,v9,14/17] net: macb: move printk() calls out of bp->lock critical section
    (no matching commit)
  - [net-next,v9,15/17] net: macb: read ISR inside bp->lock critical section
    (no matching commit)
  - [net-next,v9,16/17] net: macb: use context swapping in .set_ringparam()
    (no matching commit)
  - [net-next,v9,17/17] net: macb: use context swapping in .ndo_change_mtu()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


