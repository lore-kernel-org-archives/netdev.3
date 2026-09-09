Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12D492E4C
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913266; cv=none; b=HrKoHB9pouyIXXLwiEtQ3ob5hLWFyxOi4kP9OYHpZ79s5lRhSunl+DWxPjyEeVU/BQxBs9VIovF+IXZAU1mG+SLUPLYH7+GsreVBFNkaTCZ0xG4OwQtJVhxFn0XOYAb0ENtyhcmMD/z9lAyhgzp+CsYHqyIHsGvKv8R1Z/ASZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913266; c=relaxed/simple;
	bh=/WVuRsYo1ZrvQ9Iw4tHd6Y/DEiL+b/Ru/7/BOMvbcfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lLPcaeXTu6kXBFF++jIlJMrpmDWPS9yaADgPA/cE3cHT5/DDD6UOaipSAsxSKZRllmZAW5ZaYCZB9gLjvp4W4I7jmvcD1Qsp9esAUaOwFXvRsw1ruTIy8XGf1nATu77NyA93ADN1LlAvKdOc1m8jgyZc2E0wkUQqxxICI7zChcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdLWZ8WY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdLWZ8WY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A9D1F00A3D;
	Wed,  9 Sep 2026 00:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913265;
	bh=gV+7gcCgMiGkTKPNe/8QDwcyn8UIYQbe/6+Hic6gJoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jdLWZ8WY/EJ/ZnZ87c2fP7vpn+aOVi+ttXr7vCsWD/UpDVW1aGmCAN4q0mtAdP2/X
	 fvdov5QTS5imwzmIhbhTAwh+kTew60pHQPcowDEJuizWq2pLxCgh+9HW8LPZEqy/8/
	 AdacGZ8nr8GnKMCTJnrvvJ7NXME2Ckqfc7FeLLWuTSl3kkt9YM+r8xypVR+BzHw+Z6
	 Js+adxig6Wl3PIcV5SXpfyCavG8qvUZEpuXdLLz1TrAQ68kKrx7c6krkBVCS8zci/7
	 E3E+ZK9eWyYorZGQ2t4cX6PTjnDZKIXmahOJH56LLkxDuBm0G9M5WLcztHTBWU8O+q
	 sR33Z5JXr+/+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B4380820D;
	Wed,  9 Sep 2026 00:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: null-check fib6_node before accessing in
 __ip6_del_rt_siblings()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891320415.76352.6857349681843603500.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 00:20:04 +0000
References: <20260904180645.706425-1-namangulati@google.com>
In-Reply-To: <20260904180645.706425-1-namangulati@google.com>
To: Naman Gulati <namangulati@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, horms@kernel.org, kuniyu@google.com,
 syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 18:06:44 +0000 you wrote:
> syzbot reported a null-ptr-deref in __ip6_del_rt_siblings() [0].
> 
> The stack trace hinted towards a null dereference of rt->fib6_node when
> fn->leaf is accessed in __ip6_del_rt_siblings(). With
> RTNL_FLAG_DOIT_UNLOCKED set, inet6_rtm_delroute() operations run
> concurrently without acquiring the RTNL lock. In ip6_route_del(), the
> route lookup happens under rcu_read_lock() without acquiring
> table->tb6_lock.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: null-check fib6_node before accessing in __ip6_del_rt_siblings()
    https://git.kernel.org/netdev/net/c/cdca92eddc02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


