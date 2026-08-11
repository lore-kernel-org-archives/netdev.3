Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7039383306
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411255; cv=none; b=CRGK9GrdZI+BRPULDlRDQMOePNqecSkoAFdanpfvk4L90DVsJwfcpAwtVPWXqUzoTd8Yf5Vjs2WQJ25mfeIWHEaQn+Zg7F31V4V00Cuo/I1MNSBxwX/pXhERsDEcukl2Efh5OWHqN1GiLVbW3BMNQcRFWT4HyS0xrfaJkZv9UhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411255; c=relaxed/simple;
	bh=hh6nZRKr3ydZoPONM2osm4yFrW198pOwFr7OARF7T8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vd/qozQf8V3oNMqcbS4oP8AQIz1A55WLn0lea8d1pBMS3braijb4c2r6tZfwJVAf5DinOX3sLYim7VZ8QsSoGNjaAI3RUHBmr9KjioAj1G8p+0Bx/G1+uYJ3mymr06xVcm5rtn0A6zfCNBbZ4zG5dvJVwm/4p5JEQTj0721YZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JskRlmTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JskRlmTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04D71F000E9;
	Tue, 11 Aug 2026 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411254;
	bh=KQCSGPCe863GTaKkArqT8D6szbZNQZEQgNp9t6YHGiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JskRlmThz48UMh5Xx3dGcNj8i1AIbKF16D6hZW9ZRBZIhP+W8WeUBlV3Q/HGwYEp+
	 yA3V3DmEmAu7OOB7YPiVaUUCwGJKzk1KPzIJ4vjlOQNrfCzW+hi+BDWDdth7P1dM4c
	 hdlaVf9mpr+I9Z2PFep10sDOkV78552gGrg3zN8do3+HyrzvQVrqEtBu9sXQSDlPaL
	 W7BxDmoI8/mg496t2YpOidJml9dxp8mU7HhHBdrAv239iFdAJ0Lbr7iLJwaaqUl/8y
	 Rkta4YIkfZETETS/n0UgRKe25huJWLLBtwfLFhy6VUHTBd6Qh6ufBZfUC4xyGH1bLB
	 7Hg+0/Oyf8/FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F9392626F;
	Tue, 11 Aug 2026 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: drv-net: so_txtime: only send test
 traffic to sch_etf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178641121088.284305.16852894884064829291.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 01:20:10 +0000
References: <20260808160129.890119-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260808160129.890119-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  8 Aug 2026 12:00:44 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The ETF qdiscs drops traffic without a socket or txtime. Even with
> parameter skip_sock_check regular traffic is affected by ETF.
> 
> This test ran fine when run manually in a pure software environment.
> But with drv-net across two hosts tests fail as early as when calling
> cfg.remote.deploy due to effectively losing connectivity.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: drv-net: so_txtime: only send test traffic to sch_etf
    https://git.kernel.org/netdev/net-next/c/ef3d6cca02c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


