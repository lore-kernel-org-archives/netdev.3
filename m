Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290214;
	b=E9K1pFbDMheUxhaAULMjOt6Zyv3Q/KOPZviTFCxTFx891EDAoiNjayZ6cK8jx8y2U9+V
	 YSqkGiGuereSxKAHAp13Ttv1Eb9sqAjf6bTdWf8n3R8tqdYAwTLZmIDsW2casrjVSd8Lm
	 t+v/vUH5etslyzm7rvzs1lBWYDFQDsEx12F0mhhK/eQONmLB8U+V6PMKoQlo25bNwad3V
	 +4GojscpjgdBFQqh6dhsU6DHrFIi8TVezvjKsgTmWthdlHx7g2esSSJDnzyr5rCKFjsyN
	 naxpK0a1dh6u+u7Rl4vsxU5aXl44XIESfVf9e0zFsbEVINMD+/jF+wZVVHkzYqaYNVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290214;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yaQqJmE/bdN8+eGSGKklAuxZN+lw+10q8P+DbsBhiG0=;
	b=1cWP/rurA30GHheqPeEk07VEpKQCSSKPSZIwDB1Id0DuyOfnl/aVXNG41YIfVBq/qNgB
	 LrNDBzklq7mMMA7fdtHVCtwZj/YoirUhb10qUPPBSp1KTcQBMTbn7ouBZFF6SAv9sxrEv
	 9i7shoBrI2cR791VVzBC7XYAXlELZJJH94vxRdM+XNorcmlraKUf7NQYHm6i3LAcO0abm
	 Dzch0rO0RPHQaCBSNLu4NbQ1NAWoYCs+GUUGdLAuqTLQr/xQdOcqAYhTp8Fve0SCGl7Mq
	 JfufGI6GgmjgfR6PonWFQl5vps5xy5si8+vCDCZXU5ZSa4rrN8b43M+SwzdUdW467Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNxZw7qk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1E606A33A;
	Thu, 29 Oct 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNxZw7qk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A13E1F01826;
	Thu, 29 Oct 2026 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290213;
	bh=yaQqJmE/bdN8+eGSGKklAuxZN+lw+10q8P+DbsBhiG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VNxZw7qkLvYeobcQq/vEwy9kprYLkv8G74Sjg7gyrUwTaFkmc74vDZdfpm4loZXl8
	 JEJ2FeCWIyBzfKhGdO55ijXb7RRYOUWKKdzrnq2mHBP9ft797JnFs8WIwv6l8hS2A0
	 UUHaoNQfA2E68gPG8cIjPF6hxnf+Ujs2c5y8Le9WLhCSLGD3KHGfSbgJn3ffcmHwp5
	 t4iyc/Kx0pUjHNDl37IvOasdIgh0R4XWATRy2AHn+jRqcnapFB05HR4kz+TtujdufQ
	 Xny8nt3tCCNSCMbFGOmy0uJ/CJKJumSPQem8aJoegxd+9iH0vf6yPMGC+if3ow7Pbs
	 JKzHue8sSJTtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401C93808221;
	Thu, 29 Oct 2026 16:10:13 +0000 (UTC)
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
Subject: Re: [PATCH net] netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329021180.546068.16729568713969066908.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:10:11 +0000
References: <20261026221306.3151025-1-namangulati@google.com>
In-Reply-To: <20261026221306.3151025-1-namangulati@google.com>
To: Naman Gulati <namangulati@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 22:13:06 +0000 you wrote:
> netdev_wait_allrefs_any() re-sends NETDEV_UNREGISTER every second while
> it waits for the last references on a device to be dropped. By then
> netdev_run_todo() has already marked the device NETREG_UNREGISTERED and
> RTNL has been dropped at least once since the initial notification sent
> by unregister_netdevice_many_notify().
> 
> netdev_genl_netdevice_event() does not tell these rebroadcasts apart
> from the initial notification and sends a NETDEV_CMD_DEV_DEL_NTF
> multicast for each of them. At best this spams NETDEV_NLGRP_MGMT
> listeners with duplicate notifications; at worst the pernet state of
> the netns the device belongs to is already gone and the handler
> dereferences a NULL pointer.
> 
> [...]

Here is the summary with links:
  - [net] netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts
    https://git.kernel.org/netdev/net/c/fd0909e963ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


