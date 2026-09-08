Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AA2472AA
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829270; cv=none; b=YI044k99JgF9lxx2XjBoMfh6w02SvgG1kd3UDXDozq/a69bKxhySwtaTmqMnCmKYOSIN4/rbtoVIfXEQZZcgrH55Lv0hRJqK5O4dVHXduCaHodoSyXSMxWIlPrvK+Ax0rLzgp/00fP1hM+8MeM0IXWUtkf+DES3y6Wj+Qr9ZUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829270; c=relaxed/simple;
	bh=FtDiU+rxVaVsPbGViqkn1lyxOL491KtdowURLfDIZqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ai7YlRBsfRKXB/hfTZTLoFYlH6Afy6Z1H4ieiiQIAM/L6DSAZk7vCThvLJpcXhXcrWLejGx2NJbfMn0Bu2C6LXSMyg1uEougyGauv4DsV3ZI4cktuJvmwyRiaNBKjQ6nKiDcwr6G75THZNQ40znrzSxdIAeWTVeQvNkme4qiSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrV9GSWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrV9GSWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A61F00A3D;
	Tue,  8 Sep 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829268;
	bh=EiK4QpEsHs9ha0VS0HuVAGzQ+MuOvgStbb4EFNjiDtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RrV9GSWaHa1l6cabUox8A3SbufWedLmPdAf+gSGgExboh8riCK7W/csOcpJi+6z5I
	 teh7vJECW3uGFZtz0h9zEoTafNdoGYEpS3t01youjkZcTcDH9rsMDh9aXvblxu799J
	 SGedthHJvyQoAJ8H/+T4pnrQhbq4Gex96a13/kE8CP0fFyExYunmy17iqjC+eY4Qqy
	 avCC8E4accCj29vnIgRHbkNs9UefsjAQ+3zxx9Z7D8Cxn+0C2y0713sRgxLG+0v5z3
	 v2iCWbrvUhK6UMG1JIWChOTU5lRW4lZ7WuMOvQcUKAMkOt9aEmMcf2Qj58Bqi2WzdR
	 TDJ+SMOqgbfDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E539E8A5D;
	Tue,  8 Sep 2026 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] net: Disallow buggy TCP transitions and
 IPV6_ADDRFORM.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882920714.3227186.1695014517329920721.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 01:00:07 +0000
References: <20260904033543.2635540-1-kuniyu@google.com>
In-Reply-To: <20260904033543.2635540-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, willemb@google.com,
 dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 03:35:27 +0000 you wrote:
> The following operations have recently received a lot of AI-driven
> bug reports:
> 
>   * listen() + shutdown() + connect()
>   * connect() + connect(AF_UNSPEC) + listen()
> 
>   * setsockopt(IPV6_ADDRFORM)
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] tcp: Do not allow buggy transitions between ehash and lhash2.
    https://git.kernel.org/netdev/net-next/c/8cc3aef0cb19
  - [v1,net-next,2/2] ipv6: Remove IPV6_ADDRFORM.
    https://git.kernel.org/netdev/net-next/c/31c5ea8a3296

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


