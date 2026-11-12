Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493210;
	b=bBOG7Q7zAesoYs/C0JmszDsA6eKdEcIT8b2ZjMl5qCuUY/90O5CQc1fJJILCc62LleXR
	 roLzEtY76hP3bX2N/ZWeDK9S9TIxcfSEqf8C4IJ/Yn97DQORod15yvjsBjaqSzDb1gq64
	 Nz0FdD5KClT1qhsAn5C85xgqv6+YTvwiQVdhtNxyjpv4de5XyMcVSJsIwO2oVU2EkmTlR
	 ps73dqYybTUO3aLc2tka70+BCjZa4qXt7+DeDz1yEF9XAv1T7aLr0vXjisGvwEx8GzMGX
	 Ul53rWuBFvujSk+Tycvfs9udLyBBfgz8HfX4IuxAuhF1JVK/EAR/PaGeX0ygtAjJJoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Js3kGoBlfFAAejmsf+gtRFE7Dn86sDSK6SYM7/RrD5k=;
	b=dfrs2oKouH0sFBzlfF4tvGtZgzXxJutvMAuctHrXcJzZ3EUZahw9SRLSTrQy9AoYOAJE
	 5PjHYrfSdIo4p3fw+8KtJEgp2AhJb2LGl7d3LaG25++Ghw3W855wFlOYb9d5VZK+0Ikkj
	 NCAluDAzjb4RL6srtU71vQezt1w4BmgT/gam90nLwToPzjUdq98WYr890c3WXcg0va/7y
	 t6iqJaan4SLWsC8dOTj1R1xgklL1Odmu7F3IwokIG7BatGpHcNd1+mfI9G35HgUQkpZtR
	 AANMVmIq7xi5Bq5Fl99s4dKq428jC3WJ1UD/pBPnc/K919fkvGBsvF1irEsIT6tWT+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayh3wYNq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DF60737B8;
	Thu, 12 Nov 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayh3wYNq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AA81F00A09;
	Thu, 12 Nov 2026 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493209;
	bh=Js3kGoBlfFAAejmsf+gtRFE7Dn86sDSK6SYM7/RrD5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ayh3wYNqwhkIZiaS8CUqD/4za1ASPhqkiIMeQGIUYm0ZrVZD1a0JMBC+QiIzhL7o2
	 mYScZit3vPStAHiNbN7J9oAXSeVS+yvKWTsl0CGjAid1GMbI3A6l0WPUI3bYaNgTsu
	 5Pt2iEje//tyuWKtcAolECGYbzYFguMfib0yyFRPwlirIqQwAqJMH/6XoP3qZN1R+K
	 UhyAW6gIms3VHl4i+9oRt5AIzl4RuWW3EDHDgaiT90nPjnhwmUXa6FkUd49Jpf8jrb
	 CONmPUvGQ06BmaefpLSXbO7gFNhrbl8CwRlIzfcErvwArrMDTVLky9AF16o1Vigikh
	 MS86oJuWNVBtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0FD3AAA0F1;
	Thu, 12 Nov 2026 14:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net/sched: get_fill_size() budget fixes for
 act_gact and act_vlan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179449320817.2132344.7127803096351736529.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 14:20:08 +0000
References: <20261106064114.3592670-1-xiaolinkui@126.com>
In-Reply-To: <20261106064114.3592670-1-xiaolinkui@126.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Nov 2026 14:41:11 +0800 you wrote:
> The get_fill_size() cleanup began with commit 8e2efb3f45a5
> ("net/sched: add get_fill_size callbacks for actions missing them")
> [1], which fixed the actions the bug was reproduced with, pointed at
> act_gact/act_skbedit/act_vlan as the pattern to follow, and left the
> other pre-existing issues to upcoming patches.  It continued with
> commit 4ba61bfd4998 ("net/sched: add get_fill_size() to the five
> actions that lack one"), which spelled out the rule the callbacks have
> to obey: size every optional attribute unconditionally, because reading
> the current flags to size it conditionally races a concurrent replace
> that can flip the attributes between sizing and dumping.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/sched: act_gact: size TCA_GACT_PROB unconditionally
    https://git.kernel.org/netdev/net-next/c/70fcb28c2e5c
  - [net-next,2/3] net/sched: act_vlan: size push_eth in get_fill_size
    https://git.kernel.org/netdev/net-next/c/46c584656826
  - [net-next,3/3] selftests: tc-testing: add gact probability dump tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


