Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627214;
	b=Hte6PVdab2e/DNk+fB64IrbtgXrVu1NgWDghwEWsl2YBoXXsaFxQb79FJTLfZRyqTgPw
	 6OQlLuzCSSNhBylk46HCpLJQ0ZgYUOzbVSwUc/H937RqQljWl6ScpF2L/hSm1fKVJbvgT
	 PdyUEAIgZ81DpkrrMFjNWoTVysJVJoeW4c19G7+R+DjVixqs6WF+rp3K9EEr3sP82Alfa
	 N/im5+MW+SFVK61AMVD+kQ/vcS/TfM8zGGMlnP5nmAggySx4xYXsTA4e4r9AjEsA1lA7J
	 /70z8PM+rwLfTX37CMeJqaWfyDCJTeQCaTpmLN9X3sIPviVB13rlsxYe4VoIWfvQJQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627214;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BwyLmULc3FKTl/z76qKZRmzD3ruI26rD0tjv3BHuX+g=;
	b=jLD+dIpFJ6hyJ75+MC/+E5dv1a+aGl6xkaQFLYSgY8XtP7vpHWOKJqVHf28Vn4up/ctw
	 RJ/jFKueQ+yjBx+SUKvpWz5AVV5FV22T7qYra3qo637I5+FBi5fsO6HrahN9/YYHyjw4Y
	 pvUA+JWuN9zpc7GgCuNaPDpPcGMWE57yaUVxXj1RqNwLq9vmyrKZaDnYNLdBBzpbbw6L7
	 3FcNEZjLlrOH8eYHukamIjnQoeaC+teTUaFhO1mKcu33VPmHXKFrM3EtGXAL5h2uN3+nh
	 U9Z14pP2JGvtlyXmF0bZbDWJ0rImtqXEte3zSCKluNV0fi72gAWMdGUpGdQWHDoK6cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eo/juyi6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F8606A320;
	Thu, 22 Oct 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eo/juyi6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD4D1F000C2;
	Thu, 22 Oct 2026 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792627213;
	bh=BwyLmULc3FKTl/z76qKZRmzD3ruI26rD0tjv3BHuX+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eo/juyi6Lf5iA+PobTqDGC+KnTR550icwvHhI2AhSoSt9FsRK6HsutJJt6H3N2CrH
	 z1bCm5gVe0RGBFEeunH+iqqTWDTMlRgJdT4eZ/JB8FBD9Cf/KlBxSY14n7Lsd+nr2h
	 aQ7shM2+2yLwe8xFGTu4QhNz2EA6yeLbVWQBC1WJJ4+M4fwwzyWlXhomVZ8VzLwwht
	 4qpwcvBjJ8wtcJjsSktZmcnLR8rTN1i4UretOI0pbEgHp6+xO3HNcW79DG2x+8j07g
	 3i/gTKnYwhYfN9WSF2ZV8t+vndNYevpw5puE4lHyg9wLrJHFC2/i8w51BK09yQuhDh
	 b7auOI1bGNjww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44CB380A963;
	Thu, 22 Oct 2026 00:00:13 +0000 (UTC)
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
Subject: Re: [PATCH net-next v19 00/10] net: phy_port: SFP modules
 representation
 and phy_port listing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262721228.1368559.2594961555550561911.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:00:12 +0000
References: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 15:30:55 +0200 you wrote:
> Hello everyone,
> 
> v19 addresses Jakub's comments on the netlink part, the only missing bit
> is the phy_modes() rework as we'd need that even when CONFIG_NET is off
> (for OF and generic PHY), so there's no clean place where to put it. It
> also addresses the medium/high *ashiko issues.
> 
> [...]

Here is the summary with links:
  - [net-next,v19,01/10] net: phy: phy_link_topology: Add a helper for opportunistic alloc
    https://git.kernel.org/netdev/net-next/c/b428d67934b5
  - [net-next,v19,02/10] net: phy: phy_link_topology: Track ports in phy_link_topology
    https://git.kernel.org/netdev/net-next/c/9fd93893b6fa
  - [net-next,v19,03/10] net: phylink: Register a phy_port for MAC-driven SFP cages
    https://git.kernel.org/netdev/net-next/c/b8335326fe06
  - [net-next,v19,04/10] net: phy: Create SFP phy_port before registering upstream
    https://git.kernel.org/netdev/net-next/c/99d78aabd783
  - [net-next,v19,05/10] net: phy: Represent PHY-less SFP modules with phy_port
    https://git.kernel.org/netdev/net-next/c/51ebb13c1d96
  - [net-next,v19,06/10] net: phy: phy_port: Store information about a port's upstream
    https://git.kernel.org/netdev/net-next/c/9e7cd33fafb2
  - [net-next,v19,07/10] net: phy: phy_link_topology: Add a helper to retrieve ports
    https://git.kernel.org/netdev/net-next/c/b06f1e6c85ba
  - [net-next,v19,08/10] netlink: specs: Add ethernet port listing with ethtool
    https://git.kernel.org/netdev/net-next/c/01a556b3321e
  - [net-next,v19,09/10] net: ethtool: Introduce ethtool command to list ports
    https://git.kernel.org/netdev/net-next/c/27859d18bf41
  - [net-next,v19,10/10] Documentation: networking: Update the phy_port infrastructure description
    https://git.kernel.org/netdev/net-next/c/8af404a3844b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


