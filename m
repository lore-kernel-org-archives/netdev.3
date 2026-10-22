Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631410;
	b=ylAHyt2obIDMH5IqlKlNv07sKaTczUMxEwNJg+Q2bHiyBpv/sfRK9toaKkY6LLkg4PzF
	 rowCq9+vvILBFDkJaFw31lUpNqnwFcmG5QgSfFr5ERw2BMmXyG4ABJD7l7txq6Tn3oQqv
	 aPWB4UV+Hn+auHKYBbuDKtBd15sOb2Uvy0Tb44R5MyHGW2Asyg2AJQyI/ygYgbNlQyQQh
	 1ioJZ1SG+f8KxO5+31cbypFEi4eOlTlnbtyX4NEva1OpEwLC58an+CIcopzVTSV7PX9xg
	 HWuHRqvXTwtcvqvBmtwcFA1Ua3kzNI0tD/lHb4HOJiiqiqRALEDd+AmILqLzFR2MiqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mp0hqhUEAVw1K2G8YqaTwpF9mdbdxvg5Q/4MbdAvbuE=;
	b=fOlcSxeSpBMxaBkYTP/P5NWMrvmuvtwclwtv8/DpYFO+JkeudXGVhiNwVFGPbvKozSYv
	 rFWfn+mYuxrRBTndEiplMukmC5Qe7kwCtxoFnRc9rIiP7zEw14JkyZ3rejRowlkYQAVNA
	 oX4QjHMQQYeQ8RjN7O+TvKEh0L7cAVS7gY17144Bv8WKWvUDCXRrRVBUDZwNhh0O8laRv
	 /G2HBJf9QLFLWbz1jNwyHxJX97sna7nSd3SilkX7FNjr3UayNcrEMWY/0dSvBL0kjVTSx
	 FY6GrDcJjXoZK/WdpRv/Dr2J0A7EuxW65k78IGjnZ7J4ETSxe6uzspiExYAwI7r4GHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e40FgEJ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11487606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e40FgEJ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF7B1F000C1;
	Thu, 22 Oct 2026 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631409;
	bh=mp0hqhUEAVw1K2G8YqaTwpF9mdbdxvg5Q/4MbdAvbuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e40FgEJ8KZ6E7tPCw4ZQjdtDfGKF5ow3fBE8gnkvCA7Y6dMIJIPUmYHbvnfCERF5Y
	 ImwgLTzhUO+cc2gRh7Fbb2PZDhswWnJbohsxWaasypcR0D+BB+lKKyiZ56hwz7BRjF
	 gQBARG8TDOqw1ZIKC9RBRabwEfr3mgZV2MqzYKKMf+s1JnCaR9a9pYMg4KXxQIyrh9
	 gJ3CFOMDd+WAviBX2gZCieenRcjmIP3vgGRnjlo4p/kSiih2M7qjE2ONs25W8kgwTL
	 u3w5YAdHgkx9qPh3mz3MAPtfCjkHVTjnMX0FgjZMBUeKjp6bbAau1Qan6GCmGvTp/u
	 Nzt6LCvYgVvaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77341380A963;
	Thu, 22 Oct 2026 01:10:09 +0000 (UTC)
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
Subject: Re: [PATCH v3] tun: Require CAP_NET_ADMIN to attach to an ownerless
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179263140807.1392288.12458500793289522283.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 01:10:08 +0000
References: <3c77f88acff5b3c2617b22d64faad15f6212619c.camel@infradead.org>
In-Reply-To: <3c77f88acff5b3c2617b22d64faad15f6212619c.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 omosnace@redhat.com, stsp2@yandex.ru, luto@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 10:48:10 +0100 you wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Twenty years ago I made creating a tuntap device require CAP_NET_ADMIN
> in commit ca6bb5d7ab22 ("[NET]: Require CAP_NET_ADMIN to create tuntap
> devices.")
> 
> The idea was to allow the permissions on /dev/net/tun to be relaxed to
> 0666 and thus allow owners of tun devices assigned with TUNSETOWNER to
> actually open it and get at their devices.
> 
> [...]

Here is the summary with links:
  - [v3] tun: Require CAP_NET_ADMIN to attach to an ownerless device
    https://git.kernel.org/netdev/net/c/ffdf678dd166

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


