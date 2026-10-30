Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793402419;
	b=NfDBdZ1Dw15DM59Ct9a3hOqdqCBqcynhi84w+2farqDPGdvmRcB29aoJkbXYqpkGgETb
	 KCVg2E2zH8gi3jN0HNtIjLKC64kjyZ1r/ttcu/DrEtXeuwoddauGwuAV6bnLZPmVFah76
	 5N7WDaRjeLRUy9tvbl+ciB6QgD1/xSPVtLLthMxZX1n0aKg2npxbTfpxoljejxg8CMqmw
	 uFON8+LC0BCpuCF2dGVqKUJ98IigCFjWaxdxV43Qe0lsSr42c0yQWFl1r/HDlw+OFW6XX
	 UZsLIOd5nXEWCrUS3JNPqMuCwRpBd9bY+YfR1pgfLMimw+aFZpLprtKMNLPcWNvGuMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793402419;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rWLDs8Ll8VxxTdLnS0gplBN94ZDg4eVJMaUjV0A4+AI=;
	b=S8CWwri02qdUImswuhE7VadFxnhrTZZQBo9A5eTFlwg6K3aBIjzFoqMs1nFp0ryIkIwv
	 xpbvJyBGDtVTsqbzgK4EG9YvwxYDcngPPw9Gi6ssKi9Bp6Icxa3HSaE+CJ6PpGYf7XkAf
	 SBywZjzXpAJUuR6EVZlKNx/wQYAgq03E8mFPWXSI6ExX564SHr9Q4Vnlvd0bk07etr7GS
	 ZG4xR/q65YkBdmWLN4iBfm+K0Q5nzs+T0y39VyneVXqxaefTFxfrBUhSLu6+LbSoOm7mj
	 sPB/cfNf8nYnf0ifLA/UblYwptWvayKjfgK4nmIOerhuJEkWkZwmtnSTS3zAitm47kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKS686O6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DD606A31C;
	Fri, 30 Oct 2026 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKS686O6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF7E1F000C1;
	Fri, 30 Oct 2026 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793402418;
	bh=rWLDs8Ll8VxxTdLnS0gplBN94ZDg4eVJMaUjV0A4+AI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HKS686O6aVxjwGwm/TBGgJbMPlvd/bpz9AIv/c2tW35dgbg4JguP5ZzVDbnLSL7ZF
	 hTVZkHaoGFzFr3wnRobPxrcLf4OK3Hejq9fQbX9Imb8X9U5L54jsO29tmpZ7AH961G
	 /5TYigKLOqaYD4kI7HhgB4IDDjfo0zDOFxdOa1sSPujzpZcth3hps6pFHZapBiQ3nC
	 r22dMHabrvqpKG7tL2by64vaDRDILJ0Zz+fJAceo4sjRYjJqPSMJAmkJ858MlrJSkH
	 MiFrxuCLxIK+ZQaAqCOGV6XUC8H7TiciionPn77a4vLViK4TaeIrIz/1hJJNoUklkz
	 AbTyn4QGhpEbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402213800478;
	Fri, 30 Oct 2026 23:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/5] ptp: make virtual clock sampling and teardown
 failure-safe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179340241708.1826218.11378651277022206414.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 23:20:17 +0000
References: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
In-Reply-To: <20261026-ptp-vclock-sampling-v6-0-e705612541f1@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, yangbo.lu@nxp.com,
 mlichvar@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 12:11:26 -0600 you wrote:
> Fix virtual-clock sampling errors, registration rollback and parent
> teardown in separate patches. Keep failed PHC reads out of the timecounter
> and serialize extended samples with virtual-clock adjustments. Also
> preserve the zero sentinel for packets without hardware timestamps.
> 
> Retain the existing cyclecounter mask, scaling and conversion windows.
> Retry the first failed refresh promptly, then back off consecutive failures
> while preserving regular two-second refresh attempts. Queue the first
> refresh immediately after registration. Prolonged sampling gaps remain
> subject to the existing half-wrap conversion window and full-wrap sampling
> limit.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/5] ptp: drain virtual clock sysfs operations before unregistering children
    https://git.kernel.org/netdev/net/c/0e4a135aebc7
  - [net,v6,2/5] ptp: unwind partially completed virtual clock creation
    https://git.kernel.org/netdev/net/c/3dea778260e3
  - [net,v6,3/5] ptp: vclock: propagate physical clock sampling errors
    https://git.kernel.org/netdev/net/c/d1bdfdafd663
  - [net,v6,4/5] ptp: vclock: serialize extended samples with counter updates
    https://git.kernel.org/netdev/net/c/d3fcce5afe3b
  - [net,v6,5/5] ptp: vclock: preserve missing hardware timestamps
    https://git.kernel.org/netdev/net/c/63787dfd1b5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


