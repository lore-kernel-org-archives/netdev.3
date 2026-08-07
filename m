Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BDB3EEAF4;
	Fri,  7 Aug 2026 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146066; cv=none; b=V4yagB1FqngvyJbHGTz6Anv8+jgnqGU5kzqGRxEXB4AfPJYe1wRAOskiIqQhSGvQM3HeX+TuLNGZb3XAmEnUlQYlZbFoGqFNA6w6ebSnXNwFCNe6GgfT2ru7+ZpUOwdJs7rkrSkrDkNTT3DruYgRbD7qfE6NaET81CeympoOUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146066; c=relaxed/simple;
	bh=36KwH32cf1h6Z8Z9Y0OuV/Xlbl6SjqRaKMjRPQEbsuQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Py4MMQ/7oGYQmom5keffOv82+VkAt2SYfSbEZCmyqh/IQI+nnORV/Y+L63C04i7oB8GqIrBZthjAmfVmojcRzKnb7girMuMgP+eXwqmR8gYVYX7MTy1KKvGORWaUZdNKDUDvEdiv31pbbUotBaT35xG+yiKrzTzY4UATTcd3s8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmg4iT+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmg4iT+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C17A1F00A3A;
	Fri,  7 Aug 2026 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146065;
	bh=ulh1dPI3L1SxP7LLxw1EsSyfBt9XripzbpCsqcOXeMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pmg4iT+AYQgxC+7RQJv2MgAiU4ULsMuE+PTh0hwaZ1/W8hsQvBlSBOuCJGo7eIhJ3
	 Wsz4qV/1Zv9WAzFKYqN6txcEajHUzxTgPBoo2fsijn4LlAkB5DVUx4AKhE+Wz2py10
	 MNBrXfBecoLzmRv8p3p6+X9ATubwcMvhDPpPeMEmYQViJ+ETncRwV1HnqyyRglEHCt
	 ceQ4jNplX7Q/7WFnj9iFAKJGkphoa6qlA8DWDWZi8LoMgLomCao3GcafE6vCU5LIbH
	 QuSptlAcc5jTwsToPd0WujLWoPkr7UXibUXpgKJ4ZesprMBOUPEYLkjShnmAEk0BCL
	 7e8SeplYH8EOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD2380CEF9;
	Fri,  7 Aug 2026 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: mediatek: add EcoNet EN7528 PHY
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178614602338.2465504.18347820222618862870.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 23:40:23 +0000
References: <20260804103321.3331802-1-naseefkm@gmail.com>
In-Reply-To: <20260804103321.3331802-1-naseefkm@gmail.com>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
 angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 matthias.bgg@gmail.com, pabeni@redhat.com, dqfext@gmail.com,
 linux@armlinux.org.uk, SkyLake.Huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Aug 2026 14:33:21 +0400 you wrote:
> The EcoNet EN7528 MIPS SoC embeds four Gigabit Ethernet PHYs (PHY ID
> 0x03a29491) behind its built-in MT7530 switch. They use the same LED
> register layout as the other SoC PHYs handled by this driver, but their
> LED controller powers up with its external control disabled, so the LED
> pins stay dark regardless of what is programmed into the LED control
> registers.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: mediatek: add EcoNet EN7528 PHY support
    https://git.kernel.org/netdev/net-next/c/b6e2649fff15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


