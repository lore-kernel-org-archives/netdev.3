Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D932EBBA1
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033484; cv=none; b=t1F5/WT+g0EBXsUb12JINFIw9wEYIMSMa6tQBix7LgLRomNTfW5JTfGeS8TFSKq4Lg0G+/pTx+h3gYVcVyH7d8EN0ckAGWCE2SIb+8kCCNsszMhUFzBG4mW20GvyaD9xuX9TE46JO5hC+VBTEQue0ObaimFSa+ajZbz/9vBzYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033484; c=relaxed/simple;
	bh=868IvHhoVqHz2M38fASXCR2kHj0t9/p+t3wMp86G/mY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fxw8UwBka7aB+E+BKrfog3UQsX+bK6j1EwlL+T9xmwBekw8KsCzWca6uVjjmkOlXvLHluKvoSI+/XlqlqyenFJ4fnx1mu8Cb6Lc43UmF/+45JZkTGyqQ/rhMVNFbvsa3vKIMuxruC4G20jWIv8HN78wivOhUBjfw3bn2/8VuS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih/m/LJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih/m/LJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEF91F000FF;
	Mon, 21 Sep 2026 23:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033477;
	bh=C5mo2tBNurvSjjQZsLqODh8K4B+9+CPQMJuMSHV7VQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ih/m/LJ0h120AfSgJjb1Bgp0wLw+n3FYvZCFKQgiSC9tVYJq8+ivQQap1HJlJsWYm
	 J3a07leaSBszk++EdooFJ4OijCwAY2HBS1wo5ialUr0zwbuJZcFpJeafl+pbgtvJvj
	 xvlszxUKKox2z13AIZsVSxodGsrmCnZIGSvGYG7kNR0s3DOkRne5uDMRYzRnTo3ce9
	 bCYIYbTxW6wzscom6scMiatCDMe6jRHLYglsCvfvhNJS/pTyraam4JcMonsyjHYnKq
	 SBlB+kPv3K39Fl6bNa6X+CwGAeGjkYT/odYmdFxC7R6Pts71iZVPox6F3U4UZeCfc8
	 FkFQQ7x70v2jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391D3927048;
	Mon, 21 Sep 2026 23:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv6: Prevent rt6_insert_exception() for dying
 fib6_info.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003340814.3287147.12505999894663497727.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 23:30:08 +0000
References: <20260918082209.2853582-1-kuniyu@google.com>
In-Reply-To: <20260918082209.2853582-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 marcharvey@google.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 08:22:05 +0000 you wrote:
> Before the cited commit, fib6_nh_flush_exceptions() always set
> from->exception_bucket_flushed = 1 under rt6_exception_lock to
> prevent rt6_insert_exception() from inserting a new exception
> for a dying fib6_info.
> 
> The flag was replaced with the FIB6_EXCEPTION_BUCKET_FLUSHED
> bit stored in nh->rt6i_exception_bucket.
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv6: Prevent rt6_insert_exception() for dying fib6_info.
    https://git.kernel.org/netdev/net/c/0346ec2f080b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


