Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BEA34B43F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558751; cv=none; b=pWj9quMOyj+ojXwHcB244tTam7cLFBEC+9pIvb5Dj4ke3im1XLA76cs4Yak8l3frdai30HapOijufeukJY4bgmhZIh3yEyiR/Kloj+x0r8gAdNs4C6GrpWFdAbTNuiohkR2XXZwpR5KWLPRZ7eSGTpCJT5CSi3SjBxbN5O2kpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558751; c=relaxed/simple;
	bh=lj7HY0Y0O99ud7mHkoHfHzlsINmhRPcj+JhHzuXLxYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWmoFb+48ZOs7LnkcaqwhW4OY/H6iZPwWNFbQ0uUsQ6aYFaG68NoHaUNW9FEXB7Scgb2a12PiUoQsKNrKFWE7Gk8VN2Vtz0EZ17zVjRHavuJr0RVVDDeNYP5u3VJmdyCFi82WHQrj0vzwhXjUC/xPj1j6iYtOBYPSc+ZSMd9l2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r5Crp9mz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r5Crp9mz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NjboV9Wg70zE9XkVdwrFWoz2fthmTJs1WzbV2940NEY=; b=r5Crp9mzM1xMuaDP8bw/Ep7808
	0CrAxjr2uyxuadpbIDnFHNIKtjKFiXA6Z/Wl0njP78lqx6hJuwTwY8CSSqjuD1ohCjHWwNMrf+IKg
	MYpib1qX1ourpyqsXyS1FgX5qkgICgeH1ODDlxUS0KmK+O8oeU5QIpIhj3TUT7ir8KWY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xB07l-007bWC-Rp; Mon, 28 Sep 2026 03:25:45 +0200
Date: Mon, 28 Sep 2026 03:25:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gaoyang Wei <yhyxwgy@gmail.com>
Cc: Ziyou Xu <xuziyougm@gmail.com>, netdev@vger.kernel.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC] net: towards a generic PON framework
Message-ID: <372bc103-e98f-486d-8dd2-f013b1dbbdcb@lunn.ch>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
 <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
 <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>

On Mon, Sep 28, 2026 at 07:11:19AM +0800, Gaoyang Wei wrote:
> Hi Andrew,
> 
> > Another question which might affect the architecture. From what you
> > have described, an ONU might be assigned multiple Port-IDs so it can
> > carry multiple, separated, service traffic streams? You would want to
> > represent each stream as a Linux netdev, with its own IP addresses
> > etc.
> 
> An ONU can indeed have multiple GEM Port-IDs, but I think there is one
> important distinction here: a GEM Port-ID is not necessarily equivalent
> to one Linux service interface.
> 
> G.988 has an interworking layer between the GEM connections and the
> Ethernet-facing service.
> 
> For example, one Ethernet UNI can use an IEEE 802.1p mapper which sends
> different priority classes to different GEM ports.  Bridge and VLAN
> configuration can also make the relationship between Ethernet services
> and GEM connections non-1:1.
> 
> Very roughly:
> 
>                       Ethernet UNI
>                            |
>                    bridge / mapper /
>                      VLAN handling
>                      /     |     \
>                     /      |      \
>               GEM port  GEM port  GEM port
>                  100       101       102

I think that is too roughly, because that is not how Linux actually
works.

A normal setup would be

                 br0
                  | 
		Bridge
		|    |
               eth0 eth1

and

	vlan0:42
	 |
	 eth0

What it sounds like it should be is


                 br0
                  | 
		Bridge
		|    |
               eth0 eth1
                |    
       ------mapper------
      /        |         \ 
    GEM port  GEM port  GEM port
       100       101       102

You get your 802.1p tagged frames flowing down from user space and at
the bottom you map them to GEM ports.

How you classify frames above to tag them for 802.1p should be out of
scope at this level, it is a TC problem, or done via the VLAN
interfaces stacked on top of the base interface. It is a solved
problem Linux can already do. It is the mapper which is new.

But i assume this is also possible:


               eth0                                 eth1		
                |    		                     |    		
       ------mapper------	            ------mapper------		
      /        |         \ 	           /        |         \ 	
    GEM port  GEM port  GEM port         GEM port  GEM port  GEM port
       100       101       102              103       104       105  


> Putting your two suggestions together seems to lead to a cleaner model:
> 
>                      +------------------+
>                      |    PON device    |
>                      |  (wiphy-like)    |
>                      +--------+---------+
>                               |
>                 +-------------+-------------+
>                 |                           |
>              AF_OMCI                 service interfaces
>                 |                           |
>           OMCI userspace             Linux net_device(s)
>                                             |
>                                    VLAN / TC / bridge
>                                             |
>                                       GEM mapping

You might want to talk to the wifi developers. Do they actually like
the wiphy model, does it work for them, or do they wish they could
throw it away and start again? What would they do differently?

> That also seems to answer part of the question raised by your AF_OMCI
> idea.
> 
> If OMCI is a protocol associated with this lower-level PON object,
> then there is no need for a synthetic omci0 merely to obtain
> AF_PACKET semantics.

So as you say, one question is, how do you associate an AF_OMCI socket
to the lower level PON object? A typically home router probably has a
single SFP cage, but maybe somebody will build a box with two SFP
cages, you can connect to two independent providers so you have
redundancy, and load balancing, etc.

How does addressing work at this level? BSD Sockets can use bind(1) to
set the local address. Or you have SO_BINDTODEVICE socket option, if
there is a name which can be used. I don't think it needs an ifindex.

	Andrew

