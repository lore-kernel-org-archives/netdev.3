Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234410;
	b=cWcac+bT+gm7+FmYuIcmQA5trKQA6GkHmcJiHyJoxOEW27c+I1J/RDYGlUKAEysxCogH
	 sx/EANVXeutzKmFLjvr/LKJC+TrXbuhliwOr2HjXGltIB+JmdYhbx0VgZ8WHZmj3GcC/l
	 NpLcmXjowzpWDYTl68FTkWPEAAAreOh2cN/NuIiuRUxLryswTvlN1qXWvzRwtMr4O4+jU
	 lSqHveBrcuczrzilY5anrpbblIU6g5fkZZ7zfW1nVjD5kgEC8TTmGf0faPwOaFovrJkn3
	 le7O8CWX89BC/VXkBgHRl2rSTMzO6L0cINKsyhRBzgvtSZP7STYDN6mVkkjOFJaSAFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=c4iBQ+UwOFy4X5YPlks+jc2xwGHej55He1MgtpRs7Ko=;
	b=ksW2oPbcNIyhhWaM0CqDmHBnGff0VJYzUxNVhbJrNzYgAZw6FDuSCgf3AKL9G31ptW5X
	 89YSMxPpdi8ht4B8jx7qhCgzBcYin9sm6c3t9djL0teCc2aeLNhrldIoZ6Bin4PocQIiL
	 KpsNrbh5j0EhR8mZ4J5qtn4c1w5bEx4pzGCbBxituKX/TnXHTX5vMXXIp6qO7hOJK+34h
	 /d5BJ6pDRxGiW5yF/Fj9C7ZMTl8WzpKnuBYo2JPTw44biSzbhXsIPuEETp1TL+PjpSF37
	 0i1shOf7JuqE/xa5ULXgLyva2oZeCdEZ6TlJgizKN95rn5cbhKD1m79Wmt0Ifpj2uOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azihWin7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD443606A324;
	Thu, 29 Oct 2026 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azihWin7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACD41F01825;
	Thu, 29 Oct 2026 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793234409;
	bh=c4iBQ+UwOFy4X5YPlks+jc2xwGHej55He1MgtpRs7Ko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=azihWin7Fnf/E+YT9dK3r8KdLbROgbTTQp0qkk0Eie87I4Q+6ux586RFYKY9Ge/W9
	 Wi2xxteAwnF4wC/oT9FGHlCH+Cce/lH7ovEMDBKI1RKqRO4SN7QoWBlQpNR5s/YpYC
	 pSS63mTXa8/g+gqoxuLcxd9/QSgh5LB1S+qFrDRymrNwZPdUt8DaauOZpWf5dS/mCf
	 6VhcvGTeiPgVd0LPcHwccRafm6q2vy11vaWm8lwIFO831UHi52eo9zcw/sLT5qhsis
	 GeA54/IP0mHQyb5n3WOm4dCHLroEBB17XTrmznYkCFV2oTXhJ6Bf3W8Bt7rjXRElha
	 9cn795m3ZniGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 814FE3AAFC4C;
	Thu, 29 Oct 2026 00:40:09 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/4] net: pcs: xpcs: fix runtime PM and clock
 lifecycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323440806.1500896.10740339691705828424.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 00:40:08 +0000
References: <20261023075214.1793922-2-coiaprant@gmail.com>
In-Reply-To: <20261023075214.1793922-2-coiaprant@gmail.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 heiko@sntech.de, netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Oct 2026 15:52:11 +0800 you wrote:
> This series fixes the runtime PM and CSR clock lifecycle in the DW XPCS
> platform driver, a misleading error message in the Rockchip glue driver,
> and the MAINTAINERS coverage for the platform driver and its binding.
> 
> The issue was found while using pcs-xpcs-plat.c as a reference for the
> Rockchip XPCS glue driver (pcs-xpcs-rk.c). On Rockchip the CSR clock
> (PCLK_XPCS) is required for register access, which exposed two problems
> in the generic platform driver:
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] net: pcs: xpcs-plat: fix runtime PM initialization
    https://git.kernel.org/netdev/net/c/49d8bbc21244
  - [net,v2,2/4] net: pcs: xpcs-plat: fix clock lifecycle for !CONFIG_PM builds
    https://git.kernel.org/netdev/net/c/eea365ed283c
  - [net,v2,3/4] net: pcs: xpcs-rk: fix cleanup action error message
    https://git.kernel.org/netdev/net/c/e7cccfde6136
  - [net,v2,4/4] MAINTAINERS: list DW XPCS platform driver and binding under XPCS entry
    https://git.kernel.org/netdev/net/c/87b88b658b9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


