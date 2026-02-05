Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712C2F6596
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313215; cv=none; b=cWHctvfd+avwembzPi06lL5rehQAgaIDDwn+6bH0xUAPrY3lraYvq1Nst+uIbUu+JSMSssOLFpk2RgbvS1GMo04/DtcT/FQUjZWP5wUlBm9s/6Z7UJHd+o3iSDXsR2elTqOTz0686O4YagboyvVwVstZOKuM2JC7j/lsmLzmihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313215; c=relaxed/simple;
	bh=iYYqH/kaQ/LmXR/7I7S/RoZ8tllPwr8KwKdm9btvbOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f31wSOFBfwyViixxA5Di8RWahYCVryARmtkM2LADri/My9A6cks3GWxk/gnDsQiJUQrGFcZ9oQqwQoxiGfihUg/uqbq5ZeA3oHygYPXU6uqGyg2j8h80AnLI5eCSv8MMYZvBzdde3LbKypEP9CIxZ4Tms4Pxl8ZGPB8KLbz2pVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EICoCHX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EICoCHX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7D3C116D0;
	Thu,  5 Feb 2026 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770313215;
	bh=iYYqH/kaQ/LmXR/7I7S/RoZ8tllPwr8KwKdm9btvbOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EICoCHX+aYpUEcTuA0gBtcdPT7VpZc6U0moFGI2c+WkUf/hctzLUK/JdMNz559O30
	 YbxJypLDVi4e2sn7xiDD3y0W2sIZEsmngKDNr3mXe4DUhGtEYBHpT0hzYFx1Z3hQdv
	 lAQnoqzgsJSPP6AaduOZNHXPkfqxxc6xUGy9J3FoWdPSyW3pddN7beBshM/bywHqdi
	 HrXtAXeKyVXYZypNhf0TPqvRfD/OKa+aGKFSvab0pAk3AlzsF1ljYc0oRHr6ZwvFAt
	 Va8sNmoeL4COfLo31+SY9PMGNoOh9Jh1ugeHIItktyBaEsKu2SamTuoM6BGAwObaOR
	 n5AmDkH0wCPZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1673808200;
	Thu,  5 Feb 2026 17:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] tcp: remove net/core/request_sock.c and
 no
 longer inline __reqsk_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031321283.505259.883892579863044221.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 17:40:12 +0000
References: <20260204055147.1682705-1-edumazet@google.com>
In-Reply-To: <20260204055147.1682705-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Feb 2026 05:51:43 +0000 you wrote:
> After DCCP removal, net/core/request_sock.c makes no more sense.
> 
> Move reqsk_queue_alloc() and reqsk_fastopen_remove() to TCP files.
> 
> Then put __reqsk_free() out of line to save ~2 Kbytes of text.
> 
> v2: use EXPORT_SYMBOL_GPL() instead of EXPORT_IPV6_MOD_GPL for
>     __reqsk_free (Kuniyuki)
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] inet: move reqsk_queue_alloc() to net/ipv4/inet_connection_sock.c
    https://git.kernel.org/netdev/net-next/c/d5c539155431
  - [v2,net-next,2/4] tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c
    https://git.kernel.org/netdev/net-next/c/a90765c6f603
  - [v2,net-next,3/4] net: get rid of net/core/request_sock.c
    https://git.kernel.org/netdev/net-next/c/7d2064eb7317
  - [v2,net-next,4/4] tcp: move __reqsk_free() out of line
    https://git.kernel.org/netdev/net-next/c/22c1264415ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


