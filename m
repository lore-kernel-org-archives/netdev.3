Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D622C234A;
	Tue,  2 Jun 2026 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369818; cv=none; b=OGmCjn3MT4zc3PmXIFOB/jho1otYvxUFCD19dU1QBTj0YRSn8V+oXXi3gVcwvAQKDAZ03HVCmQY2uJWjVopVc+7YEOVAsGrqjKCktG1SBFgxaTpnWmho4QvpKxmPvwnQoABZn8FYCYZLea96iHWQF38MJlxdtypI0H3usuezwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369818; c=relaxed/simple;
	bh=CdPXZbD5j9q9+fmaCC4wnqSPQZ6cpYJ3q7fRXnDN7lA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T2VEbcKtsjTVmOHQ8TRvNXJ1bL58RsLpZ69lY7M4LMhq/hWyr4QhV3ej8lnT9s5iT/tNKqIT27amw3ytagS7aXVBuZtmpjRQnBSOlYgmMS0cuwy0D3GXIYDg8ojH4jXHCJfSHBf5vXoZA+4SF385J/gm5X0cduZq3oRVuAAchco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqPyqP/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqPyqP/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E398A1F00893;
	Tue,  2 Jun 2026 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780369816;
	bh=MVK+ez5S2h1Xv9Lonr2tNkxvedzyuxQASoNieH4/EYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YqPyqP/60tv2uyAFgYdzz7jaGWJRnWBVlMjNMsmz1lQOuI4I0deSQQKOts3XB1Dkz
	 zITfa5yzWyGjZLK8EsvUwJWsG1eeejTLRxVmHF5V3mpAtuAVtUQvsjv+fpl1g11IDh
	 0mBVtn+v0o90ic5uWHZVhTns3W6LAvmgetb8r4oykt/9Rh0CFo4ph+fPsK0tdwtLcB
	 4yjmujjZMgVwIH4W1/rbNImAuRamPkrZKYkosrCjxQk0q4S9FcQzsG6Fx1O1BDQdUx
	 0crfvLRfn2exVJSkNbQr5A0I8X8JG74bG870l6ODXWjsFwBYclmCYxPhNHCot2fyrf
	 0UdvjHsHuQcTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AB938119F9;
	Tue,  2 Jun 2026 03:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v5 0/4] Add StarFive jhb100 soc SGMII GMAC support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036981914.224606.5617424802966318344.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 03:10:19 +0000
References: <20260527084108.121416-1-minda.chen@starfivetech.com>
In-Reply-To: <20260527084108.121416-1-minda.chen@starfivetech.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, emil.renner.berthing@canonical.com,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 16:41:04 +0800 you wrote:
> jhb100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
> Managent Controller). Similar with Aspeed 27x0.
> 
> The jhb100 minimal system upstream is in progress:
> https://patchwork.kernel.org/project/linux-riscv/cover/20260508053632.818548-1-changhuang.liang@starfivetech.com/
> 
> jhb100 GMAC still using designware GMAC core like JH7100 and JH7110,
> and contains 2 SGMII interfaces, 1 RGMII/RMII interface, 1 RMII
> interface. In JH7100/JH7110 dwmac-starfive.c have supported RGMII/RMII
> interface. So require to add SGMII support to dwmac-starfive.c for JHB100.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/4] dt-bindings: net: starfive,jh7110-dwmac: Remove jh8100
    https://git.kernel.org/netdev/net-next/c/106ce4a01c17
  - [net-next,v5,2/4] dt-bindings: net: starfive,jh7110-dwmac: Add jhb100 support
    https://git.kernel.org/netdev/net-next/c/64772e4d06a5
  - [net-next,v5,3/4] net: stmmac: starfive: Add jhb100 SGMII interface
    https://git.kernel.org/netdev/net-next/c/98182c748125
  - [net-next,v5,4/4] net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag
    https://git.kernel.org/netdev/net-next/c/7e9ea8de277a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


