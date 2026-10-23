Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791010;
	b=Vcw497j8cz1YkDklOFQah86Wbv5Mj598DVXIjQ87DK5D3TaExfLWHr5X156+G/do/ZDV
	 MPJJ97tHZAzSAJl7ybtnK7my8Si3jXvN6QiR005S2N1p88eDqe5OO2YWUJQue0ceHfx6C
	 JGe3Ml8VMgGhezGMwIMVMju8OcpihV6JicNIGGgswWd8Q9+f44D3kiTlRPgkCLX26VzgU
	 Vsw2K+gNghioDwcIkEx72xWr6bpCGTt8w0IWqGJ+wFM1utzn0oVSixBC88vvHYPD4Yhdf
	 wGPSSuuxG+Z/FeWwU4p03/Z6jhhs+hUXkZBehh4egfwneDr6WMQro89y/1UeyHugdjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=DjlM6/UrYHg+dCLl5Cy7wR5C/08/JMqh+pVApowh4YM=;
	b=BAdKs3oJBzI3mysyWUWvwbLEphcsJwFo0t1ZUih6TLj4bhoDRhpIbkQwVOgu3oRybDY0
	 ge/saB7slXo2G107032ZLErxf1dpvEqtjMFT9+0EP+nbhp9vSPVtXHiJQpTHDMLheqopv
	 9H74RXU6SaoQIchlqRhT1r82YBl5AtqdXRQ/gPG0y7v4W2305CAYqINTezT5ciYMGiPga
	 6MOd4WThAj2ZSlMs6dWqmAK8G9kl1IM3AQbaLp7sI82cqj6wIRcOdApUKkU1MBxR+cpag
	 3uQfkABgVmlBpuyMK5lZvAjfTeR2qkjANbeAbAPaNRtSCg4tetawnKsLycBbeb2FR6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNcXhBaD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B710606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNcXhBaD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA931F01825;
	Fri, 23 Oct 2026 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792791010;
	bh=DjlM6/UrYHg+dCLl5Cy7wR5C/08/JMqh+pVApowh4YM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mNcXhBaDqCrVpOl31CJy0XRcv86WASzn/bI2J2ZOdjl/AbNO3Fw07z0A7wpFWz73M
	 dJhqvDcT6AmJogI7gGvc7PKdxVn/6LVlxnoB2juzRuG6AhB2RJMiY3GvEifyrDHbLa
	 0fsCQDyXPv0/FciWRPZ9zKBqYZt9yrW63Q1/2rJlRbT/CzEla+IbVbNnMFtas9of2G
	 3G4qiwo3teRVTM4Rg2X3FbSX2X/t/zfs3RL9UEDfBLu60JSnCiz7E6iwrrbHHk9JbE
	 Br5PmtOUCFwyoPQWhd7biZFqjKVzqPKAuMLb3bYZikwRoRosvKiwFAcONAQVsvHa//
	 CoyXNk8LU9ykA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 07303391B157;
	Fri, 23 Oct 2026 21:30:10 +0000 (UTC)
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
Subject: Re: [PATCH net] net: fix frag_list leak in skb_segment_list() error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179279100856.1280672.18020190075774323559.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:30:08 +0000
References: <20261021161858.761205-1-edumazet@kernel.org>
In-Reply-To: <20261021161858.761205-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 spolack+git@mailbox.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 18:18:58 +0200 you wrote:
> skb_segment_list() detaches the frag_list from the head skb and moves
> its members one by one to the skb->next chain. On error, err_linearize
> frees that chain with kfree_skb_list(skb->next), relying on the members
> not yet processed to still be linked after the current one.
> 
> This does not hold when the current member was shared: it is replaced
> by skb_clone(), and __skb_clone() clears ->next. If __skb_linearize()
> then fails on that clone, the remaining members are no longer reachable
> from skb->next nor from skb_shinfo(skb)->frag_list, and they leak.
> 
> [...]

Here is the summary with links:
  - [net] net: fix frag_list leak in skb_segment_list() error path
    https://git.kernel.org/netdev/net/c/546daf344420

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


