Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181E23909C;
	Fri, 24 Jul 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931056; cv=none; b=Bb6jzhLsnMoIVVaFaj6EjsESiE5kOYV7gRYiou/XXKHtBABJQfk6nep1stdy9n+5ioGLeFSZDqRAguHV+tpMz9NbfdjzJK8r8BF8IfcMNH+DXiMnmUKokcpuUvVBnoHKn/b40xZXDUCxIV2NMNp56rJHe8ASF23nLayvJR+Vsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931056; c=relaxed/simple;
	bh=a2zl0n4ZcN2YeNrbtt8cfsk6uluDRrlvMPGk1EXXn0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lVJQsHYP+qV2DYqEaMmeYvE5GCn+VhRiWMLbJlozFYW4GXLLuhX92ujVMjpYA1vIJEBsDuqOlDicewdN3ZYLs0LimkPqJb1sL1Rx0dztjYOL+gzwKrQySsn/mnmqIXAECFGQlP9SjP4Wz89C3CgkeuFD4rTJXXtiq2bYdJmO5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV8iBz8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV8iBz8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20851F000E9;
	Fri, 24 Jul 2026 22:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784931055;
	bh=mT+gjYgzMIInIebQz6S/F5SqdTOcOcDVDgaACywLw+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mV8iBz8uVQ09EtCWfm0L7BJNAthojeK2NX4d+iY6As6P2n1RyY/XEWim7nD0ZPugb
	 xz4aZ5pM4jYolggew62Pc+CB0pZOhSMWr9kJW6c5frUuTSHkstEgJW9dO7fIiiqJ/V
	 bgGegLWMQImlS3iaOuZvxWM6g7COuXT7AobdkvbaKuRtLZZcwv1LjwyXwWlt0delPp
	 xr57YFA4xce1ahL6l0Rw5O2QeITyPssKiiuY3yZO0EdPgLZB3Y83e4MoZ+SITQhJPM
	 iCtN0MM1sran/TEKwx5GvjjEUN5JNc15qlTcVDYg7ypVqwJdPiMOnSg15JeRGOcGmd
	 mSbtyQ+2nVQTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56ABB38111D7;
	Fri, 24 Jul 2026 22:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] nexthop: take nh->lock for f6i_list walks in
 replace
 check and notify
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493102203.3330129.7311134539620710020.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 22:10:22 +0000
References: <20260722002951.2614721-1-xmei5@asu.edu>
In-Reply-To: <20260722002951.2614721-1-xmei5@asu.edu>
To: Xiang Mei (Microsoft) <xmei5@asu.edu>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 00:29:50 +0000 you wrote:
> fib6_check_nh_list() and __nexthop_replace_notify() walk nh->f6i_list
> during an RTNL-serialized nexthop replace without holding nh->lock. IPv6
> RTM_NEWROUTE/RTM_DELROUTE run without RTNL and mutate that list under
> nh->lock (fib6_add_rt2node_nh(), fib6_purge_rt()), so both walks race a
> concurrent route delete that unlinks and frees a fib6_info:
> 
>   BUG: KASAN: slab-use-after-free in rt6_fill_node.isra.0 (net/ipv6/route.c:5799)
>   Read of size 4 at addr ffff888014607e64 by task exploit/143
>    rt6_fill_node.isra.0 (net/ipv6/route.c:5799)
>    fib6_rt_update (net/ipv6/route.c:6412)
>    __nexthop_replace_notify (net/ipv4/nexthop.c:2542)
>    rtm_new_nexthop (net/ipv4/nexthop.c:2554)
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
> 
> [...]

Here is the summary with links:
  - [net,1/2] nexthop: take nh->lock for f6i_list walks in replace check and notify
    https://git.kernel.org/netdev/net/c/072cd1f21819
  - [net,2/2] nexthop: avoid unlocked f6i_list walk in nh_rt_cache_flush
    https://git.kernel.org/netdev/net/c/4787a6d2629b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


