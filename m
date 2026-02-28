Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353CE54B;
	Sat, 28 Feb 2026 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298605; cv=none; b=d4gHEHPytCaAkfEtRxHh5X7iLROxmgsLa1u8SjzPLbzpnTkvc6OOH0/oROmN0lgOR6+Wlvez8Qzk+5NDkNYD8PaVQ9GtRHZicS5jsqWKM0+Uw1h36/cM/Iou6qc/zWwzz7UHJu/hyFFjsRGwHKiR6dyO+2nFNTzlejt7m+D/3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298605; c=relaxed/simple;
	bh=BUi7jHOfV+VhjJJvaNO7POcZNmBOSULz5vtObH+C2kw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EJIAAcODBISkraALaGr0XVV2ov0XvX85i+PyYwaZkV1rgTxK+pRZ1DT5z5C3DEQF2hThxPfThuGIVH+ynCWFmC1zV4xbH7coFeTa9nk7ZHQJ2PFJyOceaB8UvmDqzrk3PtzPfXGjEL39i4dMhOfJBF5iw4IFgxhUwoImUoKDrbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZkOvLHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZkOvLHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B52EC116D0;
	Sat, 28 Feb 2026 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772298604;
	bh=BUi7jHOfV+VhjJJvaNO7POcZNmBOSULz5vtObH+C2kw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HZkOvLHEV/w5zV89NpR1WmeXfobaWKhctK+saDQm6iJHUztKzMwRhu22xlhS8fb+M
	 +HGPehstmD61IEVarLv21ZfMQ26ogkfEBnp55rd+xAflqLVDYHBj60qw0e92OvJhdW
	 GUL8nAGBtdf4ey7+hEOS6D2LZqewCHhGx/hT/QzRLmx0Ah7mfH65VkgKZCYCR7Xhmj
	 6/YPzPwex4AmLTTJz1x/4NDUeIDaZ2qvW6d+Opcfae/cQ0opo2WTaHhZ4Pm0lP9Nwn
	 G7j5k1QqDWXpSCw0SbuVvRVAzyBVyDd5Yb3Md6NlMMOmKtR8EPHXd6WHKjtqN+m3OS
	 If75qSwG4mWIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD739F2022;
	Sat, 28 Feb 2026 17:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] gve: Support larger ring sizes in DQO-QPL
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229860779.3017701.7255871704850318955.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 17:10:07 +0000
References: <20260225182342.1049816-1-joshwash@google.com>
In-Reply-To: <20260225182342.1049816-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, jordanrhee@google.com, jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, pkaligineedi@google.com,
 bcf@google.com, thostet@google.com, linux-kernel@vger.kernel.org,
 maxyuan@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 10:23:40 -0800 you wrote:
> From: Max Yuan <maxyuan@google.com>
> 
> This patch series updates the gve driver to improve Queue Page List
> (QPL) management and enable support for larger ring sizes when using the
> DQO-QPL queue format.
> 
> Previously, the driver used hardcoded multipliers to determine the
> number of pages to register for QPLs (e.g., 2x ring size for RX). This
> rigid approach made it difficult to support larger ring sizes without
> potentially exceeding the "max_registered_pages" limit reported by the
> device.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] gve: Update QPL page registration logic
    https://git.kernel.org/netdev/net-next/c/07993df56091
  - [net-next,v2,2/2] gve: Enable reading max ring size from the device in DQO-QPL mode
    https://git.kernel.org/netdev/net-next/c/a2f19184014f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


