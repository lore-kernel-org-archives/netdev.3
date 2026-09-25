Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0C50AC33
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379683; cv=none; b=EwGTWkxwVJu9gfzNBujKxn3Xp2dKZyboITZQaM2pi+Y16TMVRRTJCv4RQsZbROrmfLXriy/8IbBjcySzb6gg1+2PXV6d9QnaZZe7e2nKSV3TnuMZnxh8SB/Zt9AnC6p7rBl6xOEfRzAsIFakRXlDya8nOtigtgTmgUfh8NNbDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379683; c=relaxed/simple;
	bh=mN1EAKb/PZNtC0aY47dc/snDVvFQAoPl8h+N3ofRTKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XMo8gNDG3WMazHWPKfzPc8juOcF5QG/vByHF5Tz4IeJOeRtAqnWJ6Ipe7v4/ZxWihzBy8wNAQiuP/Sb71hILKJJYazTiQ6LQGjbcdgloeCZDbrWcUhtgCeGJSQ2D9xf772KTIOyQN7ikUVPsR8Ppkln5vYzaPVfedcWlqMgK4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETKsZFQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETKsZFQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893371F000FF;
	Fri, 25 Sep 2026 23:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379681;
	bh=OdZDA6bI8RzFZiuri6KDMsWr3jO3og7lHmodXhGkB9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ETKsZFQWMOanztF62Xnv4gnnPuxplXilDxko+J0wKNnmXeo8ktfsaL1wGwjRQ2Yax
	 9UekIqywAvf46ZLlkBnPw1mZj6ZijTE4T41hTx4Bds8+qjWjzjgIBcMnrR9P42hQmk
	 3O2U/q1yVEz7PXr1oWNwBker3orhKTEcwCD5BBxAGvS3e5582SuKBL3jTZIlbJBr9f
	 uwa9PDqSEOBffLxXe9IRbaHfOKTlTQHCAsGS6aJnK6ZVCAn+/we6JjKf83oWewoydU
	 LH6YHgmauYifnalhD3xIww+vJOSJ0j4YHKNshX0jQ8QXFzGDOway5e2DjwUbl4d+kB
	 nctaWwNCmDLtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C33809A04;
	Fri, 25 Sep 2026 23:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] net: ethtool: make netdev_rss_key_fill()
 spread flows over all queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179037960888.3207107.14995347691230461960.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 23:40:08 +0000
References: <20260922163458.3900996-1-edumazet@google.com>
In-Reply-To: <20260922163458.3900996-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 16:34:54 +0000 you wrote:
> netdev_rss_key_fill() hands drivers a uniformly random key. Because the
> Toeplitz hash is linear over GF(2), a random key is singular for a given
> header field and queue count with probability 1/2: flows differing only
> in the low order bits of that field (such as a burst of consecutive
> ephemeral ports) then cannot reach all RX queues. On one affected 16-queue
> host, only 4 queues received traffic until the key was replaced.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] net: synchronize proc_do_rss_key() with netdev_rss_key_fill()
    https://git.kernel.org/netdev/net-next/c/9396e37c4860
  - [v2,net-next,2/4] net: ethtool: generate RSS keys that spread flows over all queues
    https://git.kernel.org/netdev/net-next/c/898d431abd25
  - [v2,net-next,3/4] netdevsim: support reporting RSS key, indirection table, and flow hash fields
    https://git.kernel.org/netdev/net-next/c/5fd4208098be
  - [v2,net-next,4/4] selftests: drivers: net: check the host and device RSS keys
    https://git.kernel.org/netdev/net-next/c/c8103dd8b9b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


