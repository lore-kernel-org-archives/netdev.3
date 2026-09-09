Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B3492E5D;
	Wed,  9 Sep 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913271; cv=none; b=kT0ep0/UnPODZIbAKGuOCChPrw9PrIGSQhhI3OadOyVcY/2duLKZxE7/aJisunv2SyejwpMQqNkYEbJiu202jPA3xX8knBt3QH/RvYFmQlM6ppVC7nD3hZy63n11QTJBqhXYC1PzdTl4e5Sdv+EnqXl01HpvVveQb243zaD1Gts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913271; c=relaxed/simple;
	bh=078mCve2Y+k7srVMYxcGv/XI5TLobgEoWJqSIbx9fWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tBdt9iVUolF0FHy8+cqVRmBJTtPraaXvaxWYirP3VaGduFHhdgIDSn7NWhpwFTpT/QfrAGBsFmQOxWxamvqTW/s/h11sFvMxBg1D7XjWTwgWtnztsq8pfTP7tdheYos96tCvR0uoS1AVbbCWsEVRTohpMsRCQf/oWX2xnYXv1P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf5XitaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf5XitaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F085E1F00A3A;
	Wed,  9 Sep 2026 00:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913270;
	bh=BuECNqwhuOKEXhntmn293ifsdKXLU3HGA/7kHQtHpxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sf5XitaDHRN98Xum/Hx2a/wvGG7tMi4ZbqsvijqgGVM5bgS53OS/9siLuLHr16GRS
	 x4qtKGLIaV1aMAbKavVzqie6bZyy5ohx2OWH4M+bVWdk6+vqmxL6xxorOCRwb+zU5F
	 c8lBgVZjofWDNV8NweiDJGIhqaZ1Me/2nL/j1ELxL2Ug5jihCD3l5u1izNN0tRRbWJ
	 f3xcaHt7FTJ3lRmhN9Lrc5eqRn68vo3zvWnB5NLiqG3oTxdGaB2epjJ8i4MMIpokD8
	 GIW05KWEzFnz0aeRuKOGZnJKYKxd8gSCqi2bAF5mXXsKccV1s5v320fok7MWZCOIy9
	 rNmL+wkNU+S/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B1A380820D;
	Wed,  9 Sep 2026 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: phy: motorcomm: Enable analog
 frontend
 DAC on yt8531S
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891320812.76352.11462538996506591892.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 00:20:08 +0000
References: <20260905072830.28986-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260905072830.28986-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, hkallweit1@gmail.com, me@ziyao.cc,
 Frank.Sae@motor-comm.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 09:28:25 +0200 you wrote:
> Hi,
> 
> This is V2 of TY8531S fixes for the YT6801 PCIe card.
> 
> It enables the analog frontend DAC at config_init() similar to what the
> most recent vendor driver does.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: phy: motorcomm: Split yt8521_config_init() page management
    https://git.kernel.org/netdev/net-next/c/4c1028a34760
  - [net-next,v2,2/3] net: phy: motorcomm: Add a dedicated .config_init for YT8531S
    https://git.kernel.org/netdev/net-next/c/58e1bbfe4713
  - [net-next,v2,3/3] net: phy: motorcomm: Enable analog frontend on YT8531S
    https://git.kernel.org/netdev/net-next/c/031c64bd1b02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


