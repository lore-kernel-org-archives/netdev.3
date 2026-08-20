Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649223BE644;
	Thu, 20 Aug 2026 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254291; cv=none; b=BqHs4saAjKIjasOl6F/VD7guh7EnqjO4YrCah81Ub1fLNyM8CdMpcNrS0KE9WAimDZ12YRL2L8JQCYsbEKudM3/GxUn7tgvq29jfIVqsEZlHu0cNXqSr4O86tpaTAyJAIxPDLNzpqwMeGwjan3r3w28qyCmdmtoJTufbB4fuzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254291; c=relaxed/simple;
	bh=9jkwQl3i32HJ4KnV04V52xW0b1Vpq+kgOnU3sfODbx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j4XLTG/7etWYOgX4/5Fo00hVkSmfxUrF15k6zzXXBfyE0cWQ7owfCzG8yiegwIQlK7iH6F9VZkFAxKZU7PS7HVNVINZ09O0/Yag8lOpQmcffu6NpldeKFrf8q+5it2hHzWIvvlv4R84/ELlxbRqGerFeE5j82k14JxAaW4mRIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRDKa1qs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRDKa1qs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FED1F00A3A;
	Thu, 20 Aug 2026 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254285;
	bh=ZLhXfnX/l9WPUe0VTKcKtenacPwnOuj7cH8YQl2JyOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gRDKa1qsctEljbYM1m965SPhP2MQd6Ux+KXP5Sqo1YmHwMyt5unzqD0LAlntBCdBR
	 nR/axXcUMw/HbT8UHrbdmXThtXfkwO6C1KQsQmR7Y6VJaxHZ40pfnVhZYb9uOKeAXZ
	 ++iiKGBV66NvuzoDOEvpgCY6fN61PtCyTDwgXnbX/BcdDCUvY+1KsMArJ6Ek4D7VM6
	 AAFHYzH0sarRSKkJ9/9vFMCdZLd+HMkp2YeVBmA33QTiifPoJUm27qmrlg2cs11m4N
	 4rmI7oqE9tmOHydfSS9zOurLN0b0BbyBg3osei7q5+F805kYG6WT+qWOPzJqhvUaRl
	 4OMjDgH3PftlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A063924459;
	Thu, 20 Aug 2026 19:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: thunderbolt: Count delivered packets in
 rx_packets and rx_bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725423513.446762.1505425827203047692.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:35 +0000
References: <20260815-tbnet-rx-stats-v1-1-8da375c2cd09@gmail.com>
In-Reply-To: <20260815-tbnet-rx-stats-v1-1-8da375c2cd09@gmail.com>
To: Fan Ye <fy15309206903@gmail.com>
Cc: westeri@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 YehezkelShB@gmail.com, andriy.shevchenko@linux.intel.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 10:21:52 +0000 you wrote:
> From: Fan Ye <fy15309206903@gmail.com>
> 
> tbnet_poll() increments rx_packets once per received frame because that is
> the NAPI work unit, and then adds the same number to stats.rx_packets. An
> skb is handed to the stack only when the last frame of a packet arrives,
> so once the MTU exceeds TBNET_MAX_PAYLOAD_SIZE the statistic reports
> frames. tx_packets is bumped once per skb, so the two ends of a link
> disagree: at MTU 65330 the receiver reports 16 times the packets its
> sender sent.
> 
> [...]

Here is the summary with links:
  - [net] net: thunderbolt: Count delivered packets in rx_packets and rx_bytes
    https://git.kernel.org/netdev/net/c/c5ae83ee02c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


