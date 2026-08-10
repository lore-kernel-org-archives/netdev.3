Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D0434404;
	Mon, 10 Aug 2026 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404060; cv=none; b=dQAutyS8aSafsroC0HHRq/vPhVAmb2yshE7NIeajDNGLCPx0dl9msB5yptgRs89Q9SZnAO7EcmOdRpCyDU3rtbUtHGkCkmDqhp2ZHr9f3/03ZQU0lQQolCjJZ8R0sEoIlqBYHXAU52dKvMP66ezxUIJQacWosF3Ti41uz5fJt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404060; c=relaxed/simple;
	bh=2xT0TXRj/N0mwAgpl/g0jIuYUpij57rFQmRxUesTNtU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=awjMfcQIyGT759suA4e4zh18V5pfV+sDjg13RlEPYtvDUVng7UFtN0+pwo4VzDPUAM+pgh/JFtzLpdzhT0wrLRg600i4noPbdqhjoCjw1Rp9+2bWNJ21dHErnIG57qQJ0CufFbA118uE11rbk2lJhAuAhXiNrw5T16JJLYHqRvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/lq51KZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/lq51KZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE63B1F000E9;
	Mon, 10 Aug 2026 23:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404058;
	bh=xi73kfB5cjxC4+UQ0Ww8d5p9lPwTOAf1BTgEki1xjYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M/lq51KZIVpx5gQ98HUS486q3mlfEdoXbxd6NvG2/PAHk4NyfjB3U4+6ZEmOfwRKU
	 juHb+PlfuC29TMyz2O6CINHoCbo0KgCsmx4qR85EfMmTxlQJ0WRg/60qxHj5Gngwxs
	 f9eJBUIXzl4eL/4zYbD5Pkd0qXlpIFNXmZKmrMoF3jYsvl/oD/TcJ/Xv3AKgWIwPtO
	 YdA4QEkhcblwnaK9d/I5j/AKhQhmUk7GIbkja9LFIUtrvdIYA8msCqSYIXEyZJMJdF
	 u3GznUqre5rm2Ylv/nTszTZwHo0xODby2yO2lwTaY8R6EbPoMeM/FDFCaW6zCmv02S
	 VkFT38ITgGEqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0F392626C;
	Mon, 10 Aug 2026 23:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix icsk_ack.ato bitfield overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640401513.250217.11132346896047428901.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:20:15 +0000
References: <20260807014437.36687-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260807014437.36687-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, morleyd@google.com, ycheng@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Aug 2026 09:44:36 +0800 you wrote:
> On cross-region connections we observed delayed ACKs suddenly turning
> into immediate ACKs plus a TCP_MAX_QUICKACKS burst, as if the
> connection had just received its first data segment.
> 
> Commit 95b9a87c6a6b ("tcp: record last received ipv6 flowlabel")
> squeezed icsk_ack.ato into 8 bits, sized for TCP_DELACK_MAX. But both
> writers still bound ato by icsk_rto, which can be well above 255
> jiffies, so the bitfield assignment silently wraps mod 256: repeated
> delack timer misses double ato up to icsk_rto, storing 320 as 64 and
> 256 as 0, and ato == 0 is the "first data packet" sentinel in
> tcp_event_data_recv().
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix icsk_ack.ato bitfield overflow
    https://git.kernel.org/netdev/net/c/60837e4b840a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


