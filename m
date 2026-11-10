Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279299;
	b=XjU7S0iQwmmYUOluzg1S7qs/MonOV57t3K//QQ/RsKsH/NnY1O1VL7mHQMJ7pLXuMmTp
	 X+p6aca7A7v46j2G9H1rcZomSAZlmoX/eeYlFkYIVViY1M1ja4Zg+8hrozZh753e7cD8V
	 wKUQsqW0P/ZoV+FZoI63C811yj7MzfNFemJo4jqS02EvL4Q4ADNVXCWQI7/Czg+YZ+3db
	 XUaH6aQtsf4OD1+UPnEy/Ke+7bA/Oxh1NMrX6K70cv9lXYXliin6VjB6lXQix5OKSm+Tr
	 4Oi1RbuXn4vkau5K4k0XshtWSq7kfgNt2o9pJQ/lxq5GEfPFn6Djp27zF51l+Z0ezPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279299;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=K8wsLWkWivP3YQSOo4H4IfV+hFon/0R2dO0BY9wWmTE=;
	b=oGgiLwDKikW32bbhSnq66fxbGh0DYnS+8Q7mWM11RjnBdBiRKPR2WFG0pq8kRSRf8rG9
	 GKge+dK2pfNB+/Z8AqZ7fYgejA71UhCj0JAogT+ugwgXAGjdG8Jq44FFHnBY9zzHmqXM9
	 vIIDLa0W36p77yMy7ncHE25KTF5hjl3vBmx2IeuKcfrdkGI75/LnqV4ydYUyZfrzTBYIA
	 y5WSFsCUWMXRhRnRE1gHuQ2u1YkNwjKcQw/+YnxRsibDS2X+xqbnB3TwoW4pzAKuzIcQ5
	 3CcrMYMn9/SYKqiR+rWkgokL1zOf9mrdLw8Wp3OnAleGCxFF8GMB7Y7tQipl84sjBxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0Kumk5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072F60A5BD7
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0Kumk5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BD61F0089F;
	Tue, 10 Nov 2026 02:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279298;
	bh=K8wsLWkWivP3YQSOo4H4IfV+hFon/0R2dO0BY9wWmTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P0Kumk5j8C/6MWSatyUgf0Q4kTNObPeqorT5kSeEmTSbzu+1slQ+kPwAlUxh0l6gp
	 wuiP7/ZrtiiRhfDJdR3WHgUtFiO3BnWgwP6xU0fVcyL3I3igZCnWN5HMFhqxCUu0py
	 QxSgNcUJv7YA7faU8NWl0TZ7w3sSBJFxatynMd1nojYNYp/LJJxswzYUoBKOiq2xVN
	 VZvvy4R/XD36spe/UgmHE1SD+m8QIzOjfUsdniCo1g+lxEgzy9bzHlYunUtFxuprZU
	 bvrNXMm99e9UwbXa3KMIc09dxtyMXWfaNKMz89obXMIPqvNF7GTCFxX4Z/VT3shRMj
	 R+bmwAhqB480g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9AFC8391AFCB;
	Tue, 10 Nov 2026 02:54:58 +0000 (UTC)
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
Subject: Re: [PATCH v1 net] af_unix: Remove gc_in_progress check in
 unix_peek_fpl().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427929717.3612825.2202404863084931818.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:57 +0000
References: <20261104162858.991930-1-kuniyu@google.com>
In-Reply-To: <20261104162858.991930-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, q.h.hack.winter@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 16:27:56 +0000 you wrote:
> unix_vertex_dead() and unix_peek_fpl() are synchronised
> with unix_peek_seq to prevent GC from purging a live
> socket's recvq.
> 
> unix_peek_fpl() skips the synchronisation if gc_in_progress
> is false.
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Remove gc_in_progress check in unix_peek_fpl().
    https://git.kernel.org/netdev/net/c/0edbc945eb9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


