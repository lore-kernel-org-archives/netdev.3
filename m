Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348BB67E
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776687; cv=none; b=l8AnReLph8ojHQ7+HgRZEgcIYbvG3GaaMBYYeKcLKqHJzYU8VvkzRbQazXd1eslN4vLeAY4hjbAZYoib+Fg4uZ7EbcX9rV8b9RKWHEDY3/YoD10wyZJ057yxwLa7um9E8f+ZcuGHoB1MZ3Z/u1JC4b9zMAl5YJLxr3OmhLgXk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776687; c=relaxed/simple;
	bh=u2Bkfyqag5mEr1DQ5X+oagCicNoWS8EvMaOYR6kL0m4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MyDLTop5eU88uB+9ImUp6KOf/xd5l94gQqLYhvnyCcXUqhlsXYc5AsSXh8C/9EwX7G8RlGL4Jpfs7Dr+z49fRaCPE9RwExhLycpGFJqgOLDdAYvNUaY9wAZEFLcaslZgrtsGozNVj6oNSjXDAWw92pH1rq/XgXlBG6GAWFcP1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbHxlR/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbHxlR/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A231F00898;
	Sat, 19 Sep 2026 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776686;
	bh=ysRDX3AnUKuUyJvQQBEbjj2RmECnkML4t6GdWMyASvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EbHxlR/Cf+5G1lwIRJip8h5P8J9TyLC5tTvF8216T7LU0UWWNYXXeHOhQNdIlAMNM
	 jfMF/tAesUuJY613pWlyGuVZqHR0dBenmuKTsQJBBH+QIyWkhN/UAQkj2ugAcDv0u0
	 mFy2fF+uegMC6ns1ghrjBg2Wqla+KHjQTkMteENnk+DKitn7opvIVgT1uAphrYro71
	 2OQbrOO5hSXN0X11uYRRWhqq+umVgbXmfmUSidrwHkaeOY8RZad8Ggn6qD/Bkmcrih
	 oRjHDFlAMxUKHQisQkY7wJOave4/g1x5yIA5PIXNp7dDrGg4f3L89to4udCdYgBwTV
	 mV/JQBoJZhGrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939323811977;
	Sat, 19 Sep 2026 00:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] vlan: lockless vlan_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977661914.1197442.12574021700995796007.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:19 +0000
References: <20260916132532.1785657-1-edumazet@google.com>
In-Reply-To: <20260916132532.1785657-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 13:25:30 +0000 you wrote:
> vlan_fill_info() currently relies on RTNL being held, because it
> uses rcu_dereference_rtnl() to walk vlan->egress_priority_map[].
> 
> While auditing the fields exposed there, it appears that
> vlan->flags, vlan->ingress_priority_map[] and vlan->nr_*_mappings
> are written under RTNL but already read from lockless contexts
> (RX, TX, /proc/net/vlan/<dev> and vlan_get_size()).
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] vlan: annotate data-races in vlan_dev_priv fields
    https://git.kernel.org/netdev/net-next/c/ca6ff8dd70eb
  - [net-next,2/2] vlan: no longer rely on RTNL in vlan_fill_info()
    https://git.kernel.org/netdev/net-next/c/ea5bd52c8bdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


