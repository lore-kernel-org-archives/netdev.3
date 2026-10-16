Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD4325483
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114209; cv=none; b=ROuAtSdapRq2U56gRWf8yrvRFGl3jOf1DDL+8UoaGdaowlB7OE+a9wNfQucu47iYwhhuJb6RqaXff5lpz2EpAPGqzzEcYCsI52oLh9jdoxM0ZHFPbNUzhZJEFsU7qrJUPc8G7GaV0zp7kUY/vz8Nff9qvVFXAQE+WtROh/ig01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114209; c=relaxed/simple;
	bh=VglXxyRxx+XtpECeZyr9oREfDBotwPq1P+2ySICGR8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NHLLYcbgJnw2qBf8n50X8jVP8Qm/BD2oxXEykjkRQZW3Z3DeBfSaaeT1dKaE7j3+HaD3TAYxEJeTZV00F6ypTYEe0RrqDJ+Xvt33Exp7iGhyt2EzNAg3Ak+66efhjq7cuhY+5KdVDU4qNvptM8J5MUz54XvxohD4tS80fiD5iMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDLyUZfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDLyUZfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FAD1F000C5;
	Fri, 16 Oct 2026 01:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114208;
	bh=BR1PycvQS2gBXK/FPY5yiYTWZH/pMhrtduU9ZthqMac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XDLyUZfklpAORVZIfzvi9QW43t3bMhQMlnVBitkJN2VMeLEf0cCPzCb8wLnyHFcvS
	 y926J4XKxT6DjAXEjyGCGHwY4WSfSMjq6JLnL4wPA/hjR+MFlnufVeQxft9A1HNWxW
	 bxj54xtqPxH4cfF/HpHBbDr0CCNZj5l1gq95iaNQWurlIDMvVhel1TBJSGFNE22daL
	 9yYNt1HJ+PYOt/70qbE87Mx7U+k1is1tGMMTR9qs8TE0dW7Q0lshkydGwj+YoPf2+/
	 IP91OD9DIcsuFTvW56tuwgSen5mWfpGW3pxTffz3VQa/Kkk7FBkmxLyMm84RwS3l6K
	 pV68gMqKYJhmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F147F3808209;
	Fri, 16 Oct 2026 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: use RCU protection in
 inet_netconf_get_devconf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211420665.3903.7250959899697067362.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:30:06 +0000
References: <20261009074906.729877-1-edumazet@kernel.org>
In-Reply-To: <20261009074906.729877-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, kuniyu@google.com,
 netdev@vger.kernel.org, baul.lee@xbow.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Oct 2026 09:49:05 +0200 you wrote:
> inet_netconf_get_devconf() runs without RTNL. It uses dev_get_by_index()
> and in_dev_get() to pin the device and its in_device while the reply is
> allocated and filled.
> 
> in_dev_get() is not safe for a lockless caller. Since commit 9d40c84cf5bc
> ("net: devinet: Reduce refcount before grace period"), inetdev_destroy()
> drops the final reference before the RCU grace period. A reader can load
> dev->ip_ptr, then call refcount_inc() on a zero refcount after
> in_dev_free_rcu() has been queued, and keep using the in_device once it
> has been freed.
> 
> [...]

Here is the summary with links:
  - [net] ipv4: use RCU protection in inet_netconf_get_devconf()
    https://git.kernel.org/netdev/net/c/b2039a6dd36b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


