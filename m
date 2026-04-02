Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E233F075B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155241; cv=none; b=QF2F9IwSeVeLrh7LfuSeN6BZK0Jkbx3vJFZ0s7GNRjbzVIFEkj9bJMeCKht8vexk9Izhj7MRO4qXKEWe2tx+pAqdlehVEdYHxwfMmK89xxaQqAt54c54gnxQRe5Hor+jUAJs1hs4J4JtYVOVqnroTQUHDfS0i3L2SkGaAJMD8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155241; c=relaxed/simple;
	bh=pmcwFe1wHetLptQwyfU3HCeP9GSzNzMSqxhSN5vyyo4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QyL0B2CfBfgG9seWwK9EcqI/uKCCZZwgpqmJ+zsm3v4LNjR7MZ77kFJfX34Ok5GJ+QERvahz919Z7KRu6+M5OXDp85xGR5Ta9lFXSsJzjwbOXyGDmXnL+Lb6Azrrs5UQNIuvqYeOO6GWEXimOyoECAHg5U4uHgRNZN6q782zP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg/qIUmH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg/qIUmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF6C116C6;
	Thu,  2 Apr 2026 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775155240;
	bh=pmcwFe1wHetLptQwyfU3HCeP9GSzNzMSqxhSN5vyyo4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eg/qIUmHH0zmmJTDhNc6+zkD4z3hZZ/uP9DfdAk1Aq9DtrvXoz4k58M7heedS8qpL
	 eNy71ongaIVLZ+962RRrwgzBeyDovEvg4/yQEYwrKKZmm8qYSWLmwMgqp0CfOWaeP5
	 +Wcrt5lx1ysm/XBhI6xmKizYyezqF7s4skIOFmzbvCu8J6J1rek/5dGoc+Cj23pgLt
	 BIrUbARdMiz3lDwov9b7j6jqarriuniRf7sAlxRSwWdKMUhLlslck0O/kaBVuRsnQj
	 0zM02fBVHjSRozus5bPVaLQVy5fa43wV5PvbH3t57t5kFQVVGGTo68QwqcZufQY/VI
	 cjAGPZsHWI0QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF843809A09;
	Thu,  2 Apr 2026 18:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/14] net: stmmac: TSO fixes/cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177515522304.572495.5047092891296862297.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 18:40:23 +0000
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
In-Reply-To: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 boon.leong.ong@intel.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 1 Apr 2026 08:20:52 +0100 you wrote:
> This is a more refined version of the previous patch series fixing
> and cleaning up the TSO code.
> 
> I'm not sure whether "TSO" or "GSO" should be used to describe this
> feature - although it primarily handles TCP, dwmac4 appears to also
> be able to handle UDP.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/14] net: stmmac: fix channel TSO enable on resume
    https://git.kernel.org/netdev/net-next/c/989a9c20f63e
  - [net-next,v2,02/14] net: stmmac: fix .ndo_fix_features()
    https://git.kernel.org/netdev/net-next/c/afe840ddf15c
  - [net-next,v2,03/14] net: stmmac: fix TSO support when some channels have TBS available
    https://git.kernel.org/netdev/net-next/c/e32820264c29
  - [net-next,v2,04/14] net: stmmac: add stmmac_tso_header_size()
    https://git.kernel.org/netdev/net-next/c/f799b5dab9c9
  - [net-next,v2,05/14] net: stmmac: add TSO check for header length
    https://git.kernel.org/netdev/net-next/c/6732e474f880
  - [net-next,v2,06/14] net: stmmac: add GSO MSS checks
    https://git.kernel.org/netdev/net-next/c/c05a81cbee87
  - [net-next,v2,07/14] net: stmmac: move TSO VLAN tag insertion to core code
    https://git.kernel.org/netdev/net-next/c/3f6a6eb9ef21
  - [net-next,v2,08/14] net: stmmac: move check for hardware checksum supported
    https://git.kernel.org/netdev/net-next/c/b55dfb173ce8
  - [net-next,v2,09/14] net: stmmac: simplify GSO/TSO test in stmmac_xmit()
    https://git.kernel.org/netdev/net-next/c/2e4082e4b739
  - [net-next,v2,10/14] net: stmmac: split out gso features setup
    https://git.kernel.org/netdev/net-next/c/c04939cb9851
  - [net-next,v2,11/14] net: stmmac: make stmmac_set_gso_features() more readable
    https://git.kernel.org/netdev/net-next/c/6ad004442897
  - [net-next,v2,12/14] net: stmmac: add warning when TSO is requested but unsupported
    https://git.kernel.org/netdev/net-next/c/f8c70ab540c1
  - [net-next,v2,13/14] net: stmmac: check txpbl for TSO
    https://git.kernel.org/netdev/net-next/c/33f5cc83bbbd
  - [net-next,v2,14/14] net: stmmac: move "TSO supported" message to stmmac_set_gso_features()
    https://git.kernel.org/netdev/net-next/c/0f96212a5142

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


