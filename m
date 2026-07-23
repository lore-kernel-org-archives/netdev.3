Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55243BDAA
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815866; cv=none; b=MYciIvDMdu0xCLDESqPqQEC+VuFp/d2oR1GWPJLOIVY8VjH0PoJ2uzq3zOu8N3VuqLEVK6VCRJpTb2/wCB4/uHv4BGhSzLxWgQmcWDm8Aj1zOk4H0mdKkTsEObQtDnE6hhpqN6vGdaNDYfDDTQ19cDfT/OT8sV9r+aAHvTOx7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815866; c=relaxed/simple;
	bh=7MhETeP1XSY+Wb4zpZisxXrCRgYlc0TPBfv2wVlVD80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CNDmmvizW5veU0aRte7u7I06sqxYbsSek/NGoF4IiOLLvdUoMYIlMmhZFuGVFYgQ/L2CbKwJ8v4jJqIkX3ROnFX+j2P8HVXwUGU2BrQD5LH2pE5PVtmJfatyIqud0pfMRngVBjg/ZzyZPY3ZsoPg1ONgHDjJcDA9LnXoIIpXdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaEGvTpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaEGvTpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1D41F00A3F;
	Thu, 23 Jul 2026 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815855;
	bh=pZ/Ya9dEE0WHV82pEdLRfwmqjhszpqTn2fP+xSyhiqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YaEGvTpvFU3el1BPCAQ+/9FihQlpE68mS4TylLXQtP9JUK5NnA+ShvY3yI3FbEIkk
	 C0s+MVbOaqzAujnI7H5ifwny7Af25n95/zStMzrSX0TcbW7U+qRwCEjFLFtji1atUm
	 gWu0t0NXaeqztZ8BDoHGVrNpA5jDG0FqTF1V58pxMI/bFCqW5juDuef+Lid4LP6EyF
	 EN3dfXIeMJgVYr7UarPfciDBa0bTe5pQETBvfds+WPJwYRfY0qxj1CEPwL30W38shI
	 2uq8dVaCeCbr4gg3yX6FzRjH1zqRmYIdn56MGQzsADjGAKnt0ivinBg3W++qZgglQJ
	 /sipV0eba6heg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D1F8A380CFD4;
	Thu, 23 Jul 2026 14:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipv4: icmp: fill flow parameters in
 icmp_route_lookup
 decoy lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481582339.2248593.10815527521271473030.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:10:23 +0000
References: <20260722104236.2938082-1-edumazet@google.com>
In-Reply-To: <20260722104236.2938082-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, muhzi100@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 10:42:36 +0000 you wrote:
> When Linux forwards a packet and needs to generate an ICMP error,
> icmp_route_lookup() performs a reverse-path relookup. For non-local
> destinations, it performs a decoy lookup to find the expected egress
> interface (rt2->dst.dev) before validating the path with ip_route_input().
> 
> Currently, the decoy flow structure (fl4_2) only sets .daddr = fl4_dec.saddr,
> leaving .saddr, .flowi4_dscp, .flowi4_proto, .flowi4_mark, .flowi4_oif,
> .fl4_sport, .fl4_dport, and .flowi4_uid zeroed out.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv4: icmp: fill flow parameters in icmp_route_lookup decoy lookup
    https://git.kernel.org/netdev/net/c/853e164c2b32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


