Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87A36EABF;
	Wed, 11 Mar 2026 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196832; cv=none; b=qIeK517CKc+EV3D+ZwUed1htqSHApia/r0MeZxT5jE4UdlQgdHus67OHIt8GOwudEU8aKZ2ri73CVyXOaQW6kV8CkNOr/URelUXTEto59/aGRKy5JgHfdvs+8F2qHR4R8YYSE7rWZ0HLKSbEuFpLYmFB8sh0p4+jN8L31xvLAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196832; c=relaxed/simple;
	bh=5eStcQIKsavYd2mr+kLuqtIxtZKjXn9Rnm4KonKjYs0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k28qPBdFHxDAwdWh8MZHgyiMWkQv0wTzn1H2EFFpCzd/GyqLwZTjmVunqAfrPAKgPLBu3vjvOgUM4skqQGg8cSwvgrProlBUybViVRnArI+nPa63ltPikItvCtKn1RoNSiQ41OAju2Uq1ilGpbql3mOxsAG3uBB+sTa/xP7Cl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRho0y2r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRho0y2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2BDC19423;
	Wed, 11 Mar 2026 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196831;
	bh=5eStcQIKsavYd2mr+kLuqtIxtZKjXn9Rnm4KonKjYs0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bRho0y2r8sd4eU4s+7RzlduNeDCU1RBzH1U0in2lXv4uSPBuySwl5XNEeMJcSG/Fe
	 BH0vhknG2CORrx30jcLF+2kdIy2aCEpDirvUCcnouaS4T1wHoub1Xjx718YsHSC9/r
	 vVy/VVPcTq+9hrd6xLqyK9V9sUvkDoFZleeZh12hzx2g7ZdDq1TbBIXyN9P7lQSBlD
	 kdqdjmJzE8flLJdW4K42RcYePNrayDsp1r+IpGX9st56JPhaxMA4sO90Q3vLQNSPt+
	 JhBmoPhbZrAjQwXvPwXhNd1w3HyGrKbWYzYopqIVwlpEwXfL2N799hejCsOMUcMA3i
	 Q6wpdbcs+Ojjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF033808200;
	Wed, 11 Mar 2026 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: mvneta: support EPROBE_DEFER when reading
 MAC
 address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319682829.3014711.17648033774376846198.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:40:28 +0000
References: <20260307031709.640141-1-rosenp@gmail.com>
In-Reply-To: <20260307031709.640141-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 19:17:09 -0800 you wrote:
> If nvmem loads after the ethernet driver, mac address assignments will
> not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> case so we need to handle that to avoid eth_hw_addr_random.
> 
> Add extra goto section to just free stats as they are allocated right
> above.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] net: mvneta: support EPROBE_DEFER when reading MAC address
    https://git.kernel.org/netdev/net-next/c/73a864352570

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


