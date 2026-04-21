Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B153C455C;
	Tue, 21 Apr 2026 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774347; cv=none; b=oYvNKaVjQR9g17tXaAXE4o6eyQTfLGEJeSZ4oS7XdEpOPWWJNBWD1vzg0dSzsDuhw2NPqjJJuAv0M1DEagwFEXMyEAEJc6VkXT7XnUeXFq45IX+4byaygjkpxQkRRdh7WmIhMhGcr81YaUjVeZ0KsQvJOPWNzoQu1jeY+Zliopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774347; c=relaxed/simple;
	bh=ZhHd2FrW7rItrNUJWV3lcJYp57NU0EMoc2hYcgX69ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC03uJnUDRZAQSKId/fdsEBW7OIZCQfaN3JW7XUTDKKzCChyfXuUiSlO1Bz/HXxZiffGmy/RVu/QgL2mMZ/KbC9csFviK7EFp9dXYOzKBliPl4MtCgDvWIoS7j9dQjoIsEZ2l+UvP9WS6XytsmvPiXKCmytFt2rCcoHWSM7XNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cmxr/p+A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cmxr/p+A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DNU9H52ZbtEWsgC0S8tHko+P0/6qPpSIAMXfwbnDHT8=; b=cmxr/p+A9thEWzclZs2J2oIdXo
	Kz0cLlr//2AZdK5FURdQhba71NoaOO3mxZJNrColNBL1kEeVhDYC556exMJjZLEpkiodr0W/ik7D2
	5Gu7wo71Y8mALxOHYZ/e8qxw8LhHZEULusDyEQn4U4VAosfpitdNDRax7Tv25PLj6PmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFAAR-00GtEv-GA; Tue, 21 Apr 2026 14:25:27 +0200
Date: Tue, 21 Apr 2026 14:25:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: hugh@blemings.id.au
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mashiro Chen <mashiro.chen@mailbox.org>, netdev@vger.kernel.org,
	linux-hams@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 net] net: ax25: fix integer overflow in
 ax25_rx_fragment()
Message-ID: <8bb9032b-3a5a-4e0f-aa17-da407af62df7@lunn.ch>
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
 <20260413204921.70463-1-mashiro.chen@mailbox.org>
 <805a8583-6a84-4dfb-a4d4-53f80f50effc@redhat.com>
 <e2a47378-9008-45a2-92e3-d1f374b5e766@blemings.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a47378-9008-45a2-92e3-d1f374b5e766@blemings.org>

On Tue, Apr 21, 2026 at 06:45:39PM +1000, Hugh Blemings wrote:
> Hi Paolo, All,
> 
> On 21/4/2026 17:29, Paolo Abeni wrote:
> > On 4/13/26 10:49 PM, Mashiro Chen wrote:
> > > ax25_rx_fragment() accumulates fragment lengths into ax25_cb->fraglen,
> > > which is an unsigned short. When the total exceeds 65535, fraglen wraps
> > > around to a small value. The subsequent alloc_skb(fraglen) allocates a
> > > too-small buffer, and skb_put() in the copy loop triggers skb_over_panic().
> > > 
> > > Add pskb_may_pull(skb, 1) at function entry to ensure the segmentation
> > > header byte is in the linear data area before dereferencing skb->data.
> > > This also rejects zero-length skbs, which the original code did not
> > > check for.
> > > 
> > > Two issues in the overflow error path are also fixed:
> > > First, the current skb, after skb_pull(skb, 1), is neither enqueued
> > > nor freed before returning 1, leaking it. Add kfree_skb(skb) before
> > > the return.
> > > Second, ax25->fraglen is not reset after skb_queue_purge(). Add
> > > ax25->fraglen = 0 to restore a consistent state.
> > > 
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
> > we are moving ax25 out of tree:
> > 
> > https://lore.kernel.org/netdev/20260421021824.1293976-1-kuba@kernel.org/
> > 
> > please hold off until Thursday (after that our net PR will land into
> > mainline), and eventually resend if the code still exists in Linus's
> > tree at that point.
> 
> Is there any flexibility here ?
> 
> Jakubs (CC'd) patches to remove unfortunately weren't cross posted to
> linux-hams and so I'm not able to directly reply in netdev
> 
> We've had a thread ongoing in linux-hams around the future of
> AX25/ROSE/NETROM for the last week or so and believe we've a path towards an
> orderly exit from the mainline tree, probably towards a userspace
> implementation. This includes a couple of folks who have indicated they
> would be open to overseeing the maintenance of the code in the meantime.
> 
> We'd hoped to have a period of a few months to do an orderly exit from the
> tree to minimise the impact on the (admittedly small, but non-zero) users
> that build trees/make use of the in kernel support.
> 
> Apologies for my lack of familiarity with the process here to deprecate etc.

I know it is short notice, but there is a conference call today. Jakub
sent this yesterday:

  The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) /
  5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

  I'd like to discuss evolution of the process which would prepare
  us for the "AI age" (read: influx of plausibly looking yet entirely
  computer generated patches).

	Andrew
