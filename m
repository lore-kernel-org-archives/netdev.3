Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29803803CF
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816408; cv=none; b=H56jMWlJEu77PjsGXzsqHPeZcYqxHYh+Q92KmcMPx0cwU2tKiqgAQaaZZ3ETG72NnLR3sUDSfurx45RVa4/tvc6Gg7iCtK4YWI2pFScWamIOPKFa2OfeJsWFSgbGONWwnoZAhPRjjf22en5GKF6aw145ieV5pK6mOakTdiRHB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816408; c=relaxed/simple;
	bh=FkkCQWSZdixRL3p3Vi+5w2Wuq1GgF6ARZW6cedgxH7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebDkd3N6l6LnlG8M+aWc8xJGS9Zb7F6++lw9ExDoWe8e1lEx/4ZjOI4uHzKxgLuX5LxHZc3n408XXTx6siQgga0EdNp8jjiIVDSurvJfTI6TL/98kYdHk+c/JKeuxYJPZySAf1uA/2AjZT5Klw6CBDiKWu1FJwwA+iIzr/wdJ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URdNYC8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URdNYC8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C6E1F000FF;
	Thu,  1 Oct 2026 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816407;
	bh=GL/C1g3x3rRofqSvZ0gTEFIayCe6ZlEj8kyXI8jbZqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=URdNYC8tdKwO2S2zs9WuS6gbN1vbFcse7m/saQ52UThMd2VMrrX3kIlk3QdYo8KMV
	 pq8u34tymyrZ+RSnQXmqxJfmgKuPjsOOeeFPoV64WwNqMvFA2428xL2xDk7UGU1Wdi
	 6UC7iETqHPromsZx43AdtAAHJ5JqtqYXTnf1BVbFwE+agA603x7pBFhR64ylR/WViI
	 LTv/EOC5z3jgXYTzmVmeJjYA+Xzl3GsM4PzdZPgb6dmkEfLZC2sMWYZzxAxrHHTnl1
	 kWLa9IPmMPJkoAfYRLdAUw6JCsZgZNL472pljet8aQ1wmbTERZrXY/j93bi1QMe8Fe
	 xzQQ+YrRxOTLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2693AA6A61;
	Thu,  1 Oct 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: sr: use skb_get_hash_net() in
 seg6_make_flowlabel()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081640578.2197065.2659635598372933261.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 01:00:05 +0000
References: <20260928194524.3617299-1-edumazet@kernel.org>
In-Reply-To: <20260928194524.3617299-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 edumazet@google.com, syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 19:45:24 +0000 you wrote:
> Since commit d58e468b1112 ("flow_dissector: implements flow dissector
> BPF hook") __skb_flow_dissect() needs a net pointer, either from
> skb->dev, skb->sk, or since commit 3cbf4ffba5ee ("net: plumb network
> namespace into __skb_flow_dissect") a caller provided pointer.
> 
> syzbot was able to reach seg6_make_flowlabel() with an skb having
> neither skb->dev nor skb->sk set: a TIPC UDP bearer sends a discovery
> message through an IPv4 route using seg6 encap, while
> net.ipv6.seg6_flowlabel is set to 1.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()
    https://git.kernel.org/netdev/net/c/8ec454dcd00c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


