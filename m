Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76C50B426
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059607; cv=none; b=MvDyleP4xuaVH3xPFJ2l9UkhbnAsoJwkpAP1pZLTVLWbPxhrbEWavdk7r81bjRPtUM7kXQwbw/KzUrgHcqLXsTY9HhuTz5SUu/675xSNaBbPaO3if20a8niFC/wWGMdGDt+5cIO0qjTErphpS6vylr0jHQfXt1RGAMSgRJzGCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059607; c=relaxed/simple;
	bh=cOhCn4QpXqfkv1lZlC8p1evP0AOxcAwAo5HJ8r6GfSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ex8ISUqvFSVx3GzLt3HRIP/grJYLXvQaCFsxSGgzW5vcsrMIVLrQ80tBDQ8BtiwaQ22bBFJ7OTCqp6VI2upRR4hRROcflEZt9s+LhxybK+zjFqwOHHM66ynrRn3eC9t2OD5gQ/QY0k2742Rhjv6I99c8too59tHX3JZaztA4HTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDEvNJVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDEvNJVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418541F000C5;
	Thu, 15 Oct 2026 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059606;
	bh=klbLi87BA0310Sxj84wFkI3UXW/5VII9IZf4BKSigRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gDEvNJVEVbRJEVmz5j0BphzRbmhmPRbkiWfvy8QO1mxgAfhLbIdyzW1a7Fb+FHUg0
	 EfZWGtEgtWZxU1EHUBweJSw1SlYdHtWW6jYEb0/QJeUKX425dALqQugkO+gIpxPoCt
	 spEPx/8+3+uq0a7QQQkqX7kbBE4Had3IGfCvx1ipA5Gb2y2l2BBIT3ClXCuRc+M4BI
	 O/yXjHrP3rW4THBozER9rCmhUtkWAn5gFZXDDPzL5bd8jOMmfLFjzH07fI8IgPXt+O
	 GWU4c4rSlKhI/uz/WBa5unDCMHwMxJ0ebVVIUjhOn+nGPjd8CeXHvJdmnC9ByNlk1f
	 NkdVmhVApo7Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A27E392EA53;
	Thu, 15 Oct 2026 10:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] hinic3: use skb_put_padto()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205960478.3334389.15521360243020555419.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 10:20:04 +0000
References: <20261009084533.735996-1-edumazet@kernel.org>
In-Reply-To: <20261009084533.735996-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Oct 2026 10:45:33 +0200 you wrote:
> hinic3_send_one_skb() pads short frames with skb_pad(), then
> sets skb->len directly, leaving skb->tail stale.
> 
> Use skb_put_padto(), which updates both.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] hinic3: use skb_put_padto()
    https://git.kernel.org/netdev/net-next/c/6329e8232aa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


