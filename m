Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491043;
	b=EtlQqP++jYqIoI/QJLMh4fbBvHoNDKPFPvPaA4pvd4rKRKqRsWOLch9vgg7yTh0TkzvH
	 SmiYveHigTcdyQML9NUu1UGbLXfHVHGu4IqXMnuGTGcxs5nCndeaVQteu2LYmmlWsOlHB
	 /Nwlqvhlbrt0fLRoysWiKY9hu4pCIGIHkJLSKATq0tnezK3LGsra/Lhs5K7wuU2gCbD1r
	 ay0SqHf7cQWTMllUxs6Y4dTUO/3DgRD8s02RacHEqXkVEXvQA5TqfsMr9kVyIOF6NT7Io
	 j+K8WuPTQA7VbbNQJtQO/yylGA+fD+0G4VyJmHQC//Q6ai7sfsM2+AZC6a8nmcL2e2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491043;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Bh9xFMrMUcNCltBKfyRaDPZe6ka6eyNBp32oRnvdPjk=;
	b=0jkQYf8RygXMz7d8b1o+utLOtm2e9+e4rSGjP9/mN6kvewLWC+yjMr+6wDqPPVrLCwh+
	 IeM452dNz+Nx/7rs9MUhBnw8/rhiwCeLdvokPoC2PZiBtaS5Yfh5hdfOwraeufckF9/44
	 QvWi2SGrrIi24uEWjzbZt5otoZeCLv4ThGkG0fxx/saBFhZm6ej0BDBELuihLR6/BU4oP
	 sRTkGVO3xCewOu3E0SP9zS/bH6nHBARDRzHZ7Z+kfUFzeKE5gYVncsFylO++M3zi39f17
	 ajeA6PidpK1+vNAa5AxcbBohMvIyEQIOYtAmn7G4WnYTE9v0j3/4eH8Bgo6rrFLILrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Drp4JXrl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF08606A319;
	Tue, 20 Oct 2026 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Drp4JXrl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DFE1F000C6;
	Tue, 20 Oct 2026 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491042;
	bh=Bh9xFMrMUcNCltBKfyRaDPZe6ka6eyNBp32oRnvdPjk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Drp4JXrlplx+lS7qurSjPflAV3uulAv2Ndb12n1kdwtv/dR/0GXGs+foaoVDzbcSf
	 11YA3u9W5DHbjuLCLQJq4KcpW3KVgYwii7+v09FLtCCQK1bjqNosjOrkZHFtAUoL5n
	 DLrHgoGSDtf9k94/Ppf3GJN82r8Lv3k4qIajSWGG8ov6/lFooCakjjKrnjNapaY8bq
	 qKaY6wur20axcXFArlSgKY9wNb5TpapfUBeKSyYk1rYqyH69SCTENpprumfzY6QFOx
	 LHNbhY3SOzCKUdMQZD4rZ5Mp16xZePSccuZwozEy8QPCLWQohINyJEJTBDFIVLwUZQ
	 ageQ/3u8cCIlw==
Subject: Re: [PATCH net v5 2/5] net: ethernet: mtk_wed: fix reset condition
 for rx wdma
From: netdev-bot+sashiko@kernel.org
To: hujy652@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, rex.lu@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Tue, 20 Oct 2026 10:10:41 +0000
Message-ID: <179249104136.3135.17477394405108454102@kernel.org>
In-Reply-To: <20261016-wedfix-v5-2-8b02e78fd34f@gmail.com>
References: <20261016-wedfix-v5-2-8b02e78fd34f@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "net: ethernet: mtk_wed: fix reset
  condition for rx wdma" only says the condition in mtk_wdma_rx_reset()…

--

net: ethernet: mtk_wed: fix reset condition for rx wdma

This commit inverts the check in the rx_wdma loop of mtk_wdma_rx_reset().
Allocated WDMA RX rings now have their CPU index cleared. Unallocated
rings are skipped.

> In mtk_wdma_rx_reset, only the wdma rings that weren't allocated are
> reset which is wrong.
>
> Fix this by inverting the reset condition so allocated rings will be
> reset.

[Severity: Low]
This isn't a bug, and the code change looks right. Could the commit
message say what goes wrong for users, and which paths are affected?

mtk_wed_start() sets up every rx_wdma ring that doesn't have a
descriptor yet:

drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_start() {
    ...
	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++)
		if (!dev->rx_wdma[i].desc)
			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
    ...
}

So once the device has started, all rx_wdma rings normally have a
descriptor. The exception is when buffer or ring allocation fails.

With the old condition, the loop in mtk_wdma_rx_reset() would then skip
every ring. MTK_WDMA_RING_RX(i) + MTK_WED_RING_OFS_CPU_IDX would never be
cleared for any live ring.

mtk_wdma_rx_reset() has two callers:

mtk_wed_reset_dma()
    /* 2. reset WDMA rx DMA */
    busy = !!mtk_wdma_rx_reset(dev);

__mtk_wed_detach()
    mtk_wdma_rx_reset(dev);

Could the message add a sentence on the symptom? For example: stale WDMA
RX CPU indices after a WED/SER reset, or after detach and re-attach.

That would help reviewers and stable maintainers judge how urgent this
Fixes: patch is.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-wedfix-v5-0-8b02e78fd34f%40gmail.com
