Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137737A494;
	Tue,  8 Sep 2026 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848370; cv=none; b=LalJ686qIl0zQ05xkpVuL+VOWHEyvjroHvpoxQIcspi5L0q4pT9QSsqGW1wx3URwyLlEInc1ZSkygFe+zqrLa/5rUqp3PZdi1VBe4UzskBvV4OwTyegYFJYKlulTt8EdxvxY7Hmy1Z+WVStCgDToevj+DLAQrV3HIHwT3Ed8zx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848370; c=relaxed/simple;
	bh=EZJ0j/vdbi4DD0YEcnHVs6XxHafYKQpog6m3fAY7XFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5isF9FBv2AzgF7OXZ9raxCwOxYe98J0a2zlHJSQBJiXuiJdkygVGt316tZh/YfW1nWbnGhXLhywGEWsduSOJQ5aTrxfUnj24XtIdBRWKMot8eKlqvrpmWcnhzyWxPgXdeNvLMT5WuU+OIaw9QhNzT2eXQuhbu6ZofNjBpRtn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRnssSkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRnssSkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7B91F00A3D;
	Tue,  8 Sep 2026 06:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788848368;
	bh=s92ct8A1sg74paDHpSr84WVLOX/rqXgVr/V3yxi7VDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CRnssSkknaqRsPUIdDyjjWGPM4vmkXr775b7hp6MyY9sdCKdW78ik/P6sCR9UgnGG
	 qIRPOQdq6YDmQ9FQ7P0IbS4K94yCjePTD5BYXxg2lS1khZol8A3XrWeKlUzn6SG0u0
	 dJGwbivZUNDuhYaeNP+ZTzd55gGrt3B8Irn9J4bKZCcQn0cQ2CNss0XOk5N9odhd3a
	 mtDABMBplvkT+bXgEODIM15BaP3obgtSS3eUiK+9fu0CrSf1uNeICd2H+/+SOpKHpC
	 3L/adof2P19mgw5woTa0AlcEe5dWYTBqOSe2ob/GDa51UM32V6mvXwJFzkEpOAefym
	 DOPHjvqcmK4Tw==
Date: Tue, 8 Sep 2026 09:19:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v7 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <20260908061924.GM13683@unreal>
References: <20260907042617.4076723-1-rkannoth@marvell.com>
 <20260907072055.GF13683@unreal>
 <ap6VHVYnXcUcMTNG@rkannoth-OptiPlex-7090>
 <20260907113244.GJ13683@unreal>
 <ap6quHlmYxI0cJAl@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap6quHlmYxI0cJAl@rkannoth-OptiPlex-7090>

On Mon, Sep 07, 2026 at 05:44:48PM +0530, Ratheesh Kannoth wrote:
> On 2026-09-07 at 17:02:44, Leon Romanovsky (leon@kernel.org) wrote:
> > > > > +	 */
> > > > > +	if (order > MAX_PAGE_ORDER) {
> > > >
> > > > Size is coming from the kernel, how can it be with order more than MAX_PAGE_ORDER?
> > > There is contigious memory allocation request from driver for PF-to-VF mail box memory.
> > > It is crossing max page order in newer platforms as number of VFs per PF increased.
> >
> > I'm not sure what this means. You can't create a VF without assigning it
> > enough memory for DMA. You shouldn't get an "order > MAX_PAGE_ORDER"
> > error at this stage. If you do, there is likely another bug involved.
> 
> I will move the MAX_PAGE_ORDER / size validation out of the DMA helper and handle any
> allocation failure with a clear error at the call site, where we know the required size and VF count.
> 
> One question on dev_is_dma_coherent(): this qmem path relies on the platform being DMA-coherent
> (as noted in the commit message). Would you prefer that we keep this check in this function as explicit
> guard so that a future port to a non-I/O-coherent SoC fails early rather than silently misbehaving?

It is a platform integration bug to use such an SoC on a platform that
cannot support it. As with any other driver, this should not be handled
in the driver, since DMA coherency is a platform/device property.

If the device works only on a specific architecture (x86 is DMA-coherent),
add the appropriate CONFIG_ dependency in Kconfig.

Thanks

