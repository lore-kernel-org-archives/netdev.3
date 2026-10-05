Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2977443C11
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243007; cv=none; b=UfWLlUQgDnftSr2a6qEc050tUVgb1k5OMLL/FCPibzjpoQOj29R14sW04s5vpaC4zG0WfepWRfI5Opuipx2aPqxuJ7Yh/iHooEhNs/Iiz3rLKCpdMhIrbwX5fdYQvE1BFQu+EbsF+sZK+QSN/fDE/ZF6cctB5VdJLZoLUKh/izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243007; c=relaxed/simple;
	bh=DhmLatEzD2rjmdLPINlK+/6inQkxqghJtxOIbcF1JpU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P1M6FRpXedEIg7Sh7+bn/291x6iaeLkdDMzmN67QYM6JDVtfcK2q+2HPHhlr3Gx4ue02lApl1HPCsJWYDPSscCDxfzZoCK8JfR5X1dH+JlL60sIYoHgeCe0nSQ0NvPhH4xCmxgIYXklAhUwd0PhUyGiqb5c/i7/X8Da5YiyWByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnHXEblH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnHXEblH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F01F000FF;
	Mon,  5 Oct 2026 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243006;
	bh=4Uuxg5FNMXPQkYNrfMaVOcepfBTv43FMsDT6pU0FuFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RnHXEblHmecjOViDH0LgLoGmvxuCXX393SITiUvB+Na1+QZe82CaGrMi4MiEiFsfK
	 /22/njx1GoFjcIvQg/h0naP0qFjtMF1kjOzsmeAsWtOgOTgp5ak/b08W0SPRSjAIci
	 cMmK/vyiFaxYasEHUyRiTCmOmp/cOWh1TlLebfQ5lHxN0cCDmBj270JuKFqh4Ng0Qa
	 2VsdHKZnpke5IIG9L8wpdRY/+wGDuFDiSR7iHVWj1ja5MycxHtQ4HiaiEYW04Kjrq2
	 4KO5xeiiB3Bvi17XtQcXrTLXXyvkRJP5dKBHwbJBv6P5jBEmUhHn3IFY5FadLV+8z+
	 TO7/PZdVmWvVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2C0392667F;
	Mon,  5 Oct 2026 23:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipv4: free inet_opt and ireq_opt after an RCU
 grace
 period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124300502.1937173.6888058929378452446.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:30:05 +0000
References: <20261001221253.2964024-1-edumazet@kernel.org>
In-Reply-To: <20261001221253.2964024-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, jiayuan.chen@linux.dev,
 edumazet@google.com, netdev@vger.kernel.org, xinyang@anthropic.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 22:12:53 +0000 you wrote:
> tcp_v4_syn_recv_sock() transfers ownership of ireq->ireq_opt to the
> child socket (newinet->inet_opt) without copying it.
> 
> Another cpu can concurrently process a retransmitted SYN for the same
> request socket, and send a SYNACK from tcp_check_req().
> tcp_v4_send_synack() and inet_csk_route_req() read ireq->ireq_opt
> under rcu_read_lock() only, and ip_build_and_send_pkt() and
> ip_options_build() then read opt->optlen twice.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv4: free inet_opt and ireq_opt after an RCU grace period
    https://git.kernel.org/netdev/net/c/e3f33b0a1d89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


