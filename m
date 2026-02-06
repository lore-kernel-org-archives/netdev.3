Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D226AA91;
	Fri,  6 Feb 2026 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345007; cv=none; b=XCjf/W0lZf2PUSuDKGsHHVxaOMzMtMzGOddDyxCgWg4Is75IB2O5M7Su07P+bxOQiVuvqcFSjAGeYbJCQP4XAnJ4eHxPMe17TXYLFiv4ZWMP4BYsO/0FOdLuOiKaQ9CaaWRqCbdIkZN9cI/WqTV4NzxGy3O+DE7dWMGVujM2MTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345007; c=relaxed/simple;
	bh=YvVUVgTpvs+4E6hrcojKMAmpmIeWsDByWtiLRL8LSQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MbMkB0URPo9RbcvHlXpQnDSqzXmWfW/yyWwO6ur+OsLah1kUv+aQGq5jnFORejFUtR9KRWyTbo+6rFDSTlelbvhMtxLscxuURCwvUUKWN19+2j6yb+gn7eZxqUIHjwnUnyys1Ohhk5AJgmf36saPuSu9b65008XJ4WoNM0wRUAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBkl62Jr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBkl62Jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46368C4CEF7;
	Fri,  6 Feb 2026 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770345007;
	bh=YvVUVgTpvs+4E6hrcojKMAmpmIeWsDByWtiLRL8LSQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SBkl62JrXn7Jydo2wc/OOXnOLrBRPRHO5ZjHAKYc6z8sSbvQF1wIRL5G8gkGdzlKQ
	 rHDsFuYp6S9qdQUOUhrBV7kfXUBHlwOnw0wr/0SxmfQguGYuIw0LRaTNSHlSL3pUwW
	 mkGeUnKnwm6PzfiSuPnRcbT+FACPAOldvwkyeXea3/FypEg8g1GfEgH32ZNg4IY8D9
	 g3+b0k+9f6JZ7x1PuUMpYxANpKXirkYCye3mNQVJ7Ae1PrIxpEtKXpzSStRk2bseyG
	 BdX3tbld3iNET4H1WkXQpvTfvnOFRa9vJR9RdTUJPyIvwWYarblkkWVDEYSe5oEy2j
	 +wiNQUl+UOHDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B02B3808200;
	Fri,  6 Feb 2026 02:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: stmmac: dwmac-loongson: Set clk_csr_i to
 100-150MHz
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177034500483.652141.1900919994217180563.git-patchwork-notify@kernel.org>
Date: Fri, 06 Feb 2026 02:30:04 +0000
References: <20260203062901.2158236-1-chenhuacai@loongson.cn>
In-Reply-To: <20260203062901.2158236-1-chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: chenhuacai@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 si.yanteng@linux.dev, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 fancer.lancer@gmail.com, loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 wanghongliang@loongson.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 14:29:01 +0800 you wrote:
> Current clk_csr_i setting of Loongson STMMAC (including LS7A1000/2000
> and LS2K1000/2000/3000) are copy & paste from other drivers. In fact,
> Loongson STMMAC use 125MHz clocks and need 62 freq division to within
> 2.5MHz, meeting most PHY MDC requirement. So fix by setting clk_csr_i
> to 100-150MHz, otherwise some PHYs may link fail.
> 
> Cc: stable@vger.kernel.org
> Fixes: 30bba69d7db40e7 ("stmmac: pci: Add dwmac support for Loongson")
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz
    https://git.kernel.org/netdev/net/c/e1aa5ef892fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


