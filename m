Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E304EA393;
	Fri, 16 Oct 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164607; cv=none; b=S/71Odcyc6P/KRYvNLq4pIZfdlFJyZg4/fhD5A1i85U93YVC3bYqxubQaY8r5KazhAV+PZN5MCHvMoTutquBFtN2xdwuVE4AR6OaFYty+5Ojp/SyF5Pcnur6sKO9WnEmrCk6ClIyLR51po7XDml7n6xwzIng1MjW7a6reblrMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164607; c=relaxed/simple;
	bh=ArpbipCaqZqGtkNqE+OCSPlNeDGMsiRw4C8o5hddkAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RazdPcZOyIErwIMuDMdTp5QTEmEVr7iEt8yOKjNEfAnzaMHnPXfzV5GywdsK2i5mslLsVxKNcv30CcTZipLbMoXLpLDtBOiPAKRfeg3NrMG3j6stkBDLeBAoaf72dwWTgjfWnR8dZllqn3KpO1JSGe4NCxVgfn6rGMJsxK3+Q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApkKv1bw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApkKv1bw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F0E1F000C4;
	Fri, 16 Oct 2026 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164606;
	bh=bt+G37iloAm/j7Uw775f/Cfaqhuc2JjEQhbczp6Qwos=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ApkKv1bwIJkMc2a36TPyjBMbHW70NwVz+ekY0/bEqDTmENAKMdnFyByL9qqOAvLsZ
	 Oiilvst0VuHu1FN7t2me1tBuazi0cePMg18vhsLwjka+/j05QuKnRKYRHTl7U9Rpxp
	 qHGR2mN+0PKNAYVAzHCPqc58AHSI6ZNEboISeS38kGjgjaTt0eGuUC2a1MrqKgWMoV
	 PVtThSBA024GhI+/PXn2bUYhzcik8QwWNU5krx42NiJGQBVXYvZCKq7Tdx/4/N3rTO
	 Upq84HeZ/ohuFav4NM9jyJBuPYseJT53j7WyjWpfAbdNCs5baio9/yJtKtlDn6LwRv
	 p8Pp6C/jP6F7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7744D380A96A;
	Fri, 16 Oct 2026 15:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: qcom: at803x: Apply IPQ5018 analog
 settings
 at probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179216460528.820266.15057930452700501966.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 15:30:05 +0000
References: <20261002210408.730-1-yongzhao.derek@gmail.com>
In-Reply-To: <20261002210408.730-1-yongzhao.derek@gmail.com>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, george.moussalem@outlook.com,
 hzyitc@outlook.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 23:04:08 +0200 you wrote:
> ipq5018_probe() pulses the PHY reset, after which the IPQ5018 internal
> GE PHY starts autonegotiating with its reset-default analog settings.
> ipq5018_config_init() writes the analog settings only when the MAC
> attaches the PHY, usually when the interface is opened. On a board
> where the PHY connects to a QCA8337 PHY without a cable, 1000BASE-T
> does not come up in the meantime, SmartSpeed downshifts both PHYs, and
> only the IPQ5018 side restores its 1000BASE-T advertisement at attach,
> so the link stays down.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: qcom: at803x: Apply IPQ5018 analog settings at probe
    https://git.kernel.org/netdev/net-next/c/17baf30a0e64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


