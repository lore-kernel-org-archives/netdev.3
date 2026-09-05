Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A53955FD;
	Sat,  5 Sep 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597670; cv=none; b=ofUDtMgpj1dPOzNTdQmE6NCqUCHsAhNakqbf/HDz0jma14eRX5FUbFWEo/Mb/cbTdyPgjLcV0N3hMgaFCCHoy21vucx1OH4dSjgrp5eXB7ZgfaoZ50Ead0rvyiwhLVv3uO4k7TfK+xcJqg9SqDDLxyQvm4On1h0OXkZfArKMBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597670; c=relaxed/simple;
	bh=01dCfMEX7U0pImuPOJtbPm5GEgzLfsJegHaGQY79RAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IwGhbFnR3WMxaNQJVpY/7846aMcSFAeFEJjz9v8iQ3Q+YQmoJkux/6yk6DQaNOFtZbapPPTZxe9iWrGN8ybJRZ7NYf7q4CcHWNBfr1mxqeZhUiXp7dVQTUW1yz/wKS2XMEFavVxy4GW1qFEHEu8nkoZNzqHFs0a+SBMs4JXdgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGrZdy0o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGrZdy0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A421F00A3D;
	Sat,  5 Sep 2026 08:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788597669;
	bh=CfuAK7+Sm1DbzUlDeMzARqot3dHRF2H94Yl3udozaHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PGrZdy0oAH1oN4J03aW5GIUSkOkzemflzS1RBVNfFtmRJcrVLJSCQylADWuCpYaSO
	 KcTCyZu/XJb572yHe+XpRC49/3jtIKxX15OPsjKm/UIbUQaNbtygEse6axDnV/pKJt
	 A+metk1XzZ7N8W9NyPUstl8Y7EuMmc2ceAHTrYSif3ZYw9+nUjFRVPk3xO5LRFEmoJ
	 YZnUZM2F+khF0LytZE+eWENE6jFdUgRGvylVwxB0WIsce4mou2VYF6g6pBf4IcBm82
	 Qd+mgMj6TOuaURlFkIzluyVKNNPMZNsubZjxuwRZRItEMsP0TgvxZzzI3QMz+nBxh5
	 LzQ9mfn8Q1EkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB03924FC0;
	Sat,  5 Sep 2026 08:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: i3c: serialize probe with bus removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178859760940.1163651.3199545435617874397.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 08:40:09 +0000
References: <20260902060118.4025762-1-v3rdant.xiang@gmail.com>
In-Reply-To: <20260902060118.4025762-1-v3rdant.xiang@gmail.com>
To: XingWang Xiang <v3rdant.xiang@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Sep 2026 15:01:18 +0900 you wrote:
> mctp_i3c_probe() drops busdevs_lock after finding the matching bus. A
> concurrent I3C_NOTIFY_BUS_REMOVE can then unregister and free the bus
> netdev before probe passes its private data to mctp_i3c_add_device().
> The latter consequently adds a list node through a freed mbus pointer.
> 
> Keep busdevs_lock held until the device has been added. This also
> satisfies the __must_hold annotation on mctp_i3c_add_device().
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: i3c: serialize probe with bus removal
    https://git.kernel.org/netdev/net/c/2b4707a149a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


