Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279282;
	b=yOZSjq8Tc1QmUx73ahsW4zd2xtbxjG21JbUlB1TCQZzGau62HTpf1BZmTQi+ou0hrfj6
	 xsfov1f1q1OfyNKPBJyXLlQlYB/I/QW94pZqbU41NoPsKDr1rg4k0O7Z7RIStyIVl9o9G
	 2bsJp5ws3DEPZqGIMC+ucmsFAP9LkACH1apuIzdDwB2MjuSUe2r+CTVPxBZXblbGsDrgy
	 8LSuM60JQeBoTyJwkvTApKI88qSo695r7ZDHYKAI7M/o9BrmaHs0euHOhpmi20/t75SEB
	 vP52mSlY6vDnvWM0fdihyXJcjgQul1un8zSgtbP2mdbUDx+AofiNnXk4rBYG4hm8qgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279282;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pGDVjv9GCVnC1zC0BjKIXRdwsel73N9am2wcYD2t6H4=;
	b=OATc5xjtZj/WRuSsQK2+oCHwOFc3nNNFVx3An822li0J+42d56QmyC4xFRUgTt35/jmI
	 LKGUpqPnuv4M3kYPClNurL3C1CAx5oGB8TwddT1JFVaYnlmRgLkk14RRwYOnryhoNBl/A
	 M/7CbLakYXfWziUo8jwkUsyEM15bqn85+wRKybn2fgCXZ+oCJtP8emAslxbUxePoxlxHi
	 gfIHukZkd4iEviUkedyEiWmrcGpYIyyd0XM6MSpO411uxKwl/d/gITIafkEe8jfQlvqrB
	 wiXoAtnFkb/w+vmk9zA3Hx/YqDr6RFF0xPiu02mALEwWBwuOZ/LODL5qNUt80leAVlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IilU8Oe7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B14606A321;
	Tue, 10 Nov 2026 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IilU8Oe7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE8F1F008A2;
	Tue, 10 Nov 2026 02:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279282;
	bh=pGDVjv9GCVnC1zC0BjKIXRdwsel73N9am2wcYD2t6H4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IilU8Oe7uG7wi0bIXVG57RfUcH7zKAiDLG0eVYZpYGGphn+6cAUwz+UGYNeE3pvAC
	 hflta5RFJEhEi9GwOQPsbaKHx5izVJo0VeXfDYd1Z8Q73j76U6MnuVqM9CcGTcGD3O
	 2xACmmyhTk+mZDjXa47YxfkgQYKOzv+4F87flZVhf8ApQ8iDpByiEAotoO/K+OBwlF
	 kD7WReH9Y39zxgFL1YcKvyTXxyRQyhzoarNhGNDwhl2sWKSgG7M0Tyy+TtGiOBwEzI
	 I/EQP6lDP7VxdoqMpJLsW/77Ay7dGtW2Q1NlHTOcTmgu8geNlKw33bMBiNakIJeb6i
	 wZvFB8svx3GxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 21208391AFCB;
	Tue, 10 Nov 2026 02:54:42 +0000 (UTC)
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
Subject: Re: [PATCH net] net: usb: lan78xx: resume phylink on non-reset USB
 resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427928067.3612825.12651783871819914627.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:40 +0000
References: <20261102235133.23011-1-stefanomunari.sm@gmail.com>
In-Reply-To: <20261102235133.23011-1-stefanomunari.sm@gmail.com>
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 o.rempel@pengutronix.de, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 00:51:33 +0100 you wrote:
> lan78xx_suspend() calls phylink_suspend(dev->phylink, false) on an open
> interface, which always stops phylink and halts the PHY. The matching
> phylink_resume() is only called from lan78xx_reset_resume().
> When the USB device stays powered across system sleep (e.g. s2idle) and
> the USB core calls .resume instead, the link stays down until the interface
> is brought down and up by hand. The ifdown triggers:
> 
> [...]

Here is the summary with links:
  - [net] net: usb: lan78xx: resume phylink on non-reset USB resume
    https://git.kernel.org/netdev/net/c/be9587c47db1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


