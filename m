Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353407;
	b=Y5KXmjLjeR9uGLohq35puxjGw0JDCRBO7xmVq7F9hSGXexTbvL9ZH799qAszFjIyD+J7
	 hxEtsmoofRXbTdzkKNlkYt57eANVqrMcBnrQZzYnQmQ+7HTYxvAi89ZvDZzQnlct5lebm
	 DTq9jjOJHdAjGrxrVURvPvi9riLzzwCGv7dvUG9plZH3kESsRBDOjgeGw01yvg3np+uJ7
	 TVX9CtM5A6w3sQE+d/mbguhherVyYrOr1KJAbbCDkUQPJZ0PTICpaIGtRFXdhnCgVltDO
	 KS/wXXkE1eK0T3wMNJQhpphrww4BMekgRHvbYoH1NTPXuq4ZHYZEC/vIj9DuxRjlidA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=c1AWRcmgTlov/MoPcAcayEMLmx43nYydduS3bM/HlYU=;
	b=R9bskZoSNL+fEJVcSVkt5XG02BA/pp8OZxPvcoynn/rJPjPZhJ8EH15yon7pj8q661o7
	 DQ7ZE+8bO7OUFeuj3Cov6/2nzuXrELxszSKln0XXe251E+Wd1i5SGawPLJTzWYZBDknMF
	 vb5ZPsVgMXQqwqeO4su8mk5KSBJf4lr96pUuFp/eJeB5YElyKwjPizIEMxfntuQytr4x6
	 iS3J04OVaUUdw1C7eTSsJ1dETyDoBVNGyM9vyB31UEaRV4Rnc3GTvAgRcqB/XSIF5N/G3
	 gRBHZRuYOTBMXM3C2ThgZUXpixZllg7bm0EKSNxBAcaeuG5FYcacd5hP2ZvWJRKQvVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVxt5k2e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAD606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVxt5k2e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90F51F0093D;
	Tue, 10 Nov 2026 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353406;
	bh=c1AWRcmgTlov/MoPcAcayEMLmx43nYydduS3bM/HlYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cVxt5k2epkz/Gj0BCmNIY30FfScFktCIOFOUqydQwAbKFPXGxHGUBdcMn/yu7BN4a
	 J35O9tTvHfU0Y+XK/eR5CSVKg8Xhni5fjQqKWcEiHrYNlnl60qGhTzRlf6tq+4YPXp
	 O/EHhkOzNzC87Nne04WUXkmcFFWkrnwVcwZRGKDGSxiv/3t0HbIKLDdb5SHf28Fqls
	 tj9v4SLKJDVofo8BWBbA3ZjHiQH2Au6Bg7XwXggUTUhX8xAYC3qNw1n6qRNdc+lrD3
	 sLuJZ+CQQzD3LN812Niuceh1wS4DWFQicwMAW4S52ARDBQFAAKAkNDPl9DEpDHTChc
	 0LI4+r35o6UlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B19239E8A40;
	Tue, 10 Nov 2026 23:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: skbuff: uncharge trimmed zerocopy frags on error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435340543.113833.8281856662943688738.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 23:30:05 +0000
References: <20261105223512.3647504-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20261105223512.3647504-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, mason@kernel.org,
 kylebot@openai.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 17:35:06 -0500 you wrote:
> From: Chris Mason <mason@kernel.org>
> 
> __zerocopy_sg_from_iter() accounts for the frags that it adds even when
> it returns an error: it adds the growth of skb->truesize to
> sk_wmem_queued and, unless the skb is pure zerocopy, charges it to the
> socket.
> 
> [...]

Here is the summary with links:
  - [net] net: skbuff: uncharge trimmed zerocopy frags on error
    https://git.kernel.org/netdev/net/c/8b67debdfbf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


