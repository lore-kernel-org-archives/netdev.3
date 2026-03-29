Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D038758C;
	Sun, 29 Mar 2026 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810239; cv=none; b=cC1J8QNzY8IpaVeTcCdxgUo7BaS38OyUNrH0/xuReicbHQ3LdrW8ACBYA8qMjvqvKFbZffDBgYoZcBNfIBNyzg/o95U/+98HgkTn96xQJdaCJJmaJbR4dwhHCU9VGNgoXEmKcfd0ttn9eTrXR6oqJsuaY3C7ypGosaKwKq+A3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810239; c=relaxed/simple;
	bh=O82FpE/7ZgUmCxQeK0am6BAdKnT2A6ZdwoNVv3WFz5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tTm2Z2YdcsI9LO7SALqIWfqfRomVBFA2HjV57W5yycoj4cGhd5xDXDbLIoYGo8L9SGBSbt8RCl11d5VsLkab8JrCDlHEhpB/0z3UlOTCaFesBtJwkMRqV6R1syfuSJ4INOrcF3bUwyds1M10TfJkHG74HPt79ZbUIfAF0TcoDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaRTxRSG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaRTxRSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD7AC2BCB1;
	Sun, 29 Mar 2026 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774810239;
	bh=O82FpE/7ZgUmCxQeK0am6BAdKnT2A6ZdwoNVv3WFz5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FaRTxRSG1VuymtP02WGPHzUkmXvzxs2ZnPhrpHxCDzor/J0ZcNxBiOQTGAmm6Dbdj
	 IojhvHCiJMHRNo0yWJtMkS7fhNE/bo5AbTpRhjvq24fIElUnik4SHYeO9MpG7nOuZP
	 tNvWXfSol5idU2kOwo3qymDS3DVHkl5rl0GvhU1vT2XOk47maa9uhTTFbP/laHLfgh
	 Au9F3RDZVp4xzUjopO2WRirIEsUFzUgj1vFcul8FzE/bQ+wLbojC+SWhIkArHhcysz
	 /Bi7Ei6gj7lB+kIlZWdXAQRv8TD6+BUY+QxBRek0mF68LYoY2PeQqMEV2wZO0bgMVD
	 5V76/1hQhNHPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DD13930012;
	Sun, 29 Mar 2026 18:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: dwmac-rk: Fix typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177481022378.437043.15447396546007070348.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 18:50:23 +0000
References: <tencent_833D2AD6577F21CF38ED1C3FE8814EB4B308@qq.com>
In-Reply-To: <tencent_833D2AD6577F21CF38ED1C3FE8814EB4B308@qq.com>
To: =?utf-8?b?6LCi6Ie06YKmIChYSUUgWmhpYmFuZykgPFlla2luZ0ByZWQ1NC5jb20+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-rockchip@lists.infradead.org, Yeking@Red54.com, heiko@sntech.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Mar 2026 13:43:31 +0000 you wrote:
> Correct the typo "rk3520" to "rk3528" in comment.
> 
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: stmmac: dwmac-rk: Fix typo in comment
    https://git.kernel.org/netdev/net-next/c/30fcf28d83ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


