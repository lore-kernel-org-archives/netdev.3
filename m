Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2E47A0B0
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934008; cv=none; b=cKFY6ZQxPcrYeOvefjenthtdF1Ryho2zEAEvOA42epR83rpzRuHJGCyHUHKy/H2IOI7HPm0LBs7MytncmBP9erI2bhatuZ4XmK1oqqVqSVYmjAUFthOUBe6r+Fqz1+le5uSPU76fd/TIMKpQTAKlf/nknEZgswpsinPMAxZVUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934008; c=relaxed/simple;
	bh=aZj426x5fFn3XyW6LrhVHbk2vsmptX1L2w0Yhyd0PXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q07fMknwNU8mPhgDlJpWG3YQy8uYNJsJvL/ZRknW7vCqotVGKo73QSBT1asC7qtJAki7hO/ZSGGbQFVIIOAoyCa1/1Bcdj59BlaeHs/Jg5W87VO5vdyxfiFlGFbAAhqR56e47yJiP4aTfYXPC6NQ1mGj+HYxuVVPqZRQN5OrXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJMTCRpO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJMTCRpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822F81F0089E;
	Fri,  2 Oct 2026 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790934006;
	bh=f59O9B08QCHTGNeuypp2tZ1+0HGrGXSxHAzKegE8o18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kJMTCRpOOxsGv4lHIB7Vh6uHdcqO+b+Umva4UYt5Be6sMuaTwoHlFLTWEhiuDY2Tw
	 x+VX6+p4l0nEAhoWWn1JahMeO3cdePphcjbSxPdfYlYbdlLdDFEfPiFs/dbShwq0Sw
	 EduUby5vXKpTOxKe1uHQ9YRn8TKU/5umgEUzdHdYWj6xG/HCpSJHSKxxTc44ssjCRB
	 h7OrDnJVWjxc6YVG6m8Tn5rsdI0UuVRM71eePoay/hIfHOvkpqeWP7LqAtKZhUz2oC
	 dLd141LPpSnrRfpDnEn8xsvmcqoDjtn9w6/aPj7+aTflZK6A5w9wagTXZH2XLQwdkS
	 4w8LBq+QVmdeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772D038119DE;
	Fri,  2 Oct 2026 09:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179093400503.3321157.8480086535803997023.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 09:40:05 +0000
References: 
 <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
In-Reply-To: 
 <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 29 Sep 2026 15:10:11 +0200 you wrote:
> stmmac_update_subsecond_increment() ignores the error returned by
> stmmac_config_addend(), and stmmac_init_tstamp_counter() discards the
> addend and system time programming errors, always returning success. A
> failure to program the addend (PTP_TCR_TSADDREG) or to initialize the
> system time counter (PTP_TCR_TSINIT) is therefore silently swallowed,
> leaving the hardware timestamp counter in a non-running or partially
> configured state while the driver keeps operating as if timestamping
> were up. This matters for TAPRIO/EST offloading, which derives the gate
> base time from the hardware timestamp counter.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: propagate PTP addend and system time programming errors
    https://git.kernel.org/netdev/net/c/232d49dd4b40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


