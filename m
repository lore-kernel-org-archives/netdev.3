Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87F35957
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918650; cv=none; b=L8fgEJLfku+RSh7gS870ClZ7QZFnCiZooAlmZWJnvhq4nzLA0iOFIZATTFNVc4XwMXbrncrFsX+PSjkbxmyLjAvsCHs6UTlav3eBBgO379476yFTweHdJbB5u77MvlapSEMz24eVehEMpcAuXr+i7fKtE6dluQypdEjl5cAg6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918650; c=relaxed/simple;
	bh=4NyDlqqxqz+E2io9iYbFcByU5IqGKyFhqmer2c98i+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5hl22VjZ8m7jq03H7I7jA6kNwodMe1kaxRypCcIbotpONgOFZ++3pa2sRXDlUFWei3WYxZ1agr6/v/zVZbcCBeoVOPzmJFIT8lRVCHEmSWa91JUaryRGH0XeY5FtuuoIjYUPynSasC1c9iQwYHDrJrHBaJFNWr+PYMFYRNvQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KycePIB6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KycePIB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19520C2BCB2;
	Thu, 23 Apr 2026 04:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918649;
	bh=4NyDlqqxqz+E2io9iYbFcByU5IqGKyFhqmer2c98i+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KycePIB68nu79kmCIm8xoQku4oIHH+6gNXpjyxBCV9bWNyuTo+BPk/0QS8qOVQXBT
	 A6Yhkd3zxSt0FVcST/3WpmP1DIHRqI0SbszVdMpuntJWK/EFJdYzIk7oZy/tLJ+9Is
	 bNlTSzWUpgKfsxwV09m3ASkq2HhfnjTX6+xJdrRvMSSAhd2gjYXrVVc3+9Y+VBmHu7
	 ul/v42Nu5UQkxB/cMJjxbGnIgSAlOWz1MZro0g721mtKSO//aZ1OrN29g3tw6+9gwP
	 lvKENUE0kU3BrNNigYMqPM/a6XDwd2cfrJsfPtwIMrtPTRNfzPTVzxMCz4UmmMpdp9
	 f6mJb39LD2fTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC63809A86;
	Thu, 23 Apr 2026 04:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_red: annotate data-races in
 red_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691861105.4157517.1463150138385112453.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:30:11 +0000
References: <20260421142309.3964322-1-edumazet@google.com>
In-Reply-To: <20260421142309.3964322-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 14:23:09 +0000 you wrote:
> red_dump_stats() only runs with RTNL held,
> reading fields that can be changed in qdisc fast path.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Alternative would be to acquire the qdisc spinlock, but our long-term
> goal is to make qdisc dump operations lockless as much as we can.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_red: annotate data-races in red_dump_stats()
    https://git.kernel.org/netdev/net/c/a8f5192809ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


