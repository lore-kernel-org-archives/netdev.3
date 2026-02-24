Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602703A0B07;
	Tue, 24 Feb 2026 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942800; cv=none; b=fIA3QiHMVCNhEsB46LpAmO87PGEr4P3qxF9K2UBzyn3bpIqzayeYDDpa20jnsaiHpUBdLk390PAoQE4ribytrUbYUUYWtx/BgNwGN9jC3M+e2hw5GZXmQsloxtle57xhSzRXQiV9uKFHRuelS1a2n7ttALSuoMx1Uzgkyl70XbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942800; c=relaxed/simple;
	bh=XZtNo4Q9LYp0y3SJlFFRrpBuNdLrAJVTIpwEGm8yIPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rFb8+4QxPnLmJd0kQGOZKvULkJvo6ntmdGkjKONAVILwY2T4QlyrJX2BZLomwFDAjhB+0eKrQ9tcJyUatXWId1DNcVljyE8vLvXqRbO5PPRPptpWrEk5U7deCgXQhGr7SmlYRnIPah02KC8b9Yl0/lTCcJm2RmEXS337gpiXIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWeCEdjw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWeCEdjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A4FC116D0;
	Tue, 24 Feb 2026 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771942799;
	bh=XZtNo4Q9LYp0y3SJlFFRrpBuNdLrAJVTIpwEGm8yIPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iWeCEdjwQjN/SyUhGsYIVuAdPgxD5y7TsK04i5Y4i7c6OnRzd7QJDLjnnLYI4rQP9
	 /HPSWUf+oJ+BrjVycFQfMbmqD4pVMTHXM/8BQJ8itghtwG+sTidIpHvS9q8WnSbL82
	 v7p+7prsuigBa6/xgIFBQn65AJBqNayFQKShnzroi9+USezjOy2ibGOQXke3piUSKf
	 EWQA2+TRaa4G79mhJitg/8Z8p+vI0u2+IAGgEUlhW8imYcDb8lVfVT8ZzUMnf6QeC5
	 2Sgw7htcG1GDB1P8qEMjTVabqyfPSbG51P1w2PoBgdajJnxHEcrUgC5Myu56I/dyYx
	 d61c+NUHY/9vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFB3808200;
	Tue, 24 Feb 2026 14:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: microchip: lan743x: add ethtool nway_reset
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177194280555.3589996.14149423047817447038.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 14:20:05 +0000
References: <20260223085442.42852-1-nb@tipi-net.de>
In-Reply-To: <20260223085442.42852-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 09:54:42 +0100 you wrote:
> Wire phylink_ethtool_nway_reset() as the .nway_reset ethtool operation,
> allowing userspace to restart PHY autonegotiation via 'ethtool -r'.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> Reviewed-by: Russel King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/microchip/lan743x_ethtool.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Here is the summary with links:
  - [net-next] net: microchip: lan743x: add ethtool nway_reset support
    https://git.kernel.org/netdev/net-next/c/8636385b9f01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


