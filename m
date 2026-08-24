Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1535F602;
	Mon, 24 Aug 2026 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598070; cv=none; b=OU40rT/xwoW092bmTiNYvD6Po854oVeNhkRA5I3C4oCFEPmrVvLgZC10JsFqo0d/NfxwHm5QPmZxpJVgTdiM4pH4eatTmfhLVq4bqy/gCBEV+7erKPHIATgD5xf1d/9CVCBqebZLoX8Mr4MVg5Q2bauaigGhMw0toqXkIN7/sR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598070; c=relaxed/simple;
	bh=kN3gYtcGX5EZyvcWjto/WRQprDWEn/YFnn04yBNSskM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bHYwTGL/C586SnMnHKehRvRRxUNc7NgxKZl98GGQcCkZN4keTF/SS7HisZpUC4tdocQtiiQaUPlKYpgUS8TZbRLubNQDDgYSOwb934byrdEEnQaEQ6XUsSYfeeL3X+brGkgqomDei7fwcEEr+4QqO7KUtrWpoHQ40IhmZO1JQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFJ/SW8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFJ/SW8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27FE1F000E9;
	Mon, 24 Aug 2026 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598068;
	bh=WlD8NSrX33+fqV6gSsGS3Os8oxiZYeoy8DsPYvW/d+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UFJ/SW8f+cVZvpo8o39oIIRBEvI+mEFABc7UAeepKRVJDXzhJOkEDxaSwXTqEb64o
	 l1sjzMsPcYUuAQN7enfFpAo53L5PJvqIAB7f8w4/2YBVJbeirfAKbIJ3AIjqpahBSK
	 EjcAXLSMMgl/cP6cNxT+dxVs0bEFCWwrDDbZHHZwIZQd6/plM9Y2Z/UCKf7ChDYpc0
	 vWRFfDE+XNcPfuaqqrzOLgWObICzHBsUsA7ObBAVx0RpQwr+htNvB50mMFcQLzy5Uz
	 dbaY4TvOz7KL6PB8aADDZD/zB+WJNdrS7ueoHM46vLIVwaPm1w8XEUcW6n04bB+ZzI
	 0ggAWOQGBnHiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0D3924A4C;
	Mon, 24 Aug 2026 19:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: enetc: restore RX ring congestion mode
 after
 ring reconfiguration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759801607.3065827.9285537541360975986.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 19:00:16 +0000
References: <20260821064140.1315611-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260821064140.1315611-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 14:41:38 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The RX BD ring congestion mode (CM) enables the ENETC MAC to generate
> PAUSE frames when ingress congestion occurs. It is configured only in
> the phylink .mac_link_up() callback, which is invoked when the link
> status changes.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: enetc: restore RX ring congestion mode after ring reconfiguration
    https://git.kernel.org/netdev/net/c/9e94d8e14ae4
  - [v2,net,2/2] net: enetc: restore RX ring congestion mode for ENETC v4
    https://git.kernel.org/netdev/net/c/fa1a8457b858

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


