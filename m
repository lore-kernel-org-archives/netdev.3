Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358209;
	b=simuY1JUbjSKDBHjyEHoXXS/rVNwxE1xr4XnQ8zOtOP+kPsTigYiKugYDAvKMx/YYuMl
	 2aSuPdTjMd9sZh1X3o8SLT+O9Pl+YIZfAxwfd2n1PWPlmwuGWq+ywGJzjE+lblLF4P4oN
	 u20t92XA/RCy4rL1/R1Rd3QWLOpGiaJknPfoUekr/PrJ7rZjUrutEaWCYdvt6sNpZ8UcP
	 q9eN2LYucAkEuB1SPvDyqzPO1d1rIcyhCiLCmMfyzEWWnPaevXgDCy7qwScr/4n09YCMr
	 m2Xof03WpA72LmqUaO8quvR5KmW4mVOK5q/xKM/4XpreyaBKUI4Fw1TcSX7aWsEcOeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Ha5Smbb98YkJ0rW+4V5BnLFoJAhpoEPnEkudR7DQLks=;
	b=BB7//GQZwGa6QW4Qx+AblWHah4A5+h1EPWOln0tGR9zw51isWRTL/lpTtYASuzsOi1P7
	 WqoZbbrjZ7f+Fr9J47wysgoC+/iw13gICMW1MZFnP852bFQmzuj5+UmDKLqsYmYGCc7Kc
	 y43OmXLHaSoOhM2kzfqZSluU3tBkK8altoIflN0EnoMedIGdeIgoP93QYfKw7FMjjjmtr
	 o/Ra6x9zypFLzE0FkmCT8pSjceL72XbcMhOlISMQ6YnNesW1+hT1v4vDMeUj8n1fY7lcA
	 OBfUuhOdlCRh4Ky5McbP9qntHi9YKYBJf08wqk0q+1rri3Ovg98jGrtFbdgnGBAf0/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KE13cqiQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105560A2602
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KE13cqiQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FE91F00A07;
	Wed, 11 Nov 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358209;
	bh=Ha5Smbb98YkJ0rW+4V5BnLFoJAhpoEPnEkudR7DQLks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KE13cqiQKvrNjNLPK3NE8c/3eOJKYUJGEA07PEX2xQTmZdQK7OkQNrdXEqZ3+ZbYl
	 ucpJF7H6Dyql8ExJg95ySGl7mBpPjcgQIpde+oZ7Lxke+3zRqp+LbJBtzayvt9QkY2
	 bIwkpo2EN8V1EmiyIuwRt1QvRinA+19OKtTp+qmX+TFL5QhQK1CHzgR7ZOIU/AASLR
	 /PoD00kgn9ijSe0VezSZOitZOq3tg6E7lBKOFDTnrNpQJpOAaPfopOHXtTkrO4pNJJ
	 nEi4kTzuDIxCVSL2yEU2B63M8v4MZy5PTQ4cbGguYEAE2nknOziHzsH2yJyjPv7ZqS
	 Qkl9fKOR1nKgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DF9F39E8A55;
	Wed, 11 Nov 2026 00:50:09 +0000 (UTC)
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
Subject: Re: [PATCH v2 net] tcp: do not resurrect a former listener with
 SO_ATTACH_REUSEPORT_[CE]BPF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435820792.142717.4771746266504404621.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:50:07 +0000
References: <20261106084300.2029567-1-edumazet@kernel.org>
In-Reply-To: <20261106084300.2029567-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, willemb@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com, jiayuan.chen@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 09:42:59 +0100 you wrote:
> After listen() + shutdown(), a TCP socket is moved to the closed
> section of its reuseport group, while TCP_NEW_SYN_RECV requests
> can still reference it as rsk_listener.
> 
> If SO_ATTACH_REUSEPORT_[CE]BPF is then used on this socket,
> reuseport_attach_prog() calls reuseport_alloc(), which resurrects
> it into the listening section of a new group, even though the
> socket is still in TCP_CLOSE.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: do not resurrect a former listener with SO_ATTACH_REUSEPORT_[CE]BPF
    https://git.kernel.org/netdev/net/c/8c011697f76a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


