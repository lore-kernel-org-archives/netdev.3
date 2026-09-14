Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD23603C0;
	Mon, 14 Sep 2026 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412974; cv=none; b=oWxzSvVNa67/3l1MQToE55hiOCdE8ekfOO9ev9xXBpkPeqvjL3JXarbTn8gGc6fZ/2sad3oGa2N1fhxm9o8zyuEKAMD0lOCir92RXoEerLj0feCwF81Mgvsb6UF0HwMtZViC9+TPeqLdA0/ERr77TMrfIXtwicmhC1J/7W43TWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412974; c=relaxed/simple;
	bh=1zwDoquw1Xtyx1Jl4TymiQcyC/FD70QsSBOmxX6cfNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxiW3nOEfEkdRRXW6NKsZoNo/o/Ob3O757mdRhxNDaV+f+Giwq0O8N3f4A73m8Mhux+ERrwfG7Mq+vALEKHEtYDlRNnogEU3v4kjdbF45Cj1gt6NZRFrO8w/nDzDPUwMIfoL5IGEbq559PZP/I7GfMiYi0gROkMSr1S0XjEKx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IeZtdKIj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IeZtdKIj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=D4zLCujqv+1kOWutlW4uiNHK+qNna0YPclsi/Y3yM/M=; b=Ie
	ZtdKIjbg5BuN8y55vYK7hiQtnXHwfgmZfYA4OLvyP0LQU3KB2YAUvAm9GTw4OahFAZhMD4spUtT9R
	/ZmwVh3ntCVZmBegRPLbRHCkGFd0nx0RXtRZeLHnpy0G+8IvIxwyqKa++wGDE+1x2WC9jZ8wQeJ4b
	O4JSu1LzdebrAu8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6C3F-0057sw-3i; Mon, 14 Sep 2026 21:09:13 +0200
Date: Mon, 14 Sep 2026 21:09:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ericwouds@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2 0/7] net: mdio: an MDIO device driver for
 the Airoha EN8811H
Message-ID: <f7ce35aa-2c3a-4f8e-9f99-e52367ff6bed@lunn.ch>
References: <20260908155707.4164559-1-f@lex.la>
 <44f163ed-8362-4aad-99c9-f8709dfbed76@lunn.ch>
 <20260910153757.2822676-1-f@lex.la>
 <20260910204916.1979445-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910204916.1979445-1-f@lex.la>

On Thu, Sep 10, 2026 at 08:49:16PM +0000, Aleksei Sviridkin wrote:
> Two of the things I said I would do turned out not to be doable as
> stated.
> 
> > It is fine. I would also add a select or depends on the PHY driver
> > Kconfig stanza to link it to the MDIO_AIROHA_EN8811H driver.
> 
> Kconfig refuses it:
> 
>   symbol AIR_EN8811H_PHY is implied by MDIO_AIROHA_EN8811H
>   symbol MDIO_AIROHA_EN8811H is implied by AIR_EN8811H_PHY
>   error: recursive dependency detected!

O.K. So there is a linkage anyway.

> > The location is fine. MAINTAINERS need to list it. What you might want
> > to do is list it twice, once in the PHY driver MAINTAINERS record, and
> > again in the MDIO driver section.
> 
> There is no PHY driver record to put it in. Neither air_en8811h.c nor
> the shared air_phy_lib.c is claimed by any entry, so the header sits in
> the MDIO record alone. I can add a record covering both files, but that
> puts my name on code I did not write. Tell me which you would rather
> see.

That not great.

$ ./scripts/get_maintainer.pl drivers/net/phy/air_en8811h.c
Andrew Lunn <andrew@lunn.ch> (maintainer:ETHERNET PHY LIBRARY)
Heiner Kallweit <hkallweit1@gmail.com> (maintainer:ETHERNET PHY LIBRARY)
Russell King <linux@armlinux.org.uk> (reviewer:ETHERNET PHY LIBRARY)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)

The usual generic suspects. Turning on some knobs you can additionally
get:

"Bjørn Mork" <bjorn@mork.no> (commit_signer:3/9=33%,authored:3/9=33%,added_lines:412/668=62%,removed_lines:34/318=11%)
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> (commit_signer:3/9=33%,authored:3/9=33%,added_lines:58/668=9%,removed_lines:258/318=81%)

Maybe reach out an see if they want to be listed as Maintainer.

      Andrew
