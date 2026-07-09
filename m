Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607483F1AC9;
	Thu,  9 Jul 2026 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590293; cv=none; b=iGnQLpzr7t5dTfenVJB6mAGqN/YemAtI/btCh1/SaSpnYFRrU8rhYoYjXK+tymBAZtdBVvCGqcDwbSofJ/ghFDBPLNe6H9PwkUo0vBk1Uh/N4+j5RehNr/06J6rElC5D+dNV3mcpQCvFksTfWv9B4f1EZl0OvLG5GlAQEZDVvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590293; c=relaxed/simple;
	bh=7Ou5+3G75tDZu799wGoMAdBW6+Fh+b5nNnd6FitkyyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWAsNTNtOU0n6RZ0d7Yiuty13CBUFfE0oKJP4VoeWybMCnvn03sCEkaMsqe3u6t2+UzhR9JDY4/HO4oH76KSq/49wsDY3SoGBYshfkFTBBcB6nmZXC5dEVZIvbHLLGrCjHNfBgDw+NHpv8v3lA3lZ7SuCZiPj8F+lnSX6OCU5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1whlJJ-000000005VW-1BkQ;
	Thu, 09 Jul 2026 09:44:49 +0000
Date: Thu, 9 Jul 2026 11:44:41 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <ak9tiW0qnq2veYw6@makrotopia.org>
References: <ak0KJ6gUk2l_IwoI@makrotopia.org>
 <96c362d3-59d2-43c4-b2aa-c12dfeb6fcca@lunn.ch>
 <ak6o7Ovekjb_evPs@makrotopia.org>
 <98505e14-d684-4225-9415-f4d872113998@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98505e14-d684-4225-9415-f4d872113998@lunn.ch>

On Thu, Jul 09, 2026 at 01:15:34AM +0200, Andrew Lunn wrote:
> On Wed, Jul 08, 2026 at 09:45:48PM +0200, Daniel Golle wrote:
> > On Wed, Jul 08, 2026 at 07:22:49PM +0200, Andrew Lunn wrote:
> > > On Tue, Jul 07, 2026 at 04:16:07PM +0200, Daniel Golle wrote:
> > > > Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
> > > > SMDIO register access. MCUboot rescue mode only exposes clause-22
> > > > registers; the existing clause-45 MMD interface is unavailable during
> > > > firmware transfer. The MDIO bus lock is held per-transaction (not
> > > > across polls) so that SB PDI polling during flash erase does not
> > > > starve other MDIO users.
> > > 
> > > What other MDIO users are there? It sounds like once the switch is in
> > > rescue mode, switch management is dead. So how can there be users?
> > 
> > The MDIO bus lock refers to the host bus which is used to connect
> > the switch management interface. The same bus can also be used to
> > connect other unrelated PHYs (eg. to provide a WAN or management
> > interface independent of the switch).
> 
> Thanks for the explanation. Maybe 'does not starve other non-switch
> MDIO users'?
> 
> I've not got to the rest of the patch yet, but i wondered if phylib
> might still be trying to poll the switches PHYs.

The driver takes down the CPU ports and thereby implicitely also puts
all user-ports into admin-down state, effectively disabling PHY polling
until the switch comes back and reprobe has happened.
