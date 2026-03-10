Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EF3090CD
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108028; cv=none; b=fD8+L13k9bVeE3AdQYEZlbT4kpxBio3HIC++/1BE1yk9WdUNoSE+6l7N0SG136LZ3Nahu+pEb6RreeJ6jBGS5iUMka0dgTznSbwCLRO0N60d1I/yNG8tgah4XDGVTYPAbHK7UOypliMIClMh6EfkE1OYaLK+Z1mLNdbDtDK7mBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108028; c=relaxed/simple;
	bh=9Ht8sFT9bCsxAkz0SsRJpegV/Z+Co/5vmeirSVafBy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uOV7ggwnoT/7mvNa4hhJVViS+acDDPsJlV9q2nOWIL+CtwNAuf6xIYQZktzXiAfAQPiGpNn8TvEmEccyKlF11gl4MKGUUggjAJLQIW1A4C/oSQpvwArPoBAJmM/eUaTQ8hKDGOb79xqfeDBAcE4JOezJg4BCGw5qqcig5cn6Zdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cksSaQrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cksSaQrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E010C4CEF7;
	Tue, 10 Mar 2026 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108028;
	bh=9Ht8sFT9bCsxAkz0SsRJpegV/Z+Co/5vmeirSVafBy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cksSaQrsKjjsdzQditpspLI5tbyd1qSN2G20qI/ChlHxLdOSMGCn6CVhLX+3QMU5P
	 VIEv2fF7Y6zATFGCfG+dT1gQSxcXnaQHVSy1vGnmCkzjSewDge+U9QSn+FlBc/bLjv
	 4BNjZ7eFQtGhoKDzGXaDp3236ipm0g47UFYJd0E4BIYSnYbqEix/T9WyeCjMLHlDYS
	 YdBHkafRaMKhs6zqUtAK0F4UdPEtMJc7Jhe2B1Pu1/jmqbRgnhFEDdeDc/zvXhjiFM
	 qlBev47W1J7WpX13CixqGza3FmrD7jLuwiosXN2Ec84zemdKVWA3HWllhk2J4F0XyO
	 F3smFCxrjK95A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDB73808200;
	Tue, 10 Mar 2026 02:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tcp_v4_early_demux() to
 net/ipv4/ip_input.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310802504.2022132.17659555527462294268.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:25 +0000
References: <20260306131130.654991-1-edumazet@google.com>
In-Reply-To: <20260306131130.654991-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 13:11:30 +0000 you wrote:
> tcp_v4_early_demux() has a single caller : ip_rcv_finish_core().
> 
> Move it to net/ipv4/ip_input.c and mark it static, for possible
> compiler/linker optimizations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tcp_v4_early_demux() to net/ipv4/ip_input.c
    https://git.kernel.org/netdev/net-next/c/50636e5ff886

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


