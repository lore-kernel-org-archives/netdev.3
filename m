Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A564AA4;
	Tue, 15 Sep 2026 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438870; cv=none; b=akkqSIa7GstzzjNcFJNE30PR4osdsXQkW6NHnBTB6ACX6q1ABWRW9YA1RjBrbb8STD4WXygAo5AmY+XmZ9jagehNJyGle1mr6aZjn06VYFvBcxtqWRa1+A/bvPcwCjpCxFf2NhLs7abhJBO/v0Y0arw7vPeQQx1mHmFOw1cvQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438870; c=relaxed/simple;
	bh=mZYCgZmMjKNJ0ZYOB8LpqGyW/pX86Js0loHnV1b2Qm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YsxdcAvr3Aycpg2VIaWG5c/ODpMCji69QZ8EyPVVB80DS9pbBjJRo5G+IpuAtJVNASz48P0B+yDxvtgYqv8A8xypwe2yLbm6g7SowGgButgUV9okmOn53D85knPBUe6/opDSXqOYDL2Mv8S8G24wo2huIKLPIxsbO3elq4e7jHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7aHukKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7aHukKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7E71F000FF;
	Tue, 15 Sep 2026 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438868;
	bh=dZUeb83lyiWX5cprylRmLkLWYkoJ+Cr/2+o4F0gbARo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d7aHukKXdYT/o+drwFZJdCCfYBsnxTxuksaioU/UI4Uc3cTmc+hlEVzxlfGhIF/Ao
	 iV/8YCtlTKHhrfoLVTPYAwURry51LcHOgHCYKPz5lipwGWW2B7H3lh+R8tioDPiDd9
	 7oRDhgtDsfFAORZnsNdDyBjnWsGCtKv0gKdjhKzrBac0ynPTSn8+WmERVAZh3nHjZu
	 7+hub+2lhEs8NYIewY/FFF18/KFG7sT94ZZ96DEzNwEAVWwosPatCpL8wlMMH2Eg8l
	 Pmm3Ij3FFvjL2cMHphrR+zIRfdycl91p04SgzqM9RJHnZcAxOVHG+v8ktIAvxT/sh+
	 vuQBGXKerRRHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A3C3924FFE;
	Tue, 15 Sep 2026 02:20:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: mxl862xx: disable the stats poll on
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943880364.1318657.7386194334334318104.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 02:20:03 +0000
References: 
 <1eb6f7fc1789b67e4b11e3f4d5ff080d0b6f7cbb.1789045590.git.daniel@makrotopia.org>
In-Reply-To: 
 <1eb6f7fc1789b67e4b11e3f4d5ff080d0b6f7cbb.1789045590.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 14:13:15 +0100 you wrote:
> mxl862xx_setup() arms the stats poll before mxl862xx_setup_mdio(), and
> nothing stops it until dsa_register_switch() has returned an error to
> mxl862xx_probe(). DSA frees the dsa_port list before it returns, so a
> poll that fires once .setup or a later step of dsa_tree_setup() has
> failed walks freed ports. On shutdown the user ports stay registered,
> and the WORK_STOPPED flag test in mxl862xx_get_stats64() is not atomic
> with the cancel in mxl862xx_shutdown(), so a re-arm that read the flag
> before it was set queues the poll after cancel_delayed_work_sync() has
> returned.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: mxl862xx: disable the stats poll on teardown
    https://git.kernel.org/netdev/net/c/9e92ad4630f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


