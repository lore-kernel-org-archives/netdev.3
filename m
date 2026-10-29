Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233806;
	b=T24wRCGLvyEOMTs8/QLH66zJqxXH541cKy0Umoxhvtq+Em+5PDVlYT6ftGUjMLdiShFM
	 Q/22420l0pW4BNo6mkHl2quXMonz22VAUR3UEFGtvPg80NfVemKCZpunOUvJ6viJQU4uZ
	 u7FLqImXegeHP++1kHcNsGmie2TiJjkqsNJVSNfS+Gv9/ZLEpInVHcglJAcEnoMewiPjd
	 rTr2VMzjwm+xkA5ODlmxw4USTWTho20HA0WTm+tdyF9oM1YicGmADUQb81BS2hf0qZt11
	 vdl9pT8taov2mpNckMYRi2KDlNE1qTO9ByDsbC8ZLySZijJ2imH/7+cuT6xR0XvY2hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=MkVJy2ABU9wEqzL8VVpQrhOuiMrCjjMBBCjmXmdQ99M=;
	b=Mgqc3PEHLeLOhVUdDqLMjT8CwlQzLilGsjfSGh1JMxOpan14hJ4xZBnllmT6wipsK451
	 5cxtVNRunt4NyLf70lPB69TlOnUV0g4GrHYzgzB9VqmiCJUSPFYex+ia5p5QEclnAVyO/
	 2nPnpm2lPs4waSzhrBzBX3nyT/Ofi30nHwIz63ieiewp5d3d+xJvZ6CroroEEtYdjosdI
	 wbgdITWDxDbZKD2hy6CsvQaRhYTV5p1Z4DCqxeKkBz2e1HsVE6YN5EOBRXU6JkYI63f0+
	 Noa/WeDm8q/aXpLDXDZLYIMOsPlnRZifJvuJjjiSO//3H/zXkMOvUidZ1+4D4MGOJNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBQez1CV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC75606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBQez1CV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71741F01825;
	Thu, 29 Oct 2026 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233805;
	bh=MkVJy2ABU9wEqzL8VVpQrhOuiMrCjjMBBCjmXmdQ99M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OBQez1CVuwHlgOv27/+l3HztVUAJOtX9KsVcVJB1DLsnav+oFAxdNjWFZAeDWs6n5
	 pPEZJMDIfOYaKfM+1/Hs7MNhklc3QikLPYkwM5zPivjTNfrNLKiG/vK90dawGMXDfM
	 MCjItKtwo139cZ1c/S92PqP4f+DurJVLNBd/RE4ZTXAbU/4IBEXNrR4Om1NanP3/q2
	 uaXwPkYRXDVrF0mQLvOd8c6XntnfGycq/FI9+YW/oW43JPaWNsgSQd5go4k5wk/qCT
	 jDArQxyp3hsNPny9qCouMH3W9ywp78CwOixVM2U5KApfvgrdXusudzDFxM2nwRYA+8
	 bAqmknRsaW2kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE4FC3AAFC4C;
	Thu, 29 Oct 2026 00:30:05 +0000 (UTC)
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
Subject: Re: [PATCH v2 net] ipv6: Protect multiple routes insertion by table
 lock.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323380457.1497553.16735824787366357153.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 00:30:04 +0000
References: <20261027065247.2871134-1-kuniyu@google.com>
In-Reply-To: <20261027065247.2871134-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+751b587577d0ebca10f2@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Oct 2026 06:52:45 +0000 you wrote:
> syzbot reported the warning below. [0]
> 
> While call_fib6_multipath_entry_notifiers() is called locklessly,
> fib6_siblings could be changed concurrently, leading to the
> warning (and later null-ptr-deref).
> 
> Let's protect multiple routes insertion with tb6_lock.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv6: Protect multiple routes insertion by table lock.
    https://git.kernel.org/netdev/net/c/4c6fbb1fbafa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


