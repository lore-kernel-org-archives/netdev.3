Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC1255F2C
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312417; cv=none; b=LY/7AeGPv9jhLbghv4ubc50oYdz56vLwCK2wZ1xdh9R0NE6SOA3kNSyEeuMupc+FK3Q9N/aULFxYHPEF47rLLtAkpkqxkwVaGvgNlqvt7COb7ZvMZj5Nr2wg45tP0KNNbLl8M63rGRc3PnJ/Uin8dkD+BRhWq4Oq5HJKYXxQdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312417; c=relaxed/simple;
	bh=0h2brqm6UcFB9+XNfUP9L6t59QecqykUNMjttWTLIVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nrv5+vgbeiY87zKhTC6NHb287Rd38Lv5IpKXE/4IBqJNTW+MM6kHKzS8Pi7UTL09qol0Z16x2dE6LWVgBWTwwayyPX6D7esxGk0iUyhbTxjemisiYTThx6UEPgwdaih97Fevg6jlRd8W/R6fzEFh7t1b87aEZEaK2+MuuE+FIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcC7pzAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcC7pzAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A61F000E9;
	Sat, 13 Jun 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312416;
	bh=XTUM/NEUK8egCcyma1exCBdUidBx+9eNNS0ckpQbU04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BcC7pzAmp81W6ZtxQdpXUrZG4zFHp1K1snLukH8fdMbeQ32wu5ByxhVR3k9lNtwW0
	 IFPbEGoxNYcUSJnb52UMG2MoTGOMbAx73ZAjRZsB9wBYc9v9QnlAIVBpebq2PvbhIh
	 oF5tT/Hi/KUupnY2j6h5/PRD6oIjoHu75wtHRo8i5IN4OzXI7yk9qPk/QnHCoGcBfT
	 YRLlaIE1QCYROxMEgbTkBmbS2nujLZmjcIaaw/O2rTz9uilMoQkvLyNPKxVHZRbz5V
	 aLXF8YmE8I8ENwPchdpnbNkL8PTFZVlptkNXJLOJRIpukzwAo90T9RdTJhryy5QToM
	 3kdL6RaChooHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B7739E9607;
	Sat, 13 Jun 2026 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: watchdog: fix refcount tracking races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131241264.1315131.11092895992307738677.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:12 +0000
References: <20260611152737.2580480-1-edumazet@google.com>
In-Reply-To: <20260611152737.2580480-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,
 syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 15:27:37 +0000 you wrote:
> Blamed commit converted the untracked dev_hold()/dev_put() calls
> in the watchdog code to use the tracked dev_hold_track()/dev_put_track()
> (which were later renamed/interfaced to netdev_hold() and netdev_put()).
> 
> By introducing dev->watchdog_dev_tracker to store the
> reference tracking information without adding synchronization
> between netdev_watchdog_up() and dev_watchdog(), it enabled the
> race condition where this pointer could be overwritten or freed
> concurrently, leading to the list corruption crash syzbot reported:
> 
> [...]

Here is the summary with links:
  - [v3,net] net: watchdog: fix refcount tracking races
    https://git.kernel.org/netdev/net/c/8eed5519e496

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


