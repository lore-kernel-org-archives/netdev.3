Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134418A92F;
	Wed, 10 Jun 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059222; cv=none; b=c4gwU7fNTjBumZqzQ9xBItsfZBFx+H5IA5de1ttrd7+1fY2BwvJSOmHoOFp5kpYoTEkcfNsjF0cCCxh3VtHCnAhCys1Hzh+jPtK0mitCjdHV9z6YEznel++mWrLjaIEWbLqI45h2QaNeNFTnmyq0hGukxq8LAQ+zDez0AKoSm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059222; c=relaxed/simple;
	bh=lIj8MK2N9N7srRtJLosWe/4cgLY8+xZkoOdBilgRNbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GwlnQJojx6OldWj+uG2ucfQbbnwgY2+PmS38Td6KyghN0/s3AVVTUB53ffIX4k3tCyv2eO32u64FAWcZsUoQtu3dmpS++GRGpEsGcm+xU6gcOEKhmGtR7EGiVt3qEVzQdIK4Cd3ofTCNmyQ6Ew9UlHWrizySthjVkNqtr4iou4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndG13QBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndG13QBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFD51F00893;
	Wed, 10 Jun 2026 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059221;
	bh=VUGlurW/KFurlvPVpYqfvt8cTRk0ttrU0x2vGArdzbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ndG13QBhJSbDVbJlpB6w0+7o3g1WItdwpIeQGu3iReJla7oDaBkoZ7zP71EYKFwhG
	 SWxaDRBMhZsOKT0noBl5GN0nzNLOPBTATsteecIS0i5O1i4iRVBBsZ3Q7ntoHo7J/c
	 qlqiY3/c0uhrdrLTQAfyXCbbyFJ2RzgZlnOZGjhnbKnDPVtIZ0sZTi959sbd4bppO7
	 hZxM0Q9L8UGrF1Dpt7nzb+qGWybTUUlYx46ds/zoBzluEdaPbBBo62uc0qVwW8i0cO
	 bc653VgFz+FbPsT7ZpuiMmTAeuRHBUnLh5N0wPCznvrgALUOrl48N8jkw+88FL1WTY
	 UjjUvYaEIbwcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BF3930A20;
	Wed, 10 Jun 2026 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v13 0/9] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105921939.2803230.4599444523749741721.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 02:40:19 +0000
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
In-Reply-To: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linusw@kernel.org, alsi@bang-olufsen.dk, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, namiltd@yahoo.com,
 abdulkader.alrezej@gmail.com, ynorov@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 06 Jun 2026 05:29:24 -0300 you wrote:
> This series introduces bridge offloading, FDB management, and VLAN support
> for the Realtek rtl8365mb DSA switch driver. The primary goal is to
> enable hardware frame forwarding between bridge ports, reducing CPU
> overhead and providing advanced features like VLAN and FDB isolation.
> 
> Some of these patches are based on original work by Alvin Šipraga,
> subsequently adapted and updated for the current net-next state.
> 
> [...]

Here is the summary with links:
  - [net-next,v13,1/9] net: dsa: realtek: rtl8365mb: use ERR_PTR
    https://git.kernel.org/netdev/net-next/c/a543687227d8
  - [net-next,v13,2/9] net: dsa: realtek: rtl8365mb: reject unsupported topologies
    https://git.kernel.org/netdev/net-next/c/36c572fd60d6
  - [net-next,v13,3/9] net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
    https://git.kernel.org/netdev/net-next/c/51a4a22301b0
  - [net-next,v13,4/9] net: dsa: realtek: rtl8365mb: prepare for multiple source files
    https://git.kernel.org/netdev/net-next/c/0e692c27fe84
  - [net-next,v13,5/9] net: dsa: realtek: rtl8365mb: add table lookup interface
    https://git.kernel.org/netdev/net-next/c/fbafdd3b224a
  - [net-next,v13,6/9] net: dsa: realtek: rtl8365mb: add VLAN support
    https://git.kernel.org/netdev/net-next/c/9da2c8672f77
  - [net-next,v13,7/9] net: dsa: realtek: rtl8365mb: add FDB support
    https://git.kernel.org/netdev/net-next/c/336e3e4a1ab3
  - [net-next,v13,8/9] net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
    https://git.kernel.org/netdev/net-next/c/183bd68b1fe1
  - [net-next,v13,9/9] net: dsa: realtek: rtl8365mb: add bridge port flags
    https://git.kernel.org/netdev/net-next/c/660a9e399ab0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


