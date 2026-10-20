Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503607;
	b=p0+ancJYzivEPfEBXobBJZfDmkzSsIuNtAoM405v5iQmWuFUYGt/EArRkK6Fl0SdR7+8
	 KW5/iGVuHA3yaLWzZDL6SO/dt80Z/NCtCZzPqyzlT6M2hQ3oTCJ0inNgUrrf/AMuAKfxb
	 nhzedvQnRciPNJpmVP1kzlpBlj9HLnZqYSNuDNp3w+iFJP01qHorEHvk/T/naptIYnVeS
	 mjYEd1c6GPhAcyyf9qDOMyuK/8G3wvV/hznUxe6j6kY0ZtcA5kmFF+TbJvJ8Ob60gGj9Y
	 3DatzMaWoJ0mDtxRxvrRxPJJhdtfpSCKu32NM05SrL9gzlrt1xtPCszn8bbWjmUc8hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=oF53MFWzUlMvI/N3yU56qXd16tQIWT+25c30AiTwYQ0=;
	b=2pHN35r09MbzYES82bL+sUF59uewhBNqD4JijD98fuQKSM5cHrGMa5tnMhOaLVHLzFv/
	 TIT2WqvtZvRanLHi4GPTJ73bTiuAbuSNHg1Qjpf6ti1iGspsSjYenJFi3vkVsRbNrRtTL
	 hFzVfLpLPafxU1P22h67COQwpenYUqRKlGkcBcIYONUhgCewFWBPYxZGYv64SQD/P2RuS
	 TQg4h2PP1RZS0E5fJzw8WvXayEjiHsVIiYMI2MSEjRnDSgTDUw16ZIBLJ4Au69MSNyYzu
	 wOdrjWkFSgggs80EhU7Wcyl3bAEQpHHDWM7LB9OkTL7rzXhdFTazlufscyl52h4P+RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f9/AuH94";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3F606A31B;
	Tue, 20 Oct 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9/AuH94
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EE01F000C4;
	Tue, 20 Oct 2026 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503606;
	bh=oF53MFWzUlMvI/N3yU56qXd16tQIWT+25c30AiTwYQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f9/AuH94/t0bRU6BJLR1pMewHveIcXqRpuFd0yWwMhdG4YowvzOgtJKlJKfbuiLEw
	 mwFZ0zE5z03Osy0EfJwY1CAI8Cd4ksYNXZMIWsw6Fu3oG0nN6Cn91UZ7GvzGfFULaG
	 6Clx/O+Q1GiHLqgScMR0pvebGyGnKTL+LY9m71vo69axDxZorwXFVxplSkW9em31RP
	 4S3yBgDD3+ShDOZSC3tMAmtD3tacFrIg1JP1/gvP74xEKT6QmKHT9oxDFgLLkbyf2P
	 03jpyf1OTsa+FeW/e2ptneDG5T0AqXl7ppeC1n/mVH8YtAsLzSk3+28TM8R2sQAsG6
	 h8sLPl5wKFKmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B446D3808209;
	Tue, 20 Oct 2026 13:40:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next v4 0/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179250360553.3743533.241293853463343191.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 13:40:05 +0000
References: 
 <20261014-miic-validate-dtb-v3-v4-0-b7da71b3a106@reliablecontrols.com>
In-Reply-To: 
 <20261014-miic-validate-dtb-v3-v4-0-b7da71b3a106@reliablecontrols.com>
To: Kyle Hendry <khendry@reliablecontrols.com>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, geert+renesas@glider.be,
 magnus.damm@gmail.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 14 Oct 2026 08:32:36 -0700 you wrote:
> This series addresses issues found when reviewing another fix:
> https://lore.kernel.org/netdev/20260915-rzn1-miic-fix-array-v5-1-b7173fd5b97d@reliablecontrols.com/
> 
> Invalid values from the dtb could cause out of bounds array access. Checking
> the values as they're parsed should prevent this.
> 
> Changes in v4:
> - Remove unnecessary else
> - Link to v3: https://lore.kernel.org/r/20261006-miic-validate-dtb-v3-v3-0-68617b3dca5c@reliablecontrols.com
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: pcs: rzn1-miic: Update port numbering for RZ/T2H
    https://git.kernel.org/netdev/net-next/c/5af4c3f61791
  - [net-next,v4,2/2] net: pcs: rzn1-miic: Validate dtb configuration values
    https://git.kernel.org/netdev/net-next/c/585df8d1eed9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


