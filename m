Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888799;
	b=gCB/NX2hWeUohIQCUHUxwhSaHdbQgt/n3P9nOHkRhhMJwy4kiZIqtlnkN0XuwOeEaxpO
	 ej93pInw7USQqOfvTcmdUaaocd7NFW1DYVlwtMgb10O7//WRVvnn+obDS6M6dmBGokini
	 idaTzq04ny7b5REpuZ+90WS0h8aoFJbIi4XKpbdekGKzwoIGEClZgvbJNpTH/Dhr2t7si
	 HJeFCsWcOVQYyM6yW5wqJoB6bCT9BWRv2sGozI+6FcdBqUMk2oNic+GP9BV8NRopzWzOZ
	 Yeogn9AobwvkYpMA6Wz8JfLK9JwN1m0yEvX7lhuqHk/zCjHzI5z0Nta+TEXoW3+l8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888799;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bB115A0rMOTqlvXkN/AIzQNgK8qZfXA7IorSb9CX7io=;
	b=BIR8JXWGPAL/WArjmZnRttenKxLleXQH3P3l+3H/MvWSQ1hjWMuSjj5isCPI8CaJQjEW
	 f5YiBr26Q8VvOvoU5HZMCQjlACUTGIOJ1oVYQgwTn4XrrgbrI0Gz8bWmOj8gGw0Pu/xgn
	 +UGmF/4bCR/oWCJa1xz5K2z1aPdJl1KE0QYbHdXBc4DDmvywWtiDvKhGvQ3BRm8SSP+Mm
	 3fTazK0Jw0JFzjJ53lkJnqZ8L2G4YFkkHhw1gPaH2J7zsYJQprykpM3B7AHtq1QcPcXN9
	 cRfzN9uRUUY6OgJqRpy8ckDQhfZxV/6wDgTmIHmZAqkGvLAHSDgOp6hRwy0fvzEJ0MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLZbEpUR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6908606A32D;
	Thu,  5 Nov 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLZbEpUR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141081F000C1;
	Thu,  5 Nov 2026 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888798;
	bh=bB115A0rMOTqlvXkN/AIzQNgK8qZfXA7IorSb9CX7io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kLZbEpUR7tlo+ZWC3OftlZigeROV+G/S2MWiAUwnAhPdaCJM4iLo5A1awAhxavhsK
	 ODjt8ZKDP88satnWbUD6GyJ4WG7eLo0fcKsRBdewiQXCYKDQoZBgmWtygUXii0VkeL
	 ShvkzBiNtiL8sf6hl04MO5SbTW7/GJVdVyI1b/pui/+wRkbFAza9ODH+jrtyPohyka
	 dbCoChO6ac7g5lWxqnMOdWvoT2FaIXl2YzLeZYbMMwkKpAJW7TTjS4qMR9oAGRctuP
	 EXSy3J89Bl1d90+lV7gUPTfQ2Zb65/zQZiFuc8RLOnMhxIu49FPToTDTH59SakH3pB
	 t2ru7Bf2Hxzuw==
Date: Thu, 5 Nov 2026 14:26:34 +0000
From: Simon Horman <horms@kernel.org>
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: ethernet: mtk_eth_soc: add 9K jumbo
 frame
Message-ID: <20261105142634.GT865646@horms.kernel.org>
References: <patch-4f863a941889f0bceca1c082f2d79624@loljews.com>
 <patch-f1b04513b0fe3fb0a35ac744799fb0f3@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-f1b04513b0fe3fb0a35ac744799fb0f3@loljews.com>

On Mon, Nov 02, 2026 at 12:48:45AM +0200, Sandeep Haemoon wrote:
> The driver caps max_mtu at 2030 bytes and programs the MAC max-rx field
> for at most 2048-byte frames, so MTU > 2K is rejected and 9K jumbo
> frames are not usable on the 10G XGMII MACs.
> 
> Add a MTK_NETSYS_RX_9K capability for MT7988 and:
> - advertise 9K max_mtu on XGMII MACs, derived from the DT phy_mode at
>   probe time so DSA can raise the conduit MTU before the netdev is
>   opened;
> - program XMAC_RX_CFG2 on the XGMII MACs;
> - derive the shared RX buffer length from the largest MTU and size the
>   RX rings from it;
> - program the PDMA RX SDL max frame so the DMA engine accepts jumbo
>   frames;
> - reject a runtime MTU change that would need a different ring buffer
>   size while DMA is running; the rings are sized at the next open.
> 
> This is a forward-port of the MediaTek downstream jumbo series:
> Mason Chang's "change default rx buffer length", "add 9k jumbo frame
> support" and "add dynamic rx buffer adjustment support" (MediaTek
> OpenWrt feed 999-eth-30/31/33, carried in
> frank-w/BPI-Router-Linux 92bfdbdd4de1/b4c6cb1d5532/ca4c976dce22),
> plus Frank Wunderlich's "try to fix crash the right way"
> (a3207a383794).
> 
> Link: https://github.com/frank-w/BPI-Router-Linux/commit/b4c6cb1d5532
> Link: https://github.com/mediatek/mtk-openwrt-feeds
> Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>

Reviewed-by: Simon Horman <horms@kernel.org>

