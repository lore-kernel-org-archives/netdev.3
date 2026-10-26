Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002807;
	b=iqinAboBhvKHJWoPrJWCYhfeayu6SYqu19sQyXY5BogVAPGLj2u4bwGmpQF8Z0PkiDDc
	 tojVdzaQ5Flmnu1pfbQT1/orefHjeHr6ZzaDlSdIWjjWCq27Kd0nInHbWMRl31aUvPvu/
	 D6kDXzl3a8Oq9fusCTPLm/jjmHYcw8ihTFJ9yNyuN8QDZzTP0b2bz+VVYaH4xwDlLrL8a
	 L+INwRlxYFvMV8OoEg90NAdlQUoT5PR45luC+EaugnNcac9NTxmyGDrs5EHiz5I8X9PcO
	 QjVwaFULX/D342LlNSszqsqsOV3dh9M9kErZuZCKfwdkLMdrHIqR88Yo1Dr4sQ/JFCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=MhvlEhTDyF7JYLAlw6P/1Iqydl9GWjW4Dy2s0ZwEJk8=;
	b=5qaby54J7aEya5eHm0i6bJlZqGdFF1F65QFRqu/yd4miKD8lVb7GhJxGrEgw114B51YX
	 AARe72Lvq2MJOHia1SHd1/WCxt7ohYFPJZmrYNrKb/R/UGTbXyI2Y87gtQkmvgUvmhxhO
	 hCJ7p1ET7W4jhwEIZwdXzIa9y1aZHgpGt1I3Qwe0qVaB+WgQ+nZ7PNob9fWsQbIRLnMe7
	 szfIT0LXhoXPAPyLm/xmQmtYw+GdwatnDLTiYxwQxT7gQU6zfiCeURoyIi+FEevIHRLsk
	 XxTCZOOh8lvvznNWQL7id8bwjnQWnPWyLccZ/xo277hwMsxNtz79QM8CLZPEHol5B0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgWjdxjt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5F606A31B;
	Mon, 26 Oct 2026 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgWjdxjt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6391F01825;
	Mon, 26 Oct 2026 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793002806;
	bh=MhvlEhTDyF7JYLAlw6P/1Iqydl9GWjW4Dy2s0ZwEJk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kgWjdxjtIYYAuRgwPz4YKtpdIlx3HD911IUelfp84DO4vRuB9zz2OTLe45q/ntuVo
	 J2DPrSnfhGo6qFNqE71TSWgdR4PMPbJYEch85sQ1+fbuSUhT1BTykScKmTEjl/234s
	 8Gf5w7CdLTwxSRtzri9GHICbXfqqJaAdM1dlRigUNRjJlbwus1VPs19VSbQsRxQSSz
	 9oer54ws0BOAKhAIrFsdQAnHrzYCPnJbRQzGgMgS3bP9eJZssULhz79u+VWqh5ei9g
	 sCTE7LSBDr419PJq1KOGvlcpbheoGgkYdzvDU6afsgeVgOcedW/ojbOuZtmau8N9Dj
	 DFNOMK9UdqwdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444E639F2019;
	Mon, 26 Oct 2026 08:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v4] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179300280507.2542292.1871399042278528060.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 08:20:05 +0000
References: <20261026030928.719276-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261026030928.719276-1-bsdhenrymartin@gmail.com>
To: henry martin <bsdhenrymartin@gmail.com>
Cc: edumazet@kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, nicolas.dichtel@6wind.com,
 kees@kernel.org, i.maximets@ovn.org, leitao@debian.org, jlayton@kernel.org,
 kexinsun@smail.nju.edu.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Mon, 26 Oct 2026 11:09:28 +0800 you wrote:
> netlink_realloc_groups() sizes nlk->groups to the number of groups
> that exist at bind/ADD_MEMBERSHIP time.  When more multicast groups
> are registered later (e.g. a new genl family), existing sockets keep
> their smaller bitmap.
> 
> When clearing a multicast group of a departing family,
> __netlink_clear_multicast_users() runs netlink_update_socket_mc() on
> each socket on mc_list, which does test_bit()/__assign_bit() on
> group - 1 with no regard to nlk->ngroups.  Skip sockets whose bitmap
> predates the group: such a socket can never have joined it.
> 
> [...]

Here is the summary with links:
  - [net,v4] netlink: fix out-of-bounds bitmap access clearing stale mc groups
    https://git.kernel.org/netdev/net/c/6430fb7f1cc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


