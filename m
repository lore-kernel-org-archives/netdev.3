Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA1250C06
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377014; cv=none; b=H3jml8n1YgBgpO1Bl2GQ8NOrhrIkavOhFiCTqZrRZErxrtAxOuza9b0yiv2nyLVTdY25hzwutj7dsAQpfu3Z5nBMpPlUyafxJwd88G6/DEnxCWxJPUkEjMXBpBsJrRx6Jcwt0BwqR3vMacHkyzdLnOe3exH24ZoMZbF5b2rd4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377014; c=relaxed/simple;
	bh=WW76CXbX1m3HYdj6hGNrWkBOzh1df8ZZKhz4ty8xURo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FR+vDdZL19hH1sIwEPihYV3Lee5V2XckJuaaBJwIMJn48D6LoqNB1zDqukHPR6ujVMlPM81M4dWrmNwZmVTGbQAZ4ZiAUmcWhgNQkW3XeoL850ma/9IJMN7FMptuEquHME7wLy0+SPgAVj3H9M1YodIBJixi7HbpL8lELLUhMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxrarqFx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxrarqFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B02C4CEF7;
	Wed, 18 Feb 2026 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377013;
	bh=WW76CXbX1m3HYdj6hGNrWkBOzh1df8ZZKhz4ty8xURo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CxrarqFxZkCX7EXPG9U1CDthC/slYz/u8a3lV+trGDl0WCnQwMOp3pe4VMSEupqPA
	 wCX5h7ot0NHqICFh4ogEEAfOdiMaGNSACJ26VN8k10naPqzCaYHQ3vwUyLZzqbDTsA
	 eRfuoe6kM6xyyonfdLlpcdW+uyaKofoesploNDhP0a5NeZ6GyUojfS7zGaHBYhSo5K
	 sbWyLsMA3UUM47I7gpIscQUerwXU/+1fU2rBWy7Lzo37uj9MZ4XCaFSw1iT0VHTsyl
	 Jlel13IqqrUUkze2w2SFbkOI7WG7Ey8pH7uMUL82MKMMr6Q2BU4PCCHE++3L2zEcKQ
	 /oRkx1X7jazZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852263806667;
	Wed, 18 Feb 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix a race in ip6_sock_set_v6only()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137700533.763696.13164388887036150718.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:10:05 +0000
References: <20260216102202.3343588-1-edumazet@google.com>
In-Reply-To: <20260216102202.3343588-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 10:22:02 +0000 you wrote:
> It is unlikely that this function will be ever called
> with isk->inet_num being not zero.
> 
> Perform the check on isk->inet_num inside the locked section
> for complete safety.
> 
> Fixes: 9b115749acb24 ("ipv6: add ip6_sock_set_v6only")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix a race in ip6_sock_set_v6only()
    https://git.kernel.org/netdev/net/c/452a3eee22c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


