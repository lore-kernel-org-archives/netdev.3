Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22A382F03
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479071; cv=none; b=eL9hyE+oshNpwrNvJ4mQ7X7bFm6vNsxKP2Esr1oWm53MPItwqS0kXrXCMKF0aCDzl/9rRdsqNhC4evUX3oMs3JTOeuc0PB4skVl9nSoyUuwnu9bfx4mtj7MldsGses0QSc7PY9Lod6IaQ+NMotwmgOwilNa9hMAsjVXV9OTGjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479071; c=relaxed/simple;
	bh=dy8fb8ZU3DcIE/n/fb0cf+zDds3+7clElToBQ3QuTA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eqVK7UmTzFHE0C/7ndDZ1oz46DkFMfgQEpqr7JX/eULKMqhcTJAUphILj5xKbs0Yn6Ile0BUFCUJnFH7bek3T82ZQ6WBVLqrR51s2PtLkNcsXEIbIGeU52yzlk3+zR5TSt9s50p3E7Yd/8+eJvO9BMnPncLAoFKq+PxTrACTMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJT4P7Mc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJT4P7Mc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3845A1F000FF;
	Tue, 15 Sep 2026 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789479070;
	bh=SweczCFMiiYIVa37dZAn2fzNt4I/2iiJkQPvSBKl7X0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HJT4P7Mcv33RIwtJUcMR6SAVj5u+sIArrqqPHjknqJwhhzf0ok1u9j5KzV7hzZZ8E
	 mOOCanOFZLGJn/FM+a4QBy79xjsdY6wR23vxGboAzvF5t0789nxHlf/YUH+rhdIIwv
	 Cscwky+AVbXxfyMKrLqy94Mufr28neF/Bdo6I3KR6bU0ot8M9XG2p8ouZjzwXdkYcj
	 9anK5/+f52Itw24jvCDCTWTJeE92/CUPDaFB78IFfjdTdz7BQa1/KerhOSTIsmRyRM
	 CfjBR/0qHo8I1rJYx0aVxYR7STh56wCLglFFFdgmSeBnRwS4Ao8uIslWcAMf/ADAXO
	 ritCuAmIqTksA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1997839263A7;
	Tue, 15 Sep 2026 13:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: do not let tcp_rmem be set below 4096
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178947900487.1624210.17299978647712863971.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 13:30:04 +0000
References: <20260912144848.3448026-1-edumazet@google.com>
In-Reply-To: <20260912144848.3448026-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 12 Sep 2026 14:48:48 +0000 you wrote:
> We can hit a division by zero crash in tcp_rcvbuf_grow()
> and tcp_rcv_space_adjust():
> 
> divide error: 0000 [#1] PREEMPT SMP
> RIP: 0010:tcp_rcvbuf_grow+0x187/0x450 net/ipv4/tcp_input.c:939
> ...
> grow = div_u64(((u64)rcvwin << 1) * (newval - oldval), oldval);
> 
> [...]

Here is the summary with links:
  - [net] tcp: do not let tcp_rmem be set below 4096
    https://git.kernel.org/netdev/net/c/83a945a529d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


