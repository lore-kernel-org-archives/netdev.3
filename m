Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63C13EFFDE;
	Thu, 18 Jun 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781030; cv=none; b=s6w18yr+VVMU7VAIEI7irwTqU9HVVz12L8aVvdmISSCq0FQkT9miOC1H7h6ovy7FCy1m10dydbobund0ZJx9JYQ1zTejChfXCjAQE5QbDXCBBToswfN4y+QLhHvHSBEw9NlS6Lb83ZAW9RpltoFWrtsXqG5h3yNxsOa/UJbANaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781030; c=relaxed/simple;
	bh=HoWGg0zTkUVqatGc0aka4gH64j/XDMTTpDicJojGanI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx8buaDXRQ4AO4YFaTp0kufaXz5cen5lKtAduqQ4WhD0K59Te9AIIlh2fXdMqXp5K9gZDHLsD4oGbTtwCYqePfA4JrjgdLtMpi73gmYbAUdGCL0kgqc76Q/jz/3hLEki6GfT0yTFgtRCBj7r7brp/O8iHZOVX34y67/7lYzqXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hn8OzFpn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hn8OzFpn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mls5Y4yVbiDGrtnf2pIJszG8YFMj0EE0dZopTEJKai4=; b=hn8OzFpnX82IHyQ9mFH+jhxsh5
	gv8ZlbUS4cmhesbFYeTyVwJvyvLYBvyXJ6+yGqWQqLGROC+b6UgEDpRL8i9daIUbqttHSGZyV56go
	O+sRHanQRzQNH+YPFKzqAXg+2LoVREAP0GkAFlziRN3fut2SniuMhJ9L3ocmZMKSkreo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1waAdT-008KaN-Bi; Thu, 18 Jun 2026 13:10:15 +0200
Date: Thu, 18 Jun 2026 13:10:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	de.ge@motor-comm.com
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
Message-ID: <5604c06c-0db8-49dd-bc89-823761f49082@lunn.ch>
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
 <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com>
 <a689a734-bfd2-4e8f-85dd-9ae210b3161a@lunn.ch>
 <39b79f5b-3e13-4620-83ba-b2ef991acca9@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b79f5b-3e13-4620-83ba-b2ef991acca9@motor-comm.com>

> >>>>  #define ETH_P_QINQ1    0x9100          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>>>  #define ETH_P_QINQ2    0x9200          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>>>  #define ETH_P_QINQ3    0x9300          /* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>>> -#define ETH_P_YT921X   0x9988          /* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>>> +#define ETH_P_YT92XX   0x9988          /* Motorcomm YT92xx DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>>>  #define ETH_P_EDSA     0xDADA          /* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>>>  #define ETH_P_DSA_8021Q        0xDADB          /* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>>>  #define ETH_P_DSA_A5PSW        0xE001          /* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
> >>>
> >>> UAPI stands for User-space API. Do not change it unless there is a
> >>> very very good reason.
> >>>
> >>
> >> Ans: The default tpid both yt921x and yt922x is 0x9988. I have modified this to 
> >> allow for simultaneous use in both yt922x and yt921x scenarios.
> > 
> > As pointed out, this is UAPI. Any changes to this file need a good
> > explanation how it does not change the user API. Do this break
> > backwards compatibility with user space applications? Maybe tcpdump or
> > wireshark has a dissector which expects ETH_P_YT921X and you have just
> > broken it?
> > 
> 
> Ans:Now I have a better understanding of the role of the UAPI representative. 
> If a new dsa driver is added in the subsequent patch, consider adding one instead of modifying the original content.

Or just use ETH_P_YT921X.

> yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
> {
>  u64 mask64;
>  u64 ctrl64;
> 
>  mask64 = YT921X_VLAN_CTRL_PORTn(port) |
>    YT921X_VLAN_CTRL_PORTS(priv->cpu_ports_mask);
>  ctrl64 = mask64;
> 
>  mask64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
>  if (untagged)
>   ctrl64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
> 
>  return yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(vid),
>      mask64, ctrl64);
> }
> 
> after patch:
> 
> yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
> {
>  struct yt_port_mask member;
>  struct yt_port_mask untag;
> 
>  member.portsbits[0] = BIT(port) | priv->cpu_ports_mask;
>  if (untagged)
>   untag.portbits[0] = BIT(port);
> 
>   return yt_vlan_port_set(priv->unit, vid, member, untag);  // Here we use encapsulated interfaces to complete the hardware configuration. 
> 							     // We can ignore the differences between different motorcomm series, which will be reflected in driver/net/dsa/motorocmm/switch/yt_vlan. c
> }

Look at other DSA drivers, e.g. mv88e6xxx, ocelot. They have
structures like ocelot_ops and mv88e6xxx_ops which abstract the
differences between different families.

	Andrew
