Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D68952BE54
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689209; cv=none; b=nVaZcsSXmYuUfVIQ0ubfZzG5JoMq8tY4GlYyFGyLOlIMT2kI5Zdbi0PufznhyP2FxbXQWxICJsawvfBBQC8H0blAW6Zx/I+sTDR12NB3X017dFxX70UAl+rP28ZjW568AvgqYr3I4ShZu++CcFSRJu9q3fd9Vh8LOALmfIz5ddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689209; c=relaxed/simple;
	bh=hYfXKFCQbjVMq5fpJ2a/xfIJJaXDQ/94o+7bBw5OuKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I18Gmzv6pIn6ONkkgHSjTqw08uqhBF7z8gUZfMlGM9+ab64nb/hB0R6d7noCmWNgbDVLo49vJIUR8q/3fRB8Kd1VFY8VycChyReufyQ+XCj3WvRpllA9yIgW15kWpkS8eVtI9UB490/x+H7gIEkZ2s/nb5uEK5I6bO+hl4jySlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doWeGis/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doWeGis/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1B61F000FF;
	Tue, 29 Sep 2026 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790689207;
	bh=sSPfOCZN5ZiQVOqMBr4jaUsYmoEXWw1qjt/mjaU6Qe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=doWeGis/2sGRBLyMh+86MX5nCrI5xFxj7DGTObh6Uvifa48ZN9SPWLSYzscCZ5RLq
	 uE6HYzTirqEkH4zDwdkMaofLNtJSHLloDzbrjh1qfVFKnMV8EXC4C0QTZq+BN17r2X
	 qPlQL1ID8dtXMi+oLhdJujTJydZJ8rart4wul1E/qbBwlFPMvp6ENtkvRHnUj8SMJa
	 zcBOBtXENdFBHCqsNoNw+NUAVhoFXM4yf0KDYGLqRR6b23MiFIgcSxpmNuRjezuXxL
	 8MZL2FisHzE+ERin1//GK1i6+5PpFf5Au0aTo1DC3+WjaIkbrl8JhV7uBngU54I+Yg
	 Fu+q6YjLpaCSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44583926662;
	Tue, 29 Sep 2026 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: downgrade BUG_ON EIOCBQUEUED in
 sock_sendmsg_nosec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179068920628.499886.774355714944793924.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 13:40:06 +0000
References: <20260928020420.3097018-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260928020420.3097018-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, ilkka.lappetelainen@gmail.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 27 Sep 2026 22:03:29 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> sock_sendmsg_nosec() runs in syscall context but calls BUG_ON() if
> proto_ops->sendmsg() returns -EIOCBQUEUED. Crashing the kernel on an
> unexpected return value is dangerous for production workloads.
> 
> This risk is real: any signed integer overflow in a sendmsg handler
> that returns 0xfffffdef (-529, -EIOCBQUEUED) triggers this BUG_ON. In
> one month, two such bugs were reported in PF_PACKET, reachable by
> a local user with CAP_NET_RAW in a user namespace:
> - Commit 73e594c19b4f ("af_packet: Don't cast tpacket_hdr.tp_len to int
>   in tpacket_parse_header().")
> - In review ("net/packet: prevent TX_RING byte count overflow")
>   https://lore.kernel.org/netdev/20260925124829.6595-1-ilkka.lappetelainen@gmail.com/
> 
> [...]

Here is the summary with links:
  - [net-next] net: downgrade BUG_ON EIOCBQUEUED in sock_sendmsg_nosec
    https://git.kernel.org/netdev/net-next/c/ee1972def665

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


