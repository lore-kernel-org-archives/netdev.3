Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5E3655DE;
	Thu, 21 May 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376808; cv=none; b=YITx3xCktGMyQ4KbfkkXQjqGFXy4X2mGJfrwYJv57Z1bvgmOMyIqmC+l5ZhEFKJOiS0w4wMOHjTg4eWlIFXoGLbPW+2XZV67iYACvo3Yfls9UBwXAdDUS/uQrOIlMPcBUJnUAY1g4dmNj0ASFXtj15phwLxaaCrvgfYGxRCGZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376808; c=relaxed/simple;
	bh=bqU9EqRV3i/z6sRrSSquLAm2Ik6ZbsYFT3RXrU9MLek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hWGWBRPx3b9L2F3HFCYwPs5D01kUKKFrXekVJAIjc8M8Qd5sBZilsyCWPdhcAYio7pIO40omo8l+sO2/yqGZEke0MB8fixW+0ZJdMyOXussGOIg9EY523YD3GqbvPK07YjpAAliCnYSlQ/ATdHMAwrVJ9F8bhZOzAB48lLUYxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG4gBaBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG4gBaBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF661F000E9;
	Thu, 21 May 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376807;
	bh=SKo9r9PebuvL3KqDY4GRt6Bk/DANWagDYqYzlWhxVIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EG4gBaBpyHv77i1lW4OQGrdfQZf2eh1Mm3WwnCtAembe11B2eT449U/wO9Rf5Rvlj
	 uU6VZ5DBE0t9f6mHy+6QIxnF1rhGZvfT8R2PcW9YR46Zu7fwJgZ161HHctg3ge/4Nd
	 Na/b/S/CFKUYIgES7WWRO28rz7ZkhJl6dU1TFqo7wtnP+gOeRhN0PkeyKdVOCrCoAp
	 Eo+ulWYklo46IlO+sKIXF5pU1nVTLmA2fCuH5iikXcMuy3N5qP4dSwY1YPC7LXxA3M
	 P9TRA4K1EEER9Ul3hKW/fzapuu4gbynV17V6AopuMfKrClHzecH1sSIPvUjFHRh7Lp
	 WalnrsVtXBCKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A413930E00;
	Thu, 21 May 2026 15:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] netpoll: normalize skb->dev to the netpoll device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937681714.379332.13205890047616049295.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:20:17 +0000
References: <20260519104647.3517990-1-rollkingzzc@gmail.com>
In-Reply-To: <20260519104647.3517990-1-rollkingzzc@gmail.com>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 18:46:47 +0800 you wrote:
> __netpoll_send_skb() always transmits through np->dev and queues busy
> packets on np->dev->npinfo->txq, but it leaves skb->dev unchanged.
> Stacked callers such as DSA and macvlan can reach netpoll with skb->dev
> still naming the upper device while np->dev is the lower device that
> owns the netpoll state.
> 
> If the skb has to be deferred, queue_process() later dequeues it from
> the lower device's txq but retries it through skb->dev. That can
> re-enter the upper ndo_start_xmit path on an already transformed skb,
> and if the upper device disappears before the lower txq drains the
> workqueue can dereference a stale skb->dev pointer.
> 
> [...]

Here is the summary with links:
  - [v2] netpoll: normalize skb->dev to the netpoll device
    https://git.kernel.org/netdev/net/c/c367b9082194

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


