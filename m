Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EE32B101;
	Fri, 29 May 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061065; cv=none; b=OdYC6oR+uXkDkVs5Jaoi63koLUVl9FEdfaeskfUFoPaV0pEn60zPL8RiQMFMbevzXvPnzneUcgAQGY6daoomkt1BadEl4EIArtz5NHH0cVII/xM7tBfVTaG+33ItjqagqCl4h6N92YXEJrjyG1sGhPVcaEFHAK0GDGFPKXjytoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061065; c=relaxed/simple;
	bh=kpqrWy5SJxGkk6gpwUj5xUbEtnt/Vnw6m6pW0CCCkt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEjRzuJWWhokHgbUudNgp+prrkg6cdoTNFAL9a98dskvHMZdHh9FTbf6Yxo1uawi0/TPusjpQjPnnO/vRy4P38UtXOI2L9rL8f+Ke/Z6MHicmjs7Uqea73EQS0ajhnT3/v4c0/RLWBRN+4DcR2uYDXTUNjA0idet0540BndQToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PP/jxdQl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PP/jxdQl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L71W6lePAyQAQ0UNhTYqMway8i0hVWylqwd07SfHofk=; b=PP/jxdQlobh9WLawMPmB2tmvj+
	znBkUlplsuLpi4r5BbaqAdoMV+Nu150l9cv6Zc7pg5+sqPYCdnLnUK4zqPbvPc35CE3R5tkvTOUEg
	L8iBnQTzi5yLiMrmYTY0CPJdGIoNSamfcCUxh/YP0Axf5JekDwQAqeB9j2Z0krXWmGYg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSxCC-0055eJ-H6; Fri, 29 May 2026 15:24:16 +0200
Date: Fri, 29 May 2026 15:24:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: as21xxx: handle corner case with
 link and autoneg complete
Message-ID: <4a372acf-f916-4db7-a4d5-949e40e44098@lunn.ch>
References: <20260528193545.11160-1-ansuelsmth@gmail.com>
 <9d3729f0-8d2a-4b21-ae87-aaade72e388a@lunn.ch>
 <6a193a6c.0c2aff9d.3966d9.f87c@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a193a6c.0c2aff9d.3966d9.f87c@mx.google.com>

On Fri, May 29, 2026 at 09:04:10AM +0200, Christian Marangi wrote:
> On Fri, May 29, 2026 at 02:36:07AM +0200, Andrew Lunn wrote:
> > On Thu, May 28, 2026 at 09:35:41PM +0200, Christian Marangi wrote:
> > > Add missing case in custom read_link, when autoneg is started, autoneg
> > > complete bit is reset but link is still not up.
> > > 
> > > Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
> > 
> > If this is a fix, it should be based on net, not net-next.
> > 
> > Otherwise it looks O.K.
> >
> 
> Hi Andrew I didn't want to introduce patch conflict with the last patch.
> Should I split this?

Yes.

Post the fixes to net. On Thursdays net get merged to net-next, and
you can post the remaining patches then, after you solve any
conflicts.

    Andrew
