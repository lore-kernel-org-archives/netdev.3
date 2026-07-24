Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720374908DC;
	Fri, 24 Jul 2026 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935840; cv=none; b=k7zZkTg99oCkGyFMogm+uetBvTkq+jVmEf8idZ4/N+XcFJOAa+jRghIAEg6HukD1Ki+vqQGzB1nyPxm7mJjFNTsUgu3TMxcl/g+RNO17p1FMmMXM4OMIbkBO+oshzDtg94pS6JU0/QL9rDhTuM1JyvuLxGcwiJ5To37vPQQ70NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935840; c=relaxed/simple;
	bh=gdyFq4oIPvu6VoNH2Ed2nHk23xZn9x7dGIOH9hmqdXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bi0FvUm5W/3UzoAnJup+WRfGMDM0318jk8/f0F52nOLlb54Zf500LjSlIbHV6MgCUk1fXN8ARCSVzQegi9vTdnzp58Kxvm1nuhHU2PvcXizbFfYMV+Kaop+wb6A9yWCki0dLO+e4RQiKluR4XEVxq8whTi41YcJIbVdvAR+ao00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDU5Phuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDU5Phuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B341F000E9;
	Fri, 24 Jul 2026 23:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935839;
	bh=Zpza3zZJFRgQqkzyQZ775uNn6khMStNPVqzg+X+aL1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gDU5PhuoxYuU5HXU6wlqrB7kSUGwt4D/9WI/H+Hi2UEQ+Da+Kq69IbkIHgwug0Xpk
	 EMaEtIztS1wDQCvORaDyhfIZAm8CD/udxb0BWcycH7MeKlS4dUrAf8AQpCr8MeNQcA
	 DoQqDfmsbrwvlmH8jMgw4leXDtH0D3Lu/QPd6LHdrl90OL2hFKmPFr6GZUf5aGO8UE
	 vwi84re+unl1xXisqIzDmrCEDqIPYf7sJBItPXJFuK8ZM1i6I4N9SklA1yZIYAfJaL
	 DepAAUn6Nip5ecgooBXiRu7nuqINpqvf4zK3n0UgbCm0KDnyb4iJYAQFVux6T6knN0
	 9yveJ963tpFWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD638111D8;
	Fri, 24 Jul 2026 23:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/sched: sch_cake: skip clearing unused
 tins
 during rate adjustment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493580589.3350809.5507808088090892286.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 23:30:05 +0000
References: 
 <20260720-sch_cake-skip-clearing-tins-v2-1-e6a8b0275c73@tu-berlin.de>
In-Reply-To: 
 <20260720-sch_cake-skip-clearing-tins-v2-1-e6a8b0275c73@tu-berlin.de>
To: =?utf-8?q?Jonas_K=C3=B6ppeler_=3Cj=2Ekoeppeler=40tu-berlin=2Ede=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: toke@toke.dk, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mikepham4321@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jul 2026 23:14:52 +0200 you wrote:
> When cake_configure_rates() is called from the dequeue path with
> rate_adjust=true, it only needs to update the rate parameters. The
> loop that clears the unused tins is both unnecessary and harmful in
> this path:
> 
>  - cake_clear_tin() overwrites q->cur_tin and q->cur_flow, which are
>    actively used by cake_dequeue(), corrupting the dequeue state.
>  - iterating over the unused tins and their internal queues to purge
>    packets adds needless overhead to the hot path.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/sched: sch_cake: skip clearing unused tins during rate adjustment
    https://git.kernel.org/netdev/net/c/a3729e0df005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


