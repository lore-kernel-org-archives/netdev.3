Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611206;
	b=ygxal9i3AlVG3JKhU1KP5f4+1iI1kxYn2mTmBrAU7g/r9qy8DTJgKVhPTSK57K0sol1K
	 XsmpyzqF5dE1SkzaESvONjpFDYl9WyraPmAlblL1iXBIFwxM2LnsCjk5j+knp9GyA3cix
	 6ULmAa2xqWEDKOtsWom5r8XzF092T6B09aLBR5iekCxVNbxMX0D4vLhVcAjWgzNyxFdbA
	 Wdis5AnYt041k4ZYG5cjxQlxtIAn/En2b8wUpDcZvQ/HiomlrxZatx+GT6oOi43M35VuH
	 /xejSOZB5FlEKK0ML6NKvzlOZ8zcv1USAQe8ZFVnc5XSDrIXd7xMOzxrASH7ImIoTvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2TR8hIk4QIo/VA3n6pSJ/Sl2fmNVlc1+gWnV6oYLkAg=;
	b=cL2uVrgJ5S94+3x5oWkmhr+uHgbXtlubsPw98PmeUTGhwJ+m8IGSJ9UAImo1hslnCBOa
	 2MdhV8NHzkghBWbp5dL+UJFM6T98HTkAJeEBU6HvFfn7dUxO7k8NnakYtanjj+oxmNcCo
	 XB4KEeMtOu/lgLQX0HDPpGmiuy/AqYoGytuBRdbNggFfWM8UIBUCufRuBuJgn7mXF53JR
	 LZDVFfrq4qlEQaBFNrucawiP7av0MXTVG5gkf8oSFxbfFsfAjUyOepjatw8ya5idf0kLZ
	 Q/grSpifHVhGovN7wrU/H2KYXqquBKsM0WKTMKywktKuFbU1rKNQpvvZDcvDm/mjPkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5jLlGK8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C905606A324;
	Mon,  2 Nov 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5jLlGK8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDDB1F00919;
	Mon,  2 Nov 2026 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611206;
	bh=2TR8hIk4QIo/VA3n6pSJ/Sl2fmNVlc1+gWnV6oYLkAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g5jLlGK8t0/gWrXUxcEMboS7BJ+NvHsHCiRlqjaG4KWTDZcdDNrFcB6XmwD3TEk6c
	 e7iHuUYmRVw84rdCOtFFeMS+9oqB1M+WVX664mfpVMAD53JQJjkTTixZk7JQu9zRuC
	 DeYSW8g70iXUxViVyG/tckR+VF1Pu6ZLlrzrvLmRhiofyEoUhLV3N8oYDBWVb7YM+L
	 /ujY41uRGzQmlDX+VGf7Xy9KJ3Jl6gFxPJhtAaQobQu3XOSuVed685OTJhZD6Lvf3u
	 Q6wPEc/KfXOiMGg6CfNZ4RKJYa7XuNj2Ibbxv/cQowqtghEV7Y8nKsxlCud166XgAZ
	 laotx8eg5jC2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0322A380821F;
	Mon,  2 Nov 2026 09:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: wwan: mhi_wwan_ctrl: send a DTR drop before
 it
 can be coalesced
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179361120480.3887292.4141193242882742731.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 09:20:04 +0000
References: <20261027171055.1796482-1-peter.hunt@opengear.com>
In-Reply-To: <20261027171055.1796482-1-peter.hunt@opengear.com>
To: Peter Hunt <peter.hunt@opengear.com>
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 dnlplm@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Tue, 27 Oct 2026 11:10:55 -0600 you wrote:
> DTR/RTS changes are sent from a work item that only sends the latest
> state, so a drop followed quickly by a raise, for example TIOCMBIC then
> TIOCMBIS or a quick close and reopen, can reach the modem as just the
> raise. A drop matters on its own, a modem set to AT&D2 hangs up on it.
> 
> Flush the work when DTR goes low so the drop is sent before ->dtr_rts()
> returns, and flush it in stop() so any pending state is sent before the
> channel is stopped. A drop that hits a full UL ring is still retried
> with whatever state is latest by then.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: wwan: mhi_wwan_ctrl: send a DTR drop before it can be coalesced
    https://git.kernel.org/netdev/net/c/10f51f4fb99d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


