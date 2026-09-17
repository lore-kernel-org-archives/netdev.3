Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FA4AC149;
	Thu, 17 Sep 2026 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648281; cv=none; b=u1MoOR8sIZ7X1prZPo+9G1q2MQ2DaB6c+GMdEwSk1D7nvLhLWVEhkE6ynJ5Sgk34ci33D/5Byo7E+dFtwB9qtQnPBNCCNbDchU/ItIqWgsCVwQSofSlG4UWbNfH6gEWi+kO1fJduiJdMvrPS0hZy8YrKcAAZewKrIIjNKU3tSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648281; c=relaxed/simple;
	bh=hClSNZPUZ+ViywGQDhx6mtZcHconW3n4u2b4duYKQzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LoFyYnNvt0xaXgu1B4egEzGMRjVCL7JWNgN5V3CvIVAEq335QuqNladJk7qQLcd0v38WK+fnCvDHtLjePnURvfUGLSiA0knTg+H3fzIdHwQGvIod5bBtYSgZ8opwZ+EoQRc3z7bY6tk37Wa7v4hY3FkETDxsVRvx9zTWKCqMSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTX8+NsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTX8+NsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DF91F000FF;
	Thu, 17 Sep 2026 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789648270;
	bh=ggr44ucWpSkmZk37yK233tYlLvjAiQJWTzbamPXMmHM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UTX8+NsDeTc1Sh/cuHH+8Ev+dk7/xmSjlOQVuXl1zXakD+baQkDtVKt1bFGfpiFRI
	 FgBPKxHV96OigqciQyEwzu75I9fPJsJ7NB3nQdvA3SPlQuNSd730n80l9NlEJxSaL4
	 efTmxM/sWx6xN4tryvgDzCv0sBI/uziBUKWXY0FTD2R17YoIb7dXrpLBhmsRKrRrgo
	 BFEriQ9pXsONYTbYa3mBMIdzopsfuMNwU4urKqXUrhXAPuQszBXWC717+p/6/PS0L9
	 Pzrw+5mbtSNdKe4kozP15jfPbit74O9T2PaXJJ2Y3ZEMzjQXXJ2Oz5X+5w4TJVO1nr
	 2Lizzmq2rvIuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393138111DB;
	Thu, 17 Sep 2026 12:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: macb: fix ordering around PTP timestamp read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178964820443.3616626.14441776053855821867.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 12:30:04 +0000
References: <20260915045823.76100-1-jjc@jclark.com>
In-Reply-To: <20260915045823.76100-1-jjc@jclark.com>
To: James Clark <jjc@jclark.com>
Cc: theo.lebrun@bootlin.com, netdev@vger.kernel.org, richardcochran@gmail.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Sep 2026 11:58:17 +0700 you wrote:
> PTP_SYS_OFFSET_EXTENDED returns system timestamps that do not correctly
> bracket the PHC register read on MACB/GEM. On a Raspberry Pi 5, the
> returned interval can be as short as 37 ns, while an ordered register
> read takes approximately 1 us. This biases the midpoint used by phc2sys,
> causing CLOCK_REALTIME to run approximately 0.5 us ahead when synchronized
> to the PHC.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: macb: fix ordering around PTP timestamp read
    https://git.kernel.org/netdev/net/c/9ca4ba242591

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


