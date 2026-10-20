Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522821;
	b=H1vhn6EN8nAyu563wGhBOeahAI1e+eGStZ6BNr+F7feXV2YwyuPigSP21MCmA0HvXwLe
	 4skWVI7SmVMHFGvWxGYU+uWKDq3C0snoMBmY+/XcexO4QoklKX7xGVG7LM2t3lmAThNVn
	 asfgd40aOz/+pg+VDpZP+te8Fk0MJBV6faTcUqKk6xEmZa+OPlviVF3i1+kOy/xr2XfD8
	 Y5j/EpsTN3OkUuvU6S7pCXp+UeHeT8JtvxjB86H1Pc7JJWivtWOis9knbdTCn3XxppCgY
	 VxZqNpPYzSDZ1thBYxG6uHZG+DCgEzpVZ/ygFEz47uTHHn5YezzmT4RbJ83/ZsMO74w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522821;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BR48JBBLgoT5Ab+WlGBsITJm2E+BPQLQTiC4wGtjjew=;
	b=qGaNLJS3zU63Z7O3Rp6T0yuDC0pNDexR7OdgYE71D4gi/LisEKPhfiMk+OxTVKZhcBKJ
	 EDhXG0dRMuYKuZH/bHrORgqUomWvqTzwYFFg/R9WBPfysGmZF0f063FWzIgpUzmInu2Ng
	 qqDOgHIc514E+58WbfxbumPQVgkAO4ZC7IQO/2UQ0zZ8/NQIpbZ3fYw3kp58Wo284NaIv
	 FltV/KnNuZYODeIV2kMlD5nfcoOBEAHxQ3Fxby/5bIs06jx8+n2Jjfv4vaVh8NU4MnmGw
	 jTnXpO0iF/wLGGtlnkhVDv3XYqaX5opGHW6+cAMVBW5uRZhfvFW/9oPXZMrv+4bko0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpzxDArZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE7B606A327
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpzxDArZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4317D1F000CA;
	Tue, 20 Oct 2026 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522816;
	bh=BR48JBBLgoT5Ab+WlGBsITJm2E+BPQLQTiC4wGtjjew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dpzxDArZdVKDu8g6LOTLWHomQqn7cV3zGmdfilHiG8Mw9Og5RyB2Rr8cYXeLGE5At
	 nU67dED61CSU71U0+9/j45Zv4fWR+11r7069anvMGIxOiP7Hg7TqVZ1NIhB5G5VCLX
	 De4IlApuv7I6cqX+d6aleIrhx/KokYUGS5tNObKmTeo6RCNBQK2GpZSzYfYwlbrb0M
	 n4LuKafOv/iFPVuvS2qTprch9KtoFA/I4g8ciNh0aTJfQiB2DA8PcH6yurjCCA9APf
	 1S0Zk/8t4zSomIFlrCSu31MPJ2nX6m6WUMPKnq8nehLs53Q0synTmCyacRMnlO/hTQ
	 8RxUVRR229pAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A34C3808209;
	Tue, 20 Oct 2026 19:00:16 +0000 (UTC)
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
Subject: Re: [PATCH 1/2 net-next] net: openvswitch: skip IPv4 later fragments
 on
 TCP/UDP set actions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252281478.159319.15440207107164273578.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:00:14 +0000
References: <20261015124749.4694-1-fmancera@suse.de>
In-Reply-To: <20261015124749.4694-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, jesse@nicira.com,
 aatteka@nicira.com, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, i.maximets@ovn.org,
 echaudro@redhat.com, aconole@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 14:47:48 +0200 you wrote:
> An IPv4 later fragment carries no L4 header, but key extraction leaves
> ip.proto set to the real protocol and the flow may wildcard the frag
> field, so validate_set() accepts such packets. set_tcp() and set_udp()
> then treat the first bytes of the fragment payload as an L4 header,
> rewrite them as ports and patch the bytes at the checksum offset,
> corrupting the packet.
> 
> [...]

Here is the summary with links:
  - [1/2,net-next] net: openvswitch: skip IPv4 later fragments on TCP/UDP set actions
    https://git.kernel.org/netdev/net-next/c/14c0350142ab
  - [2/2,net-next] net: openvswitch: drop IP fragments on SCTP set action
    https://git.kernel.org/netdev/net-next/c/4d0d8f491307

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


