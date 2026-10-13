Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB74DD3B2;
	Tue, 13 Oct 2026 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889368; cv=none; b=YuEk7cJHXgtWosiYlOA/1CsPBktZ5BDbHOS7VHIX6by0LV3Ebev7lIRro4Zp8bWyjYmJSjhVHayDlhRThtac4XnfB+yyCFfnAFyAcNJL/yAFuO6CPJRS0Fu+VPipKL/KLUcxFRcoYljQGysV+Pka8WsFnlkWe7j9xyi5Pp8rk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889368; c=relaxed/simple;
	bh=Vj4+KUI8cQqSytbjiVluTu6SuBwuw88/UUMo/jfQskc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SS7xfZM6BXCJkfd4aQtBUIIlAuxrxAEgdjuBahvoOKumQyRkcoUsz0O+w7Tyn8fZ32zLzhiK2zP5AxdVAjtLsk9urWp00qDPWn7wBtddhNOfwJ5oEK56HRAgAivy+bZrcRInJMQeNCgLBVTwBlwtaSad4C8Mh/hXIpiS5wkHDF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQtJxEXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQtJxEXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AA61F000FF;
	Tue, 13 Oct 2026 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889366;
	bh=Gp4AwVfLQNcSfDsteZE+KsaLnuHbio1WLfcumtJEKNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QQtJxEXWiiQ/CNuHogiyN2CqBayIUDzgoAtsrG+cMuPNl4tDUX4mKTeOO+ZHSxYax
	 upV6klH4AZRB23oJhOTJMr0ArBq2RVTenNqvxs2sK34GPuI+phIBBB/wF/+bfHwUiy
	 hcSMhESPnA2XHlHLQBaK1f0+4F2Bu+flk04Netm0r4ZghCz51HMPY3ol3pFZtpYssF
	 pEipITuIOa46VE2DidJcyOOqRcaBMJZ86m78JLrwfSvaMMIsB1lThzKi8uC7aS5FID
	 uCmY9rDWaYOqfMlM8SBx75byDyoI6Qw8YO8iyc3yFFX5lK3ZoO24JlPtT+8/ayPiNs
	 nKDUXKB3RUsQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F19853927051;
	Tue, 13 Oct 2026 11:02:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: ptp: switch to gettimex64()
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179188936464.222572.15666839095638245831.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 11:02:44 +0000
References: <20261008103809.1848255-1-jjc@jclark.com>
In-Reply-To: <20261008103809.1848255-1-jjc@jclark.com>
To: James Clark <jjc@jclark.com>
Cc: maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 mlichvar@redhat.com, nb@tipi-net.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Oct 2026 17:38:09 +0700 you wrote:
> The stmmac PTP support currently implements the gettime64 callback to
> retrieve the hardware clock time. Update the implementation to provide
> the gettimex64 callback instead, adding support for the
> PTP_SYS_OFFSET_EXTENDED ioctl.
> 
> The system clock readings are taken around the read of the nanoseconds
> register in get_systime(), so get_systime() gains a ptp_system_timestamp
> argument.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: ptp: switch to gettimex64() interface
    https://git.kernel.org/netdev/net-next/c/d7804253678e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


