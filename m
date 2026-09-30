Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43649482A;
	Wed, 30 Sep 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810413; cv=none; b=CFCPJTifrr9OJF0bQUU8Df3b7O4sCnLOBiUnOfjCffs2uiCdEw1jWwgEZjSpL7D3jYrh6g2iOkBVa5PYEMx/PmJvFokWO0IM7TW5R9ufTvzFziz9tWiOjKweQLNQFqEAsKBnIRRgouaJKhuXFPkQAWoyIHY4HaN0eqeQo6ltFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810413; c=relaxed/simple;
	bh=7DadGKeMIxNk/iK7Ki7mOJQ167tzchC/nMK+p9ftgdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E24Hxqs6nMbJ7NLv3a58Ez5XSNaqicSn5nFgzSrLT9OOXbL0Eop8qXvkJ8bOSqxvNtOmCPXUpGo6RzgEgqzCYll1lu6m5WlSI3ntQUFvSbY1g/s70Pl3gQqlyGVUyGHP2+1Hej8da/AiswdaaHuOzIQ6sK1Wlrq8i6rCQpEk028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkEzbIqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkEzbIqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071011F000FF;
	Wed, 30 Sep 2026 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810407;
	bh=4DgZxlDzZ/OisfGA71vu7g2dsC1OBMa3nR+gsYol/NU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fkEzbIqFcbDoagTWp8AWr0jVC85j8olUHANZ703VvEDZGBGEQoXI7q/PwSlR5jTua
	 7AuuPeJ1nF4ebXpqfq4kA1jpVjTnCNtRnYbIlVEa7H9AwNlPGf3V4YdYMqVOvExX77
	 o+dLGH+a4/BD4ClDTk00tOJW97b1uRxD7Z/IU+AtvyZSDYJd+BJrdkv7wyjImb0sFa
	 eCWFea8XyyR+rxAV7ngWYnpbVHlliSeVPUdSJlQKIhUnEjYeDOIFZbZ7uBMR5Ctjfh
	 5Zm925J9BJNUuwbov2jEOzufh1aGY3xZqOgJwrbP1KEPa8kerhRC0H4dF/z60zmNSm
	 CL9401WqJE3mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F147C39EAF51;
	Wed, 30 Sep 2026 23:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5: make ports inherit the switch base mac
 address type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081040578.2169244.17245869964651407465.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 23:20:05 +0000
References: <20260928045012.30178-1-quentin@q-lab.dev>
In-Reply-To: <20260928045012.30178-1-quentin@q-lab.dev>
To: Quentin Freimanis <quentin@q-lab.dev>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, lars.povlsen@microchip.com,
 bjarni.jonasson@microchip.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Sep 2026 21:50:12 -0700 you wrote:
> When the switch uses a random base MAC address it does not mark each
> port's address as random:
> 
>   $ dmesg | grep "MAC addr"
>   sparx5-switch e00c0000.switch: MAC addr was not set, use random MAC
>   $ cat /sys/class/net/eth0/addr_assign_type
>   0
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5: make ports inherit the switch base mac address type
    https://git.kernel.org/netdev/net/c/5642b1648d5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


