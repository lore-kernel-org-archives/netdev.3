Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1A361959
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860265; cv=none; b=hcyhoDN8+tRU7UWz23QKvlADEIlP/oDSHlozDnbSz5QtELwnQJy82KPnT6/39BI6tpoilPOVd0b+ddffBu/Gw7Z8Fk66oHXl0Snf2lzEvDY9CDlijaiMJaeWg8RoHZ6Lazy5uk4i3HOfzVzoRxuz7GhdJatgpAfQMcFF10yMCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860265; c=relaxed/simple;
	bh=CgtU66YvDTa9KH7R2f+3royhBI7c4dKyoEv+ZbiLedg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YSxhK/hmUbpbBNOtxAs3+C5Drx2Tf2Dk7z1oBnEYUjvFHP+VlmaxCdgn2ONFD/2Rte1Ad39/TWOq6jgO7iYQsJizFuYfLRvF1mQz9KtkovsKZOlj0aJ73H46hRX/xVx66C/L6+3xNcXizYwATePXaC/JCsjDDYzgH9c1xBBg1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AamlyQGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AamlyQGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698B81F000E9;
	Thu, 27 Aug 2026 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787860262;
	bh=LBQh4Cu79a38YQZyOkdsQBjRGrxDfa9Mi80AfANhYD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AamlyQGElt5NHaVlSQoAk2QDtMIlVzdUwv40cBY0TCN4ox5LhuKALHZgmgcs9pLjz
	 s5u7+f+ad+hApjC0cqrtIsXvMhjrv4yWz5NIZgds5vmrpOdcHKJOh3nq4FPfsKGnuH
	 oUPDY4BaoAj1wqz+z5J1XGOMF9QM+/DrdWSykwLgXQb4GpMVn61d3ynY+NA+Iyn7c1
	 dzbFO7l0X2xiq6sP6roqvltMMgUxW4zGJI4/vgpjqj5ZXPkPDOu85yW2sh4tD7zHhW
	 Lcy9ssxYKDw+EhOjGYxZfQ9oDi+fllEFyboaLlMSiVcK9v+wE2W9/bGL0+n9svw49O
	 Pp/GD47tZ0WZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197FD3809A8D;
	Thu, 27 Aug 2026 19:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] slip: remove slip_hangup() to fix use-after-free in
 slip_receive_buf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178786020765.1820029.3720107144713374273.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:50:07 +0000
References: <20260826105238.3323436-1-edumazet@google.com>
In-Reply-To: <20260826105238.3323436-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jjy600901@snu.ac.kr,
 eulgyukim@snu.ac.kr, qingfang.deng@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 10:52:38 +0000 you wrote:
> Jaeyoung Chung and Eulgyu Kim reported a slab-use-after-free read
> in slip_receive_buf() when racing against tty hangup.
> 
> tty_ldisc_hangup() calls ld->ops->hangup() while holding only
> a read lock on tty->ldisc_sem (via tty_ldisc_ref()).
> Because slip_hangup() simply called slip_close(), it ran concurrently
> with reader functions such as slip_receive_buf().
> 
> [...]

Here is the summary with links:
  - [net] slip: remove slip_hangup() to fix use-after-free in slip_receive_buf()
    https://git.kernel.org/netdev/net/c/23c53269f2ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


