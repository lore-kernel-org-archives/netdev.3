Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8331578E;
	Tue,  6 Oct 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244809; cv=none; b=IfCtFkEJZe+J2GokcswCQFRCtGK1yF/cp+o7svVlMhH1AP0S/nAYEFstMF0lFgyk+yO9TGuuNxKKIa5d3IjwZtajdbTjJ9RUXzhJOmyCXoHrAPQ4rG083eVmmeDVRbi+hJsyKMa1cWJ1x38nNgwjRvQGYhOyc1KHdM9ENNSAUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244809; c=relaxed/simple;
	bh=J19NaaZvL8gFXEtdbAiyv/Hl/MndTi5kDHevebBaFd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kycmt9EHUxdnSqWvC37c/17G016HvMhQih7z7cN9ZeddTvSLx8CyRtP4AWMTOIaBZTlpTNtPO0pdF2vRMxJaZJT5KqYHhgjkDHLjz2YKmZ+6O/LW3Q8Wr1m0X2ciVDCAGOsZgWa4HjoUygV2B37YJt8DtQxVeY9GYtvryWeOz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC+2hntY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC+2hntY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3F91F00899;
	Tue,  6 Oct 2026 00:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791244808;
	bh=lvj8SC5pqp6JhKvmMFRMNZvobw45umdTFKDtOkONq+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KC+2hntYUHKFuVDp/p0ly8uzmPbNrZmbLM1a5ZE9L7+2zSN5QSs8ETN7ltGEU4RfK
	 zSBH1tDCm5WXq1ZcwK+t8D4WX/m3H9yGbgSx0/R20qhy5AK5PlSvbVyFbUwgYFrgfj
	 0cYPfe7ULKWocMzMeNrBbfaDYxatg2AI7gtE1M4Pil3G9gCz3kwskNXoYB8L5LgnOM
	 RW8SK9tQ4dA/n+lug83Qy6aNFNEe0NlDj1Y3mf6i3g/fkoQmyFYP82NXGLXLlDJie/
	 ZK9XGOBLCH3RQadVK9pyymEUZEyDe8CD7jaxJ75YFJafEqW5gyfWV46PFnuNqyn/xr
	 wgAMvs0Y7C2Zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A316392667F;
	Tue,  6 Oct 2026 00:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124480678.1944959.18161635120847031238.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:00:06 +0000
References: <20260928203441.34876-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260928203441.34876-1-ovidiu.panait.rb@renesas.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: maxime.chevallier@bootlin.com, recv.jo@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, jun.ann.lai@intel.com, yi.fang.gan@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 20:34:36 +0000 you wrote:
> Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
> hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
> than using the actual protocol from the packet. Because of this, packets
> that contain an 802.1ad outer tag are incorrectly passed up the stack as
> having an 802.1Q tag.
> 
> This issue was observed on the Renesas RZ/V2H platform (which has a dwmac4
> IP), when testing QinQ ping:
> 
> [...]

Here is the summary with links:
  - [net,v6,1/5] net: stmmac: Remove VLAN perfect matching dead code
    https://git.kernel.org/netdev/net/c/11705541e7d4
  - [net,v6,2/5] net: stmmac: Stop toggling the EDVLP bit
    https://git.kernel.org/netdev/net/c/69aa9e76677c
  - [net,v6,3/5] net: stmmac: Rename double VLAN references to svlan
    https://git.kernel.org/netdev/net/c/354b07bc1dca
  - [net,v6,4/5] net: stmmac: Do not advertise S-VLAN stripping when it is disabled
    https://git.kernel.org/netdev/net/c/c63ce7b9c7e7
  - [net,v6,5/5] net: stmmac: Disable S-Tag processing on dwmac4
    https://git.kernel.org/netdev/net/c/da17990421d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


