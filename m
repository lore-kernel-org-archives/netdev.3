Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3763A1A38
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425406; cv=none; b=cYVC2SaZ7WNr3mxnPeW7AG0DR5yqU+Np9rA1cdq97n4r1uEZD45UQ9aebTRurNBr6yiOztdYoHIcCAOIrVG7bTPg2IaKnbK8acAGyytCjKghj6xRyIDNwXq8vK5jgCsqTuSx6E91QgR0XEcLfV2F9zf4JC6kSTlgcn0i9J5J3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425406; c=relaxed/simple;
	bh=E2/ujE5lw+swq1oFQy0oDnJAsM2puGcPO3LO0jskCbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XedtYSz4gQenBCa7HoiUK/LJ2IHJ/qXiIkz5DSIM5VTkZx9LEpYghheL3QI96MODLwI2E+PFIwtJwze7o+G+rpkGBpTA3Duh73ZBuVYqqXGWH3htCg0pWODT6gzz2pkI83nBaHjEGEffRLwwC1w5e/zXGkBge5X+Jsfef7uB/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHQgS81B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHQgS81B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A11F000FF;
	Thu,  8 Oct 2026 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791425405;
	bh=8kVErmzKmk4v7aTZ5ZTFJj5Ll6FBd2D3NI7dtVhVjj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fHQgS81BQFetyrij0yDZl9DCPnOYgT+kzJBh4WVTQXJyKJGykkIX9VBtewSVLn5Ry
	 KrpGY2mFxgMIFtgHmsUvFGsdRuMoMLOi7vHo1YD2WpMJxsuhMR49+w5WyPn0gWd/0e
	 NhYvb7ZOdqcJ0tfll6jvrrWsohwignFwRFkvSI53VGKpEJlq+16nTWZQxP53K1hAD6
	 Tts3AZSwKLkeSAHnj1mgU6OUzQ3YG0WRxRQuqD4yGcD+uUnC3pBxHPcmdFKBAPwuri
	 of7riTGOhpLDOcLeeSrfwOBfknN6ND4LN57ElTd3I2flO/e0UtFld8z2bAQj00FSzx
	 4NCsp2qGkfW8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7740C3809A09;
	Thu,  8 Oct 2026 02:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-10-01 (igc, igb, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142540428.3771647.7325212273794142157.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 02:10:04 +0000
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 florian.bezdeka@siemens.com, meng.ding@siemens.com, p@1g4.org,
 tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 15:24:33 -0700 you wrote:
> For igc:
> Ding Meng fixes Rx hardware timestamp when NET_RX_BUSY_POLL is disabled
> by populating the skb hardware timestamp from the NIC's Rx timestamp.
> 
> Paul Moses limits timestamp-header stripping to the first buffer of
> each packet, preventing continuation-buffer data from being truncated.
> 
> [...]

Here is the summary with links:
  - [net,1/6] igc: Fix RX HW timestamp reporting when NET_RX_BUSY_POLL is disabled
    (no matching commit)
  - [net,2/6] igc: only strip RX timestamp header from first buffer
    (no matching commit)
  - [net,3/6] igb: only strip Rx timestamp header on the first buffer of a frame
    (no matching commit)
  - [net,4/6] e1000e: fix IRQ leak when request_irq() fails in e1000_request_msix()
    (no matching commit)
  - [net,5/6] e1000e: Fix out-of-bounds MMIO access by validating BAR0 size
    (no matching commit)
  - [net,6/6] e1000e: add system to disable K1 list
    https://git.kernel.org/netdev/net/c/1d6500523b8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


