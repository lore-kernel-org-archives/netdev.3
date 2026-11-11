Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435150;
	b=boDgjV0gmHj9KrZq79KZU2Epd2YBFZl2DRupysxxLwD+IzG/YfDLNaYomkGTK+PCg8Pv
	 AOu9s9/Gk+tyJ+cf5Ro1di3IF+akMuy7nArtTslYVQ12v5wyFDUdDnkt5e4gzXFyECn7d
	 pLGRvTnRrcrc9DZDeZArFJ8jjKNyicvm0ouqoHefOtNJQA2w34towz0wwiMm4qTAHDmuN
	 veyjJQzCTulEbO4XAx587/X6W5Li4sa467sMonJEqFnvway2fxFCKHtZvNAjFLRcfD+Xi
	 GSjhw6gwrpnOX/+ehOJ84R+RGemNW9jMfopigThuGXCW45nDM6SRhbqztzmRhFdGAiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435150;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5dqRBuZU6Qt/Zkfok++rC6Pw4nq3oHXYANvYJ+YR+jo=;
	b=rnZf7IqpRUfD8YGI/S04muCmO4/KoMDcvy+BbTr50xX5w4IyVuOXBV+/VEmbdE+uEQKt
	 Z6BcRmxp0LhTF3tNojrTLx/2eIHI75Y8RMlmlu1YauQBwODbkt1pILVDZJKxO+Eru63V+
	 cmpKl4NyU3vqDRb4UMJKPYmXxV9QyLgRlbuVoafBjyOQ8MsjyZjQcK8js9tRhvR9CKHLb
	 U378RbO+Xvly6tCio3cJnEaeY1Cmow9s6A3HDH7lm96qy+V+IrMwxLE73F1g9sGHjAdQW
	 lPnqgUXSYrsho263tPUWfajJZir4t2qgu0husQ12y/lVxGVpWQVewBSDqJxpHDmuxeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klFErFli;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988EC606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klFErFli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A5A1F00A05;
	Wed, 11 Nov 2026 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435150;
	bh=5dqRBuZU6Qt/Zkfok++rC6Pw4nq3oHXYANvYJ+YR+jo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=klFErFli8SVL9kFqM1TdbY+4I/12S8XDisvdP0k5zgROhowZLYrPwOp8wo1C5BUbB
	 y059knjaz0shOCFOp32DZb6xgX7/psiRVffRIyKjMKZWEEeBmKRRkGmLuQIBalXISW
	 i6J8wyaRJrYFey92CJHLxCycbMcXxvDBN+zZQ8BOn1/T8h+IogXOZalY489uhl1vV3
	 lNI0mDqYsa6c15ds1QUstgUKcSWwCLRcXkWLHVkIy++FrETWxijxNMTeA99DGKBhRl
	 PZ+9/d4MyQH4Fhy6/25yMyRSXQcPYLDOlv2n3YMkmYzPzZ3DZ45m7ItaUchFKcvxZ6
	 Wo/cHyt5V599g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210E6391AFAA;
	Wed, 11 Nov 2026 22:12:30 +0000 (UTC)
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
Subject: Re: [PATCH v1 net 0/3] tcp: Small fixes for DEFER_CONNECT.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443514867.1670291.15738666309965531796.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 22:12:28 +0000
References: <20261107235720.3129212-1-kuniyu@google.com>
In-Reply-To: <20261107235720.3129212-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ycheng@google.com, weiwan@google.com,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Nov 2026 23:56:07 +0000 you wrote:
> Chris Mason reported a bug that TFO client socket can accept
> segments even before it sends SYN.
> 
> He provided a patch too, but it needed some adjustments (Patch 2).
> 
> Patch 1 is a prereq fix for Patch 2, and Patch 3 is packetdrill
> test for the reported bug.
> 
> [...]

Here is the summary with links:
  - [v1,net,1/3] tcp: Clear DEFER_CONNECT before tcp_connect() and in tcp_abort().
    https://git.kernel.org/netdev/net/c/93723db43e51
  - [v1,net,2/3] tcp: Drop any segments if DEFER_CONNECT is set.
    https://git.kernel.org/netdev/net/c/44809e491779
  - [v1,net,3/3] selftest: packetdrill: Add test for DEFER_CONNECT.
    https://git.kernel.org/netdev/net/c/e6f5a8d08005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


