Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75532175A64;
	Sat, 17 Oct 2026 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198209; cv=none; b=U4izf6LTPUIoaCd6q30IYdC4zfYBG7JH7ANdr265Vy0WsKRFbjv8Hq57GNLQyCnL+OPKAZn1xHl2dXoulArN0mLGdgeqfKktsHQjmkvL1/yolbinQPnjn75RBcAIfRUbFGl0Fjyn/s6d1jdBq+VXyfi01ffY+8GUFnnMYqv+mzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198209; c=relaxed/simple;
	bh=cBGxI9GwyPBfgkvn72Jiw9RPW9ieUYmr7O3YsHjeNXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mytU4RbBCvUmhiPoSUbjpglqS4zvS++UcZ4+ojD6KELwWZZcYnVroVXDFpp5LwIGACVzuva2G7Wa4y6EuC6buyny74LvR8j12U1WaADEJNsjOQtlPCmRbxRk4HLcYiNsX3Wfe6IVOs6WC/FJyjJ6gtal9ilL2gKF5lsQPQaOZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRljon2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRljon2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085F01F000C4;
	Sat, 17 Oct 2026 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198208;
	bh=VjuJodhz/LDeBB60nl5r10/rgJgr0uY0JxzCSCnYe10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cRljon2/4YaaLmawa26m4hZiLF6jUZGdddr6x1MDPTTN50XqLk4B5QV4bNkScc0ny
	 527JMN+1l9PHy0ue6/XgaV/Sd0tlD+tRGag8RasWFg9vJTcseOt5KDmjDNCmT9oByZ
	 JdIfo7oQWMrVqW0TIJE2N885xhQYTFJVbGOQ9/cycMU6JfW2DoQA3d4tmI8DIr0P6j
	 ukCOrfhoBvVynxr/OgvbkSTs9kF8YXjV4HKVvF0dgPqPpWmx7lX+qv2HMfCQ66CSE3
	 V6JYy73vpkg5G6THHnbV8NSnGvMgha1K+h32Dsdr9x08ktakmlhOAdXZuiQIHg7RNc
	 vzbX/651Iwp1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F155C380CED8;
	Sat, 17 Oct 2026 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net: dsa: motorcomm: TC offload
 follow-ups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179219820677.1034269.9215112938628592927.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 00:50:06 +0000
References: <20261009165825.359259-1-mmyangfl@gmail.com>
In-Reply-To: <20261009165825.359259-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 00:58:18 +0800 you wrote:
> This series continues the traffic control work on the Motorcomm YT9215S
> DSA driver: it reorganizes the offload code and then adds ACL enablement
> on demand and flower priority mapping.
> 
> v3:
>   - rebase
>   - reword commit messages and comments
>   - fix cleanup path in acl_add()
> v2: https://lore.kernel.org/r/20261001204851.2576101-1-mmyangfl@gmail.com
>   - move type casting helper into chip.h
>   - remove flow statistics and broadcast/multicast policers
> v1: https://lore.kernel.org/r/20260926211813.935723-1-mmyangfl@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: dsa: motorcomm: Split TC module
    https://git.kernel.org/netdev/net-next/c/ba13bd277d22
  - [net-next,v3,2/4] net: dsa: motorcomm: Use NSEC_PER_SEC
    https://git.kernel.org/netdev/net-next/c/4a8e05d62ecc
  - [net-next,v3,3/4] net: dsa: motorcomm: Enable ACL on demand
    https://git.kernel.org/netdev/net-next/c/73db071a6692
  - [net-next,v3,4/4] net: dsa: motorcomm: Add TC prio support
    https://git.kernel.org/netdev/net-next/c/f9822b4ca6ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


