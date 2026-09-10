Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90278377553;
	Thu, 10 Sep 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055472; cv=none; b=jE3w9ow0OOFB/uUui5H1eLdv4f77iWzsCMdFh2ccUzOQl6v66BNK0qvBOITZ84c/vqc665F+jbvONuXXFTmWLIMU4iDkyFaw4DP7BBN9sfFPOZQ3aD7s/XW9CFDSS6/vc1RDXtmmXUXHuvup3GQsPgQ8sojMWUrlx5Oq+Lbb804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055472; c=relaxed/simple;
	bh=hfjvvgQw610BAmuALSHE14lC6ihOlOKL4waqehdnbDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oFHJVo9d3ctqumsrmuk/j3uhTfITM8ZYtI6LeqhvQjBCxF0jTwFUHB6QAB2yp7xPGuKdjQ/9znhXEaSCPIaF3AWcmkArY4tQd06riVTf8guW+ahA/FboI5bI1HSF4lcT2MC48gwWG5tYF9sKPRHf8W2k92b9YBU3gqjJtAij1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0IDzSeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0IDzSeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7A41F00893;
	Thu, 10 Sep 2026 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055471;
	bh=lAxxxd+icwL3OXZJ6un0FNRSE4xRvoZ/XAj5r5yEcBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L0IDzSeBMy8mlYT4O4IJjdudjfuXXuUiFfjkdZL0OZRQjA/CAXMMLT7RYUbEZdgln
	 hd1f+BFALWmuZiQKtbsJgNGIQ/1KQFUOavDGm2pcRFwT0NZ9UFTIwqaaweboTdE/MJ
	 occ59/fNd5uTBK8XrAeEatpS5nw4/Mg4DS2h5eRBPHFf4Hb9zZGasiN7lUUvUz4em6
	 fyOcsB5oTmuK3fmZncFVTTA/I73QA4oSM+vx1DwX7DfQZdWINF3wwIEBjA6FYKHwOY
	 NRn7Na1HfQxt57sMcSwJvvNoClRadNQ/qtQ2PXhkX9N+Gcd4KbufgN6mYUkhTlpqpW
	 s5DSnhwb3KyCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B34380CFFA;
	Thu, 10 Sep 2026 15:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: phy: handle the active-high LED polarity
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905540837.1510486.3215302337759175412.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:50:08 +0000
References: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, daniel@makrotopia.org, o.rempel@pengutronix.de,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 19:59:56 +0900 you wrote:
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") let a device tree LED node request PHY_LED_ACTIVE_HIGH, but a
> ->led_polarity_set() that only handles PHY_LED_ACTIVE_LOW returns -EINVAL
> for it. of_phy_leds() propagates that, phy_probe() fails, the mdio device
> is left unbound, and phy_attach_direct() falls back to the genphy driver,
> so the PHY loses its driver-specific configuration. Three in-tree drivers
> still have that gap; each already programs active high as its default, so
> the fix is one case label per driver.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: phy: dp83867: handle the active-high LED polarity mode
    (no matching commit)
  - [net,v3,2/3] net: phy: dp83td510: handle the active-high LED polarity mode
    https://git.kernel.org/netdev/net/c/6ca81bbc31cd
  - [net,v3,3/3] net: phy: qca808x: handle the active-high LED polarity mode
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


