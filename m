Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465145C71D
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268679; cv=none; b=WqdbYAgUGCFdkM0A1pBa0zOQ0KjWYSHkMq6P6Lgot6YYU3L+/QELcLymza/mKVPMnx5mY6m0binWSGgNmSE4ctApy2nkwpe7im3kwGMQXuNccUHaVv9gzZakFOK1ABkXK1VfZ/bxcw1iYLT7sbPnDfUcIiL3bzkgPEWD+uqSKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268679; c=relaxed/simple;
	bh=ceOHn48+m0/bVnlZZpB1bPOFVDZ5B5WjQV1nzvn/dy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lc/oVLMS27zMNgwqm5G8dwhrCIBefJBfjkmr4wGtK1H/c3INJKwJNQQcRXRiAQs34jN1aMsn8UdLScci5kXEI1uXJAuHbzXj/oSmovnHSZSMWuvzEh33t3yLRRJV+yN0EeAW7IID8W61vO0JuZyjuhmFJTj4ay25T6aDhh03BYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgE9Zn+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgE9Zn+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8941F000FF;
	Thu, 24 Sep 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268678;
	bh=AYizv7cZ61GKnfZoPyKBTURH3GgxK75BBU1PJZXqZA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WgE9Zn+pYR27Rh29e2pXBDBv7sTOC+obMHHCfLsubcIt8MO8y1nWCCyrXa3YuuEgK
	 h9IQKt+YleDK0EU7EeYB7t3VlakmcABdbDAc7YyOxHpXydjA2gsjqvawbfPnb8n+re
	 ihCnZYOLTi+zkf5GEowkRubwfwEXeKVPZDQd4VvV62jdVzPCgdy769iIXx80Jf0GNC
	 GGUR1YPCxAiUEqVMcy0kFD1vTmhOjOA6rl411XL7YbE1p0+MGtpGrbqVwXSgDlJuHz
	 H9AfPNzvOOikclV/ryt3czUoquCJxewd62/olvEWllP6VxPjSGeP8yuSO4c7SdCHMa
	 KOlK4jwacm8TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0E3A566CE;
	Thu, 24 Sep 2026 16:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: libwx: fix races in Tx timestamp handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026860739.1650423.11536566260145832868.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:50:07 +0000
References: 
 <77431AF9A0E369F3+20260921071549.1141804-1-jiawenwu@trustnetic.com>
In-Reply-To: 
 <77431AF9A0E369F3+20260921071549.1141804-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com, kees@kernel.org,
 aleksandr.loktionov@intel.com, vadim.fedorenko@linux.dev,
 sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 15:15:49 +0800 you wrote:
> wx->ptp_tx_skb is shared between the Tx path, the PTP auxiliary
> worker and the timestamp cleanup paths. The
> WX_STATE_PTP_TX_IN_PROGRESS bit prevents multiple Tx paths from
> submitting timestamp requests, but does not serialize the worker
> against cleanup.
> 
> As a result, wx_ptp_clear_tx_timestamp() can free an skb after
> wx_ptp_tx_hwtstamp_work() has obtained its pointer. The worker may
> then pass the freed skb to skb_tstamp_tx() and release the same
> reference again.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: libwx: fix races in Tx timestamp handling
    https://git.kernel.org/netdev/net/c/3173cba11701

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


