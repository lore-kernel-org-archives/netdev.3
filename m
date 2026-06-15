Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0834887E;
	Mon, 15 Jun 2026 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566824; cv=none; b=Ka0ZqirOJ8AhgWOBw8tkwEj4cuTVFL/in1fYcvB+tY310f8yplCIu1Qb/em3Xvh5PBYnkmxy8ELZw0YJcqE60+fX0ICHfazz+eu9F7+hEijkzY58y5Zws1Ue9+IHvyZvtEHfxjkCSZpt1wrgHPu9u4wXK7Pn7z0KliPk6gslOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566824; c=relaxed/simple;
	bh=ZyOLMaLwJs6p6k/MNvaM2k6PKzaG9mXiPuBRfBfovk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XF4we298+du41tgdIwOxJAlOm4A+ZIAFepRPWFyGB1aeDqq6Xtf224MZPzhc+9Cbt4z0AOVAUM4hUgX5k3k6Oh5s001F5IXzD4bRohm/U5QkI4knlNx9PwKsx+h1x8MLtAlWTUEem2FQ5F4gCv+MtZOU9T7Z+/WQcBUmga60eFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkuZZPZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkuZZPZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4D71F000E9;
	Mon, 15 Jun 2026 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566823;
	bh=+1apkrB1jbaFhw7WCwrOwJDH1R+HLyNSgYxDojcEzTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QkuZZPZRfnL1Eptpvfskua2yScD3nyWGmdhfvWNs1MWDvy9FyHM4kjp7z0+mBephC
	 fMPeNTjIIDDPdxqsI6tDzTW+v9ziCpsg8RntwOqtTZzcb0gMW3TqAuH0517KZGMfti
	 FuRMsSc+HWCfsHuhrswN+DEbh03o2B5l3NU1a2+p7lic1FNWCaHK807IRIcZFzvzO5
	 sDWDLyGwN8904FQ7JfWPgf2D6vt+yvNMlvCGSJczUtvPdcQBYncU8HOZRlzyP5cyvE
	 MewLRBrhNEFYLDxgfgvmOvYx4ZI/vJySklKssl5vMJdqzYWAIfxnocJZEQCX/mYt8N
	 nqZEaN5mGB25Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939433839A08;
	Mon, 15 Jun 2026 23:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/4] MAC-PHY interrupt changed to level triggered
 interrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156681813.339383.7315045393443753551.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:40:18 +0000
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
In-Reply-To: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
To: Selvamani Rajagopal <selvamani.rajagopal@onsemi.com>
Cc: parthiban.veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pier.beruto@onsemi.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
 devicetree@vger.kernel.org, Parthiban.Veerasooran@microchip.com,
 Selvamani.Rajagopal@onsemi.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 14:55:37 -0700 you wrote:
> According to OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface
> specification, MAC-PHY interrupt is "active low, level triggered".
> The specification mentions about the conditions in which the IRQ
> is asserted and deasserted.
> 
> Bug is inadvertently introduced by treating the IRQ in the OA TC6
> framework driver and in dt-binding YAML file as edge triggered.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/4] net: ethernet: oa_tc6: Interrupt is active low, level triggered.
    https://git.kernel.org/netdev/net/c/b542d13fab0f
  - [net,v5,2/4] net: ethernet: oa_tc6: mdiobus->parent initialized with NULL
    https://git.kernel.org/netdev/net/c/a221d3f7e3f3
  - [net,v5,3/4] net: ethernet: oa_tc6: Remove FCS size in RX frame
    https://git.kernel.org/netdev/net/c/a5a1d11dd372
  - [net,v5,4/4] dt-bindings: net: updated interrupt type to be active low, level triggered
    https://git.kernel.org/netdev/net/c/31e56112e654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


