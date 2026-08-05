Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455A39934C;
	Wed,  5 Aug 2026 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895253; cv=none; b=L5ZbwsfP5d5A3ybZaf0HCz0KyHwlOjvD7oIJR89qz6eKzeMd7L2ZGEyGP5JxWrKE/5HcABWpD1bmORltcc6T3IQ6Ox6ivf06Kvvv06YGvl5GBi1uZgE6WCW8AP3gajil+T5kwWYx6v0KbLJZTSLkIQ15riB3Mj90xKhy34WP7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895253; c=relaxed/simple;
	bh=DmVsiv+tSFv9CMTDxDlboykZNzn8p/vjDX8gWvgwmeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ODbAtd//wl5nPc3gU/YL4uPITeBh50wlsgM5Th0F2vwJocOptx/DNPniHW6ho0uvO73htu1d6OTo7eSv6VXF1VKiDT76PzmRQmsu+AlK6aZG9USeAfCh1d2GcZqVTxfPSpi8A4NQc+BQa8Nls0rQk2wufb2QvKqCOW3MCO/oItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs5ew/6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs5ew/6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AF21F000E9;
	Wed,  5 Aug 2026 02:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895251;
	bh=u+r0VuiMYKrU4ZQUcqVkPTKNhNmr/6D2CqrBJ5bL01k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xs5ew/6e6LmSsqAQehghlFUGtlbac1v99tjBgpjEgFumtuIDFi4Eqn2cjfT1e9rl5
	 9KdlxBnxOhVsb2x7izwMmax35lDFfkQQnUVzEGKUi+htRxLYOVkVJ5EdRO8AlYxex2
	 MNDhPVAUFPaVbpThp2m5fSJ3pQwaMs4/1YbT7zyQK7cR7EnyZ/UP8+vgm/inNNHsff
	 SmureWHcN3+tTEEKNZX6Zoxyv6SPrGPOWLsHnkP7xSyae0EZMUHnnxfmZEi01JXGaS
	 OM1eUICeDE4rwJJEtd1kYzKnJQTCte3fJEQBD6cNeCPlKSlD2MBHUMng4vdse3hr+Q
	 YLCEtqeXVAreQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D03926667;
	Wed,  5 Aug 2026 02:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: failover: check register_netdevice_notifier()
 error in failover_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589521165.3873994.10881764707390746725.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 02:00:11 +0000
References: <20260731030338.82508-1-heminhong@kylinos.cn>
In-Reply-To: <20260731030338.82508-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: sridhar.samudrala@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 11:03:38 +0800 you wrote:
> failover_init() ignores register_netdevice_notifier() errors and always
> returns success, which can leave the failover module loaded without its
> netdev notifier registered.
> 
> Return the notifier registration result directly so module initialization
> fails when registration fails.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: failover: check register_netdevice_notifier() error in failover_init()
    https://git.kernel.org/netdev/net-next/c/d13bb65dd2dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


