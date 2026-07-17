Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52348317144;
	Fri, 17 Jul 2026 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287835; cv=none; b=UtYPN/fmC884unJqQ+nGg9EI1xamJmdxPiB6fsCAFkkgb3Qefbd/58/W1mIN1CzTivIlOwO86tFqj/xsOlBbfK2Ddorw9764lnqJZfViHXy4ufCxy3/MZmxTFVDQu6hZXtuCZbxkk3ao8ZOIHTGyvgCfhRulaTRSgg4Z2f5RboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287835; c=relaxed/simple;
	bh=wMwnnwGb8Wm8scH0nvR9uIVH0QDM+dUHUZZBuP8LDIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tiWchW0VhtEeL1J+yn/PFcsq+zzgULOKhmHRXMxr93te3aMflSP67amBaNUJecyncC7V636q+qPRDbiV5OaAnc6JmbW9Z6itCSqLIu1Ff4R1JPQ9YMMNEV31crgG3+o4I9CF8T+mPxqstVMmqk1KQoaVMdr63ryeTyHpAikkJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grrg5HiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grrg5HiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE9B1F000E9;
	Fri, 17 Jul 2026 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287834;
	bh=YCfkMOd5RMJfr0bV0xFvuE/FsB0XTGwzYTf7dIbi1P0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=grrg5HiHXtEr5g3tEm6CIMU+UXuYgDJXks15CSxxPY2mtGjxcLTeALsLlXj7D86+/
	 5u0xvo0tqk8k2F+IBLaFgw5Tqg0C72BD3C2EQUpQlvjoEvzNHQpVc3cYKSLFYbAOn3
	 QhjvU9AiBhXvv6oZvQ5opDzRKDEFa7mMthfx8OFXKeCUoekUTjR75sC4HL2K2W00pt
	 7yKIfNVz3VI+2XnWB21bPoFFQG5Wvtqe92F4JL1PTLnJwO1Joo1d+TN5sACmG+bG33
	 DN/Z0j1OBb4Hx8ZWxCpQ3DAa3XJzM0k53ORrxiXMOvtwFkozDoNvVNdVV6xy1K6FvK
	 Zgef8eSiRMpLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08F1380CED4;
	Fri, 17 Jul 2026 11:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mpls: fix NULL deref in mpls_valid_fib_dump_req() on
 CONFIG_INET=n
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428780665.1678100.16947875908339713325.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 11:30:06 +0000
References: <20260711114958.1009619-3-bestswngs@gmail.com>
In-Reply-To: <20260711114958.1009619-3-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@gmail.com, kuniyu@google.com,
 gnault@redhat.com, xmei5@asu.edu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Jul 2026 04:50:00 -0700 you wrote:
> On CONFIG_INET=n builds, mpls_valid_fib_dump_req() walks the parsed
> attribute table itself instead of calling ip_valid_fib_dump_req(). The
> RTA_OIF arm passes tb[RTA_OIF] to nla_get_u32() without checking it is
> present, so an RTM_GETROUTE dump for AF_MPLS with strict checking and no
> RTA_OIF hits a NULL dereference.
> 
> RTM_GETROUTE is RTNL_KIND_GET, which rtnetlink_rcv_msg() permits without
> CAP_NET_ADMIN, so an unprivileged user can trigger it.
> 
> [...]

Here is the summary with links:
  - [net] mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n
    https://git.kernel.org/netdev/net/c/56d96fededd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


