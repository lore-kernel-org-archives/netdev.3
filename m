Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4F3F1655;
	Tue, 28 Apr 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373448; cv=none; b=s75wBaf4gKQ0SlTwq/hsxtShuiyJCupst/X8iqHDLYT6Z+P1cl+UnnYGOOBSgthVIPfhnJnhnePFnfi03fkgcjdH/1WqdRg6iXvjY5uGnCblqpHQ5igWTFnkUvwKIREY9vtSqqsNCT+vBLrhgRGyNJLKcuVE9KIIrz5+3BlSVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373448; c=relaxed/simple;
	bh=0cuZ4nY0AbQu+qq/AL+Yse47A4Z10Pa0BfVJC9kTurM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dDU/Ld/VehMDsbWKn0jFAz4Le8fxgCfADRtZn0mYPYyd7XDfOEaYn9cbeP+js2jpqA8Zw2VmO3/ownRvHcE1BiztQpP5C2pW+sbOo4aOOsoXoMVSe4uIFfMfxjNcxrHVeQ92EltFavjOBJRj3K16PwTrOec4xlYN2EZ/KGacu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKk5tgQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKk5tgQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B326C2BCAF;
	Tue, 28 Apr 2026 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373448;
	bh=0cuZ4nY0AbQu+qq/AL+Yse47A4Z10Pa0BfVJC9kTurM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DKk5tgQcak2+Ipn1aFgnj+gK7y+qMU+mqZLdurDKXospQQm0b5lWg5kEVOCh0yFrS
	 wnHyeh3o/G4zbZ2Nmg45NX7CL1ZMKo/9AEjeF14WvsAS6XF6+NWqYqSq2D9BPpzIT0
	 Bn0yalC9+9y0a1Zqiupd590wdA0HMUTwaGAGTXthW9ErGIR1yRv/5MOJWu138jEVo2
	 5wLR5pPWwDPM6ZOHgaWY1jaG4Aizuyxpe5Q9lJJWn7qWb7vaKDaWPqlMSs6bEkKFAF
	 /YP4yhNGwwXwSqCcdRQnu4RvU/SWFHSUq9qEXPaz79u6//BKT7qcbDAb6Uilyre+ke
	 aKW+ZiL5MMiLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD903930196;
	Tue, 28 Apr 2026 10:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: stmmac: Prevent NULL deref when RX memory
 exhausted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177737340530.407008.57733216818450708.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 10:50:05 +0000
References: <20260422044503.5349-1-CFSworks@gmail.com>
In-Reply-To: <20260422044503.5349-1-CFSworks@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, ovidiu.panait.rb@renesas.com,
 vladimir.oltean@nxp.com, baruch@tkos.co.il, fancer.lancer@gmail.com,
 peppe.cavallaro@st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 CFSworks@gmail.com, stable@vger.kernel.org, linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Apr 2026 21:45:03 -0700 you wrote:
> The CPU receives frames from the MAC through conventional DMA: the CPU
> allocates buffers for the MAC, then the MAC fills them and returns
> ownership to the CPU. For each hardware RX queue, the CPU and MAC
> coordinate through a shared ring array of DMA descriptors: one
> descriptor per DMA buffer. Each descriptor includes the buffer's
> physical address and a status flag ("OWN") indicating which side owns
> the buffer: OWN=0 for CPU, OWN=1 for MAC. The CPU is only allowed to set
> the flag and the MAC is only allowed to clear it, and both must move
> through the ring in sequence: thus the ring is used for both
> "submissions" and "completions."
> 
> [...]

Here is the summary with links:
  - [net,v6] net: stmmac: Prevent NULL deref when RX memory exhausted
    https://git.kernel.org/netdev/net/c/0bb05e6adfa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


