Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199658;
	b=f3Hx5xdOOvwIXw1Ws0FAzlcveznYkRh2DGa/VFzaSeev3CTUQtp83cilqmAUQg7pFkyb
	 kE4GHMcdk7Fw1I1MM9IeBYKVzzg4Uzr2HbqiIg4xENAyspFXyCPmtX8rh321E/P/P4MQV
	 x+RNloUbhSxoEdYenFsHsNCzbUq9td1SUZN/4Eo8bSMGldi1l3E4eJrA85HLq/M9wderl
	 r3LSgheIyQdy85ITacMHLVBe3xRcgnYgjVZQNGVjuBuGFgnWyP1V3bfL5ucORjvv4whmX
	 VothTl09teNBo6thOTP640Tqn5/c5v7gn3gp0bDKa6kwho/AoPq9/tWYJCWXMWGNlFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199658;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=97Oq3h61nNGl6LLTRfZVkFwajsAV8PVh6RmhEZUOMCg=;
	b=e3kf3oqA+zGxpDd/oixENZ2DAWdkQJryFTj0HyPo60JUNr/5NozI4ylMmJxuJ9aWlO8M
	 HVIRImGoaFgCJbsk9jfJl6qHf2C5xCisYYWexRukCoy5v0BENH/iHnN45/JQck1lpWAI/
	 79EeAm0LaWdMt1pknjkXTcxXzIacmVgxztAi/QWb3X7Tczh8HE/hqOthnxs67yxZlBzIG
	 lF1vsvQKbke2w7aRcivAS8GJYvRGvqSZfOFCg13evkoTQD0NimB5t1KBO5MhGo0eRHa7m
	 0SjLq6Hccz1a7ect5pz0oSxVMsvRQSwV8uXEfCPfhiGG7p+GDG7n/4Zbqv+vXJf2zPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs6HABx6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CD606A31C;
	Mon,  9 Nov 2026 04:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs6HABx6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE3D1F0089F;
	Mon,  9 Nov 2026 04:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794199657;
	bh=97Oq3h61nNGl6LLTRfZVkFwajsAV8PVh6RmhEZUOMCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hs6HABx6vSELnk8cm8cfChFZua9xIEEKQSWqtTW3oajmjkrUSCvrgq4t5l8WsC7Rx
	 pflLZ5C2RQn6HdR9sdt83Ms2z4k2JpnezxZ0e7hAmX8wt5MVWaylh7v+nczzOnWVvB
	 hqA2oIYUCYmQVtFChOPf32RZgdxLNKKu/tuRiiSXrXXcVKF7CzlxMMTQHexPiRBeeg
	 yOXWEruDQzzACNv+JgXdSAyd8XJh7YjOX7beBZVA/4c7Tkx3UHvHV4FlLo5ecnpVyI
	 QHIYAbKkawSNiirr8MQtbYosZBdXZHdpVfmC0ZrNgrKc3f+5qLxJWXjFkj0oGVEt/B
	 2cqLDZq1IrTEA==
Date: Mon, 9 Nov 2026 12:27:24 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Disable checksum insertion for XDP frame TX
Message-ID: <avFLrDFxQdj4mbpN@xhacker>
References: <20260929121025.20821-1-jszhang@kernel.org>
 <f0d8c25f-96e1-4da8-af6c-3286610338ba@lunn.ch>
 <atn0mF-dukVTK6Lh@xhacker>
 <741319db-17fb-4768-8606-9105df6bf905@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <741319db-17fb-4768-8606-9105df6bf905@lunn.ch>

On Thu, Oct 22, 2026 at 03:54:54PM +0200, Andrew Lunn wrote:
> On Thu, Oct 22, 2026 at 07:33:44PM +0800, Jisheng Zhang wrote:
> > On Tue, Sep 29, 2026 at 10:29:14PM +0200, Andrew Lunn wrote:
> > > On Tue, Sep 29, 2026 at 08:10:25PM +0800, Jisheng Zhang wrote:
> > > > stmmac enables TX checksum insertion for XDP frames whenever the queue
> > > > supports it. XDP frames carry no TX checksum offload request, so this
> > > > can overwrite a checksum already present in the packet.
> > > > 
> > > > Pass false to stmmac_prepare_tx_desc() when transmitting an XDP frame
> > > > so that the packet is sent with its checksum fields unchanged.
> > > 
> > > This seems odd to me.
> > > 
> > > If the frame contains a checksum, it is either correct, and the
> > > hardware calculated one will come out the same, not an issue.  Or the
> > > checksum in the frame is actually wrong, because the frame has got
> > > mangled by eBPF before sending it out, and you want the hardware to
> > > calculate the correct value.
> > > 
> > > What an i missing?
> > > 
> > Hi Andrew and all,
> > 
> > some discussions happened in below thread
> > https://lore.kernel.org/netdev/athAoWfW-xesPhFP@xhacker/
> > 
> > Since it has been merged. Let's move the discussion back to my patch.
> > 
> > AIUI, dwmac can only do HW checksum for normal particular packets
> > layouts, such as TCP, UDP etc. The stmmac_has_ip_ethertype() has
> > well demostrated this limitation.
> > Different with normal tx where the common stack supplies the skb->ip_summed
> > metadata, XDP path doesn't have the necessary metadata. So to make
> > the XDP always work properly when transmiting tranmist arbitrary Eth
> > frames, dwmac HW csum needs to be disabled by default currently.
> 
> I don't know the XDP code. But...
> 
> Zoom out, look at the big picture:
> 
> What do other MAC drivers does? Do they also disable hardware checksum
> when XDP is enabled on a queue?

I checked ixgbe and i40e. AIUI, their ordinary XDP tx paths don't
request checksum insertion: ixgbe_xmit_xdp_ring() leaves the checksum
offload bits clear, and i40e_xmit_xdp_ring() supplies no checksum
command or header offsets.

So this patch likewise changes the descriptor for each XDP frame. NOTE,
it doesn't disable checksum for normal skb transmissions.

Also disabling insertion doesn't introduce an automatic software
checksum calculation. An unchanged forwarded pkt already has its
checksum. If an XDP prog modifies checksum-covered fields, it's
responsible for updating the checksum.

> 
> Should XDP actually have the needed meta data? Can it be added in a
> low overhead way? Does the overhead of having it cost less than
> forcing software check sums?

This needs XDP common code path changes, I think, it needs a separate
discussion.
