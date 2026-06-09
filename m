Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EB2E9729
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000408; cv=none; b=CzRrrrbvn4j+2Fx4G72TnUjx4nAGm1kx9g5PnT3f+kxnHfk+TFco4gMHMEHmtmrzym7YKfu7VtzfhqvBPypBXSxI87TTYBOyv3Hj236+gNTB6UF8r7uDJCCEGwjluOzuJ8DxssU8qeU9fBFXsdDvrEcA35voXPE/+2jpy1QFkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000408; c=relaxed/simple;
	bh=lESJ6wiWVmWjLS9C7xguInk/92xub3MnZcLz5JMJ2K0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C5MBCz875G0EI6SXE2V2s1b+lyYajesOllDVNtQWklOEaH1TSmxvWDdyRTwTnL1/ST6yD8bzEXgFayPH8/NStUQnrGVJcod9NMe79ukkXybbuuACFSmHWS90l/t2+2InuMPvvrJ30KziD+frZuZqvDfslzfemD7Ii9Vg3xr6EK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7jqYXj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7jqYXj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F181F00893;
	Tue,  9 Jun 2026 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781000407;
	bh=hcZCPZbAXpRMsPBMLdVQlgVIeSEL2c2sr6R+Tr9s+jI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O7jqYXj3QGPi1zR3gffW+VRA+q4jXH4na2yLtuafV7mo0ztoH9vhJ3bw/fXqt+BSQ
	 xhFqbw8i8xQbjESSQC1KLF35/uJgILKEJs/iIYWWH8hdXWe1NUR/IeeqLXsj1YQ/Rf
	 ckNBr4wvRj3DMyo5pT18kiRucIlAEIwFmajyoC3hrWkVpxgHgRkweSGK1N7PnYzTx7
	 9Op6Z21Q2RZkrG777KlEvyMjAlGnk9pZncEkMzc2pfk/Xnbrcy+IbQmiixQVL2XqQR
	 D3KXZJj3HeS1kfzAo0UhW9nZOl/CmsDVQFd8ABZc10BrS4tWC6W+r2PTVnmeZ3+np2
	 LrNmz0EmimDNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D096F393078F;
	Tue,  9 Jun 2026 10:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: Update function name in
 TCQ_F_NOPARENT
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100040540.1935013.2799395346981956131.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 10:20:05 +0000
References: <20260605212239.2261320-1-victor@mojatatu.com>
In-Reply-To: <20260605212239.2261320-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  5 Jun 2026 18:22:39 -0300 you wrote:
> Commit 2ccccf5fb43f ("net_sched: update hierarchical backlog too") renamed
> qdisc_tree_decrease_qlen() to qdisc_tree_reduce_backlog(), but this comment
> was missed. Update it.
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  include/net/sch_generic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net/sched: Update function name in TCQ_F_NOPARENT comment
    https://git.kernel.org/netdev/net-next/c/06528596662b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


