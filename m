Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DD3A8753;
	Tue,  2 Jun 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436415; cv=none; b=AgRhtmujFq0cV59f6MDjIvQVs+0YY5W7kR56hpAY0h6nrdOMkgSQ0M61rMpaEtQmqfIKoRLWRQgVifP0PWOwyvFEpgyGlFOosCt1+e8SssUACuuBSHLARoE4+5Idc77E6FUMzVphZyehBihBEiBSmny17Vk47amH8bbH8rn17C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436415; c=relaxed/simple;
	bh=5HUk6blmTY6B/bShtSvIOr+0Aby3IZOGBHmNvv7wf98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s0vz2nc1uUhaPZoA3TPPhDd7uGz2QUfa478WIqWp9OSDChdZZOmPWa+yALjF0Jdvca5no+g0dQXpssz3ZbN3IEoeY68paIcZIN2l1/G/sL3WAz1/dPNY7Gy1CIyB/W9s56GRsr7vO6SrycXof+kH/MXOsER5KiZx4XwtufCsadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crg4Kqu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crg4Kqu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BBC1F00893;
	Tue,  2 Jun 2026 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436414;
	bh=8RgbgMfwdXrAAR3pXWOtWuberCOF0K1N076X/OPErc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Crg4Kqu1hTcwqNT33LbOBGp/EDpI38uWS2pyOtuMn+AsQGGGNqyjcRYmOJO3gUzFJ
	 XLd6fra18lbFkYVurR0rAT+pZ29PAszjleZR4TyAFkWZCF3zFjOlOQKsiGW9souyZR
	 74UZ2RY8iquq22vCfkSBmUHelneH/3Y+3FW2VCM8/7Gkm7O/54/Z/UgiXkQ3Z1hB4u
	 WX8cVivn35Q3beAI9G665PeWxy6hpi9uDT5lZbaw091svRaMd4d33sLktUE+5gJGgo
	 T2fRRBSngtQAB+TNeYCkgIKr+D3vmzM/tYxgb9VPErW5xY1PeVOGVurCgwjcS2gMPm
	 fAftxnZMRQjUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990C3811A76;
	Tue,  2 Jun 2026 21:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec_mpc52xx: add missing kernel-doc for
 @may_sleep
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043641564.1060922.9321127831202168625.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 21:40:15 +0000
References: <20260531000042.369043-1-rosenp@gmail.com>
In-Reply-To: <20260531000042.369043-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bigeasy@linutronix.de, tglx@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 May 2026 17:00:42 -0700 you wrote:
> Add the missing @may_sleep parameter description to the
> mpc52xx_fec_stop kernel-doc comment.
> 
> Fixes: c35a0824e88b ("net: fec_mpc52xx: Replace in_interrupt() usage")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: fec_mpc52xx: add missing kernel-doc for @may_sleep
    https://git.kernel.org/netdev/net-next/c/d20687818f46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


