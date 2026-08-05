Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067462E3FE
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891062; cv=none; b=cKB7N1XCvmysc2x3xJkNlO6B0SkuAfO0yG8BnjLUwXsGrRgFHIN5ufS6IfhnRZd9vE0oOPYl60tD4gLk2+hgScQGoiPRcvDoi/Nui9KyA507wdbRPMhAvoNmVsozE1rzl/xc30dVXWnJmXa7EFOtaPSBo3lnAyYr9PrTV+WIHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891062; c=relaxed/simple;
	bh=lAADE8VuurWP2p/0j/UkZj8ayn3RDEP3dF9Td88M6W8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GlCijo5Lq+95guJdaVZ3mEubOo8h6yT+VLU5/ptt7p1+wqLiEKCXeBblJs2ld8n+VTNx2znag7rnqQhvWa/xCpjlhbSrj5t0g5dSUOLIktEWR5f5Oxlk/DEmnoZg1/Nyk8dPqOhBgAtIHCk6EdkmzF8mHUMbbaWW/gCeyDBT+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFRyPb50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFRyPb50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C26A1F000E9;
	Wed,  5 Aug 2026 00:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891060;
	bh=nbEupwfBMUSmQus2ewTaG9cNBH0X/TbhlWyezZ3LP+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OFRyPb50uGdJqHXMCiyEzl6dSF6wcS5VOFxKGnkDu5XqLypl85hoaMLikfAEf4Xgi
	 EOA9rUu58QzMcs6EJwJs/83eIohO4/g7NWTPtQAveIIrwtyuSo+1EK4Q3w6pD6hBsZ
	 52/XUN9VEUpvVKWo2gs0qZgvVV0LudK0Iw12AFuhq+pmm6/r2kcSqHJ5Yx1fyp6qtk
	 9PPNIho6d1CG36xjhdCoLSdteVFDBZ+EbHkby/fyfd8TWTJadS/0yjmeJ4TcyAmahA
	 HQLcBRZM4JTA75732P7AvPq7UKvXg5RvXjZR23TQcKp1rcn4Uo1XhmRTWyuPZnfvcY
	 x7m8b0RYYeBhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198443926663;
	Wed,  5 Aug 2026 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/10] ovpn: add missing rtnl_link_ops->get_size
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589102075.3853342.15773461804873326335.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 00:50:20 +0000
References: <20260730094624.4102963-2-antonio@openvpn.net>
In-Reply-To: <20260730094624.4102963-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Thu, 30 Jul 2026 11:46:12 +0200 you wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> ovpn_fill_info emits IFLA_OVPN_MODE inside IFLA_INFO_DATA, but
> ovpn_link_ops does not provide a get_size callback. Consequently,
> rtnetlink's size estimate for ovpn link messages does not include the
> nested mode attribute.
> 
> [...]

Here is the summary with links:
  - [net,01/10] ovpn: add missing rtnl_link_ops->get_size callback
    https://git.kernel.org/netdev/net/c/6e9f539e4f01
  - [net,02/10] ovpn: limit keepalive values to one day
    https://git.kernel.org/netdev/net/c/935dc3bb20e0
  - [net,03/10] ovpn: skip rehash for peers already removed from by_id
    https://git.kernel.org/netdev/net/c/33ec10567fe1
  - [net,04/10] ovpn: rehash peer in by_transp_addr table on CMD_PEER_SET
    https://git.kernel.org/netdev/net/c/cc12f7240c8c
  - [net,05/10] ovpn: ensure socket is owned by ovpn before deref sk_user_data
    https://git.kernel.org/netdev/net/c/59aed1eb60d7
  - [net,06/10] ovpn: zero-initialize sockaddr before learning a floated endpoint
    https://git.kernel.org/netdev/net/c/3f012bdbabe2
  - [net,07/10] ovpn: hash floated peer by transport identity only
    https://git.kernel.org/netdev/net/c/b47a52dcd598
  - [net,08/10] ovpn: disable IPv4 redirects on MP interfaces
    https://git.kernel.org/netdev/net/c/0301aa324941
  - [net,09/10] ovpn: ensure TCP vars are initialized first
    https://git.kernel.org/netdev/net/c/4680c0ebd958
  - [net,10/10] ovpn: fix incorrect use of rcu_access_pointer()
    https://git.kernel.org/netdev/net/c/26ba17d84519

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


