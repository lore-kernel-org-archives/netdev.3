Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D74A2A6E;
	Thu, 15 Oct 2026 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069210; cv=none; b=R1zwoT4B06kHa8F6PTK0T+pj+ZTsWk6dSOMM9nk9jUpTbKbMszMeDBGiYmUS6upk1S0/FQrkFIyELW9dsfKv6R2hWoYomd7jHpkCTCxqkc3sS6v4F6YTM9pFHZZOF5L+ihBMFv3UDG7bQ4oQHF1pU8AHou/HmvrR5XVsgN8P3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069210; c=relaxed/simple;
	bh=ucz/F/R4tKXfbA2slqJIp4UhMivOpvFyAlmYB5GhpTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTvxmthDEvEEHKt5WFBnms3pK5JjWSYbiC9yMvuCelOuzjg7/EcdXmX8TlFa378bEr2GABreFq6ryn455GTAOZ4UwQV6r7VJTQ/7XUHWdx/E/xCJKXRm97gX2hrqgHQ3k5n5Dcpa/N06GosM0OE+V3f3lON5g6il9wRJ6Xlqfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RumX4an3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RumX4an3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E871F000C4;
	Thu, 15 Oct 2026 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069207;
	bh=HWTfC5K89lkNZnNgOaqM40wk6WYWlsj4gyMe+x+8pqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RumX4an3dTCHK4ViRVTayHHYmg5HJtRca1lrJQj825qt7U67pZT1FVF2jteowr+t8
	 2tC95Crv910KGDMzgmKkHjNh367CJOlHUOrT1jmTzi5yolLtKRPj9gV6Yz4r7l1Vvx
	 afZ2Fk+PlCcLHuTOrq1huWtD2+FbB9BoEw/LPrbM/QJKkueuaGHGYz7xDngZO2Ol8S
	 V0bSkZAEtCVKW6dmv8cU9V43TEzA097Qj47Ow38Cms7FgPBKt/6ebQzAmD3hbzHtl0
	 VvP0NUkvy8j08wtRp50850wnx+l4GiPka3UyMtW6LaA8Hm/VQ1vCF0Do4dUW6uEhb6
	 XIcIQsnB9km6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A30B392EA77;
	Thu, 15 Oct 2026 13:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: stmmac: dwmac1000: clear the RGMII status
 interrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179206920579.3420246.7646480278225164720.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 13:00:05 +0000
References: <20261009201709.1917585-1-iav@iav.lv>
In-Reply-To: <20261009201709.1917585-1-iav@iav.lv>
To: Igor Velkov <iav@iav.lv>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, daniel.machon@microchip.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Oct 2026 23:17:09 +0300 you wrote:
> Since commit 2e2c878a3141 ("net: stmmac: remove SGMII/RGMII/SMII
> interrupt handling") nothing on the RGMII path reads GMAC_RGSMIIIS, so
> RGSMIIIS stays pending behind GMAC_INT_MASK from the first link change
> on. stmmac_resume() resets the MAC in stmmac_hw_setup(); the reset sets
> GMAC_INT_MASK to 0 until dwmac1000_core_init() writes the mask again,
> and the pending status storms the line:
> 
> [...]

Here is the summary with links:
  - [net,v4] net: stmmac: dwmac1000: clear the RGMII status interrupt
    https://git.kernel.org/netdev/net/c/aa07285705f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


