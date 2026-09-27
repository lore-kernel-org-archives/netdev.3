Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F313B8BBF
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549347; cv=none; b=AVMEDSnI2HhPNlaDmEebKlm+TF73k7O0IHmqhL4QEV4q49p1NBd4Kjie5ugRdTqvv/ZNJ6TSsMwMttM2lPaIZeRzShPwG7N/10PlfehvoC3Jaq8sWJuZ/62FtFrEaA+Uh/gN2HfTYO9X8ZBfmNgRzqPOJ1XEzk4WjAcGvfmbfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549347; c=relaxed/simple;
	bh=Tl+wERWuq/2/Eq/BQNJkCLNMDcokiyyg5GQKGuUN6+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ives2yKuQmJh0cktTgXjx7fnJvNKYJu8mA6ZS3f7Vq7Iw6wzvgfDbp0hia/i0T5bDCesRJ9nkgbqz/7bZfexfGj30pE5beoKqyhNn2vmKF/EqDF5jLD9KkETKWys0vZcmCxAFF4aFRbbxWkNLzMpyT/xyuS/jFNvO6Nwyr0hsPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n4jdFv39; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n4jdFv39"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4AMcBFn7ecJkhzB1pVjErh4DLv7K5pSZUcqMoJ1PnjY=; b=n4jdFv39ZSwlFg9De3cR2Doga2
	1DHOxNpKn2q58uBvVgPs3+y40Ku4wQ2ntkn+4zbSAne+t+jms7GrVi84dnBdskiRxhGygB2lNwwmU
	nZDzKpCEJBgOqEWG6EAPIYH9zVF9WJEKxVkQSnfRUk8HYGj3WJJtFZcwQ5Vju0tLRUDc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAxg6-007aLl-41; Mon, 28 Sep 2026 00:49:02 +0200
Date: Mon, 28 Sep 2026 00:49:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyou Xu <xuziyougm@gmail.com>
Cc: Gaoyang Wei <yhyxwgy@gmail.com>, netdev@vger.kernel.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC] net: towards a generic PON framework
Message-ID: <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
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

On Mon, Sep 28, 2026 at 04:29:00AM +0800, Ziyou Xu wrote:
> Hi Andrew,
> 
> I think I skipped over an important layering detail in my previous mail.
> 
> An OMCI PDU does have its own protocol header, but on the wire it is carried
> inside the PON transport framing. That lower layer is also where the
> management channel is separated from normal user traffic.
> 
> A little terminology may help here.
> 
> The OLT (Optical Line Terminal) is the operator-side device, while the ONU
> (Optical Network Unit) is the subscriber-side device.
> 
> A PON is point-to-multipoint:
> 
>                          OLT
>                           |
>                     passive splitter
>                    /       |       \
>                  ONU1     ONU2     ONU3
> 
> Downstream traffic from the OLT is physically broadcast through the splitter
> to the ONUs.
> 
> Upstream transmission is shared in time. The OLT assigns transmission
> opportunities to individual ONUs, which then transmit optical bursts in
> their granted time slots.
> 
> For GPON, the transmission convergence layer is called GTC, and service
> traffic above it is carried using GEM, the GPON Encapsulation Method.
> 
> For XG-PON and XGS-PON, the corresponding layer is XGTC and service traffic
> is carried using XGEM.
> 
> OMCI is the ONU Management and Control Interface specified by ITU-T G.988.
> 
> OMCC is the ONU Management and Control Channel, the logical GEM/XGEM
> connection over which OMCI PDUs are transported.
> 
> PLOAM is another management mechanism at the TC/physical layer. It is used
> during activation for things such as ONU identification, ranging and
> assignment of transport resources. PLOAM and OMCI are separate protocols.
> 
> So, very approximately:
> 
>                  service plane        management plane
> 
>                   service SDU              OMCI
>                        |                     |
>                        |                  G.988 PDU
>                        |                     |
>                        +----------+----------+
>                                   |
>                               GEM / XGEM
>                                   |
>                               GTC / XGTC
>                                   |
>                               PON optical PHY
> 
> For GPON, a GEM frame starts with a five-octet header.
> 
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
> 
> A GEM Port-ID identifies a logical connection; it is not an Ethernet port
> number. Normal service traffic is transported on service GEM Port-IDs, while
> the OMCC is transported on a GEM Port-ID assigned for management.
 
Another question which might affect the architecture. From what you
have described, an ONU might be assigned multiple Port-IDs so it can
carry multiple, separated, service traffic streams? You would want to
represent each stream as a Linux netdev, with its own IP addresses
etc.

This again made me think of 802.11 in Linux. I'm not too familiar with
it, but it has the concept of a wiphy, which represents the lowest
levels of the hardware. You can then instantiate clients & access
points on top of it, each being a linux netdev. They are share the
same lower level, all need to use the same frequency, but you can have
multiple clients connected to multiple different AP, or an interface
offering multiple access points with different SSID, or both a client
and an access point, which when combined would make a WiFi extender
etc.

You might need something similar, an entity which represents the lower
levels of the ONU, and then you instantiate netdevs on top of it as
dictated by management.

     Andrew

