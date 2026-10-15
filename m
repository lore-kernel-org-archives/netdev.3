Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9D4D7D39;
	Thu, 15 Oct 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054216; cv=none; b=D70nxZrf0zVyIYRcnLtGu0LBxDeKj4OySqpFWMuvi6DRQlKiqTJ7gZwO896jWvhIsztlX/KZKUhJy9b/MYw1tNYjKMz74ejcSAkmOHPrq1pjaDnLjTjCLxR1yQ3v5iu1SVmG/LGR2ksYbxGPNsCvfTgKxSTLcT3OUuKT+yEMJyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054216; c=relaxed/simple;
	bh=8uV520q7PNg4uv+ZFNjVfSo9y+62RdXtpm9FG0owK6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f652CRaoHh1oo8H95jJ05qgEOT5t6aVhtmcGYJB5cn0kKHnqkzUE8zayK6iI2hbTFLxki2Pm3nxzOK83Si3C4alq5anSp89XOhw0if5RY8Dv5TWewCCPKbTFki1cbWx8LJBwSJf3pkHbfjsOhKUg80Dzz8Bz5V1iNFno86AizL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3AH3Kel; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3AH3Kel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830541F000C4;
	Thu, 15 Oct 2026 08:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792054207;
	bh=iQ5ecVPNy31vU8tc5VU+V4etDkTRdGoX/2WdYTpz/+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b3AH3KelbwRFgVeh4Vhsc+l01AwMf9zHvNYO7Q1KFKpz/lYDv3AepmfnVa7xD5k+m
	 8IMco0ZtY4kMDqeVaJHOJjxoDPii5e85+OsN55Qin5z1ytZ+NjKRCrV4F+ZuH2Pyit
	 NB2z+rv4Qz2M6hTh9t6jVbvv7RfHgsW+steohOT4P0KQxF/P4X/RdakSZcQvmJlr5M
	 KslpU8WeuO5Dq0L6YwxCJQbjqHqrmHq4Dbg0CbZHhywctjKe1e6Uqx5YncbBWQE9qG
	 P+qfQ6HwgTPtNUM9hfnhwPmCjYlJp7h57aHJmSBDCPIgXqnfTVCX32WN2CRqVvuUwc
	 D8afj4GJsWm0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774C9392E9EB;
	Thu, 15 Oct 2026 08:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10] net: Move setting of netops to fix crash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205420627.3286272.11847066903047422427.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 08:50:06 +0000
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
In-Reply-To: <20261008022656.3592191-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, afaerber@suse.de,
 mani@kernel.org, ciprian.regus@analog.com, andreas@gaisler.com,
 shenjian15@huawei.com, shaojijie@huawei.com, sebastian.hesselbarth@gmail.com,
 parthiban.veerasooran@microchip.com, danishanwar@ti.com,
 parvathi@couthit.com, rogerq@kernel.org, pmohan@couthit.com,
 runyu.xiao@seu.edu.cn, horms@kernel.org, jacob.e.keller@intel.com,
 sdf@fomichev.me, nb@tipi-net.de, maxime.chevallier@bootlin.com,
 linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Oct 2026 10:26:42 +0800 you wrote:
> Commit ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev()
> locking assertion") put a netdev_need_ops_lock() check on the
> phy_attach_direct() path, in phy_link_topo_add_phy(). With
> CONFIG_NET_SHAPER enabled netdev_need_ops_lock() reads
> dev->netdev_ops->net_shaper_ops, so any driver that connects a PHY
> before assigning ndev->netdev_ops now dies with a NULL pointer
> dereference at probe time. The breakage showed up in v7.3-rc1.
> 
> [...]

Here is the summary with links:
  - [net,01/10] net: hisilicon: hisi_femac: Move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/444889dfa27b
  - [net,02/10] net: hisilicon: hip04_eth: Move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/0d9342701f14
  - [net,03/10] net: ethernet: actions: Move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/c2c482431985
  - [net,04/10] net: ethernet: adi: Move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/ea1565cbf063
  - [net,05/10] net: mv643xx: move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/a3eef3d2cca0
  - [net,06/10] net: au1000: move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/beabbafdd0f6
  - [net,07/10] net: ethoc: move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/c9f8ce62a5fa
  - [net,08/10] net: ethernet: aeroflex: move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/d71483f0716e
  - [net,09/10] net: ti: icssm-prueth: Move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/955bb7cf680d
  - [net,10/10] microchip: lan865x: move setting of netops to fix crash
    https://git.kernel.org/netdev/net/c/2a3f6d2a9ac3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


