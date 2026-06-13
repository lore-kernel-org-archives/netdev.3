Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296D2E8B6B;
	Sat, 13 Jun 2026 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388010; cv=none; b=Kg0xt6UixEp6OwpaGSZ98j8Cj50gpMrbnCFo+GY4uEL+lC1I4ywve/m0r2Ink426eMvDHK7lLncPN97Ez3+z+0tYmbxnId1PRM7Poq0m3HOhfwEyPFRxver2/lq8VImdwLzaxiUjaaTolrYgS9foXtt0MnRhZAppTUwQhvNEJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388010; c=relaxed/simple;
	bh=HeQJf1e09DUYIL+aw4gIXqbiPbXa4Dw65OO0fSuGEFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UCwz9Q/K0EcBZcR9gNIztaidGY/l7YgX3TsUEm7B/PUJhCOR01O0+hypWA3ys0vfa3X7mq/CO26EoLE3hTaveiJEBvhmseqRB0v3I1b+Iy8EBqEJKQrbSJkC4WDOUKNJunUB4PEE8ET1HC8GvQZYvrqk/FfJhCsfluuS/SzJ0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T12u3i/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T12u3i/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778AB1F000E9;
	Sat, 13 Jun 2026 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388009;
	bh=rA68kJZhnNjblo7d9Bf6fL30BN3xpW9wSzpe0KiOV/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T12u3i/4Og2nC6ggYzV7P9PtjYGcL4Gcnedicr5r9N03OPWB2Jxg4mEtBO+wnUGoY
	 MF7U4FWFindWxMyf09cTRORXd9Jpsm0jeq6pg4EaQU7/G5KMoijXqoDtzNBeU4goV2
	 SY7AeIdyidFGuDNDt2rR4JF9pZA7HHfkdiLZDXQRBc9eMXTa77XfnfBBsIRjq481D5
	 DcL0Sr/yQ/PGiMTG5cuHa1w0/pNDpsHhvv65Uq5dxC/xnrrJUqw3oYSgFdJcT+fZy1
	 58wrYHn4B+xKTW+qffbw1Q0NV2ArRgZkiVl6VQ/qI0eeLiyVY10fvubj5r72JmRNge
	 LVMEJ1qvvetRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CC2363A54A32;
	Sat, 13 Jun 2026 22:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: Use weighted round-robin TX DMA
 arbitration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138800539.1605072.16594394661463915072.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 22:00:05 +0000
References: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 08:52:38 +0000 you wrote:
> Under heavy network traffic, we observed sporadic TX queue timeouts on the
> Raspberry Pi 4. The timeouts can be reproduced by stress testing the TX
> path with multiple concurrent iperf UDP streams:
> 
>     iperf3 -c <ip> -u -b0 -P16 -t60
>     NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 2044 ms
>     NETDEV WATCHDOG: CPU: 3: transmit queue 0 timed out 2004 ms
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: Use weighted round-robin TX DMA arbitration
    https://git.kernel.org/netdev/net/c/fd615abd5311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


