Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D538399C
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432464; cv=none; b=rs/Pu+vZJZf3ocwCqwXsBM2jZq/2AWSz37b2oJXHBSOzLtdoM93BX4dvnF671whRHRiY3q0KYEsOFcShPg5y/+63+49Cpev21ZK/OOiyq0jMa+EX2McghU86RfC6CxhmZpgtIB5mEX071LkE0aLIccl+AR33pYCJeBdScsSLAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432464; c=relaxed/simple;
	bh=1h6bedumtxdIt4uJ6D3eTlJfLh+23jnH7slE8JXsUzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VCsgaal9gg9H39syxpKwzhhJGwTsOSJgvdkumZSAX+aS3/UxGmi/bFtmMS9fzKzbsMSlR094IcD23qXYlCwAKzdfY3tUC6kikFv7jhlKhEzvJ5q+n1gvQX/Hr50H1DaDAeCAOghTKgw83n/pFOko1ZZ2GpblZOo1zWUgo352jvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gme3OZsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gme3OZsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABA91F000E9;
	Sat, 22 Aug 2026 21:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787432462;
	bh=ajbowqQ+gXi4EG8IeHsSzJBz/EESZeixXoHD8I4z2RA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gme3OZsE198UB5XxZ5+69RCXyL2q/CHUxha5/IhK/DJlfKgVgmzD0JCVuG35Hjhdg
	 1C7CuRqdTXey5QmGeuvkK5lB6xTRmUIGVj6VfAEfal/a947TP8ObFl8gLa2WZIkvL5
	 94VKwPqzUY4Rw/1aDbRNdbFi2oXqSlnqms/ykUznj/DJabBGDjBAJEu9OU1e306Y9m
	 UpLER373H45NKPLJRfsK4DrvgNQ+SytFZUtwIda6TikwkWqnvpWUDB9EsJgPnhgJ/F
	 gYmWGqpkqohmh+UD7Z2PKYcS7O8ZodlTEIpRMhRb6EZcf+fT6OxLSkHMlj+yFd4HEx
	 BzDuQHuAJcS2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A76380CEF9;
	Sat, 22 Aug 2026 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: sch_fq: fix pacing delay underflow with
 pacing
 offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743241114.1826211.13344127816621627635.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 21:00:11 +0000
References: <20260820120706.1995449-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260820120706.1995449-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 08:06:25 -0400 you wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> When pacing offload is enabled (q->offload_horizon > 0),
> FQ can dequeue packets early (now < f->time_next_packet).
> 
> In this case, the drift calculation (now - f->time_next_packet)
> underflows to a large unsigned value.
> 
> [...]

Here is the summary with links:
  - [net] net_sched: sch_fq: fix pacing delay underflow with pacing offload
    https://git.kernel.org/netdev/net/c/137b8ae233ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


