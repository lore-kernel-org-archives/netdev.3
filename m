Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFBA3876C7;
	Mon, 24 Aug 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597472; cv=none; b=cEqe6PAzM+Ri3brfVVxo1nrE1l9PoehiVJDoqJBUlqBWb+yVBRNiQpWblqsJ6azaAp4pzabAre+PkO/mHOmZvETfwpXigSdiz/0B06G/z8jE7C76tPEpSEGRbmLAuadphQEB22KgaZ5GQmdbRByy4ajCCNEvegxkKa44499bZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597472; c=relaxed/simple;
	bh=cV00wOoir6Fqgzg9NqvpefOXWB6l5XlhFBP4gD2U58E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LeEteJyelke9Wcp4EeU9QQ6YeU2JMkcwrZXUZhZpAg457mWco1g+gh1kamC6vy1A+2UkOHWHJnaGCJvtcR89ry87HM+6l4hZJNCWN90kHNJhix2R5G9bs8j7pQj6N5bdpoFFoQWc0/3CwhdSayLde43KxNzVV/uxRk+nqluYHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCanKUVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCanKUVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951B51F000E9;
	Mon, 24 Aug 2026 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787597470;
	bh=md/bSH+bxdxaUjVhC1Vlg9S6HNsInOmb1k4KdEpVJws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jCanKUVZgdgH/1dIdUiZoSv4xqGi6LwfoQDIRbfElydSh3OZwcir19bEfWQFBUX75
	 6plflfuziUFpwR7pnNPpWQ5yBRPQRU0QjfUDa/sEI8shNPTwIK2K+Opk/jiGM4x/Sr
	 R6dWkRI039iuqZJmqjeGzRxFTzMMrD/Gr8XJU5FpUf5GuGZYzUCBy+1i1qwssPI78/
	 L8mqqQXy41y1N5TIK4M9RlZid8jrnOWCoRLytZWi+cnmjdixvlZbrhEnOM4xU1Sk/D
	 bNpHLibcMGs6h81jPZOFs+hBjyLOA35JysNvfjS6OANwrM4H6npSHu1RQdWCTspGN+
	 8aNipx11JFCqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688B3924A4C;
	Mon, 24 Aug 2026 18:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: restore skb->dev on
 deaggregated
 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759741799.3062482.15686763886179126811.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:50:17 +0000
References: <20260820195240.1631458-1-xmei5@asu.edu>
In-Reply-To: <20260820195240.1631458-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+4638111fe2a12980@bugs.sh

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 12:52:40 -0700 you wrote:
> rmnet_map_deaggregate() allocates each sub-frame with alloc_skb() and
> leaves skb->dev NULL. __rmnet_map_ingress_handler() assigns
> skb->dev = ep->egress_dev only on the data path, but a MAP command frame
> is dispatched to rmnet_map_command() before that, so rmnet_map_send_ack()
> runs netif_tx_lock(skb->dev) on a NULL device. An unprivileged user
> reaches this by unsharing a user+net namespace, creating an rmnet link
> over a tap device with INGRESS_DEAGGREGATION and INGRESS_MAP_COMMANDS,
> and writing an aggregated frame carrying a flow-control command to the
> tap fd.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: qualcomm: rmnet: restore skb->dev on deaggregated frames
    https://git.kernel.org/netdev/net/c/a66734a1c5e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


