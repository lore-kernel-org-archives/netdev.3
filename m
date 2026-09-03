Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1839060A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426007; cv=none; b=BoIZAerYeU4qNZzmdrrMrbwbjV8+IivyNymRKIUPbcHRg+itTO+1sOKe3TWZEfV73GOckxOnBIejhQlurYbZjGhdeB47dvvGVM5nkLrYmR/sVg9bYaX4am4wSTQwVj4PI+EnMMDH3VxOHScWkq5hgZGUw+6dl28T+Z+9IPIcy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426007; c=relaxed/simple;
	bh=4NstDlohkWjIgcni65mVUwiaGk5yiWDokMTEwFCkLJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6Bmoadi8tg7ZfgMFbXDuDrG80mk3C+Z51OYeA9M3eZLikjeuLi8sBeTrZErLRqpWvVCuWu1De0u8NMqcavmJd9XQZJjtREHq8gGZJz+yaxzalMzvEsAL/DXIC5hYChsNMMLjBAVBMBH03kuEY8PRrFgxCKOr3KImF8WV65DE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnA8uajd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnA8uajd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8191F0155A;
	Thu,  3 Sep 2026 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788426005;
	bh=RE0ASB+DdFZ2kYHuMUvbFe6R5K94GkgGPlp796qZCRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BnA8uajd9lyP7thrGqR/vwSIZFCF32l3ok4ysl1WamoE86XDm02l0gGJdxMZ7qxZH
	 qF6rZZHh14j/Z3LYYVPekElmOIYwtQNYRVuVymmcD26eN1wj19fOjl8AQ1NuYMkT8A
	 U1LMF3a0BB8LOSf51ABrPdZR4TZIhOgkGr2v29jkgZXxjOn6iOG/YGE/6iV6GgUBPe
	 jjVZ2fLwVY5GyQtOv8plQfV/vbk5NNfjZMSvUW3NqDo0BZwcGZHOgda4AU+984lLEZ
	 MN9NVrE2fbqVNbIhmyJyv6ARK6a13R31FOpVaLNN/4BmmhXh74MKODsI55dFQXHQIB
	 VV4DxQKOXqyTw==
Date: Thu, 3 Sep 2026 10:00:01 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [net] net: airoha: enable RX_DONE interrupt for RX queue 31
Message-ID: <20260903090001.GI396647@horms.kernel.org>
References: <20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f@kernel.org>
 <178836297161.3394541.17329602881799623239@kernel.org>
 <apig7UCTvWjKmzQB@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apig7UCTvWjKmzQB@lore-desk>

On Thu, Sep 03, 2026 at 12:19:25AM +0200, Lorenzo Bianconi wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> > 
> > Critical: 0 · High: 1 · Medium: 0 · Low: 0
> > 
> > - [High] Incomplete fix: the patch only adds BIT(31) to
> >   RX_IRQ1_BANK_PIN_MASK, so the exact defect the commit message…
> > 
> > --
> > 
> > net: airoha: enable RX_DONE interrupt for RX queue 31
> > 
> > This adds BIT(31) to RX_IRQ1_BANK_PIN_MASK so that RX queue 31's RX_DONE
> > interrupt is routed to IRQ bank 1.  The stated goal is that the queue gets
> > drained and its buffers returned to the page pool.
> > 
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> > > index fa9a8edce22f..8277c1c87bb3 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > > @@ -538,7 +538,7 @@ struct airoha_wdma_info {
> > >  
> > >  /* RX queue to IRQ mapping: BIT(q) in IRQ(n) */
> > >  #define RX_IRQ0_BANK_PIN_MASK			0x839f
> > > -#define RX_IRQ1_BANK_PIN_MASK			0x7fe00000
> > > +#define RX_IRQ1_BANK_PIN_MASK			0xffe00000
> > >  #define RX_IRQ2_BANK_PIN_MASK			0x20
> > >  #define RX_IRQ3_BANK_PIN_MASK			0x40
> > 
> > [Severity: High]
> > Does this leave the same problem in place for the other RX rings?  After the
> > change the union of the four bank masks is:
> > 
> >   0x839f | 0xffe00000 | 0x20 | 0x40 = 0xffe083ff
> > 
> > so rings 0-9, 15 and 21-31 are covered, but bits 10-14 and 16-20 are still
> > clear in every bank mask.
> 
> Here I wanted just to align to the vendor sdk and enable rx queues 24-31 (31
> was missing) in preparation for HW GRO support. The other rx queues are
> out-of-scope.

Thanks Lorenzo,

Seems reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>


