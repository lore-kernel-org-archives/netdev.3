Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657655295D;
	Wed,  9 Sep 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958218; cv=none; b=osjZMGPN+LXh0tpHAJyV97arC/I4s45pIWLI/H8KBLp6sTkS4KYhP13RSeNBEQ7Kr0VhVd4Uy6hM+f8zNKpLbPYcxLq6RbEiR9o/8QpwNbDgkbGPUCXjauTFw8ayU9jsa8LsFbFQXeMFwCNsXFeRLKVQTiaxXbU4ruh5xJVzPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958218; c=relaxed/simple;
	bh=8S/e2+uC6E4iux8m3+K0fEvecNGMydkW7kj446cWzSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCVHgFzfTAkqkzouSJ+WREqFwa8+2Xyuwk7Gq+Qs+a+/H/S8eybNoUFIZy757O1bzWLP61x1hNcDX1KEmlQToIFYMfLez63iUxrbzx69+MCVvY4e/vcgSeZ1eY1ePnxP+CnvFwl99WjZl24p8yokyo61y2n0xnU6vFc2SI0MB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqBArHfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqBArHfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C6C1F00A3D;
	Wed,  9 Sep 2026 12:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788958216;
	bh=yDyJPqAaAdYyb6ktGL9kZgXGogHf4ynFWClRe1eBMzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BqBArHfmQUuBPCscfB518rlnf5qSKhrNQt27TUAufkpsgusOk8kMaoLAMtJeZ8v3q
	 MOfkDuzwdWE3sqaJ8vBqnwXC/covxgCsI7If481RkUf3Xn+FpGl/DsQkmhV5drQGgQ
	 Aqp6BHteOiBADXWl6gRRQ0VAA+Jx+j1iHGDzFzsSlQH2ixJ7zld+RWYHPfNbEXwyv+
	 pyTwS9hkanD75QgaZqAeCVYZ/4puockT3g7QddrcT0Xm1ZTVxbMzjjCqnUUEJ4vigR
	 fa5B/v+pnlLjVKMPbU1YeHY+VRww+D4G4yFyzszgTjBaa9B9fYl7UojF27vw564qmO
	 mWSE3kFLns0Fw==
Date: Wed, 9 Sep 2026 18:20:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Gupta, Suraj" <suraj.gupta2@amd.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH V2 1/4] dmaengine: Add support to configure and read IRQ
 coalescing parameters
Message-ID: <aqFWBEct9AoIR9KC@parshuram>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-2-suraj.gupta2@amd.com>
 <aICPiS1_ITwELrxq@vaman>
 <BL3PR12MB65713879CB569E3B330C1E76C95FA@BL3PR12MB6571.namprd12.prod.outlook.com>
 <aKxJQLx6yprNdU03@vaman>
 <3369241a-b591-415a-9f40-36f95bdd6a9d@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3369241a-b591-415a-9f40-36f95bdd6a9d@amd.com>

On 07-09-26, 20:23, Gupta, Suraj wrote:
> 
> Hi Vinod,
> On 8/25/2025 5:00 PM, Vinod Koul wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On 23-07-25, 11:49, Gupta, Suraj wrote:
> > > > >   struct dma_slave_caps {
> > > > >        u32 src_addr_widths;
> > > > > @@ -520,6 +528,8 @@ struct dma_slave_caps {
> > > > >        bool cmd_terminate;
> > > > >        enum dma_residue_granularity residue_granularity;
> > > > >        bool descriptor_reuse;
> > > > > +     u32 coalesce_cnt;
> > > > > +     u32 coalesce_usecs;
> > > > 
> > > > Why not selectively set interrupts for the descriptor. The dma descriptors are in order,
> > > > so one a descriptor is notified and complete, you can also complete the descriptors
> > > > before that. I would suggest to use that rather than define a new interface for this
> > > > 
> > > 
> > > The reason I used struct dma_slave_config to pass coalesce and delay information to DMA driver is that the coalesce count is configured per channel in AXI DMA channel control register[1].
> > > AXI DMA IP doesn't have provision to set interrupt per descriptor[2].
> > > I can explore other ways to pass this information via struct dma_async_tx_descriptor or metadata, or any other way.
> > > Please let me know your thoughts.
> > 
> > dma_async_tx_descriptor has dma_ctrl_flags and one of them is
> > DMA_PREP_INTERRUPT which you can set for a descriptor and control when
> > you get the interrupt
> > 
> > I am not a fan of adding custom interfaces.
> > 
> > --
> > ~Vinod
> 
> Apologies for reviving this old thread. I got pulled onto other work and am
> now picking this back up.
> Reposting the context below so we can converge on the interface direction.
> 
> As mentioned earlier, interrupt coalescing on AXI DMA/MCDMA is a per-channel
> configuration (IRQThreshold + IRQDelay), not a per-descriptor attribute.
> Because of this, DMA_PREP_INTERRUPT does not map cleanly to the underlying
> hardware model:
> 
> - The coalescing delay is a per-channel timeout expressed in microseconds,
> whereas a boolean flag cannot represent a time-based value.
> - Linux Dynamic Interrupt Moderation (DIM) adjusts both the coalescing
> threshold and delay at runtime, requiring an atomic per-channel update.
> Flags on already queued descriptors cannot provide this capability.
> 
> DIM is important for modern Ethernet drivers because it balances throughput,
> latency, and CPU overhead at high speeds.
> 
> If adding a new interface to configure interrupt moderation parameters for
> networking clients using DMAEngine is not preferred, would either of the
> following approaches be acceptable?
> 
> - Passing the coalescing parameters through per-descriptor metadata, or
> - Using the existing Xilinx-specific struct xilinx_vdma_config from
> include/linux/dma/xilinx_dma.h, which already provides coalesce and delay
> fields.
> 
> I initially avoided the latter in favor of a standard dmaengine interface
> that could be used by other networking clients utilizing DMAEngine. However,
> I'm open to either approach if it aligns better with the subsystem's
> direction.

Given the above description, I somehow didnt feel that you can use
existing flags. It is setting the flag per descriptor applies for that
channel imo...

-- 
~Vinod
