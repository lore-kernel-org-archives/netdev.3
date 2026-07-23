Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251544E64B;
	Thu, 23 Jul 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823662; cv=none; b=RgV++y/meHAcKcZZGXPrVuIbpRwcsVYeNLqGaELqq99WUSg0shmeh7Yw6zUbPWn35btn3QacU08lJq+QEdtr8+MOmiMgiSrxvl/BpvxuOnqStM+7atj3DuAzpVUGeZGK0xNMRo8c4pkyD9nswQEOa18xll9K60FJZLLN+IXWIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823662; c=relaxed/simple;
	bh=Qjf5bCIrkX30ASjezOBzK6RFMBIZ0W5mZoS/zrTjL9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ozAFWDdZKp+c//DpiIuQwfVQtsndFpf7CdjSF807WyYCD9n9CFbmP5LJZZtx3QrNszG3Dhlo+qszI818ElOJMKvg36uFz/Rnt21kmOudXXN1jaxyIiDsff+rkpZjUT/cs6dDjB0V/AIRoNxYiUkJuWsyVsLqs7PlMjGKt1J0XNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt5w+CSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt5w+CSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A031F00A3D;
	Thu, 23 Jul 2026 16:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784823648;
	bh=/aHQnZYMVwDJP0Wv89s+NFe3qkGpPJd0uFY9eAqrTUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Gt5w+CSBflS/jY/GI9QD+VqH6oC0N+KDec7Fg3XH/L3/glyZJYsZIAfyC9EUZDwtA
	 NgcYgM4wwwWHmPUqPczdw1pPWfnbR8UoOdO8Dh7UyqafhO/KPXuYqXIqLUUQAbdkij
	 3iYI05XKXVnsaN4Ic2NUROYbv5zyAukTvGTzBgvRcedv2dK4Vvx3+YQwf5eIhUVjWC
	 wGsTvliw61GtXZDghktiX7oKIJtcnljV0+lKO5fu/iQT5j/JBQrNq8l7Z3dOYrq8cR
	 tmBZT2J7zurMSJz9P9pSMmN0JArotQIIgQCnZkumrAo3CifvRDqDBwbvzWhT5A9qKd
	 JgOdydMWrW9jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AF1392447E;
	Thu, 23 Jul 2026 16:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v1 net] ptp: netc: explicitly clear TMR_OFF during
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482361289.2769750.11191675161835921315.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 16:20:12 +0000
References: <20260720012508.23227-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260720012508.23227-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: richardcochran@gmail.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Frank.Li@nxp.com, vadim.fedorenko@linux.dev, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jul 2026 09:25:08 +0800 you wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> The NETC timer does not support function level reset, so TMR_OFF_L/H
> registers are not cleared by pcie_flr(). If TMR_OFF was set to a
> non-zero value in a previous binding, it will persist across driver
> rebind and cause inaccurate PTP time.
> 
> [...]

Here is the summary with links:
  - [RESEND,v1,net] ptp: netc: explicitly clear TMR_OFF during initialization
    https://git.kernel.org/netdev/net/c/c3f2fc231a39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


