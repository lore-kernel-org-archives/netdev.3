Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1613509EE0;
	Tue,  8 Sep 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911475; cv=none; b=A8zA2eSzWkl4m/hzwsrfS1F4MTXl0sTgXtch2deaQrqBXVMSTBpEODtky0QkowAAWQJNJicTwCYeDmCZVzcsoKAnxUZwP5Fw4BH1gQ0nGS2sJrRvBemOdVkaI/aKW+KA7u7qQwCCaQEQQ3kvquL2rlnV88YQLa59+Ld58lwSR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911475; c=relaxed/simple;
	bh=LZbBTr/ColV9nvtIPy87fq/UZmhJLJ64EyeI8XIQCBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b/kOIWEhUsuhb986QEK5MaqAnL5lK626sf10LDUM8H0QO9PA+OBvpBW9HSvDCpUYvtshR2hwggWjCf/N+QpOvqaSp7ly47Bi9i8Bj+uem0tzVv9Z6Wr7gys1gwDaCmav5dmvxCeyYD0gKRjJVolwUOcYl9GMvZKsdxIRMRT2Y/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mar9s6TQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mar9s6TQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728FD1F00A3A;
	Tue,  8 Sep 2026 23:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911473;
	bh=DJwkZNe/otg+nrKzz2bS7/TvrSraEkdheALPgNlqsK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mar9s6TQuVmcvBZ81+T3xP9S9SglcjjciYSMhudZvdBov38JSBoLHaiG/3Rt9vfJ+
	 0ompfQHJ466bN6AKPSjJFsfkr9tyFSX5OIzpyrUInOezwAp087+m2VA+VcKYWgYOSg
	 wyhHNty56IA/xCtjwq9G/i3jStLxlLGTeNPr2hnv0PXnKMAS/H4O++GLfHKIqVqQI0
	 v1bysB2MUmh/t2d2u2XJXLAWa6QfcI/46UyMiNiQEZqi7x5k503t6Ktdt7QrePrFax
	 dCIU/AqpnEnKIlci/xJqa6JvkIo7xqD7AmpqAi/j1RfDQJOb6AphSN5XL9TaLFxDOe
	 olmtOtUWBMmtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A8B380820D;
	Tue,  8 Sep 2026 23:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] net: Remove obsolete 32-bit DMA mask
 fallbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891141163.68202.10469960085602949246.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 23:50:11 +0000
References: <20260903084339.870562-1-zhouruizhe@resnics.com>
In-Reply-To: <20260903084339.870562-1-zhouruizhe@resnics.com>
To: =?utf-8?b?5ZGo552/5ZOyIDx6aG91cnVpemhlQHJlc25pY3MuY29tPg==?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sukhdeeps@marvell.com,
 chris.snook@gmail.com, florian.fainelli@broadcom.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, satishkh@cisco.com,
 shenjian15@huawei.com, shaojijie@huawei.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, tariqt@nvidia.com, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, idosch@nvidia.com, petrm@nvidia.com,
 alexanderduyck@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 16:43:25 +0800 you wrote:
> A lot of Ethernet drivers set a >32 bit DMA mask and retry with a
> 32-bit mask if the first call fails. This treats the return value of
> dma_set_mask_and_coherent() as an indication that the platform requires
> a narrower DMA width.
> 
> That is not a correct interpretation of dma_set_mask_and_coherent().
> The mask describes the DMA addresses the device can accept and constrains
> subsequent mappings to that range. A wider mask includes every address
> permitted by a 32-bit mask, including addresses from a platform that only
> produces 32-bit DMA addresses. Retrying with 32 bits therefore adds a stricter
> constraint and cannot correct a failure to establish the wider mask.
> The DMA API HOWTO explicitly calls this fallback pattern incorrect [1].
> See [2] and [3] for details.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net: atlantic: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/78113e4c4002
  - [net-next,02/14] net: alx: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/fc5a6ed4992c
  - [net-next,03/14] net: systemport: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/12a924aebcf5
  - [net-next,04/14] bnxt_en: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/f60b86ea8864
  - [net-next,05/14] enic: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/0b861b6ee2ec
  - [net-next,06/14] net: hns3: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/e7d0cff7773b
  - [net-next,07/14] fm10k: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/f7cf8452c58f
  - [net-next,08/14] net/mlx4: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/ee95313d1aef
  - [net-next,09/14] net/mlx5: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/7b85fba09ebe
  - [net-next,10/14] mlxsw: pci: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/68161cab4810
  - [net-next,11/14] eth: fbnic: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/453248082a5d
  - [net-next,12/14] net: pch_gbe: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/85996f110325
  - [net-next,13/14] net: renesas: rswitch: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/0a8bc1ad90ad
  - [net-next,14/14] net: niu: Remove obsolete 32-bit DMA mask fallback
    https://git.kernel.org/netdev/net-next/c/03011820f02f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


