Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85026474255;
	Tue, 15 Sep 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461670; cv=none; b=m1LxRQqHf7Zm9Dshx7uTqJ2lxcDFLSpklp00qxek2ZwCO+J4tKdgyFdu4kIZsTaHo/sxVE73dL83r6zXW62oB02EipZ8kAEkib9dtPeQzsSoNE+tYS70Os+bMygBC9PpPVWUW7EpQvKzidyLHmsIOz6OlnRfVBMrHrD7QTmkIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461670; c=relaxed/simple;
	bh=uYOg4r3aPPRdb+mIgzHjOYWcHGGPcnYGfNRjIiDB+Eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eUDc5Fm8BsXGDtS8F5PagIr1XDBCxepv344y5D0YLXd6GCKK0R4Wj4qqFR1f4Lm/mIBsorcqn0LqQ5ULLHTRga6Cwnc3J40xOHsTI33UKSZi1qp8TSH2iqmu49b8X7KajreifU5GF6mlCoUZ/kG1hfbGBQrLu9XhgfpMsIDAS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6Fsa7m4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6Fsa7m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2921F000FF;
	Tue, 15 Sep 2026 08:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461669;
	bh=RixgAfwJ7FOy0z4gd1dgG06QcqvthFck4BfXdnCPyFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b6Fsa7m4VbOlThCGxWERam5ghd5zVaK5o8yzQn1R7MTUZV37LWWvslhFpnjvgazN1
	 J0blXvLM2f0wDEKeZ3f0rzPJnuekbG6Izl8VYlx/PR3KaOI8xXWaHKa0nWn/0raT0X
	 HZ+8+Gx4fVimfPfyjCNb9pct/gNcfpOjpy4u2d4bTb6vZ/PGjoP4ZFEkcetrmC37np
	 qnTbrEED43zNx8nKaKVVjpnJ/UXODYHZEI/LRUb6ugWxZmEMEtDgtA66OnaQoWcgsh
	 QxfQixMc9mNLPW+BX2AgHC65UARn31yZ0dWpsetje5HyKxg143QkphSes6s6PdznzU
	 kTUhd8sFq0eow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983539253F5;
	Tue, 15 Sep 2026 08:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fddi: skfp: fix NULL deref when setting the MAC
 address while down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178946160391.1451124.5423515994250992664.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 08:40:03 +0000
References: <20260910063743.110747-1-tlaghgus0425@korea.ac.kr>
In-Reply-To: <20260910063743.110747-1-tlaghgus0425@korea.ac.kr>
To: Hohyun Sim <tlaghgus0425@korea.ac.kr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Sep 2026 15:37:43 +0900 you wrote:
> skfp_ctl_set_mac_address() calls ResetAdapter() unconditionally, without
> checking netif_running(). ResetAdapter() first calls card_stop(), which
> sets smc->hw.hw_state to STOPPED, and then mac_drv_clear_tx_queue(),
> which walks the two transmit queues:
> 
> 	for (i = QUEUE_S; i <= QUEUE_A0; i++) {
> 		queue = smc->hw.fp.tx[i] ;
> 		...
> 		t = queue->tx_curr_get ;
> 
> [...]

Here is the summary with links:
  - [net] net: fddi: skfp: fix NULL deref when setting the MAC address while down
    https://git.kernel.org/netdev/net/c/7c8810c2e69c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


