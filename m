Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340207;
	b=urXi8zH35pYpl8cK6mteloAebEnkMT0hmLfoXjh0P7Lxlbm8ZjjLeNcdnqdlWdOWXdWL
	 Br2p9pSY0u0LEofaQ+muC/2JkQEwsxvWIzD7JZjuAILwWGKYqrAxDJ0e9QJKRPU+2bNSa
	 YJKzlcaccEVSXMRbF74Dm0RxPlsPvWYZ5Lz3Xd2f2DlAcg0SRTcCNdNsP0C2ine/6am0j
	 8BJTrpy33JduJGuHYwM/KRyVBw6EMz3DMfDInf9wXuZWX1v4Fw1FAwNjvKj5xl0CRZdz/
	 0NIPNErXMjC0hfp8FVvi5cNY2ytVOciQF1McNwAicUdtDw8UWmCYQGeQrmrzaSERkNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=bdoJoBV+Vh16ChD/aFV8bOkLqDWVxOGOUNEvQVEWSMw=;
	b=23L/VW4UgQTcPy25XYQrZ6370aQPXLbkaV6zlCDguCw60wwkQyy7+8J1rSCnJAeekly9
	 SKAhSnTa2jXah75XYua0RS+lOXi68d6mALWtT1ZAThP8GNzcJk3Zlmjo9e+lQnfrcviHh
	 E+BtFbFYdt4Tmd1Pw+cpIbOuBGUZa6YWjP9HYgES9cV5QTnZTR/uGHaAGaD8MEnNPjsjr
	 v/sMsIIX0O54SwsbwcV6tXfq0AH1EihlUKaLDJ8/RzHfJJ3ZPYiEFelPwiybdLV2NzCiD
	 Pw8fAjqu54Vi2XBqLiGtEm6B7uq4ZgLfBaeJYB198TzynCH8sXnsz0fZASjiWbn7hdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kz89Tr3n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE500606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kz89Tr3n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307471F0089F;
	Tue, 10 Nov 2026 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340206;
	bh=bdoJoBV+Vh16ChD/aFV8bOkLqDWVxOGOUNEvQVEWSMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Kz89Tr3nIgvLm5yZ5wKyueUiDH/UEzZRcco0ardUp+yJxwHQLJTfEIz6KAAwVBRw9
	 nxoctmGZvcsef/ifaR46FVJ7hr2KPxhtvqJLPe4cUosQ+s1uKJhWijuf8sCCUekSv2
	 v2/GzwIEf205lwaf5Anvm2XIcxqXt5iCzY0oaPOXarYbjKtL+g1cR4dIKKSBB1VP8f
	 GXV5ztRpptqg0Lh0iDU/4Q2Vqjk+CjlUFQnel0r50VjPlTF6f6QKfXma0iZmzpH+EQ
	 J1QpPajQQ4XGhSGvS2/x8wSowaLfkn0b3o+IvU3XoPrJjbIUGavzExCLbttLlNlf+M
	 X2ynZILy9oXDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2109039D60B0;
	Tue, 10 Nov 2026 19:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net] mptcp: reject DATA_ACKs against a reversed send
 interval
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434020493.26472.7236408102827538052.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 19:50:04 +0000
References: <20261104130747.1045741-1-edumazet@kernel.org>
In-Reply-To: <20261104130747.1045741-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 horms@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 14:07:47 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> ack_update_msk() samples snd_nxt before taking the data lock, but reads
> snd_una after taking it. Concurrent transmission and ACK processing can
> therefore leave the sampled upper bound behind snd_una. Active-open
> completion also exposes a reversed interval when it initializes snd_una
> to IDSN + 1 while the socket-owned state synchronization is deferred.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: reject DATA_ACKs against a reversed send interval
    https://git.kernel.org/netdev/net/c/d75e5cd72995

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


