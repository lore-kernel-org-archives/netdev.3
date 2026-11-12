Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445810;
	b=mdKUa2G7bG9n3U1ipS1amoVcyew72gfisUKJCMFdF98ZrvvuYzuweHOxjxxls4jgENQr
	 nSaXS7G5mJ82oXiy0PBVM69B+GVeVHQjrAXcx0U/KlB2qw/XLF4Zz/76heCgxWNVrj/4i
	 LNP5xxpvp0I/QxG9OrxqjsRfD7IxSEuq46DvEM+b8Vxy0zWNlZOMq3d9aaTdBwWQzShgk
	 cVqbQJCld+chPyePYslhkMh3Zd7nFUc0DA+ZRfmGDyks6+BNeamuKeIYnwEtf+OV3TGNO
	 FYaxd05WNF7WylFmyMfVgwaHDKPNH3urLcttpOgafLVpzwqH8GHE2mf5jxDY2ZdVUvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ObshCPhNJeBqHK4VEg8dRahOpwtW4NtSrzxdnZILaW8=;
	b=vVz9FjCW3l35jeu4Lrf0iBizAEihUff+Lg8VyCz7k6PwW5618QufNa35SI1OZeFP1tBO
	 kUNbFpogWzaWnrYLdC9kC85hq1SZ4mcg/tNJmDBYbLgfCngfxgMMQ053O9wyVFrotpUSi
	 yVQ0aTkG+YS+t2vFBXYxyJN14c41vtGP/CsHI73hFs6I9rPkhIVYWTlQEToAZOYeTQGoc
	 A0PuH7RT9KlJb2T2VTLyb9MNQVY7obk6Gx3fehVoHaHxz34A1zs8mB9coLhddPFwdqhOs
	 U+MjfJOjNtmxKO+331+aw6gWiViAxWLQJdf+LMHKYc7Oyv/GTG8Wa7NlH6f/oicj6bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHYam520;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AF606A88C;
	Thu, 12 Nov 2026 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHYam520
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20611F00A0A;
	Thu, 12 Nov 2026 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445809;
	bh=ObshCPhNJeBqHK4VEg8dRahOpwtW4NtSrzxdnZILaW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PHYam520beLtLA3dU9afNOTIawSgGKlD/RGzCQ4bzNhKPD2woTw2FPQLRb9ei8vxs
	 3NKbGuEiBnj5c5N59QXQLhFLOG+6PRr3yyWWH1P8mEk3WOJcmVacwibYdL2of4EGq2
	 TRq+alUb1sL3traEZd+v1K1Md50kkOTj0dNAJVhvjVKaXhFv4C2hwWJ7+hlEpJj7G3
	 C0bjJGSVZ8yNk/mKkfnZoEpfDWZ/Z85ECPIcVL5kSibB/AD6Q+r1LOGWVDZpW5x6//
	 qjkUpYYVzSr71TrMmsNT4eiJ6Vb23M0f69Xnh6XywrgmgPHtfx/sM4eqfgNM0kYXrH
	 xQGyRt//3FePw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8115391AFCE;
	Thu, 12 Nov 2026 01:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: realtek: return MDIO read errors
 from hwmon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444580842.1745669.14920774716996178409.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:10:08 +0000
References: <20261108-realtek-hwmon-tz-v3-1-b4e9fb16d323@marleb.org>
In-Reply-To: <20261108-realtek-hwmon-tz-v3-1-b4e9fb16d323@marleb.org>
To: Hleb Shauchenka <me@marleb.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 08 Nov 2026 22:13:45 +0100 you wrote:
> From: Hleb Shauchenka <me@marleb.org>
> 
> rtl822x_hwmon_read() masks or shifts the value returned by
> phy_read_mmd() without checking it and returns success, so a failed
> MDIO read is reported as a temperature: -EIO reads as -2.5 C and
> -ETIMEDOUT as -55 C.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: realtek: return MDIO read errors from hwmon
    https://git.kernel.org/netdev/net-next/c/d5b5ab50d2f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


