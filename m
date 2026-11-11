Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358211;
	b=OCsP/nKKemlY0gZWH9Wutcu2A0TJc67p5PFiOGQsJy/IDsVYr884Vq987OmeGWjzxAhN
	 7RFOxc40o9VmG06vIBB1VYUSy52d5WBe6bcMtUezjAnXXT7L86MzA9ZAxhqqlkTSCGAY+
	 OBIjSf5u8TUq1yrYeklBDzyxTYa6oI3jCZ9Vk180JptKm5XJ4GWKeIXhkVzNWUfiqDDJy
	 +BrPROFpcZx0PwH/fUnSbwPBEBjrzlOissPqr5FRT/uzECj5CCOeH/536GP3eRPaWuKUH
	 O1qPuMwR+UvwNvLAjuQAaYwgSAg4hCbrTyh+kNodYezmqwVWNCRV0o7Tbgm3k7n/AhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358211;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kux+ABqdhO5dUm+XjTZIOe7W5RzoPjOxZ45yGPbU5vU=;
	b=QMdRqGrlZZgDvoBcDlXqVV+40J5uoh4qjgRn57uTacW1pxhAjx5bcENurIqNOghG2w9M
	 nyXLJqU09U3PUIa+rtpSF5b+EmoLtDu0z2Y/ajeUd7oNm0H+RmvWd6/ruxTk8WruMdFsQ
	 1odOBu/KsUa6xODiSVg45X/dt6Qnl5do/uq/0M3UNagIODBvHFwt+kzcqUkTju9BdGw65
	 FKalofxCJQrFo2jn00UdBTYsAVmZ2OtGO1VtGfERg9hsijEtzBbwWM4B/OPjmCL2hUg0G
	 5ucDff22SfVpefCeQWTSvZRgwULKQloIJIOo9ET57Yg8nKg+0T26rXYsh3g6UUEWbCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVSgSCLU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17461606A337
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVSgSCLU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E385F1F00A08;
	Wed, 11 Nov 2026 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358210;
	bh=kux+ABqdhO5dUm+XjTZIOe7W5RzoPjOxZ45yGPbU5vU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UVSgSCLUV4Re6U+qmzo/Re2fj42Bxs/+6dNhI0LKUhd5eMSoIQy+2Vui1YncFL9na
	 VUSNdsrYP6/YWyilUPkxqacn0v6e+Oxqj/sg/HiapkQJK6SUR5a5j9MMcW2vwQZjRL
	 FDtjb502VkTJ17cImg7ABfdzVExmYgix8yniGKC6yHl7vwM8YIYgLq9exQeg5vVB2w
	 hytMXsWjPG5hmIty+/19I/HvXIwim7kLk9SrF/XOiHMmDWgFA6PfSEp7x0T9i3Go2E
	 2wwi5nO+gqARVFSNgU+MFmUNG5I1sEcJzSHV0b4HtihJkXxG8KBriS7GPdniTxUZn1
	 TCo68zyVDotpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D817339E8A55;
	Wed, 11 Nov 2026 00:50:10 +0000 (UTC)
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
Subject: Re: [PATCH net] udp: do not use a cross-family sk_rx_dst in early
 demux
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435820942.142717.2777369707623922209.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:50:09 +0000
References: <20261106110135.2161204-1-edumazet@kernel.org>
In-Reply-To: <20261106110135.2161204-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, willemb@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 12:01:35 +0100 you wrote:
> A dual-stack UDP socket connected to a v4-mapped address can receive
> both IPv4 packets and IPv6 packets using v4-mapped addresses:
> ip6_rcv_core() no longer rejects a v4-mapped source since commit
> dcc32f4f183a ("ipv6: weaken the v4mapped source check"), which kept
> that check only in tcp_v6_conn_request(). ipv6_portaddr_hash() hashes
> v4-mapped addresses like IPv4 ones, so both early demux handlers find
> the socket, and both __udp4_lib_rcv() and __udp6_lib_rcv() store their
> input dst in the same sk->sk_rx_dst.
> 
> [...]

Here is the summary with links:
  - [net] udp: do not use a cross-family sk_rx_dst in early demux
    https://git.kernel.org/netdev/net/c/5636e6732056

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


