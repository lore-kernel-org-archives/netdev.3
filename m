Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD73909AE
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424976; cv=none; b=tMpiSKgrf5XT/G7n5f84d1Q3sHDHN5KGMXWKAN3AF56/GGdI8JIuBgnz3vIf+8DuCu8AS0OR4CyUi+r/q/VpK37dPB4iFGiq+jOEqJYrZCDIh3RwTU6d625M5OY4GOc5EJcjlhxveMUZtmkgPu6Zk4o0oK3ERBG2heAc/X8IVnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424976; c=relaxed/simple;
	bh=cOAykZWhRsL1TGyL1Ic9FrlRU9AEw0MeRR9PTO45Ebg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R31FcTeWzJtNfS78UFUB90sDjH9cDChrDGIa8MlT0RL7GhTTY91RJxbgEuTV1X+0FRwKc6h9gvVgwebLi7AQK3vldsdkh1VUYN/MhF7UVwiYHrMkmTiF0hy/xOx/Jyo/DWnxrjNIK2xFpjXEBP/rFRSPnoxm9hwMEsCifl6GejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Xa+Y4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Xa+Y4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEBC1F00893;
	Tue,  2 Jun 2026 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424975;
	bh=Brx1uKf/6SqXt1lkmg7kU/LgJ8uxseX3gupdvVmfdOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B+Xa+Y4uZHkbtWE5QsqdetqF+prKN6NT6gxPjdRlvwzYO5w7bLsumQVr92TfJmiiE
	 eswYYB9NMVdBRnerS9F3zgK4SF7w8B8gA2e1RRoDXwMQGZB04l2Si7/XMU8zC3EBSX
	 cqEIB+0N4+ch6pZx05Pr4X7fZNL/OjrJLfxHfz8O/WMkSW2uP8CwTw3t7X4s+VyUGu
	 xKjT0/zLlAiOWOso1VAecIKsf+uwh1wqsnvLe9gmxPu6F+Y1DdXg8yL+6fdNu2mqkf
	 +cdYfMcCJhKnhi66D+xWJrZ1UHVVd43Fa/UV61k/w0cWeWcseOCAscNhYq8v9yMhy2
	 oWu2zrgdERF4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198603811A6C;
	Tue,  2 Jun 2026 18:29:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: change bpf_skops_hdr_opt_len() signature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042497665.988310.15642495418915987528.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 18:29:36 +0000
References: <20260601093819.469626-1-edumazet@google.com>
In-Reply-To: <20260601093819.469626-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 09:38:19 +0000 you wrote:
> Some compilers do not inline bpf_skops_hdr_opt_len() from
> tcp_established_options(), forcing an expensive stack canary
> when CONFIG_STACKPROTECTOR_STRONG=y.
> 
> Change bpf_skops_hdr_opt_len() to return @remaining by value
> to remove this stack canary from TCP fast path.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: change bpf_skops_hdr_opt_len() signature
    https://git.kernel.org/netdev/net-next/c/ceac8dbce6c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


