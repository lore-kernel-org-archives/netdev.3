Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C233937B;
	Mon, 31 Aug 2026 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217872; cv=none; b=AS6/NXDi+r1pvwsc+OY1mnNcXAeTHL2hDEe/nUv60xnqr79UM6ofRD8BSC1Umq4SVc8yNZt0WfMLMDllvbTIHceHlODCGyBbO8sMUTtVIvwen+PNCvm96HRtfqJ5j8Sr2JI0WBS339gYV418HDiji2vYblJth3oAx03okYBvcrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217872; c=relaxed/simple;
	bh=sqsS6BKl8STjFq7GfXiq8I9ZEFb74NVzMfV779gFsDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TDr1LBa4NXnqhXOuD2zJjqh+mV1Bk/rMweiKGjZn20OdVeuf200CsQfNKP5bxO1S7oZjyr96YzVzx6BcU8L9YIQNxhHAl/CLua1537QVGgna54nNuQBoKxwoPgtaWeJazWyULlBVfS5rzlUZc5EtH0ZSvmnGvNXZbw/SbgKwZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX6ODcHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX6ODcHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9511F000E9;
	Mon, 31 Aug 2026 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217871;
	bh=fTvMy9rkDvERCx3/039j8BN+T2TnfGQtKGFL2YL5wgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oX6ODcHo5Q0NUKFnMGRfwRkvOhR1nxoi7SYLAxbyYgxP/j4t/YYyoQh4UNLZ2FhMx
	 qVJ9zweTIJbufmIVS9kbCkMDsg4vLvdgYa5EOyZy8wzTU481SRC+E7x0iHBeAlo/iJ
	 OCLlbLMEeszsi0jvUyR4fx2HDOOu1MYuHJdtfkD2N+jh+d7/Yh0xDTGD8Lol3AmGpj
	 pKkV0r/JsEHVdd86e7xgvtAOzABXFoNANmJbLSO/mr9DGgM9ishHt+NJmOFpJUyv9j
	 bgqSzD43hVsjbBOiqY6C5V0qCVc7BhbF6E86jhmzQO0da5i3hQLKScLmmA4TSyu7Nr
	 sAXGai2qQNS1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BAE3924471;
	Mon, 31 Aug 2026 23:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7 0/4] Fix to possible skb leak due to race condtion
 in tx path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178821781389.824292.6884805679994851550.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 23:10:13 +0000
References: 
 <20260824-fix-race-condition-and-crash-v7-0-4323279b18f2@onsemi.com>
In-Reply-To: 
 <20260824-fix-race-condition-and-crash-v7-0-4323279b18f2@onsemi.com>
To: Selvamani Rajagopal <selvamani.rajagopal@onsemi.com>
Cc: parthiban.veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Selvamani.Rajagopal@onsemi.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Parthiban.Veerasooran@microchip.com,
 andrew@lunn.ch

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Aug 2026 14:57:57 -0700 you wrote:
> Now the traffic is handled in threaded IRQ, and the
> disable_traffic flag is checked before handling the
> data, new race condition is exposed, in which
> buffer may leak, if threaded IRQ interrupts the
> trasmit path midway.
> 
> With this change, disable_traffic and waiting_tx_skb
> pointer are protected by spin lock/unlock pair.
> 
> [...]

Here is the summary with links:
  - [net,v7,1/4] net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
    https://git.kernel.org/netdev/net/c/5443d9c4f55d
  - [net,v7,2/4] net: ethernet: oa_tc6: Improve the error recovery
    https://git.kernel.org/netdev/net/c/172c974113bf
  - [net,v7,3/4] net: ethernet: oa_tc6: Disable tx queues on fatal error
    https://git.kernel.org/netdev/net/c/349c36636587
  - [net,v7,4/4] net: ethernet: oa_tc6: Fix for the wrong data type
    https://git.kernel.org/netdev/net/c/3cc2aa96b971

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


