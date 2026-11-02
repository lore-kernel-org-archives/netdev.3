Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628608;
	b=3nhi8YQ2yZ+xttBYXOWozBuA2a33KqFX/IawFs0MEsKFKbH7xILdemc+4Z0kgjqFqKN7
	 6ty25pfgomKf690d2cXJycE+loYDdM12WVc9VCUSbX+0dO0Kws5XWW0XOEzU48WQ5FB9C
	 wfX5mjvOb+1lmPoAq0Tl3O1CqiH6ua8p1RfBLYUiHrY5JIKvAEMUA6k1fWMG4KPuPCpxf
	 fhsHCT3wDdp0ib5FX1r6z9uDP2V7Jz7FZXGT9Fd+MsmTX3mCvH01C7KqaJNBLnY8OmAvV
	 1cX9jQBTQLUOI+hMJXVhY1jd4CfX+dzJvvuYtApsuAiK6CVwXFE09eEi3tityZHdaGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4OVeYWfheYH8FtbHuki+QzMAA47RZQV0phvaOV3yvhI=;
	b=WVje4gClui0RBxMRRONURKyf9uHuEqkLLahEx+gKrMCNNXoBhhBoCU2GfEFEdDU6/eyU
	 Db3rfU5SCC2QAAC54W0CfNhBifIpNTNjDsvlLNvN++UiKG/b5zomcovxc6B1qpNSSvlW7
	 uCrCgt8XvQyr9ksU9dhtTwGmKqrMkQsuNH8psk6l9vQiNAo2X1I6iemlfmPkfB5PRUHCk
	 9QMe0zsNRKPClDEzQMIhZqHrLCo9YqZNTZhSlrM0tzH2bzr91wJGQgH8zgBktoIzGj6qJ
	 u+3FV3pOmVsvCkV1TZJT18C3vt4zLcXPX63KPtS0xTlzbYEXCoVyX+D5b+hKWa0v32g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DA4eeWnk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF87606A331;
	Mon,  2 Nov 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DA4eeWnk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1068C1F00A16;
	Mon,  2 Nov 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628608;
	bh=4OVeYWfheYH8FtbHuki+QzMAA47RZQV0phvaOV3yvhI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DA4eeWnktH8h4sQSoUzbAAHoaSu4bcio9Mt1ehS+VHWLz/dhZfHOFhBKxXjcz78w3
	 VrBVDlm4s3G51BeT8mku/bHbIOH1Y273D9xA4RofaMam5uU7WJHSb7TX8ux34PTy0g
	 MprZETbm4SZPmcV86KowhogUiDpsa+++IAhVkqjEyCVlmsP9J/EuyTKxqRN0Fw/Tp2
	 7K8S38ajx53f+Z/qj2FKWmtnc1V53yCWNmxZ+Vxf486b1LzSUKMOFQ4yeT6QPcfhr2
	 Hs/1shuPvt9Rr9pSdjVvx9jJfW3d1RDY1zHmfCz9TvtGlrajMC13A1moYUyRHU7a5B
	 tx5MTtLxWvHlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 034CE380821F;
	Mon,  2 Nov 2026 14:10:08 +0000 (UTC)
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
Subject: Re: [PATCH net v4 0/3] sfc: fix PTP synchronization races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179362860680.4057752.1132714652152269394.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 14:10:06 +0000
References: <20261026123023.3566549-1-alex.austin@amd.com>
In-Reply-To: <20261026123023.3566549-1-alex.austin@amd.com>
To: Austin@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Alex (DCCG) <alex.austin@amd.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com, pieter.jansen-van-vuuren@amd.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Oct 2026 12:30:20 +0000 you wrote:
> This series fixes PTP synchronization races found by code inspection, and
> a related frequency-adjustment bug found while reviewing the locking.
> 
> efx_ptp_start() resets the driver's cached current_adjfreq as though
> MC_CMD_PTP_OP_ENABLE also resets the NIC's frequency adjustment on the
> MC. It does not, so the next time-only adjustment reprograms the clock
> from a stale cache. Patch 1 removes this reset.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] sfc: ptp: drop the stale frequency reset in efx_ptp_start()
    https://git.kernel.org/netdev/net/c/21d4917cfc8b
  - [net,v4,2/3] sfc: ptp: serialize host and MC synchronization transactions
    https://git.kernel.org/netdev/net/c/f707347b33fe
  - [net,v4,3/3] sfc: ptp: avoid racing PPS timestamp updates
    https://git.kernel.org/netdev/net/c/23d23e6c6517

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


