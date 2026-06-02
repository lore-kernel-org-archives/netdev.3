Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184623A99F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358417; cv=none; b=kG+b7WRGuQw8+PWMUoB4iOH89LTHnVEtJtdaW9sofcHTI4vBJYrYyxibjxpSKKJmpdz98X+sLS3ds1n2lF23Q0Pq6M5cjAnlxPvWIopyTkCRQV7lPfuBnFTSVci42ryVMTK5qaWdeqLXicK3Zbdk2D+PYxgp9LOB0jUU6YhHrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358417; c=relaxed/simple;
	bh=Unx7AS3v7M8R6DMVSPWqU3eQGSX6wak1WjHcCu+aKQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fPR9vnox7d24/FiKy+Xrd8G1GUZPPFgfV/IRkYJwJM6ZkIiuNqDA/Kh/yebqE5cROl+Shd2skSkUCcnIoRGVxaB5hihxS//F2pexK/Do4/yZNv8n60bRmqTHC+CjuIoxQkkHbzPMKYdal3tntdKCDLNmo04UjN3C2QlW28cuI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO3DDx0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO3DDx0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAE91F00893;
	Tue,  2 Jun 2026 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780358416;
	bh=ENJ4vx5j+s6ZCaljlKPIFBuOvTWSn0L5MgxJI/wwTn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cO3DDx0kxI/5XdZaGEHJr53wxr4H93+6JVevLo/GCbqervWe4AnjeD70NCV7YL3L+
	 KgrhoeqoQ6xZnCIMqQDk3EvOgeXL37tBPsznOHxJxzqtAMvNbmVIqNBFyXBdL7oZ+C
	 cgSj2+opwx67OnIBeWjGAHKCOA4iEdPF6s+xAGlzHkj+48JeyBmmPJK8iZjzZALJIy
	 uE77bYb+GFuqZPOFT3oiI7tlcRncfwja7Msvyd6rEkxhQ/Y951fWA271DHSMuW01i/
	 iuZkjalKX0RKNxuqXKm3QR3iq16qF1rNWE9NHp2nIDcw6F1XauhkuBcuKOn8dQmu8V
	 1z0uBADZUNnzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AA638119F8;
	Tue,  2 Jun 2026 00:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp_bbr: fix SPDX-License-Identifier to be
 GPL-2.0
 OR BSD-3-Clause
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178035841812.174748.10998119291308599431.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 00:00:18 +0000
References: <20260531183558.2337381-1-ncardwell.sw@gmail.com>
In-Reply-To: <20260531183558.2337381-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com,
 vanj@google.com, soheil@google.com, tim.bird@sony.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 May 2026 11:35:57 -0700 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> Since TCP BBR congestion control was introduced in
> commit 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
> it has always been offered as "Dual BSD/GPL":
> 
>   MODULE_LICENSE("Dual BSD/GPL");
> 
> [...]

Here is the summary with links:
  - [net-next] tcp_bbr: fix SPDX-License-Identifier to be GPL-2.0 OR BSD-3-Clause
    https://git.kernel.org/netdev/net-next/c/4490516d2109

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


