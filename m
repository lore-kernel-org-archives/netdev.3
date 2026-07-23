Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B1474277;
	Thu, 23 Jul 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828445; cv=none; b=YcSzNp5Xk+xofF2lgN1sLuY4jruxXdBxt25HYE2d0BNaGWGW81qGg0yy9ITIuN2Hc9fk2+uSboilvIOMeoXEwzvJvyu7RnlRJ6Ic6SQ4gPY2zcNZplflLP24GuIb/jvyq3MS835U4cdMTXcccrJHAQDCzmnq+veMtUYDSGH4Fo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828445; c=relaxed/simple;
	bh=hfEGLJTLAsilz8yB30uUoE6bOgknk/ut8gljQTaRZRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q2JpTnVDlTrqqnbsr1bJYEufHHpHfVc/bB4hUm2mmOkHKzZA7MBPJZ/uJ4+3C0J9vEYV54Hg6MizY34NSrOZyC+x1RI39qR83dj9dAL6ARiB5fmHMoOgmhAF/mtJ2T92/PPnivZPt6ovP+v9e0Lyssm0hJp319QFLooEo++vbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqgaw8m+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqgaw8m+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9D71F00A3E;
	Thu, 23 Jul 2026 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784828442;
	bh=ks3XjigDLjDNzzBHGX8pYTQTuqiSLz5pQhjrPK9s1BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eqgaw8m+17xChGO1XWC9BCNO/OHwJRH8L+nu6FuqUikhnQ2P2NtzLKfsA7KuRi4mw
	 hqCY91P2WWp8CqDU+FXrioy8d2D5xJ7xJddd/tntDNJKlBVIorIjofXIlIrCS9YiNT
	 z2bruDbfG9P01TZGr4C0rzeUvA5tPBS7dCx7hfAqnbwjetOh4I9oMFT3wwlWfowUdR
	 X5N26tuKV1z9ZNMLoXHC8VGQSjmWgHAcMIG9MjO3GR6ZbYQHKi3B1hZnQ77qpdxmT2
	 dYfYPfjqrvsU7rmzmEl0RubLgGW976Eats5blHI4cVkAFVJl9d+sYRI3ULGXlnvJyw
	 wQ13ePAy2HGDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 600B139244CA;
	Thu, 23 Jul 2026 17:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] phonet: check register_netdevice_notifier() error
 in
 phonet_device_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482841025.2802214.8478969759815544733.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 17:40:10 +0000
References: <20260721093956.162617-1-heminhong@kylinos.cn>
In-Reply-To: <20260721093956.162617-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 remi.denis-courmont@nokia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 17:39:56 +0800 you wrote:
> phonet_device_init() registers a netdevice notifier before calling
> phonet_netlink_register(), but does not check whether notifier
> registration succeeded. On failure, netlink setup still proceeds and
> init may return success without the notifier in place.
> 
> Also, the existing phonet_netlink_register() failure path called
> phonet_device_exit(), which runs rtnl_unregister_all() even though
> rtnl_register_many() already unwound any partial registration. Calling
> the full exit helper on a partial init is not correct.
> 
> [...]

Here is the summary with links:
  - [net,v4] phonet: check register_netdevice_notifier() error in phonet_device_init()
    https://git.kernel.org/netdev/net/c/d1ff66b66151

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


