Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327E19E819;
	Sat,  6 Jun 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780710007; cv=none; b=jmyEWIrVJgmkMvL4ZYCkkHXW64BQ0bmeCTMML9t2xgsTJLdjkuYnLjfv7Q8MeR9TfCBcVYiTtQuJyV7uc3PpYNZHCuzPLB/HPOVscH0ps3Y/u3YL/ZaANB7CnuvB5gCCUpma1auzyoJjiH1kHpOZzLpxyOK+2+DPdf9GCBjWXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780710007; c=relaxed/simple;
	bh=c/RF0kC9Qh+p0TvfLOcMCsrCfkq5R0iOL8badKhi2wY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a0iOrR04TyjTEFTM202gimdPgI8GlxBNDSccGPZOQ5sAt9Nz2fYyeENRuDoT+RSf8yt5BD92XGMfKeKtvkfwT/lYgXIJyp9T2JjEXb0Re//zwiiODn6UTBCe54DXRxIrxW4mz0qNeU40LMDiBf20ARXK874zoKcuSdlb1F4W060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myUMH5mY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myUMH5mY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DBE1F00893;
	Sat,  6 Jun 2026 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780710006;
	bh=4L/2vxjqjL4RiGujkM/Ro9au+zwXOQvhTC3CfFNd7rc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=myUMH5mY46MJYaBDJHER0h2NVBkakwbmfRrN40iDO58t5pJSdHfWSbFsm3RhBeeSG
	 bT3gSEBqzUgCxEJA7Ki4sl+++M0Nob+pCHOIlLqvjfLpQ9PkL8OArol5KPMZYc8F8l
	 GbGpjrk1Z/mubuiTDNH7rFAkeEKexTSQJ38YJTqBAeyvbZ4gVix2srIlwxfqDp68v4
	 ErDNINU7pNc7Esr1SNFSruUl/WBWUb7SxlHLzCBwwN0AWxYuSNLUIrqKgtbHuzEpHw
	 HcsffE4JpP40QuovURdcYoTiZ8nI8MEUk2QC1xKC5FVmcg8loKz1UI8qFq359LerE0
	 kjcl0IO0Xmwog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939813930A9C;
	Sat,  6 Jun 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: dwmac4: Report DCB feature
 capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071000615.3987407.7537922881978365743.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:40:06 +0000
References: <20260603173644.24371-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260603173644.24371-1-ovidiu.panait.rb@renesas.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, o.rempel@pengutronix.de,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 17:36:43 +0000 you wrote:
> Bit 16 of the MAC HW Feature1 register reports the DCB (Data Centre
> Bridging) feature. Read it so that dma_cap.dcben and the debugfs
> report it accurately. Right now it is always reported as being disabled.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 1 +
>  2 files changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] net: stmmac: dwmac4: Report DCB feature capability
    https://git.kernel.org/netdev/net-next/c/3a58a1b8d505

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


