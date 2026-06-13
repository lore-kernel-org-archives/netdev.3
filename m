Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897713D891;
	Sat, 13 Jun 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373010; cv=none; b=TH3neXnekK+PX/wqExdro1YBgTeBjRr9iocDPKZ2Dr6WqdcXvrxoKTfTQ0zGK/ofJQG6vB95ibiHdsjtDw0vE8/CQsU1X7dBD9NBZy13SzQ9T7dBz5kQ33rUFW79L4Sdgg2itgBY3JnyqZ024Z/KBscfUT5+rVtnH7gJOKtwLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373010; c=relaxed/simple;
	bh=BtvfR3DbGdHisefM4lH9IR40L7buuRm1UvuBzGnxNZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hrtkH8/jYk8RfBZEzlE8rmiQ9jffk/A1dqA1HzwRlxeLZtAZN5kRgyWcZLu1PtF7kRbItExT/Q12nDcqGu8W1gb5K2S1pJrJhT6/SbyYebJSM/QtmOUUVvDcWSO1lxhr2GdLcwJyqAopaXknK8YJUdyATf4eUdbtKMymhQOiBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwnTkOWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwnTkOWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642521F000E9;
	Sat, 13 Jun 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781373009;
	bh=EXdXTzkLAaFiG05TlUnjmzkDsg/Mt4NakHNRItwhcDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bwnTkOWtdaEOhcrhv00UWUNPuvirGVzdEPnnzecR/HBUE61pKdRich2wyQHkKswmY
	 bGjZgRhwSLbCsOfWkuu3gwmNm65GktGqjw4SOelg0vjBD+fUMeo78eyk2YhWCwSFao
	 rL/KWVrTRpFLAP9r1WF93hKbglav1o+uWcSw/O8BvM5299nT4wXWUrFAkKFLH7AxnP
	 5dW44ECW9X1IMjTd8oq1CxXXD2dh4EDQ5ka52J0bWZo7UCLkKYF+uRkrvTWmNlf3vd
	 KZIVy2gFP2Q8BeflISYmYLfcdb5ss4ZxFhTLQnRcb1+90IE1iA94UEnD+2laSHI7Yc
	 6jO6LMylWWtzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5F3A40FD9;
	Sat, 13 Jun 2026 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: wwan: t7xx: check skb_clone in control TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178137300571.1548981.6167640520032704806.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 17:50:05 +0000
References: <20260612035613.1192486-1-ruoyuw560@gmail.com>
In-Reply-To: <20260612035613.1192486-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 11:56:13 +0800 you wrote:
> t7xx_port_ctrl_tx() clones each skb fragment before passing it to the
> port transmit path. The clone is used immediately to set cloned->len, so
> an skb_clone() failure results in a NULL pointer dereference.
> 
> Check the clone before using it. If previous fragments were already
> queued, preserve the driver's existing partial-write behavior by
> returning the number of bytes submitted so far.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: wwan: t7xx: check skb_clone in control TX
    https://git.kernel.org/netdev/net/c/05f789fa90d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


