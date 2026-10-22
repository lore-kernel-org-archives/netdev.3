Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792630208;
	b=OR3Il8Bw0o+MHkXb+IaGpUzpLRkcAASWnCvI/LimJfeeCa2/C1gUnV4GvKJjUmND0+FK
	 OFL6PDYyFG1NXfbBE24diYRwl2h3cuUTUNB5FwmmWuvxH52UITd6tXjL0zmY8eap/t4vk
	 1Gz5zQdyM2iBSe6CWsG8u3H1V2jNB0sOmxuhfcp75mTYBFj69nTm8lCPg/pX5ZZEN7qbC
	 L7rWz+TRqF2/la9SQDlxYDHdbqFxNQvZAQW7Bl2lNgp9KFravA4OMBpuSLnYBCpqZsuw1
	 xEvN7bJuHk2Cm6/xl6gq8d9w3HEgOPhhY/Ka7zjlXZ12SSPLnYYWESVmXIOrj1A07kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792630208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=8Q8KgXaHFy0aDDPTNMLkRTbaKKT0iVWcByQhHqS794o=;
	b=scZmZ6wfbfqYvw4k52r41aTND8IFPVMUYPEB7jFzpH6K133qQOYQbiOv/5P1IN1YJyNR
	 CpnBfbem0WuvKDqLjGTYdxuus+BLIFeUWJgqAcQ8727xXJX4Mksb7Cg0iCI4OGwNtWTn8
	 1BqjIfpbfir9Phrosg4smSemC0PnNsI0dL6sMjaw+tZiPomN4UuNfNqVgoqoraUePF5ja
	 BRLiRZdM4qpFo9idK/jLKeQoazGH+RMMnBtB9Jju5CDLGeA0WYD0avQ0a0nM9uC8eZWBQ
	 RXiCZfiyLQxahSOOsnXEDb+az5Jla0Dd+AmdGNzgOrKjJDmxBM5jOCqtlJV9BP8fxcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1O5qM56;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3A606A327
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1O5qM56
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4031F000C1;
	Thu, 22 Oct 2026 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792630207;
	bh=8Q8KgXaHFy0aDDPTNMLkRTbaKKT0iVWcByQhHqS794o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A1O5qM56qT88BaFVmkCvw97/Mx0lyQg/KzqxxqAoN2BNPAYuhnK+WzLXwm8AgZHb6
	 VlyREr+66DD42jev+n1yMNroQ3v8HMKzfNID04SFr9IKWvheOmvKZu+Ne7jrboByH3
	 2x1IDS4ZajF6AuBzUJK4FH1qNFv6TU9oY5cxBI0AcPI1mjns2xDW4LtVrj/uJ/GoQJ
	 +GG7wkqbw2N5wuKsTLZhhnI75dq7WlL7WOaHqFc+244+s6WrT6zKyob0xOtxuGzHg/
	 VbTynkZjOtSRBPwQ2Cql3jZqGc4AvUz2wFOL0heBh3nDXGhoulS5Hqi4SxhAYG0gFL
	 6IzeYjMcMcuXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4337380A963;
	Thu, 22 Oct 2026 00:50:07 +0000 (UTC)
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
Subject: Re: [PATCH net] net: shrink the payload-only part of skb dataref to
 one
 bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179263020632.1386998.2635338271651886674.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:50:06 +0000
References: <20261020151954.22953-1-edumazet@kernel.org>
In-Reply-To: <20261020151954.22953-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, Stephan@adalogics.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 17:19:54 +0200 you wrote:
> skb_shinfo(skb)->dataref is split in two 16-bit halves: the lower
> one counts all references, the upper one the payload-only (nohdr)
> references.
> 
> __skb_clone() increments dataref without bound, and skb_cloned()
> only checks the low 16 bits. With 65,537 references the low half
> reads 1, the head looks private, and pskb_expand_head() (or
> skb_unclone(), skb_cow(), ...) frees it while clones still point
> to it.
> 
> [...]

Here is the summary with links:
  - [net] net: shrink the payload-only part of skb dataref to one bit
    https://git.kernel.org/netdev/net/c/4957ea03bf26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


