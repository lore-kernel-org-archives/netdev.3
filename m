Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F834106A;
	Fri, 20 Feb 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594771; cv=none; b=BL7Og5X7Dw1fzN8g1QMzinJEz8dexm4L3oQcIL+w4iu4A4o5WnXGfHNYLX/y0ZrUTIcifQGqari05ZPOm2gHdlceHS6/ow6SBbypxk5CAoFKYnLI5L83GbNBvhLN7Oabw7iSDr2IvHRlQg9erPfIZpbGjC3+xZrmiIOvj1PYJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594771; c=relaxed/simple;
	bh=Hb99LbuCtvboHljxjmx4TrTSxvQBnzgYOLiNoYjfCZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzTNpJzD8NPQPQjhRHH+PS9PC9lVeOJQAtJ6fZijRRVOdvBq0MotfbruXxAFmrDieXc899czfM0/fqZEsSUqC4TVhg9IZOcCKgRFtDoGnJlIwRLMonYtgb1OJkp65MzXzlTL1EgjC0IdkFopi/MT5xfQrDuBh4K68s1he4E12tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iRtZhjJo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iRtZhjJo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uYS8MGw1rvpKx7e8kOPpBhMRoCVxRnVWUywb9QjDvXc=; b=iRtZhjJokINZqNDYn8LXLx0JxX
	GruzK4SQj0kVJix3KOMS8iCLen32wd6uS5etM2V5Sx5ZjSQzrO6Pfpc3H8AQh/ryThQjFsPCW8OL9
	Q8UckK50QD7n+VomIKSFZMiMG/1Qy/ONzYRIZAVhLhD8TDv3/+y4DSilk6EU7BiOOCZo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtQj4-0084bV-O7; Fri, 20 Feb 2026 14:39:22 +0100
Date: Fri, 20 Feb 2026 14:39:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Neeli, Srinivas" <srinivas.neeli@amd.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC PATCH 1/8] dt-bindings: net: Add TSN Endpoint Ethernet MAC
 support
Message-ID: <36492eda-a332-4dc8-abd2-99be88f7d06e@lunn.ch>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-2-srinivas.neeli@amd.com>
 <76c811a7-d081-4238-bf6a-0226e867560a@lunn.ch>
 <SN7PR12MB814702B7C9A28577A94FE79C9368A@SN7PR12MB8147.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB814702B7C9A28577A94FE79C9368A@SN7PR12MB8147.namprd12.prod.outlook.com>

> > > +        // Endpoint Node
> > > +        ep_mac: ep-mac@16000 {
> > > +            reg = <0x16000 0xa000>;
> > > +        };
> >
> > Except the Endpoint MAC does not have MDIO?  Or does it have an MDIO bus,
> > and you have simply not listed it?
> The endpoint MAC does not connect to an external PHY and therefore does not expose an MDIO bus.
> It is an internal endpoint, so no MDIO node is required.

It does not really matter if it is required. Does it physically exist?
Can MDC and MDIO be routed to pins? Could i hang an external switch
off it?

DT describes hardware. If the hardware exists, describe it.

	Andrew
