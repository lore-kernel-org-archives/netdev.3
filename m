Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D86318ED2
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010027; cv=none; b=JHgUZ42a2AL0lXSlPQK2sSdVyJgpNE3M/aO0kuzqK1zRjRC+/S+GrOAwvglP52rdt9f4eFpZVSCGePqpS9uYYO7EB0XLDN8Ha6YWWeVbXTqfImBPiRAY81Na0GwoYmIl2adbDUPvqAhg3Q/tyvV/Ve9/io2axRPWi3pMtLptqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010027; c=relaxed/simple;
	bh=839xTuZRzHPSikAkJKowjwL0kagt3o6tfRYUM1/gGCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QLaUhx5o1tThYQikrSQN29gkBTfOyJpZkls8L9tRsbsgpbulcfAHA5pDEXXJsXtZQ5uns6q8oTOPOLEHoLBFy4wGMsCP9eP39f5rraTq1Ne5BSks8lDuoH+giUs6PgxOHVe4h+h5s5DjeRuYuZIWrRBn5xsQDV+4K6VqxQ357/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExKVv6uy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExKVv6uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BA6C19423;
	Wed,  1 Apr 2026 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775010026;
	bh=839xTuZRzHPSikAkJKowjwL0kagt3o6tfRYUM1/gGCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ExKVv6uyw9Pscmrtd1lUZdhYzFZQ/IENIJg04TGo0irqBFAUmGxTAd54dbIKANJHA
	 ub8Yv9QiuttKhxEnRJSkNTJPeyZLOGJoD0133idqUY3mzYvsydgx3Dqg90XYLZzTkX
	 3E2VhLuS7eZihyE6M2e5UqVMmO32HxLfrq6A9SVnIsAeFES/SZYG1RHaXY8VQn60fp
	 pz1lfHTpQk0iiwsRMciC9HFjRq6aj+rB6aCUGUHNuEe8uDjgJiYZs4P7yyZeZICdN7
	 X1YZroP8ivoylUIk5v+ueBipDsqitdcN/MgnI86O3R5+axXjmQ9ejlfWrFLcj/MKMD
	 P1zOZBuDyfolg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD4F3808203;
	Wed,  1 Apr 2026 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: bcm84881: add BCM84891/BCM84892
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501000978.3035943.17003013654428448756.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:20:09 +0000
References: <20260330225310.2801264-1-wagner.daniel.t@gmail.com>
In-Reply-To: <20260330225310.2801264-1-wagner.daniel.t@gmail.com>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk,
 bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, nb@tipi-net.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 23:53:10 +0100 you wrote:
> The BCM84891 and BCM84892 are 10GBASE-T PHYs in the same family as the
> BCM84881, sharing the register map and most callbacks. They add USXGMII
> as a host interface mode.
> 
> bcm8489x_config_init() is separate from bcm84881_config_init(): it
> allows only USXGMII (the only host mode available on the tested
> hardware) and clears MDIO_CTRL1_LPOWER, which is set at boot on the
> tested platform. Does not recur on ifdown/ifup, cable events, or
> link-partner advertisement changes, so config_init is sufficient.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: bcm84881: add BCM84891/BCM84892 support
    https://git.kernel.org/netdev/net-next/c/75171eeff353

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


