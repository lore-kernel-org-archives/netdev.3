Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBE383C8F;
	Thu, 24 Sep 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208080; cv=none; b=Y54WGDP0D2amcM09q3olaGqRY7LUZ/PnZ+ITFO2rnWRKHYywmQKU/Izn3T7eptshAt6SoPGdFxG5GE/h7s329PUDFWAlhbH2LoSBbXT+YOuUkwoLEmg6fLJ9iNRnXDSIYxs120gcJUDWkVelGIBtgU3pW9vIIzCFdVT2UNygyBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208080; c=relaxed/simple;
	bh=sCuRTC1fs9cMOsH+wC07AXmE5WzEaHEvLiuz444kaiE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KIG/1DrzvxRtO9WQt2jMSJo1yv/Cgrmol+/RTEfR4Uaq7dpq/37HNoKCC7SAe7+xnkGBrSEwHQvdW3B8KIf9+IuA2dEpKyo8MEM9zGWI03C6+wf7ltzu7KkNQn+5rcEH8k9st/IgTjBkx6Iy4Cn0lSZTxvtzZqJkIxphNbzKmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYlk7co9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYlk7co9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A821F000FF;
	Thu, 24 Sep 2026 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208079;
	bh=JXtNgY3L/hxeTJP4ZSqMZFG8LW3x9MkTUaizU/HFJDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DYlk7co97HYr7mfIP/2rP18bd8oFnjTBIx5nKKH0KqKyMzwkZ0w9jx2srIiumTthr
	 KjqdsEXDBmKPi8m1VyTG3HmVTaNzTba+1tD9e0JxAKd3U/bw7//Su+EuimL/3DPJzi
	 0XfuRTeDhhScY0nHbIGG58aRagmYqYICqnvanuJU3nyy3xc4qt5T1de1u0YhSo2Y15
	 FiOll49wXa7vkzK0fZaNpxL7Jo8cddiJmknqjAuYuDQuzJr215fSfS4bv/kGObHTeR
	 kzkbsvchX/stIK9zN1GyNabhXFOxPw71sc/IVUzs/r543V27wMyR8S+uSOsN4cSUhQ
	 H6yVBH2Yldk9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567E739E9602;
	Thu, 24 Sep 2026 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bcmgenet: stop Tx NAPI before disabling the
 queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179020800889.1240300.5416980125665903707.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 00:00:08 +0000
References: <20260922130639.1660797-1-nb@tipi-net.de>
In-Reply-To: <20260922130639.1660797-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 15:06:38 +0200 you wrote:
> bcmgenet_netif_stop() and the Wake-on-LAN branch of bcmgenet_suspend()
> both disable the Tx queues first and stop Tx NAPI several steps later. A
> completion in flight calls netif_tx_wake_queue() in between, and nothing
> stops the queue again, so a transmit can reach the rings after they have
> been freed.
> 
> Close is safe because dev_deactivate_many() stops the qdisc first.
> bcmgenet_suspend() does not, so stop Tx NAPI before the queues on both
> paths.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bcmgenet: stop Tx NAPI before disabling the queues
    https://git.kernel.org/netdev/net/c/7e87508b5c4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


