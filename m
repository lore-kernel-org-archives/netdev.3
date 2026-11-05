Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887213;
	b=eU0vOB2Q77en/OyXqlV2hQNY8hn+UIyr19kbtdtf+3EdxWWwqi8+Zu/B/Y4H61xJbhvf
	 LgRPjemm5llLrOrEFyGBhCDr7Mzu1ABaXkVCLybZ6mi90Y11B5aQjXQwKvug0tLCMe02y
	 Xch1MOAjUdgChzvtCvcGK/7u6bAfQTyJX7vW2LJtSqX6OvFEmDDdcPXCQxfAWnkCK6uk4
	 xzRn1lx0fk264+K7JUPPMUfoKUqSS307Is6OVFVqe1uOQjBlMS1+JysSZikbj3CeY0F4K
	 QesYaBTWp0AGszBIk3genrWSRpM6OWM5z0p5IcMPlGhTddcAQC9mwWZZmDgHS/YdKAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Wbz89TKEx262rwj21tXM8dzwd8os90vJZRvRJAR90DQ=;
	b=0DPzdIEIHi/TqTzahXYb8opPwxl9FvJFrER5aOwG8WQWl8bTTXKgw6xeuF2GGQ9mDxq9
	 rIpqDLpIJvNZqnSgr+Gi5MA7f/2lN91CuDpeYm6nklhZ7LTnqDA1v2bNCkiTcFVvwsHS6
	 +5CWXUhJE0zNMC3Hd/SMfjV3jYoRIA/BbMe4cwBX5lusLoPLubtgbnZHYLT081E6aLkwr
	 aNtb6SDHJZcK3hf409sPblA6Xi58Y5SDhdlQjUwyBjw2R9I7pWgOgPwyJ2Uo7W1slFo8O
	 BwmRM8XiBSGoB4EXXsmdaP0Tn+S5fQ92KVtnFcNCT87jcU3/29xEzfwXBT6JtcGTibQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyYcTkLC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592E606A328;
	Thu,  5 Nov 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyYcTkLC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894621F00919;
	Thu,  5 Nov 2026 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887212;
	bh=Wbz89TKEx262rwj21tXM8dzwd8os90vJZRvRJAR90DQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SyYcTkLCqxwsHDEUX9fa+uTYAlShsY2XTG0LxNcdjPfAvYnE/v4yFdgg4MvTZ/r4s
	 GvvjBLzBu1phRsakHumHhW2+iMK3KWNXJgNEETSyneQ9eYcUWWW/xHodCB/cRL4aF4
	 3R7pFXpKqOOZPQgp+sWDIYS7qAyicpIFK4rs0BuR3VttvyS354vFwBWIwJ2g9QoXf8
	 ow7EIZMQvl1NhpgP8WpuWb5MbXsTPtbyn6GyscFALozvoBIWW3CCsJcJLfCaxbOjpc
	 HFkVO3iZn/+p0iSmxVtxzm8maJXt6F8QrmL6+PaJX8+3kcN9JsZiPvvRcGsx/35xPo
	 /WWKPgtJfUD4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2D0391AF93;
	Thu,  5 Nov 2026 14:00:12 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 1/2] l2tp: ppp: remove unused backlog callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179388721117.3722597.3147877095658047375.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 14:00:11 +0000
References: <20261103055614.3729-1-qingfang.deng@linux.dev>
In-Reply-To: <20261103055614.3729-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaolinkui@126.com,
 netdev-bot+sashiko@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Nov 2026 13:56:11 +0800 you wrote:
> PPPoL2TP sessions receive packets through pppol2tp_recv(), which passes
> packets directly to PPP or queues them on sk_receive_queue. No receive
> path queues packets on the session socket backlog or calls
> sk_receive_skb() with that socket, so pppol2tp_backlog_recv() is unused.
> 
> Remove the unused callback. L2TP/IP control sockets retain their
> separate backlog callbacks.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] l2tp: ppp: remove unused backlog callback
    https://git.kernel.org/netdev/net-next/c/7c43105da5fc
  - [net-next,v2,2/2] l2tp: unexport l2tp_udp_encap_recv()
    https://git.kernel.org/netdev/net-next/c/ae54bc28fc9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


