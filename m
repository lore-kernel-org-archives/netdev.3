Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C2313E0D;
	Sat, 26 Sep 2026 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790385700; cv=none; b=R4H13BAXwHgcwKVln22WM9wKeKei6qwTSYsxHdQfTp+oNYgNCFCfjzt5aZPMyB0TxfpE3aGqwObBB5eCZDJl0/sCSqq2JMy6fUX82lo76R0gqLW18HUuHKUulAKi7tT+8pmK6ep/ew2jQuS5qTvy/5/nG+0K79QZTmRMgYyI+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790385700; c=relaxed/simple;
	bh=K9a096TI9BMR0cjFpYtTZnIDEdt7BdVvRXBvNGqcgWE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gc1m3gNsy0bw+7niEA55Gu9CNiiiPEaPt4GPognZ2LHywtNjmMMA7jBct1wMMTRN4yHLIoQ4XYcHl+MhYvymYoUE/bwWQbW/vPLAsk53tnXBEP9INtimPLoiQ0Vbdbev+ZePYOxUxWVuB+QweWX7FLnt2ztbGrbXwWQvLGlIq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6OpCqTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6OpCqTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1BF1F000FF;
	Sat, 26 Sep 2026 01:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790385698;
	bh=9SIN/IbXVC1+REPMAzc/D1V6Z/u2YqRBrSchrOoSHTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K6OpCqTtYfnqxloi5jr1dQN1o9m6SlEB+mUGkMVGlKUA1I9Yl/LFx7gXeDj3HwA6a
	 kInAuqen0SFp25Lr3+jPYO+YHu6boD+PEKAsFDQk4BXkiJLj1IEU9d+M0eFoo1xLpd
	 0Eud3T2i5mJA6mIP4npx9gNEiuf+Pe/G7ge0xPaC4tvpZmHMJetzkMAV771G/HYGpr
	 HNqdsTQn5VyodcCEgMu8RCj0o80qbYL8CqAn/WrpYyJ9yXRqlGbSRyNIlbLhvjMMf7
	 Bb0CB2/YVPuzG6smH9DenDVQuYD5Dh+9PORsl0yHAKmWGERq6UKesSFzaevfXzcwiC
	 Gxh8P9QRmJxvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B673809A08;
	Sat, 26 Sep 2026 01:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: mxl-gpy: add 2.5G for MXL86211C
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038562615.3233155.691949890011659834.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 01:20:26 +0000
References: <20260924-mainline-rouven-mxl2g5-v2-1-fc8367a4c3ad@linaro.org>
In-Reply-To: <20260924-mainline-rouven-mxl2g5-v2-1-fc8367a4c3ad@linaro.org>
To: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 12:48:18 +0200 you wrote:
> From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> 
> The MXL86211C also supports 2.5G via 2500BASEX, switch the config init
> to indicate support for that mode. Datasheet checks indicate that the
> 2.5G speed indication is the same between GPY211 & MXL86211C.
> 
> The same should be true for MXL86252 & MXL86282, those are not modified
> for a lack of testing hardware.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: mxl-gpy: add 2.5G for MXL86211C
    https://git.kernel.org/netdev/net-next/c/83cfac9d70cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


