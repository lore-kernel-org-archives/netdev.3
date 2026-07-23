Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94C48A8A4
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826674; cv=none; b=HeklvKYK/88eX60sJLZdHoz1CT8QwdvTX+fk40Nv4Ux27zOwnLCIu4LL8IPxXJI8P34FUCwnlnX55Y10/JAZX4wyP2RLwfMJFZgdtrw6/jglIBPPbAX1OWdPChMxbChy9s2D14e6NLBvq6rEUsUqfdJNgFEjXc/3bTNVzalmR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826674; c=relaxed/simple;
	bh=Xry1azhqCNgPwaiFi99rdrGUF+gLrTveRfMBDIqviAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QYDd60kTJwIosmdnDNuJGUCzQ7RBsQDfCulFOVbUOByA2PUlP0OMDayGOSKwJdT7EDGwpHoYSks9QXwb2DJmH0I99y9FmfmeUDi0rZnUswYkMoTymAdVrSXMS2rzi09pzzK74zlcUQ5PJL4ryFedeS6GcXPO/3cRlBBqwkfg+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPz/xQ62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPz/xQ62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A1D1F000E9;
	Thu, 23 Jul 2026 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784826665;
	bh=fV8lwhLnqEQUWned/YwyumvF++kHSIwrDKGrwYfvTbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JPz/xQ62C8aN8gvIt+KBPqKJ/aIRhu6hrrFfMOL0YcMmiM/DqEV45uHXIa+bRtPmB
	 aqp5j/HUJDBW5zRrt3Krif1wYS7nHrENNQj7c5P4JHguiV0NEkgNFhxIblGMNvoTfo
	 KTSA6TSGleqz6kz7zROrxu6vCLfPPyMMRThn2gyApVo1UXBPJc8F3TjgjAQBQlOy/t
	 8Cgb/KCy/nfsRlqbe8yO4G4RkNgYVygGZ1jY1A2jqAuQUHneo2KtFALobUtx3tQZSE
	 zSLOgL6TSuljr1ckwdi5dyFJ5z8NHvSIPBDza5gc6IUnkQHOHTWk9eIC4VNNdYhXj5
	 gt3cB+lI+GRWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B3039244C7;
	Thu, 23 Jul 2026 17:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] ovpn: avoid putting unrelated P2P peer on socket
 release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482661640.2789426.16690142104859181544.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 17:10:16 +0000
References: <20260720144131.3657121-2-antonio@openvpn.net>
In-Reply-To: <20260720144131.3657121-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, ralf@mandelbit.com, a0yami@mailbox.org,
 horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Mon, 20 Jul 2026 16:41:26 +0200 you wrote:
> From: Qing Ming <a0yami@mailbox.org>
> 
> ovpn_peer_release_p2p() is called when an OVPN UDP socket is being
> destroyed. It checks the currently published P2P peer and releases it only
> if that peer still uses the socket being destroyed.
> 
> A peer replacement can publish a new peer before the old UDP socket is
> destroyed. When the old socket destruction path runs afterwards,
> ovpn_peer_release_p2p() observes the new peer through ovpn->peer. Since the
> new peer uses a different socket, the function takes the socket mismatch
> branch.
> 
> [...]

Here is the summary with links:
  - [net,1/6] ovpn: avoid putting unrelated P2P peer on socket release
    https://git.kernel.org/netdev/net/c/b52c5103f64e
  - [net,2/6] ovpn: fix peer refcount leak in TCP error paths
    https://git.kernel.org/netdev/net/c/63bbe18fc030
  - [net,3/6] ovpn: hold peer before scheduling keepalive work
    https://git.kernel.org/netdev/net/c/a4710ae2e7e3
  - [net,4/6] selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()
    https://git.kernel.org/netdev/net/c/0bd9cfebc1c9
  - [net,5/6] ovpn: fix use after free in unlock_ovpn()
    https://git.kernel.org/netdev/net/c/e1ad6fe5db71
  - [net,6/6] ovpn: use monotonic clock for peer keepalive timeouts
    https://git.kernel.org/netdev/net/c/f7e6287ccd3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


