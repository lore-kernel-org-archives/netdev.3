Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F82206A7
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337466; cv=none; b=WK9nwm+zu62/nF/aDZNuNbEpzGziImAFRDVTKe8sVSq3xX+amnU0VCSJtQIGubEaflp1Nv9zUWaMlRYrJ1+1WPfAYcBE6odt/AmWsD5ijbNtoITEWsIWqPORnxVbKpfg7M2nf6uJ0wYVLXX1vUYw2hZRuKRJqj6uOoPxH9mRBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337466; c=relaxed/simple;
	bh=ZOBtLKYyJXH0wWjW8phJ9cMUGqgoPmUIHSSl63m5/Io=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sdgbfVvxMi/QksvM0ii0spRyhNSRCOQ5eg4H0Jv+yp27y9yUJXnIjwE3aJEXGoX2INVOxjclcy/YWAVSQ66JOZ8CR51f35XGnZzQ3yNM6qtWuID8PCNE0QeFPZDaxDPW+499hiCS/5nFFY8/ToYcbWdNEffOPYZ1T53vLdNix8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESZn4Vuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESZn4Vuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3989C19425;
	Tue, 28 Apr 2026 00:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337465;
	bh=ZOBtLKYyJXH0wWjW8phJ9cMUGqgoPmUIHSSl63m5/Io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ESZn4VuftDeu5848WTjaGz2CX6sWHlLT4hOkAWyGAorvs92yxiKul4mnMok2fwBxf
	 OXSROAN5lMZ71gMNjAr2fuhE5ssjVgaatUyj6hWnHXfMJS0qSPdYnqLBCkCm5EFNnv
	 P2DYE0wDat/t8lG54DqBHLvZML9yYMEJnwTSO6u34ZSTCsFtv5S0w7JQ5N+4o+1uVX
	 9FkPWoPJMsfby+Kcj+gx+E+LLRaIWPaZXpuSPQpxJMwtsjvecDhjkvkyl6++SSkwoU
	 ViJFxyiuSYflLeStpJIdfPdTS+QkESONQE+PUkcuBDTnhnXES1eOeteTrqmjFN4mLb
	 TNNsg21bIRa+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1F38119DB;
	Tue, 28 Apr 2026 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_fq_pie: annotate data-races in
 fq_pie_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733742279.177472.15858457083061821304.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:22 +0000
References: <20260423063527.2568262-1-edumazet@google.com>
In-Reply-To: <20260423063527.2568262-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 06:35:27 +0000 you wrote:
> fq_codel_dump_stats() acquires the qdisc spinlock a bit too late.
> 
> Move this acquisition before we fill tc_fq_pie_xstats with live data.
> 
> Alternative would be to add READ_ONCE() and WRITE_ONCE() annotations,
> but the spinlock is needed anyway to scan q->new_flows and q->old_flows.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
    https://git.kernel.org/netdev/net/c/59b145771c79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


