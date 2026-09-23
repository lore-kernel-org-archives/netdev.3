Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DD334C1C
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207477; cv=none; b=Tafl6ZWkoz5yljWCB8J99rq74cgtemekYvs7W2/kUb/+/dRWaFrWEzKL9RUof22K/yN7+rLUYE1FnITZ4aLvijQ6KLxK5JSjGRmRw8qNEhtzovEgS4dzkAcbKupAX8bcdR1htI5MhmK2RITpQPFQDpMZGw/MHuWECDUH5bBwbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207477; c=relaxed/simple;
	bh=HRWap01Ch2guv4NiHbEQgrEqMQX0KxOfAo0cLDAb6jM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=laCAcFt8XutCLAZtiiwbI97LI4tVMkjJt3UV+BjdNE+q21DpSgJc7jNeQuD0srDtcTUw22tjHq3FmFAGwn3YJ5iRNPjeM9mY8DIeeeDRlkkO6rUfRR8MnKmylfJze0YcgF5cM1c0l8yu9RGj2lpl1N6W5VlOB+sYeiUd2Z/JZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByU5WzBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByU5WzBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF201F00893;
	Wed, 23 Sep 2026 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207476;
	bh=HakspCagm3ScCF2M/Fa+q4tSniApF6HaE4ECUDCvJLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ByU5WzBGc3PnF5NAUcSSMQkg46BHx21T+FVUiG5HO7+QQtd0hxwMI9X7iVHm3zILE
	 mrB9imXSrimFUamWAmuTPdOp4/a4Y6pf6hxBSKIOAndqFCwXD830hlHT8LMrVxvRZu
	 z9hclidEaqDw5pQf2bh71uK4WbiVZN4vdcweV7Bc89goJ1kVPTp7JghNmiNw0kkS3F
	 ltZbFRkOQO0S5A00+0/SQGGdYBgxqEabsoOJE6eykX1k4wkjhtIiSWcoGQhbG+qbUA
	 9AbFqmRgIyfOWrpEfI8HceqBbXelbdc0XeWDQi4axW+YOPSD6AZQ1KF1hj/P+CzGcH
	 Q15adTd2UCZiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A7E39E9602;
	Wed, 23 Sep 2026 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_gate: budget the per-entry list in
 get_fill_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179020740618.999807.15161561763499463273.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 23:50:06 +0000
References: <QDISC-3BLH.v1.20260914203033@mojatatu.com>
In-Reply-To: <QDISC-3BLH.v1.20260914203033@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, horms@kernel.org, hybris@mojatatu.ai,
 sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 14:07:01 -0300 you wrote:
> tcf_gate_get_fill_size returns only the TCA_GATE_PARMS size, but
> tcf_gate_dump also emits three 64-bit timestamps, the clock id, flags,
> priority and the variable-length TCA_GATE_ENTRY_LIST nest. The per-entry
> nest is unbounded: parse_gate_list places no cap on the number of
> sched-entries, so a gate with many entries can push the real dump well
> past the skb that tca_get_fill allocates from this size.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_gate: budget the per-entry list in get_fill_size
    https://git.kernel.org/netdev/net/c/cfa165cbfbed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


