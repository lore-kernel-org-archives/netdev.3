Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799339280D;
	Thu, 22 Jan 2026 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052621; cv=none; b=VJ4vQ6FS/l/O28sLOFhhVCiHjZSfl1bYqq/CsOIBRedM3ZqJe2cgxE8j5KsS+AK6fohOE1/wt50T3apXQAaEOCEPDt7mC9oDY+1nNnbGYdMwdSGw06ebCXxyuOz4jgogbB1uBpbC8ktfP2ipW25aanTS9oWqMSKeRRWQiFkm1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052621; c=relaxed/simple;
	bh=VE0iS3pWhp6so1Npva7qmx2mCLeL878OmKehB3Ye6Og=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hC+VKP8VHlQAWYJmgP6fecYHjOVzZwF3pWo+EgKqDLolM3Es+ECOpVCo0LSOCJt57LKbf9dxg8asgqC2BrYV5H5K8t4fWZ0d3msd+miRr9t4RJxH6Cf8vcBhq9Q3N47uzTePeX9taxuFwgFgYv7yMK1CcZXne5wEIdOvHB6Q420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZwgaI77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZwgaI77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C648BC116C6;
	Thu, 22 Jan 2026 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769052620;
	bh=VE0iS3pWhp6so1Npva7qmx2mCLeL878OmKehB3Ye6Og=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tZwgaI77P+JBPQJRfwCjgWjgBKL1AI5szg6OnUW3QdB5dzwq2oWIgA6ltGY6CufSV
	 6m/USVvfKGbvMAVtFD08gU6iQnuhn520D/ApINoaXr3iYsXJ4oOTBCSqja6U9UFN2e
	 6zjTDCZbraviVYC2j3CxpK83nDswupz+gMBTkAPLnQQwUw1JhHA3QI2ekeMJp87ToR
	 nNGEkTDTt5ZTddlQyuGcqkM2qQudFkAVTWDuuTsftEWILjXAuk73FDdXVf90mkOEIj
	 tsIeKWkeosMVPNHHJfEw6Lxod9h6i3xz0Bg6eN/fLgQZOMCb740VX+Iz1Y5obRkyzS
	 JGchDmWWPdvDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8E8B3808200;
	Thu, 22 Jan 2026 03:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] airoha: Add the capability to read
 firmware binary names from dts for Airoha NPU driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905261759.1542867.17011579181219560528.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 03:30:17 +0000
References: <20260120-airoha-npu-firmware-name-v4-0-88999628b4c1@kernel.org>
In-Reply-To: <20260120-airoha-npu-firmware-name-v4-0-88999628b4c1@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 andrew@lunn.ch, krzysztof.kozlowski@oss.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 11:17:16 +0100 you wrote:
> This patch is needed because NPU firmware binaries are board specific since
> they depend on the MediaTek WiFi chip used on the board (e.g. MT7996 or
> MT7992). This is a preliminary patch to enable MT76 NPU offloading if
> the Airoha SoC is equipped with MT7996 (Eagle) WiFi chipset.
> 
> ---
> Changes in v4:
> - Add missing MODULE_FIRMWARE definitions for EN7581_7996_FIRMWARE
>   binaries
> - Link to v3: https://lore.kernel.org/r/20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] dt-bindings: net: airoha: npu: Add firmware-name property
    https://git.kernel.org/netdev/net-next/c/03135a5a6ed3
  - [net-next,v4,2/2] net: airoha: npu: Add the capability to read firmware names from dts
    https://git.kernel.org/netdev/net-next/c/3847173525e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


