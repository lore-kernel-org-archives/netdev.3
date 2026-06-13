Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B884039
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313010; cv=none; b=TliXU4VZuPUqEs7YhAMUyLNoUAv9Hy3GqSe5IhYc1LajMMSMcP4q1BujL+N1AOJ+BQuLgA/EmCJbb81qsdjxmW8Xce8rp8B8TYnCcs9U2v6kNTw3pkfw5+61AmLWpNVSt7bcWZyuD/5aURtSGL3u1TDbPc39Aci0wE440UhvnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313010; c=relaxed/simple;
	bh=65dnFTrzf37vU9Q284JG1/bn803hC3aML5Xn9STMB1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QqFQ5YgaO/tqR06tPPgyOpNQH5DKxNaf2Z9wgp77F2d2mavapG1k7IGHn4JTRUqcpBaPL61NjelekRS+Y8bdsqQFzvzlOvM/RyaAKP7CJoYn0I7kgUF0da0IUhGoclofM2orjnJvmEA61LWtAhfFob3XT3nVmZkLj2Fbo7PiL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDz0Jxh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDz0Jxh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C070C1F000E9;
	Sat, 13 Jun 2026 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781313008;
	bh=dHZIMRL/Ufwh3L0HxzauQCJnOZ8ynSJ6uLvXLE3i2l0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CDz0Jxh2eRZ7t8XNwzoYwDpgoLvmCkJGscztXSHhZKcmYKnDYXPefzB9QEc7mZ8Xu
	 fOiqs4e09H5DeJDkFzSQ/moO37g025p2OBGTC1KvWARTI6DXk/QJIh0n2E1rih/Q+x
	 +3mrNJt5a0Pd/TfR6e7It3OZNybFo+anz6aU+cRrXmpaLhnsx+9TIbP5nZwSM0c0nJ
	 yAV5cUZ1966eWksJRH5ps1tndmp3dx6DUUbPbPV5Xcy75Pi60k0t34+sZGtCn25Xma
	 cjLZoASXPGKRsumOEiuVNr6q2fQJugkuBtGtSGW0HH5C+BbZFNQarwa9k6I+yITub1
	 q3BRloCXemcBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938F539E9607;
	Sat, 13 Jun 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_dualpi2: Add missing module alias
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131300539.1317911.2829384771119225811.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:10:05 +0000
References: <20260611205849.3287640-1-victor@mojatatu.com>
In-Reply-To: <20260611205849.3287640-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 netdev@vger.kernel.org, pctammela@mojatatu.com,
 chia-yu.chang@nokia-bell-labs.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 17:58:49 -0300 you wrote:
> When a qdisc is added by name, the kernel tries to autoload its module
> via request_qdisc_module(), which calls:
> 
> request_module(NET_SCH_ALIAS_PREFIX "%s", name);
> 
> i.e. it asks modprobe to resolve the "net-sch-<kind>" alias (e.g.
> "net-sch-dualpi2") rather than the module's file name. Since dualpi2
> was shipped without this alias, the autoload fails:
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_dualpi2: Add missing module alias
    https://git.kernel.org/netdev/net/c/ee1ba0add3fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


