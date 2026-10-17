Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B23876BE;
	Sat, 17 Oct 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201816; cv=none; b=OoRu+ssLl78bFrGs0sxvsIuE9hDXVxrtxSf4FBJ4lvWNgDNsesWcoqsVXJwixL3Or95725bnwz4ycMZMmH1nhWxcTe8ZLw/9xj6pPaXeWMi/VGUl05Lyru1F1jkgeTfds609g96nVPPgkNBgzuL+JglzY6Z0RT+jQeNb8abgnGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201816; c=relaxed/simple;
	bh=Jy84qNyua2c6bKD6ErRGhzdYp+8eg/UII/kvSsuMPJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jZ0WkudZhZ3izbrX1+PT/ZkmKifadokuceVlgLZNV2JRTDIc3HkBs48sgNB0uSkcplDyUnOjbFqEPcjCOyNaVUnFq7X4VB6hA3MQUsGP9fIRf1r6ummkH1UaopdbbeUVZqS2yiC/mu3/rUzIKSixa/ERK0IpjhW6f0/7IkgJ/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW4jGywr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW4jGywr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8039E1F000C4;
	Sat, 17 Oct 2026 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201814;
	bh=4Fu58a0NmBn3XQdNc+Da+WKytu4zyoxLl7XWEd4LM6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eW4jGywrf3mbDdWWX153aZj5HeSypvRKtP0AMyrAs0d0wSbMXjFb0cFc9BOcCC0jR
	 xrjsCVGvRKZel+X/nmz/In64GD0MOawfkxrnhyaYnPUBmDeW7o3kZJDJeexF9ijl0I
	 XYVvyekvVwArnOjqM3yBOyTPhvHqptJ4xM/0Lsf0KZ61aeXCq+dyS9hF6VbpG0JTNS
	 xhJl3NbwJs/C7DM/UpF5uKjVAXWsRHGNzDpPWUfizeINHXc7Qtj+JsRoMh0IvqGN0L
	 tD4CQ+IpR0ivJ7par+VMmfIUYlItDP0yKkJ3SS21fdDZ/sUWztVfBWTfmILKke8CW8
	 2sfdxJ1bXuwRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77393380CEDA;
	Sat, 17 Oct 2026 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: phy: fix a second attach of an
 attached
 PHY and the module put on detach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179220181326.1055958.8232686997643079264.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 01:50:13 +0000
References: <20261013151200.2473464-1-f@lex.la>
In-Reply-To: <20261013151200.2473464-1-f@lex.la>
To: Aleksei Sviridkin <f@lex.la>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, woojung.huh@microchip.com, vladimir.oltean@nxp.com,
 maxime.chevallier@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 18:11:58 +0300 you wrote:
> Two phylib fixes found on a Keenetic KN-1012 (MT7981) while chasing a
> PHY driver unbind race. A second attach of an attached PHY tears down
> the first consumer, and a detach after a driver unbind leaks the module
> reference.
> 
> 1: refuse a second attach before the driver module is taken or the
>    generic driver bound.
> 2: put the module the attach pinned, not whatever driver is bound at
>    detach.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: phy: refuse a second attach before touching the PHY
    https://git.kernel.org/netdev/net-next/c/fa38468cd26b
  - [net-next,v6,2/2] net: phy: put the driver module the attach took
    https://git.kernel.org/netdev/net-next/c/7151b86654fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


