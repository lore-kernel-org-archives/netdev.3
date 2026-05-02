Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66042C21E8
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777746063; cv=none; b=sATxtR4LwHZIkIhG6F/on00l2XzMgYO1Bs6AjQ/NUAArryy0jbtPLV7Z66L4Iim07sxKr4qF0eCMrWP7DTNviB2x+sdHGWI5FamjYMOaVsBVBMc1VGDB2c0IO00paq8CCqDaTOsTfjCfZ/2Bt4qu81FZVz5YPR1gwI/0pwIU5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777746063; c=relaxed/simple;
	bh=vmYZLYzlNJpz/yBVgtgxFm69xbnFtkUKtfURcF4UxRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Svrdogw3UR1k3ltIowb+TAdqOemAX+uTz4j333x/NQyVidg6KEpgbyOcjKj/t0uRNMF3BGWIi/cF17ZVdn6+y2rftbZ7bo53UvWvx3cGY/7w1S/svrzq2nyhsR12HOH/7GMxDf/0jxS+a/Vu8IkIrtkWcOQNzAFf2x/zEH07uIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGwfuNLe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGwfuNLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECD0C2BCB3;
	Sat,  2 May 2026 18:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777746062;
	bh=vmYZLYzlNJpz/yBVgtgxFm69xbnFtkUKtfURcF4UxRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LGwfuNLeYwcCaZKdaZn9WYvN07+sy930cT/ERuBjGJKhbN7QYnGwyQy3IgV94ZhOF
	 nUS06ZI8zNv4OUEYLPdgY//bZofcGIbkJurofb6b6hQU9MN4vZmZS8La9IVYzM3WHx
	 SpbvfaTYolor6ELoUNKFpDr6ce6KHlNrtfw3TKMDrwOwBAzwOgpYQICaG0D6Po4gp+
	 2hI9a1cWukmKpfkmQv2GQZTIINLNiuH2mNaEdeoqMhGPEN8VkMmLiVUdgkRiLAtE+q
	 Pxv3wiYhZilB3Nei3LU8a54N53SaJMPVHdY2tZZoXaRuY2CeRkO2Osuyk764LKN5K2
	 pSb+mqJVCLcpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D44380CEFF;
	Sat,  2 May 2026 18:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] Replace direct dequeue call with
 qdisc_dequeue_peeked
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774601480.3903048.13400905631672371303.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 18:20:14 +0000
References: <20260430152957.194015-1-jhs@mojatatu.com>
In-Reply-To: <20260430152957.194015-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, pctammela@mojatatu.com, ghandatmanas@gmail.com,
 rakshitawasthi17@gmail.com, security@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 11:29:54 -0400 you wrote:
> When sfb and red qdiscs have children (eg qfq qdisc) whose peek() callback is
> qdisc_peek_dequeued(), we could get a kernel panic. When the parent of such
> qdiscs (eg illustrated in patch #3 as tbf) wants to retrieve an skb from
> its child (red/sfb in this case), it will do the following:
>  1a. do a peek() - and when sensing there's an skb the child can offer, then
>      - the child in this case(red/sfb) calls its child's (qfq) peek.
>         qfq does the right thing and will return the gso_skb queue packet.
>         Note: if there wasnt a gso_skb entry then qfq will store it there.
>  1b. invoke a dequeue() on the child (red/sfb). And herein lies the problem.
>      - red/sfb will call the child's dequeue() which will essentially just
>        try to grab something of qfq's queue.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked
    https://git.kernel.org/netdev/net/c/458d5615272d
  - [net,2/3] net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked
    https://git.kernel.org/netdev/net/c/1b9bc71153b0
  - [net,3/3] selftests/tc-testing: Add tests that force red and sfb to dequeue from child's gso_skb
    https://git.kernel.org/netdev/net/c/3a3a30c14d7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


