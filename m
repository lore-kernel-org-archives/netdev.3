Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7B38D3FE
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694479; cv=none; b=E9kQvMdlPZrMghebrDRZ5zD83YqwfZwDetyr47vpAnExEx3oe/hzAJIASpwUKuNm1RhQ8cUEJ8QJo/DMWuLgJwxDyvr5fE8aW9Xb5s5frnW49uuSoJTeW5qI5KTf2yvlkMH5hgLm3WGzsKb4SmdJmEirDxtdUx4EODcwmcutBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694479; c=relaxed/simple;
	bh=uTDPI1mjJ8O+RggvWa+26+cmArL6pXoU3gq8cMreEGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o2hqLX70bVLHKim99y9MWHMm7dNqWRgIlNS0NF3mj8pqBFqwzENhsCzMcp3e0vETTlDbb+tM05uWko2YRbh5/iSMgbz5BiIP65ZtOYfBY2UHUVCXfUJrnipzWytb7YKF4Y/IJlg3wTXU9495zZQDtdJTRtpaQGVWKT6d+e82K5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvvTHTW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvvTHTW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E7F1F000FF;
	Fri, 18 Sep 2026 01:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789694471;
	bh=NsZLZK+eVphx8rEayXeBZuLu95LXFmvSyDQEO8+5YzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XvvTHTW7oHJrEbqdzocxi8Ah5sy5Va7YcB4n6TcVGWCsJNhRIkoyITSmsyYCAyrwR
	 UMWsiphEIz95WLEcYOQBXynATMyyEoPTDt73/yHJYV50BgaSmCV4NLGOl32S2A8K6e
	 jO2Nc4+j/4TTYxUGa8xX/aBigNHd8aUxvcwPQ3uQgsKntIlzpg9Wx4+c4uFnr9zceR
	 kEikRfhcAVqMJM6jPKRd+NFJQXYYYbAOua9n7JFx67XUa5Mj4P7k3rzWmVXuenvO2E
	 dD0ZQkfabx4ftDYbRM3/fJy0rLS0/4KiMkkMWVOXgxhflq+OaHfw1DWicOze2EPX89
	 /nFrwyY9gKygQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D8B380820D;
	Fri, 18 Sep 2026 01:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969440464.212131.9134370127375175160.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 01:20:04 +0000
References: 
 <20260914-stmmac-ptp-error-propagate-v5-1-81149897e65d@oss.qualcomm.com>
In-Reply-To: 
 <20260914-stmmac-ptp-error-propagate-v5-1-81149897e65d@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, rayagond@vayavyalabs.com, treding@nvidia.com,
 linux@armlinux.org.uk, qiangqing.zhang@nxp.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 17:26:44 +0200 you wrote:
> stmmac_setup_ptp() returns void and swallows both PTP setup errors:
> the PTP reference clock enable and stmmac_init_timestamping()
> failures are logged but never propagated. When they fail, the MAC
> system time counter is left in its post-reset, non-running state,
> while the driver keeps operating as if timestamping were up.
> This matters for TAPRIO/EST qdisc offloading, which derives the EST
> base time from the hardware timestamp counter: arming the gate list
> against a non-advancing time base would leave the schedule permanently
> stuck.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: stmmac: propagate PTP init failures in __stmmac_open() and stmmac_resume()
    https://git.kernel.org/netdev/net-next/c/8181678a92f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


