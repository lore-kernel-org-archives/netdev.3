Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652621ABC9
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126477; cv=none; b=DzzC1JxmYQ5AxE+ZzaCiwl8jOYpGs5yT4mZ63x48wzjNTwjSUsKY0yMUiZ4q4HnYts+htx3yVUu0hAK1GY4ECKk225u+Pbvk/E7oF7YWBUgb3LbxTVE4HBZAZR56EArRty+brp03aOKf+D98zkpeIc43ZibiGaklwl1F5U3xWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126477; c=relaxed/simple;
	bh=wRTs5mB7lbr1O6h9EptkHT14EBpTmkUtfmKFrd+Ag7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sqx8ETjkqpsc92UYacynyC+Uyg73YExh9t0g8u91e3sP3fno5AO25kOZdgmWoUNgwPVmOecOUxkG86CIjW9GOLE2CDjp5ATTTMetyU94yyMhQAWx/ZZ1cjETfxhs6jA5oaxF5ox5Pn7Jsm4mRntfWIpF9rQN3TYs/0YUuGOqN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNZy42tE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNZy42tE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1C51F000FF;
	Wed, 23 Sep 2026 01:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126476;
	bh=l6UO0vWE1Nw/6etMkEunqZ/ufuKDV3Nt2QfQMCAUPD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DNZy42tE2nmbUxaNDtOtUmqF1bj+yXtpoCaHi9hpzshr8h9jzOxgg2DViRzy3Q8GK
	 EcztGvIwHPTAUXEQOWYUev9MlXQi9wj/DyyRl3bIILmKLgP5tGBCKqe0DGG+wTjn/H
	 llinqHm1jM/WgsrRMhwzE8B05LoKLB1kFKUvmI17qnMfvF/NdSNA+dOyqpDWxVUvvF
	 r+px37c9xYV8VmWqKvItKwv+9d6z9XPUhljthJmp1Bxvmg+gXWLM/bHzVwSGQZwagA
	 QCSBf0KYs5kxx7u9Cyznpp8H5s9IlILduFcGKbx6lF2mMfDMj5S6FLx9nc42J9dINS
	 YBUKEwyvGhMzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569F73924463;
	Wed, 23 Sep 2026 01:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net/mlx5: Bridge,
 fix remaining switchdev ownership gaps on merged eswitch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012640714.161587.5863662668734138663.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 01:20:07 +0000
References: <20260918095931.29792-1-bsoares.it@gmail.com>
In-Reply-To: <20260918095931.29792-1-bsoares.it@gmail.com>
To: Bernardo Soares <bsoares.it@gmail.com>
Cc: mbloch@nvidia.com, daniel@iogearbox.net, netdev@vger.kernel.org,
 saeedm@nvidia.com, vladbu@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 10:59:29 +0100 you wrote:
> v4 of "net/mlx5: Bridge, don't fail switchdev events of sibling
> eswitch ports" (5f324c5d1b12), addressing reviewer feedback on v3:
> 
>  - The v3 commit message for patch 1 wrongly attributed the recursive
>    lower-device walk fix to LAG bond enslavement order. As pointed
>    out in review, mlx5_esw_bridge_lag_rep_get() already filters on
>    mlx5_esw_bridge_dev_same_esw() per candidate and cannot select a
>    sibling's rep. The actual bug is in the generic recursive walk
>    used when attribute changes are emitted against the bridge master
>    netdevice directly (a bridge with representors of more than one
>    eswitch instance enslaved, no LAG involved): the walk returns as
>    soon as any lower device yields a rep, and the underlying base
>    case only checks same-HW, not ownership. Commit message rewritten
>    to describe this correctly; no functional change from v3.
>  - The v3 commit message for patch 2 claimed a "replayed/duplicate"
>    NETDEV_CHANGEUPPER unlink as one of the reachable cases. As
>    pointed out in review, netdevice notifiers are not replayed, so
>    there is no such duplicate delivery. The actual (and only)
>    reachable case is a sibling instance whose bridge offload notifier
>    registers after a peer port was already enslaved, so it misses
>    the link event and never tracks the port, then genuinely receives
>    the later unlink event. Commit message rewritten accordingly; no
>    functional change from v3.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
    https://git.kernel.org/netdev/net/c/35e6f970f553
  - [net,v4,2/2] net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports
    https://git.kernel.org/netdev/net/c/2e51097c982b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


