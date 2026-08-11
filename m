Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2736EA98;
	Tue, 11 Aug 2026 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434522; cv=none; b=KuVvoiydH0f4m9NdzQDhjYTyIbRENNikNie9XeFQCcfWqwmHAup5s81+/A/GGZldyMtxwOjoAQzdHrjDvCqlSOQ2/Cu5R9JSllJmy+ASFs7CBTaYwpr2ojUe8wcLLIehXRVeS7nwmArBIDp5x4RVUx1fYARRFGvmI3xWHn0qLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434522; c=relaxed/simple;
	bh=Cwghg1RRZ775f7AlJIS11uWSUUT2yxNGNypS52GuMLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw+2MMEz8Bz4M8fVenTTd0tG7KZgJofIMDo2q9ulVsE1y6QQllDIGtM7qWbvRf0AbepZ0Gp3JwX2ZXvhgNnKT1RAapodVvEQmN8b+h5oLyZZJZcRSvVuovfWOEQ2ET1g6XVj3fiRK65W4e6fPpOs0TczJEe0t7IBgIi1iViyo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzgAtXk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzgAtXk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469CB1F000E9;
	Tue, 11 Aug 2026 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786434520;
	bh=daXUWiNhiN7cNvtBzAZ9KFArZ3GpfPxgFjFP5H8KqzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DzgAtXk5RGh2onxOvP+qmdvGYDOuzPDI22Lv1njALZ47IygRgMoUvuOJQfPMVKLn5
	 7mMc7QLA+Pd0ih0lzmbQxDoYn2s4tiKoyjWRKgBz3MTHODVNrEmsKAay2KNqua/8iZ
	 frWOrLFaYN3YMTqmzlgGcCijl6w+jSgNDbGUULhFw4BUXQ8k/WKgF+N5u2u9yEHJuU
	 ZQ6cMwEuRfWCOHujhF3zXAqemucZ00SIa8426xPhGKAFoMIEBv1vxXEQ5OaV/VzjvL
	 qD1wugMLlYpB1YuqjCOCLyEuvtAwhvtIrYPPBn9mtwW508Uzwk2PYQ9NYpqZu5cMtX
	 XtAoL1dpDVHww==
Date: Tue, 11 Aug 2026 08:48:35 +0100
From: Simon Horman <horms@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, c-vankar@ti.com,
	vadim.fedorenko@linux.dev, v-singh1@ti.com, nm@ti.com,
	daniel.zahka@gmail.com, nora.schiffer@ew.tq-group.com,
	oss@vassilevski.com, grygorii.strashko@ti.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix port_id
 extraction from SRC TAG
Message-ID: <20260811074835.GW51943@horms.kernel.org>
References: <20260807111738.2055900-1-s-vadapalli@ti.com>
 <20260810165629.788002-1-horms@kernel.org>
 <d7841492-7e2a-4f4e-ae82-8058c7f4c6a5@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7841492-7e2a-4f4e-ae82-8058c7f4c6a5@ti.com>

On Tue, Aug 11, 2026 at 10:38:55AM +0530, Siddharth Vadapalli wrote:
> On 10/08/26 22:26, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260807111738.2055900-1-s-vadapalli@ti.com?part=1
> > ---
> > --- Patch [1]: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG ---
> > commit b0ed959d350c90d8b49f6f81eba7461fbc86dcf4
> > Author: Siddharth Vadapalli <s-vadapalli@ti.com>
> > 
> > net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG
> > 
> > The RX path extracts the ingress MAC port ID from the CPPI5 descriptor's
> > 16-bit Source Tag. Only the lower 8 bits carry the port ID, so the patch
> > masks the value with 0xFF before it is used as an index into
> > common->ports[].
> > 
> > > diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > index 434a31080855..6330540979d7 100644
> > > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > @@ -1310,6 +1310,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
> > >   	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
> > >   	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
> > >   	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
> > > +	/* Port ID is contained in the lower 8-bits of the 16-bit Source Tag */
> > > +	port_id &= 0xFF;
> > >   	dev_dbg(dev, "%s rx port_id:%d\n", __func__, port_id);
> > >   	port = am65_common_get_port(common, port_id);
> > >   	ndev = port->ndev;
> > 
> > [Severity: High]
> > [Finding: main-1-0]
> > [Sources: opus-5]
> > 
> > The missing range check on port_id is pre-existing and not introduced by
> > this patch, but since the change is specifically about avoiding the
> > out-of-bounds access, would it be worth validating the value instead of
> > relying only on the mask?
> 
> Hardware guarantees a valid Port ID in the lower 8-bits. A Software check is
> an unnecessary overhead and will impact performance since this is on the
> data-path and is not a one-time check during initialization.

...

Hi Siddharth,

Thanks for addressing the AI generated review.
This all looks good to me now.

Reviewed-by: Simon Horman <horms@kernel.org>

