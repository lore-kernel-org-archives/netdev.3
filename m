Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E53C1D40
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548210; cv=none; b=hK27p+h1/xtjJTjZBZolSUBtFriLXz/uyg4yUqXaVPkY1nqfAwOcZpOH6kbqoO7AspXIYP1gsTz4A2cuLWFNy3A/gV+A1pU4XLw3AeYhwceNgkyj5VsmCsuEOnZDrZgGunUqEw5J4YHse765tYGkPeU8a/8FAaZ4uWgJLqm4kTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548210; c=relaxed/simple;
	bh=dnibPEG4jGRj/BJAlnh0DvGWOm6qVHJ1k0yIzUrTACs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePrwBVPUiQK3Lpei7Hhp1a0wD3CzAMyvQtFxxEZFMxDnER6jJ5QoFRqsIM51qpJChtVC4IuW7f8eMbyqp09mWiQGk/I76JnUV+IlJdc6dun2RPFCRXzdfSQWOrkjae7psZQbnQjkyCj89nia9KpegSf/cZWDjYc3oRpxUH6Lg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JXosGhce; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JXosGhce"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mXr3QTwFQHOWT09wOL0oo2tt/LPk0OgqDJnxc2z2ZtM=; b=JXosGhcey0kzEgatcoS89tYC0u
	+OaUE6ieeCjZ4K3pDIndWw05YeOptMgiW4mfQsNKAyHyJSB0QUmQPRP0e8QKxdsgANlNNwRCzTKlm
	DFYTnSI92AQK5qJHoIQabHMkjDs+QZaphX4AUjFeJ1u2M6bzRCmHt2e/6G+NDyYtKbeM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAxNl-007aDI-0L; Mon, 28 Sep 2026 00:30:05 +0200
Date: Mon, 28 Sep 2026 00:30:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyou Xu <xuziyougm@gmail.com>
Cc: Gaoyang Wei <yhyxwgy@gmail.com>, netdev@vger.kernel.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC] net: towards a generic PON framework
Message-ID: <84a27a94-4e9b-43dc-a178-542ae5cee961@lunn.ch>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>

> ITU-T G.984.3 defines it roughly as:
> 
>      bit
>        0          11 12         23 24  26 27          39
>        +-------------+-------------+------+--------------+
>        |   PLI (12)  | Port-ID (12)| PTI  |   HEC (13)   |
>        +-------------+-------------+------+--------------+
>        |<---------------- 5 octets --------------------->|
> 
>        PLI       Payload Length Indicator
>        Port-ID   GEM logical connection identifier
>        PTI       Payload Type Indicator
>        HEC       Header Error Control
> 
> and the frame is:
> 
>        +-----------------------+--------------------------+
>        | GEM header, 5 octets  |       GEM payload       |
>        +-----------------------+--------------------------+
> 


> The field relevant here is the Port-ID.
> > How can you tell apart a OMCI PDU from a user data PDU?
> 
> That distinction is normally made using the GEM/XGEM Port-ID before the OMCI
> implementation sees the packet.


> Depending on the hardware, some information from the PON side may still be
> available after de-encapsulation.

So in general, the hardware is doing some level of demux?

I would of put everything as it is into the skbuf, and pass it to the
network stack, telling it what the first header is. It can then look
into the header and demux it, same as it does for any other protocol
the Linux stack handles. You can also hand this off via pcap for
tcpdump/wireshark.

If the hardware is doing the demux, try to feed the skbuf in one level
higher in the stack?

> If the immediate userspace requirement is simply transporting
> already-demultiplexed OMCI PDUs, AF_PACKET already provides a packet
> transport abstraction.

Throwing out another idea, which maybe completely wrong...

An interface is just a device which receives frames from the media. It
can have multiple protocols running on top of that interface:

6: eth42: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none 
    inet 10.20.0.82 peer 10.20.0.1/32 scope global tun0
       valid_lft forever preferred_lft forever
    inet6 fe80::61ae:d150:2724:7d6f/64 scope link stable-privacy proto kernel_ll 
       valid_lft forever preferred_lft forever

Here there is AF_INT and AF_INT6 address families on top of the
interface.

Would it make sense to add an AF_OMCI?

> So the part I am still trying to understand is whether a minimal
> non-Ethernet net_device, used only as an AF_PACKET endpoint for these
> already-decapsulated OMCI PDUs, would itself be considered the wrong
> abstraction.

An interface which is not an interface causes a lot of confusion. The
DSA model for switches has shown that. You really want to avoid this.

    Andrew
