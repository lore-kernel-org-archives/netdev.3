Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5C38655D
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597469; cv=none; b=j+8pYAz5idtStAitiLXr2nBLz2lb8+AbFRJgmx7axngRhkLikL7KgOCYkN/58iYfrMRRZLOWOEAZ1ercVxLPGAqrkIUAbS9DHqSOSdnei7V0nDs6ejnE93a6iYsJ8QMLPEI7Q5+PGt3BxDul/LEHj0gMdldGBtnNjdfLgL5lsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597469; c=relaxed/simple;
	bh=usq0o++89jzhTHWeF9uOEgu+WEcT4PyzqBKqY6+cVGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ow74OBWKzUt8qHu+QBC502SjLtl+MpnyCQuKLI9cN+HBEJNRI191TjuNSacWfQSrLqGVio2AQ9wKm5xGSEjQoK0nIQ3LNjuu/Fljq06b25LBEG8KLjS34LBodiVhPWVqQ44Ja1Jr3kQl2YRKC7v8obw+TS+feSPzIi1T0sYMkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFLf23hN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFLf23hN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941DC1F00A3A;
	Mon, 24 Aug 2026 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787597468;
	bh=pV0pRHkh85Ff9HhCfHZIfVEfYvyq5xEy/SHGr3RHpPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WFLf23hNQ5ohUBMekPTltKccmu2Ttu0cj8vgkChvcUU1CirEJiZr+hDiawq4wbK+8
	 uVMuEGQtEN7sCXQfCYjFltc+eOeemsFFfmiP4Kh4pi4AwiC6uVyq66a93JXCVw277T
	 fgg5XVcpBkYAWSFZLieJ4TNffHjkjTdDd4VwZEKEQJbOowipesO8/rEBuawcdwNAIM
	 uhNl8xRoqV6sNZ/U9bIwaC8t5DkQq7xKQcCv4BCKexGjYTlglWCN2jEGG6bCxaGu68
	 wOA/EkHIxmFIfHmx7If0yywlSlP/yeIrdsl/AJEeoD9BTtjXEI8JnDDSeSVF+zsn0x
	 u7kJgZOlRH3bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B43924A4C;
	Mon, 24 Aug 2026 18:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: fix device node reference leaks in
 stmmac_mtl_setup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759741588.3062482.17874707106135640490.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:50:15 +0000
References: <20260821055718.57-1-rabbanyhmm@gmail.com>
In-Reply-To: <20260821055718.57-1-rabbanyhmm@gmail.com>
To: Md Rabbani <rabbanyhmm@gmail.com>
Cc: maxime.chevallier@bootlin.com, alexandre.torgue@foss.st.com,
 mcoquelin.stm32@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 11:57:18 +0600 you wrote:
> In stmmac_mtl_setup(), q_node is shared across the RX and TX queue
> parsing loops. When the RX queue loop breaks early because the number
> of parsed queues reaches plat->rx_queues_to_use, q_node retains an
> acquired reference count. If the error check passes
> (queue == plat->rx_queues_to_use), execution proceeds directly to the
> TX queue loop, where of_get_next_child() immediately overwrites q_node
> with the first TX child, permanently leaking the retained RX child
> device node reference.
> 
> [...]

Here is the summary with links:
  - net: stmmac: fix device node reference leaks in stmmac_mtl_setup()
    https://git.kernel.org/netdev/net/c/317fe168f4c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


