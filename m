Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440930C342
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485220; cv=none; b=Jx4DhLLYKPcWZAbnSPhme6WA6nprDLsESRQYjwTKFS78m/xEYpUX4M+5UX6qIJHCiIu/7bFTcF4Z8AbkRcZd0lBL8ms+WHTElbXlDtrhPKAPWGV+tKIUYMpWyWSiVsLwQ6/FMWdpF53ZaXuZ7GOiYKn7HSI9ubQyp2Wpn0/q+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485220; c=relaxed/simple;
	bh=x5H7S59WTuosqUQraUo7X/tWCaBw3GKjDYYIpkDo1uE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C5DZoV1HnwVYurxkVMCgrFcJkJYqGiT9Srj2/EOq6ijbtCHpbbv9+CTP3fgO4hPcMRZ5d/SliC2AK3URpcv7lqLxCwFIUCmu4tkorUElGtRfh3Q14GNjy28PzkSMWZtX2dqFpeqt20UDZt38ryIJt2OiNddfmZ72BS881L8+RlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT0yKqXL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT0yKqXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D56C116C6;
	Tue, 27 Jan 2026 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485219;
	bh=x5H7S59WTuosqUQraUo7X/tWCaBw3GKjDYYIpkDo1uE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fT0yKqXL0zovbOii25Gj/1Bl2CIgmzBpC6lLRey7mMp4zRYG2N+vLXy5TVnvP+LMA
	 brrnYNvY1qszbUIlCGIu9MNokxKOWFcLT7Vi/52tOsLG0t4z9CK3frzGnjFUKX1DR5
	 kx8KzykUGi6O7deFtiqBcfQTrO6kq4jW8xcYGvLMgR8R3vxnWWT/ku9uzOjEY/m/Jn
	 MrxRnW7qcejN/+y0Jko+GnsBE5qy8Y+X4m2C5ROWfNM6iUMX7CCTvFFiORfmeSS3WH
	 DLEydUe3ouh/swFnG81DLRAHFxjeCoQWDw0cMApmqnpPskHA3OOVft7ArsJ81StQ9t
	 4hrVu2FSy4hyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB49380A961;
	Tue, 27 Jan 2026 03:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove optional size argument in calls to
 strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948521384.672496.16665133212101741299.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:40:13 +0000
References: <d560ec66-848e-4290-818a-ce28f39de493@gmail.com>
In-Reply-To: <d560ec66-848e-4290-818a-ce28f39de493@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 22:30:15 +0100 you wrote:
> Minor simplification of the code by removing the optional size argument.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_firmware.c | 2 +-
>  drivers/net/ethernet/realtek/r8169_main.c     | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] r8169: remove optional size argument in calls to strscpy
    https://git.kernel.org/netdev/net-next/c/3ccf393cdd09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


