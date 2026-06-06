Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA122652D;
	Sat,  6 Jun 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780710608; cv=none; b=g7trzpFzOyh7n8TUk+X8UTwM3JRXAal7kvdq6MZc9ijwD07NzwELB+lJyhBiONVbmBf7eBOVtOLEnTewfd7cSomNi6qaE423HjXUQAI02e/aJ80BN1Rx6UKVTpUWXC+XlNoe5okVDJF8jGrM46sgJqDPEVREcChf9fnlJNjgFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780710608; c=relaxed/simple;
	bh=O9S2efjexbrsI3lcMeEXaNF+N6raNkemNqobYH8v5Lw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WFL0L1QnOPqky67EKEX3xUUKr/Ibs7gKiooPOoRYWaf17BYwlbougJgophyq3Mp4vlkYpDQDv3gFMC0xnB58kmMVpR6p+90Up52xAWPAoTFuZiq57JongMV88oetgI/Nc1g9i/bPmiwVhkjLqRwVKUNsCDMDteScW7PiBB3JYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6ZYJeNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6ZYJeNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CAB1F00893;
	Sat,  6 Jun 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780710606;
	bh=YZd/rp8sGaNuCD+N45AkBnt6khotKVn1OdeI6oj4XCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g6ZYJeNsdvyPwRac2ef2TybDskjrkMBoL+Ikei4kXnrSeJK7elW28+6IAcCMRbEOw
	 a5FJYv1lEjVZItPOYlTDSgIO8dZn8cRtE5Tr4hFwxvnZUZ/9ZRP5mm3TDbbbOZZhBu
	 mHiYlDGijYTr5voc2LeQmO04x7tzfeaFdVQIAaXvArq2xqJIqm35ecRA6icjqqIuD1
	 UcSjBmmBVEVX8U67cLJJ4wwY36cb2p8oGnsYMtmkeXrmfPIXf7xG7AL7LPSZJUcrEm
	 1VtiN2AzbwSw0lJ2xLMsgmK63hJxRSFUwmgymWZ841MHJopV3cDuNibvbZrA/Z5vTF
	 WZqE3yKWS/q6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197C73930A9C;
	Sat,  6 Jun 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2,net] net: ena: PHC: Add missing barrier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071060665.3989414.8411045312934190903.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:50:06 +0000
References: <20260604080706.19366-1-akiyano@amazon.com>
In-Reply-To: <20260604080706.19366-1-akiyano@amazon.com>
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, dwmw@amazon.com, zorik@amazon.com,
 matua@amazon.com, saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com,
 nafea@amazon.com, evgenys@amazon.com, netanel@amazon.com,
 alisaidi@amazon.com, benh@amazon.com, ndagan@amazon.com, darinzon@amazon.com,
 evostrov@amazon.com, ofirt@amazon.com, amitbern@amazon.com,
 andrew+netdev@lunn.ch, saeed.bishara.os@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Jun 2026 08:07:04 +0000 you wrote:
> Add dma_rmb() barrier after req_id completion check in
> ena_com_phc_get_timestamp(). On weakly-ordered architectures,
> payload fields may be read before req_id is observed as updated.
> 
> Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
> Closes: https://sashiko.dev/#/patchset/20260430032507.11586-1-akiyano%40amazon.com
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: ena: PHC: Add missing barrier
    https://git.kernel.org/netdev/net/c/954981dbbfbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


