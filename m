Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01B3845A7;
	Sat, 17 Oct 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201220; cv=none; b=QYCvrF4oFZ6AqhCEeLaLDNc0uToEt/VAx8y+LhHvz70CzIwmmuRrjk5SxC1v75vrlAVHVjBYXeK+uPuR3LlDZ3RNIN+k7N/+t9kwyOotg9Ve6Od+WeucRpjiGjmrRYfA4V9NdlxQ82AtSytLGm8r1f0xq+hwGAvnINDIkUleCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201220; c=relaxed/simple;
	bh=maA2Pztf7/TMMpYhUk7ow80ygjhNmZME8PjVqYSrJ/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tUcge8qSP898spxGRsDibo3YnSVC4bv5bfYW8ajfcL6Q/7reG1ek85qWnL/jLCOq8pv9B3fZB2J8qJQ4NF29ESF51lqYIyTf+/eTVlob4lR4D+xMY7ZQW3LkhpoP6TQpPxG5CsyU3uylJ6vQKCHldcOeC7j8Fz+DGL3SG7Nccqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHarg6H6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHarg6H6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8079A1F000C4;
	Sat, 17 Oct 2026 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201216;
	bh=CMzXMEw7TbJvjYDjf6Ds/tqX/25yKYfasf1p+t7HRvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UHarg6H6vGBHEd0bc7h3zr6JWYypgrx0vEaO3M5dufQbzWMBQkqRHi75axw00mmTV
	 bWgg2YZ6cRxPM2ucDYC1dAlG76pvieckk06YnfL1qJd5qNdX/z83b0zsu6A+g2883s
	 XZN55bQ9iL0qLe3yWSec0ZYJ0pjEl1LY3Fh0TgxlKSMnJGx66RnFa15fPkML58HFtH
	 5xYrzsokIPE7fw8OYtBtF5XJtFuv2p76k5lBOqcnCs0S6ufIYAuECI4NtVQuvRVedg
	 S53e9DfP4m6ILIoG8gVBlZC1rIKWj6QM1BKAbWN2L87rqKjAGD6+ZdKWRnCv8482+p
	 lnTmBpFxYCccg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77307380CED9;
	Sat, 17 Oct 2026 01:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net: freescale: fix PTP_EXTTS_REQUEST2 for
 QorIQ 1588
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179220121502.1050340.1733209882255672981.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 01:40:15 +0000
References: 
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-0-0f4eeff2295d@free.fr>
In-Reply-To: 
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-0-0f4eeff2295d@free.fr>
To: Vincent Jardin <vjardin@free.fr>
Cc: yangbo.lu@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, ioana.ciornei@nxp.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 09 Oct 2026 02:00:55 +0200 you wrote:
> Since commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags
> to ptp_clock_info"), the PTP core rejects every PTP_EXTTS_REQUEST2
> request for a driver that does not set .supported_extts_flags. The three
> users of the QorIQ 1588 timer (dpaa2-ptp, enetc, ptp_qoriq) do not set
> it, so linuxptp ts2phc cannot arm their external timestamp inputs.
> 
> The timer timestamps the rising edge only, since ptp_qoriq_init() clears
> ETEP1 and ETEP2. Each patch declares PTP_RISING_EDGE | PTP_STRICT_FLAGS
> for one driver.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
    https://git.kernel.org/netdev/net/c/86a30c434849
  - [net,v2,2/3] net: enetc: fix support for PTP_EXTTS_REQUEST2 ioctl
    https://git.kernel.org/netdev/net/c/8e96c4d39316
  - [net,v2,3/3] ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl
    https://git.kernel.org/netdev/net/c/d347ab5cf809

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


