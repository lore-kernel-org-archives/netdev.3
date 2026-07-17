Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C537EFFD;
	Fri, 17 Jul 2026 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315937; cv=none; b=oqLbDUHMXUczPu/+pkz9OiSQlrDQx/mP3jH/bxKZ5KaN9JDbQLuY0sjMAX1CxzLJxYWch++wxPFAL02zVgi951rJ/udpV3JO6bx9BCye2Yq9arrSKrStQ+ARFCevFjKEv7qW3Mn0HjNVX/VY/65oUykmIVVPHoXaW28RiJ405oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315937; c=relaxed/simple;
	bh=wkXnemmiR2NuLfknO4oNGoYzWkWjI6KbUnnoVjNBqN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiLycIIUejZX/OtKSx+MErfJkpwrdV1QzKAUzgluZPZJW06EtmwOzY2MMpRA8qBWOwfTnUBO7heRBWiuMQIu5wVMjVgMQXD6Tqq0lteiqetvV26MsJquYo5cErcNuSjBPO6OL6NRq2P8tKk6OjHgTF7eehXPUNou3aTvAiAyxKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MVAIB6AK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MVAIB6AK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ynyse+JhrZVGDgcRZ5Ihrp8lJfrQnMFUeGXxTlrNVNM=; b=MVAIB6AKi/42He540nXDAipG5z
	xxIxO8YmqInz8qXi+9Yayil4X4e4rnuDAqSXSdYmOlaCZWADac9tJqgOWihKdkCKWZuvLiA0E9C2Z
	Q1U5700eSFveaAnqVW2KjLWXkQhfQIvGsSG/03+X8ykptB9BFXtUr5MzIC3XHFkQmAaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wko4z-00CrUr-Fc; Fri, 17 Jul 2026 21:18:37 +0200
Date: Fri, 17 Jul 2026 21:18:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <a4a6b079-5b9c-4434-8222-2c402de3dac4@lunn.ch>
References: <cover.1783988826.git.daniel@makrotopia.org>
 <5d1614d1cd6b99bf0f0635c6370bbed10736a7fa.1783988826.git.daniel@makrotopia.org>
 <alaKsBXSK9tP__O8@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alaKsBXSK9tP__O8@makrotopia.org>

On Tue, Jul 14, 2026 at 08:14:56PM +0100, Daniel Golle wrote:
> On Tue, Jul 14, 2026 at 01:51:02AM +0100, Daniel Golle wrote:
> [...]
> > +	if (!of_property_read_string_index(ds->dev->of_node, "compatible", 0,
> > +					   &compatible)) {
> > +		ret = devlink_info_version_fixed_put(req,
> > +						     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
> > +						     compatible);
> 
> Review of the fwupd counterpart of this series[1] made me reconsider
> what the driver reports as the "asic.id" fixed version. The devicetree
> compatible string used here ("maxlinear,mxl86252") turned out to be an
> unfortunate choice as the comma is awkward for userspace consumers, so
> for v3 I plan to follow the mv88e6xxx example and report a chip name
> from a per-model info table instead:
> 
>   fixed:
>     asic.id MaxLinear MxL86252
> 
> Before sending v3 I would like to clarify the preferred format of the
> value. Existing implementations differ: mv88e6xxx reports for example
> "Marvell 88E6085", including the vendor name and a space, sja1105
> reports "SJA1105E", hellcreek reports "hellcreek", and bnxt and ionic
> report bare chip identifiers.
> 
> Documentation/networking/devlink/devlink-info.rst only describes
> "asic.id" as "ASIC design identifier" without any format constraints.
> 
> Userspace builds firmware matching identifiers from these values, in
> the case of fwupd for example
> 
>   MDIO_BUS\COMPONENT_fw&ASIC.ID_MaxLinear MxL86252
> 
> and while a space works there, such identifiers commonly avoid spaces
> in favour of underscores, hyphens or dots.
> 
> Is there a preference for new drivers? Should the vendor name be part
> of "asic.id" as done by mv88e6xxx, or would a single token such as
> "MxL86252" be more appropriate?

I would say it is a Wild West, and you can put anything sensible here.

  Andrew
