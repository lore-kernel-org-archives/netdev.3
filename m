Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C63EC2C7;
	Tue, 31 Mar 2026 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952424; cv=none; b=B513pI2iKySfdy+xJxh/GtBiWweSDeKoDoSNeTf8y+ag7JTWMnopKzNHNkWMDV07Wd7xeCMkwbjHlNLpp1GbzmYWSGOZfwYhx/30iDJzH+OuHuk7cd0JXntPbGsglDmpsG4S/45cpFXKqiokCLrwttI86mpcs8vMUIpf/ggdUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952424; c=relaxed/simple;
	bh=GL+c/lSOQxZG1kVN2DXUiFsjniVUu9ycy0pQ3qX7sEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H9O6lrbLzDzV/3WqvkTJ4NgliPRDgDyG4btbCJ9CcUbgW8lUZAN9YoDJPbnZBiaIw1qxMgQRJ+ekaRxF47wLaHh/qNYjhwyxeaYwcFsdO/Vz2gUcnUTWGgJnvXvore/8PdrBGhT8dVJmBUGlt7iEczFYL2n4go3EmAVTYh6Q7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGAL+k2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGAL+k2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51694C19423;
	Tue, 31 Mar 2026 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774952424;
	bh=GL+c/lSOQxZG1kVN2DXUiFsjniVUu9ycy0pQ3qX7sEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mGAL+k2zgnJsHTenMRQL8f+dBUDC4XKO11aDvCacu3izChojkn7G/mMKrzpATZnM9
	 qPi4GnAFXVgVM2QKXOjGvqcgU8jj5v6Qlok7ptwmnQKI1vrtuGmKMm1DkbL5ZFRwtp
	 3VFJFe+kzZdtjQ2msFF/k6porUHDUJqooGAiSLZjEJv7ULw60YQKrttqdulLPvTm7b
	 qiN+7V/6LHv2tiJ39MQQhGDSu+bbOoLov2ZeVG01Y0DLichoSiownkSKsMv16P18qR
	 WEbEtE9CnLXaQjOFbzqs7xY+4ocS4boOOYOjiX2iWyigwDbD2X7orCVcVBEzLUJzpS
	 RwCZkKncbCCDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF3A392FF5A;
	Tue, 31 Mar 2026 10:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 0/2] Correct BD length masks and BQL accounting for
 multi-BD TX packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177495240804.2222159.14302586518463810554.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 10:20:08 +0000
References: <20260327073238.134948-1-suraj.gupta2@amd.com>
In-Reply-To: <20260327073238.134948-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, sean.anderson@linux.dev, daniel@iogearbox.net,
 ariane.keller@tik.ee.ethz.ch, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Mar 2026 13:02:36 +0530 you wrote:
> This patch series fixes two issues in the Xilinx AXI Ethernet driver:
>  1. Corrects the BD length masks to match the AXIDMA IP spec.
>  2. Fixes BQL accounting for multi-BD TX packets.
> 
> ---
> Changes in V2:
> - Define BD length masks with GENMASK(25, 0) per PG021.
> - Credit BQL using skb->len on packet completion instead of summing
>   per-BD actual lengths from descriptor status.
> 
> [...]

Here is the summary with links:
  - [net,V2,1/2] net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec
    https://git.kernel.org/netdev/net/c/393e0b4f178e
  - [net,V2,2/2] net: xilinx: axienet: Fix BQL accounting for multi-BD TX packets
    https://git.kernel.org/netdev/net/c/d1978d03e867

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


