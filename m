Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437415;
	b=lMqJnP1SLyR2ZoSRZyFSl63Sl6kxvsBF6G3ul3Z0F7qW+3FbjMuY0gF8QjbBmvSVsorm
	 mRGmfWNsOmiFMjpmcvQmZ3FeLfd+HQMqXHgjnE7eQbneMdz7ZyyKBDAz4bjUDfeDOtZS4
	 uOIMgAyUkhyRCqaJ41V8ZPYRhJY1nxq6tqAa30zW3tqZYQXb4KFUkXtszW7OfsxZGytTp
	 iL0RUhxflQswYIG1tnsknugSyDwxn65WNmXnXRhTCClC2Seek/klIrY/h+cGRW80hFNbZ
	 I5VYZD+HMRtMpnRLfTjkgLGxIT4xmgusGazHgRfcsCTxMUNLkeukbiERgm6/FLT/NOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=19d40tmrh2S5ufhYSNijo4wvx2Hh4N+meYoo5/jwesQ=;
	b=btWNvi+AZjk+wUwB0bnTrlFh9HENz5UzPulwnNV59O0W7Sk+AaOYsMFMnOtzRGu5jWBh
	 yd2Vlr64nhjuGtJBcN1YuMsETkyrGKJidQejtWKieY6TzU1h1dWh/W0IZUIhlxBnA18du
	 6EQ96RvnYZ6RjKFx7I+B8fYQxf3AWcAwZIeLqCb7sCSnHFTJa3Iu+GVWYWfeoU0hHn6dc
	 PKc03OCl1LoSUiZCm44Hrzl+uMbDbZheV9Q73b/A0BoyAjYoFJbfu4TR0BSiCVo3uonfq
	 ogux38BEa+SZU3NeZGB6KTg85vWyUy2OGVqC7VJHNZiSaciMCBaCTOA214TpZbSHCXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yp+DQ1NY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59B606A89C;
	Wed, 11 Nov 2026 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yp+DQ1NY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665F31F00A05;
	Wed, 11 Nov 2026 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437415;
	bh=19d40tmrh2S5ufhYSNijo4wvx2Hh4N+meYoo5/jwesQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yp+DQ1NYkIuuIZg4JIzTjY/IbpwD9HFyv65rp3obsAgzHk1STe4TVpXXvARN9BK4s
	 NbhxLhoOO8t9Ob0cU32iVZKJe0nfNip+8u9ozO9C5bJ7GyeofZqDs2rX9zRWe3zt3q
	 uY7sZ+VrTIXb45ckV42OXDkqYLAPxmzqFhhzMfIMBeL9bp0iE4/0NEIqRUiEgsaxMU
	 BVfFWzrkIBMLdNYEP8fvgZJ9Z+bNYgR6swow5m/gmBvbY7IQfYNdarsVgWBpog/oll
	 aXryCGPPVecg7WxHjdf1ct7IC+ICXdbjefPhk9xNkdB3BX/xltrDfRLwhB8Pu/5OrC
	 mAiLohZhCmKEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DF58391AFC6;
	Wed, 11 Nov 2026 22:50:15 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: dsa: motorcomm: Stop MIB poll on link down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443741392.1688116.12424000884344273704.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 22:50:13 +0000
References: <20261108104037.1320166-1-mmyangfl@gmail.com>
In-Reply-To: <20261108104037.1320166-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Nov 2026 18:40:34 +0800 you wrote:
> The poll re-arms itself unconditionally, and link down only cancels the
> work non-sync, so a poll caught running kept polling every few seconds
> while the link was down.
> 
> Cancel the work synchronously so that the re-arm from a running poll is
> rejected.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: motorcomm: Stop MIB poll on link down
    https://git.kernel.org/netdev/net-next/c/176da52a815e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


