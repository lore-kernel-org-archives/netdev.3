Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F352652B6;
	Thu,  5 Feb 2026 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267022; cv=none; b=J0S3XpeCauuUoNLpv5/7GTbgr/FtH4VRSkzv8/C8RN42eURbnsEZz9B1iTnoPImAB4uvE90Cdesdfmg4LLSXxH6FLkixzQM9vd3qVzd6tYWacDZ1z3XnKT194jPnRhs93y5Vdhg76i75Ts7dk/TckhefERv5tkDv7hSPlLxaMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267022; c=relaxed/simple;
	bh=fH87LTU4sipG80JEbjtRCAh1ElxM7xzqJYLKrjvK7l8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G+X3TH3OeemKDBLgR8gwzi3C4GlmxXOTW/Ajo+1anS0wmEufbsEpWe4VYdxXJOuJ1/FijRvjF52pz8j6l+oTxJBp5slva5b/5g5mqVIgo/JJFHQfJ8JfuuMetC4xAuXcoDYnUUoinDx4Y3mviU7w+JzTmvbxIv74cGT8ZipHh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpWhmrDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpWhmrDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8754FC4CEF7;
	Thu,  5 Feb 2026 04:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267022;
	bh=fH87LTU4sipG80JEbjtRCAh1ElxM7xzqJYLKrjvK7l8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JpWhmrDD697OxjpiE03GT+TldrsJwV0es5DGr5A2NozBZF7tzmk6EVlvQ2Qcgt4by
	 spilMuGu0StcHCxkXFaqj3jr6SQB6kFHbabmdu4IzIuBkonqpzjLaQ4sXMbHHNg2C2
	 do4Qz7b/rCj5CAaSeLtD/GI+ZmOn4tST43bYUto8X6c7BljYfEzGkR1yzA1Kom66uk
	 jN+kgJCvXOVMQV2rP1OlW35JINzjG+Y69hwPD+TUA57OOu0A2S6MRP9hs3rWJ+jGmr
	 sScnjBc6Zk5ldrGYeNj+fexbYH6EE49i0j3GlDqn1EIZvCNRPCmonamj0wYhJcenLO
	 X8LIUl+h4MC5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C24E63808200;
	Thu,  5 Feb 2026 04:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: stmmac: Fix typo from clk_scr_i to
 clk_csr_i
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026702032.165764.4026219262923266957.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 04:50:20 +0000
References: <20260203062658.2156653-1-chenhuacai@loongson.cn>
In-Reply-To: <20260203062658.2156653-1-chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: chenhuacai@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 si.yanteng@linux.dev, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 fancer.lancer@gmail.com, loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 14:26:58 +0800 you wrote:
> In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
> so correct the typo.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Update subject line and remove "Cc stable".
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: stmmac: Fix typo from clk_scr_i to clk_csr_i
    https://git.kernel.org/netdev/net-next/c/42a940ef1845

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


