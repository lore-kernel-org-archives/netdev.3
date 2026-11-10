Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279279;
	b=CppEuvVMk45Cis/otkDqlYu2x4HkB5bx8T9+AFdEtSstqBbo6UOEAxXLMAjnGxNG83gQ
	 7j18v0AcxkzIadL04X1zZYVvBirb+ul6E2RGE1SHCgsdi5AqBiTr1NlEV6GjEVhu0q3ip
	 C2xmVgdTNhflsoMuoNsEWDO7cVUAUlKQs5v6B1AunTby3kjBpIgZrA1wBX8YbUVIl6HcS
	 KPYJ+WOeiz81cZp2Q3cUZvL89ZGU5TJ3dPdB8hZK9Wwi4gxs7wGC02hVC+U0GxeTkCdGA
	 wIAWcRQwWwuH5hmvQiikCe8C8kCqQTIoCoHOC95/KBkUNw6xzRYSvUa9/0Vl8MQJuGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279279;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Qp+I/cESJX6hyfO8dGvEiiipb8CSLOeBhQAUwdUf8P0=;
	b=MNU/PuMnr77obetHJoLTaHbekFlls/wfaGFZZEa/WlWacbMiSMgSuIIj804gUXjxjGpM
	 Dx3Z0fAVZp8dC+O1CODtjWxiGTVYgYevLQABPmFk/SGfg4ymcoBELC7pQh6aX01jawsZT
	 wXakEfgMNIPp5muxEUjRz+jk5BJxrNKyMDoi3CWzyFnulypDtVOU2+3Y0NzAPJQC9ORBz
	 FgKz97zLo5uCHr3KNb1xE6PS6jk6ALqeMMTwFLcAfZdMYl1BrMImVklhqgXblWsXg22Jb
	 fRDgy/5pWwaRUvL4Icc/LTxhKGLjnBxRnFD+p59/R0A513H71+m2ddOqiwY9GXKeH3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmZJdHkY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BF606A333
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmZJdHkY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8701F008A2;
	Tue, 10 Nov 2026 02:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279279;
	bh=Qp+I/cESJX6hyfO8dGvEiiipb8CSLOeBhQAUwdUf8P0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PmZJdHkYqf/d+HyyceadnsCHPjt1Dt4PQ1WkYV5g6i5qO23JWjm6JO2QNQb/G/YF7
	 xV74B8rXkzIqzAeyTN6SBYNzcoqRPNUqzxWnZiBc6RGYS4Lzp9qsE+yXI9cO97pAo3
	 EeQoXcz3to+56iKnPEFdyBuBJNOGhMDjLIVDFE+sTy6RNSMsUKZpsxzHsevp+FJa6G
	 wzgaQ46yhAkc34pvRgDCJ/yvSqF10srV5q3sE9mttm9ktQ3SEpk3JfowpunKhYROdt
	 RKC6OsZTP2EPPGSD8oVrE0Mscod6AKtnBqi1D4Tpnxbgv9oJhijOYVVNzCyUrdNX/A
	 IEE1j8J2yNzaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2112A391AFCB;
	Tue, 10 Nov 2026 02:54:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Convert unsigned long to u64 for GC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427927767.3612825.402285626628149168.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:37 +0000
References: <20261104082058.452188-1-kuniyu@google.com>
In-Reply-To: <20261104082058.452188-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, onleaf322@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 08:20:55 +0000 you wrote:
> Lim Chanyoun reported that unix_vertex_max_scc_index could
> wrap around on 32-bit kernels, which confuses GC into purging
> a live socket receive queue.
> 
> I apparently designed GC with u64 in mind to avoid wraparound. [0]
> 
> Let's make it true on 32-bit kernels.
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Convert unsigned long to u64 for GC.
    https://git.kernel.org/netdev/net/c/d5f898d4c472

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


