Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BC2DF142;
	Fri,  6 Feb 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393341; cv=none; b=PcYUQIJmf0CusmA/euE2VqvD1Rzm9FNiXHhctrX6kh65meoa3q+vaGDTFAtVHTbjjUl64kZgwcrGL6zyu5X/X8DVf1jC/TV0KObwvOilv18BOYF7kI4kVnUXFwwnCVmgACIFD9XLPdHaZrvrceywRgTOmojqqpabgY1ck4Z3tTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393341; c=relaxed/simple;
	bh=BG/jYCq2c+C+hwE5+iOfS8xZ1FSUF8zGigGcPKQ/Gl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3ieKybJUcpq+3oHlSZWPHYDWB56mKyPGaTVeIJ0XoEW2xzKa5BQAAaeQwhFwcTL3hCfZ4btYjJcGv/4CoIXJYD9IB4SeV2jLiS5K474ZWYCxiq18PUfrjoiSyj7NuMCiX0iGtZZ/Ba2G4Gt0xy+3LNk5Js5jkjditr62AjP7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5t5dqUK9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5t5dqUK9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ehd/KH3vEh7sF6Tn03NhG8bTXyjL4hvfCcSCzjI/vPQ=; b=5t5dqUK99SCAB7KcsizbQ0gd+y
	PKAlOF1uLEp8PB4QeQ6qtL0sZy++D810WxSUIE18VwqqopAvDJxtVsrYxKsXcOamlJtohkuqTcr+5
	HQarlpUObntAa4Alc8vIzo4GOo+/2Zdln+xYs2Sod08ZbaIObE096JiL7LYAhvUL9O4o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1voOB8-006Ok4-H1; Fri, 06 Feb 2026 16:55:30 +0100
Date: Fri, 6 Feb 2026 16:55:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Michael Dege <michael.dege@renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
Message-ID: <38e09d91-c514-4090-8e31-1709073b237a@lunn.ch>
References: <d6a9356d-6fd4-459b-9c5a-2f3e20368bbd@cogentembedded.com>
 <TY4PR01MB142829D9748A483ECAF19FD3D8299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <25ff0841-545b-433a-8e88-6e463ea718e7@cogentembedded.com>
 <TYRPR01MB14284CB75C7DCD35381BD17EE8299A@TYRPR01MB14284.jpnprd01.prod.outlook.com>
 <237bee8b-a7cf-4c14-9946-8bf72dbddde5@cogentembedded.com>
 <TY4PR01MB142829EB0EDDE13B588F949298299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <a4cfeba2-23da-4fdd-870b-6533b5ce267c@cogentembedded.com>
 <5b8bcf37-5cd0-4c32-b0ba-3386142b7795@cogentembedded.com>
 <TY4PR01MB142820FC29E751D8C7F0B7C348266A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <1aa615e2-1297-40a9-b7c4-beb943996721@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aa615e2-1297-40a9-b7c4-beb943996721@cogentembedded.com>

On Fri, Feb 06, 2026 at 11:34:24AM +0100, Nikita Yushchenko wrote:
> > Unfortunately, your argumentation is very _academic_. There is _no_practical_reason_, not to
> > forward the traffic to the SW bridge via the HW bridge, even if only one link is currently up.
> 
> The very practical reason not to forward packet to SW when it can be handled
> in HW is - reduce SW load. SW cores have no chance to handle the load if you
> forward everything to SW at the channel speed.
> 
> The very thing I was trying to achieve when working on this offload support
> was - detect the case when a frame can be processed correctly in HW, and let
> it process it in HW, without notifying SW. And send frame to SW if and only
> if it is not possible to provide correct processing without that.
> 
> But this does not directly affect the case being discussed.
> 
> When there is only one port with enabled HW forwarding, there is no effect
> of keeping HW forwarding enabled, because the allowed destination mask
> computed nearby does not contain any destinations. Forwarding to CPU port
> was never handled via L2 forwarding (*), because L2 forwarding on rswitch
> requires explicit adding any possible destination MAC to the L2 table -

Are you saying this switch does not do address learning? In general,
or just not for the CPU port?

DSA switches handle the CPU port in a few different ways:

* They do address learning, so learn what MAC addresses are in the
  direction of the CPU from the traffic sent by the CPU.

* All frames with a destination MAC address not in the address
  translation unit get sent to the CPU. This is sometimes implicit,
  the CPU is included in the flood for unknown MAC addresses, or there
  is an explicit bit to enable this.  The software bridge will then
  handle the frame. The reply, if there is one, should then trigger
  address learning.

* The switch driver taps into the events the software bridge issues as
  it does address learning. This allows the switch to setup its
  address translation tables to mirror the software switch.

The overall result is that having just one switch port in the bridge
is no different to having multiple switch ports in the bridge.

	Andrew
