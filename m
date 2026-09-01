Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1C4307481
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225076; cv=none; b=O44LcPrVE+yKodZt3ctS6loeXGfbNIZCbqKW95WAh0WQ0sNHYTOyUlkFwMtNPvEPazwnvUm+7qyYDBR7onXU0QT5SyPpYVe9TaKb/TBjUVjOKYvBuHmcsNPDHgahl3HEmaBnUPhebLZxXqIl1QbZgDyK1x9pti9LzBE6CiRuQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225076; c=relaxed/simple;
	bh=Ff9EVK2+wOh0J+86204enxXHdiYhjRE/02PmCUxigK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rUOBCopanWjN+3FjOiG3mfml6jP33OgTYbmVcyZ1X9Ud43rQSVq7yPKnz9zHjEy0LmIoykze+WNH1xm3TZwVhN7RpEJ7UpNinKPyBUPW6SSCaExJmnh5kvtjPQpaoSMKMihIcgGzw5F2YHvyMfUuFmaJCrvlBNqOBuuL0m+uOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPNVIfqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPNVIfqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C061F00A3D;
	Tue,  1 Sep 2026 01:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225073;
	bh=h85wkjH80bMVeJnMCvpmBS5OsfqvSKZxoYCYVGJUq+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HPNVIfqTRTHnJ3errNJQPn+lyFPIsY99LwaWrSSRdVUJAIOiF1FSvMiAPIXxBRlgD
	 cA/92MGFgTj8Uk1/ooO/Tu1XvqAZR3izdJzbshRPRgYK/MClosE+qrzxuhkNy+9vEJ
	 8dw0il4SWakuXMvCk7jLIJ1IVMTRMvFAjXJ5J5bh7xPDf/PQ2Y9RpqozqjyBEUXZr6
	 wwaF1PyoO1xwfzjf6oaRz9iiY8ismTl9z9LDs0iqdp/C0wnd+jQXtjW3/wNFUogVsA
	 EV9uiuqHeJDHTCjWpvnOLVA/wK1pDmZT4oAI/xF0UkfxyTcp47RKAX2ksX6LRPNega
	 GA8VINOjEKwww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2D3924A40;
	Tue,  1 Sep 2026 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_gre: check tunnel info before xmit in
 ip6gre_tunnel_xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822501639.865139.5430949835495837120.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 01:10:16 +0000
References: <20260828103731.1951815-1-edumazet@google.com>
In-Reply-To: <20260828103731.1951815-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 idosch@nvidia.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, shuangpeng.kernel@gmail.com,
 dcaratti@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 10:37:31 +0000 you wrote:
> Shuangpeng Bai reported a KASAN slab-use-after-free in
> ip6gre_tunnel_xmit().
> 
> The precise KASAN bug was caused by ip6_tnl_xmit() consuming the
> skb during headroom expansion and returning an error, while
> ip6gre_tunnel_xmit() still held the stale pointer and called
> skb_tunnel_info_txcheck(skb) at tx_err. That specific bug was fixed by
> commit 87f21b59ddc6 ("ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()").
> 
> [...]

Here is the summary with links:
  - [net] ip6_gre: check tunnel info before xmit in ip6gre_tunnel_xmit
    https://git.kernel.org/netdev/net/c/97cc84dad1d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


