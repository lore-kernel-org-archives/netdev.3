Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED51AF4E9;
	Sat,  6 Jun 2026 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712413; cv=none; b=DQQ5Dm+dmf0sQZxgrw/oIlnTn2ftFGcSFOlgUNG+bEmvFXpm9LfvKJ91YJDy7Ijlnxf4n8uu6qNXlV+w7Gf9b7Q6eCBhbk3bFj9EzjN5MV+z5upzSVgAhoEfJ9QbC++j3W7c42TroIdvf15QE7+mKCyWbkKsdyCQKx2pHEBFFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712413; c=relaxed/simple;
	bh=eW4rKG6foJ6QPTlGqacvcjToXBWnVtV9lGJPiy2BVuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tedqM/gk/7KbEAu/G4tpvbwuR8HRubqa3itK4ooOTYq4q+vUaTPnWfHeXKD6B7w4P1LVJWQSONERDEZyWZICTQ0Ih0OcGj5UPT3o6SoIjPxhd2foFzo1u1dmh7PUmZnOyfMH86TDuD4Yx75pP1WvkXlME0GCmFKf+5JFHyfREVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEBeRt8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEBeRt8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A2E1F00893;
	Sat,  6 Jun 2026 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712412;
	bh=+3bLFsnB5839EFXEZht5YnnLpYejZsji1a+GgQPr6Xs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OEBeRt8vfZhvtrneTFV/QG9l+pY1C1nl9gOMUxhcOBiMOAB+vt1ugZttQAApXmSp9
	 PltSMnKtFDsyfeutOZMAr1Lnf20Ti38wYl4wsNFIafomRr+O0phh/dWOgYwCSk5oNz
	 ABDqPX0ioV0yQ46j90BoJ7D8FTUoyKCOQgxjFP+/GCGelCdK7qTHXQcD1y/3X2ym7N
	 dV7fVA37y0a6Pr4oI8jvvZea5d9sErxCDwpn5XXZLK9VR5m8ADzmeZjqCq43eocsDp
	 SpU9QQgMuf1hDxmBD/7hX1/DnMOMhqwTzc5nXrtzj8G4ck1GRdtiVGfQRf5/+hpKmE
	 IijSmRSY11E/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A783930A9C;
	Sat,  6 Jun 2026 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: xgmac: report L3/L4 filter match count in
 ethtool stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071241185.3995915.13210125850131582461.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 02:20:11 +0000
References: 
 <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: 
 <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Nazle@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Asmade@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Muhammad Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 01:30:37 -0700 you wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Read the L3FM and L4FM bits from the RX descriptor status word (RDES2)
> and increment the corresponding ethtool statistics counters. This allows
> users to observe L3/L4 filter hit rates via ethtool -S.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> [...]

Here is the summary with links:
  - net: stmmac: xgmac: report L3/L4 filter match count in ethtool stats
    https://git.kernel.org/netdev/net-next/c/903db046d557

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


