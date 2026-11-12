Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510012;
	b=w61sq7GU8Vyod/7PKn7YWipARAPy8fnx0YekQcnE1TjMmTayS+w+RfYGaHc8NGzkm6E0
	 3vxkKso9LWQeIDh1K3ue2iiPQhVxAD6VM4cEa5uex2Xz7M50PIOXZngN9a04SGipQM25+
	 +J/DP/nXwxp1y+a4ruOENTy60Y3Hy+zJ3Z/dKtBVTYoFDFPDMvd6M3vhgqUdxK4gPli0r
	 hqX0g8qEfRwiM4dRe0NPNFLzB5upds4NqakO5fRFF7HUrhXOn/M0Y2EB/jZDEqWOcMH2P
	 zmfdANL+YLF/ubUxJy1iC603D/HcUSxxPPnd70kU1uIlwivKuu6D68JtYnmX+qne//A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nU1s4hPKfhK1wmrH5ikzcYoaNf00CXdascWgsQAj/nQ=;
	b=dIeqtUlak2DDKKSzyYrsqqBaSIJO84CBPBfjBhT4jYGRriGjgDqe5ehvfhQVQkcuJpz8
	 h+cEHAW+r3tAE3dMsvyGEqWsN0f9ChQXOHv7TdGdBVsmilRWm9GxsbXH/IVSe+o8e8zAJ
	 jmtwGCHK3CFVlULiCq1SZB3xeBQ/o9Cjp87jpJlYBAkGcdIZtVW0NSFSAnXL+PSqfgzki
	 xRVrQafdm/Rr9HFM9J4E0y5I4tyLcE5M68NT+EHl+XhNXJT3u6wcFEqBOSOqgbyn4T1KP
	 OPwWlh3CZ02vzOp9EOj37b1N03XLQnUNbA8ryZSLX8/Onpl71esURYS8mLwlRgc4r+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/dRi0T8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CA60A5BE2
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/dRi0T8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D1A1F000C4;
	Thu, 12 Nov 2026 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510012;
	bh=nU1s4hPKfhK1wmrH5ikzcYoaNf00CXdascWgsQAj/nQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F/dRi0T8IXe8qJbMSRzpgRT1PPEuTUT9z+JnBeQbXRzquR1P2uoZ2YozPVqxvth9v
	 Igy2ymUbQSZ3dm2y9XpeJUaOjNOKzZXuas/l+xduQGROy1g74mfNDJfxkkw2Vh3iSE
	 u6hJzMgM4DCVAiGRIFEYu0QDu0d0Jqm0+/5Lof9r9R0I4+FKgktOIx3NVS2dMtro9X
	 YZj9dFQm7aIndLEQRf8PLRdcdvP53uDqZ9mTbOXUXdIb92OTA0+pxzeHZSu7fCjhrf
	 MYHSm13VOB4wErcSzdGP/0X9ZgtyBlo7gIOgEnlb3w8VrW8vhDHLqkJvOnbpEdZVyd
	 udzMF2t5H1y+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E72CE3924A5F;
	Thu, 12 Nov 2026 19:00:11 +0000 (UTC)
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
Subject: Re: [PATCH net v2] tcp: fix request_sock use-after-free during Fast
 Open
 accept()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451001045.594620.10862327534856393811.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 19:00:10 +0000
References: <avQKA_YTAThtbsYU@v4bel>
In-Reply-To: <avQKA_YTAThtbsYU@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 15:24:03 +0900 you wrote:
> Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
> made inet_csk_accept() check tfo_listener before taking fastopenq.lock
> to avoid taking the lock for connections that did not use Fast Open.
> 
> reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.lock,
> then reads req->sk. If inet_csk_accept() concurrently observes
> tfo_listener after it has been cleared, it skips fastopenq.lock and
> drops the last reference to the request_sock. This can free the
> request_sock while reqsk_fastopen_remove() is still using it.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: fix request_sock use-after-free during Fast Open accept()
    https://git.kernel.org/netdev/net/c/62754aad50d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


