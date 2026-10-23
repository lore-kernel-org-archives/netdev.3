Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789226;
	b=p0hWUlQ3zYf5YpdCBL6SAUJDNaK0iTnXkQqzLRPKgnhH9sCw8uxrlN8+CrNznCbtGSaD
	 Tevyp+HZBrZZo7LVbba9HlhjL0rBa8C2lbPXDzJoliVoPgxGlTCH3cUxSNGGU0r+ii/g4
	 0+FHb19QyWMRewn43iPddKsEqKlMxqSuGd9UB4ACMKrwdpvull5shz294s1NXZAph60KC
	 Q3dEFyIoxNzhoLmpwI7rcQsKqKfjS3aiWNELOSwxLDg+KknZ94hJQz3GWRDQphOE+n+w1
	 Elv8TQTBjUtEwnM8EbwWEBA91hIFpYIMy8vpm3/cvNUGh2JfEobnhqsR6rh2BAkdDFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789226;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=wMxatn9ZBgj5mTbs6ATeEIyXX0vaFfQVORNtXX+SfPY=;
	b=zTwIWP0l4qQ/UfGgXTka8CLOkLiqXmCc0G9LS279i4wUIzxc6WKkaDNOjsF2eq9XckYW
	 CXeu0W7+C9cV/4aiYhM4Lf+1gvYyDJDX9i/nVJOCuwt2Tqd9luyMC5hERlR/BVSVSzpSj
	 Ck8faHgk8QDjpfpvTzaM8SODa6sahec/3NfCHOx45Pbyw9qSNbfxn1HM3AC9SgHBs3zkI
	 revouiLh4PSK7trcTui7MNxa9h16HoCVsVLDWCs0EzKC2RsjUyil94sqB4mojF5EqDio3
	 Qhr8zoxcjmafx9gZZh9jSz2DWSX1lBU0bgoG9xteG8CCKt6ADvWrQ8yp3wufdnz8vyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Twk5Chpi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC4606A336;
	Fri, 23 Oct 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Twk5Chpi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8651F031E0;
	Fri, 23 Oct 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789225;
	bh=wMxatn9ZBgj5mTbs6ATeEIyXX0vaFfQVORNtXX+SfPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Twk5ChpiEY7kvnfQzH1fP0t11NZBt/4OZAUPgaTYOicR84dfvLo0W3MDNoLFQiOV1
	 rJ7wx5x/ZnOhk0lm6IJIL1iO1wcShildb4EOEzIEyFPu50t+I8xVBsv0upailKrgJx
	 2+5KFkaPVAjPijNF17lATASjFV8a7rQ3DSZ7e2LLj+X35Jl6ILlreBJNejt8gkDxAl
	 3c5VfputP/93/LWJUFOBjUZCQ7UcJJh1qPoXWPW6f+HiF+NDkSWK7gV1gwZJkXLaPh
	 X5LaOo4+gcid3UM+bCiOUPCs9mX6VlypoQS73evK9UjpTu2/K0hoxuubl1qDGlyUV0
	 Jcc7DI34f+coA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815FD391B157;
	Fri, 23 Oct 2026 21:00:25 +0000 (UTC)
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
Subject: Re: [PATCH] net: sparx5/lan969x: do not read past skb->len when
 injecting a frame
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278922406.1268720.4078185766615858241.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:24 +0000
References: 
 <20261021-sparx5-inject-tail-bytes-v1-1-7dcc035c8ddf@microchip.com>
In-Reply-To: 
 <20261021-sparx5-inject-tail-bytes-v1-1-7dcc035c8ddf@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, bjarni.jonasson@microchip.com,
 lars.povlsen@microchip.com, steen.hegelund@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 12:48:26 +0200 you wrote:
> sparx5_inject() writes the frame to the injection FIFO one 32-bit word
> at a time, and pads frames shorter than 60 bytes with zero words.
> 
> Before this patch, the last word is loaded whole even when skb->len is
> not a multiple of four, so 1 to 3 bytes past the end of the frame are
> read. For a frame shorter than 60 bytes those bytes are also
> transmitted, as VLD_BYTES marks the whole last word valid and the
> padding starts at the next word.
> 
> [...]

Here is the summary with links:
  - net: sparx5/lan969x: do not read past skb->len when injecting a frame
    https://git.kernel.org/netdev/net/c/9642ce6cb51e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


