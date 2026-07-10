Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DB3C553B
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698037; cv=none; b=CqCTGBxQr1NPbSBgSdD8NVXyra7ZPYRmEeEAOan8Cqv3DqY7LldWIVJQYrUITsmUWI7glBnCP6Rcftyub1mRuZ7cH1kqtET89o7FcA11PDL1BwtzrZm15O5M4LCugYepTTo+8Id8zzmv2IoIAZRX5X3LgKIKP0zCIBFZP4VvzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698037; c=relaxed/simple;
	bh=BruHszgQKXC5nMgfHOL7Zceo55mvSdLe3ZsaDNvyDLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ccIhFGgPv5wx2MlZQZurEkYwcLXWi88WbKn711JuKvQE7NDR3RFJzzzEzGYrWSHMaiEYn9ByP4VFHFAe3ax9sc2yoWnGsW+wpS6KgJezW5Vn0NrCdJoRZs5Ws3V3vA3MvRkLrcRjWPRKQUACwbUB7mVQ2G+/4CVIkZOiFbtqeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOaR2DDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOaR2DDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB741F00A3A;
	Fri, 10 Jul 2026 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698028;
	bh=MQEW4HHqbSnKqGo3a+ya3bSiB4jx6NB3sjKoJPprHb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WOaR2DDWAH0i209fSjkRkx+RbyDc/BUToDqg4MEaU2qrQdlcmjJFDwTkxYlT32h0w
	 rj8AeQTBTET19GMKR+ZtHog/OtPYgqTmCtLsPdb1KXA4sAiZrY1jLSHVvmwpiAIhqy
	 zH3bndXReY7trozWCx+oNRB+KRtE0HtnEjJ6Kx/L5s2EcVXMyiH5i5wO0VEzktV2uF
	 FAjmgF+bDpASKCTkThID585YRYAnqDZAWxcfZrhN+p4VqanhTFkqYoP8XJODnMaVrz
	 HWTtNzy3CyFEG4wlcCCgOn9YJcd/N6FAFUF/60DMX2JO1qy36mjZmbT2O9m5nz+1sN
	 AU+kfkihl7UAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D090E3924F9F;
	Fri, 10 Jul 2026 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tun: no longer rely on RTNL in
 tun_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369800638.742691.4280078697381191859.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 15:40:06 +0000
References: <20260706163517.2415530-1-edumazet@google.com>
In-Reply-To: <20260706163517.2415530-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  6 Jul 2026 16:35:17 +0000 you wrote:
> Update tun_fill_info() to read device configuration fields (flags, owner,
> group, numqueues, numdisabled) locklessly using READ_ONCE().
> 
> Annotate all writes to these fields in the control paths with WRITE_ONCE()
> to prevent data races, as these fields can be modified concurrently via
> ioctls (TUNSETPERSIST, TUNSETOWNER, TUNSETGROUP, TUNSETIFF) or queue
> attaching/detaching.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tun: no longer rely on RTNL in tun_fill_info()
    https://git.kernel.org/netdev/net-next/c/23dad2d088df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


