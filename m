Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA68322753;
	Wed, 18 Feb 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431719; cv=none; b=Qkv71QuAqPgY1qLqGB8iV2eAew4xbZ6DqlXot2ztcvc5Nx3GJO62pDIE6uxatu+EFSGlDi2kwECmO4bmuG4gF0fEV2UWWKTcZsteKgM9hTbVs9TWWipitfTz8tNBe1Wwn3x2TQTIhc/64sZwSfgcv7oNjxyfWSh5PTAfCv4M/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431719; c=relaxed/simple;
	bh=gcLhJZxqBfiQRlzXedpNtp/J111FdMLE/KTjHoZ5fdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCunNr/GQJLNPPN66/werDFEd0rdLoGY/J1TYhV/zphWm911c9Te9T9PSYLT6N0PQR8mj9RNv1oKhP2CjsdxNhU9JJOBWSYKoHtUDIwiNpShwHIFnuziHKM1NJK4ezMfRp8OVRDtZkbtfJfnM58DBzRSGaZ/5GEvL5LPNZye+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q155NiRN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q155NiRN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kjPRey7Rf5pPYo4Tb7Jv/NvV+NVfKybMBXtMIOkmVl0=; b=q155NiRN9pTz43oy1poxQGM26P
	cklvFMyCbAUiMfdMQfekobrP7pRHmfb2aB2zz0uTRpBAAqz3Rnz4aICoJ/MuNkU0YBFh4K/VIFNzr
	8CuGnr2HcJCFP/avhQyYypEajheOu8TSwLvSBnzLRroCe9lRttokL1sX0bqlSan08uIrPu0PAbvJU
	Mhh6OjDuXGvx57QQLvg9nWGHsdWlHff61Nrrr6ev3vzoeXlOUE80tOYB1atlOriKg26fxjEEmK+Rw
	4UUTmadw0dCW+97teQQO/UUYWPJ2Pr6bdCXOKOXrHKKoYaJBLhBvoOsKpkRzeVlCQqfHskHXmyXQi
	qwun9Jkw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39076)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vskJH-000000000E7-1hw6;
	Wed, 18 Feb 2026 16:21:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vskJG-000000002NL-06OZ;
	Wed, 18 Feb 2026 16:21:54 +0000
Date: Wed, 18 Feb 2026 16:21:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: sja1105: protect link replay helpers
 against NULL phylink instance
Message-ID: <aZXnIVpaetfHn0Nv@shell.armlinux.org.uk>
References: <20260218160551.194782-1-vladimir.oltean@nxp.com>
 <20260218160551.194782-1-vladimir.oltean@nxp.com>
 <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
 <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
 <20260218161037.a4uyxtku2hbsnfzx@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218161037.a4uyxtku2hbsnfzx@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 18, 2026 at 06:10:37PM +0200, Vladimir Oltean wrote:
> On Wed, Feb 18, 2026 at 04:08:17PM +0000, Russell King (Oracle) wrote:
> > On Wed, Feb 18, 2026 at 06:05:51PM +0200, Vladimir Oltean wrote:
> > > There are multiple levels at which this could be avoided:
> > > - add an "if (dp->pl)" in sja1105_static_config_reload()
> > > - make the phylink replay helpers NULL-tolerant
> > > - mark ports as DSA_PORT_TYPE_UNUSED after dsa_port_phylink_destroy()
> > >   has run, such that subsequent dsa_switch_for_each_available_port()
> > >   iterations skip them
> > > - disconnect the entire switch at once from switchdev and
> > >   NETDEV_CHANGEUPPER events while unbinding, not just port by port,
> > >   likely using a "ds->unbinding = true" mechanism or similar
> > > 
> > > however options 3 and 4 are quite heavy and might have side effects.
> > > Although 2 allows to keep the driver simpler, the phylink API it not
> > > NULL-tolerant in general and is not responsible for the NULL pointer
> > > (this is something done by dsa_port_phylink_destroy()). So I went
> > > with 1.
> > 
> > ^^^^^^^^
> > 
> > > v1->v2: select option 1 instead of 2
> > 
> > Given this, I think the paragraph above needs updating.
> 
> Sorry, I don't understand what needs updating.

Oh, you rearranged the options, which makes this changelog comment
wrong. You're still going with option 1, but you've swapped what was
option 1 and option 2.

So, the changelog comment should be:

v1->v2: implement option 2 in the original submission, swapping their
  order so it becomes option 1.

since "select option 1 instead of 2" is ambiguous (obviously) because
it doesn't state whether these refer to the initial patch or this
patch. I assumed they were referring to the options on this patch,
that the options hadn't changed, and thus "So, I went with option 1"
was an error.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
