Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291DC3E558C;
	Tue,  4 Aug 2026 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808255; cv=none; b=mAVOuPSFvqke+EMDEJIhbvdWyBDtASh/NI+hiR354BQhUnNmeRT7dZ03RLrJa8lu9ZeBdd0pLILuTSun0MnoBOvnfYX/PMROSsBwuHyZiB8lkGmYudanbCJDAWhne8f8gH2J2ij8IAld5Y6l2VZCFjwGqQRW+vrWR3Jvx2oZlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808255; c=relaxed/simple;
	bh=+PqGprqTDIau62+jk5ljN0hcs9P2jnk9JCeWvSs2WHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gNFoHgSjGOSKetPIumz5tISgEZEsRmtuLy4dixH3y2JlzHQry20FjFZlbJ9B8m7RJZRYZw1fLxNjSNq54jkJtW1CmAhKi9kUa/ZHb9wzeMQXA2mxRBUSdTKqKGm7l5ykgRGz6eiER7+ZSS/PlLUD3v+9W8IjPARgAIwJ+qDXg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYTO2P35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYTO2P35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8461F00A3E;
	Tue,  4 Aug 2026 01:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808253;
	bh=VkGB+ach/sz+Qx+EPBIcvK5HnXNIKV8FeEl8ovVVHWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FYTO2P35L7Sn/+YlXU5FkfKEUk1AZSeAEwrEC8GS7KyljQ96g+58XUXnS7k4A52A7
	 cV5D3U1AbMbv/o8Krk8vQMJgK5CJIr6eBLzBubwC7R1S4YweEGtA5R0CQu6imHBRND
	 RYJouYUwh5w0x+jqvRuojhxPPoU3TtygekF2Dhm2lg2le8kgedd3bdQCAg3NP5L/9A
	 V8sUKZIGkHQDQW9mPmK/NUM23JK59E+FOBle6Qej1u0crIRiyq8Kw1gDm4hC7CVAn1
	 +oYvTMx3bOe+0uPE1IOA7IRsMBO08US9GTT928ghWdimV5rwcqfdnmFZCM/dMb+CL9
	 nOk5Y+mVqE8gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BEE3924467;
	Tue,  4 Aug 2026 01:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: Cleanup rx coalescing
 computation
 when using RIWT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580821438.2913307.10017683576948175054.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 01:50:14 +0000
References: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Aug 2026 13:40:12 +0200 you wrote:
> Currently when configuring interrupt coalescing on devices that relies
> on the Receive Interrupt Watchdog Timer feature of dwmac, the
> computation of the RIWT timings leads to off-by-one values when
> reporting the timings back to userspace.
> 
> RIWT works by arming a watchdog timer upon receiving frames with the RI
> bit not set in the descriptor. The timer duration is expressed in units
> of 256 stmmac clock ticks, and therefore requires a bit of computation
> to derive it :
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: ethtool: Comment the magic numbers in RIWT computation
    https://git.kernel.org/netdev/net-next/c/b6a89c8ef34f
  - [net-next,2/2] net: stmmac: ethtool: Address off-by-one when reading the coal rx-usecs
    https://git.kernel.org/netdev/net-next/c/ae88f78bc4eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


