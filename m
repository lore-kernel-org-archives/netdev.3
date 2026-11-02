Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635809;
	b=mbB9p9UWKrKlj8B6Hp7e4Aj3euliIes3e5Ul1FTB9sJtA1ICG48My/UlciQMhlzzjDdV
	 jWArQ+zlg8lvX7i4j0u7T8dmaFIJfx1p/nx2c28BretLRT+ZZ08fSq7e7faR6MlXKOCsy
	 2vDm3sj3FsPePMSbGdcdYC5evroMQW1/s79S/kQjPRVC6ivA0m1EDOtyifHUHppFXGDh3
	 bAvUcc2MKcM/4/0ZM2mihRWzaXKSr829kKxGc3SmdiFmVsE/EuLgR+2yKWblPdXyPe5uv
	 dyAPjY0QSlfAMB8HzBQMUz3Ht7ksEtgb/CfWSi2D64uQ4Z2IncPK0mZyE0AGuPHo3oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=f8l2LmN6DtBiLYVSfIRSx6ttVI0HwmkTK4KfTo8Elvw=;
	b=5ElZFDOsBwrKoVvu87MK26EoKquiUDGKMI7NbC3rBXnxeEgKjpK6dCQb7YkZWaUVIzQt
	 KJoy4i7Mc9uTF9rc1iSdWaKdjaGhwFD4YzWSelzRgJnjR/ILfdrOIaeNG7tyfNr5Y/jAY
	 sYDBfoExpEZ9OhAjybuwA25LhOBqGnPoeVsPJ/uSs8+Lo+gmWW49zY2jnt9mXpZBOXPPe
	 4GbzqfIXKjb0R0A+4wHvpmIg35zBykvGEkkYE85HAE/d7BDVLvQxtDFGxgGNLjxO78NAq
	 Un8Z+goZ2UmdHNxRHPNbbHmMnf9sq56SeWLZHvTiM1AzJTceA7YkGOtjkipqLdt8JYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4LNZN6P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7011B607E0F2
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4LNZN6P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C651F00A1C;
	Mon,  2 Nov 2026 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635809;
	bh=f8l2LmN6DtBiLYVSfIRSx6ttVI0HwmkTK4KfTo8Elvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N4LNZN6Pwse3wB2tvlu7AWD0gJ+cmP28PNDFWeb4CB7xfg3WQBE8jtgMqqXezFl3v
	 p3CV4mjP07kQ8ZuikENyfZnCStztkeHDK54Fl7hdLTfW3SJ+01pBQklBv3yvhZuHog
	 Mkt1GfyqI55PPtl6Kq29ewT74mFeMBwykakXAk70tQ2LY4tct/IJkrVBogRx1Oavse
	 5ctZMFwdTjlPi7JsnVsPgXd87ZKDF+cqnFYmyw3+ZTe/d+egopTX1NmXI0s2IePyHN
	 FVkPouZXiFOylFwfLjLWNgk30QTRhhx8cZ9YBZmSxMGxaNMbTcUy4oxS9ErbWEAJqB
	 c2TFbj7M+rEVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 40283380821F;
	Mon,  2 Nov 2026 16:10:09 +0000 (UTC)
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
Subject: Re: [PATCH net v5 0/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179363580779.29416.13751914901506623948.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 16:10:07 +0000
References: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
In-Reply-To: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
 james.hilliard1@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rayagond@vayavyalabs.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 11:33:54 +0100 you wrote:
> Reconfigure MTL_EST registers after sw reset in __stmmac_open().
> Remove priv->est->enable dependency in est_configure().
> Initialize est_lock at probe time.
> 
> Changes in v5:
> - Reconfigure preemption_class in stmmac_setup_est().
> - Bail out in stmmac_setup_est() if ptp is not enabled.
> - Link to v4: https://lore.kernel.org/r/20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] net: stmmac: initialize est_lock at probe time
    https://git.kernel.org/netdev/net/c/98caed39c1db
  - [net,v5,2/3] net: stmmac: pass the desired EST enable state to est_configure()
    https://git.kernel.org/netdev/net/c/e4f5b46dfb8a
  - [net,v5,3/3] net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()
    https://git.kernel.org/netdev/net/c/23d96de472f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


