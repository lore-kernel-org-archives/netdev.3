Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF048665F;
	Thu, 15 Oct 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059007; cv=none; b=ApdMcS1ehelK5xO8yNwSUM2UY8TvOO/tt5P6EodWYiFjI6RkAHrcKPzJD07qsuF+dxJGGL57PaJLXfkUw2P0E9ZqmxNmZLiJFxX2ipQnQEqt1g4yVeg0fR332yE9ex48Iog2sc/uolfLpnPf/ll0mqR9dhwX4g0d9Z6oTFohV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059007; c=relaxed/simple;
	bh=WRgzYFOArbXaTYEeFNrGeUiCrAn4QQqyStUy/+BzAZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qloPcncIG6V+HlwZgvMajtbBKtQOS4cj7NOmqauQ53OOgd1yjjIZ/s3+uIeKS1crOyKDCGxMLOT20pakmSZpqJydE7P9M2NQxbJXre5tbZxcqfu/7XbWtoMZr+rWvLOeJm9Wglsf8QxTXT1zo5AlxvsaYmEWCo20a/uP9v4glYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpGQE/J4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpGQE/J4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E1D1F000C4;
	Thu, 15 Oct 2026 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059006;
	bh=NCYNP9Fi9prxm0OJnfd1ciz/HhBuDQoqjbyYk3JuOoE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hpGQE/J4BlXWTO779nvAX1pRfX1xrCbDwDz9tSMxOxX2vp8Me50MBvYneOpCkVx6A
	 i7tkPvte/MTyO4TS9FkZaFZStyvD/5nAn6nQDBMsTEblXOcbmOwxOzWk6H+Be++sJJ
	 4uUHNcsrbGFc9I5IfjPzSC41r5oImsMBy5qkCOvBZc61psIZ8xyjtui5uE09y5mCsS
	 TSyILHdXUz6RMeTXF/zSUCRp2oeUOe2txmKXXRu3JjWcqDmZciQ3yuqi6tvhrduwsp
	 vRGHjvxxTLCnlH1hVWDcqP95d/ufVekaz63SwJi88LyQbldxZGoC2vXW0ufRkcDcay
	 xDBIpaQkA6Skw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A288392EA50;
	Thu, 15 Oct 2026 10:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: unshare the skb before writing the
 control block
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205900502.3330315.1943709997032683206.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 10:10:05 +0000
References: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
In-Reply-To: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 09 Oct 2026 12:10:41 +0200 you wrote:
> bcmgenet stores first_cb, last_cb and bytes_sent in the skb control
> block and reads them back on completion to free the skb and credit BQL.
> ether_setup() leaves IFF_TX_SKB_SHARING set, so the stack can resubmit
> a shared skb that is still in the ring. The next transmit overwrites
> last_cb, so the earlier slots complete without crediting their bytes
> and BQL stalls the queue until the watchdog resets it.
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: unshare the skb before writing the control block
    https://git.kernel.org/netdev/net/c/89771ce4f8f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


