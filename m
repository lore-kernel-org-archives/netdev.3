Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D543B83FC
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477274; cv=none; b=jYkGmDR2vwb3AbZ6HG0avhlcF1AZkJzxpblRlJ2uyV3NgH3nm+iUNMN9ObX4Ihi3rMOv174s4ftNniuTdsmw++k1aRonuRkAXGabYcA6ueXVqT+zdk64D+mtH1oTl63XZDLlRsNxhCKdxEUVoyFoJn+82MK7hwlnA9fcQBqUgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477274; c=relaxed/simple;
	bh=if1M6z/u/A2ScTi/uYkx9JHuYgEW8SweK2xkbcz1j8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ey7pPvHIU7C153ewnhuECF4tJxFqy9u6vbEXLNmnbOWPPTwa70hhssTvTVQCoK0lxG31JorwYMIg8MnlnAKW9Q+MuDwTDdQSYaMsLUeYNkqSJrvdnXt2tYs2E4mCLnpY6E1kvLKjUNLUkFvz06NgSs1xWsCoYvMcF8qDrZo3sD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjHDvE4I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjHDvE4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C1F1F000FF;
	Tue, 15 Sep 2026 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789477273;
	bh=2EEe0E8cI9tTxwJBmp1Y7lDL0YykHEKCtrU1an42H4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LjHDvE4ImpkTA8Sdz7l7d2AsS1tSNCkF0zey/O/t59Fkrb+nqxN0anYVkbWtMtFJe
	 nLKI/GnNgZuKRV60n9UUBBLfDccmW90Fu+iSFIIAeuIhN7xKTvJ6FSTjSoqhKrczoa
	 9R9lErzEIuufsXCLELn2MtVetY0jZN3J/XxKuOuHNa+WBTdFULxUIDSmkGkZApL6yb
	 2mLMpmm0CkmOXnBaCq93OKpPQWDVyct4cK8Q1qmOK0iNSfU/3YHCZI6pL+mwyLg9fG
	 O01ZHu7IeXD53uYQI2MQRkqV8t/PYGtmIo0qkEULJx5CzIrV0AgwQhF8LIeODCm1Qo
	 OxrKhw7JcXYXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196B539263A4;
	Tue, 15 Sep 2026 13:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: make smp_rmb() conditional in tcp_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178947720787.1607766.4672913101588270762.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 13:00:07 +0000
References: <20260913123224.762935-1-edumazet@google.com>
In-Reply-To: <20260913123224.762935-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 13 Sep 2026 12:32:24 +0000 you wrote:
> Commit a4d258036ed9 ("tcp: Fix race in tcp_poll") added smp_rmb() in
> tcp_poll() and smp_wmb() in tcp_reset() (now tcp_done_with_error())
> to ensure that if tcp_poll() observed socket closure, it would also
> observe sk->sk_err.
> 
> Currently, tcp_poll() unconditionally executes smp_rmb() at the end
> of every invocation, which on weakly-ordered architectures such as ARM64
> emits a memory barrier instruction (dmb ishld) on the poll fast path,
> even for healthy, active sockets.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: make smp_rmb() conditional in tcp_poll()
    https://git.kernel.org/netdev/net-next/c/e8c06b895281

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


