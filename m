Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482615;
	b=ICSo0+gisboTvJUc+EzWebhfGnq4VE4UWnKauD3+G/vJx4T1zm/q9zD5lrcVva1Cd2j9
	 GUByWWwK27rC4/WF+ZAEfC3hTqJnZM8uiHXfE3yvSY1fL78fHQt2GPpBzaZEYps83Dgbx
	 M9lE0QTHfPso2zCTZOxMo+tY+8AS4tbl2KFLN2H7DyTUuLwSaDVoTgvjHxN37LUb+EBYk
	 7o5nGGXV/UplRcdm5rzS9OBR7+7gbe9jZN0xV880XtZdMRNJ1mYuk4p7BommadRqv4ETS
	 /oOyMU5/8GMUXjPSSlb4KNrH6P6HBsYqYFFAktrme1K7AHkdNOfNIxRRyarNgKPRIOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482615;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=aj9CdbUCldx2gcYOrVi6loEUg6OKj3IJyLv5f0F4OfA=;
	b=sT8raBW8i6Xw3REl4nxQPzmhJhzUVSqauOCpHKHY+MVlncN17cVINkIWuegCi+K6vc4N
	 9enkFUl6EUYlaJKLYDS1cpNAXmcJr1mU+sVdY0g5B2oAe3xNh9AT50eYGAxk7lXxiGCls
	 Z2d8xFv4+GUvUSTw5mz9FMCAVqS7oC/uCCv7WbsKYQkZP/LWeQY0vgXt3LmilY424yrSS
	 mZmP6bo1vyvz08+iL+HvXbzPWmEVmfb/SO5gkAalgv3RZf6zOVofCpXJ2B1F8oZIMrdng
	 TMqhm08Opp0AuH1Rpq3cNZ4gbELZEPHKMHYQPxtjHdWckVZcROww1IpD0SSUIINnaOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQ85VuFY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9C606A319;
	Tue, 20 Oct 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQ85VuFY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084BC1F000C4;
	Tue, 20 Oct 2026 07:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792482615;
	bh=aj9CdbUCldx2gcYOrVi6loEUg6OKj3IJyLv5f0F4OfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cQ85VuFYm0aDwNjIgJsBjUS9GEmSSn07zHUJJRF+Ra+0U4wgO3vjcfGYJk14QqooQ
	 Ns5R7Seu/MgBw1S6shCFnxMfmPbLVqmvBqZhKw1kZVACrwvl0PkZ1Wzu6o7F0KEvzz
	 rX2JeoGA17/x2hNhcV/jKkVXXt5VpHeATvLFXVjOjFADYl+fCRM491USNbPJzmfGyK
	 b39AxtS4QzXwGAWeWootrar5CCMjkLGnAVxIBjsgNUMwUw339m5eu4K/lgFMR1BaQX
	 cdsDQqU3SrG0IiNYz4fOgMxGH+9Z7OcBM1aLun5Xm3b8KWtpOb4G8eUvW3jFq9Qlry
	 qf52dHaWnB6XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14623924FDE;
	Tue, 20 Oct 2026 07:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/9] net: macb: implement context swapping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179248261378.3556861.3740380461349419952.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 07:50:13 +0000
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
In-Reply-To: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pvalerio@redhat.com, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 benoit.monin@bootlin.com, tawfik.bayouk@mobileye.com,
 thomas.petazzoni@bootlin.com, stable+noautosel@kernel.org,
 sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 15:16:38 +0200 you wrote:
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
  - [net-next,v11,1/9] net: macb: close race between NAPI polls & ndo_stop
    https://git.kernel.org/netdev/net-next/c/ba16ad3c8769
  - [net-next,v11,2/9] net: macb: introduce macb_context struct for buffer management
    https://git.kernel.org/netdev/net-next/c/435345c65180
  - [net-next,v11,3/9] net: macb: avoid macb_init_rx_buffer_size() modifying state
    https://git.kernel.org/netdev/net-next/c/b8ab596dabde
  - [net-next,v11,4/9] net: macb: make `struct macb` subset reachable from macb_context struct
    https://git.kernel.org/netdev/net-next/c/9bfec20d011f
  - [net-next,v11,5/9] net: macb: change caps helpers signatures
    https://git.kernel.org/netdev/net-next/c/dd1aaefee4f6
  - [net-next,v11,6/9] net: macb: change function signatures to take contexts
    https://git.kernel.org/netdev/net-next/c/ed16494c2c50
  - [net-next,v11,7/9] net: macb: introduce macb_context_alloc() helper
    https://git.kernel.org/netdev/net-next/c/88e99640fcd0
  - [net-next,v11,8/9] net: macb: use context swapping in .set_ringparam()
    https://git.kernel.org/netdev/net-next/c/dcc3288b9433
  - [net-next,v11,9/9] net: macb: use context swapping in .ndo_change_mtu()
    https://git.kernel.org/netdev/net-next/c/a98375924d64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


