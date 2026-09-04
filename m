Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A53630BF;
	Fri,  4 Sep 2026 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483079; cv=none; b=XtP3OZv7AFlQbb7DBb7BL5G+OrpzZJEOc3yVzrbsVaNfnSA82rJ1jn0h1iw+LfCjYNpo0IeEZME153dfLCgcyKZZrKDtxTjN1UaoprK8wM7Of2vWFBTN6eJmj2giAE0glpMID52aGdMwLqErweF0VuZ60Gv/Wpg9Ece6kQwwRWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483079; c=relaxed/simple;
	bh=FD324jkbp4yUklNIN9EFZsIswvA7nh+IQGzf2Vu/fXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SkvRQW8oH+x9gBTqh+BErRvFLFFkXsLxHGFINAFs1nu+cwpE/wYHh59Sla+IuT/sojP1OIT+ZnPA2qKSW4cakV8DByTW+IBGEb+yKAsmXSy9nWBJfA0KEkfHmiGiyItdHvw3mEQb5jKtxQavJH1K3Q889BPbZQXnpzQ3sltWQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsMSOV3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsMSOV3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65BA1F000E9;
	Fri,  4 Sep 2026 00:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788483077;
	bh=Elbwyrs1jX3Jus+rCUcCHF1cIugoR17c+/zniT7r36w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DsMSOV3Alaw6gw+oISugiAleF4URofIYSqRfOFTMRBwSNPx0g2WPDjw7ZRQk1SWjL
	 Z4Bnvc6lRiwcdgkdizrqTU5kgILJ3OjPeBZZcR/Vpsow+SyE5xy5Ig2B7YXv1EriuW
	 9Ll+H0E5PVWNCYTuQ0Gfi34YpHQmiYYJWfDEtQydFK58PsZQHWttOu3eShbY4+W71O
	 54BHH7oxlKJG537Bv2s2NiiqhHTwr88nk6LA0kwuw4hOGPgs0x4S4pGO5k1v0HYC3x
	 dLSeKakJNUBDeuwppcoWWkxXEzSIQhFiYadGUKIIC+5TGBn8OU/JhmeKr4z2TxDC5f
	 WlzvHVoReUD8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16F8D38119E3;
	Fri,  4 Sep 2026 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: dp83848: check phy_read() return value in
 config_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848301864.4094353.7900151471834554049.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:50:18 +0000
References: <20260902065828.1031113-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260902065828.1031113-1-donggeunyoo.kernel@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alvaro.gamez@hazent.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 15:58:27 +0900 you wrote:
> dp83848_config_init() reads BMCR to detect whether auto-negotiation is
> enabled, but does not check the phy_read() return value. On an MDIO read
> failure phy_read() returns a negative errno, which is then used directly
> in a bitwise test; the auto-negotiation state is left undefined while
> config_init() still reports success.
> 
> Check the return value and propagate the error.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: dp83848: check phy_read() return value in config_init()
    https://git.kernel.org/netdev/net-next/c/8c9190bfd18a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


