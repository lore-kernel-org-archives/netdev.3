Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C75947EF;
	Thu, 17 Sep 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655473; cv=none; b=jPZJ0eWwQ7mR5R498ES2sPTzIcVLqm1JYr69G2HDrVnX2gw7wMmqx5VfIICifMEyJyojfFXHZn7EmGPNCB0J1R5uMqkblhr6t9LFRO/9ByItO/Pk5mYf7RxeEqT/FXbwkDK3qPjRt3aBXdz7E2HEC1Qcbv8wRLQvhuDz6FIQbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655473; c=relaxed/simple;
	bh=uEl4EECKGXhBp9GF2kkvwWzKjgeAIHxbVYK7tvBgEEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rVSkU5i3i/OjR9/clJQ1ntnjH6Po9WPtoeJMkcoOGUJ3Ep+hOB5/D7Pr00ufvuI1vJVBUs2+N/eAoohabwxxEktY3IAxJY+RW74zoOnT8hPKCe1d5357Gx58AiC4veWFVo/iXiYAoTl8b5GZBGNN+us5ZB+Uppr4kjri/v7ILPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaGmDRP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaGmDRP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38B1F00898;
	Thu, 17 Sep 2026 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655471;
	bh=KHa8g/o3ojjpCzhC1dcYtNo1S27K7jUNp+brVCmz6W4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kaGmDRP73EAovXlnIrU6yFrohP/3C41V3F1V5eOLlQ8PPQY88qQe954FUjgFwJs6g
	 BRBBoddxrQ42MyM3JBwLkoNgJHT8TLmvaYMl7shJ/NsY/vpn18sIUv2NJ0s0UK0g80
	 afv91FNBC8jobE7Tu07hUsZR/cEvYLJ1Io12qfFKl4XlK1rwDNBuVLqEvYAA/Pba/f
	 cD9gHSxKBSdcG2D/F3Sy4wqY88YvTFWla/36oiQyRcGfAysK0jH8AzRRgn5nWBiu4S
	 ZoBaD+dj4acH/DzgcoxrLI5UBQFeqlaqRv3jaTTUVaWVYvLUvQ5HpJg2rYKEJ8Gfgh
	 D3fdrlqV1CGNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A57381196A;
	Thu, 17 Sep 2026 14:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8] net: qualcomm: rmnet: require CAP_NET_ADMIN
 in
 the real device netns for config ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178965540489.3675117.1032576692809888118.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 14:30:04 +0000
References: <20260915195642.1912-1-suruurism@gmail.com>
In-Reply-To: <20260915195642.1912-1-suruurism@gmail.com>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 subash.a.kasiviswanathan@oss.qualcomm.com, sean.tranchetti@oss.qualcomm.com,
 horms@kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Sep 2026 22:56:42 +0300 you wrote:
> An rmnet device may be created with its real device in a different
> netns than the rmnet device itself (rmnet_newlink() resolves it in
> link_net), and the config paths below only check CAP_NET_ADMIN against
> dev_net(dev), while mutating rmnet port state attached to the real
> device:
> 
> - rmnet_changelink() rewrites the endpoint mux table and
>   port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
>   MTU of the rmnet endpoint netdevs.
> - rmnet_add_bridge() and rmnet_del_bridge(), reachable via
>   ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
>   port->rmnet_mode and port->bridge_ep on the real device's port; with
>   bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
>   forwards real-device ingress frames to it.
> - rmnet_set_coalesce() rewrites the port aggregation parameters via
>   ETHTOOL_SCOALESCE (ioctl) or ETHTOOL_MSG_COALESCE_SET (netlink),
>   whose capability checks likewise only cover dev's netns.
> 
> [...]

Here is the summary with links:
  - [net-next,v8] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
    https://git.kernel.org/netdev/net-next/c/26ee8cd69d46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


