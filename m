Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7E3B6370
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725807; cv=none; b=ZGU6fgJzOTj0Jh/K6YVnY3k2tZp6sSHXnoKbxMLMxlQdHJlZgxppSmY2bFvD4qfBpGFsSNddgcYAcqYW1o787DGfMTPaYUYS2U9/s+aQ4h2FUl1LDtBW9n5agSEireMR9y9KUGnw9d7oY4PCRNmsWMdf1496hNAuf2T7VndKH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725807; c=relaxed/simple;
	bh=TA+J3yQqhB0Bp/EQNZb0uNSjHp6QXI2tfJDfelzzG10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rIS4aYLZT9lBVA280r2+cnWOQGcGfZfN6Cn2D2Y+ErGR1gidMFerduhgZ+UQLg9gL+TECT74z+DBPUFoLy8DK7dDVio78Mwg9zAT5OlK+KgS7N2+NceRFsaG1NXI1rkqEbtxVAyHD60gJSvRvM25Ij3GwR6tmuSjoganCFpqgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7xfWkdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7xfWkdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8701F000FF;
	Tue, 29 Sep 2026 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790725805;
	bh=K5STqsST9hTqkYRA5GaFdliU8v5WFv2Y71PI1VdU6a8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b7xfWkdb2ALCoaAA2iPpwSFpYSzd5sngh41nW8695nI/tw5Lk85TUyF7+tgYRgnv7
	 PqFkQqxjaaadO06nmBkyxfxJeQITmoCqfMHIAP/rmKH8M6svrhPSxVIlrHNxbZG/jx
	 HP2mPtXkdWoLE3HEG8VYThv3/MBNbptb7UFfgyjwGlcGo/xq9SaWrOuF6oYIVYgXPx
	 zElpYQVnaIaEOIDtBgwChzyAREGVO8Che9QYmXQ/BDcJCRgNuMrCzdH6BAZl9qYSDB
	 NoQQ8jehx7X4yG85YZuZqFKl4AwrpcecLh/15aedZFiRFgk2y5BpBZ+FmF/BgXJq0I
	 WRILnce0dQMCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B481439D5FDD;
	Tue, 29 Sep 2026 23:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/packet: prevent TX_RING byte count overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179072580454.1169866.3216258817099435365.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 23:50:04 +0000
References: <20260925124829.6595-1-ilkka.lappetelainen@gmail.com>
In-Reply-To: <20260925124829.6595-1-ilkka.lappetelainen@gmail.com>
To: =?utf-8?q?Ilkka_Lappetel=C3=A4inen_=3Cilkka=2Elappetelainen=40gmail=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 security@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:48:29 +0300 you wrote:
> tpacket_snd() drains every SEND_REQUEST frame in a TX ring and adds
> each valid packet length to the signed int len_sum. Userspace can
> recycle completed frames concurrently, so a single blocking send call
> is not bounded by the ring size.
> 
> After enough successful transmissions len_sum wraps into the negative
> range. In particular, 65536 65535-byte frames followed by a 65007-byte
> frame produce 0xfffffdef, or -EIOCBQUEUED. sock_sendmsg_nosec() treats
> that as an impossible return and triggers a BUG. On systems configured
> to panic on oops, a CAP_NET_RAW holder can panic the host kernel.
> 
> [...]

Here is the summary with links:
  - [net] net/packet: prevent TX_RING byte count overflow
    https://git.kernel.org/netdev/net/c/2cf81fc9505b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


