Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01673D47A3
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190851; cv=none; b=LCaSu3Fn/ffK5JmRQR2wtSektFr8ipXD2iJoGy/VdjuXjsWZ+IV5NdARTH7onQnMcgJLawCXR/BbpcA+tgzUnjs4NwpcTs48IHtlRgat/M28EFqqclpRtvAWrLsQjqSXqfgS0dik/0dcZYjWBA3J+pD+iTxAR5HobrgyMX+/11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190851; c=relaxed/simple;
	bh=Ksgqzu2N33tKNi5KP62CckWAeWziTdaDoLV8RZeegE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iBuQx923yy00H2IAyHjXH3aqZC/uICe4eF+nwSKB6k+HxXviQD+reGmjP5VQdCFPZ9GL7HtgMgKNl/JMe6s/xCCpp6FLKbqUR27IfZwp7w4ua8NvuVrlpJteWIM6VtEVOQSVfZDon/SMYzLQ+eljtTlnYSwrT/hHhzySTDHZEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO1hg/2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO1hg/2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D166E1F000E9;
	Mon, 27 Jul 2026 22:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190850;
	bh=f3Pnj+XnqzTEgFxVSpl1jrxNVkQP63e8incvlML7cv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nO1hg/2bxho3w4GWwmHP+eVt/wz06Wu7TldxS792UbrN/ShXIpTi9ehVPwxGYOmN4
	 2i2DQmYfglBga1Lntblsctcvup34fi5xodrG3JB4oYuzmkEEdWtm06Z6N/aVEmh+4O
	 H+iEU7vNaF/eiTZoeidlc1T+DmOdbyWZENnOPfMW3LX87pGc8sP4zsVZ1F1GAOruvl
	 QvvCTKMu3Ej30rqpNZHaLiVzpPwwwpKE8BEu/v7HbtFZiYWUz5VIHTUK2EowOINbml
	 JLg+cEXs+iMnn/ntFExGa4jIN0hmymoXu3SueKK3EjjwCXud3tuXTgLdFVMdKSEYwa
	 Wh3zcPhXS7rfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56862380CECF;
	Mon, 27 Jul 2026 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not send ICMP/NDISC Redirects when peer
 allocation fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519081588.1438149.18330636783764920286.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:20:15 +0000
References: <20260724072901.1633601-1-edumazet@google.com>
In-Reply-To: <20260724072901.1633601-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 07:29:01 +0000 you wrote:
> When inet_getpeer_v4() or inet_getpeer_v6() fails to allocate a peer entry
> under memory pressure or tree size caps, redirect handlers previously fell
> back to sending un-rate-limited ICMP/NDISC Redirect messages.
> 
> In IPv4, ip_rt_send_redirect() called icmp_send() directly when peer == NULL.
> In IPv6, ip6_forward() and ndisc_send_redirect() passed a NULL peer into
> inet_peer_xrlim_allow(), which returned true when peer == NULL.
> 
> [...]

Here is the summary with links:
  - [net] net: do not send ICMP/NDISC Redirects when peer allocation fails
    https://git.kernel.org/netdev/net/c/dbc3791e3b24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


