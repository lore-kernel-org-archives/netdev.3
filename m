Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC663DCDBF;
	Thu, 24 Sep 2026 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219480; cv=none; b=F+TDmCOvTwjwdk+6/JYxJ8nFZmv4+wrk5uJrjC+nwRhjV/AcbhG1lkDhBxbbhi/YOhk7qyRWTBVbcBbLrOQCkgSn5akvjM+/W+FTKgu6SvV15BqhpfJh7nY5FP5PkTv0csAxO8akmTGQzGbpeFTTrFYr8rZSvXsEohdtHyFdMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219480; c=relaxed/simple;
	bh=4iZgjUMQATOd6w6hjELpmeD5dyPYVd3rrCZuIhqqv/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WlEGkGQ3MYFxq6CqJI9AjoXnGTQaEv7Mo59spNd9NVoGXK9e6xtLvYTf+ruF9gfeZRLZJQgmSjtsforbFM0FikB1ZofcNwHMVA1t6FcMO21zJWm43l3jqa7dNCqwACr4kRvNvJ0jIPz83zz2KZ6f9s+v9QMz+nMZrcW/606dBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXK04rc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXK04rc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2BB1F000FF;
	Thu, 24 Sep 2026 03:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790219479;
	bh=/70qZe0+kIFUIiksAdFmyNxjVTOn90KEOqslaa3xsiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aXK04rc+GN3R9Sjy5jRVBsb/vipKTcs3K7ej+lyYrOUsNq9HMQq+mdTYxF4sV1Ba7
	 4ganm9yfoGaGd4jQ9sCfRVnxwm0yc8iyF+JYmLFBoCOjvLo+U+TtnvpLeyLR1rjYt4
	 TiDvCeJpuwUsOANgBF/SmzCo4J4jm9/9lqDQHj0CR1ajLH24bdyEnM/azZki4tvjuX
	 ZA36lItgk40yqz3nRgG/yJXdjxr0jS4t0dqNf54omGJokI7IUYbJpGumiRAXDntETD
	 TnvkvpI9k/S/B5bi8CLm0XNC3f2sbCrkkYbHplQaEg4zkQf6Kgv0JExdBmHNP1Z93V
	 DN/2lgyzVSvQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D093239E9611;
	Thu, 24 Sep 2026 03:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net RESEND] nfc: llcp: Fix list corruption / refcount
 desync
 in nfc_llcp_recv_dm()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021940839.1297601.14086217343331650655.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 03:10:08 +0000
References: <20260923133339.2518641-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923133339.2518641-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David Heidelberg <david@ixit.cz>:

On Wed, 23 Sep 2026 10:33:39 -0300 you wrote:
> nfc_llcp_recv_dm() handles DM(NOBOUND)/DM(REJ) for a socket that is still
> linked on local->connecting_sockets: it looks the socket up with
> nfc_llcp_connecting_sock_get(), sets sk->sk_state = LLCP_CLOSED and
> returns, without taking the socket lock and without unlinking the socket
> from the connecting_sockets list.
> 
> llcp_sock_release() selects the list to unlink from by sk_state: a socket
> in LLCP_CONNECTING is unlinked from connecting_sockets, otherwise from the
> sockets list.  Because recv_dm left the socket physically on
> connecting_sockets but in the LLCP_CLOSED state, release() takes the else
> branch and calls nfc_llcp_sock_unlink(&local->sockets, sk).  That runs
> sk_del_node_init() while holding sockets.lock, i.e. it removes the socket
> from the connecting_sockets hlist under the wrong lock.  A concurrent
> connect() linking another socket onto connecting_sockets under
> connecting_sockets.lock then mutates the same hlist unserialized, which
> corrupts the list and desyncs the sk_add_node()/sk_del_node_init()
> sock_hold()/__sock_put() pairing.  An unprivileged local process holding
> LLCP sockets, with the DM supplied by the remote peer over an established
> LLCP link, can drive this to leak kernel sockets without bound (the
> mis-decrement goes through the non-freeing __sock_put() path, so the
> object is never released), leading to memory exhaustion / DoS.
> 
> [...]

Here is the summary with links:
  - [net,RESEND] nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
    https://git.kernel.org/netdev/net/c/bf1460acdf8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


