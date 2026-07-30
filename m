Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8E43552D
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417678; cv=none; b=Mt0D4nj7KdWaiojWEGy+2PTI0vIopFw38G34YUjSe9Jv3owDaxQ6WVqouwv0t/+Y3hn9jH/tCdtZFFBTeIL7LTNaDaQwFrJAF7aemgoHiYMhUdObdmlz0K8/jkvNeiRqfUxRrLQzdMGHY/n++c98hro2Rglz5w3euvtBn3kPv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417678; c=relaxed/simple;
	bh=op6Hj1/txbTAlJG6H7kNFPlwn3T5hoU4jjv1332I1bQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d4x5x5nfNq6GQFSvS09VOvSqi19fOYIEoyPPO/uMLjowpkszTwu4h/A/GwdngrE3q4+R9C/HwYbkpHYKpeYp4/rWRgXDJYLB4x49GmAYUZGlm8v7AfKxKmvoxJGs8MWQumztTV+Gk/A6fWDZcUstqnMJSoVe2gJA5t1qX963yuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsxeMtV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsxeMtV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7E61F000E9;
	Thu, 30 Jul 2026 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417676;
	bh=ffduiuOShIfi45gElbSODFRG9bf0Ejn9HvuQYifhT30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AsxeMtV1Qdc5ffo06n84RSUgzNPt8MXi6EZau/F95iS0Lj88v8BnOaHZa9gRAeqH8
	 KA3XJeeZ//D9/5meL8+tDONUPbX9L/7OF8F4nS/olB6wU3sqD4E69ylQM6xmn+Ie3f
	 3OuIrW6d1vRDieUha2Yk1qDcLDRVNA2LRZTZqDK+qaOY4vK1Ibmgsj5gN+vTa7hVZ1
	 TUhzCDzG0kjhMgpP5TVBefw6KzZHO8uUA+bfgTO9hgnLPut/JuVPrqY/hQ1zfp8CEL
	 EFlkrZWn3hm8OErfK3+ueov5bLSgm6ijv2+CYVCNZgIDeCoTw2+g4XSq5EvYw6QfEF
	 BnCjdNREf9rXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0538119D1;
	Thu, 30 Jul 2026 13:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] qede: sync udp_tunnel ports outside qede_lock in the
 recovery path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178541764013.3566031.317291305137906808.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 13:20:40 +0000
References: <20260726104311.1782900-1-den@openvz.org>
In-Reply-To: <20260726104311.1782900-1-den@openvz.org>
To: Denis V. Lunev <den@openvz.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 Jul 2026 12:43:11 +0200 you wrote:
> A TX timeout on a qede NIC that has VXLAN/GENEVE tunnel ports
> configured wedges the rtnetlink control plane of the whole machine:
> 
>   NETDEV WATCHDOG: ens6f1 (qede): transmit queue 2 timed out 10226 ms
>   [qede_tx_timeout:586(ens6f1)]TX timeout on queue 2!
>   [qede_recovery_handler:2665(ens6f0)]Starting a recovery process
> 
> [...]

Here is the summary with links:
  - [1/1] qede: sync udp_tunnel ports outside qede_lock in the recovery path
    https://git.kernel.org/netdev/net/c/451c9075d6c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


