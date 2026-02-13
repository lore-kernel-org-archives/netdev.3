Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A992239E6C;
	Fri, 13 Feb 2026 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951612; cv=none; b=mcPcpq+f1e9Yc0dsAq6gfeF8VyJH7OPasWg9jjLLcz1TU1jCYYjhgyhmo8f/xMQHWJw3FR4qG6lAjxOYvFxNNeOoPLRoDBzeucGmUU5WE0e0ZbVlUNvn3bfoqOsm2gAp5sxnjszk6+K3CCFlSgYrbfuM7DTVo8EybKCxTbl6qEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951612; c=relaxed/simple;
	bh=5ZSl2pzWhiB6N4VZMYvSeGipvdIFBBlDtOiOeOJ5RDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EfLUDIst84DJvc6lj8OBk+1/olLAN+seU/TVaL5g5drukpqIHr+ltsASICjCZOwzNxGAL6vp3PVa1ZWtogOgap/Bp/5CmVVqMqoptBCDFsjTHcDiJ1dI/0nIo0KhLrIZTJjO6qoJ7xn2PDs2MIdkKvJN5KMSeqXYhxk5lcpWcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=konDU/Tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="konDU/Tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BEDC4CEF7;
	Fri, 13 Feb 2026 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951612;
	bh=5ZSl2pzWhiB6N4VZMYvSeGipvdIFBBlDtOiOeOJ5RDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=konDU/TfJYyklZA52QAaVg05izA4Q2bja597l5d9mwicKHUkYOt0hdXOIF9QFcvXO
	 D8QnOQOMuIVDU46HCCq4Ovtp8rxQVbC5BQxRnFLyFt8UwvnmWhn4cWZCTRwEiCx4Dl
	 HSg2KnOISqjDEIN3liZ65jPTQlmtfZ6bBdUMh8Ts2rY0Gl2BoekoyaYmPZn025upzL
	 ENNC0FnN7fT9YtwXy+h7APYiIYtstdAE89HP6GAtei2XmpkMeG6vgvQzYEyrOAqm7N
	 QnCif+Bgni7lXIn6LbziaCol5BCCelN4u+q23zujlv0eJ3xGu1qhJiHrUduRStu8SR
	 rC5uJbjvpq3wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 483323931095;
	Fri, 13 Feb 2026 03:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: fix oops when split header is enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095160583.1822665.14143768748258402663.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 03:00:05 +0000
References: <20260209225037.589130-1-jie.zhang@analog.com>
In-Reply-To: <20260209225037.589130-1-jie.zhang@analog.com>
To: Jie Zhang <jzhang918@gmail.com>
Cc: netdev@vger.kernel.org, jie.zhang@analog.com, horms@kernel.org,
 jacob.e.keller@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 vladimir.oltean@nxp.com, Jose.Abreu@synopsys.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Feb 2026 17:50:32 -0500 you wrote:
> For GMAC4, when split header is enabled, in some rare cases, the
> hardware does not fill buf2 of the first descriptor with payload.
> Thus we cannot assume buf2 is always fully filled if it is not
> the last descriptor. Otherwise, the length of buf2 of the second
> descriptor will be calculated wrong and cause an oops:
> 
> Unable to handle kernel paging request at virtual address ffff00019246bfc0
> ...
> x2 : 0000000000000040 x1 : ffff00019246bfc0 x0 : ffff00009246c000
> Call trace:
>  dcache_inval_poc+0x28/0x58 (P)
>  dma_direct_sync_single_for_cpu+0x38/0x6c
>  __dma_sync_single_for_cpu+0x34/0x6c
>  stmmac_napi_poll_rx+0x8f0/0xb60
>  __napi_poll.constprop.0+0x30/0x144
>  net_rx_action+0x160/0x274
>  handle_softirqs+0x1b8/0x1fc
> ...
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: fix oops when split header is enabled
    https://git.kernel.org/netdev/net/c/babab1b42ed6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


