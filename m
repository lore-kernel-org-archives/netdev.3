Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F039A06F;
	Fri, 21 Aug 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309688; cv=none; b=CfW46xHlkfJWm6hMacO3Gy8+PyJSBXEMz0QDf0MYPEI+WWN8z+XmgCYFKdrxkUqiOZ7Jcfpu2pnGBpo345dMv/8Coi4AcjGswPQyPuD68DIKntYq7WPxUyPHtKrgpEw4WVg+BgJUvOBYlvyLgOoThYz7kSVduVNhithtk3g4Lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309688; c=relaxed/simple;
	bh=9yvVCPblnl1Hs0m2R1ompmgF5XK7HcESyQp5Hoe2Ifs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOfRkUDhl92DiTC+fm4sr/P9AoIfSBHJeeG8j9GpOQ615xDsDXUGVtxgmdkAV4FjGw+YuFKrZHcHSgwxQki8bJyTMxwX7ZnnqNXd/5Ai8wMdOvfwnB0ddASDhL7X6wZvYXpurXM+nWO6gTZ2LguWrYCrgnXaGeXt1btpjUSJxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPLlhxMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPLlhxMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0D01F000E9;
	Fri, 21 Aug 2026 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787309687;
	bh=PgY1M31eUBna9lj2b3bxg1PT8jUYs9RMaq/pBozhfFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OPLlhxMuijwp1cpaegIpHgaDEYqSlPEXLfZeN11vQaKUhms/r5LmyldSO7pCLrmVS
	 ue+KfDTc0/yBxcBxztTS4g8WiV4mdpI2aE6MYqcnYzAkEjfSIjVnUXMF8qiBmCrwo+
	 xSbikCEK4FTzg4rJWAwKe6PXM5/9ni7AOC1rqIvWIDt7WV9XA833Hoe/PUwQumKOgQ
	 qFOAiwSdF5BCbWFPQwJe7lc3JPb0NAn89tVFq8G+9Gab7zgiiABqHbPzEEzWpsy4V4
	 x2W7B17UYSrqGOfryBJj6wfe7bekhkGHJMXvadaZ+NlkpmXJsakU92hIlS8qKupigd
	 2BPmkWnXkRMzA==
Date: Fri, 21 Aug 2026 11:54:42 +0100
From: Simon Horman <horms@kernel.org>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: netdev@vger.kernel.org, Rex Lu <rex.lu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF
 to 0x80
Message-ID: <20260821105442.GI265046@horms.kernel.org>
References: <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>

On Wed, Aug 19, 2026 at 09:07:07PM +0800, Shiji Yang wrote:
> Change WDMA RESV_BUFF from 0x40 to 0x80 to avoid CDM TX FIFO overflow.
> Without this patch mt7986 and mt7981 may have WDMA TX hang issue. This
> patch was pulled from mtk-openwrt-feeds GPL open source project.
> 
> Link: https://github.com/mediatek/mtk-openwrt-feeds/commit/07c87502e854b68b48544d101b6fe17ec059b97b
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>

As a bug fix for code present in the net tree, this should

1. Be targeted at the net tree

   Subject: [PATCH net] ...

2. Be CCed to stable

3. Have a fixes tag. Perhaps this one?

   Fixes: cf26df8833cc ("net: ethernet: mtk_eth_wed: add mtk_wed_configure_irq and mtk_wed_dma_{enable/disable}")

I'm unsure if the maintainers would like a repost because of this.
But at any rate, please keep it in mind for the future.

More information on the netdev development processes can be found here:
https://docs.kernel.org/process/maintainer-netdev.html

The above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
