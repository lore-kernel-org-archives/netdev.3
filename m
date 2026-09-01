Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0F386578
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258665; cv=none; b=HXx+wrFBm14GVvd+HeiC795sEaSrDAVT8SP1vlw5RuCJ5DZuKGOiMjOdccdhEyUJIpeo+1mTZNPuq+fEvPfz3UEo0EQtkxpzlKtKvwOReXOSFprCBQN6zB+uGvAH4J3sez5Jn01StPyeuy6jca0S+Oco5EEk5/3Lx4NDjhcJTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258665; c=relaxed/simple;
	bh=FIDZCQZqPstbert5JEwTyyVxaAUMf+vExOi044EkCSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lh0kNc/qGGGezNXnw8aPTYCy/uCGreykO52Ilqr/CBsn8g+HTmlNwj4Mafs2TzC73WruxruKEbmH3hrL0N7ekD5XmbvtZj8aPym+eKvJn/oFvbeGN+RWgJWrH+4GoSp2bMPYdBYW7PW1jIbCm6SRNSkg2NH9dZzq4uWq9HGwhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwvM6iaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwvM6iaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08101F000E9;
	Tue,  1 Sep 2026 10:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788258663;
	bh=FtICOGMFGMjUWSgJERxPs4Opq0nyQwlMmjeEsvDZw9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gwvM6iaOZAEB0ArbVkHonSWmeKV7Lm59M5+4wIWKosmqf6ZtszpZ9w3adw8riZn50
	 qVHR/jgzvTrPdKVIekGfSLFd87dSWHBxa3HjeIBkmwF5mDHxpa5Fk+IxHvS+bBSAy2
	 d6yqy/4c8FZTHPNQ+mF7VjpBUgAebPrw4XHI6Ye5Z+dQHnXQdExCmm/gzTmMQ/zixX
	 kF7o2G/mpI6OqIaYIUi2H1Mqh2a5zo3/LBl29PSuql3vqUSianszN9rJAORGTHslO1
	 DxojAxpL/V0DDvaWHBeLN8zEKC8cAUAZQLQc8cw6YtJanGD0VWgHwKBET27c5+A7oJ
	 MTVYyCneMuncQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B83924FD7;
	Tue,  1 Sep 2026 10:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bonding: annotate lockless writes with
 WRITE_ONCE()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178825860615.1093519.10366311649733929037.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 10:30:06 +0000
References: <20260831081027.3209554-1-edumazet@google.com>
In-Reply-To: <20260831081027.3209554-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 jv@jvosburgh.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 31 Aug 2026 08:10:27 +0000 you wrote:
> Several fields in bonding are read locklessly using READ_ONCE()
> (or ACCESS_ONCE() previously) but have corresponding writes that
> do not use WRITE_ONCE().
> 
> Add WRITE_ONCE() annotations to:
> - bond->send_peer_notif decrements in bond_peer_notify_may_events()
>   and reset in bond_close().
> - bond->slave_cnt increments and decrements in bond_enslave() and
>   __bond_release_one().
> - bond->recv_probe updates in bond_open(), bond_option_arp_interval_set()
>   and rlb_initialize().
> - slaves->count decrement in bond_skip_slave().
> 
> [...]

Here is the summary with links:
  - [net] net: bonding: annotate lockless writes with WRITE_ONCE()
    https://git.kernel.org/netdev/net/c/bc93419130bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


