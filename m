Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111409;
	b=LvG4JVGV98eccPhaunKtjIETA5U223Htm9NzlKEUR8t1A/FgPeVaB+7EDFZmV1ippsO4
	 Hi1IN4ghekrH9GUM8afv5dEyt/ApqZJQ1k9T8uuLLTPYfeqv787wBAFaEjrw/Vee0cWlz
	 c1ZRDzkcoR5hkCKtIPLECool+ZB1soB2aTVae+j3PcssriCLtbtJNOvXymSOiN+dzUML4
	 vlthy9RWA+ZbDml6rWAbWIFyoQh7NXjIiEN586eLhlshO9CYkFwvMv2Y7Wbwl1OOgblG/
	 d7bOB1ehHc+UjErHxxE6VkX0Q606AmgwGoyCBUNl5+4ISBHk9zPfGuboTcHDxlB68/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kYgo0vXw1mXNGTCPxn9U6dd5qYtZxrvBfUqi/NIIW+c=;
	b=DTV43jRw1CCDHQMyUyxmnmvd/FYGwh/HFlErmxHMtgB9hvRZM4TKSkOclTzbXhlsLhsN
	 LI8vZigZuM36wqsqKBP1Wl54XLgApt/bhkN6P56EQkOFMtAsJduSrthGgW3ssJ3CDvMXp
	 UAnjEmVm6foNpVaqnwEUl0+m3FGkEYT/4Pc/rPfEMPR36JKvRRv9UeB95pUFaDPGgzLGW
	 BwX7O2Ee9pDNBO51ib5+7b+CgGG+SENvTkydB1noQBSD2ei8SR17SGJxx8qgE9+vLNljx
	 LJOe+dc87zihfXVwXCY4a6NO+T/YM94H8RQuvyXPIymCrcrf6JzXp3gI2CbImr5v+dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsUJ0M1x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF352606A31B;
	Tue, 27 Oct 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsUJ0M1x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5841F01825;
	Tue, 27 Oct 2026 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111408;
	bh=kYgo0vXw1mXNGTCPxn9U6dd5qYtZxrvBfUqi/NIIW+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dsUJ0M1xwV+i6rPVExbv8Tl115bID9mKOcprqS03XxmXpYqRfbr0xB1vWHxrrfPr4
	 ZnqwxACWMjx2xG429kIgyUGwbmMORBz7AoHx1Iiv+Uq4axGzmgoOAmTjOho63OEQfF
	 b/i/+MooRokBexdkQh3oiObxJcikgIJH2Od60A4BpotJgmtdjp5w8DMj9nn0P0Uuqn
	 DEzQMCA12qOpHEhHBxcDdiENBHm05eIP4ZvezbToR1SrafaEevNfACeqraai4LDUTM
	 oEdf9tpijQsfls3JFJc3TJk+mCLK9I4cKBmDJge5YrS7Jt6n5xNJgaLjBRZ3mEMsmJ
	 bzhilDae5B6Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 443F03AA942E;
	Tue, 27 Oct 2026 14:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net] net: lan966x: do not inject uninitialised bytes past
 skb->len
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179311140682.3859410.2714856393147356866.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 14:30:06 +0000
References: 
 <20261026-lan966x-inject-tail-bytes-v1-1-51d599a48313@microchip.com>
In-Reply-To: 
 <20261026-lan966x-inject-tail-bytes-v1-1-51d599a48313@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Oct 2026 14:46:15 +0100 you wrote:
> lan966x_port_ifh_xmit() writes the frame to the injection FIFO one
> 32-bit word at a time, and pads frames shorter than 60 bytes with zero
> words.
> 
> Before this patch, the last word is loaded whole even when skb->len is
> not a multiple of four, so 1 to 3 bytes past the end of the frame are
> read. For a frame shorter than 60 bytes those bytes are also
> transmitted, as VLD_BYTES marks the whole last word valid and the
> padding starts at the next word.
> 
> [...]

Here is the summary with links:
  - [net] net: lan966x: do not inject uninitialised bytes past skb->len
    https://git.kernel.org/netdev/net/c/b4a7180558eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


