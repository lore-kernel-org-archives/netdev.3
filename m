Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390005;
	b=QWmU2MQnDBU/3u2shwpOLOsmhVt0WZgA7rYiZNjgHyC+T4KbOBU2y9Xz2+O7d2/aB82v
	 qYV9b42/gK0CC/tIr7fzzbES5W2VFfdAo4ivIN8PxWx8/ImRg8vp8UYHQObUiReU0jaeu
	 UVb6fsyIZHRjizPY1R93Hkfxu3tcDOuyJ0F21yQU2Pmaqk1+KTKVU+VxzGNOZV/xfuiqb
	 n55ERajVULR+NMRpAH4V8B0AO0cH30JH7RcPzTG0qJemvTVBu5CkeL8A2S4gYDS0+LT85
	 QSAAqMpLcSRSoLCAWBTVwWLSYtETBajO4zE125XHUx/WiuQ863v0zcOs7GEZ3G07Tdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390005;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=H9JSoPUcQcq9mb7X9jQRMYVecLCKjY1icR1Yvbbasng=;
	b=EOTYw5/hCqwommvEygv0NgN3zwGwA0kJgdBTOXW2GdgxXTWgKZ7Hfy289MBiobrKxfhS
	 z6a2rbjhBOSG3V6tWICo8p2TmH+S2SJMoaDgrM5QpbQvbNS8TqmYwQ0OgFniOi2zbqkJs
	 EHtmfcif6Ohz21xkOZx+1SoU40rSy5X0dqbDg+tIkmOXzqn93/wUv/KZFpJCn9FZM4pwn
	 jzBlW/jkGEGuJUCwiKgWLR1XMxTjULsyXqGRSQxvWjY2ElQu+wyz3nUkSBlIe4IhR74Ka
	 MJIwWKDIQ9ujHxQvYUdKQLijaPeY4OosXhAUYiPob9q0/mzHJv4zBS0WZdaWSrKrhIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brW7QBZi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282F606A33A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brW7QBZi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BF91F00A12;
	Wed, 11 Nov 2026 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794390005;
	bh=H9JSoPUcQcq9mb7X9jQRMYVecLCKjY1icR1Yvbbasng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=brW7QBZiWDm6bQjm+qHnw26r2sEpbEV34s+Eck91uOutjmlgohWfPrWRAanal4rT5
	 7pXoh2Rw5YI4/gC718FvkK+eRl9zTtg1DetGXrBap1mmQfiwbopy+Dqhuw25D8L2vz
	 B0r3wIxpuWCd9TTLUp7uQRzbRLwcptsbpFBrkWupHenzozEgHV4aGKsNdY7Jj6eZNb
	 sqaONSPlqQKl8pkvbSaXen1vECfFPm1Vs+pOeU/HapTvxLc62veh1iMlHdA0iaF3uO
	 4n+oyl40/UAM1F7Z2LQjbZeIyaYQfOCDrWb2TDj86ClQ4oRgaRY6ZS6wnqygRKc0eb
	 j6GfAbijZwgpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E09C38007EB;
	Wed, 11 Nov 2026 09:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] net: neighbour: Avoid sending RTM_NEWNEIGH
 for a
 dead neighbor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179439000418.824452.1043634381089924984.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 09:40:04 +0000
References: 
 <780b925d4f8b398f425da9cc69ef5b435bdb5231.1793980278.git.petrm@nvidia.com>
In-Reply-To: 
 <780b925d4f8b398f425da9cc69ef5b435bdb5231.1793980278.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 idosch@nvidia.com, kuniyu@google.com, aroulin@nvidia.com, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri, 6 Nov 2026 17:27:27 +0100 you wrote:
> During the processing of neighbor timer, in neigh_timer_handler(),
> when the number of probes for an unresolved neighbor is exceeded, a
> non-ext_validated neighbor is marked as failed. To send the ICMP /
> ICMPv6 destination unreachable diagnostic, neigh_invalidate() unlocks,
> and gives opportunity for a concurrent update to mark the neighbor as
> dead and send an RTM_DELNEIGH notification. After the lock is
> regained, neigh_timer_handler() proceeds to send its own RTM_NEWNEIGH
> notification, this time on a dead neighbor.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: neighbour: Avoid sending RTM_NEWNEIGH for a dead neighbor
    https://git.kernel.org/netdev/net-next/c/368fbf5d82da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


