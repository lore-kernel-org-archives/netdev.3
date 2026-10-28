Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182806;
	b=qw+8AoRLaNZb/LfI5xBqNahXUVNaVrCeHb/EFq3vVzuXl2Phzfh5NRT/c0Lhgv/Uem3q
	 YTRs/6bNh/ELyq4L+2iWJVvQAuk+xDKq0SeXbbpgXBrUt3hxwOgeklS4q9Gkm2oO4mo+K
	 8NnDc3qmufzhjWpIdLIq3p/0rzo4/8Fd/lFqVX/wxWkY8yPf/OYOHI4abcCVxR3xRzR0p
	 jOY0XVD3Kc+r2DLOnutU8XBhrNyWsaYbkmvpyYsl3/IciTK62MQodYIGlCiGqce0aZDaE
	 kB1rZgX5+aZ50rzow3qQIQaxWyRWsHvcF6DXpWpQHiUNSRZl2UFh99l5Itje7xW5xvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ttFynIgy/Xcly1gdjgWDoK67waLOKt/oo+hGSYTDE4U=;
	b=yy+6AZcWM1MfRyr3uTKGEIBt9qw43G7tc4TPaKNZxur77koxXvICYDhUdX7CTUa+zJ+4
	 /Eok1McOAZ8fVrr5CjmSZGqIibgHL2veRm6Vyv1qMooJ4KujzRdmKXyD41IUDdBaQ++W5
	 JHbanofMdS6VUFQVHoJQd1fV1/Z80VLJrTs9iAjLtDBXE7XEPW4xcjFA3+YcT8L2eXxBH
	 2iWPKC3/YR/6CCQ9cp2TR7wMYlCQAV/VxYSDzj2hybqq192zOJ0ool+LUTKRRoE35g1gJ
	 fnsW9k9BTXLC7EYmNz4hRlYu/1PaVZb2S4grsnDZx1T0/htWjzD+jGv+q8ZUPNZePPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ngBrL/Sd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA22606A31C;
	Wed, 28 Oct 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngBrL/Sd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7F31F01825;
	Wed, 28 Oct 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182805;
	bh=ttFynIgy/Xcly1gdjgWDoK67waLOKt/oo+hGSYTDE4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ngBrL/SdB8O3qFUvtXOLQS89OW2rO4K8L0OJbMKgvYDhuScmujS1r28xNokLCN26m
	 VcRIZ9cD+//kjTouB2ytqQ9zaqwXqx8NRpORhHmSdihu7Ci/Vu8RlwsR3F+2ZCrwI5
	 6qN8bW0ojhCTHenBzIVw6xj9BcBktLfgVPCjuA5Xc7OoREYcElT/ZhqV28toQHFxvh
	 jL46cTVyuZ6gsntZrjyYUa3qUMrk/0PTbAeXZpbUmq+vvYriojWYaTgqSe5sRZnnWS
	 Yc9AdU/j/7AEPhWPJlfN2js6wL33it0+VqlbaOpa4GgF6vcTPhJNCqOtY0zCsfL1xh
	 nPYhP/ytKJSMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444763AAA0DC;
	Wed, 28 Oct 2026 10:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net] nfp: flower: fix use-after-free in neighbour update
 work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179318280406.630848.412198034968801807.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 10:20:04 +0000
References: <20261024044903.1130380-1-congei42@163.com>
In-Reply-To: <20261024044903.1130380-1-congei42@163.com>
To: Sicong Huang <congei42@163.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, louis.peens@corigine.com, hui.zhou@corigine.com,
 oss-drivers@corigine.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Sat, 24 Oct 2026 12:49:03 +0800 you wrote:
> The netevent notifier handles neighbour updates and redirects by
> queuing nfp_tun_neigh_update() on system_highpri_wq. Each work item
> holds a reference to the neighbour, but only stores a pointer to the
> flower app.
> 
> During device removal, nfp_tunnel_config_stop() unregisters the
> notifier. This waits for notifier callbacks to return, but does not
> wait for the work they queued. The teardown then frees app->priv and
> app without waiting for these work items. Flushing cmsg_work in
> nfp_flower_clean() does not cover the neighbour update work.
> 
> [...]

Here is the summary with links:
  - [net] nfp: flower: fix use-after-free in neighbour update work
    https://git.kernel.org/netdev/net/c/083aaafd453c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


