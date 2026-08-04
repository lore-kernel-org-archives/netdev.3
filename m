Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB03EA66;
	Tue,  4 Aug 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804652; cv=none; b=TFQhMfv47KxdMZtYoEBivMaPlgte6OYXCq7L7Pfj0Xo4OjWXP0uaY524U6VBDtLUNg5yE/dXUGxvhlrYC6FLvkAEL0u7jscEx30DrFHVKyDtxydXk4tZaw2i27KtvQZA8MExOclJ7zDle1ZN0cd/soZpSgsWMiR3GQ0HztuJPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804652; c=relaxed/simple;
	bh=9JWDOeM7XxRSRi3LG0cC1wx4SR+75GxfaJM6yuGDQow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ixix6Oz6anN0E+ME3mse1NaNXp3fneEVXaezQm9wM7RB7yvGQ1D5VVptyGSaAHtFuBWvNzO96OesG0DnvGJ5pB+CK/DSGeJXM0sUF52ZChc8MAQ6rx21OsJS1D1hvNmOzFeY1+yYI2VTg01t9fG9UWk8nQfDkGs04iW9LR6lEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRiHyw1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRiHyw1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C6C1F000E9;
	Tue,  4 Aug 2026 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785804649;
	bh=ikesVMyU8GIDPp0PUGYx0cWmJ5xN4U6c26tRvP0TWKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cRiHyw1DRr8KtiYWWb1oOq5Q74/VYv5FLnzLlSjNwT2UM/M7NejIORXZM2jaKLSBF
	 VtmtYKHyKgM+gmrguISlg+u3ImxpuYvhM61t44Ys6Zd0cWOTvI4kkCGinQq2Wak7ms
	 onfUoQmC3X9TqTrr2ds1qM0mn+rPEHIGJZN4YHh5JjoIfDt/xKI1N8qg+WaLfKLYz8
	 5EUkCsMY2FX7Q2/8lfJKQe2pjm7N0P4UfarRug1cQe7OVFt2sTG3pUf7pjXb21ZtA7
	 hDPRE53nTYWd0gHQkW/QB35dmykZnUh5+5VuO6l3VQ53dFbsf9Xny4CoULq0kWL69r
	 sFuvvUafOZl1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB33924467;
	Tue,  4 Aug 2026 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: only use MAC loopback for
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580461039.2897167.3732640516841415246.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 00:50:10 +0000
References: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, o.rempel@pengutronix.de, zxyan0222@gmail.com,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 17:57:25 +0200 you wrote:
> stmmac selftests currently use PHY loopback when a PHY is attached, and
> fallback to MAC loopback otherwise. PHY loopback however isn't ideal nor
> necessary for the tests we are running, that only stress the internal
> stmmac features.
> 
> Some PHYs bring the carrier state down when in loopback mode, which will
> prevent any packet transmission even for ourselves, making selftests
> fail for non-stmmac related reasons.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: Don't use PHY loopback for selftests
    https://git.kernel.org/netdev/net-next/c/1528af830077
  - [net-next,2/2] net: stmmac: Don't rely on the PHY for flow-control testing
    https://git.kernel.org/netdev/net-next/c/48806dbee0c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


