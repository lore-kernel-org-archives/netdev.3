Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C5E30DEDC;
	Sun, 23 Aug 2026 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787498423; cv=none; b=Eew1nzu3n6mtvdT9njBZTNrwphbDUH1LrFMI0EEAyzBOAXixRXXCz0ACLj85NWfl0sIdh0QGhKUpjjs+86FjbTbvSjLN5E1ENUsLth6MUHqpto/K5oIlOzX3qmL2iWog9ANLBK3384Xs7Ux9W2sYOj+uR2ZkUvl4iEoE0sAMcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787498423; c=relaxed/simple;
	bh=U/2EVVSqc6UaAFmmIQSjkhqRLdgmUBoMcbB+TWfiQ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY5I+6T/HQLLvNcN5oHzK9pTfZK0B4MmuKghxhyBoxN2c+VFM5lpyaswVmjj429QSetPkGk5XKGJZJNeZY587MsAK6UGIKe3AJ1gd8sRJw7SPf5lxHUTfWlqACl/cI/gmfeezj/c/pJ++u7e4Juf17t80yD7oPmNzVOKhLtNrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aWPYAPfM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aWPYAPfM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IF0e+/ogV8XGdn84iopTOnNrKlY/M8FLVrcqVbBiYd0=; b=aWPYAPfMq1pe23Ljzp8hN5sdai
	bXArGEprCmrW57YdSx8e/HIvPxxJe5es6eJaezziIsyyn3IR/d1XlNUpfi3U4ox1A723/94mcjPOx
	BBxKenGa6kvUrZr4UPHxqDwJqPZGPSvIXzlGcmFTZy28O1BzS5lNvqVtiA1HvGIH81pk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wy9zU-0018Uv-OI; Sun, 23 Aug 2026 17:20:08 +0200
Date: Sun, 23 Aug 2026 17:20:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: connect a late-arriving PHY at
 ifup
Message-ID: <eec9896e-9350-40f9-a91f-03ba918cc8fd@lunn.ch>
References: <20260822155259.87146-1-f@lex.la>
 <20260822155259.87146-4-f@lex.la>
 <9557daed-f039-434a-ae64-ac849b9860be@lunn.ch>
 <20260823000549.6095-1-f@lex.la>
 <c712cd5d-d4bd-413f-82a8-6303ff3e6526@lunn.ch>
 <20260823123729.74290-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823123729.74290-1-f@lex.la>

On Sun, Aug 23, 2026 at 03:37:29PM +0300, Aleksei Sviridkin wrote:
> > How about making the DSA driver depend on the PHY. That would be much
> > simpler.
> 
> I worked through both halves of that for OpenWrt, where one kernel
> image serves every board of a target, so every kilobyte lands on all of
> them.
> 
> Built-in: the PHY driver itself is cheap, under 8k of text and data on
> arm64. The firmware still lives on the rootfs though, and a built-in
> driver probes from an initcall, before mount_root(), so blocking in
> config_init() until the firmware shows up deadlocks the boot. Putting
> the firmware in the kernel image costs 144k on every board of the
> target, and almost none of them have this PHY.
> 
> Modules: that works, and the kernel gets smaller. OpenWrt already does
> it elsewhere, kmod-dsa-mv88e6xxx depends on kmod-phy-marvell. What
> stops me is that it moves the switch driver out of the kernel for every
> board of the target, and NFS root goes with it. That is a bigger change
> than I want to push on my own, and it gives up the case you asked
> about.

Another option is move the firmware download into the bootloader.

Going back to the big picture...

My opinion is that moving the binding of MAC to PHY into open is
wrong. We should be building on phylinks support for hotplug of SFP
modules.

But i've not yet figured out how that would work. I need to think on
it for a while.

   Andrew
