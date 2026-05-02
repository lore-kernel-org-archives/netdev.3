Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378B175A87
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777681252; cv=none; b=MellyoQG8Lymyn2y4z3OlfNk3nFxWt/bghka1uSBRRo6j/UNTCkFJ8qrgNW+rMCXu96FGMy3Bh7lkODxcdt3VjmUYw8w0bdFSScTCe1aLsYfhzbovkCKsGBZLE5+sM7enxgkjyzRBFEE6ojkqv2hXYocjKwfi3m6u1FK+MG5gUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777681252; c=relaxed/simple;
	bh=PMYKriH5ocJpTe6LNMt7He4CYHjj0qMBprNOF06R9jU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CmNNe2dkDjHEh86k3hGBW3ZZXY1KIhcHCOY1Rguj+uFnn2LVQ2q+OgUxuO8RSq5JdKlQdJDyaCknTaUnYjdFHL/RVbR3kpzuaTQcAq/ZoaOODLAKDSp1TdHogAn7vzEDwRpOFMjhoNFaAnXQryjjMUroFMK420mPv9AImyqz7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaAnGMYf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaAnGMYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B000BC2BCB4;
	Sat,  2 May 2026 00:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777681252;
	bh=PMYKriH5ocJpTe6LNMt7He4CYHjj0qMBprNOF06R9jU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AaAnGMYfG6+NrHZWkYsDTnWWIySl8D8fgsmpFUOdh9deHE9DdwsKcygF73f7XzbCy
	 bx62N9eZnA9A7VHEoovWCORUkuHquEITyyoIFxBejgEa7u6gekygyPsvOG1HB0DdQv
	 hv1Xcv3M6ejMfypLBTZ90DuIBLlssYgB2av5/xLOBCrZ+M4OD2toxxdohZnRLFMdhF
	 E1bkNLy9tpQ/NvHbnpoP6YnmbBx9tpnodq/FbpmFqVbz+96b9Tb320fAEDgT3jpVAG
	 heloeokuh8ylR8O9WHW6MrlFgwIMl1wXp1x4XVZdpyuLXs6RZavvpHViRDuKeeK2Sg
	 fzu3nj9lr8bFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 032A5380CEF5;
	Sat,  2 May 2026 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: igmp: annotate data-races in igmp_heard_query()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768120554.3671363.16932265440606292577.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 00:20:05 +0000
References: <20260430164836.872079-1-edumazet@google.com>
In-Reply-To: <20260430164836.872079-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+ae9a171f239b14485310@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 16:48:36 +0000 you wrote:
> Multiple cpus can run igmp_heard_query() concurrently.
> 
> Add missing READ_ONCE()/WRITE_ONCE() over following in_dev fields.
> 
> - mr_qrv
> - mr_qi
> - mr_qri
> - mr_v1_seen
> - mr_v2_seen
> 
> [...]

Here is the summary with links:
  - [net] ipv4: igmp: annotate data-races in igmp_heard_query()
    https://git.kernel.org/netdev/net/c/c6bebaa744f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


