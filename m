Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376206;
	b=ORVLGagThqVxg7ezMYAT8eCyAXzxeBwoFiob3ddzlon9Nt5F2CQc4OUKQVhWaUpBY2AM
	 +XA+DmTb5Ldat0trYQkewNf2JFdetFHaLichA82ckxydu6Fp+kQQJYXvBG8eZUvTlFwI3
	 YtdB11eak1cSciy77t6V0diFLY2vm9Yyl94oDPDLBgTs8U/xHjDJpNuCjOXIVVknFRBlo
	 mwvvKrW93ZXz60ixfeDkD4X96ixdYsCmd7UL0q2lwRtb26iU4HpxiKSvDrpxijnwGOK4/
	 g8jUzrAtGfVVhmmy2Mgz/DPPeRnuEj97mIgJKG3Proo+kpWYvc8qzc0YkuzM/rRkBiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ihQ7RalclwTtyciHdqTPG3ExDqIcbkjL04B6leMc4Zw=;
	b=ACWCqVI+/LV/PksxqMQH+CivwhWUpvC6uaoDnIeBLH4lTxXdOmZwUypLek8o20YwDR0a
	 Bp3GRA0r1i79BmYdDndeTqXRc8tctoVELVU2dKSFPd2uiiJxz56PT392s1dgdZg+iGfbD
	 hXDemvEEzYDNu3EPZzff/ePTKd9NrlufMxYnHx7DhwZrbC8S3KGE63oNA2tPcejJZ0JOv
	 rJTPx1vkpo+YsO6pZJoIZUpzwJA3BSUWUioSBJeaR940kiLKRwxcUwmrCHKXw8ss2frRl
	 MEhNOyT3GyRViX6hrTAiCddVAWUdFtRrJi98JC6qi66way9Xg06ykEHWuApIBFQrZUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PBBs//GV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6F606A31C;
	Wed, 11 Nov 2026 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBBs//GV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A3E1F00A05;
	Wed, 11 Nov 2026 05:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794376205;
	bh=ihQ7RalclwTtyciHdqTPG3ExDqIcbkjL04B6leMc4Zw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PBBs//GVyZhTdSN3o9w8KrUVIg567RZm2G8lZAwXRlxjTbr6vctYMO/7GR0K/cRHD
	 9ygxOBlxxF9eGhWso1G0e8N3BEsrTBECoO8yL6VRcWaN751CsaJIavZGXIGSajiXdz
	 IWJy7Lo55EkDWhCFAYUrsAwY7m8TjSEIqFRt+trowHUoSTtitt4ux4LbeWsXN/whX0
	 0Jcsow2dkGo4j2SF33j0kBiUFQZn6rT77F9Y3VtSCvoD3gTV3cDVb773PD77cYfloh
	 PX7yMZDIn/NsdHLxSjEmD3kr09rJXE5c94A9Y4K9LPeKiwgrWOz4oyO8HTJQDfq+A/
	 xGLsH0lsq0gWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81DE38007D4;
	Wed, 11 Nov 2026 05:50:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: dsa: hellcreek: fix device_node leak in
 hellcreek_led_setup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179437620468.720797.7079283265270004352.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 05:50:04 +0000
References: <1793954912000.3200.3087525628285919529@cmss.chinamobile.com>
In-Reply-To: <1793954912000.3200.3087525628285919529@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, kurt@linutronix.de, andrew@lunn.ch,
 olteanv@gmail.com, richardcochran@gmail.com, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 Pavel.Zhigulin@kaspersky.com, linux-kernel@vger.kernel.org, yana06070@163.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri, 06 Nov 2026 16:48:32 +0800 you wrote:
> hellcreek_led_setup() walks the two LED child nodes of the "leds" node
> with of_get_next_available_child(). The helper drops the reference on
> the child passed to it and takes one on the child it returns. After
> the second call the caller holds a reference on the second LED node.
> 
> That reference is never dropped. The out: label only releases the
> "leds" node itself. Boards with both LED child nodes leak one
> device_node reference per probe, on the registration failures as well
> as on the success path.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: hellcreek: fix device_node leak in hellcreek_led_setup()
    https://git.kernel.org/netdev/net-next/c/c4c470912125

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


