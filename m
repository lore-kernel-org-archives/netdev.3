Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2C48035F
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629845; cv=none; b=sU3nERWi7JJ/zm21yC+Zidnnf+l7CnxFMt7tD9VPnQrmdjNdX2aQHxdpQvBd+3iHmgpsQQJ1ndxoLNMBUlWZJK1aIJ/zNAqYSOEUMWI5P14oK5hr1rF2EdJukwNYEctJ9fAVo0HLcbUDe91uYn8U/uQFxPuCCWygHtVr54zSpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629845; c=relaxed/simple;
	bh=Xloz0aI1iGTa4gmJL5Z1p5FO2i6D/VEHcxLtxhcAyFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eypJsmPCYvDkPkpuBDg+F3r9MGUTg4PQEtLQ+tfXu3kL2qBgDY/L6qDH27Uy0l0B56KqZoaMLVJMkrUR1CiT3CqFX6/89jRnq4KeuCWO0UQWYKAY4RM4Gd1UfuHvB90HXN3nErESGQA/SDIcyO0/rZEEyg32guzfl2meO6gLuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j22OvqY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j22OvqY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CA61F000E9;
	Tue, 21 Jul 2026 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629844;
	bh=Uqe8psFDIQlKSUFJ5GIbpCPkfIxTBiYWBpCteC7DREQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j22OvqY8Pbif3S+luzLHYveGbmXuvmMd/W97S/Z2LHy7m9XE4t6B1gGUDf0xDXQrY
	 KkikLafF1h1CYj/WnR8bVBhShcOEY1+XzT30ftghVIjhhE7GOqSGTiGiQINnrZDpGq
	 Tf+1RUSTNCEvZxorT/lXoij9XiBLIorLbXnduLp5KoGzJIRdy4L36tycL3Afr7hBC+
	 1uqnYL4G5zTHJ/7/pZ+dHAv1d+O71Kxo/PXToxnxHsWqf4T0Fi4ZEK8y9JpchA23Lh
	 2k4ITc37CZhBX3iNMXaNKgF+yL6Z92ZQ/9w2mCW2A2piT3V17QF6Q6FqcT18wO5kjp
	 RKhZ3Az5WQPKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A203924A64;
	Tue, 21 Jul 2026 10:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix DMA direction for NPU mailbox buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462981413.215603.10774821203949448313.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:30:14 +0000
References: <178351055214.98729.11403147818632027428@gmail.com>
In-Reply-To: <178351055214.98729.11403147818632027428@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 8 Jul 2026 19:35:29 +0800 you wrote:
> airoha_npu_send_msg() always maps the mailbox buffer with DMA_TO_DEVICE,
> but some callers expect the NPU to write response data back into the
> same buffer:
> 
> - airoha_npu_wlan_msg_get() (NPU_OP_GET): NPU writes response into
>   the buffer, then the caller reads it via memcpy()
> - airoha_npu_ppe_stats_setup() (NPU_OP_SET): NPU writes back
>   npu_stats_addr field in the response
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix DMA direction for NPU mailbox buffer
    https://git.kernel.org/netdev/net/c/6f884eb87a79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


