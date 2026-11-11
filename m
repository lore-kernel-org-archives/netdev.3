Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355221;
	b=ZYGeKfiuIgpTVsV87Lv+9DRQSgvcruFVz5DqCWepbLq28K7Cjwyy2fKqKfyx9mcpekCn
	 gki4GMQdarwmcE5tju6NYi8kluqlunAvn5NQ8TKRgEILuw8td7pRazSaAqaRuALCR3i+T
	 l/yHeRAb8iIZJpXSeEVSZKwlsUVBVwy85p6hZaog+P5Qw6fYG/c64y5VvZbMuIjjeZXTq
	 VOZqe6nSXji9zAJN5MFLnMHT7bHIxbgSPQYFw8ur1BKaaQYvZl5WdBnBH7r3srsww0VVW
	 r1sYY3KVhpYaW33Mo273MDLT/gE2kAy7b7TIiJQltlRUhhC2VgHoSrpZjlMNv6gdxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355221;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=phEqkOfyzG7mWqZf5OroNGvwqwA5FixCyvfQgGZBeQM=;
	b=M5ioh8WWDL0QUpDvHIkAIPPWlryHnZn7VQIosORAjF6egeJGFBAkhbpbDtPS9T0Duyv9
	 Aai+Wz6kq4RhJsk3aqzuYBVmU4v9yJe8p6D6n+dub43jFahf6QEnASW4mbVR0r8B1vs2g
	 HCc3KEUtu0vWWkpZaytIuZDBedDx5lP3k34xNF9pcG9waJsH80OPfF2lNviYv3tXff+87
	 hWdkZAaexCbKEml95ZwCH5o/70B93yojpOlwrbj7IgZKdlMTA5bT9yaBiSX35DfY3DVKY
	 7BAPZL7xNRCNv82gGlQ8n6hB25c8OWOHkgKTkOeP6GPmlPsQFz3kOFzYGyULkuHfWyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTTX6AEZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456F606A325
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTTX6AEZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB311F0089F;
	Wed, 11 Nov 2026 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355221;
	bh=phEqkOfyzG7mWqZf5OroNGvwqwA5FixCyvfQgGZBeQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PTTX6AEZFg+yVvIEYgd9zBXGHPSGnDOaFf/2rk3nEFss1oi1BWotUuDAlxvqv2b0D
	 SGmaePt9PoWAsAQhvQmRqas6RkYU0QiBb97vfQl50m/L8EJRDYH6OzC3HSwaJATDjt
	 yP4Yw2NdY9D2Us8BVkJWqqxaFGxaW1nLTnskFCFy2oXgwBlhLkd7eqRNKq7i9B/pNY
	 Q2o5OP4CwjWdheKXT7WckHSsr/fDlldRZtAyAPskDcodZkLqYskrORgThQYigIBhKj
	 n8BMTMkJzbpYDPGeX9AiQgcZYya2Y1ykbeuu1rQgNERW+xK2Pi6bA5aMLirMTw7v2S
	 QoRbuyDCMcdhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7256D39E8A4C;
	Wed, 11 Nov 2026 00:00:21 +0000 (UTC)
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
Subject: Re: [PATCH iproute2] lib: bound the hostname cache in resolve_address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435522017.125436.18266005474398577569.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:00:20 +0000
References: <20261109180832.300754-1-stephen@networkplumber.org>
In-Reply-To: <20261109180832.300754-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  9 Nov 2026 10:08:32 -0800 you wrote:
> The reverse lookup cache in resolve_address() grows without bound,
> including negative entries, so a long running "ip -r monitor" can be
> made to consume memory by churning addresses.
> 
> Replace it with a small fixed size open addressed table (32 slots,
> multiplicative hash, oldest entry in the probe window is replaced)
> and use getnameinfo() instead of the obsolete gethostbyaddr().
> 
> [...]

Here is the summary with links:
  - [iproute2] lib: bound the hostname cache in resolve_address
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f7ebdb7e560e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


