Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624B37FF68;
	Mon, 17 Aug 2026 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996254; cv=none; b=pRBQaeVGFKAtc8eGof/y/PUgYeks5mzknJ6htZJzWu+l1CGzkSa2B7EV015/H/eNAEOzxluuWDcv22rtYXm1eCuA4/f1EqfdouQzfci0o474FYhAauJv38lNrrsiXsAGgFM42gjlBwyQFk1fiv32gbW5j9uuZlBO2Uyc6oZjcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996254; c=relaxed/simple;
	bh=vePC7Fcrx82wDlQ/rKKGc57L1Y7WUxYIVWa0pmfwHjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mcWmucBmOVht8uKTDJUnaKxxFD1qsYoINY6j496kLHm23IukOVU/OW1/K0L4ZlImBViPXoMM1MPqePNKUmI7Y48uW/W93YTOlRWAHeY+0pvIEX58A5y0yLVjKO70KA7p6ZypCz+rUXy9/bu0DOtpFCf8gBMsK4Ow8mZZnulsJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUim/nSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUim/nSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D6C1F000E9;
	Mon, 17 Aug 2026 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996253;
	bh=bwwXod479GzoVF8RaKfsbUVy6CpG/5bWGTCkUA5T/bQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SUim/nSF2Hlbs5+/KeEh1pQ0g0clNPpSE7C1KO9Vd61mgsLV7OcONWDd3JwDbleCW
	 mPQbdiL/xMcr1Rpj8xjEOj+qqFF8O4yit5RIl3ksUD4XOtb+sVAxDTltLGT79EkGzR
	 P11CAkjCD/NyULx+mgOlWT86BARhmDeQ6PkNlbMCw62YG6AWah1j/Ob+UCHZrYvFd4
	 f5UJQuFkL8dzw5y0n1T2/MDzYskQMQGt+ysZboe6dbasVL5rCUeFbklGXL3kPE2tw+
	 2P3XQAGPAfdfrDE05vy2LXjIhvwtqPGZA/JPS8fUUq9/Zh0ERMgIHlRb8ZqvSp8Vn2
	 11dhnsRwi7X5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938CA3926263;
	Mon, 17 Aug 2026 19:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ibm: emac: mal: fix NAPI locking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699620513.1711043.1699856308945706591.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:50:05 +0000
References: <20260811070813.377573-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260811070813.377573-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 15:08:13 +0800 you wrote:
> Since commit 413f0271f396 ("net: protect NAPI enablement with
> netdev_lock()"), napi_enable() and napi_disable() take netdev_lock().
> 
> mal_register_commac() and mal_unregister_commac() call these helpers
> while holding mal->lock with interrupts disabled. In the unregister
> path, napi_disable() may also wait for polling to finish, while the poll
> completion path takes mal->lock.
> 
> [...]

Here is the summary with links:
  - [net] net: ibm: emac: mal: fix NAPI locking
    https://git.kernel.org/netdev/net/c/43b0213529c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


