Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECDF4F1;
	Wed,  8 Jul 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539980; cv=none; b=CUCQh9V4ewNP+sLTFUo00HGnhO8fcH7BWDEFWs1KkdudghWvLqaCeli2IhsE3tae6UubzbWjnc17Cu95oCpiNJkypZe71H/ZCwkhF07IRaoDc2U64IYPj99/FNo4AstT3WyKzCEr2Bc0DGLjHSXLp9C90G2eHUgWtl3PEnrSbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539980; c=relaxed/simple;
	bh=KXzvMMXAalFxrhgHFbpXE+QWseDaqEypD1jOwd1J6/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxn7aUO1MG6oiKx7RhnPXoJUBRgltIbzlaS82RFoskcbeh1RmZmXVB3cajkzcF3xdE6X2mYW4J3AZdggeHZYd3yjHWkEIL8qxqCFWa5p03p+SWQM7ChVk4K3EPq/5uTCzQWFZ8G6jPhFPIK5FHWnOis6voQyAGb2fNwYi0aSquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1whYDe-000000000js-2aC0;
	Wed, 08 Jul 2026 19:46:07 +0000
Date: Wed, 8 Jul 2026 21:45:48 +0200
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
Message-ID: <ak6o7Ovekjb_evPs@makrotopia.org>
References: <ak0KJ6gUk2l_IwoI@makrotopia.org>
 <96c362d3-59d2-43c4-b2aa-c12dfeb6fcca@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c362d3-59d2-43c4-b2aa-c12dfeb6fcca@lunn.ch>

On Wed, Jul 08, 2026 at 07:22:49PM +0200, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 04:16:07PM +0200, Daniel Golle wrote:
> > Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
> > SMDIO register access. MCUboot rescue mode only exposes clause-22
> > registers; the existing clause-45 MMD interface is unavailable during
> > firmware transfer. The MDIO bus lock is held per-transaction (not
> > across polls) so that SB PDI polling during flash erase does not
> > starve other MDIO users.
> 
> What other MDIO users are there? It sounds like once the switch is in
> rescue mode, switch management is dead. So how can there be users?

The MDIO bus lock refers to the host bus which is used to connect
the switch management interface. The same bus can also be used to
connect other unrelated PHYs (eg. to provide a WAN or management
interface independent of the switch).
Especially because this "other" interface can be used to connect
to the host via SSH and perform the firmware update on the switch
holding the MDIO bus lock may impact PHY polling and impair the
link used to conduct the update.
At least that was my thought when implementing this.
