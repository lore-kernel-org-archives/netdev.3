Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE14078FB
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232276; cv=none; b=BhUkzRLUQmln2rlW3ywzG3JR0c0vGjAEn+tDdRjWYBIup5a4+f239si5HUJYfT8awkcD5sV8Ocn1P+YN/EjkUbiU/X38S2CgLUWZuFvK0u8HfZrvRtDabqxsWaT3Q3VVn6xzqn6gAXkzurdROxlq5ZYOPwYh3SN4gPDJO129bF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232276; c=relaxed/simple;
	bh=HRYfZc1Wvv1MsQkU/siN5dPv9ctvyBZAeu6dOJNgELk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jWVx1qvJN+5DCyZ39cf9VamcfGY0a5cL0XzivU6ZKqO8CSm0V+uKBlQL5dk9iRjPVH7GwjwgcjZZm/7o9PoXUu9jM+helvQq5udP6lfTbeh4nL8nZ2dydqAyQBXGoWVMvgMBHFm62zi7QxdiRf7Tf/A9fqHF1MpbijUL5Xe6eIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2VR9Pac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2VR9Pac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991251F00A3E;
	Tue,  1 Sep 2026 03:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232274;
	bh=EJLFJHq7MSmDiqFkw+aCBJE9sT6wofwCY4yZB7gvUxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e2VR9PacfQ8R13hgyColq5DXByINjt/1cYEiFNfBMRl3zo10UTxFGMErDWB4JpOp4
	 r2dfqKuS5tFEHmC8Ev6HkkAWWNEEfxI5zuFLBxH7Y3Tn7zpcSoMbUHpN/WP8S+mHYF
	 H14a071kfZEzwltgIsNTwTr4e7D8sFDiNhZ+xjdb5+y4cuVuwmj34lCx78nVzmoaLO
	 cDaW1w6voiUVEKdYKe80S21ATijsNbP8q1rRFaAoq+APIRLzm7B0kMk4ivwHgo2P5R
	 rZhT+VRfHn90bMKX3N7iKC6bq7pBuJgC35uOoTLUKmAIm6mXJl84SobHiDizhjY6ll
	 3bxzI0yV+LvJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A69463924A51;
	Tue,  1 Sep 2026 03:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] Mitigate a side channel in routing exception
 caches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178823221738.912076.12244805765246266662.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 03:10:17 +0000
References: <20260828192344.2596928-1-idosch@nvidia.com>
In-Reply-To: <20260828192344.2596928-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, aksecurity@gmail.com,
 noam.caspi@mail.huji.ac.il

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 22:23:40 +0300 you wrote:
> When an ICMP error that quotes a UDP packet is locally delivered, the
> kernel only creates a routing exception if the quoted packet matches a
> socket. This allows an off-path attacker to conduct a side-channel
> attack on the routing exception caches in order to discover the
> ephemeral ports used by connected UDP sockets.
> 
> Previous mitigations tried to make it harder for attackers to find hash
> collisions in these caches and make the eviction of exceptions less
> predictable. Amit Klein and Noam Caspi demonstrated that both of these
> mitigations can be bypassed.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] ipv6: Fix redirect exception creation for UDP/RAW sockets
    https://git.kernel.org/netdev/net/c/cd51b74bdd0b
  - [net,v2,2/4] ipv4: udp: Create exceptions before socket matching
    https://git.kernel.org/netdev/net/c/4c3499f79f8c
  - [net,v2,3/4] ipv6: udp: Create exceptions before socket matching
    https://git.kernel.org/netdev/net/c/ac76cab50e89
  - [net,v2,4/4] selftests: net: Add exception cache tests
    https://git.kernel.org/netdev/net/c/c923c14942b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


