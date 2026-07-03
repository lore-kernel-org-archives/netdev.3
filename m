Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA032E729;
	Fri,  3 Jul 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084332; cv=none; b=r2UAJ5l511HG9gGgxiLkdRzPWRMDmQgrjnxnHYBP3/GYmh3IK+LAGwlLdmy4N6fbXh5CAkjf+ddrnEhyFBA50BVkbdrKlhw6o2hiP4fNpK/vdL4UbQLoOWtEcZ2NMz8HzdHcvIeQyjyEhx/YMzsprHDLiitjb0HFCIZ0eWRXSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084332; c=relaxed/simple;
	bh=Z/2Hnfc9GB/OzugUkItSrufn1TDkO6pWeaSjkfUWplU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4pjAYVQctKWq+SAi6/khYVTL0Q5BsfMPCQyWFvAtQX6Lu4SClXui/YfhBKSjOGkbb6KF/g38GMnT84kpWwe6cVD/JZuKHvt4auQPLCVLbh+XOUf9qkSi5Htc1IxvOKu1Td9vuW3NC48W4UWHD9O5YrO0jQLbrB7sj3+TfW5Bp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zyOXNe7e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zyOXNe7e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Y2MPRqkyRTH14QDFfn7C5hyRL84ni46rfcjThNuG8gw=; b=zy
	OXNe7enBL7WJDeN2aiPcHmlb5eLtMLuRE/p5xz5u3N3rebEjIzZ3X5gBn9Jejpb3BQxiFtJY5vzN9
	nSl14zAnUCJz7XSx+u7QqMftzrzkCRGlbWerphQYl1Um8wFA/2fGuPXEHa+bX/2L21aBSX++LsnkE
	8sZbOQC4HlAXbB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfdgW-00AYBV-MI; Fri, 03 Jul 2026 15:12:00 +0200
Date: Fri, 3 Jul 2026 15:12:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Nazle Asmade, Muhammad Nazim Amirul" <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Message-ID: <bf7c6343-e0c0-47bd-a857-0f1881fc8659@lunn.ch>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
 <347c50ed-234a-4f29-b63a-1e0010c6b09d@altera.com>
 <e4cf8d95-0467-4bdc-8e19-228ced3a8bbc@lunn.ch>
 <5a0c962e-1af0-4d6a-b871-d8a0b0197ff5@altera.com>
 <d70a6795-e1a2-43e2-b523-0fc668324674@lunn.ch>
 <b8ca3bd8-af8f-43e7-904c-1ac45512296b@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8ca3bd8-af8f-43e7-904c-1ac45512296b@altera.com>

> >> The delays are provided by the FPGA GMII-to-RGMII converter soft IP,
> >> which is hardcoded in the FPGA bitstream and cannot be disabled or
> >> modified from the driver side.
> >>
> >> Using phy-mode = "rgmii" is intentional here — it prevents the PHY from
> >> adding its own internal delays on top, since the FPGA converter already
> >> provides the full required delay. This is consistent with how all other
> >> Agilex5 SoCDK board variants are described, as seen in commit
> >> c5637e5ceb4b ("arm64: dts: socfpga: agilex5: Fix phy-mode to rgmii as HW
> >> provides clock delay") already in Dinh Nguyen's tree, which applies the
> >> same rationale across all Agilex5 boards.
> > 
> > I've become more insistent that designs get this correct. So i don't
> > care too much about past systems. Many vendors are having to fix up
> > their drivers and DT in order to make new boards consistent.
> > 
> > You can look at your system as the FPGA being the MAC, and the PHY is
> > the PHY. The PCB is not providing the delay, the MAC is. This exactly
> > fits the description above.
> > 
> >       Andrew
> Hi Andrew,
> 
> Thank you for the clarification. We agree with your framework in 
> principle, but would like to explain why phy-mode = "rgmii" is the 
> appropriate description for this specific case.

So you want to be different to every other system? Please extend the
text in that document to say that this device is special and has a
different definition of phy-mode to all other systems.

> After getting more information from hw team, for Agilex specific device, 
> the RGMII timing delays on this board are provided by an FPGA delay 
> chain (Input/Output Delay Chain primitives in the FPGA fabric). The 
> reason for using the FPGA rather than the PHY is that the Marvell PHY on 
> this board only supports 0ns or 2ns delay steps — too coarse to meet the 
> RGMII timing requirements. The FPGA delay chain provides up to 63 steps 
> of ~0.1ns precision, which the hardware team has tuned at design time to 
> achieve correct signal timing.

As the text says, fine tuning is different. You can have fine tuning,
in both the MAC or PHY, while using either rgmii or rgmii-id.

Also, you cannot fine tune just the MAC, tuning needs to take into
account the PCB design, the length of the clock and data tracks on the
PCB. You can however take into account the difference in timing within
the FPGA.

Or does your FPGA team produce a different bitstream per board design,
after some sort of calibration in order to determine what the PCB
characteristics are?

This however opens up a new possibility. It does sound like you can
produce a new bitstream with the delays set to just the tuning delay,
not the 2ns + tuning? You need to decide if this is simpler than
changing the MAC driver to mask the phy-mode.

> Changing to phy-mode = "rgmii-id" and having 
> the driver strip the delay before passing to the PHY would produce the 
> same hardware behaviour (PHY adds zero delay), but would add driver 
> complexity with no practical benefit, and would misrepresent the FPGA 
> delay as a driver-managed MAC delay when it is actually a fixed, 
> board-level hardware calibration.

Look at the wording again. It does not say it is driver managed.

# There are a small number of cases where the MAC has hard coded
# delays which cannot be disabled.

This exactly fits your situation.

> Could you advise if you still prefer the rgmii-id approach given this 
> constraint?

rgmii-id is the correct value for your PCB design. Please follow what
the text says.

	Andrew

	
