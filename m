Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF423F7A9A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272883; cv=none; b=GX7wbnM32KWfViwReVxSH0zJ9QYRXjAZc5S0GxOht6Wp0ThlHgka0KVxbryZ9Uw2J27SgyxW17VxG0pSgSRfXmy0K5R4PEJkH/CL0T+qoMcmddK0Lt5ve8y8UFU0StpEKDykLatQYGiSNhcvXhAWBhNgv2buRCxvMA6F4kM1vf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272883; c=relaxed/simple;
	bh=PRIf6SCr6zo0fzk1lnOIbBwV63+BayDtd8Bx/owNdf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kHvxqZDmMu7VdGRUWygvdcvgtH2pWYf4BYu1rxR/9vqADdjbsNxr0NPE9E4kS5LGv5eqfX65qgtNLao9sXTk7z4L5833I5qe+FRYvbvtZ5vHwUjDpkCzr+XPT4qq0VJBocTnqHEgF8+b2pFLj2O5xsPTM7ZJ4x0H5DfXdoJ+7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTUDBoaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTUDBoaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3B71F000FF;
	Thu, 24 Sep 2026 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272881;
	bh=V0W+BYSVQgrDV7wfqG6HYY/hQKhJ6ic8LhL1qaNrlI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZTUDBoaSKJnJ/95jIs5kpLwJzkkTyQ1zsD7R/eDgCz8ynVBB0Rm7iTzpwBbP/d+Eq
	 PMvl9tIosY8D9Q1wEqkNVW+1PfNNgUpcgz+PL6v/IqK/e9HuIhzpZyXfMEOxft8VR3
	 d3dd8XlYASXsreJS6b956oEXfiyDd/rzicp9YDBxh1+2+F6+bkw27kMXlNcoBQlEOV
	 YcCa/hvhorAKF4JEALBalb/8KGxOuqbW1htUgTvadIsJR09iBBwvE6nWzCrjeaokcL
	 2mzoIcWLiJYLJ/VX1bF9yx7DEmDSLcc3qlHqLthaQft/TZolhOIH94lX2YPkuf/1SO
	 JXMGgmcIHAnmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2D3A566DD;
	Thu, 24 Sep 2026 18:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: DQO: fix header length used by
 gve_can_send_tso()
 for UDP GSO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027281039.1685480.9201074786534081630.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 18:00:10 +0000
References: <20260923145942.731365-1-edumazet@google.com>
In-Reply-To: <20260923145942.731365-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, willemb@google.com, eric.dumazet@gmail.com,
 edumazet@kernel.org, nktgrg@google.com, hramamurthy@google.com,
 joshwash@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 14:59:42 +0000 you wrote:
> gve_can_send_tso() computes how many buffers each segment of a GSO
> packet would span, and for this it needs the length of the headers
> that the device replicates in front of every segment.
> 
> It unconditionally uses skb_tcp_all_headers(), which reads the doff
> field of the TCP header. SKB_GSO_UDP_L4 packets have no TCP header:
> tcp_hdrlen() then reads one byte of the UDP payload, and header_len
> can be anything in [0, 60] instead of the transport offset plus the
> eight bytes of the UDP header that gve_prep_tso() programs into the
> TSO context descriptor.
> 
> [...]

Here is the summary with links:
  - [net] gve: DQO: fix header length used by gve_can_send_tso() for UDP GSO
    https://git.kernel.org/netdev/net/c/83769c23fb18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


