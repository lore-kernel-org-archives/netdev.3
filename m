Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767825B09D;
	Wed, 23 Sep 2026 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128879; cv=none; b=WFM9DyxtpreXYthPNLDCQrCgUQNBxUwSbBg88uDcysfSLYUsek2zBbrcNVKfKyzHcVtV0YuhveXs0TOdVFIfGvq/gwK8gJJRT0bMPesO97UEBFDnWZ7BVHnrMwjiPO3DAZ8Ip/lNxZ/OfuEApDtfqj34WifTH8GhAOU7xp25b8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128879; c=relaxed/simple;
	bh=l0wtqLhqIkmwk8A/LOXNTeMAQP5ik0wQKIGuyeYNd88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RPmcvKMEbOPFdtVA2odmboRWgzHMdlI//Y8FvgYnA7PLx7DP/sFztawaZYqJ/BCvWne/LqBsfCo3HbMoCZ+Ma8GvwIjDcfIaNdyKs4YPa3tABIXDGQnz5dJS9outNhyeBWB+2D/F3AXyNJklWLLfkfVOzaW3avh0Al1jFpV+I64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV2izKL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV2izKL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30F01F000FF;
	Wed, 23 Sep 2026 02:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128877;
	bh=CrJObJd9jgoRBak2sDbeRVxuJAl0Cs6v5ebe8+LfgFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FV2izKL3+mar00fWUIDph6Wb1F62Ipf6zPUojX96+CzYnfOtZfQ9b30dXE9kvyoqP
	 2FUR1j3rLrsxfQPbseaDxO5q+AM5sLiqJ3n/xdCikhwMYzSq3juhSLJBy6rP76GwVk
	 5E7tVsZZQVZEhyBbTHcgUdzmITklXPthJT0XR73BJG/ko4n5a8knUqgMM6ZzA9N612
	 gYWRZE4a0Ce8GLURiQmST7N+0S3kDx2Ho7UgH7MFvt+7zK0yt7lmt0KTuYorZs57gR
	 AjLqQMZdhCYn5MYZFwmrg1XR35rI39Z60VHlOUzH+La/z1aDPdY8MB3oPDnRUoX3d9
	 FrGVM6G94O/mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 750D73924472;
	Wed, 23 Sep 2026 02:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/7] net: stmmac: More selftest-related fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012880821.173471.16493081589116567315.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:00:08 +0000
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, alexis.lothore@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel@esmil.dk, minda.chen@starfivetech.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, jan.petrous@oss.nxp.com,
 ovidiu.panait.rb@renesas.com, Jose.Abreu@synopsys.com, nb@tipi-net.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 david.laight.linux@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 23:53:31 +0200 you wrote:
> Hi everyone,
> 
> This is V4 of stmmac selftest fixes, addressing Sashiko's issues over
> the MTU patch. This lead to the introduction of a new one. The
> dev_add_pack races have been addressed, however the double-vlan issue
> stayed there. Ovidiu is actively working on it, let's wait for his work
> to land before fixing that.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/7] net: stmmac: selftests: Support running selftests on DSA conduits
    https://git.kernel.org/netdev/net/c/d68acbf93531
  - [net,v4,2/7] net: stmmac: selftests: Validate EEE based on the actual LPI timer value
    https://git.kernel.org/netdev/net/c/c8c1795aa810
  - [net,v4,3/7] net: stmmac: selftests: Check the dev->features for S-TAG offload testing
    https://git.kernel.org/netdev/net/c/ba804b23d76d
  - [net,v4,4/7] net: stmmac: selftests: Capture all packets for vlan checks
    https://git.kernel.org/netdev/net/c/960db6f65788
  - [net,v4,5/7] net: stmmac: dwmac4: Use the correct bufzise when the len is exactly 8K
    https://git.kernel.org/netdev/net/c/b42e7012773a
  - [net,v4,6/7] net: stmmac: size the RX buffers from the frame length, not the MTU
    https://git.kernel.org/netdev/net/c/b8a26d46c0a4
  - [net,v4,7/7] net: stmmac: selftests: Account for alignment shift on dwmac1000 for Jumbo test
    https://git.kernel.org/netdev/net/c/c4ac6e94eb94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


