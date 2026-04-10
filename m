Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E92D9797;
	Fri, 10 Apr 2026 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789006; cv=none; b=n/F87aTO5Pe3FXxC19Cp7FSdeNUKCcE7uhjl4hiJEKtzDNbOy9CCdPxhditl3LF9eW9HuWX+0dH9nkyum8nFm9da0LXocvYS2WHGgsZC7t/oBtyGRCJXbqAI2tYVn27jqavzHxfCRWT1AHYFqEFZKbqBucaPJWfayKQjin6J5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789006; c=relaxed/simple;
	bh=ZdMH/YN5M+5uPPUjGHjHRxVHutLXJKr13sKXugTz0Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr8oYBevILfzZKNhVDoe41dAOFA1Hz4K/v7stQbApL2nDHr94FpQDSFvE3FuK2TbD0NGEvEfC+0fWhD859XzfgbibWnfcyMQEdN4gWzG9Jiz8tmaabSHVbgZtAVc+NMeCuzcjIEb0YNScboAL0izgABIhD52nKYdILmFxNAG4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pcZ89OBr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pcZ89OBr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r7gvNbqBmzmOy42p4djtAgVS7wsnqiaZP0IwIWcJvsc=; b=pcZ89OBreUQMD+0rTcl3BC6alc
	fJIGsJVtX4ugJM6aL0zp/DJg31qYBMaodAq+uMMJKVHaxDTFpXyMKW9ph6zJKV06luPUbNKdSrDbd
	R388kljO4QzOTeid4Lhb9C1/+k838ELvTQDde9215fkTRCIYNUiv6VPvvkxR73OnA83U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wB1pu-00FWnz-Tq; Fri, 10 Apr 2026 04:43:10 +0200
Date: Fri, 10 Apr 2026 04:43:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] r8169: implement SFP support
Message-ID: <cdb01a67-8699-4bd1-9212-5ca318eb0d28@lunn.ch>
References: <20260410005331.2045-1-fabio.baltieri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410005331.2045-1-fabio.baltieri@gmail.com>

On Fri, Apr 10, 2026 at 01:53:31AM +0100, Fabio Baltieri wrote:
> Implement support for reading the identification and diagnostic
> information on SFP modules for rtl8127atf devices.
> 
> This uses the sfp module, implements a GPIO devices for presence
> detection and loss of signal and i2c communication using the designware
> module.

I would probably break this up into smaller patches, GPIO, I2C, and
the swnode.

It might be you need to Cc: the GPIO Maintainers, the I2C Maintainers
for those patches.

> +static int r8169_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct rtl8169_private *tp = gpiochip_get_data(chip);
> +	int val;
> +
> +	val = r8168_mac_ocp_read(tp, 0xdc30);
> +
> +	return !!(val & BIT(offset));
> +}
> +
> +static int r8169_gpio_init(struct rtl8169_private *tp)
> +{
> +	struct gpio_chip *gc;
> +	struct pci_dev *pdev = tp->pci_dev;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = &pdev->dev;
> +
> +	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
> +	if (!gc)
> +		return -ENOMEM;
> +
> +	gc->label = devm_kasprintf(dev, GFP_KERNEL, "r8169_gpio-%x",
> +				   pci_dev_id(pdev));
> +	if (!gc->label)
> +		return -ENOMEM;
> +
> +	gc->base = -1;
> +	gc->ngpio = 16;
> +	gc->owner = THIS_MODULE;
> +	gc->parent = dev;
> +	gc->fwnode = software_node_fwnode(tp->nodes.group[SWNODE_GPIO]);
> +	gc->get = r8169_gpio_get;

So there is no set? The SFP cage has a transmit enable which is
generally connected to a GPIO output. You can use it to turn off the
laser, which phylink will do when the interface is admin down.

Can you trace the lines from the SFP cage back to the chip? At least
see if it connects back?

Are registers 0xdc30 +/- 4 used for anything? Maybe there is 16 GPI
and 16 GPO? Although that sounds like a lot of pins. Or it could be
there is a direction register, and an output register.

This looks quite good otherwise.

     Andrew
