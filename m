Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5333207DF7;
	Wed, 27 May 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844207; cv=none; b=cHG48mrXULeiOaWBjZE7pugP1Ykm/az5G9XeV0O4b7NVFzJs+ICMfbWh6sIbexeuf+ELyphL8kOVIsxBcY7uW8F/9Q8HD78qex9ljPtiHNA7j6PmcmjdSFcMBgxtRzJEIUDZ1+MjNe4atR26eEcrA0zHLfZqPwerWQp0EV08cZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844207; c=relaxed/simple;
	bh=6AFLMnzMNqkNdMyS0BI6HKWC8cUWcF6B5j7CA9J5gxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qWG6iNK2ntHmdOwlL71QV+DPl1AcT2wZ6a31Fl3/RgodrRUYw+7FtQZYVX1rElGgrwTo887xI1FqrZbs4Mi5hI46dVuehPLkeK0QAQp098wQmzzX/hlpqEIfdKvi51GGxqZqhDgNFbQf6Opxtloia5S1aZ8DY87HiCamsAxOhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCcCIgZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCcCIgZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640A01F000E9;
	Wed, 27 May 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779844206;
	bh=7szisFQcjEmOnwzS4zMx5Ii/YMyBEoA8gjRBq3neaLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jCcCIgZ1vdGA5fFUzDZGOCM6FGZz8ZbtPYK3crM50NbADimOUF/2928IwYE26CpvB
	 S4qd1j5klGTBXBwk/bxI3VpecLgaFuiykT/WAtrmVcOjA4IxWQMbQzi+IF1cAifrJL
	 XciRUQpJoaThVETPZnPEt5YmpAN1WJZd+ZC5wM3aidGUY5ZIutStvlO7TPc4kREqxp
	 48quHhEX5/XZFE0WeQ2jAOGjZJT9HNO2aOlSO5h0btDEPEcDo3tJB1uRfxca0+nH+E
	 K1kaH8OdcqeaqxAiYGQOSBxRd/9hkpLVUIFKSuwO/jHqIdrgeC6Y1q3givW0OXPLg1
	 xRHEHhkjOW85g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E6380CEED;
	Wed, 27 May 2026 01:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: netc: fix unmet Kconfig dependencies
 for
 NET_DSA_NETC_SWITCH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984421189.4036929.10087209171562712797.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:10:11 +0000
References: <20260524070310.2429819-1-wei.fang@nxp.com>
In-Reply-To: <20260524070310.2429819-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 olteanv@gmail.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 24 May 2026 15:03:10 +0800 you wrote:
> NET_DSA_NETC_SWITCH selects NXP_NTMP, NXP_NETC_LIB and FSL_ENETC_MDIO,
> but these symbols depend on NET_VENDOR_FREESCALE which may not be
> enabled. This results in Kconfig warnings and linker errors like:
> 
>   undefined reference to `ntmp_bpt_update_entry'
>   undefined reference to `ntmp_fdbt_search_port_entry'
>   undefined reference to `ntmp_free_cbdr'
>   undefined reference to `enetc_hw_alloc'
>   ...
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: netc: fix unmet Kconfig dependencies for NET_DSA_NETC_SWITCH
    https://git.kernel.org/netdev/net-next/c/10006ad04b74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


