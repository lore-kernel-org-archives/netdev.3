Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A136390981;
	Tue, 21 Jul 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660492; cv=none; b=H8m24TMwWXMvZvTXPbIuEb2K3gc2WnVW34rZ/3CMyfdrW/ykGJ89JnjutEAi+lKCif9KQ1FKhT8s93Ro+iXiegZbI3hy5BTaUmBLHiOwYrqmrkc4tAauXZdLP1+e1sDBD4oISbLXe1dLHir/vtC1vjQkhHJ+/7KqQQJtnIRYlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660492; c=relaxed/simple;
	bh=BWIKXELe+fHWof55jJxPwg5FrHY8ERjO/nJ0a/1IfEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cHCjh6q1I31Pw4ifwVxFyCA8UJ5geCsaWf6Dev+j1KsRvGrkkL8IBuXWNbAs9LctiT1F8NIpNz7lqNhafB5vOGu7D/XsBnJtn9QnrZIEDCtLbEDj9uQctPSNID5+wChLdXXFwZ2K3wtuSOO/pv73JkiDqrngbayQeg9yYRCI2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdZieI2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdZieI2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA891F00ADB;
	Tue, 21 Jul 2026 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660438;
	bh=lDtMtYjXd4d+jkaj0I+4zP0cOlL1kpND36W2l0LodnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HdZieI2jV9wmO/NH9Nx4gWGjdQ+Sdj9oxlAbwLhk0ci6b7TtvKLHqnpQRchTFkkjg
	 P5PxRuBj4psRZzliCBGZLgNZtkYoC+HN4V3sm5SLSPMgFdBuAO/T5h22q3/Kme/ndS
	 sLHrPJTbizlwE06PR8lpa8tGJdIEfBO8NA4nS5CYp+zxk6J7VGlqb3G1AITR5+WlwQ
	 RaAJKJ6Z7VoJCB1J7fiNGuHDq8qQwvz12wNa0+9oALO3egrM1z4/VDy/RbElQdaPvE
	 d/7cX0936mqpnnhZbIVElIX6SXTR7I0cNIPSqqFEmnIpR19ied9U8sIjRPRslx3oVq
	 Ne8S7Hf333S0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1993939253F6;
	Tue, 21 Jul 2026 19:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] tipc: serialize udp bearer replicast list updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466040764.954483.2357191864553594311.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:00:07 +0000
References: <20260716025203.9332-2-bestswngs@gmail.com>
In-Reply-To: <20260716025203.9332-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 tung.quang.nguyen@est.tech, xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jul 2026 19:52:04 -0700 you wrote:
> tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list with
> list_add_rcu() / list_del_rcu(), but nothing serializes them. The add runs
> from the encap receive softirq (via tipc_udp_rcast_disc()) without
> rtnl_lock(), so it can race the cleanup delete and corrupt the list:
> 
>   list_del corruption. prev->next should be ffff8880298d7ab8,
>     but was ffff88802449ad38. (prev=ffff888027e3ec98)
>   kernel BUG at lib/list_debug.c:62!
>   RIP: __list_del_entry_valid_or_report+0x17a/0x200
>   Workqueue: events cleanup_bearer
>   Call Trace:
>    cleanup_bearer (net/tipc/udp_media.c:811)
>    process_one_work (kernel/workqueue.c:3302)
>    worker_thread (kernel/workqueue.c:3466)
> 
> [...]

Here is the summary with links:
  - [net,v6] tipc: serialize udp bearer replicast list updates
    https://git.kernel.org/netdev/net/c/350e592ff4e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


