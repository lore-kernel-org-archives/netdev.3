Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDAE3D5642
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216484; cv=none; b=IIJr2lPO0aw/TwyZ5EgpyWjPhRg3Ed8OaeK4u6zSZfXqeK2UIQ0aUgOAntsNRoi/45hNiuu0Zmd5tqQRWEegL41C7cpXl3HEmR3g4GlHUzVIuCnGnpRCa5Z6AwdQXdU+9Jb2flv8nQc7Gr1FML0G/WhBmQ0rGELq6lrI8d0jpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216484; c=relaxed/simple;
	bh=RRn78XxCQvzJRdRM7SaJJGk60ltDQqZY5cRBu2lirlE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G8TXJC6MgQCYNn3uf9Eww9I1bYVsZplN7MNY/KeltEvU/8IEoCaesieCALzTwGHgD+U558nLYksRDVcqN4Gz/z+R7/H3TPDhSZzGKJ2lCs0tlGs98FoHfihgCf9yyoht2L8ABUdAZOYhzYGKocL/wQwHbXwB1bwWxIwHkOllCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1O+mTZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1O+mTZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69CC1F000FF;
	Thu, 24 Sep 2026 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216482;
	bh=U6gvHdYEmRjPiP5dUVlot/Tgw7DMA5AXZlbqPvZfhns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F1O+mTZQ4GWxL7yvN44LO4K2bOvlyPpVrx0GJ0ZSooXRdl/w41qyIWKSZlaMeWuL4
	 xdpHU2N+OlmP2MoTgyLxD/LLvObyIBTxuOgEKueManOaVA6q/+dRInP5kYFdFp+fjQ
	 xQzBL+xYaZTVQYo0yFLrPw51hx6KfqfXPoRgy8wAzTsCrUWdkr37h/pPNvex+9TdY1
	 uBcGs7w1x5R52RRZMNNYs7gK6i/Hv0TL8Hlkn1+hMqi5BNWcyyf2afxYuGLIrxdspu
	 bIOE2j9eVur8NQgBnFp2BL3OlVAWlu7mDfuJtdfJ7PTk6A5zYbs23D1d7BXRcWGiYg
	 W44P/P3EMUhpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396139E9611;
	Thu, 24 Sep 2026 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: clear stale buf->page after recycling on
 skb build failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021641214.1281065.12234220924406890442.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:20:12 +0000
References: 
 <20260921-stmmac-fix-napi-build-skb-error-v1-1-3d54bf6d9bb6@oss.qualcomm.com>
In-Reply-To: 
 <20260921-stmmac-fix-napi-build-skb-error-v1-1-3d54bf6d9bb6@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 si.yanteng@linux.dev, aleksander.lobakin@intel.com, 0x1207@gmail.com,
 larysa.zaremba@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 16:46:18 +0200 you wrote:
> In stmmac_rx(), when napi_build_skb() fails the descriptor page is
> recycled back to the page pool with page_pool_recycle_direct(), but
> buf->page is left pointing at the recycled page, unlike every other
> consumption site in the function which clears the pointer after handing
> the page away.
> 
> With the stale pointer stmmac_rx_refill() skips the replacement
> allocation and programs the already-recycled page back into the RX
> descriptor.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: clear stale buf->page after recycling on skb build failure
    https://git.kernel.org/netdev/net/c/0a7822e34a0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


