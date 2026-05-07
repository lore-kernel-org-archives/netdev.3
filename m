Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695551A681E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778115064; cv=none; b=iFA3TD7HkYIkpWL95R4nZgOs0LeopCnBB/y0vWFF4GlxOixkwp/C61RihC6IAJIwiGp3BtJSK3Q2ssho09DOOW2xsYpAWHCKd1Iat4vIWOklWCER8zZg75bh73/1rB0EKX2ILe9qaE11UH6ut3ruceSEgMxkIoP2XAYNoKfWtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778115064; c=relaxed/simple;
	bh=Xo43drVsLS4+XOyNDFa9TU2lA/j2NxmwmhAdwh3rg7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=huzdFCZZy4XpO7wYp8gD88QS2Q0qlFFeEmFkkPF24sBQ21mgvE3YAXCNnsGEAL0M4ipvrv4tpOTFLFEj4462iRECrY4gQtnl30CR9wwVvXtMtWJaRzLsM69+gCvFbdjFIah63YcHIfXpnS7o4oQmQRKXZArmv1LrBIh4sGYHOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ5fYRQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ5fYRQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4BAC2BCC4;
	Thu,  7 May 2026 00:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778115064;
	bh=Xo43drVsLS4+XOyNDFa9TU2lA/j2NxmwmhAdwh3rg7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fZ5fYRQGfa8mGRWHYOwyi0jwziXjMy6Qau+pJgZRMTgcvXBfL3EUtysCjaYPmawVX
	 vH96BJfOwK/ZFMlElJQS022t+5n9sAEcqzCsYaQRhthYr+yYlW5aVG+5ehZfVudxoN
	 9C1xBDOIHYvLySMIzFTReHZuMfHvVQpD3ufDVGNMj8Ba+UeYg722mJVyB15NEUOvgO
	 XM5gaDQpyOjBbCIuB53P1JMlSLWY20agro3P4BMOjvB3Y65x6yHofIoS8ybBft7lOx
	 xEqq9WFn19xPXkeQ6ZXflbp6u3k1GZUpR0F9oFC68YtXxfzW4oM/uzGYHHMJpIzrcL
	 sQqJpHgBLwaYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E57393089F;
	Thu,  7 May 2026 00:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inetpeer: add a missing read_seqretry() in
 inet_getpeer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811501329.3280886.4810044066570088478.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 00:50:13 +0000
References: <20260505133233.3039575-1-edumazet@google.com>
In-Reply-To: <20260505133233.3039575-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, melotti@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 13:32:33 +0000 you wrote:
> When performing a lockless lookup over the inet_peer rbtree,
> if a matching node is found, inet_getpeer() returns it immediately
> without validating the seqlock sequence.
> 
> This missing check introduces a race condition:
> 
> Trigger Path: When a host receives an incoming fragmented IPv4 packet,
> ip4_frag_init() (in net/ipv4/ip_fragment.c) calls inet_getpeer_v4()
> to track the peer.
> 
> [...]

Here is the summary with links:
  - [net] inetpeer: add a missing read_seqretry() in inet_getpeer()
    https://git.kernel.org/netdev/net/c/67ef49047d31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


