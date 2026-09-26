Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676226B2AD;
	Sat, 26 Sep 2026 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384481; cv=none; b=utma6NG739ldffnZYgiOo8abe2Z4Q1EhofB8bjxaQdF55+lHeaVbBOSSFBi/t7kNp0Lonz982sz1F8pEUHY1+bD9VLzzLl9xbTnR9Wmujor3nKcVZW8kFs3xVmQvhh09akRy8krGazxmbqub20LJxFuJ1+MFWiQ0pDvxRhlflQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384481; c=relaxed/simple;
	bh=grMSr8bgKG8HBTbB5BW/Xd/BL+VPEx7QASczW6UXSK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e85xDMgU23KGLbxE5rSNXdvCXWSp4eBHkoeA2PcDJ/6AaxACuAAxPbFqff4sbkXNx4BUPZZXWfrydcELBSpeEGUdScsvPbR1Jm5vvPfpEWn1LmP0witDFNPu7jlahjZreGim7Boey5ePi6K58pu89bsWV9dnTLgu5b+G+rar+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gix4+yx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gix4+yx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5061F00893;
	Sat, 26 Sep 2026 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384480;
	bh=ahDzJDC191LmFiaVrjax+NZXs6944gARtjnRreqvMCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gix4+yx4gDS0OPeziaAhazqKojW0ux93b5A7XN1NAQSeyRiejFhl2T3stgzux2F2Z
	 maWhDHLEB0TLLicw0bl7gMBYz0prUBPMQX+4MaFHcMppjEl2j3D+UnpXiU85ZCvlIK
	 Vx5Er5KjojecMy8e37EUWu389C0ho6HTCtyPn2rswlJhpCFDAGijA50dqPxq8Qcsf3
	 RW785R1YCRCe76QuLu4PZhmdIdISoMgtRXEUqH5Vhk/UUl7B6YPYfJyzVkcoQ3F7oL
	 jytVhlFuzHAsH01xjXxoOgPCfDeUQn7lMYy0z1ws/XIX+yl9Swv+xoK3lj8CBF1kvK
	 WH3rPSZRvMR6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A0F3809A08;
	Sat, 26 Sep 2026 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: macb: Rework hardware timestamp
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038440765.3228201.6452750958839498026.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 01:00:07 +0000
References: <20260923-macb-hwtstamp-rework-v2-0-75c909b2676d@khu.ac.kr>
In-Reply-To: <20260923-macb-hwtstamp-rework-v2-0-75c909b2676d@khu.ac.kr>
To: Kim Wooseok <5mghybrid@khu.ac.kr>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com, rafalo@cadence.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, nb@tipi-net.de, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 18:13:24 +0900 you wrote:
> This started with two problems I found while using PTP hardware
> timestamping on a Raspberry Pi 5. A rejected RX filter could still
> change the TX one-step setting, and the PTPv1 Sync and Delay_Req filters
> returned success without enabling RX timestamps.
> 
> This series reworks gem_set_hwtst() to validate the whole request before
> programming the hardware. It calculates the settings locally, then
> updates the registers and saved configuration under bp->lock. With the
> register writes now in the setter, the two helpers are no longer needed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: macb: Preserve timestamp settings on rejected requests
    https://git.kernel.org/netdev/net-next/c/381cb968fa89
  - [net-next,v2,2/3] net: macb: Enable RX timestamping for specific PTPv1 filters
    https://git.kernel.org/netdev/net-next/c/059a5a238c22
  - [net-next,v2,3/3] net: macb: Clear SRTSM outside PTPv2 receive filters
    https://git.kernel.org/netdev/net-next/c/7ca3702d40d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


