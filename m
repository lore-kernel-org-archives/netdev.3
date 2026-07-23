Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD837EFE8;
	Thu, 23 Jul 2026 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833471; cv=none; b=B9g1xZxZ1G0rUmz652Zh5gSktZozmNFAsILLocmo/9vr5f2meUUc+aaqAwLhEg8Q/+4DA+sUh1LNr14Grt1eIZQnvHNjewSr3bGVkL8SfxYLqncF288fCr4qt485loJsrxsH6cuJPpJWEB+QljFn4Aj2pPZw5JApYk3DGjrjRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833471; c=relaxed/simple;
	bh=DynKOM14cZ0Q0FoMi973bOIy39eBvkDY0PTF9KlI3wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQLCU5w3SW3Qr76Q9UQ7aFk5grXx9tK0tXlTLd6AlRJvXlKX+TUIbsouVkm/AsTja+Pb4a+IWZFogb7zhk07ui5D+F7gbKv0YUoAeQBLWE5jI8PhARUesQ2GgiOpKapyonPj3BbX174seIm4AScDo30iEe+o8lQNbg4h06/yWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YF+61bsY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YF+61bsY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LSQ3TmK6+uWISy9/POQp13YIfoaEQVzoY7e/Lh+j58I=; b=YF+61bsYgPDW4KjF9FdUHy4vWj
	X/VM+TeRxcb/1liIQTjfUl6bykI8FWqXhsvVcTZACXIi9xKj5hE1tWdABwMcPOWq/lCa1MJKhLTOq
	5HntlVJdQ2cKF44AFzhwwgq6f9uXE88EIAEHt4Ow8KQDxXDSSmG+HlPotjBl0G79cOnc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmyiJ-00DsJO-G7; Thu, 23 Jul 2026 21:04:11 +0200
Date: Thu, 23 Jul 2026 21:04:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 08/36] net: remove conditional return with no effect
Message-ID: <836a6044-beed-4372-a58e-68bde8e14c22@lunn.ch>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-9-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-9-ekffu200098@gmail.com>

On Fri, Jul 24, 2026 at 03:45:10AM +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
