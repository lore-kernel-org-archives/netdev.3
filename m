Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100127B340;
	Wed, 30 Sep 2026 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728209; cv=none; b=mAmVOx+mBgGiXeqkgLTsdiYunnJYvWmaGLEnVOWkJ7RAu9m7xPVA90UWU5o+nnJTY7vaLjWRpBcA4aJqpSkaQwyIB0D34PlSJ16+eibCWUqqyEt90yxx1a1o5e0juEY3y9fuLOK1YP28yVh7JbrpnpjlVhZ47wpbqJMUtG/8q1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728209; c=relaxed/simple;
	bh=U3w4dJZpfAdF/ZE9SbdIy+BgYfA483dDoL7jUvlGeUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mZTPy//h+REIULvBmlj6n+1YmDBCIfzYH6VoHwp2rukPmdNQjva4QZlz3swqWZB5qhGu03ShgY/6CleNbEmOidNEqj/gQauGE4aKA05IFlRIWfv8ikOSOutNWDErfIlZq1PYPIHdX+Qq4V2uG0uGhx90f9GtbJFiCb0OME/VFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHxtPu+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHxtPu+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4399E1F00893;
	Wed, 30 Sep 2026 00:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728208;
	bh=MhgzUmfULpBYvjMGgC+stf/aMprvJS4nFS3FZ0ZX3hM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RHxtPu+i+a9KVBXPRT0ObVonJ1zTCUiBTbm5Blz5AoYs8wR7FaWFHNGlCtl0ewp5+
	 6pH1oot17Dt2sYx6imefRBlk1NaMg948LpkhuEJ0I2z+IJ06G2sWbiN4S1OixgkQHt
	 Sa0E40RWZty94MCAy0LAV46YpjSUYzPKI6e3U3wYf0fLMXg+9PHpS+F5VRFbYn6Zbg
	 vyefmCPwDg8MVvIR2skBGH3VV8cX99lnIUYDsYJ4S5h/tqHW/FY82dMSxjg82fJjam
	 NoO8cuxQ/Yx3RuF7SXzeoGNOsYoQZ1I3fRyJydvypcAGoUcZly/DgE8CNXpxZix95m
	 jtkS8ELEL2/Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A51A3924FEA;
	Wed, 30 Sep 2026 00:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: fix NULL dereference in set_coalesce
 before first open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179072820677.1181068.7188904034956035359.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 00:30:06 +0000
References: <20260928105642.856210-1-nb@tipi-net.de>
In-Reply-To: <20260928105642.856210-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 12:56:41 +0200 you wrote:
> The Rx ring priv and index are only set in bcmgenet_init_rx_ring(),
> which runs at open. Setting the Rx coalescing parameters on an interface
> that was never opened, e.g. "ethtool -C eth0 rx-usecs 50", dereferences
> a NULL ring->priv. The oops happens with RTNL held, so networking
> stays stuck until a reboot:
> 
>   Unable to handle kernel paging request at virtual address 0000000000002788
>   pc : bcmgenet_set_rx_coalesce.isra.0+0x10/0x88
>   lr : bcmgenet_set_coalesce+0xe8/0x180
>   Call trace:
>    bcmgenet_set_rx_coalesce.isra.0+0x10/0x88 (P)
>    __ethnl_set_coalesce.isra.0+0x490/0x570
>    ethnl_set_coalesce+0x48/0xc0
>    ethnl_default_set_doit+0xf4/0x230
>    genl_family_rcv_msg_doit+0xe8/0x160
>    genl_rcv_msg+0x220/0x2a0
>    netlink_rcv_skb+0x68/0x140
>    genl_rcv+0x40/0x60
>    netlink_unicast+0x338/0x3c0
>    netlink_sendmsg+0x19c/0x3f8
>    __sock_sendmsg+0x64/0xc0
>    __sys_sendto+0x124/0x198
>    __arm64_sys_sendto+0x30/0x48
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: fix NULL dereference in set_coalesce before first open
    https://git.kernel.org/netdev/net/c/19419faf58df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


