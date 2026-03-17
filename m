Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AF3491F1
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715215; cv=none; b=SZIzRMdt8bptw+ZiP9x3EKRlrxRsfXGBAF9R1k+IboWF+/blqjcxXhdropHeC3ioHcy3oVmORuRcWHGjDvNfP3lS2aaaqV3LsHQNwcBmQdMbOlbcUeU183ztL820wb046zipuRI96a93bie+5Ypix52PZmJK7h/6X39JcF3Pyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715215; c=relaxed/simple;
	bh=6dI9pxBT6qss0xW2pQw/ZGsc/a+uuwMu6xMEUNWSXus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kK5h1PObhnvgKNvbqP4s7RkO/ghfKnvQw5OJkrY7nLbRLGuU1jrFIe6HN0i9guoC2y9G/bwVoPQ82nU9JRRdhinzkF/ertyNCFh8Nj6Rc8lyAQx7dfELrh5ZSypMKgBgBlc3JIxDOzkuizOuG9hbWwtQIi1olup3mzwrpqMe62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkB9uM+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkB9uM+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE91C2BC9E;
	Tue, 17 Mar 2026 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715215;
	bh=6dI9pxBT6qss0xW2pQw/ZGsc/a+uuwMu6xMEUNWSXus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lkB9uM+m7h4YwZqRo1Du3amus4lVyWwWsXv0Cmh1PqfE9ayBEs+xMH7gGk4R2+7NR
	 MjnZwVDwH7mKOY6a/6CBDAnJ3wK1OirjK/68bqXGXQNgf/7qIAcGsu1g07PgeHafJq
	 1V4tE48Koe2F7LHcF6z3+CipiTiH8HNwqJUIrAOcEN7cuxZwG0ssftiyX2OKOxbfWX
	 gXypKTuITIN+JfUlGS5FJ3n/vn9nQUaotsUejbW8/HRLJAhaaL8yyfuUGqgaiSe46Z
	 4KXBVK5a3oXThaC3eesdefPZ52UlA7x+JfLOi5QcOIhhpsCuggtNCb+G94m72CKjug
	 ewXrETVRgo5eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEC23808200;
	Tue, 17 Mar 2026 02:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tcp: improve inet6_ehashfn() entropy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371520803.3399897.17363061976477726162.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:40:08 +0000
References: <20260313120346.3378811-1-edumazet@google.com>
In-Reply-To: <20260313120346.3378811-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 12:03:46 +0000 you wrote:
> Instead of only using the 32 low order bits of the local address,
> use all of them.
> 
> Xor net_hash_mix(net) with the 32 high order bits of the local address
> so that we can use __jhash_mix() three times.
> 
> If we were hashing 4 extra bytes, we would need one __jhash_final()
> which is a bit expensive.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tcp: improve inet6_ehashfn() entropy
    https://git.kernel.org/netdev/net-next/c/854587e69ef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


