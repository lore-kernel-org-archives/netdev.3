Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559043F9F30
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185812; cv=none; b=kn4r1DcLZyh4CoZZFvxnGhPTlf/kBHsblJ59Qt/Ewf8DfiivMxQMuemJ6iTpn3plnyb91z7Mrhl6boH6bV9edR02y0lxbFXlZW5gjBoJdVoKR23P5BXMh9fzUNaLf+Ux+hN+CWEUmYVS1MPvFh3yAMucJl9sbXD8g65im68KwCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185812; c=relaxed/simple;
	bh=nPg/A/OwO15WKQybusWtgY5VyXtEcqEloo/pC5qslqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G+bT41LB/w5cyD6Vw8YiKs8FDywhnEufGx6PLZjOfUEiSrQAiCYZws8Mn4GTD6Wi8be1jkdJh9lQZbSHYscG7DG2qbdzk3ZF3wxmVlxuZ4Et9H5arIKvr2nHvwFXW59s/u6mw2Ni9rnd840yOaCwdsUldAdSXwWIMlyhMHfpw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogqzafCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogqzafCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F352C1F00893;
	Thu, 11 Jun 2026 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781185811;
	bh=3/ekPrYApRsby3t4xJgGUGJarCVkfDAx31S3bUYdzZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ogqzafCb+m75hHpqd+zGm/DCUsVECDAyqRoH+vVLCL+NH/WKWc0pcr81DT9tJqw24
	 MQ4CWtIRkNMKn7M/FqcGCy5jFnjw+IlC59e9jIeaE/wuOSyB4P8oJxsyFXpOMRnBvc
	 6gS7vh2JvrPfE8OLGNn8IZTbeMzTASj01Zpl2/cwdP8Ifh188NbnVPPK6Gvhx99fHJ
	 vIAWugryZBMMBaRCqGHRsg45ddAjj4ZIh2+HXr+yss5CSvBy04Q1NEYXkxVpjjpbV9
	 l9mNJqIcR70nOR8mvTMKxND1X1UxFYq5A0klanh/F67ByiwKo0oT2YzRtB6kYJnK0r
	 t7sBUmwzRcd3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938D33930E5F;
	Thu, 11 Jun 2026 13:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_tunnel: do not use dst6_mtu() in ip4ip6_err() and
 ip6erspan_tunnel_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178118580813.3971116.9259263464522447787.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 13:50:08 +0000
References: <20260609091337.2672441-1-edumazet@google.com>
In-Reply-To: <20260609091337.2672441-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jun 2026 09:13:37 +0000 you wrote:
> This is a minor performance / conceptual fix.
> 
> 1) ip6erspan_tunnel_xmit()
> 
>   ERSPAN tunnel can mirror both IPv4 and IPv6 traffic, skb
>   (the packet being mirrored) can be an IPv4 packet,
>   and thus dst can be an IPv4 destination entry
> 
> [...]

Here is the summary with links:
  - [net] ip6_tunnel: do not use dst6_mtu() in ip4ip6_err() and ip6erspan_tunnel_xmit()
    https://git.kernel.org/netdev/net-next/c/6e12a8894e02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


