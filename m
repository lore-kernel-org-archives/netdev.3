Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106F269D18;
	Fri,  3 Apr 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253635; cv=none; b=mG9aDUhsDzjJhhbCFQRHFEhoWdR1mxbxYVxjOdEKQCb7Ad7Q/JcEdz0bTPvltbx/PRWUGvdwxmKjOeHauc5H17ys7D0OsWm/upaKHHIuNxk7pKC2U79yxeEwmDBjrzVkf087sqauqiIzfHRBOSL/s5XkexboQ4+QKSyPqVvCu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253635; c=relaxed/simple;
	bh=S7LoVHIaVdzAVCA2dcDM1RF7zy5gCGFKAZGv99r52rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xw64WAW4NiMGiLG7OdwrR+G6Cg+2a3GQjDTSdGBRPe7dfuIDstW4/HEZABgj2wtJYA2dxYgzlJG3LkiCV+yOpUZ1QEu8SDY/4MoSo39T5H9v2uUJ6ZJn1iSWFqH4gJkq0PJNypz+8htAaipYvrPH+lpOmxrxhyd9K5qeYhjX8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzEDwTQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzEDwTQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B1AC19423;
	Fri,  3 Apr 2026 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253634;
	bh=S7LoVHIaVdzAVCA2dcDM1RF7zy5gCGFKAZGv99r52rc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nzEDwTQwNiupffSLW4kgerwwAcTa0T22DP5EYEwv2HY2+8E/XMv3+bTaEj4LOxQmm
	 DyzRWrawtUPw85amKesJYK1QdgdnIKknftU4YIuSfRSd+ha9zHHHWFTT4POCDMB671
	 4Uk2WEvEb+/YtPqjJgIs33IrnskN2h/KpeqMUG/RrMApanfzmMMG3oQq7OhUprwO65
	 gdzqMrd+zksEWh9LNTmhI6u7wFH2ndgUoqIFQqvgmSqh5JJu3+9msgysKBs0cd7/JZ
	 GHAps76zjFDQ6hNR/dlgb8o9iuHOo4DilaAAHhDeRfoTFrF3OHt8zs2fH6iXwBRSSB
	 K6/fR2cN6oNbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCF03809A14;
	Fri,  3 Apr 2026 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fec: make FIXED_PHY dependency unconditional
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525361598.1466030.8172670823884997635.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:00:15 +0000
References: <20260402141048.2713445-1-arnd@kernel.org>
In-Reply-To: <20260402141048.2713445-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com, arnd@arndb.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 16:10:40 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_FIXED_PHY is in a loadable module, the fec driver cannot be
> built-in any more:
> 
> x86_64-linux-ld: vmlinux.o: in function `fec_enet_mii_probe':
> fec_main.c:(.text+0xc4f367): undefined reference to `fixed_phy_unregister'
> x86_64-linux-ld: vmlinux.o: in function `fec_enet_close':
> fec_main.c:(.text+0xc59591): undefined reference to `fixed_phy_unregister'
> x86_64-linux-ld: vmlinux.o: in function `fec_enet_mii_probe.cold':
> 
> [...]

Here is the summary with links:
  - net: fec: make FIXED_PHY dependency unconditional
    https://git.kernel.org/netdev/net/c/e16a0d36777b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


