Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D7426693
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560511; cv=none; b=d+O2zAfdBPo8p7k7DggEEnzS4G8OJcF6C7HTo2LKvnGJJtvfYgRxKcGx/J4pp9BahxhLGduWndsEUrTfAiCxmQrhJz5/7pky//NJuiqSzJGHlkHEpGUWyB5Vp1FX76oeOrRBMZSYKz8VzkB6j+ZgzcZM623NKQIIEfrHySBeq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560511; c=relaxed/simple;
	bh=Ap5nS9rm+uqAXzNdJlEsDIdw0BjWhTmK53n2z2CUzjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aYUAvaek9g6ungRpT2xUxUZ1tm3OYYNKRdIlqMB7ABAj6Lp7sbqqMbH9O3yQp+jyFthTZ9xvxE8dcgS45KhNRbNIemO3o5VJWEh+gOpuQzkCMaYfdddPYXqXzl0xs8Xm131fcVWyrCYzNej65j/+pfRF/mdaqMfN0vQET5gPf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMAQzADd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMAQzADd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C501F00A3D;
	Fri,  4 Sep 2026 22:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560505;
	bh=TAgmYD56AmyP9KH5gSLLBUSL2v5gWQO2ZUefd5slUWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SMAQzADdhCwi0knFv0Hhnz+jX41KplfLqVw/JIfQe2RcsALAFR8kX/az3qC/ot6xc
	 6p6rN9MiebR+kj4jwIq77k8mLTYAmFai6tYoflvdkul+AOF0jyF0G+iGaRxpMKgWpv
	 bFq3tnirDq4pBYybX2efi/UepBS94qjMwfFqEc+I8qsmxZi3lF4ckWkrcg4djP2A8d
	 EwxJxiCYOVcsDQCQ+8NXs0/wZLvkIalqs/mSZ02viQ2X9+HGrpQ1nS6Sf9nsCjBBts
	 +x4U6x1x/BlqD0bovZtSZbglfpGcCJlf8zNPc3uq+n8/7X92zwYl5cKHnVJojCOwI5
	 mMRWiDYeaO8JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AC73924A7E;
	Fri,  4 Sep 2026 22:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net-next 00/15] neighbour: Namespacify arp_tbl and
 nd_tbl.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856044538.992241.10296841981644153976.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:20:45 +0000
References: <20260902203722.926528-1-kuniyu@google.com>
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 20:36:41 +0000 you wrote:
> The neighbour subsystem is almost ready to drop RTNL.
> 
> However, the control paths are serialised by the global
> per-table lock.
> 
> This series converts arp_tbl and nd_tbl to per-netns table.
> 
> [...]

Here is the summary with links:
  - [v6,net-next,01/15] selftest: net: Deflake Periodic GC test in test_neigh.sh.
    https://git.kernel.org/netdev/net-next/c/cc9bccbad049
  - [v6,net-next,02/15] neighbour: Remove __neigh_for_each_release().
    https://git.kernel.org/netdev/net-next/c/985f6522d856
  - [v6,net-next,03/15] neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
    https://git.kernel.org/netdev/net-next/c/2f9ab22897bf
  - [v6,net-next,04/15] neighbour: Remove unnecessary EXPORT_SYMBOL().
    https://git.kernel.org/netdev/net-next/c/ffc5821e8ab8
  - [v6,net-next,05/15] neighbour: Remove __rcu from neigh_tables[].
    https://git.kernel.org/netdev/net-next/c/cbc2fbb685f5
  - [v6,net-next,06/15] neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
    https://git.kernel.org/netdev/net-next/c/b4f0115efd7f
  - [v6,net-next,07/15] neighbour: Remove neigh_tables[].
    https://git.kernel.org/netdev/net-next/c/7bb5d7675cde
  - [v6,net-next,08/15] ipv4: Replace &arp_tbl with arp_table(net).
    https://git.kernel.org/netdev/net-next/c/2430df635a59
  - [v6,net-next,09/15] ipv6: Replace &nd_tbl with nd_table(net).
    https://git.kernel.org/netdev/net-next/c/df5f4f372de5
  - [v6,net-next,10/15] neighbour: Clean up neigh_table_init() and neigh_table_clear().
    https://git.kernel.org/netdev/net-next/c/e265c2c432d9
  - [v6,net-next,11/15] neighbour: Convert neigh_table.entries to refcount_t.
    https://git.kernel.org/netdev/net-next/c/1c2b20509463
  - [v6,net-next,12/15] neighbour: Namespacify neigh_tables.
    https://git.kernel.org/netdev/net-next/c/cda2962b6e2b
  - [v6,net-next,13/15] neighbour: Don't store net in struct pneigh_entry.
    https://git.kernel.org/netdev/net-next/c/da5a7e7a90e6
  - [v6,net-next,14/15] neighbour: Remove unnecessary net_eq().
    https://git.kernel.org/netdev/net-next/c/fae1c59810b8
  - [v6,net-next,15/15] selftest: net: Specify netns for ip ntable in test_neigh.sh.
    https://git.kernel.org/netdev/net-next/c/10aa85762861

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


