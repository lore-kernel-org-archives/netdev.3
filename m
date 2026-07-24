Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09F41D22B;
	Fri, 24 Jul 2026 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931685; cv=none; b=IyDtglx10xSHSJFSBzr2QDfglYukDqvkXJk+rf8ng45+KwdLQiLspEkDwiKkyUZqkLONgXkiSikjs6A+U5iViLCt6Zr8euAnUZWadtSV/xXkUgLGFKPgnq05FaSUjXmopO+q1vtxVy7u+kSzJUhzI3IddzHYUZI1+P7y9++rL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931685; c=relaxed/simple;
	bh=0oFV58+lJGX2nj6e5hUVVou981vuxQT/ozX6Zu3LyZ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ja4oiTYjBPqwb016ihIxiTL/IiHVTEfnBEOEE7WFrC3foJUCFRy9HMAsIvGdYw9WdwNMZHcEzhhiQ/Kx98nnVqNeVNCK66Jj0ptHhJ9S/nZ1hY5TANtiq1g03LCVIDMIl4bUnt2hBCHAnhaq+7ajsxb4Dd+GEjaam1O9ruuvbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okbU4jVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okbU4jVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEC11F000E9;
	Fri, 24 Jul 2026 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784931680;
	bh=O+YxxvuuQq9OFP0iQ/hdWLnf9nsDZfrHdPyoxS9vj2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=okbU4jVUFjNtRDEPOQUXkArXod+RmeKMSRfEL6extsWgrQWnNCHSLF1kJ1auPvN+k
	 uOAdl86WLJd7HuqqXa09UeY1GeW+K9rDeRyz63ffjaVWshkCxdjTI9ksf7DHyN1RIU
	 DEiuiTYZdG+KmNMCbNcTJ6lStktOAJ4ZcRkdol3SjLEEVokP/J/vEP1PebhENIDn7B
	 /KiGm40Ik8G8Cl2sh6lFjDoEPRMb4ySk7T7aNxynE/NV7LYKUyQfFDgNNZJX1zWXNW
	 i3slS7YVhZq0+WkVYUp/l0yqDSxPkqJonCiyHQSeDhklWjuNoKjKajvXwPq2vC0+sF
	 hEzVKmLnjp7ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B3738111D7;
	Fri, 24 Jul 2026 22:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] af_unix: fix listen() succeeding on sockets in
 the
 wrong state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493164714.3333291.12886050021145598875.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 22:20:47 +0000
References: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
In-Reply-To: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
To: John Ericson <John.Ericson@Obsidian.Systems>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mail@johnericson.me, horms@kernel.org,
 brauner@kernel.org, david@readahead.eu, cwang@multikernel.io,
 sergei@zimmerman.foo, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Jul 2026 14:29:01 -0400 you wrote:
> From: John Ericson <mail@johnericson.me>
> 
> Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
> reaped sk->sk_peer_pid") inserted a prepare_peercred() call between err
> = -EINVAL and the socket-state check in unix_listen(). Since
> prepare_peercred() leaves err at 0 on success, listen() on an AF_UNIX
> socket that is not in TCP_CLOSE or TCP_LISTEN state (e.g. one that is
> already connected) now silently returns success without doing anything,
> instead of failing with EINVAL as it did before.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] af_unix: fix listen() succeeding on sockets in the wrong state
    https://git.kernel.org/netdev/net/c/f0d9c3ffc2b5
  - [net,v3,2/2] selftests/net/af_unix: test listen() rejects wrong socket states
    https://git.kernel.org/netdev/net/c/7f57c650d08b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


