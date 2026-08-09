Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F2282F0E;
	Sun,  9 Aug 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290668; cv=none; b=Oo0bgBRG2FH82lMKPYNRqxIrxySg553vid07ik4RgYlYRcOyjBqQdLKdF1JIKijiJScLdK312Z1swsfu/87rpEiNge2YYbFpbYt+XNsQrkyHCzv1TgV+uU4xPL6O5+I706F0CGcgVYRJfshFQdjArQ72EC37c38pp6nj9q/SnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290668; c=relaxed/simple;
	bh=w+Itt6ZD1Vs4N2aUI7pQaqQBvvL8sDAcH0olZuIcjvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqERPKjdkNrpLVKSvBJoF+bC8LiUf0YznpujqPyAw7TGMQGlmI7//iCzWx0YkF0iLh+SntWgfKybAkLEIk6gfzkqhLGe491KLJmXF1kug+5zylB5zQi8EYV4wQpA/S4MKk0J/4ZdVLNzKc/tr9YjVIHci4kGe5S9LQzWdwTHSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VlWXoG0d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VlWXoG0d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FgNLfj3pfkm7LDmMsixDlk5BWQLGphalBVmSeIOSmRU=; b=VlWXoG0doB9riYD5Hmpl5/zZwi
	+IG8ajM40E3Mz2kKc1lZxfmmnDhZlu0QphOlr1F4PNfkem6mgCRZQfV9Dm4jE6St6PTf8wWSg3iGc
	Ho13wYhuVzyXUKaY2BWFQrfQFLimWeAN4I+AxquKGPRmHV+LL9PdWHZ2UMzopQ6jipls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt5nd-00GpEc-5p; Sun, 09 Aug 2026 17:50:57 +0200
Date: Sun, 9 Aug 2026 17:50:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: phy: add X-Powers AC200/AC300 EPHY
 driver
Message-ID: <c78c2c35-52e7-4393-9714-06039d8a3f28@lunn.ch>
References: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
 <20260806-submit-acx00-of-dynamic-v1-v4-4-9bf2f7441632@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-submit-acx00-of-dynamic-v1-v4-4-9bf2f7441632@gmail.com>

On Thu, Aug 06, 2026 at 10:51:29PM -0600, James Hilliard wrote:
> The AC200 and AC300 contain compatible Fast Ethernet link PHYs, but the
> link endpoint is inaccessible until package-specific control registers
> have powered and configured it.
> 
> Add one PHY driver which binds the link child and joins its parent
> Ethernet PHY package. Fixed package compatibles select the corresponding
> backend. The generic ACx00 compatible reads one packed configuration field
> and selects the backend before touching backend-specific resources. The
> AC300 path therefore does not resolve or enable the candidate AC200 I2C
> device.
> 
> AC200 obtains the regmap of the referenced I2C MFD and keeps it bound
> with a device link. If CONFIG_OF_DYNAMIC is available

Please drop all the CONFIG_OF_DYNAMIC code.

>  drivers/net/phy/Kconfig               |  11 +
>  drivers/net/phy/Makefile              |   3 +
>  drivers/net/phy/xpowers-acx00-ac200.c | 388 ++++++++++++++++++++++++
>  drivers/net/phy/xpowers-acx00-ac300.c | 404 +++++++++++++++++++++++++
>  drivers/net/phy/xpowers-acx00-main.c  | 536 ++++++++++++++++++++++++++++++++++
>  drivers/net/phy/xpowers-acx00.h       |  28 ++

Since there are 4 files, i would suggest a subdirectory.

> +struct ac200_ephy_ctl {
> +	struct acx00_ephy_control control;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock; /* Serializes power sequencing and state. */
> +	u16 ephy_ctl;

What is this locking against?

> +	client = of_find_i2c_device_by_node(ac200_node);
> +	of_node_put(ac200_node);
> +	if (!client) {
> +		ret = IS_ENABLED(CONFIG_I2C) ? -EPROBE_DEFER : -ENODEV;
> +		return ERR_PTR(dev_err_probe(dev, ret,
> +					     "AC200 device is not registered\n"));
> +	}
> +
> +	if (!device_link_add(dev, &client->dev,
> +			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		ret = dev_err_probe(dev, -EINVAL,
> +				    "failed to link AC200 device\n");
> +		goto out_put_client;
> +	}
> +
> +	if (!device_trylock(&client->dev)) {
> +		ret = dev_err_probe(dev, -EPROBE_DEFER,
> +				    "AC200 driver is not ready\n");
> +		goto out_put_client;
> +	}
> +
> +	if (device_is_bound(&client->dev))
> +		priv->regmap = dev_get_regmap(&client->dev, NULL);
> +	device_unlock(&client->dev);
> +	if (!priv->regmap) {
> +		ret = dev_err_probe(dev, -EPROBE_DEFER,
> +				    "AC200 driver is not ready\n");
> +		goto out_error;
> +	}

Please take a look at syscon, and syscon_regmap_lookup_by_phandle().
I think it will make this code a lot simpler.

    Andrew

---
pw-bot: cr
