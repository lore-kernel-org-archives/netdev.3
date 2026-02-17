Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3E32D7F3;
	Tue, 17 Feb 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326013; cv=none; b=FTYTfVAFdmmZKwQoFWvj7ECpEKSY1YzXD0CJJLZ4s+NwSWGu8xfIwn9Vs3mbzpOoXFQ0dj8iDZvgmBmNdmvRCtpd75ne5MDjRD6tsjPe5ZMgvSLAy/zoPx502r3VaNusBDf4vyVLhJ1kyslSJmfeAbeDyoKhqBJlQcnynciCyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326013; c=relaxed/simple;
	bh=EtUSxvpqqES11XXGrvIkxPTLX8QUY/JSJrLWU+jOhl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AQ0hBmWcd9cZIrsBuMXE7P7MxMtf3xld7UzzWp2+BL+c5l3JEH86YjKf/eI/JPAMjVyT9PvgoMaXEXwXeQYyppfCaxQffd7mNng6fed1/lfA+Vimozs+jW0X2lQRLENQeNFtAMGXCt9DPQq4uCNwSlAf77e1+FHFghfm7z3oGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P82GCK7V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P82GCK7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E13EC4CEF7;
	Tue, 17 Feb 2026 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326013;
	bh=EtUSxvpqqES11XXGrvIkxPTLX8QUY/JSJrLWU+jOhl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P82GCK7VDmYVXpjlvPCWYm6ov7GGx3jleZlP9MVBr/pYmJHVvs0vMZdrd0C8gcI2O
	 SCD5Nt/TFBzxdxrRIODtUuckKbvbu62U9SIzy0dCSVxPY8oy5JMWVsVJD4D9rkzu3J
	 rwKJ8LRbm+gGOYPu7hZB6CU/q1BXcTDXEOSH9vRo2OQzZUF0SCf0Cv6lnWnFyhTu62
	 wEssLXdENs6ymi+iDlai9AajYl1Agiur2VSQWmynBV5Wvw2h2YdT29DyI5H3HEKI+u
	 FVmTb/UcfKKqXiBefugyx+vgi6YWJVIbl4qaj1SGaOTwtjA9SynwqnvV1PeB3KTJSZ
	 i630ChWDaWXUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4808E380AAD0;
	Tue, 17 Feb 2026 11:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: catc: enable basic endpoint checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177132600483.21044.10447255090282222235.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 11:00:04 +0000
References: <20260212214154.3609844-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260212214154.3609844-1-n7l8m4@u.northwestern.edu>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Feb 2026 21:41:54 +0000 you wrote:
> catc_probe() fills three URBs with hardcoded endpoint pipes without
> verifying the endpoint descriptors:
> 
>   - usb_sndbulkpipe(usbdev, 1) and usb_rcvbulkpipe(usbdev, 1) for TX/RX
>   - usb_rcvintpipe(usbdev, 2) for interrupt status
> 
> A malformed USB device can present these endpoints with transfer types
> that differ from what the driver assumes.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: catc: enable basic endpoint checking
    https://git.kernel.org/netdev/net/c/9e7021d2aeae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


