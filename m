Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9447A87C;
	Mon, 21 Sep 2026 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032877; cv=none; b=BSH9/3htLvxitjDk5rZS2+dTPrFyssQSjaIGkfM/1/YOkmRbKCnUQbidSGwEWenyyRs32W2bnLChLg89/2mKaNQIlUs21llhBhpmgfFeZuApyPx7LlRP4vLX2XrUvh+ryxnTqvelAtBHLdc4QwyJuUdP5LRKuIdQZz6MKSyyD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032877; c=relaxed/simple;
	bh=sRfWECjVFySuV8U9SZGChLB03Yxj2C6tEWXlVhIN114=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cVvYj6ZhKClOtH5ShWRfU66a2LUWLg83QV/hfe7R4jn6mqhq11gmTvQVkDypzzDiKslw090UK6MY4ZdV1EA5fH9p6pOzlNs5MRF61q2TMR2Lu+tF3oz2BkwBgWXK3gw5CsdnoFHiHHmPrIEPUPN5YZiFZPb6i0QVQkS4eiXdOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maXGZI9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maXGZI9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4A81F000FF;
	Mon, 21 Sep 2026 23:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032875;
	bh=VwgiVMbtTU0GnEfmISLt7DOS2sZJ3kpIz8D0SeNc6Zo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=maXGZI9IWJhCSrjEiKnqq+Y6fVcseLfsZWz2vRW2fHhh3yI0WobmAjubUH+bis9w3
	 RJyNA6GgRdk1ZoZerBTFT7OrD/W23KaFfLEgpAvCLgwf32BCvPTJlRper0VkNN8ZEd
	 c05TFH7yaNOwSmN2rLN8NkJiXHyfrs3FrPzfVtZUF9g8ZO/r5tWL1x9z5QxwQQaLpX
	 XUKxplcujUWRxN5fuxLJ8MjGoNi1V8kYdB7MmTEpG7nreJu7d3abX6VDpXIxqN++lu
	 t6W6cQMDGS1XpnJdMURtPsBmvg+1Er3GbqsCwWnRpmF/9gp1jAvj7DM48t96mV8xiL
	 ycq/TO+tvjcJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568A93927048;
	Mon, 21 Sep 2026 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v15 0/4] ptp: ocp: add TAP CPLD support for ADVA
 TimeCard X1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003280714.3282843.2669337425459655811.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 23:20:07 +0000
References: <20260916153242.157171-1-sagi.maimon@adtran.com>
In-Reply-To: <20260916153242.157171-1-sagi.maimon@adtran.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sagi.maimon@adtran.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 18:32:38 +0300 you wrote:
> The ADVA TimeCard X1 (PCI device 0x0410) carries a Lattice MachXO3 CPLD
> on the TMC I2C bus.  This series adds access to it and an update path
> through devlink flash.
> 
> The card has two I2C controllers.  Linux registers only the one at
> 0x00150000, normally routed to the config EEPROMs; the one at 0x00120000
> belongs to the on-card MicroBlaze and is routed to the TMC or M.2 bus as
> its firmware selects.  A request/grant handshake re-routes the host
> controller onto the TMC bus, where the PCA9548 and the CPLD behind its
> channel 0 live.  Everything here is built on that handshake.
> 
> [...]

Here is the summary with links:
  - [net-next,v15,1/4] ptp: ocp: unregister devlink before detach on probe error
    https://git.kernel.org/netdev/net-next/c/a2bd6c17665f
  - [net-next,v15,2/4] ptp: ocp: fix dpll cleanup on probe error
    https://git.kernel.org/netdev/net-next/c/65ca1f70c4df
  - [net-next,v15,3/4] ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
    https://git.kernel.org/netdev/net-next/c/3b815e29966f
  - [net-next,v15,4/4] ptp: ocp: add TAP CPLD flashing via devlink
    https://git.kernel.org/netdev/net-next/c/a4b7c15aa78f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


