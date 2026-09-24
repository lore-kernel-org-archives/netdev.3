Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9E41D23A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272884; cv=none; b=dYASKAVzVMdah9SmVUJI9jt24ZUnfYBMQVKq5FdEelfVsb9Nm23iWa6Wb0CTOlTa8n1Uhg0Tku1+8uw5XxWMiijsNKs3t9/5XcQ83kyOIIUMwshF4KrTFIs15uBvSpmAAMhXnB4ZqGpH+/Wgy7jOE5qHSHpwDnZ6qGuGk177FBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272884; c=relaxed/simple;
	bh=8zUknIt/ePwhd/LddkBiHSk15y43HRK6Lo4gAVu1+Fw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gRSUhh2OEEHGm4tbRDSH7Fb7nFWAa8H+UO6vqcMplSIzoBSgiQfaEivnNYU5aSzYsx0esfOr2LRYAYtqK//jJb4TUN+fhIeK7vm1lqjHqD6OPBeFlE9iRzK3LXiAV3MBEZCXmY64urcBP+oSDdzOWvS+KoHfuV/ha/gmrQD7hr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzGFm7Nb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzGFm7Nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322901F00899;
	Thu, 24 Sep 2026 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272883;
	bh=PUAIRbR38n1VnKaj0e/uBt+4cjIAazyRZgXOu191Hr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YzGFm7NbXwRBfmsZUDU7VfN5Ic1SydnxpYrWDfGo1Wxfz/M2bwnECOGmSNMx6vla2
	 xnjS9fut3RcOypw8Xp2XKThJlaIJrIIuqxtnqK3zqPd7FcubZA2u2gsG2h7rEdK/hi
	 +4fl8vykJATM5FVLgkMnBkpO7JCfvbGO/DyfnEMF1LoKYBQHWvIkybLSClJRndDdXB
	 KYIjJY6lH0KnCFtRe/k5G9pqILHVSiJcn+J20e7+AlBoQjTk8SeSpn/2RSe0uUyvbA
	 S8ha1LiYkLyxsXbj8bWAL8D8X0bmuhtXnQuYQ33k7/OMw92Ho6INAghS3vkE7j4O9c
	 cM8z/0S0dSmGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695C3A566DD;
	Thu, 24 Sep 2026 18:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: flush skb_defer_nodes in dev_cpu_dead()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027281189.1685480.10772123660048220576.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 18:00:11 +0000
References: <20260923130318.607255-1-edumazet@google.com>
In-Reply-To: <20260923130318.607255-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, edumazet@kernel.org,
 kris.pan@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 13:03:18 +0000 you wrote:
> When a CPU goes offline, dev_cpu_dead() drains its softnet queues
> (completion_queue, output_queue, poll_list, process_queue, and
> input_pkt_queue), but leaves net_hotdata.skb_defer_nodes untouched.
> 
> If oldcpu goes offline while holding pending skbs in its
> skb_defer_nodes lists (e.g. below the sysctl_skb_defer_max >> 1 IPI
> threshold, or if the IPI races with CPU teardown), those skbs remain
> stranded until oldcpu is brought back online. If any of these skbs
> hold page_pool fragments, page_pool_destroy() will stall indefinitely
> waiting for inflight pages to be returned when a netdev or driver is
> torn down while oldcpu is offline.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: flush skb_defer_nodes in dev_cpu_dead()
    https://git.kernel.org/netdev/net/c/06e3f54e8b22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


