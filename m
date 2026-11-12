Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485408;
	b=ZYKWwfc/DUBugV5gSRjsk5qx+3OpAMcn9S7foaBZXpNUclZYAcrCwfshw2Kc+3l6V1pZ
	 Tiu+oqyK91/NBAvtEMDFLHYLQsEESXQBhnlnDf4AbWFRGEF128vbIPcXJRI2uo1rUHHfA
	 ZCgyB6s8Wwk/q8ZAPKG0F1RQpIK9zle1pB4K0bHm6v5XdOIGSlI/r1YpsVw6sDaX/RG5e
	 vrk/06x4HsPwmUgkYNVF5FXwgI1HGIGol3v5I7oyo9kbaWCVe/1xeBOv5G8cN6HQc2ng8
	 2VEx+Ctl814yixfE0TGKkAc4NsRrYNHTHrpCgBjMy4CBvJUltF3xdAHAMpe2T17M8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Z9YClPU8nxS2nyF2LwX5x1olqDPV6MDyb2r6g8NxxT4=;
	b=e3Oh1xwkwdiZoPKxQFb1CapDnagp055ZFyM97lNgToobQfOXT5bnM0PNr9wJQaiVd6ER
	 Ej6f71dT1rWEOjGuGSPRGTUHqh+XRdyKFJ28E64ddThpLlH710c4C9FSGpRLGghw6nxq3
	 J9d8RDf4REradk7bQ7wx7eFfIZyfJPmFes/43MmnBdehZ+IXpph/acClXeShNllylADuY
	 jIJ7qY64CnVirZhe7LWLU2xsHlo5CqW0XJd+kcFCSThOcktAA9Kvs+oRsQ0/3Wbyt3uNj
	 k2J3ypXbJc4pU8WcZIS7HzB/iBHmPZKAGrx/u4PUNiKdALca9qDyl2Sh18RsBKi+krA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNBs29ZF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB1606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNBs29ZF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A601B1F00A06;
	Thu, 12 Nov 2026 12:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794485407;
	bh=Z9YClPU8nxS2nyF2LwX5x1olqDPV6MDyb2r6g8NxxT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YNBs29ZFHsP8vlyISjbKvVIn2ReWCxFq5TSuO4Q7WdnZCYf+nYUz35pduP3Ljmf10
	 GC1W2pMJwIgYSuuazY7AL9MO0TTPYUvRFXvdDKTc6glWL4odzAkAD9n87D+8ENgXoM
	 zD4yak6vlH/1m8fQAHgfyLz9s+KHz02KezAxOvom/J1KVR3DP5MJs9zNlHDT+pQ7Ci
	 gXGjn269EsAogezB5jxbnJSayaBlCvATh+oPf3+OYpF4JhBjNq2mbECs0q3+gJiWo2
	 gpdAvbqHy+PJyBUPAdjlcbO+u5iysDH5RC2P7luaiaeV64bJ69lDY2DQsEd8vxgonS
	 ysFesI0h6yKNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B1053AA9F74;
	Thu, 12 Nov 2026 12:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 0/5] hv_netvsc: make XDP propagation act more
 like
 bonding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179448540643.2056781.13102948847115674069.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 12:10:06 +0000
References: <20261109194843.1353592-1-kuba@kernel.org>
In-Reply-To: <20261109194843.1353592-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 kameroncarr@linux.microsoft.com, ernis@linux.microsoft.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  9 Nov 2026 11:48:38 -0800 you wrote:
> Currently XDP programs propagated from uppers are invisible
> to safety checks. I'm trying to fix that, but AI reviewer
> threw up a bunch of complaints about hv_netvsc. See previous
> series here:
> 
> https://lore.kernel.org/20260928223648.2739371-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] hv_netvsc: fix the program refcount when the VF refuses XDP
    https://git.kernel.org/netdev/net-next/c/02ed947f31ac
  - [net-next,v2,2/5] hv_netvsc: hold the VF's instance lock when installing XDP on it
    https://git.kernel.org/netdev/net-next/c/e70c86451390
  - [net-next,v2,3/5] hv_netvsc: treat the VF's XDP program the way bonding treats a slave's
    https://git.kernel.org/netdev/net-next/c/96cc49682450
  - [net-next,v2,4/5] hv_netvsc: move a new VF to netvsc's netns from a work item
    (no matching commit)
  - [net-next,v2,5/5] hv_netvsc: let the core take XDP off a netvsc device that is going away
    https://git.kernel.org/netdev/net-next/c/dcc69fa24fdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


