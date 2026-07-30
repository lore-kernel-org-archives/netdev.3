Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC24779B9;
	Thu, 30 Jul 2026 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454248; cv=none; b=NZ6MiLch99vTlktIi0TU6dFxN49s/Y6Os4X8SWbUvTETXjGIF2HB/OQfRxvASG9/X5jUCFjxMU1XYWmyv+HqczUNUI1KoCP6PyMVTj1/nazWuMf1ux1/VJddIko70p1+2wxi3yqzZ0GGclOS+q7qiYUWhgYW4gyyOFxZlAuYQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454248; c=relaxed/simple;
	bh=sVvDdwdWocEX4eQiZfZ6KXs3wR3Z2HLL0i4cU9mxp5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KYwIY1TPOcwuskv+fn8gm+LQVyI7CfRJGL8kSX4EfYoD6gHQ5Xk6OdKpipw49N0wS+DGuQmT5ra6D9uHjEIE5oMAzNPVrojW1/Jp61QnFfpbrwPO1Q4ONl05NwNsQwoJY5qDaXu/4azJk/h8haATCD+N2qCtUYHj9qwWmTLCF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvY+YD0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvY+YD0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096871F000E9;
	Thu, 30 Jul 2026 23:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785454247;
	bh=nG5vXe6YVJ/CQ0f3t4Po4QS/3P98bdRLH1qDNC2Hak8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YvY+YD0/lfUafYTmOONOzpUVIMD+ngRcaHXBNdjcBor6IQNykKvHnjLFwz+WfPg0k
	 WCaishs29yJTFjhCB/OVCVCz8W/XS6+etuz5kQxbhNSKYAAu4f0TvnficIdjRgmjDy
	 6zzN1aTojvHeHeV/8CiBdge9z5Tn5+tMP95aj8xmbfL2g1NnejPCoJ9Dh1Dw0ftBbk
	 NnDmt3Dm3Hm9vRfWINNhAIltlJAqOAuzKcfjrLjCoYCVlT75+z1aAOi3RNT0cOpxKP
	 yep/tUeccjqmO3LZTHXgDjv28/KaHWEyREfTEdQikc5AoTH7izXSs2Kb2M9n08TxJL
	 XYI7p3Dx2eznQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93888392445F;
	Thu, 30 Jul 2026 23:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bonding: alb: re-check primary_is_promisc under
 RTNL
 in bond_alb_monitor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545421014.36899.8795736744485931799.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 23:30:10 +0000
References: <20260725233930.2957317-1-xmei5@asu.edu>
In-Reply-To: <20260725233930.2957317-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: razor@blackwall.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 25 Jul 2026 23:39:30 +0000 you wrote:
> bond_alb_monitor() reads primary_is_promisc under RCU, then drops RCU and
> takes RTNL via rtnl_trylock() before undoing the promiscuity it set on the
> active slave. In that window the active slave can change under RTNL
> (RTM_DELLINK -> __bond_release_one() -> bond_alb_handle_active_change()),
> which already drops the promiscuity and clears primary_is_promisc. The
> monitor still acts on the stale decision: if the slave was removed with no
> failover, curr_active_slave is now NULL and the deref faults; if it failed
> over, the stale dev_set_promiscuity(-1) underflows the new slave's
> promiscuity counter and pins it in IFF_PROMISC.
> 
> [...]

Here is the summary with links:
  - [net,v2] bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor
    https://git.kernel.org/netdev/net/c/683c6ba6e58e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


