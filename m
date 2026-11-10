Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354010;
	b=NlPKuC/6fcmXjL2omksslQxhDdVsatBWWPU25nyDiLJmjLFFENUX+R3w0/c0ibz6PbGk
	 DW1X4cUuKzT+s+4g60OjvPiHugUuXuqBeOcVAAHhYiI/qn0iMdH0mYm2vpf4NWb2EIqIC
	 Ek3mMPScrr84WHmLmQnAg10wi8LTOoyIVDf+rU+QzSnORmlB2trRYqxOh3kiI1WvwANUg
	 0QODabmqwBJ5NosJ5hJdk2MbCaTybxzwdo2aQSh2iauw+W6II3CthVQwcJbTx4aA6tlOf
	 oya6TKkylECRcs/D2uF8SnHFuOSmtkDpAWj4tcsaR3zBQOpJbtac39AF6cFYNZ48HVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=UJ+dnp7W7LhPBMepHIiLdFwBGR+4qgPkW4P8pMHJ6BQ=;
	b=Gb79LrisMTkfTzQ9jRYYq4oUbCc6NR7GfC/6PJtfV1UnlLD9izd3Ib6IG189ZfuU3NJl
	 z5fnNlUKLT6Zfc/jFt8ZipTnhTIMYmYm/SV1JmCUArsK7UBnXYpMQMHpQf+1pfbjqvWcH
	 cryQfMewC4Ak7mwGTPhlzK7SpBHsmefxRzkGdb1RH4yrraaz/F17bNxdintCD6uPoUPO0
	 o4erTrku1cbCx8QIHroSv21JEKRAXif3uh4TY7rYWmv9olw6NmU4DXwFOprU+uZYvzpu9
	 sXjesbxB6i5zqLatH4NCxh8NJsvl26pL8XZxessIPatOnoh6dTb+GSl6QffVi0vLQWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQNqrpfi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FF606A331
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQNqrpfi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688481F0093C;
	Tue, 10 Nov 2026 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354010;
	bh=UJ+dnp7W7LhPBMepHIiLdFwBGR+4qgPkW4P8pMHJ6BQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fQNqrpfiz1FuHIXh5gJ7sqHKIh5hx2wSFdteI3WuXImf81l9bdW81/BsriOyCt2Am
	 WLSuIAiidKD+4XlBVpU4Boh1yJ5rYA9c19hNSiN6Q32/kjv8PScL/QdxRUiWz3WUMn
	 vwV6RCdKmgUa5OwM23gSx8omEORPUPiJfRU3U0kTx+R3mtRJgpS5tkFMCd4yVxi6pi
	 JjrMXuV2GDp39wWJAFWI8fRtIshUgTokvYyxqwcic5x/e2ghmlh+51+RFQkIuRPuJY
	 DFCxl5vuD+6rj9XSzvRb/TUfBQpAs2J6JDPx33kGHK/7iYJw39/BinLmCaKal+Y2P9
	 VbwGhAYnaASNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E01E39E8A41;
	Tue, 10 Nov 2026 23:40:10 +0000 (UTC)
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
Subject: Re: [PATCH v1 net] net: Fix memory_allocated leak in
 __sk_mem_raise_allocated().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435400892.117523.14002426849545083444.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 23:40:08 +0000
References: <20261105212905.3122712-1-kuniyu@google.com>
In-Reply-To: <20261105212905.3122712-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 21:29:00 +0000 you wrote:
> __sk_mem_raise_allocated() calls sk_memory_allocated_add() and
> reuses the return value to check if it was called.
> 
> However, sk_memory_allocated_{add,sub}() cache a value in per-cpu
> counter, sk->sk_prot->per_cpu_fw_alloc, up to sysctl_mem_pcpu_rsv
> before reflecting it to sk->sk_prot->memory_allocated.
> 
> [...]

Here is the summary with links:
  - [v1,net] net: Fix memory_allocated leak in __sk_mem_raise_allocated().
    https://git.kernel.org/netdev/net/c/8012eec76b7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


