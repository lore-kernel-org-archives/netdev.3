Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D483019AA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067752; cv=none; b=RKXZN+LxZLxPDdu96Pdzn+gTvXG3HcHcLck4pm9fHsnAyJYyCbOLkO7MiqSyI+s2oovCXpfNerXpTAN467JS3oXLMGzpXrP67iSWQzanjYGzY7+jKAs3f/iEVfAKP4aI9oEhNRHwZGlo1tyNQKdGWM+lZ5viisxsFts9UjcYw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067752; c=relaxed/simple;
	bh=ZedgvzdroAmWQAwpAKO4f979IxRCT0NG79Cg9IVYYcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LldqkDmNUOeRZ4M0hg/brUXz2Wi1rhSaZzHUYfbY4sl7c8QowIy0wNszXkziJD8HtVz8G8QCZTiRRzJPL4r+1FNrRta8NjZ/5cu1CE9iAhQKG7/+C8PVIZ23ayU7z54Y7cygUHJUQGqCgz77WqwaghpbUfdr6yc3pQUWIFQuhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFh57eHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFh57eHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00D71F000E9;
	Fri,  3 Jul 2026 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783067750;
	bh=CxxMVJB72QyFg1TyIOBoEzRg14WUyK0zXhkZQEr6HLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WFh57eHdP7yWWbPme4JBazmDrmR5yIOXktbZ1JNPU24skMzPP7ytgG0APBwvTRbZF
	 AfTLPs0X9iFasExx5EWWztjr+YsAlOZ+OgxHMjdqejcAoi00OLOWncPASEQUWP6upu
	 /nMPmNjn+olALWIfGkL4XyYTLh3tlZvpHiaU6bTC/ZtKMFMYu95AIUM744XCqaa91d
	 5HHzS192r5QBacImc/66jkvUwbearukISuOpsTP8kBqando2P4Hu+T5AKGjJRhG7ox
	 2OJPNoj0A+OzOxKHe9PAmYxGDLleUrEDnH0mVDx/0WUj11vbALJzz45MPNK9Tmssu9
	 gp8ckl+sacZCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AF039389FB;
	Fri,  3 Jul 2026 08:35:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gue: validate REMCSUM private option length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178306773313.2512156.14413228998878751784.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 08:35:33 +0000
References: <20260701022617.53171-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260701022617.53171-1-q.h.hack.winter@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  1 Jul 2026 10:26:17 +0800 you wrote:
> GUE private flags can indicate that remote checksum offload metadata is
> present. The private flags field itself is accounted for by
> guehdr_flags_len(), but guehdr_priv_flags_len() currently returns 0 even
> when GUE_PFLAG_REMCSUM is set.
> 
> This lets a packet with only the private flags field pass
> validate_gue_flags(), after which gue_remcsum() and gue_gro_remcsum()
> read the missing REMCSUM start/offset fields from the following bytes.
> 
> [...]

Here is the summary with links:
  - [net] gue: validate REMCSUM private option length
    https://git.kernel.org/netdev/net/c/d335dcc6f521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


