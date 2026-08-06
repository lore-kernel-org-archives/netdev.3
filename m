Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4D2E62A4
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015249; cv=none; b=c60BZlxa4rTx1pFUgOEGMgCBWhRJgT7VT3N1FVGW2Phhp6dg4JmDFIlcsM+5HBuV4N0I/6hRLXt1PM0Vaj5aEGJqMGodheDuLD3OuLp9mrjefR/4lH990fB+pdRfv1v/2hdcEvHxuIGZztE9xWNNi+c5Pslylfh9T3osiBMJOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015249; c=relaxed/simple;
	bh=YnjK2Y5fffdXq/MJXQCog2BBjcqIRpGAd0RnlfUtBWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kh5nhjiTB7jnL/k5fFqflh+rQd/ajdP/aCcl9Roe+j7ZgRh3kfXN1cWsFAu3pzKK6uXzohQRC2oXNhEkULbbV5W2ggZMi0Jj/E1FgiM+HSiPSe+m4R1d0vrTtJYvICBQ4NhbPw0i331Xwy2JW7UbCO7ONEMEgnE59q2Oo0l1EAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM2SXzXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM2SXzXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFBA1F000E9;
	Thu,  6 Aug 2026 11:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015248;
	bh=P6XSFh3edJYtvj74Y113GM7C2rRQDXcz04PFpM9eR4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YM2SXzXTrs0MRFq7AXWHxJdgKBAA9D+b34kPEWpyExIxGS/f/ViyOgWhaMVe8RaPg
	 P/WRoJzs8wAPRzi290cBgHffzfyXPzmrPTDrRil+rqzsPeix6fOkhlbinPgMuJfHeJ
	 RzskZO5m/5oJI6E2wwiWay3h1FC4ZMuWxIoqzCZjrqek6W0IE9aSU5sDgbh5JSV5DE
	 Xa5hGsVW53uIlFeMe1XeP3hREMD+6rCzfLUKK6nRdKs3tOMsOZwUANP0+X++n3WZFg
	 QY5PJngmrNAxbf3V4JkNRFHCB4YwjKudM75MHFlA3DIOsl3L1mkrvpdds/A4OiworH
	 LRNAaIBiRTIzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A57380AA52;
	Thu,  6 Aug 2026 11:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: remove WARN_ON_ONCE() from sk_mc_loop()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178601520714.790824.9012891459022097855.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 11:20:07 +0000
References: <20260804152048.2134341-1-edumazet@google.com>
In-Reply-To: <20260804152048.2134341-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+22c3218a6fa219e47321@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  4 Aug 2026 15:20:48 +0000 you wrote:
> sk_mc_loop() can be called for sockets that are neither AF_INET
> nor AF_INET6 (e.g. AF_PACKET sockets when sending packets via raw/packet
> socket over virtual devices such as VRF or ipvlan).
> 
> In such cases, sk_family is not AF_INET/AF_INET6 and sk_mc_loop() falls
> through the switch statement and triggers WARN_ON_ONCE(1).
> 
> [...]

Here is the summary with links:
  - [net] net: remove WARN_ON_ONCE() from sk_mc_loop()
    https://git.kernel.org/netdev/net/c/b8a39a09ae4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


