Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1812571C7;
	Wed, 29 Apr 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426869; cv=none; b=HZMgV20Ulwfdogbb+urGsOstoRDfDehUyBW/OP+YBo0zRPLvJVGbCs08JnjkJ0Mk5+OeOxzAnKbrenzFXMuBvXvftVI4McKzY+exIYHD2OQDeuyTc/V3o0au1aKdH7MhtzTcJ/uUot65N6NBlSsNzCzV84m/6NnS7FLqHEicr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426869; c=relaxed/simple;
	bh=ZufN4XiT3cEF3/MnkweTt+1XxyC1FpruRMf/3bTu5sY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DiAvjZlyaCCYNFc7DeAgQbkLfbEC5jT/ddgjfZJEaCRsH5QEypi85x8fvG6Os75Os3Ie2eMyCuX391i7/t0ib2iAAORXgEAwtBSH5Co+1b8JrzrrVGdtZOQ4R9gPdrdbHFr6morSLMGmXA9N3H+BYapLlrlzYOhpFAni2Vc5R1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulrLN2sY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulrLN2sY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA75C2BCB9;
	Wed, 29 Apr 2026 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426868;
	bh=ZufN4XiT3cEF3/MnkweTt+1XxyC1FpruRMf/3bTu5sY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ulrLN2sYRdRw10f88Xd+A0bNorZTVDpY9x4g6DQAONVa/Hf71NRuvJ8ZsRrZI/RU1
	 Vw2TFc2UFO7kKnfqJuOyXC5VQYm3OOo8baS2E12jKin7fjf56BeiM7HTaizAnUjD0E
	 JH47Pjftu5I6fVpUImlOmII/KsTuFs/iTAocACknzCc7pFkH8/4P7RYU5o4GVyMr3G
	 bMX0ceF85/F+o7EGq1nPwVtT32OSaRBPPv86DbylBl8mgTtQOzGaGW7rs5735r10y+
	 +jQN/tXzsrAnjYr+u8D+T1LJeU7vVaBLLm3607wuhgZkEbgY02EOoFeu+fnFh3gyAy
	 keG7QSteAMEGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC539302C2;
	Wed, 29 Apr 2026 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ppp: add PPPOX symbol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742682479.1291511.12607684897778641027.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:40:24 +0000
References: <20260428012830.3069-1-qingfang.deng@linux.dev>
In-Reply-To: <20260428012830.3069-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, julianbraha@gmail.com,
 ebiggers@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ppp@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 09:28:26 +0800 you wrote:
> Add a dedicated CONFIG_PPPOX symbol to handle the PPPoX generic module,
> avoiding redundant pppox.o definitions in the Makefile.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/Kconfig  | 6 ++++++
>  drivers/net/ppp/Makefile | 6 +++---
>  2 files changed, 9 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] ppp: add PPPOX symbol
    https://git.kernel.org/netdev/net-next/c/09942ddedcb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


