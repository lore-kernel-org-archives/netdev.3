Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2219E97B;
	Fri,  4 Sep 2026 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483077; cv=none; b=qOG+WxB31lrw6uQHYTDYk0k/RCwhhILx7KwTzI5rASNHB6EFq5A+ff6ac+Iw80qLaE4+ibtBR29YP1vXuZ4rXDVuK1ckyLf+z5PAwvNesOv53QXP3GzVH7C4IP8Q1QcNFFL0hISwKfYVQcM4Yz7MhItIx1Kh/yX4W1Mjb/KPVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483077; c=relaxed/simple;
	bh=SxGgGODEQfIdV2f22hrGwDXTMdoQx6G9Xl+2y7jqryY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=auW32+/j1TK9yYvL1JF7uEGFdFfbuGYkcUXYoXRTSNJH9L++k39OKRK3U3BxMkZkGdKBkz/oky3fRSNWli1dGVT/P2Ii/WFoxW3gS89OF8WpxWzuhor9+eqTYbLrf/OErF7pADrVLCK3pfqNDVKUtOi3ab/KjGtBORk7JCzAjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3+Hfiwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3+Hfiwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB911F000E9;
	Fri,  4 Sep 2026 00:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788483076;
	bh=Yc2ZCRcIvOwvg2IQvY2wSd6WbQCz/OHJ3p0yLZ35WXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N3+HfiweYDEbX3PxWz4gK+1AsXYl71Q73VXZHNiNqAxN0+JQB3ue9X+AXkm5/g5PT
	 g0B/Mo9neLGZ99/Avj+bPWW4obFiuPH5c1CoAkXrtX695f35J590i/CBdkSBDPGMvU
	 Ss9fxM0ypM4ogc0HMzgqWaKOraZWWn4o549HuU/KAa9z2Hrg4XM7nCnUIO2cWlxkB/
	 c1R9KMT6tczyOdMwSh9zp0EB7QoJ9fAkZmvZdzJBOqogcTzTRRbwq3nZGeOSfCIySW
	 n91MSJHtyalrE7//Am7HlETz63UnkZqCtM+D4ut2i1VLUZtRO+XJjl6PfNBMobx800
	 XeHr5QtgKs3ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4938119E3;
	Fri,  4 Sep 2026 00:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: openvswitch: don't schedule rebalancing if
 there are no datapaths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848301722.4094353.4725518207988075715.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:50:17 +0000
References: <20260902203200.1416026-1-i.maximets@ovn.org>
In-Reply-To: <20260902203200.1416026-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 22:30:41 +0200 you wrote:
> During namespace initialization the masks rebalancing work is
> scheduled and automatically re-scheduled every 4 seconds afterwards.
> This is happening in every namespace.  On a large kubernetes node with
> 500 pods, i.e., 500+ namespaces, this creates a decent amount of
> unnecessary churn scheduling 500 jobs every 4 seconds that take the
> mutex, check that there are no datapaths in their namespace, release
> the mutex, re-schedule themselves and exit.  These 500 unnecessary
> mutex locks may hold off operations in a single namespace that
> actually has a datapath configured and has real user requests to
> handle under this lock.  They can also add delay to removal of other
> namespaces as ovs_exit_net() needs to take that lock as well and
> synchronously waits for the work to be cancelled.
> 
> [...]

Here is the summary with links:
  - [net-next] net: openvswitch: don't schedule rebalancing if there are no datapaths
    https://git.kernel.org/netdev/net-next/c/6ebcf5074cff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


