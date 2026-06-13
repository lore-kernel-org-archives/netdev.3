Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED2331222;
	Sat, 13 Jun 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781392214; cv=none; b=BeNwSgj1FRWbiVrBWiBvk74QTZwgDpXscQbAYfe6nJyndRu2FyLYl3ayT9UrCKrdBJfAUBhJgToLhRYkjNOEy91BS/qBVdt7J24tfHelT+EFfVcP31xygo9SGkduSIaXZjwURedvH1gvICYsO7RwznzlosSE4a8VGrJS1M9co1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781392214; c=relaxed/simple;
	bh=Pf+JPilGVfEbynN26XqwaHtTSYoFlhksdL2CdPTziQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K+IFaZIxhVQhvIHSU+rpeIf9gN5P3fuVK2BHmYd9mZU4ccGZ7cPP2qu6aarS/8hVs9+Jmfe4i33QxLoojrl5Spe1/aJOrt/38oEPGr/FgNyrZkpwf2VvfDRch1FPqNj5ws+qUwfYB0maFU1ihU+3NoxZuWYnfuBzowriq1dzerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSYMmOtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSYMmOtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122741F000E9;
	Sat, 13 Jun 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781392213;
	bh=2q/iUZHmzQJ2DtmNMtcn+7efYWlaZTLUNoV8eMxuMoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dSYMmOtKsCxoiSxOvLoSHdYRssn1le0ynrgX79A9xb2JkxdSS3dN37bID7oTZwlsE
	 syuFBg2CNBQ2Wbdafq7x3RKeXQs9xkyE5YIh3+HSNJXYbJTDUxDMsksDgzyeVmr/LA
	 svs2tDYEE24ivI0Qx1JHnJEbY0xnt9SZBhfe+Y0ti7EzTCCJPopzdZpXgKukSlKQ5w
	 qJQ5j3PLAMK9sDh5CsQuV/Po+Jo9Qm8OPKGU8AnD0SoNRzLSMrmPm6vAXCPv2eIAAy
	 PU1u8ZkiQ/LxPd0vpnFscWdLYH57yDnJze2GUavg8aULtiea7CxB4TIjnKDDSjz5x6
	 Ni2YwmUmLjL/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569ED3A54A32;
	Sat, 13 Jun 2026 23:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net/stmmac: Fixes for maximum TX/RX queues to use
 by driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178139220914.1621428.9980668998947938804.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 23:10:09 +0000
References: <20260611113358.3379518-1-j.raczynski@samsung.com>
In-Reply-To: <20260611113358.3379518-1-j.raczynski@samsung.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 k.domagalski@samsung.com, k.tegowski@samsung.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 13:33:56 +0200 you wrote:
> When contributing other changes preparing functions for new XGMAC hardware
> https://lore.kernel.org/netdev/20260601162537.553512-1-j.raczynski@samsung.com/
> there have been reports by Sashiko AI review about pre-existing issues
> in the code. These problems are non-insignificant and are 'net' material fixes,
> rather than net-next features.
> One issue in this patchset was reported by Sashiko AI, while other
> technically part of new patchset, but is reasonable related fix.
> All of issues are wrong DTS configuration, but kernel needs to handle it.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/stmmac: Apply TBS config only to used queues
    https://git.kernel.org/netdev/net-next/c/8b10877d9d6c
  - [net,2/2] net/stmmac: Apply MTL_MAX queue limit if config missing
    https://git.kernel.org/netdev/net-next/c/8a7bca6de6de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


