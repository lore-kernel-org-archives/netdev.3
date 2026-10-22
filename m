Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629013;
	b=RGSQrBZF4Be4wJEHDasP+dTXCaUdOMfX8xBSztlea1+ThA4xycKjfF+hRfhYj6CyWU96
	 dHMZ5sGXx7JRWwmgZUI9hMLfhdBp4AHTUSIuyE0rPe4FRB7eE04CR2zG3PWhyrhSCGCp2
	 Ljk2cRNDmfFlssCCng6+7TAlZ5F/nhLoZoqJO4edXGS7cU32KpHAh4ILNzzZEgI0vxyLV
	 qb84k/3UxQw6isaOaq0fHhJbw32k0Qu/fk0ntQaKTbNvSvOlIrJISX1zyWBPnudALM9sj
	 9ip3V6p9LzCEM/C7bc8o7BrPeu3oSxxFqxIDbuk5CFjIAWBiUB/A1DSaFfRXdh5eDOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629013;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uZkzK/XnREzEVV0ebXbgmbk4W62Yc9eFtRqf1FWlWqk=;
	b=BfM4t5ctNrP2n8xj6HVHCS7jSJLZXiArP3yB3Fq6ympcoO7ld1Pdz3+cyVHFEBSWXQQb
	 M9t9AgzYXeufrL0tQMxiCNwFuSwILPUGB6TSoUK2o8wiqnORZk43bJ4qtOYye+6kaI1uJ
	 D3KET/LEXySsLieDboZfp3ezlvFuQnd3sSvWz8HNkaY6rij7LP3hfIbK+FByPqllzhG+F
	 azMr8+Nb/9nYRqYmhRJDfqLG5v4tasdUQlOglnDSGDMJRpeGYjow7GBQqp2GS1Hs2bDek
	 8SYTcX9m1N30rBuHHyGC8pBy21P5FpR8ytypLg+6B3l4RSXw3dFeGJ9U6JaE/Lv9mRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j7/C49Wb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD54606A325;
	Thu, 22 Oct 2026 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7/C49Wb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0734A1F000C1;
	Thu, 22 Oct 2026 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629012;
	bh=uZkzK/XnREzEVV0ebXbgmbk4W62Yc9eFtRqf1FWlWqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j7/C49WbSMxxG0QijFQKufiYq0Q6dinOiGJm8MkKxqm6StnaJDt8TdIH6Rgcf+keq
	 JADCWI01KasEN91qaed5UQGW6ajVEcWjFhS4edH5K6ikiH1vaI04BS9WMYQvYiaRPH
	 7Wkz1rNuBpaxGd0B9C/+F96AA3g3WApR4IfDmlQkpObBgY2IbK7sTDKbTi/qQUH25V
	 wTesyhUX87grDxMnyia3fA6O+g9/De57gzSXa+cLXdAaYbis9obYauivIQVeCKe4uL
	 Fmp1+voB3agGWkl7oG/2zx7u1gJh+YYKRR8RpVzpOslzk5NMoITGjrhhkG1Jb+tR0N
	 ZWyatNxK0iniw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15A3380A963;
	Thu, 22 Oct 2026 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lan969x: don't disable hardirqs in fdma tx clear
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262901059.1378903.1270598313678764253.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:30:10 +0000
References: 
 <20261020-lan969x-fdma-tx-clear-irq-v1-1-b9f9d1eda317@microchip.com>
In-Reply-To: 
 <20261020-lan969x-fdma-tx-clear-irq-v1-1-b9f9d1eda317@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 10:57:27 +0200 you wrote:
> lan969x_fdma_tx_clear_buf() runs from the NAPI poll and frees the skbs
> of completed tx DCBs with napi_consume_skb(), under sparx5->tx_lock.
> 
> Before this patch, the lock is taken with spin_lock_irqsave(), so the
> skbs are freed with hardirqs disabled. RX skbs are marked for page_pool
> recycling, so when such an skb is forwarded back out and its tx
> completion frees it here, the free path reaches __page_pool_put_page(),
> which warns via lockdep_assert_no_hardirq().
> 
> [...]

Here is the summary with links:
  - [net] net: lan969x: don't disable hardirqs in fdma tx clear
    https://git.kernel.org/netdev/net/c/9770818b8a92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


