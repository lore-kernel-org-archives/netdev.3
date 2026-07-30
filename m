Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF81346AC5;
	Thu, 30 Jul 2026 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373247; cv=none; b=YK6TVESv8Z1O4qbk9ZlPkTas5gdPw6wfRa1QGwziLs3mNehUixafR3ar6qIegiGstTbQ5mr1lcwA+O3nEuy/x21oSF6Nzx/dxZ+KWLiA0n9H+PlCU2m+fS8QLtcYUiitt9URyaWEk+iZYgaRIuI2b+JcZF90JD2XPOAl2icVIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373247; c=relaxed/simple;
	bh=V0G/M+lAmdg2XxgyAHbiQc7M1iFOfiS5c9ZEvVIAOJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V0YaGc5AYoY08CYRf/sf9E6U6G3oWTZDu4S6Qs2VT1oEtsy7O4t5RVbchygwB9y7GVqn6atYJr8gB46ce23OV8upH4/ofddM2y/t1BnwOHWSkMMdnCQRpTPq/OEp7uLFh392Q6qcNG6U0QOags2MnHT8l6AUyUZZEL/b5mezwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmTZXOfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmTZXOfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1421F00A3A;
	Thu, 30 Jul 2026 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373245;
	bh=d68rPoelmdmcgWTV80bywdPwdzZJOB+idb8Hy/zkcb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kmTZXOfiJRuWv1IdfkJjxKh2asHsU2sSnZ/m9wvDqBe61LPM7ENnczo+fM3Hy54Nc
	 FDNKkxpgnSgxPnjiuo9RxdhBlIIVYULEHvjHosWOUozsZHg9QyHW4ygEhCJEc3YH2L
	 p2jqBvnjopesrrRBHPoKw7IzZFQNpm00qGn8uOX5O1N9jkcPrd5BDXpVoqhx1XT6ad
	 qgxZk0uxL+taY6YKvTf6NfeNMdczjNOjqPlJHRlY7YFXlkFLqdymqxsq+pznAG1kSE
	 WNEum/Eny1uKKq6WsbvsP3zsIJXg5hJh/NMjx9sZOippsZVwgYPo7aAM5ilvbD9PnT
	 8k5zPCGH3QjRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56ABF3926256;
	Thu, 30 Jul 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ptp: netc: fix potential interrupt storm caused by
 incorrect unbind order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537320878.3303028.17227087712130370934.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 01:00:08 +0000
References: <20260727060348.1887464-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260727060348.1887464-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: richardcochran@gmail.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Frank.Li@nxp.com, vadim.fedorenko@linux.dev, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 14:03:48 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> In netc_timer_remove(), hardware interrupts are disabled by clearing
> TMR_TEMASK before ptp_clock_unregister() is called. This may cause a
> race condition during driver unbind that could leave hardware interrupts
> active. For example, a concurrent PTP_CLK_REQ_EXTTS ioctl can re-enable
> TMR_TEMASK after it has been cleared, leaving a pending hardware
> interrupt when the driver unbinds.
> 
> [...]

Here is the summary with links:
  - [v2,net] ptp: netc: fix potential interrupt storm caused by incorrect unbind order
    https://git.kernel.org/netdev/net/c/54ad7ea45d63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


