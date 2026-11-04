Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803213;
	b=iYPnjgKmprXZM/9GqNJDTF5D1Mh+QBvnkvCwkZWxqNhSf97MowiUtszEfLiStJITXJbb
	 HnoTgOHkAW1QzDHBvQH2N6amF4Rb9eD+0SgijuQhcr7XGcn27vwl9D6PEC5nvu3sJO1LP
	 q1bzF1uQVEL+mfJr4lxe5NSY+LFUHRnmhn9tfZkQj7VlUDaDBmrXNv6MIiHqFko2LaIrW
	 gDzJ8UVjavghDXJzOKhqhpncYYkmsOxXWsenEAzi4Ci1JxzlN1rTe1+6VcXhWdP1svmJV
	 QwwksePRcvUzxp9kBf2XbCAHWdTEcANDKfbrmBgLo/LP0OktHuKqxd0zpEDxJqnEClw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uVIibrXoqgbfpoXiz5uTNH0V8PLvHkZWNwUBnulrgQo=;
	b=H3AGwG/NBwhAAMGs0if0vQA6IMJhwDXtwIT/Rva/BGMB5JEjrh1ZB9i8IAAno+sK5gbl
	 DFRzC9jy+SOc/Rl9aRZucU9BsIpBHV62LDONmAybGwHy/njX2VD9XBX1g8VqL5bokkml4
	 l8YPOrA45ipStbmNam5R7WhCjeSnhbxsVTAbTP4/GHbWV0fNfYH1dG445roY6wf0oGlXc
	 bz4thO9KEf0WwgzVfW2qP2Ybau6rV07lbqCUT2m2y96Vtm7XB5rThlDDh+dk0X2jijq9g
	 NmvLwcLRKp8ZxtWtujzEn+t46yoCFfjYODHBIPhYycuY7rel5+7cXtkdyTN9kr3kAbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtlYS8Ol;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50283606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtlYS8Ol
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6161F000C1;
	Wed,  4 Nov 2026 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803213;
	bh=uVIibrXoqgbfpoXiz5uTNH0V8PLvHkZWNwUBnulrgQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JtlYS8OlyQMIh5mDa8L21xi5vdbCek/I1S+xnBk1TqkJzaPzz3JnzcqnNWRYJ6LoY
	 BywJA/JNbV6MIHH/YKbleZMc47u0tHjYCC7tGPKpk62Dz1ZahlItEp/ZMkoVdaP/Wi
	 fwWtM8A3uDJ9+bpJay3s6TqYt++aZBbNBsOer2j0NJU/YpaqldIdnFIthRB37FLHO8
	 Boc1Gc88ipIy49ze5D+YIkEBeR3KHn/pxIpY4dS+mLTWYsuO/RWkSTweQpJpkDM0qa
	 MQHfKwAEmsu6QS1YTTSc4woXcR1Q9GfZvGmqcVWgnEzjC28DpUI3PUsv5yFVtv6/m4
	 245o3I4RGSS2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0309639E8A47;
	Wed,  4 Nov 2026 14:40:13 +0000 (UTC)
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
Subject: Re: [PATCH v1 net 0/3] ip: Fix route leak and unregister_netdevice()
 stuck.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179380321180.2864866.16689876284637388238.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 14:40:11 +0000
References: <20261101064418.2055158-1-kuniyu@google.com>
In-Reply-To: <20261101064418.2055158-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jdz@google.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  1 Nov 2026 06:35:21 +0000 you wrote:
> Jason Zhang fed commit 0346ec2f080b ("ipv6: Prevent
> rt6_insert_exception() for dying fib6_info.") to LLM to
> find tricks to cause the same symptom:
> 
>   unregister_netdevice: waiting for gre6 to become free. Usage count = 4
>   ref_tracker: netdev@000000009652f190 has 1/3 users at
>        dst_alloc+0x14b/0x490
>        ip6_rt_cache_alloc+0x27b/0x670
>        __ip6_rt_update_pmtu+0x572/0x850
> 
> [...]

Here is the summary with links:
  - [v1,net,1/3] ipv6: Flush exception route while replacing nexthop.
    https://git.kernel.org/netdev/net/c/9401b428b5d4
  - [v1,net,2/3] ipv6: Flush rt->from in rt6_uncached_list_flush_dev().
    https://git.kernel.org/netdev/net/c/a0fe1a3f390a
  - [v1,net,3/3] ipv4: Call rt_add_uncached_list() if !do_cache in ip_route_input_slow().
    https://git.kernel.org/netdev/net/c/4019af3afd72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


