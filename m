Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509420;
	b=k4H4eod/GOvaf4LP7/W+1rgvacSzdxs0hXRgfdgS1a0jXGox0fNtCX84V+VQXpbCU0Ll
	 WYqI8MKw1ZG3Dfe5oZnyGGBcB6NDfTVvGTimbd9tkP18i9AlDWbDBq+rgbWyeHuIdX/6e
	 VE6NtxA0emmc/8aB/IYGLZWMCHq/JSe1KUKBHJcTrFpPdCukVjp4MRfsfd/dwWuspF0AB
	 OG5H65gZF/WVOKmGYOnp92J6zrJYqj3CWWBorNgR29l5vhXbtvtWZdHw9LTTB4tsu4NTd
	 2fboVhYktItJECeW3K4MSzRl7mfZr281u+Yr4wKtelrdh8MzaiyCbnSXN0dtOJCQ1QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509420;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0t7MBPoXO1zUEk3qTq2YgC9RWH2JSMEoFtgx+BcgY9Q=;
	b=k+YSDI5GkIw4nG9ki1nIZWGlBF62PJ8pj3NKEHKWPTMvFPQl8HjZTs2zdO4eGIY4uQu9
	 xyKA4cnOGBniQTo+Lii87G9U4RLd0WkISR8RnNuLsD9tRFNLsBU2PkilvNbUt9VqC/8hp
	 kvoh9mcY1iJUZY5Any0J+23+ZMvlDYVwhx0idMcgCSjj89zqJ8viS5l+tu2A9pRF6CjCz
	 Y1AnqYRRV5PzVgKfpws+JByOEEPPVfiVbH7EiXopq1IjcJau0BIfLjwV7EzE39Ll210cF
	 uX5NIeclpzXU8plUqEo4T2wp+nnpCwk/cM4i7GxOjPyzRRB5r276JnTGlFob6Teh6Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xot332U3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A760A3806;
	Thu, 12 Nov 2026 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xot332U3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442AC1F000C6;
	Thu, 12 Nov 2026 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509420;
	bh=0t7MBPoXO1zUEk3qTq2YgC9RWH2JSMEoFtgx+BcgY9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xot332U3xfnc8YPIYjyO3rbNYPlMwmHx2P4ug5T5hR1ctV+S3RTN3nI32lvbrOpiw
	 BxRCKG6f48eJNv1ZMSf5mmXJE8shvZENveMDMlko1ZCzW//70H2HnwIHGxYcL/LzSH
	 SS2OFxrHxjyiU5AFIj6Bg/GBE4wXCHabJYY1GG3Vk8onmh9mL+DplnSRMpse3o4LnV
	 VhKgy2p25R3xgMlo0UOZaNYZGYzIvSGt6BtpICmP6g0nowXPO/YTH6OXZL8HHRh5wz
	 Tz3sTBfddGrzvX42ehjf2r3IAJb47s+P1Jfqadl6iK0b4HsjvtmLWpVSlo4fDuglWg
	 Urp23ANGxRU3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A29A391AF9C;
	Thu, 12 Nov 2026 18:50:20 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/4] net: sb1250-mac: ethtool link updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450941877.590019.12889374228037218560.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:50:18 +0000
References: <20261110230300.2769327-1-f.fainelli@gmail.com>
In-Reply-To: <20261110230300.2769327-1-f.fainelli@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, macro@orcam.me.uk,
 daniel.machon@microchip.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 15:02:56 -0800 you wrote:
> This patch series addresses a few minor issues:
> 
> - Running ethtool against an sb1250-mac backed interface would not
>   return any link information, although all of it is there
> - There was no support for restarting auto-negotiation, also there for
>   "free" with PHYLIB
> - The kernel driver reports enabling RX Checksum offload but does not
>   report it through the NETIF_F_* feature bits
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] net: sb1250-mac: Add ethtool link settings support
    https://git.kernel.org/netdev/net-next/c/b1a2a220435b
  - [net,v2,2/4] net: sb1250-mac: Advertise and honor RX checksum offload
    https://git.kernel.org/netdev/net-next/c/f116890c4050
  - [net,v2,3/4] net: sb1250-mac: Add ethtool autonegotiation restart support
    https://git.kernel.org/netdev/net-next/c/47759d9a9f74
  - [net,v2,4/4] net: sb1250-mac: Fix RX checksum status and header offset setup
    https://git.kernel.org/netdev/net-next/c/e48003f359fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


