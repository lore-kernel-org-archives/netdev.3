Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E747799E
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454246; cv=none; b=tuYqQ2UG06Lw+FW9fdqVNTcofm+3ZjJ/1eWUWeVtSQUhQGCCHJ3rfvNQHxW+tweb+7dnsFnmj+LlAucBHHW/uWlDCpy9iULpmeAvxoUFEmLaJw7US0O999RePd268pqq1gdfnk2R9dP1DuqS0pXfNsG8QPNxEmJui953jS/KF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454246; c=relaxed/simple;
	bh=K2hN9wVU74M/4sYO/Z6n3XPIoTs90OA4hw7KtTKMb6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ohJxir7DLYAXS7ZXxMmvSGhdDjUyEf02fU8VVxViTyU+D7ZFA5LVd3jeZaRancheaL9AVsxZL8x5IY01ibdtiTN3lF5j82QrS1ZJuJkz62AKTDN/jKP5F+e550oSCNrUNpdkKhLOcPl0INpwiwneSQGx0I8RI99+T8vifNX6Rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl4cmJCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl4cmJCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8566B1F000E9;
	Thu, 30 Jul 2026 23:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785454245;
	bh=LqKG4ILdk3qyJjaeBZu9D9sjZZ+JXSMY411KoquhBVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nl4cmJCSOtfbkJ44UsAkU1c2B0fdfWd6Jag4NURLYCytBknnKRAzOuvisLDn3DrB4
	 YNu6ykQsX+kNA217J4rKmSnA+16kEtl9CpHLrABikmdZl6kMjxIjhWJyPz2kr7V+h6
	 ICJCLI/8m8EPZoGI/CQ6bj9yIvwasXWUaawPPGCclJsfXsM+s9CdKQYVLQLveS7QUq
	 UBYIj/f28amP6ZF71TRpGIRSXrD6dEpjxdlGYl/ms8G6ADUQO4EFQIV2Sj0EVxb9Bz
	 ZEkjw1A+HnoEBFiKmEVDqCdyLWDP1l/oAX6nFvIn7GXIpDcB4U6BZO8QucY63tACLw
	 NIpaVQkMPVsTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B5392445F;
	Thu, 30 Jul 2026 23:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545420864.36899.8870435906589662301.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 23:30:08 +0000
References: 
 <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
In-Reply-To: 
 <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 almasrymina@google.com, bobbyeshleman@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 12:19:37 +0100 you wrote:
> We should either have net_iov or page backed frags in a single skb,
> otherwise it blows up down the stack. Don't allow mixing in
> zerocopy_fill_skb_from_devmem().
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: devmem: prevent net-iov / page mixing
    https://git.kernel.org/netdev/net/c/53a43508ee33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


