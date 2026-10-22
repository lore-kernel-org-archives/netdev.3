Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629017;
	b=5K/yM/0eo/7D/Dg1OwlUPGyZtvVBLnyXZUs3Mvsn8XTZC+9CuPtMClz/8suMTMnfq0Hk
	 qotHTtdrkLkJygDnysCg3cU/0TBy8dhoEkEuJmwp0SGoIQJUK2k69Pw2tCCHV82CfLNnF
	 BSKefQxOlOeqFEf+Hn7jNhyH3mDpGJHXxtC9YnOPzGxOVZyBnH+6yLMplrwtpVNNhaGL/
	 IqaNHCCUEKziDz8JQ3gCxFPO5VuFNA8I3KNRs0Jw3WqDcW4LwzOY4fZRGqXUydxHoDuKt
	 uqKqPSTJQBjjjb+dr6aDdFfzrqOlsjk90u8jPKx5gu6888MN4qFWdfYpYRvOleQoOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629017;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QtjVuPQ7kn36ZSPJwBclqThMAgXwOY5mVnGvm7BncAQ=;
	b=xjwEHeEsT7e1UF175dB8T/prjEBlRccwlXNjsNHXq6JYq49n7GoF5vRm8B0CeSt2eFh4
	 OVHnMRTo73sEV802xPJL0d5NbsW03Z54YIaKbkHAIODf1+S2+FHZwg/947fL+WewvsiWv
	 7gDpX5eamCi/vAFiobchns1+7xHrlzPimSQ9ma9rLmkE9EeR1oshQmW5f9f9J1x1VqE4i
	 S9yqAIzLfIzx+gkVuhq/Q8uwxPRv3EROO8wTee3j0OU/fhjLYNm0kmmQleopwrJvF5l75
	 CSQ7KldNDfWOhz35Y2cCNEt3kCOi8KOI52CISaLVMPpbHXa96KkIzZB8M87ZoEm2azA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfqR6qkx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25311606A31E;
	Thu, 22 Oct 2026 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfqR6qkx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2071F000C5;
	Thu, 22 Oct 2026 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629016;
	bh=QtjVuPQ7kn36ZSPJwBclqThMAgXwOY5mVnGvm7BncAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kfqR6qkxczncMYElE4BFVnPnI+W2MBigg4WNj/sN7Xf7KYaCbop0JoygzdEpJvI2Z
	 1PjaOLIo/djkdiBvtyX/4p3/Q4MZVQmNZGYJ1cOrIAVmK513u+AKPE7AE44R8uizI8
	 u8shg3eMO1XMFOBbVNlxTEjSiIuvnaV/pf+Zdc2KTujryjArKRaEwrlkxCJuDAVwB2
	 JVa8YyxubTfYBYxqmgF0BOYNeF/1Wz+wP8QjiYeBEyu0xDFATbjIE+HFY6IrcRywln
	 TZn0/VhP4rXq5e74Un6QY2dbPgRfYVrX5l98FqioJWsiPXx9+TDTHRdQ2mkBH8wQAn
	 inPTpvGtxsnmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B427E380A963;
	Thu, 22 Oct 2026 00:30:16 +0000 (UTC)
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
Subject: Re: [PATCH net] net: lan969x: fix DSM calendar for empty taxis
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262901535.1378903.9048135017181445808.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:30:15 +0000
References: <20261020-lan969x-dsm-empty-taxi-v1-1-14790f1e7430@microchip.com>
In-Reply-To: <20261020-lan969x-dsm-empty-taxi-v1-1-14790f1e7430@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 10:58:35 +0200 you wrote:
> lan969x_dsm_calendar_calc() computes the DSM calendar schedule of one
> taxi. sparx5_config_dsm_calendar() calls it for each taxi, reusing the
> same sparx5_calendar_data.
> 
> Before this patch, the schedule is only cleared after the n_devs == 0
> early return. For a taxi with no active ports, the function writes
> SPX5_DSM_CAL_EMPTY only to schedule[0] and leaves the remaining slots
> at whatever they held before. For the first taxi that is zero from
> kzalloc(), so sparx5_dsm_cal_len() returns a bogus length and
> sparx5_dsm_calendar_check() fails, which fails the probe:
> 
> [...]

Here is the summary with links:
  - [net] net: lan969x: fix DSM calendar for empty taxis
    https://git.kernel.org/netdev/net/c/a031ec9ff5a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


