Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF63CB2D2;
	Fri, 24 Jul 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911506; cv=none; b=RYY57ROfKcZcziWIcKaTpfJ0NJlam29uJ0SXpI/a0SrJbFMUELj6ddWF0ei7IAPePRhVusNUmxbBNXVwlbR3JseE8nJ6yubnLd14/zDGralfxNUZFaJLzGC56t+d/aASfW7Zz4xUzyuRDSfEQbs8TyIPGDIeaiCbfBO5Ax/ED5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911506; c=relaxed/simple;
	bh=TbFYv9oTn0NcF+/PjkHljZGt9vBbdOpjXbv9DePxnm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlvnVJ1FvcwcPGqpJwhx6i6DtY/29o/+lBQdgrEX6DWXE6AEK69bwDSRyrwb5Y61P52Vkfop0a5BUtorXMQhAhOgMOtaX1OMBsy2IizwBXxjb2vURcYh9kpouaf5+/i2ybrDhbr11qn9UjUGu1z1KNcyWoJW1Vs9tukGsxemPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yB/sdqJ9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yB/sdqJ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Q4y30N8l5fMyyH7n2+nBB+EeIwA2Fy6Mz35y+qQ0gs=; b=yB/sdqJ9VUBH4wjdR7k1aBS9Ie
	8BLAaMbl3c+lHh3GM2ku/fMJ6MjsPqDm3e2j21Ax04i3I2QrnQjgx7C5tL+rgNyiebIWvr6MExg5n
	vnRvt+caKqRjtdB7vdg2A9GdYJrVRKUhRKWcbOTXRS/dfUPHxbk6ObpVc6iXKlZE71lc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnJ13-00E1jD-Lt; Fri, 24 Jul 2026 18:44:53 +0200
Date: Fri, 24 Jul 2026 18:44:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/13] ax88179_178a: Use MMD accessor
 functions for AX88179A
Message-ID: <6cbd0d83-9802-4e02-ba1b-4cf76cb51659@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-3-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-3-bdde4f905883@birger-koblitz.de>

On Fri, Jul 24, 2026 at 09:36:46AM +0200, Birger Koblitz wrote:
> The AX88179A uses a much simpler Clause-45 MMD access interface,
> which are made available through ax_read_mmd() and ax_write_mmd(),
> which in turn call the chips' respective implementation.
> 
> Make use of these functions for stract MMD read/write operations.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>  drivers/net/usb/ax88179_178a.c | 39 +++++++++++----------------------------
>  1 file changed, 11 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index b90a75a11024c58192bdb4a9436636bc9312148c..b7837c7a89f9b5ee520ef1ae91bbc7619d1a12bd 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -985,22 +985,19 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
>  	int val;
>  
>  	/* Get Supported EEE */
> -	val = ax88179_phy_read_mmd_indirect(dev, MDIO_PCS_EEE_ABLE,
> -					    MDIO_MMD_PCS);
> +	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);

All these look to be standard EEE registers. phylib should be handling
this for you. Put a printk in genphy_c45_read_eee_cap1() and make sure
it is being called.

Basically, anything which is part of 802.3 clause 22 or clause 45
should have helpers in phylib, and in most cases, phylib itself will
take care of it. A MAC driver touching the PHY is generally a bad
design, a layer violation. So any driver using phylink or phylib, all
direct access to the PHY needs to be removed.

	Andrew
