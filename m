Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6F10F2
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826268; cv=none; b=SoM9QmwN4NJ/tDptKFlSkNtd7FVU6yjc9i00dfW3w684JLoeQSdRjPb3RWVpq37bfUY295xpHzAH2foD+8TZDsicb8VmF0r3cWd3+tzTecpRMQzoEwj0vZW1SV184Q6uLPfZkncP4lkd19Iagip4TPqxgJu5lgSULriq+g5SpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826268; c=relaxed/simple;
	bh=JPuotM6ukxT9Dq/XINDaQG5w3QiogGZITyk+VFUXPGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jm9UEJ38RgLfaYBFBJl5T8ks4p8tZj+e5oxsndb7b/eL0/N8OYRZ4WyAtb4TGlX3fSPsayoOPyyYpmvtoqw/Y7uRjKqMtMOdjOte4Pw/p7jeM4vqI1VSr2ekp+bR+xnOHu62y+6G7Ay7YvOGvAt65DdB9UG/msMWn1B0lWTLVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSsgulix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSsgulix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE161F00A3A;
	Tue,  8 Sep 2026 00:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788826266;
	bh=Ax4jvq9CM4A/DsmVP9VzYsooXP4ByOCoXb7iDOQIdLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kSsgulixLXS0T4wrW8oZovvzOAPkE03yddtbRakdk9UgU5DK+G9EXu3r7+MWUo1dD
	 qf+sKPRmX7zmM7w4woRHmgVk2citxOdG17iK8k2bwgcIpnOIhzPmFizRkqbZhL0uNG
	 p2nIgYYFm+6CNlBLITHjnqOnSd799EcytYVfa465fN3qhvYfy9844+rM+zmPG4xUnx
	 BNdKviKYaM9PCRuzQnqGf44y7sdqjbwN0lfxjxUPqd7Wp+fnMk7t2puqtBaZKFf4GE
	 9bX/iARRQj94YW5dQOZYFbikNQRJ7c8WzvVsIWKbh77Bg6ibZ1o/BmpFiN4n3P7pmz
	 +TM+QzXNuFdGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D093F39E8A5B;
	Tue,  8 Sep 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/3] af_unix: Minor fixes for MSG_OOB and MSG_PEEK.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882620564.3215121.3210974264651874931.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:10:05 +0000
References: <20260902202202.892676-1-kuniyu@google.com>
In-Reply-To: <20260902202202.892676-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fahad@codepure.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 20:21:49 +0000 you wrote:
> Fahad Alharbi reported blocking recv(MSG_PEEK) could hog CPU
> due to OOB skb.
> 
> Patch 1 and 2 fixes the issues and Patch 3 adds tests.
> 
> 
> Kuniyuki Iwashima (3):
>   af_unix: Update last skb marker in manage_oob().
>   af_unix: Return immediately when manage_oob() returns NULL for
>     0-length buffer.
>   selftest: af_unix: Add zero-buffer test for msg_oob.c
> 
> [...]

Here is the summary with links:
  - [v1,net,1/3] af_unix: Update last skb marker in manage_oob().
    https://git.kernel.org/netdev/net/c/94fd4debd2e3
  - [v1,net,2/3] af_unix: Return immediately when manage_oob() returns NULL for 0-length buffer.
    https://git.kernel.org/netdev/net/c/6e5ee08eb585
  - [v1,net,3/3] selftest: af_unix: Add zero-buffer test for msg_oob.c
    https://git.kernel.org/netdev/net/c/ca0b0a86873e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


