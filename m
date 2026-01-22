Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B742E6CB8
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086208; cv=none; b=PGrPd6a7ticFEP3iQnGGU39yqjytKAgUAEXQ9UNRnXFulovltPp0ixdzZo4lGk0wrgXjptcfnx8pqeKL2qCLxrcW+V6DlsCjmmy69xmWGhcb2MZ13kC7DrnLzYoCFOV2ycz4GhpvrxBHh1oEzN85FcDSWXhWg1n6BCei2U8kT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086208; c=relaxed/simple;
	bh=Zw55jiD++xSJJrWscD7TtUGc93PiMEoWmrd6SdzU0wI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CJAU2X6gllSlYs6I3n6RyPtEAv4yon1BItt8LG3R1eNR87KLgqTNc0at50D7ScixkDGQ2+IiTCG1WFH+n8fEaNJWp834yoNMcOosbBux9IHEQQ4+G2CAggjbAmMS2b9pHrs5OqFGPS5Sv8cBhexEGAcpZajFUyeko26K+gW/VMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUUqnmK4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUUqnmK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA01C116C6;
	Thu, 22 Jan 2026 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769086208;
	bh=Zw55jiD++xSJJrWscD7TtUGc93PiMEoWmrd6SdzU0wI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CUUqnmK4O9qFMrdKsLVVHfVusoj+3urre04bFMfpL144YjiP3Ujdp5pfl/RiEJj7R
	 MnF+/8KF6BJVdGYAPu67hbN7b6ylW1U30ak62cmVVpr4disblUs6rpmYbJJlVJpT6+
	 9yKu80JN/UPCWNYLWKsWowsaRZlmWr/7ScodTuaijTBfVjtTU37xW6+jUgPApewwTu
	 3+qbOnc9ng5IDv4ziHwIHBLL10NQ14hJMUtoZZmsBi9S8P2l6XfNk/PcS8F/ROT2px
	 fiAoUZTJ+34bwrkDL2SYo8zXAgi6EDzZlTLgrYETQZMiki0HWj8hEtDnGu2xIMMTeY
	 72NjIg1vSzpKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB553808200;
	Thu, 22 Jan 2026 12:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atp: drop ancient parallel-port Ethernet
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176908620511.1708465.3359062090873691798.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 12:50:05 +0000
References: <20260121084532.60606-1-enelsonmoore@gmail.com>
In-Reply-To: <20260121084532.60606-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 daniel@thingy.jp, hkallweit1@gmail.com, mingo@kernel.org, tglx@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jan 2026 00:45:04 -0800 you wrote:
> This driver is old and almost certainly entirely unused. The two other
> parallel port Ethernet drivers (de600/de620) were removed by Paul
> Gortmaker in commit 168e06ae26dd ("drivers/net: delete old parallel
> port de600/de620 drivers"), but this driver remained. Drop it - Paul's
> reasoning applies here as well. To quote him:
> 
> "The parallel port is largely replaced by USB [...] Let us not pretend
> that anyone cares about these drivers anymore, or worse - pretend that
> anyone is using them on a modern kernel."
> 
> [...]

Here is the summary with links:
  - [net-next] net: atp: drop ancient parallel-port Ethernet driver
    https://git.kernel.org/netdev/net-next/c/b00a7b3a6129

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


