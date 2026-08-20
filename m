Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC233D47C2
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257881; cv=none; b=iH7CpvdsTog1517b2K1RwyJFkJDG3lCkonVnSYlo4rPOBEDfvQaMAGkDIbFaMnr+dvFK2d6WNL/uykgJG2yIOslh26D6PkKFdy8D41+fJVeUqnhBUOy3cJBswBIAHNx5rMGLgUgYJDnIlFkMUwdnDl6t0lBopTpYfyvIHNT0xhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257881; c=relaxed/simple;
	bh=ivMjMuMf4fJt6JcryVMOBy4llOqUG0VEyDndG/JdglY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a3heFqGtvQFn6awmgkFYNk+FE+TaHgJGgogRgJnN2GKxIT1oH1H9e21AHS3RwfTN0cpyiPhObFqJZ1UeeRoMMMXnzgYmQNpbbukhLXnI6o3vVwk0dkdI7AHK8qoUG2aYY1sD0PXgs+A6PI1MgrbLGygOiaKrHs+GHlqiWJVJyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcHqBlJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcHqBlJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698351F00A3E;
	Thu, 20 Aug 2026 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257878;
	bh=dR1hxiOSHRwZXGTOXJLUZPNS6d4Oj4Ju5y2RitlT6zg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QcHqBlJpIjqaAgjsUcFcRWa0F8MdjfIGbNNwstEV3+276m+OMEoXAy7BokAmlf8O9
	 i1V2V0xHrg1qxIcSl4pcLiBKXp6Yqx+K5F2/dDtlG5DM2DRgKj8uGuNTB8UWGvLOhB
	 FIG77Oh8Kep0RlioMRVf8qPaJhsfZJtqlT8bFlPz/OgAHEFoZtZTGUmqnYTge5tnwu
	 rtEKodN6e1Xwyee5FX8f7U1vJraVcg2y4Ddezrb4z0qo63CtQQxbz87PGTVXJqM+Ak
	 IvVLGR04q0gX9/oqT7qvEgk0Tz3u+TyB/RstKMet2NxKwwdIjaFs2tWKD6SzIz4RbG
	 WmWdNMg9DFo2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D092E392445B;
	Thu, 20 Aug 2026 20:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6mr: do not clone dst in ip6mr_cache_report()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725782838.470503.14744618527842418723.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:28 +0000
References: <20260818172755.4083692-1-edumazet@google.com>
In-Reply-To: <20260818172755.4083692-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, zdi-disclosures@trendmicro.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 17:27:55 +0000 you wrote:
> IPv6 input attaches a non-refcounted (NOREF) dst to skbs under RCU.
> When an ingress multicast packet misses MFC lookup,
> ip6mr_cache_unresolved() places the skb onto the unresolved queue,
> escaping the receive-side RCU grace period.
> 
> If the underlying route is deleted and freed, and the MFC queue is later
> resolved with a wrong parent interface, ip6_mr_forward() invokes
> ip6mr_cache_report(..., MRT6MSG_WRONGMIF), which executes
> dst_clone(skb_dst(pkt)) on the freed dst entry, triggering a slab
> use-after-free.
> 
> [...]

Here is the summary with links:
  - [net] ip6mr: do not clone dst in ip6mr_cache_report()
    https://git.kernel.org/netdev/net/c/235b42b58601

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


