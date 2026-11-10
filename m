Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279314;
	b=oaZ/5K/9ikYAMxMOaqkViqW9jUU0X3C0DppEN15rvxMIMwCaTS2o3j893MuloVTX8QSM
	 0YMlUOMy+K4g5gR93bSUSqNmq9gWwmq2V33v02N6KP5A4f8lHvDtUqxiECbtCKeNgFZhG
	 daZJKre+Oi2tGJUTnLxBTDsviJcItyF6cz58cGzBOG431fKILxHcGS7lvCrw2rHIX9Nz0
	 3kTUmrKjuRWc2MXSHEvqr1/rhWPfYhKbyllPAWaqx0RBvwbUGJUSIz2iQFzoWQIo59Tah
	 5jsbwSHA4zS8kpS05FZ9OXDllRWHsfJYKyTUrcGSKw92KGhOAVxcC66tEmQV+2+a05g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279314;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9vkjXGj8E1tCNlK6OgtPkP9eLc/ViU7DdLFLKuqN8to=;
	b=241YIqYBOfBNuBsVmEJmOxBbt8e6g9plopJb8CPQk4EqJmkdJWmbP1ll2YYvJ6CxtrYV
	 g/mQVApxtSQ8AuQZquDRBkz/qNSgD3ZKRx7olYKmi4TKqF3K17C6AxI6WVgafkZqNCvbQ
	 pOGdw5AYZBw4B8NNGf5mk6DvRDrC+SezaxslcQNuXbLB286V7GHw0QcPNIzMIscR7BjxV
	 vDC9Kf3L5bQ4coAg4r1QY8IrOs10kznObXgWogVjue8E65lLajLprf1d+SA59llHyKEPC
	 HudeVWaSSUAAn90x/BmVhXVnZIdKKm4HRpkR6x1k+Vz0EXEWQUi5fug1gg7E3cBOSfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUAEMr8b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1951606B0FD
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUAEMr8b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFAF1F008A1;
	Tue, 10 Nov 2026 02:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279313;
	bh=9vkjXGj8E1tCNlK6OgtPkP9eLc/ViU7DdLFLKuqN8to=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cUAEMr8b64rh70D72PomBwr2MzTeqij9ATCHIUOQjtCMakmsEPqsJM0WwmXG4SyhW
	 76okAytmrvxTZ5H1/sbDr2i+KgoJyCHoamNjilRivfJt+RbbBvdIS8jff+2e/vF6S0
	 +BJw2XZavkKKfC6zTcMWq2iUGAbN57m1untgackBKVzNugZQUMhQqUZb9S0ShLF8LX
	 k88qaIGyJsyj1lYsO0CKNzGFukK8ZV6oEwkysiNx15pnWDCyHAaaKOyu6a8Ns6xpBm
	 dtFG21iX4HH4rHatekH06i19kwG1/UHR2HqMPpd8xj705XJCGIv3qpjfXyPw8gUX/A
	 Abj5vR7+p+4KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 21110391AFCB;
	Tue, 10 Nov 2026 02:55:13 +0000 (UTC)
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
Subject: Re: [PATCH net] net: stmmac: keep est_lock across PTP clock
 adjustment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427931167.3612825.9963746260177679514.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:11 +0000
References: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
In-Reply-To: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Nov 2026 18:37:56 +0100 you wrote:
> stmmac_adjust_time() disables EST, drops est_lock to step the PTP clock,
> and then reacquires the lock to reprogram EST using a base time computed
> from the new clock value.
> 
> That leaves a window where a concurrent tc_taprio_configure() can program
> EST enabled with a base time derived from the pre-step clock.  The gate
> schedule then runs across the PTP step with a stale base time until
> stmmac_adjust_time() reprograms it.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: keep est_lock across PTP clock adjustment
    https://git.kernel.org/netdev/net-next/c/b0816917a4f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


