Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8234389F;
	Thu,  8 Oct 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485415; cv=none; b=CAn8Y4OirvBJtIJgmnSz3e2T48+1NLT6FHfivmuRiYEUQHb9OOHNzU6eRmMraac1MJ/or9+uPFPDSZ/1s/4zDBmmFYwXYAURMReicwspbRFp/K5N13oWzo9jXGRs4PPA+87kSrSEtOIfwtaqmlAbK/HU8t4aNnZNz3aqVP8Zpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485415; c=relaxed/simple;
	bh=5pfvzFO/Fi0mmTPQ1blRdVg4J5LACr+hhCgwJTNY8RI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s/Ccp3J77aDUjY5d7Ilj3L9BM0PLMOg+sZsT/K6B3IreBc6cbEv2EW6mbCUEssQDFKhueuWENE1PKS81t5UAdeExmYUQlBySQz78POKfNz9nH1xU+S/3BtJKYO0jeSj3zOYm/zhXBlrmmEDEPBJr0zn8A/3LV/WVyTX5dpJ1iqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyhfeZez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyhfeZez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0837D1F000FF;
	Thu,  8 Oct 2026 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791485413;
	bh=5GwZ2Y35+w8NOWA7NSPq6sL5WvDJSFiy4R1e3fLPzEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kyhfeZezy9ojs8Yrp5slxHRLsvfq5OVkB+q7hUzq9x7vPzYwxBA13cwBlb+UFHEuZ
	 cx4JqgJmo1zGz/HM1ra8dkXGt6U3a+q6JGiSZP/gcutV5WEmDqbbBRt7qnhaxtuOFE
	 HtZB2GAn2UKqi27g9AtNobc+zUtWm0xSmMsqEalV8xEPklU/GIIfUPhfT/oVc/8ymr
	 J1uceFxJoQRLAM1n2K2YXQDs0L0yfaVcSpbygKpz1C9b0WXOlP+vry2ASXcjgkKSgX
	 LDiFeNaLv5pDRrOVg06+xPXCcBr/21vuOeOgsCICJBqnIf+C+lS1xQgrxOwqrK+e5I
	 nXTcLp6d79npw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1461380CEC8;
	Thu,  8 Oct 2026 18:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: macb: fix software FCS handling of shared
 and
 requeued skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148541151.391001.6091516917596389045.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:50:11 +0000
References: <20261006-nb-macb-shared-skb-net-v1-0-a80641479041@tipi-net.de>
In-Reply-To: <20261006-nb-macb-shared-skb-net-v1-0-a80641479041@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 Oct 2026 07:41:31 +0200 you wrote:
> While testing the genet MTU series I used a Raspberry Pi CM5 (RP1 GEM)
> as pktgen source for the CM4. With clone_skb the CM5 rebooted after a
> few seconds. Further investigation showed that macb_pad_and_fcs()
> appends the FCS in place, so the shared skb grows with every transmit
> until BQL completes more than was queued and dql_completed() hits its
> BUG_ON.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: macb: check TX ring before modifying skb
    https://git.kernel.org/netdev/net/c/6b48ed85ae0c
  - [net,2/2] net: macb: copy shared skbs before appending the FCS
    https://git.kernel.org/netdev/net/c/9151d6c42799

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


