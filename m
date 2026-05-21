Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207E365A0B;
	Thu, 21 May 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375009; cv=none; b=iqkw1Jw6PZCJRpaB72Jt4QjzXXTg3trCjNvl8GXLPya8jt7fL/zcQAgz+M0RgBCtMDyoXhu4gWBpuubfJ4i2pNq67Zn2T8fCkYQ9UnY2dqpT72oWmBEbEWk8Trq5dq4/Z+wkFzeLGNDR5TSdH7w1fCXgyaNL08A1JzwTB5v3mkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375009; c=relaxed/simple;
	bh=kr5DCfDLze2bL0bMq4RX8rk/tZWf0JchX0ei7zNmgtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Elop2lhyFi4t6av7BP2k9yNK2ymjCg1fpPEH03S695D7LJ793M8IviFGhf0n6Rg7pPTiJ/DVsObUhuNH/aRLSicYityq+ETWXavbxGHJqp8CrGZiw2Ly0xeWS4eYT3jWKeDZxlOlv/tcsyD/d2wHjfxqkfOI+tW5DZVysyzIkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oII1NBAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oII1NBAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92061F000E9;
	Thu, 21 May 2026 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375007;
	bh=3YfRdDSvMV6JRnlKEL6wB1iZXSalX1399J5l7yHyJ3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oII1NBAuoDXfGG5kMu6uesLvs3gxeEtQKu8nFHOVu+O5EHnygAzyPZeO5o2r6B1cL
	 EkBAT3tZnrykUpi2zBl1dt/9hByBD15S1QkCKP01EtBP1KFXBJjjv+vBzZaRM/moxO
	 qges17ZOSvGtzZ5klb6zwL0fXIYzsykFuOmrsvoJD6OeHQxz+l2QfJPBlGdQQwLoeq
	 AUMfiS5lzMj2Ln0gnzeG2Bb8LwdwgWKq02ZDx6Di1B7kYz6FB4BRiVReMoti8EOQUv
	 rTgqXrl8INqVGprqJtoheiSjPQ+qysorIWkQ9CFj0HQqw5QACGxfh4AErPIz2ARrPn
	 t1h4KNMg0hUNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6D3930DF1;
	Thu, 21 May 2026 14:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] phonet/pep: disable BH around forwarded
 sk_receive_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937501739.361786.17790917589741494228.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 14:50:17 +0000
References: <20260519172635.86304-1-yzjaurora@gmail.com>
In-Reply-To: <20260519172635.86304-1-yzjaurora@gmail.com>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 10:26:33 -0700 you wrote:
> The networking receive path is usually run from softirq context, but
> protocols that take the socket lock may have packets stored in the
> backlog and processed later from process context. In that case
> release_sock() -> __release_sock() drops the slock with spin_unlock_bh()
> and then calls sk->sk_backlog_rcv() with bottom halves enabled.
> 
> Typical sk_backlog_rcv handlers process the socket whose backlog is
> being drained, so the BH state at entry is irrelevant for the slocks
> they touch. pep_do_rcv() is different: when the inbound skb targets an
> existing PEP pipe, it forwards the skb to a different *child* socket
> via sk_receive_skb(). That helper takes the child slock with
> bh_lock_sock_nested(), which is just spin_lock_nested() and assumes BH
> is already off. The same child slock therefore ends up acquired with
> BH on (process path) and with BH off (softirq path):
> 
> [...]

Here is the summary with links:
  - [net] phonet/pep: disable BH around forwarded sk_receive_skb()
    https://git.kernel.org/netdev/net/c/dbc81608e3a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


