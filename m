Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112F305691;
	Tue,  4 Aug 2026 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880246; cv=none; b=gU8mJT88btG88K7o5SEgltD7ROZEUVOyj3wNRHCPBwsAg9IS1CA/FksfG7HFI/HmyGOhLchxEcOHBba9v7rCtf9ZyGoo6oUfNuovJ/i7u+LLjLSPMMnOPBR/Nun4egtSrhCs8x6vvYXzneC1ywvNbTvngDq7FfS2A2sgMCFaN0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880246; c=relaxed/simple;
	bh=M4EZdC8ygero/2zdy1CztBDKiGMFuAH/qwXJQRYs8+I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m/AyXdAiUyOBf4sk64+Ehny7jA/1fM/0AQucdXHkzvqbartHWr/tBCAzbw/GaqcAI7ftowo4BaZVvcsWr7DZuaqnaoRKWgj0K0W14Haq1yjyA396FnuIjiUR111G6WrJMUaNBSUk3T4Uhs15M/MYlo1Oa0YAPTctl3NlU5fwcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFTbfl04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFTbfl04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5013E1F000E9;
	Tue,  4 Aug 2026 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785880245;
	bh=EkNRpLkFQbklpXhlhpSbYoouuppf1lhtf6KMzefUN9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GFTbfl04sWNuT/qvwrHvc+GheIIpTIE0Q19QLDg3GkRZT7TCpNtSz+nieqjStPwYs
	 xFW0n1qSkAHAxTbNmyBY2hY9fyeXRzK3pRIrUP8pCGc+s/EnvitJ5HFpTn/dhwfoLu
	 N6VjDbObW8WuZqq2tff13gRwuqu/QiiJ6OLAVbcWjoFNy640quOraLlKRPV72IdXv/
	 KQke4yHFpamL8TYP9CbjL9VGRHvteJ+0oOHgxnqTnfzHWSaw35gwSyjC97QF09ZuRH
	 P80y9CBP+wwyKJc/FxK9kHC1/3YsJk3l+7U/nYUEKXyLWF4RrACOvIWMOUgvMdYEcT
	 OnLfnPgdTuQ6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E9494392664C;
	Tue,  4 Aug 2026 21:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: remove ptpaddr/mmcaddr/estaddr "safe"
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178588020564.3802025.2220394407123145162.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 21:50:05 +0000
References: <20260803135745.12600-1-jszhang@kernel.org>
In-Reply-To: <20260803135745.12600-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 21:57:45 +0800 you wrote:
> These so called "safe" initializations aren't needed any more from
> sometime, but the unnecessaries are obvious after recent clean up
> by Russell. The code will correctly initialize them after getting
> the correct stmmac_hwif_entry by calling stmmac_hwif_find().
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> [...]

Here is the summary with links:
  - net: stmmac: remove ptpaddr/mmcaddr/estaddr "safe" initialization
    https://git.kernel.org/netdev/net-next/c/95a390ce6aee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


