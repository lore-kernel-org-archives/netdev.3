Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677312;
	b=LEg/dKoDVAnHi+ENao+kCx5C5dKpNlyJZJ4sQMVJcQHrJbA0w8/ZsWl5os9SrhCmoYM6
	 cu53BBDegk2PY4z+zvMLA22Ets5YpFZwZIMWetqNcEK+DMIksfTkrf4Oar1c2bdhgcTrh
	 qpXgMERvrjwEMhPXfZUN1V4qQ+vFCLwAkNbK5Ay2cFzzr2I5+C3bB1XDBjbypka/j42U+
	 ihej2AgOpUbrZTN0upYGoCPQV+cUt70/36yLb2dKP6BeYhOfrpW1fqdSZS9igcWBSxxUN
	 VLu/1z9Xz8HXa6vreM4fbM+46HsGpbvaYoXjHwfgbJ4kem6QziR7FRO0UegronNLnXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677312;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=2ojm36jDUBb6pXJrubCoB6gVau8R+P1ZTa/JMKRiThE=;
	b=OVF6Ft10Q6UdckBhAXKEtq55gXRvhr2XltOzFIRX+NRf7T6Fjw9yk2qEfj9HNUnwZAj1
	 MsDqFWz6xffqQNZJFpqvkBWmJgQkU2GDUURlzDzno4vzOjOPst/yuDzSSII5gyZ63HMFR
	 /XvvpDykm2g3xrwg/1V2YTuCMRV9dprWt6UML3YwVBBAAm39taCvpKieVK81qS5LyZJ7+
	 ifA+HJyK7m3GR5P569RD/83yXHYk2e8UUhpqAZbdfXTY8yXAZGNKa+O/Wa5HyumNlq1S9
	 Kt7ZfKfsIG//bNko+y3HwT9MIOLHxO3LhMvRFFRgwvcfuRZ61kS5yxEUAICD3dQWrSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=CxrBhuig;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB0606A31B;
	Thu, 22 Oct 2026 13:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BB0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=CxrBhuig
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2ojm36jDUBb6pXJrubCoB6gVau8R+P1ZTa/JMKRiThE=; b=CxrBhuigoakpWN5Is0+/mnuMlH
	7kvWlQaUZz3J10DLYIY62uAy0UDsgHoBxPmyVdeiQfOB69wozYtoATCzfGr+fXCjXhDDZdMBcXeBK
	TnRlktYSQY0q6QnulyWq8f1vtaS9fInAIMV2u5lngm9VwdpTSQlsXSt13abfxEFN8ios=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJtFu-00CGU8-KE; Thu, 22 Oct 2026 15:54:54 +0200
Date: Thu, 22 Oct 2026 15:54:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
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
Message-ID: <741319db-17fb-4768-8606-9105df6bf905@lunn.ch>
References: <20260929121025.20821-1-jszhang@kernel.org>
 <f0d8c25f-96e1-4da8-af6c-3286610338ba@lunn.ch>
 <atn0mF-dukVTK6Lh@xhacker>
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
In-Reply-To: <atn0mF-dukVTK6Lh@xhacker>

On Thu, Oct 22, 2026 at 07:33:44PM +0800, Jisheng Zhang wrote:
> On Tue, Sep 29, 2026 at 10:29:14PM +0200, Andrew Lunn wrote:
> > On Tue, Sep 29, 2026 at 08:10:25PM +0800, Jisheng Zhang wrote:
> > > stmmac enables TX checksum insertion for XDP frames whenever the queue
> > > supports it. XDP frames carry no TX checksum offload request, so this
> > > can overwrite a checksum already present in the packet.
> > > 
> > > Pass false to stmmac_prepare_tx_desc() when transmitting an XDP frame
> > > so that the packet is sent with its checksum fields unchanged.
> > 
> > This seems odd to me.
> > 
> > If the frame contains a checksum, it is either correct, and the
> > hardware calculated one will come out the same, not an issue.  Or the
> > checksum in the frame is actually wrong, because the frame has got
> > mangled by eBPF before sending it out, and you want the hardware to
> > calculate the correct value.
> > 
> > What an i missing?
> > 
> Hi Andrew and all,
> 
> some discussions happened in below thread
> https://lore.kernel.org/netdev/athAoWfW-xesPhFP@xhacker/
> 
> Since it has been merged. Let's move the discussion back to my patch.
> 
> AIUI, dwmac can only do HW checksum for normal particular packets
> layouts, such as TCP, UDP etc. The stmmac_has_ip_ethertype() has
> well demostrated this limitation.
> Different with normal tx where the common stack supplies the skb->ip_summed
> metadata, XDP path doesn't have the necessary metadata. So to make
> the XDP always work properly when transmiting tranmist arbitrary Eth
> frames, dwmac HW csum needs to be disabled by default currently.

I don't know the XDP code. But...

Zoom out, look at the big picture:

What do other MAC drivers does? Do they also disable hardware checksum
when XDP is enabled on a queue?

Should XDP actually have the needed meta data? Can it be added in a
low overhead way? Does the overhead of having it cost less than
forcing software check sums?

	Andrew
