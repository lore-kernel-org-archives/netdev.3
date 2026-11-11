Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438010;
	b=U0izxk7VIrsrcsf//xE/GvfEH6d5L7NBfsO9gfovKNtsgd8knecwz9lc67ID2bCZZ+Od
	 DAdTd+KM3AfVLsWFLCXaOCrq4X4fctDuaV6QCXhsRJWj1rqC41qG0vsFKR/wsV1N3ek4P
	 h38M3ykiXs1139u3Pw7yZk5T0RZGEt4+l0mqRURqh2NvUpWaUsprHnbjSFwie6gOfwwWH
	 2KZtv891iJri7lrJ4td6cbF+twadAnpiksMv662M8X2DJcCn2vqVOx3DJbMc+vWexFEN5
	 fULe3FN5V2a95/Tnk3I8QKMQeJxbS7T94LWJZv70Kcid42OvFJ9evISPiQ1VtT9TDSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=KZcycJc23l6NskUVhXEfD3eRHPNY7gNYIBfAcMGeoGg=;
	b=lLJfpmC4w3ro+Fchh6IEJnYlA+P7jNNnLa3nmBpIAyFZkasSyuqjE3R57I2M6qHnLfyT
	 TCP+ils0HGiZMDKp8lCepv8ywxbB1+rYmwTmyQcn14f8zAdoUx5CTcsH8kkor/OSLBiPG
	 6GdQNOXpEKk3EpAPMj5OkjYAdPYi8eSsB+cAujJc18VKgDCxtBHmo6htEX992MaB/Y4wW
	 kyfJrexRmvwlizYNXto281XkIoFXHiObrxgW2wdVHqksdJNgfjaaHp+lsZmHpD3L/Dzom
	 5gke+6lcttLD6ENCfDKUPvA6Yl3pJ9X3BGICewqYAmNFqclO2Lx5Ruvy5aKCMpBmj5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUbwnVNt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA69606A33F;
	Wed, 11 Nov 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUbwnVNt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A7D1F00A05;
	Wed, 11 Nov 2026 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438010;
	bh=KZcycJc23l6NskUVhXEfD3eRHPNY7gNYIBfAcMGeoGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jUbwnVNtmWdjjP8v8jScQi5hXBZ5jWJpIijBHeQ/nbTuAHmva9fN3zLCIEC61FxJW
	 CJorhBmOJhteeNbrcM7Rh46hwLradVhWmM+4fc3Sk26oaIXEnr+Nt4QMCKSfKjwct+
	 ErAC3j9lt/DC8TWTiIAmhhNt6Hmx3Oo3ylXFgl3ui4VlOU9nIqE1r4lWJN0cYp48au
	 tXEbh/gZtNM7jXSIIPdvZpcNGLS1eHbM1KrSZgQ6P+V84vjAdIjgfxT9pUrV6nIZ82
	 sfRcJWS+JBUCfzMJmnFqKRWD0BjhZB+YPvthTrR/l/q0PKj27QnfUrn1Uilqxt8Wsm
	 6yO3Q0li1JDrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210CA391AFC6;
	Wed, 11 Nov 2026 23:00:10 +0000 (UTC)
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
Subject: Re: [PATCH net] amt: tear down every amt device on an unregistering
 lower
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443800867.1692642.5683456205144772730.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 23:00:08 +0000
References: <20261105232302.494171-1-omar@blockcast.net>
In-Reply-To: <20261105232302.494171-1-omar@blockcast.net>
To: Omar Ramadan <omar@blockcast.net>
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 23:23:02 +0000 you wrote:
> amt_device_event() acts only on the amt device that
> amt_lookup_upper_dev() returns, which is the first amt device bound to
> the event's lower. Several amt devices can share one lower, for
> example two gateways.
> 
> On NETDEV_UNREGISTER, only the first device is unlinked and
> unregistered. The others stay upper-linked to the lower, and
> unregister_netdevice_many_notify() warns, because the notifier chain
> must detach every upper device. They also still hold a reference on
> the lower, so each is torn down only when netdev_wait_allrefs_any(),
> called from netdev_run_todo(), rebroadcasts NETDEV_UNREGISTER. By then
> the lower's sysfs directory is gone, so unlinking it trips a kernfs
> WARN, and unregistering it from inside the rebroadcast trips the WARN
> in __rtnl_unlock(). On NETDEV_CHANGEMTU, only the first device is
> resized.
> 
> [...]

Here is the summary with links:
  - [net] amt: tear down every amt device on an unregistering lower
    https://git.kernel.org/netdev/net/c/7262e999ebec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


