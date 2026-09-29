Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327453BB131
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649607; cv=none; b=odtT3kZtVlk4J5g14qQjm95ZOr0Xj7FT9runhHY9e7kC4pdU3xXQKISasYIllpQPm0ddYRAFojFVyqhF9nyGC1nKZqlC7oQ+gnztXgmzF4xtM4kbR8qIRFenKg5WW4rYRmUp7GRpE2jkhWGYaekSvcQTRSN9lSG/Uu8sLRThaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649607; c=relaxed/simple;
	bh=1AO8chNg4wSbz6M2VhOM77smtnlIaZ8e+/sCnhg1i08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F0Kz50SRkuwc0GeNXWMLDzywjeOXfQQiIgBKkwjl5wMpaVmuSyMpoxsxdfCb8F1VI9tc0KHbxVIVVIP+fohOa59d01LoIJF3CaCrdPJFokAkknIi25nLrSAg1x68Z/p4zIKoncvskXo5Yw5+Z+2pNbkQYfCBYv4G1XtPI4jzpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWG6Zi4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWG6Zi4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F0F1F000FF;
	Tue, 29 Sep 2026 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649605;
	bh=dN4nrRUHpbQaAiNSOmFjCBAnGbZlDxzzsXNmhNEnKas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jWG6Zi4qx0eK2zHASRAnTrLCSzbLFC6UurjWVHMc9duMqr1OWJySUXQC9t/zUlgxQ
	 bLkiETsir3OtgIGPIl/jSb6ajI/8UBcKQ1DuJYelRadWZvGMzUAkiL+MY7wPs1hgwg
	 f/MXRB+lHLl9pdaMUJMJ/ePtT98aKT9ZzRSsmRZH1/rb5kINPx7qjWob4T6ddfvtLy
	 CyCaeRnEIkDY2KXcRXAhPmM2l7NGCWhDjt/aS9TO6e1HdLq2o5x9EBxh0cHmhEEf5i
	 2I6TfweESLIlgEqSEhHSPBee3lrt1K1S1hbXu/F+aUxHECW3C6VlpumPF/HGNH1k9O
	 2uADyXJdTb9dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45FF3924FF2;
	Tue, 29 Sep 2026 02:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: fix SO_RESERVE_MEM socket type
 restriction
 and value bounds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064960453.229594.15099300870054423023.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 02:40:04 +0000
References: <20260925135244.3715196-1-edumazet@google.com>
In-Reply-To: <20260925135244.3715196-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 weiwan@google.com, horms@kernel.org, caixinchen1@huawei.com,
 netdev@vger.kernel.org, edumazet@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 13:52:42 +0000 you wrote:
> This series fixes two issues with SO_RESERVE_MEM and adds a kselftest suite:
> 
> - Patch 1 restricts sock_reserve_memory() to TCP sockets (sk_is_tcp(sk))
>   instead of sk_has_account(sk), and caps the requested reservation to
>   SZ_1G in sk_setsockopt(SO_RESERVE_MEM).
> 
>   Currently, sk_has_account(sk) allows SO_RESERVE_MEM on UDP sockets,
>   where sk->sk_forward_alloc is protected by sk->sk_receive_queue.lock
>   rather than the socket lock, and udp_rmem_release() does not account
>   for sk_unused_reserved_mem(sk). Concurrent UDP packet processing and
>   setsockopt(SO_RESERVE_MEM) corrupt sk_forward_alloc and memcg
>   accounting. In addition, values near INT_MAX overflow 32-bit signed
>   int in sk_mem_pages(delta) and (pages << PAGE_SHIFT).
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: restrict SO_RESERVE_MEM to TCP sockets and cap max value
    https://git.kernel.org/netdev/net/c/37e02c42a00b
  - [v2,net,2/2] selftests/net: add SO_RESERVE_MEM test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


