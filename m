Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EC377A9A
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225075; cv=none; b=hpbZpj04SVuT674pdabwxFHpI9S4QPCipPBm3JTOiaB6BPVUEIQC14F9uwJGxPl2UskXXLoIqCsABAmuTD8Roh1Vn2nbmhSMyeMOT/a4Yu8XMKqfRubo+h0vl7ddrW/VKeIyMsAYB507TzUIaSAM5Cjf4b/tBi/xgF/mhh6LxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225075; c=relaxed/simple;
	bh=NzyYlQEDNLdtIzy2rMf5UCAj9HwnwpJn/WPpkostx+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TG3Hsm3x0Fq7kgu0UT3pb0AzSTyC4eSk/koPffXPnDbcmcRz8a6vTRyaeJnnwtia/DqdMrXidaph/dUNggGa32Jng8MqWyU3LF2DD/7Hmm/feW3lzFBpNIsnlAgu+oeN0E8Od9v/b3dfYKIgFw76Io/AKzXE3MqjFANpT36TOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvWYRsww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvWYRsww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6311F000E9;
	Tue,  1 Sep 2026 01:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225072;
	bh=v24N7FtAdRyKfaN48daGR+WbEiH4MkTEhHUodzvmLQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NvWYRswwqfz9yYX0y1kfZfQFk4pmx4UP8lexIcvv3T8u1tSQDwcpNTdxJg9s6AqKx
	 Sy5EyDM9Y7z4N+DOj8f4aQTUwl08M3UAVbC2w9BqfKIXH0j/0XWzjA/YPhWsgpBvQ1
	 Gt57iLCs9AGfC6S+Q2kdhmNZL/0liFJGpDM5jkZ9wfAGs3Jh8NMUwfH+LJ4LfJnXoO
	 V5xdX3U8FXIvmB9SZOV3pMEKPXqJ8YEwZZfeym6YFGxyaRMZOG7bLjL5mDIQ6pt6vV
	 OaA2p4Mxxu8F76tmeBv+WVfExu+DJKUgiE0cZZpvSDvb6lAJgU9MRhDyIArJO1Pz5P
	 +Ej47VeLBkzGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5693B3924A40;
	Tue,  1 Sep 2026 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/5] ipv6: mcast: RCU and timer fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822501489.865139.15246624962755693699.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 01:10:14 +0000
References: <20260828084531.1826790-1-edumazet@google.com>
In-Reply-To: <20260828084531.1826790-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 idosch@nvidia.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 08:45:26 +0000 you wrote:
> This series addresses several RCU synchronization and timer calculation
> issues identified in IPv6 multicast (MLD) handling within net/ipv6/mcast.c
> while I was working on fixing a syzbot report in net/ipv4/icmp.c.
> 
> Patch 1 fixes an RCU reader diversion in ip6_mc_del1_src() where mutating
> psf->sf_next to insert an unlinked source node into the tombstone list
> diverted concurrent lockless readers (e.g. ipv6_chk_mcast_addr()) into
> pmc->mca_tomb, causing them to miss remaining active sources.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/5] ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
    https://git.kernel.org/netdev/net/c/93b49239840b
  - [v2,net,2/5] ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
    https://git.kernel.org/netdev/net/c/c073d1b070f1
  - [v2,net,3/5] ipv6: mcast: fix delay calculation in igmp6_join_group()
    https://git.kernel.org/netdev/net/c/75fa9caeb8aa
  - [v2,net,4/5] ipv6: mcast: use rcu_assign_pointer() for __rcu list updates
    https://git.kernel.org/netdev/net/c/0c8f56c583c3
  - [v2,net,5/5] ipv6: mcast: use jiffies_delta_to_clock_t() in igmp6_mc_seq_show()
    https://git.kernel.org/netdev/net/c/b4cf4a092a7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


