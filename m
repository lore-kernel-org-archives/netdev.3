Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268593BF682;
	Mon, 17 Aug 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001056; cv=none; b=Pw1ftm08bFoHkw6UUlPivT/CE/LGbAwte0eIGcgVoufEKbMxJF+0CRX8lfo4gONEtWuBj7mAp15pbaF2L08wldNnFCJW8Pe/7wi4C3kONL8oMv5c5yGTw6SaBNcwIxHIdOJHD0y5fqTm81gX74Nn3tGOM68+26VdZukBVd/95Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001056; c=relaxed/simple;
	bh=rq/HN8qxE2GJrwiOlKuG24t0jihWS3lYbxrpIsVaEt0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HOC3iKSPPrr3T5/IuSFUqFqG8aLjL6CQ0IXnLkkx3uvNYbQex8gKgLyusNSqeuDiKFxbXFkb8dEYbV9ACm67VCNncChi1T69JceaSCJC2dla9RaJP1MtWRKXLatMhbppQ2DDMRbAz9QLRaMy3R/5Kg1ZiVC9KYI6/NalJUB6NPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UclaT9v3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UclaT9v3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2271F00A3A;
	Mon, 17 Aug 2026 21:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001054;
	bh=yaSt6sxk1Bnfm3zVj4gx27THkwv1DV5YdOSB3O10W4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UclaT9v3bjfHT6c7QUSC761p9gBF2XfK4pf2AJXGfHt1ZDkH06PGwdnAhJaEuBmNV
	 FB+NVD71vCN3g+1vLJv1zyg5zIJY1JxtWyZE67Q7U+PqncvwYGfMKvzCA9BIM2jdwk
	 +Fc/BvCd6vn1SpMsfAVjfxcmqKg2dakQUP6bHombAP+1zt1UMMGZjPs3SQDEuUDQNG
	 ufMkHeR7IkIoNEShzMHJT+vGhbOSlGjfzC9OGq1cyiYNvh75Ji3a8heBzdp9WuxMJd
	 OOMkA6zH3CGaqnuoHQj5bpH2+zSSEOk0iboy7WhRJJlXLp3U9ZzU/EA/ek1ACYQi3C
	 YxW990eduolNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A6A3926265;
	Mon, 17 Aug 2026 21:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pppox: drain queued packets on channel handoff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178700100689.1739106.5852126263750575730.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 21:10:06 +0000
References: <20260811035314.302878-1-qingfang.deng@linux.dev>
In-Reply-To: <20260811035314.302878-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: pali@kernel.org, linux-ppp@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arnd@arndb.de, gnault@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 11:53:10 +0800 you wrote:
> PPPIOCGCHAN both returns the channel index and marks a PPPOX socket as
> bound to generic PPP, despite its getter semantic. Packets received
> before that transition are queued on sk_receive_queue, but a bound
> socket is no longer readable. Such packets therefore remain queued until
> the socket is destroyed.
> 
> After marking a socket bound, wait for receive paths that observed the
> old state to finish queueing packets, and then drain the queue into
> generic PPP.
> 
> [...]

Here is the summary with links:
  - [net] pppox: drain queued packets on channel handoff
    https://git.kernel.org/netdev/net/c/92c1bf630abf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


