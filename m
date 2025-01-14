Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED22206A1
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895615; cv=none; b=tfWy7Gexg58Di9CIz11Sm4j4eySVc+BIrzCSgmdU4JOeGrba2Q0GcTCJBSqxpQMuhvDGK4k883/tND4OVa40oLiyDVypWk3XRhGXemppOwPQHwwwG/bvgPFeLan1q2bNuyCN19BtgDEsRLAzcrQi1d8o1XrYxWaYW0WFrWC34Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895615; c=relaxed/simple;
	bh=nuP66AnBB3lr0usah5zBWOTcem2+E2Hbve4YWC71rkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=if4BV/yOPV/nmRUClkbKhwloNq6G8VWoLG517DICHrkdcwvoNpdvEMwTFKFPkgh7JTyCqj/uSEbaBldVKkMIDU9gEoE26b/wCREItQlIuQrvRjTjTdq9Uk9jc/6Urm/4my4jWtJM6au/Trb66o7GY1v8BrViu+GGBxXMwCbpBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+OfneGQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+OfneGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D15DC4CEDD;
	Tue, 14 Jan 2025 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736895613;
	bh=nuP66AnBB3lr0usah5zBWOTcem2+E2Hbve4YWC71rkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m+OfneGQNKLt465exRaZ+UEqtVJLKFDewomLDLfHxBoJbCMOEb/i8cFBEyi+LfauH
	 gZelTgHkn4ITh42iTYK74uIypzFgN5aGtnEYsKKG9iQe75P4+Job0jDkPT06Emm4sY
	 o+Yke2Y4KziC9sU5g8Js0WypHXEszO5cy8D5jFRK0OG1v6q0SaQtM4hXTwkao4bWwR
	 U1jcO+NSTcDyZC0aptEme4fuBr6U1WvSMdSVZCX17pmHbaYnlaq30RfG55gQ23a+f8
	 o6SEiZ6Jdpuqf1dNpnE4lKkIuyLXp4+VZqNKdKSPxRvycFB+V+McoWyvj4DQaHaxOJ
	 naVLtYCJNjd9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710E9380AA5F;
	Tue, 14 Jan 2025 23:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: phy: realtek: add hwmon support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689563627.170851.17398917606349589259.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 23:00:36 +0000
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
In-Reply-To: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Jan 2025 21:48:29 +0100 you wrote:
> This adds hwmon support for the temperature sensor on RTL822x.
> It's available on the standalone versions of the PHY's, and on the
> internal PHY's of RTL8125B(P)/RTL8125D/RTL8126.
> 
> v2:
> - patch 2: move Realtek PHY driver to its own subdirectory
> - patch 3: remove alarm attribute
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: phy: realtek: add support for reading MDIO_MMD_VEND2 regs on RTL8125/RTL8126
    https://git.kernel.org/netdev/net-next/c/3d483a10327f
  - [net-next,v2,2/3] net: phy: move realtek PHY driver to its own subdirectory
    https://git.kernel.org/netdev/net-next/c/1416a9b2ba71
  - [net-next,v2,3/3] net: phy: realtek: add hwmon support for temp sensor on RTL822x
    https://git.kernel.org/netdev/net-next/c/33700ca45b7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


