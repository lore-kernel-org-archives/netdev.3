Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60B3BFE3B;
	Tue, 28 Jul 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268714; cv=none; b=V7MGwAOCZxZDCjZQINxXStWvW/yGIYfYBHJVP7RkddWTXruxggvZsSd47Xt1q+TcJcOTfu24WJ0CAAByon8hpcn4ztx4C72Eb8kSA4VexVGM1qsSW39tlvsjF0bXpxUYLIAEmtqgrQG6/ZHHRUCu66tLtqIAgS0e2vgqqVxhX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268714; c=relaxed/simple;
	bh=IxjRhlA3KSpnHtWUSIZev47moP64zGnpMILZ6GTGAnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCUM0UbP2ITQZKNXuJMnbfv1K0DCiQqreTtEnshqbk4aIGmw7Bf8zwf+tpa6NOqrsQ8V6dfxsGjBDsZS+AdGvJX5sJJyybGRZLJoAZ5RDRls7D68SSMORidxsWxTYppZ/oe4XZ20q6SyW0SBv/PDTfkfNa2lHle6EAIGLsu4Y5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xXPQ0NnW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xXPQ0NnW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OfFq1viu7NZiAAD9wSwqftvnpVHny2A0Bk994MrfVPI=; b=xXPQ0NnW2TN8BE/itXafNEdIJh
	3k8TtoIQCUKeARdKrJHBx9gKbEAtWIirX8BKFnGCJ5qUtkgH8NUu+G7TTNGs6paAzDGgfdhg9lRim
	g0iqS3o6jFibn4iI3s29/ItETmZNhaQmToMDuxRMq5amUqV3+YZ/oxndJFvie55XDSUA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wonwH-00Eh4o-Qa; Tue, 28 Jul 2026 21:58:09 +0200
Date: Tue, 28 Jul 2026 21:58:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next] net: phy: micrel: Add loopback support for
 ksz9131
Message-ID: <34d64a88-f234-4449-ae21-d0250e86c77b@lunn.ch>
References: <20260728075222.956780-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728075222.956780-1-maxime.chevallier@bootlin.com>

On Tue, Jul 28, 2026 at 09:52:20AM +0200, Maxime Chevallier wrote:
> ksz9131 is configured for local loopback in a similar fashion as the
> ksz9031, with a need for full-duplex operation, but with some extra
> steps to take as specified in section 4.13.1 :
> 
> 1. Configure the following registers:
> - MMD 1C, Register 15 = EEEE
> - MMD 1C, Register 16 = EEEE
> - MMD 1C, Register 18 = EEEE
> - MMD 1C, Register 1B = EEEE
> 
> These 4 registers are marked as "Reserved" in the register map.
> 
> When setting loopback up without configuring these 4 registers, the PHY
> appears to shut its RXC down, which can trigger failures on MACs that
> require it, such as stmmac.
> 
> The datasheet does not specify to which state the registers must be
> reset when disabling loopback, so let's restore them to their measured
> initial values.
> 
> This was discovered when trying to use stmmac selftests on imx8mp with a
> ksz9131 connected in RGMII.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
