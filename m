Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA61523EA93
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984199; cv=none; b=TSY8XVyjGLXOxykjAhqS2/9WXIbxynTadxQQaNThD3cUHsHnn+DxYRwmnwiW6eIEKOBHyOuXNQOsMb49YTHKyoCiNK9n2jCPRiQL4u8NCYtGhUgWD05h3u9r3BFcvwaYHCN3sRwHfXL88aDCyHBDbkpr7QkdyZxxlG5YR3bOUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984199; c=relaxed/simple;
	bh=ddK31AyZnHETg4NLq71bUz5Xx+K/KKCyYtF+CrTfIAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpzQx9Prn9bFFu1pwghkoiZs1D4gVNZg7WBH0ymJaPkXQW/wlklLtnyM+ZgPPt4KZ1Rq1qwLIbvmXSXQXR4tc/RpH4le+JuDkBX6IRNZLG9P2cT5DiBjlPXZd3bwvKCNEJ+mysky7ZkR2Xm3HVmZQstDa9Y0tPB+KmVB6sbZTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFBnq+SY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFBnq+SY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF86DC116D0;
	Wed, 25 Feb 2026 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984199;
	bh=ddK31AyZnHETg4NLq71bUz5Xx+K/KKCyYtF+CrTfIAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YFBnq+SYbXX0En6K6IpMQgPebiPaotATLy13t6lE8GoeAwLIoLJfFwZyAGqFPp3Qx
	 rTSRGMEp7YRkFltd6+HDzTBvPYcN0JFI70qxNNGk2ZfThmZpafoNhwk75bF11odLg3
	 EXctO3A3EYKpRmSl7Ukw95BEqSK0Sj4Pc98zIj0dj15T2a5nHp1S1u0qptzCv+jGt1
	 tkZN7/WNwm54COvN8QEnwlcCXVXpVaBG2/9GQKjPJGBupxaTHMgWVhRYh/ARMIgqo+
	 DfcEXUjvPgLInpwCi1weXEcbI9SbiPe7yvAZ6XgzLrLTzEnltCmyRalX+sugl5CZ/Z
	 oYtRrUraYXNKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD03808203;
	Wed, 25 Feb 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: fix timestamping configuration
 after
 suspend/resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198420505.31093.8056819283468946737.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 01:50:05 +0000
References: <E1vuUu4-0000000Afea-0j9B@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vuUu4-0000000Afea-0j9B@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 12:19:08 +0000 you wrote:
> When stmmac_init_timestamping() is called, it clears the receive and
> transmit path booleans that allow timestamps to be read. These are
> never re-initialised until after userspace requests timestamping
> features to be enabled.
> 
> However, our copy of the timestamp configuration is not cleared, which
> means we return the old configuration to userspace when requested.
> This is inconsistent. Fix this by clearing the timestamp configuration.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: fix timestamping configuration after suspend/resume
    https://git.kernel.org/netdev/net/c/2f61f38a2174

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


