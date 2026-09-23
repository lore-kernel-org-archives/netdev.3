Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E2361DC1
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129483; cv=none; b=sQxEuCPPfeVNmoZt584li0pfIYSyBlGInsIJAeLCPV1YgK1tD8KTsHJkd/YOZjtvGAzHh9uwaFgIK8ErPmbTljyshJyf1IRPwA9ophSOUoXQE8pXyE+iADA8hky2QVSpXzNKoszq8gixRW0bNZgWcfY9rTRebuU8wNxsVqBc8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129483; c=relaxed/simple;
	bh=HX/nFYUwkMh1g7AsBRg3QpFH8vSJ3MB5jfuTfvC7Iv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fVas1tYUTp5MSW5WXD3HsXE2daXV7AdvCoYR/Kin7gBY1pzw8qjqLcIKhGSOrtfIZK3mEZxYqCgYVKeDYa5DqxqlJ1GnBiiDtl1nwT7moL4KukYvawbfKVkV4yq8jhlOVpE+oiPQZ9Z5xY+6FNPDZ+q2Wp78KnDETxMUP/o01YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAUaOxFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAUaOxFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7CE1F000FF;
	Wed, 23 Sep 2026 02:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129482;
	bh=mp1QAQxT66THAj/rXZ3FPN5EE3PFJ8uSSCeoUyqbud4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lAUaOxFGJmdk/7MMzNkDaYhB8kkRM74GzajOnEzZphioEUoJOlJIEXBzXPw0qrPtA
	 NANm521dutCpHJOJCp9glQmFlVhKoIuWKpRiV8hvydw4+XBMQG+QtJOvGWm3r271U8
	 19lHZwnIJsX/t+faysxPVlfnR9b67Jofti7h8/1e2PhGCoWYpCMm/cCCOQpej9wUK8
	 MGB1Q1IB6kjQGtjUVnS33VtJqfBTt1PlVkQ/qoAQZIcly5NK2UZPFSXZTcQ343EgAR
	 k/hulx86tR1hZXuhm0TKUWzqZ7uB6DBvMu9SpduMu6/sDEiCeYmjKL4ukTEUWuV/H4
	 koeLskPLhB0qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B9E3924472;
	Wed, 23 Sep 2026 02:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: remove dead code in tcp_rcv_state_process()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012941239.177114.8591343191777304229.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:10:12 +0000
References: <20260922010627.2291980-1-edumazet@google.com>
In-Reply-To: <20260922010627.2291980-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 01:06:27 +0000 you wrote:
> Since commit 3d501dd326fb ("tcp: do not accept ACK of bytes we never
> sent"), tcp_ack() bounds the acceptable old ACK window by
> min(tp->max_window, tp->bytes_acked).
> 
> When sk->sk_state == TCP_SYN_RECV, tp->bytes_acked is always 0, so
> any segment with before(ack, prior_snd_una) immediately returns
> -SKB_DROP_REASON_TCP_TOO_OLD_ACK and never reaches the old_ack label
> (which returns 0).
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: remove dead code in tcp_rcv_state_process()
    https://git.kernel.org/netdev/net-next/c/944ae66642b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


