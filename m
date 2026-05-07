Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C863B775E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167256; cv=none; b=AkL1SPuQdl7yWrKfstVQWAhVQMmpO5oqX5C5tLoIphmGINerIUEu3330yRmXzbSyADZ1XJ74m7uYpGTYdPkxHwVzMJgSwxK6YEoWYlqh51dodtJ5rEUYL+Cc7QNdnl+RN0+02m2pHnjrZwlM6QT6ueBUXqIOjhTFbOMk9UTcleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167256; c=relaxed/simple;
	bh=OF+vlZlvOL9KKG8lwA0Gv/nZ28zzQP39fJfh9ulYM64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vh7xLkhLmR2rnIeWDCNWWkgfS1Q1yvgTJ2Hipg1fWytvZlc+5hN+pSwsv3UkiRU5qYk2nFpwZp7OH4sSywUyXSmbIe0+nO7OxplfEcvk+cR/D1S/59g0+aD/XvTGozd5TEsAi96waY4IHzvxN6ewUUBDdEBq4lGUh9SyzzEUwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOUOEleg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOUOEleg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2DBC2BCB2;
	Thu,  7 May 2026 15:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778167255;
	bh=OF+vlZlvOL9KKG8lwA0Gv/nZ28zzQP39fJfh9ulYM64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FOUOElego3BPYUy5r1oZshVIvrfsEsXglseShWDzSd7N+iqiNYOwcUZi0S6FAe2qC
	 erbZ+jBp6aMUVVbPp2k7oJIOY0CAsMUNVIj91MgaEU9uot/FghJnfv53/3hdN7PpZr
	 AeXAjbYlXmtQZUSYACKY+ujChqCnQ2JGnMISNFy4rqM1ABaTActGxvRmknT9N/sEDd
	 rJAb6XwgwL3AppaDSXvIg5tav9jdS7h4xpjUlivuh5S3uSoTnN65ZplsuGK8bBUDEP
	 ol6gXacf2XhaUBSmtJbtxAIh+Qto/XtFkblv280mvZaBOmAFCTFEy0ds3sK/r0fH88
	 UFC6oJ27QVueg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C5C3930906;
	Thu,  7 May 2026 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] tc/class: use rtnl_dump_request_n() in
 tc_class_list()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816720480.4034455.16026111878922440843.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:20:04 +0000
References: <20260506160656.1226077-1-edumazet@google.com>
In-Reply-To: <20260506160656.1226077-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, jhs@mojatatu.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed,  6 May 2026 16:06:56 +0000 you wrote:
> strace tc -s class sh dev eth1 parent 2:
> 
> strace is fooled with rtnl_dump_request() way:
> 
> sendmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000},
>         msg_namelen=12,
> 	msg_iov=[{iov_base={nlmsg_len=36,
> 			nlmsg_type=RTM_GETTCLASS,
> 			nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP,
> 			nlmsg_seq=1778082626, nlmsg_pid=0},
> 			iov_len=16},
> 		{iov_base={nlmsg_len=0, nlmsg_type=NLMSG_NOOP, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=131072},
> 		        iov_len=20}],
> 		msg_iovlen=2, msg_controllen=0, msg_flags=0}, 0) = 36
> 
> [...]

Here is the summary with links:
  - [iproute2-next] tc/class: use rtnl_dump_request_n() in tc_class_list()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=eff6e4dad32c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


