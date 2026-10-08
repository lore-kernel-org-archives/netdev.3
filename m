Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDE4C33F9
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483010; cv=none; b=iqPpjTszKsbIpzO0zOnas6eXUpk0xvNt9i0ySSaLapWYeCQ/0onR/NHuNctsH8UXG0Nby3AhdLd1ksYqSXnBdrESrNeNvoSUm+VEek+aW4g3uo7Trrg7Zt9cFWZTCkwXzSV/vteTq1O1knH6h5GSGPPHyIDcLebv6A3kasmfvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483010; c=relaxed/simple;
	bh=jW7HRAijltp6OERdbScHMstcDWu0f3Gj5njfwSqndzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qHFYhlezUtkdJ9x3wNkliH58OR8bokodr8/J0lMf1OG+fA2yHGx4lGj8uZtEGOzmg0NsExgLQfACP5JyFIZvXwJTdEnCO1X1UjFDbWMYNFOPTBn6Jzgp3ysozr4qaVXbjzz6NYNm4n0sGjmsLZ6F483SwCwIOr6KruUM+hzUgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGDJ544/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGDJ544/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E881F000FF;
	Thu,  8 Oct 2026 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791483009;
	bh=yOhDZzItmoKCk+zPaCjLio5dL1kBbn63cXFOf7KK5DE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TGDJ544/Elg1AT17eB4/dNLZ2epKtgmSHNYQ076jHEY8pf3m36N8LTt0rHcFs0Rl+
	 4KHh1IyFyqlZGEOR0koqGasOu57vhNl/eIV4jpN9Dj6YP4tRSPSHAxgkTA6zXWatjP
	 pGFtb4AldjNaSNqIr7zBJR4AWZQyrUwvb0fZ/kDzE70NY39BO/0DiaB4imfRATUB/4
	 LYzFnUjMC3LW32XImNpf1l+oKOgyyn9QJVwmH45fjwxz0vbIzOFhVLph5m2Y7F9Yse
	 lfgYYuTsMueBjqTVWzauhuGw/DQqXozxwfUEBevmuViSNHHJOBcQ+yV78dUb5FvtUR
	 EJ6eBP3wx9o0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 771FD380CEC8;
	Thu,  8 Oct 2026 18:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bng_en: pad short frames before sampling nr_frags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148300801.376744.3401019989790817903.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:10:08 +0000
References: <20261007075649.468033-1-edumazet@kernel.org>
In-Reply-To: <20261007075649.468033-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, vikas.gupta@broadcom.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 09:56:49 +0200 you wrote:
> bnge_start_xmit() samples skb_shinfo(skb)->nr_frags into last_frag,
> and stores it in tx_buf->nr_frags, before calling eth_skb_pad().
> 
> If a nonlinear skb is shorter than ETH_ZLEN, __skb_pad() calls
> skb_linearize(), which pulls the frags into the linear part,
> releases the frag pages and sets nr_frags to zero.
> 
> [...]

Here is the summary with links:
  - [net] bng_en: pad short frames before sampling nr_frags
    https://git.kernel.org/netdev/net-next/c/056d046bf530

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


