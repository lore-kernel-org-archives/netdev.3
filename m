Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3302DAFCB;
	Tue, 17 Mar 2026 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717626; cv=none; b=hczl7+jGwq3TIbHpgkgMjIMdmQm7QkAkOkpvYLXhH6vDp8kPvbkHU8H//NRBpaIZhlkHuEGCLCWTYPdkMVLRNsF3bZOvd7m/Ce9lGUDtnjtezQQdMo2NenkJ/OCPg7SICco2XHH8fjBnksBr41rDLIhfCJHlnPqSTbX7Cr1kzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717626; c=relaxed/simple;
	bh=BwQzW6m0teoERg3UTn37tup+faXdlyYzoOEPIu4CC2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NYFlspXGPUCcZSJj+lHhrYNLr1HHj+ml/aH+oZyvLwUxxKSVeGrPUJcmqeoX0XZXtZVRNXSy/Ma5lghlCFPtE0opa31nwPB5B2OawBBrBQsA/tV9ytx3ZcOZe+NEJRJXotOSd5QbCWu1zl7lbV9pDvwRvgVYKHYe7QN5bPsrGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkHcyanq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkHcyanq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2417EC19421;
	Tue, 17 Mar 2026 03:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773717626;
	bh=BwQzW6m0teoERg3UTn37tup+faXdlyYzoOEPIu4CC2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XkHcyanqBSkcYJQFxmNauNV5F00+xM89nFvrXvPudqPOw/vQY6IaZ0S5dCoDnW1bQ
	 FYfX87Wu8f9jqsCyZMkluoZexkNLMt53d+geXoGEzSgy5Yafvr5Rqp92lfHPVrNb4K
	 9umgsEmJq9uNDvd4fQkRkrIVF5TSHdj272hdQ5AekfIFhfJxFbAN7X5gS4blZD8HtW
	 e6RqlEdWX+Brr88MSZdrRDiAkqe36hX4iAQ/V8w3c77aWucW3LMtVeq+HmFb50jlQC
	 AZP+j33FLGE3u9vFxwH7B1okbQgJ+4RrO+7sDXy9g3Sa/ulhdJTzgEEzd9B/Z87pdi
	 F4n/gGp2YNQ6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E263808200;
	Tue, 17 Mar 2026 03:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: macb: set default_an_inband to true for
 SGMII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371761853.3410412.3146259463182102700.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 03:20:18 +0000
References: <20260313142140.4040647-1-charles.perry@microchip.com>
In-Reply-To: <20260313142140.4040647-1-charles.perry@microchip.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, conor.dooley@microchip.com,
 rmk+kernel@armlinux.org.uk, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 07:21:39 -0700 you wrote:
> Most platforms using GEM in SGMII mode use in-band autonegotiation
> because it is on by default in GEM's 1G PCS and is always on since
> commit e276e5e40e92 ("net: macb: Disable PCS auto-negotiation for SGMII
> fixed-link mode"). Leave it on if possible using the "default_an_inband"
> flag of "struct phylink_config" so that platforms that lack in-band
> autonegotiation configurability at the PHY do not break with commit
> 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled") which
> will turn off in-band autoneg for non hot pluggable PHYs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: macb: set default_an_inband to true for SGMII
    https://git.kernel.org/netdev/net-next/c/348baefbb635

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


