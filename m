Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553408;
	b=THs+Gf5GEPeREH+fSFQd12KqsQiGbcdmdrYSJhZ2nDtEWCbM6WCWq0kRaBNb5XRRJ/ve
	 hfq0/wVSbYWiM0V1GUeo9bmWithG7CdLHGotow4lSvnt1hYe1O1WoYow5qNTEHzth5awJ
	 y68cyeoF8XhJl5oviOjI2Zs1KBbIKgA+PWqis1oXURXwUuOblrg3Hym3QCmwRnLGsRASy
	 WeN9tUX+52xqBNJ1PwJtJ/ZMAZvEpIyZRocxFcdshs/8Y3xtr/3yBj1hNmrnH/i40XbrT
	 fRvOuBpMn3eTw6tl1yfbb0GDJaDNMKa7m6bGoQMnmDTaYfWhuOYt4CyftZZwaQ4aevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dF6Ecrha90AY2ZN+AU+N6oPHUZAc3Sti+PiNBpi5wbc=;
	b=YkaD1rXW2ZfPjUD8uuwND5rvOPJuKnw5rRxmIikgtcXr09Ls+o0xU20dPAaUqdKGEazh
	 bNxngwIGvdyZ9ByV6sbzUKOLEPTBgZAeV5EYf3mIK9SqGgx089CLMWPy9v8d53wgbOgFO
	 sxRJW3NIJIP9eodQoJ5sfj+dRK6JZJZgu1NcCmNpZTGAUAdVJp8sEO63kexYO6SurFTEQ
	 9/tW5F3wPp7WCS2IaUk5mirZFa52ksuy/n4iZhuIub8gECscfMP/mjZyxV0uXTxIhUtYZ
	 TfPs8GLGw7NGoVZSpIBGsy31vZB3HcuPktSeLEXQ4RzYRlhFh1dgzCMczLUsoTfRp+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vttmvpc9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE5606A31B;
	Wed, 21 Oct 2026 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vttmvpc9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4587D1F000C9;
	Wed, 21 Oct 2026 03:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792553407;
	bh=dF6Ecrha90AY2ZN+AU+N6oPHUZAc3Sti+PiNBpi5wbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vttmvpc9HI0yoiNfm6YWOC8lKRo/g4+Cal19b315/OxX+PGo6d6AFzdG3Zb9JH6D0
	 h7Gfjx4MyEjxKrV41DL8wYONOU/uRiCYdFJWYLAYui53r9C5tKeQengdinQp+nqzYE
	 z28rBqSep1zSeuum5YRoyUgidiVdaj8Pv/Apx5XFJ1/YD+Eeh7FX7BrJQ2xwMbpkzV
	 1VjnlzSzGsNWiOf90lVthAeiVLKWGTcX/nDgXi5ixy9+kXNEWhY+W9smBVJd6ORZrH
	 uDsYIn80khfqy+rx24FsigZWvCZvnMiwoc9XPkMJBp272H2OdlngMDWidHc0GqlvLB
	 E216v2QXBOH6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4873809A18;
	Wed, 21 Oct 2026 03:30:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3 0/3] selftests: drv-net: Introduce
 flow-control
 selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179255340603.371569.15249037018606424996.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 03:30:06 +0000
References: <20261015134350.629593-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20261015134350.629593-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 o.rempel@pengutronix.de, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 15:43:45 +0200 you wrote:
> Hi everyone,
> 
> This is V3 for the ethtool flow control test.
> 
> This test aims at validating the flow control implementation in drivers,
> using the ethtool API.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] selftests: drv-net: Introduce a selftest for ethtool flow control
    https://git.kernel.org/netdev/net-next/c/cbd8a536cd6d
  - [net-next,v3,2/3] selftests: drv-net: pause: Validate the pause autonegotiation with a partner
    https://git.kernel.org/netdev/net-next/c/8f897f26ef34
  - [net-next,v3,3/3] selftests: drv-net: pause: Validate pause autoneg interactions with link autoneg
    https://git.kernel.org/netdev/net-next/c/aca2542b886d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


