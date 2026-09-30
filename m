Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD43612ED;
	Wed, 30 Sep 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734207; cv=none; b=CuAg77Oi27nAXguPyyEhVNcLdVP53ZHjWkw7uciOCnYQNR5heXwkZcKv3OvB+6sg6rEZQXsRMUFtVHMsBJLGvYoyUNhxk527pFpDnE8rtOqqVqrcT0PspPnRZPakQDDFmtp+UovqlXddtVV8LQKZqFwbHbMuJMWDdaczxHTD5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734207; c=relaxed/simple;
	bh=fSYgjVTvyzYvIfQP2CzMiOkP69W/LSNRq9Qgo8AWXmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DMXVVwXRsHORCYXPqHa7RDtJtac3dVJ8pnG55RiygSq5K/NS4sgiN9BsOl8a8mUf+dVtfKtmz3HTPePQzeHV1SnU1nQw1nlSTZXUHqB6RAg805TLTUwY8sTMTLihe4Vl3IbUD0ZMjQ/3RIXLnuDsps8tHJ04GJ/9+RtdTQMHn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHZJ/4Es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHZJ/4Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8236A1F000FF;
	Wed, 30 Sep 2026 02:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790734206;
	bh=k37ydz3gmrzOGd3xCFKZBYx6bSsaaaFykfYFvycKz5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UHZJ/4Es0FgGH5CjBeSjh7lcOfz0A+Kwzhy6ChbbeKSTdcoyQMDJWpIPhlTItEvPO
	 VnZO8XvUwlSQV3BflLNH2kpyhCbB/9Qeuy1qB1+JYOqU/4hpaB1gnmyBXeVxlpfzLb
	 jT/QiF1A4mh0g2E7QZxKriW8rBJRKdhCYpqfVggP1LXh/10gL7vnftR9KhB1XQUawx
	 mAq8sroiXgAZEYPYdrTAjrvaeVZ+BCWio9141smURObJ5tv4rXMw/VDz+UXIr/OR5N
	 uay8baqvr/8qVzqgf8oNFmQVNA24QzOKaT/+tPe8XeWU9y3SibAXR+515/RgmgrMTV
	 6VnIsNF2cd5yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775243924FEA;
	Wed, 30 Sep 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5: skip ptp deinit if init was skipped
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073420528.1211220.17018666609894661061.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 02:10:05 +0000
References: <20260928044542.29287-1-quentin@q-lab.dev>
In-Reply-To: <20260928044542.29287-1-quentin@q-lab.dev>
To: Quentin Freimanis <quentin@q-lab.dev>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Sep 2026 21:45:42 -0700 you wrote:
> sparx5_ptp_init() returns early on the base lan969x variants
> because they do not have the SPX5_FEATURE_PTP flag. It also returns early
> when no "ptp" interrupt is described. Unbinding the driver then causes a
> NULL pointer dereference when cleaning up uninitialized tx_skbs queues:
> 
>     Unable to handle kernel NULL pointer dereference at virtual address
>     0000000000000008
>     Call trace:
>     skb_queue_purge_reason+0x68/0x120 (P)
>     sparx5_ptp_deinit+0x64/0xc0
>     mchp_sparx5_remove+0x38/0x70
>     platform_remove+0x20/0x30
>     device_remove+0x4c/0x80
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5: skip ptp deinit if init was skipped
    https://git.kernel.org/netdev/net/c/0d2c49915bc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


