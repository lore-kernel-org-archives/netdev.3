Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454053F58E6;
	Tue,  7 Jul 2026 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423227; cv=none; b=nBgC0Suw75kgJsu0N1sjiE4cwojsQBx9KwK1XCek+7JKaeSMav85xWFaJzn5A4OceTuis/GTg5oV8q//X9HI74/a8C3PkS4ANlAQBqgKCYmlgsf4Q/i9+6jbcTvzRcFqS+WI4A6CVnXAb6gEVs0Dkw9DJhPxfOAUfwDaaCZoEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423227; c=relaxed/simple;
	bh=xcb/lYqIKXK1vUGxwYDaeE3NG/6v6Sfe2CEeH3RLIuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PlD574hZqdurK8j08rz/dqBDZRsNl3EgWQoQDSWSZabBZ8cDkHarNWoNHmK94o9nuf4BSlfTtspUaQJrBcNlOIkss8MeoiCWcpHg+Adsz83QmtmFbSfWziA8uXenX5lc/YpD7uza0OwbQyhRtwQOgcMh/1vaqm8WsH3kYMlMYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbxpbKjw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbxpbKjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3631F000E9;
	Tue,  7 Jul 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783423226;
	bh=HC1CiGl3Dfh6Ra3ZH1WZbs+vEPwTQRbaXlOvtAdG00E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jbxpbKjwm/4fYDVHIMVXGz86C+O6obKIKX17WRhr8yli0nqgSaZWqWQd/9mmadAmP
	 CiW2W8l392A215x9Cm7fsZBCTr15Qgm8MhWUxhOR3SUCyuxuacYBfQ9bp/6MljLHWa
	 EIBQI/sGCXf2lgYUs30T9gXkmZeXc3yYEiVGZKfyKcjpQTbgTdnvqj8Nhb3fqk1j7y
	 e3Zon3s8QHfgmYLlaPRTC+5b3WT/rIFN05i4b1PnN8YHxtoZVurckgn8vKU8fljqwJ
	 MOEPWFlM6Z7jU6sjJoH+mAyrtfUt3M4ZU7nONQHWlPRfHotgV4nvEDHwyP5BkS2sYX
	 U1++OQdjOjLIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691C3925479;
	Tue,  7 Jul 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: usb: lan78xx: disable VLAN filter in
 promiscuous mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178342320589.1506559.9026475494202161606.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 11:20:05 +0000
References: <20260701-lan78xx-vlan-promisc-v3-1-232266d32743@dissecto.com>
In-Reply-To: <20260701-lan78xx-vlan-promisc-v3-1-232266d32743@dissecto.com>
To: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Woojung.Huh@microchip.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 01 Jul 2026 16:47:23 +0200 you wrote:
> From: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
> 
> The hardware VLAN filter (RFE_CTL_VLAN_FILTER_) drops VLAN-tagged frames
> whose VID has not been registered via lan78xx_vlan_rx_add_vid(). It is
> left enabled in promiscuous mode, so packet capture (e.g. tcpdump or
> Wireshark) does not see tagged frames for unregistered VIDs.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: usb: lan78xx: disable VLAN filter in promiscuous mode
    https://git.kernel.org/netdev/net/c/60444706aa17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


