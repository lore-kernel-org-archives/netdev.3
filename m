Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3754279DCE
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178650; cv=none; b=gEYlIVF+Q2BgVPwLZe2AVRvUovXg5U0vEYz17zN2ATCxZpp1ZezUvblXPJUtvgJHmUtQQvbxYN7dIKyPa8l6UW1X7vBtOCQV4aYQKXiD5zZfFwI1fckN76rqX8YwRKl0v+FpYm5LuEzutv9/Am129/81QzVJCZ0c7UWDL7RD/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178650; c=relaxed/simple;
	bh=um7mjCABSVYKCHKWqm7U3zZDUkJA/mX9EHnXdyzMXGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oCrVH0i1Bc/efJXDXEfDEGOhSkJZhRE9e96XslEq03Gv9aP43boTGkaYKBkSFIntYWsOaqaZR83dp0vjBbLKd+iQF1Rx/DRivRbT9OuKuTu7wonzc68qR5F6hcQXu7VsRWGkfZwdH7wu7rbi0a5zYxEOIHQ/Q3SE77i4ulYk2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhiGsAYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhiGsAYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690F6C19423;
	Fri,  3 Apr 2026 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178650;
	bh=um7mjCABSVYKCHKWqm7U3zZDUkJA/mX9EHnXdyzMXGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lhiGsAYw6PjWJnEOF1f5Z/1xzrr9dnYsvUx4Y4x1Sm4BQ6+DU2sdpuZOfkbJi4p6b
	 fmOfmwYiD8ToLNaJ09eOWDCwrPixL5ZyWkNycOs2CufSGMM7XYscctSyvPFwEOpF2J
	 49ICrcKwFD90gljokQQISpd9zVIHwAflesibSR34AXNGgsFQzrdVcOU+mFB/ujF2N5
	 kz7VoTVJLWkJIlG0gdVDdVxMabMdrW0FdZBMRIRX2Wm0XntWXlHHVyRfdSeWcf+PD6
	 yx3Xdu45gE268lx5whcIKOQ7DbNZxfDovNzNPOSwNXahexp2cLNpLUG+p+DkOCg+Xu
	 6jtPiT6rO3HOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FF53809A09;
	Fri,  3 Apr 2026 01:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: bcm84881: add LED framework support
 for
 BCM84891/BCM84892
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517863253.685228.7304854581317179724.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:10:32 +0000
References: <20260401114931.3091818-1-wagner.daniel.t@gmail.com>
In-Reply-To: <20260401114931.3091818-1-wagner.daniel.t@gmail.com>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 12:49:31 +0100 you wrote:
> Expose LED1 and LED2 pins via the PHY LED framework. Each pin has a
> source mask (MASK_LOW + MASK_EXT registers) selecting which hardware
> events light it, plus a CTL field in the shared 0xA83B register
> (RMW; LED4 is firmware-controlled per the datasheet).
> 
> Hardware can offload per-speed link triggers (1000/2500/5000/10000),
> RX/TX activity, and force-on. LINK_100 is accepted only alongside
> LINK_1000: source bit 4 lights at both speeds and 100-alone isn't
> representable, so the unrepresentable case falls to software.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: bcm84881: add LED framework support for BCM84891/BCM84892
    https://git.kernel.org/netdev/net-next/c/7eaff1eff003

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


