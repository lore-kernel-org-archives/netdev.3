Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336012;
	b=Bk7eCasLE972jkIAbJDQV6wv2HfsTeb6vkqNXtPR//EcYwl7/D072kfVr19ZrSHxd9k7
	 pkync60sJTCsqGGYOk1BxTGDx+eE8pnEAIhsQs6FRq98Fm/4u/LRkLn/FPJbtEHBIw4H1
	 ZKhNEjb8Hl8LjK2jslFrWUDWAqekOAePsl2YZyFFvVSgjAURg3PoTt66KSJzLm+kM0Fvw
	 dZn4U2UtC2x0b5rShHxbjKnUDn7p1jMBZHR27sFrS/7HeRWePFwizzpceoArzeomZYOPg
	 KMf1n1sz+XVs/MaSoWpF/HCSD5GPEDDcrBf5HhaWtQSIO0RIaEW0ceZfI6wa1roCc5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=j/HiRNgNDwgIfvRr71aE9B1tv3rjx+NrK88z3ezu9PE=;
	b=scG9x7FXe1ZdlZ+aWxCb37m1+hxbyicy1swODeHfKtzjBKEYXTFZKtLSExR0d6F4amvW
	 Gwo7a3GDwifGGmhFfjDbqWwI1wnWSg9eZdW10mr2XY4x2i+5RcqrO/Izu67OQNDzZCTMe
	 FHyYITthW+2bzaOR4lSdEw3cClsP3wD98DwsXuPivEm6p8EFaPRxBAhGKvbcWYNs1ENLn
	 M81RENLcoZNItTa5/sopIJdZmzXjynnLVkgGBHmYv1RkaAmvqghXgM0Rk1bsbGP0RcTWR
	 NPzOMIYdg2HhfkwXcDPAhF2UCw9j7slcFpB+SSmfwOBuUi05IA24Qb71pa/n/3Za8FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8Vv15xa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966960A6F60;
	Tue, 10 Nov 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8Vv15xa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C02C1F00903;
	Tue, 10 Nov 2026 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336012;
	bh=j/HiRNgNDwgIfvRr71aE9B1tv3rjx+NrK88z3ezu9PE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L8Vv15xabE9PxRxXolxQJIJ5eseB32KDMxTn9Z3GbSE5WrEecoFvINAhYlC55Hg4t
	 5op/tQkcuvwh6iqZDTs7i1g9ybG3xUKcFJmFwCRl/6YPBkqTELpBc8TUMZCd3NW0wu
	 Z2d6TVY+dCaMyz5VVRc7YEUjhnDxgvmJ/Ne9YoPEAyhW/UeHxuDqGZhcoWcbxgk5U9
	 GhR+4wovk4t2dKRvMhlom+3gqnPXDv8DzjEbuxF+ijK9NWcKqsMCOQgWcb0S5JZ4JM
	 poPtR3b9osQjMrTeKcnQJoqoV5Jboh4foHXuYBSV/QnILBXvAm0gjpyT6qTHqmY2If
	 zYOE+CPt4kiqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E19539D6091;
	Tue, 10 Nov 2026 18:40:12 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] ipv4/ipv6: preserve multicast filters after a
 failed source leave
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433601092.4186528.9911475514959003155.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:40:10 +0000
References: <20261104061419.87989-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <20261104061419.87989-1-yanxia@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, yana06070@163.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 14:14:19 +0800 you wrote:
> After joining a group with IP_ADD_MEMBERSHIP or IPV6_JOIN_GROUP,
> MCAST_LEAVE_SOURCE_GROUP for an unjoined source returns EADDRNOTAVAIL
> but switches the socket's filter mode, so the existing membership stops
> receiving. Leaving and rejoining the group restores reception.
> IP_DROP_SOURCE_MEMBERSHIP has the same problem.
> 
> ip_mc_source() and ip6_mc_source() allow an empty-filter mode switch before
> checking whether a source list exists for deletion. The failed request
> changes EXCLUDE {} to INCLUDE {}, so the socket no longer accepts packets
> from any source.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv4/ipv6: preserve multicast filters after a failed source leave
    https://git.kernel.org/netdev/net-next/c/2f14be6c9b9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


