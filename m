Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B87277C88
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587814; cv=none; b=IM23raO1xg9Ig0CAz+3ml8/1Zri8i+oM9v89d767sV9YEBSi5OSHvDixIqk0HSE/7skqDQm6nlbnnyq84iiCWiemwDNb/eMPpN3NPI+0evc6q9WspnvW7B3YvkiIQeZKqF9RqcMjwdJYgC+C+GcDQl7bTeYzuea6w6uUDZnDd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587814; c=relaxed/simple;
	bh=IXTD2T2BlvDQ0PNOz7T9V9ZrH07e9rT5kipd5hiFPxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o0bQMAZLdAVYWPETiNmFChH2nwqh4O0yem9ri60wHOyWA7Ax510FoFG3b854s+/q7+kcsaOitsbrNsWfo4TMy4Y91MvuOin/iJu7a9Q7F/fj6PJr8ocIs3JHR3xMmsP/iAA2t+2z8BZA779yqzgEL0oD1uFoVpc1vuajlVlhuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9OJbfgc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9OJbfgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F064EC19422;
	Wed,  4 Mar 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587814;
	bh=IXTD2T2BlvDQ0PNOz7T9V9ZrH07e9rT5kipd5hiFPxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n9OJbfgctBUjcSFIMPhDSuAzMdGsyhGfgwS38RmTGkyXRzfuB44g4DQ3GteyKPsXt
	 LTnKRt+4zsAaE06z8DEuYGVmDPgQPAaudb1ku7bgAYnus4WdOUvu8sjVZIEBYDCi7s
	 JC88uEzSCEkOksgv6kCaKON6upopQqGav9MqWwCRE9c3h7kEvqoe0Sz7iRTOrSlFij
	 HV+9a3lKIYBEdumiQbf4kduU57bjN+BdDdELuYaP7CE8l80EG4B5MtWUe6bVp6QiKL
	 uwrh1x6KbSrw2zdHbTpvg5s5DqJnOhqZCE+LxbjlizrtNRquFAaSOgUY6MPA61trD9
	 zoSk1yiwWi2KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC613808200;
	Wed,  4 Mar 2026 01:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258781504.1546050.15599447015231829493.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:15 +0000
References: <20260301194548.927324-1-kuba@kernel.org>
In-Reply-To: <20260301194548.927324-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Mar 2026 11:45:48 -0800 you wrote:
> l3mdev_master_dev_rcu() can return NULL when the slave device is being
> un-slaved from a VRF. All other callers deal with this, but we lost
> the fallback to loopback in ip6_rt_pcpu_alloc() -> ip6_rt_get_dev_rcu()
> with commit 4832c30d5458 ("net: ipv6: put host and anycast routes on
> device with address").
> 
>   KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
>   RIP: 0010:ip6_rt_pcpu_alloc (net/ipv6/route.c:1418)
>   Call Trace:
>    ip6_pol_route (net/ipv6/route.c:2318)
>    fib6_rule_lookup (net/ipv6/fib6_rules.c:115)
>    ip6_route_output_flags (net/ipv6/route.c:2607)
>    vrf_process_v6_outbound (drivers/net/vrf.c:437)
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
    https://git.kernel.org/netdev/net/c/2ffb4f5c2ccb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


