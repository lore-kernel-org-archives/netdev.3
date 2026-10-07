Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90833242B2;
	Wed,  7 Oct 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334810; cv=none; b=GnHuOFdlgzeDSrxqgNvU+ZN0+jIuBXpnAE1GtRNFeFdtmSNofnFacYGGRfWvuJ+v8Rlntwu0uueqP/uFoXr8jTGYiEMNevkGUWeji5MDZ3tClE9PcgOfBG8eLhNf3pAqeKAATuE4EB8qnivqpw/GWV7dK5rVYuJJ18XS/9dCvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334810; c=relaxed/simple;
	bh=D+xBKRIaENSbRFifckQwzLmJ5l2aAjZ0NW6cWBKSG3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hoRPGUgDiDbpRksRwsDqv3fGlBh/A5YNbhwr5ujt5TMbWPqT6Ke2dLfXQxfC3gI3tuNwqqwx2w1UeID10N9guAED4EpF6OVi5msIc833hx5KsBco9TkumbmFB7aT9m3J/ZTnD23CVCEjvy8ayI1LSY1c6/L92NRn31B0+ffuLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyL5FY7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyL5FY7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837E31F0089C;
	Wed,  7 Oct 2026 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791334809;
	bh=Yx/wstz8ZIVYVV4REYd9UpnZaMvU8O3AS3Fzl9EAhZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HyL5FY7myZ4jIpZ9uspML0sJQPLLRBvkdt/9xAHdDxryZAuVqX9b6OGqBLZtWni/5
	 MrHpcc5BF5uWbBUE5phWejZDe3Ru+xRqtQ4AR8ETmnv8BgH/3FZLph76OxNzLzkmwl
	 fu2bpQzzEpREnGt+FKhgWiVe7bwdH7OsaOM/nhqujcN34XuqmLkMVy1ImjCAQXwwxm
	 euabTLH5E1YpoEPozE9pgVSytGf+Xrrf2NkOOzS+o5kTOjCkhDQ/iMpw2lxqN5mvAO
	 RY4mbM/6oLMIpJHKItpSaO/TJw4OcrbCWCJVVHNmKIgpkjiXKLC9HzSMdV1w4jDuK5
	 KDZ1HeuCzc/hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773173806541;
	Wed,  7 Oct 2026 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tap: report IFF_DETACH_QUEUE in TUNGETIFF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133480802.2850681.15148271717862694854.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:00:08 +0000
References: <20261004174739.36179-1-umangpokhriyall@gmail.com>
In-Reply-To: <20261004174739.36179-1-umangpokhriyall@gmail.com>
To: Umang Pokhriyal <umangpokhriyall@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Oct 2026 23:17:38 +0530 you wrote:
> tun sets IFF_DETACH_QUEUE in the flags returned by TUNGETIFF when the
> queue is detached, since commit 3d407a80b62f ("tun: Report whether the
> queue is attached or not"). tap does not, so userspace cannot tell a
> detached macvtap or ipvtap queue from an attached one.
> 
> Cloud Hypervisor ran into this when checking queue state on macvtap.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tap: report IFF_DETACH_QUEUE in TUNGETIFF
    https://git.kernel.org/netdev/net-next/c/60b5268444a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


