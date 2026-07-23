Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41943CE74;
	Thu, 23 Jul 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804447; cv=none; b=BYbn+bE/LRrhWTk34DPRTN6W6/ndA+h38dK3NB4b80fvMFW+yYU0EVFelkycn4MbksA7HJ/L55os5v6IM5WY7BkGiBb0Q3m5NcFZu1FpmSOL5HcNWCx+lkNMUbda8AH7zwJ95FWm5NJzdZGPuL9jKVtxtdsvYvp4ugP1RjY+Nx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804447; c=relaxed/simple;
	bh=tkMLEGC/MOwX2flS0xOuIgSmy8VCce5NREFx2sg7QJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nsMAQbkJ8iXai6yU4nmGUSCoCymujoG2199x3fJmVu1WQz3xovPBNKNsSC6eA6tKdGNv/kB3itOPubJyEzhA8hfMuJgvujOTGp7vSoNoyWrOjNPt6CpYINEQvzMnAIFLSLiHo358H4WW+iyCppOs9VXofI/MpKrOVYk/0HLw7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A421F000E9;
	Thu, 23 Jul 2026 11:00:45 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A77380DBFA;
	Thu, 23 Jul 2026 11:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: stmmac: L3/L4 filter bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178480441340.2227840.16089405252896069758.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 11:00:13 +0000
References: 
 <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: 
 <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Nazle@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Asmade@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Muhammad Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Jul 2026 19:37:12 -0700 you wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> This series fixes three bugs in the stmmac L3/L4 TC flower filter
> implementation for the XGMAC2 core. All three patches target net.
> 
> The L3/L4 filter match count statistics patch (originally patch 4/4)
> has been split out and will be sent separately against net-next per
> Andrew Lunn's review of v1.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: stmmac: xgmac: fix l4 filter port overwrite on register update
    https://git.kernel.org/netdev/net/c/9fcf274d93af
  - [net,v3,2/3] net: stmmac: fix l3l4 filter rejecting unsupported offload requests
    https://git.kernel.org/netdev/net/c/5536d7c84363
  - [net,v3,3/3] net: stmmac: reset residual action in L3L4 filters on delete
    https://git.kernel.org/netdev/net/c/a448f8212899

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


