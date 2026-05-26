Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5303FE375;
	Tue, 26 May 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804945; cv=none; b=Ftb6MTpk+VeB/1Pr+jFDb+j/skpsUnOzQrV+Dc3Y/ivqXxOIRj2iza3KwhnTVny8quBfqnDVf7dsPmTaWfhWtcc4TZzikhKTOg9b1GrIvFipKaJes8pShIH1+wd6xRiaBN90Qo+ngeQSjwe/nH9WRjG8XAFyn8suLhO8WBcAiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804945; c=relaxed/simple;
	bh=m9WMC20Tv8Zv2Emye8XCi2XK8RzVvBCT4fLbuhzxHPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haMMjppyMNwWPgyV8SafsqfkXLsap2PCsPr2wjEJT7XANzmIgqsx0mIRSkRNY4JWpIoubkVZldorPyh63UIzEEDfCpYjLu68y+8a2WK8TICxRS1yLCXpxjGhusUJSXXRbeHZgVLIVG9VDXCh7i4fp17LSdjk4zTZTOFTib52bYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Itee+OVk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Itee+OVk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AXeSChbrS2MKVVIoq8nDR3HUnmhmtFhqY4Lxl8563VQ=; b=Itee+OVkeiFb6m0Qj7SYWe0C8W
	zDfZH6LHb0j/IY8kzWtU0zpz3qE3b/BauxPY0deLPW1CUKnKmpbxZTNegBncUm/BQ8C/BT6nUTmz7
	hSxlza9lS7qSOREdu2GPLuzbAvaqsL8qC/8Yl7InyQLJL5Ci4ufQoQBnhJJi+IyeIoiM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRsZC-004akt-Cj; Tue, 26 May 2026 16:15:34 +0200
Date: Tue, 26 May 2026 16:15:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lukeh@padl.com" <lukeh@padl.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Message-ID: <71282124-10a7-4833-873d-d5f0451a2285@lunn.ch>
References: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
 <20260526-net-next-mv88e6xxx-cbs-v2-1-13eb49c29b83@luminex.be>
 <c2e2ec6a-edc4-4eb2-8dce-a79858e6a1e1@lunn.ch>
 <PR3P194MB1505D182F5C0D22C45A1F29FEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3P194MB1505D182F5C0D22C45A1F29FEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>

On Tue, May 26, 2026 at 01:21:02PM +0000, Cedric Jehasse wrote:
> 
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, May 26, 2026 2:30 PM
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Tuesday, May 26, 2026 2:30 PM
> > To: Cedric Jehasse
> > Cc: Vladimir Oltean; David S. Miller; Eric Dumazet; Jakub Kicinski; Paolo Abeni; Simon Horman; Russell King; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: use the hw tx queues
> > 
> > On Tue, May 26, 2026 at 01:41:14PM +0200, Cedric Jehasse via B4 Relay wrote:
> > > From: Cedric Jehasse <cedric.jehasse@luminex.be>
> > >
> > > >From the datasheets i've looked at these switches have 4 or 8 transmit
> > > queues per port.
> > > There's a PRI field in the dsa tag used to indicate which egress queue
> > > the frame is to be sent to.
> > > This isn't done for vlan tagged frames because this would overwrite the
> > > PCP value in the vlan tag (The PRI field in the dsa
> > > tag is used as the PCP value in the vlan tag).
> > 
> > Maybe a bit more context would be good here. This patch is about
> > frames the host is sending to the switch. Looking at just the commit
> > message this was not obvious. It was only when i looked at the tagger
> > change did i understand that.
> > 
> > Does DSA_CMD_FORWARD vs DSA_CMD_FROM_CPU make a difference here? Does
> > DSA_CMD_FROM_CPU skip some classification stages in the switch, where
> > as DSA_CMD_FORWARD might pass through more stages in the switch and
> > have the queue over written by the hardware?
> > 
> >         Andrew
> 
> Yes, this is what the documentation says on DSA_CMD_FORWARD:
> > Used for frames that are forwarded in a normal way (ingress and egress filtering is performed on these frames).
> 
> And on DSA_CMD_FROM_CPU:
> > Used for frames that need to tunnel through Blocked ports (like BPDU's). No ingress or egress filtering is perfromed.
> > Frames egress out the Trg_Port tagged or untagged determined by Trg_Tagged.

And are there any implications because of this? Could it be you do the
setup you suggest, and it gets ignored because of FORWARD vs FROM_CPU?
Or it is applied to some traffic and not others?

Again, this might be something to mention in the commit message?

   Andrew
