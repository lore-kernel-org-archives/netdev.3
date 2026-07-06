Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF28442101;
	Mon,  6 Jul 2026 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332625; cv=none; b=N3Oyo/oG15P1bu+h+RCVQche7XZ/Eso1bNN/T6xCwGd62/7zmI5ndvdryERou/j6nZYQljLc4kAhHZQH/PVdeUUKMUW+9Jw7ZuzQSDiaLu1RcZk1EjA+3dmTwxpNxHRk+VRAb2ruknaQqn3TVFOtDW2Pc3Z0wpI+9UJBv86dOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332625; c=relaxed/simple;
	bh=ULpJKK3kasidvzMp0YKddxDBK4Fug7wAZV3CDP3H25Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hPyVT04H4Np64xxAHiUOG3gE7KIxsbC8ZfBkkKTtiDk+UttFmg7OZexkXdOhgCSolK+O5mSp2FbppshSKpb0zsbPJfhHCukqwUD8bMw7SG5jVF5QoK01r5qGJlI1lICshPoTW7LhE+RtPQBPneRPvgt1o2gI3DQixgsCJXuVNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5vTVgZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5vTVgZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F00B1F000E9;
	Mon,  6 Jul 2026 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332624;
	bh=qMbOGNXzEFrpIDZTZIODDwW/jF3aOiZ7lLkdfUV5tQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q5vTVgZXHDdRhkpHWZL5CN51oUP50VZd4wMroOjQ0QQyHSR/AlqeuW70b6cP1KQRm
	 03qpsI5CV+O5gMTbbs3x+bXmTUdsmQlGKaklgqXvk6ScA0XWJJigsyyBywlz/YcAGz
	 n46fcbbk2cmk4rFuESeU5GM8rAWcxc5K9023SxLsgFZpGq2DFKufXC19PtNbCnt3mv
	 9RdXwIHqf27njN0zKymSWIYjhhDlxNbiqqEFrQCvtqB0dbDS8K2FAJqnpR6uP+3Ne5
	 1t8p+duWOcOhBHZSMxSLSO5RKUW/UcVJZWnOw02iyUSxlgO6piS0rbVeXbOHomUFup
	 99gRUD2VMmlHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569CA3AB1391;
	Mon,  6 Jul 2026 10:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] qede: fix off-by-one in BD ring consumption on
 build_skb
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333260514.479270.2191423022943795278.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:10:05 +0000
References: <20260630164623.3152625-1-syoshida@redhat.com>
In-Reply-To: <20260630164623.3152625-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matvey.kovalev@ispras.ru,
 Pavel.Zhigulin@kaspersky.com, jamie.bainbridge@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 01:46:20 +0900 you wrote:
> qede_rx_build_skb() and qede_tpa_rx_build_skb() do not check for a
> NULL return from qede_build_skb(). When it returns NULL under memory
> pressure, the functions still consume a BD from the ring before
> returning NULL. The callers then recycle additional BDs, resulting in
> one extra BD being consumed (off-by-one). This desynchronizes the BD
> ring, which can corrupt DMA page reference counts and lead to SLUB
> freelist corruption.
> 
> [...]

Here is the summary with links:
  - [net] qede: fix off-by-one in BD ring consumption on build_skb failure
    https://git.kernel.org/netdev/net/c/a0a558ca7e75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


