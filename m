Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F351C3BED6A;
	Fri, 14 Aug 2026 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717097; cv=none; b=V785HTDXkZ61IXYKivkH6315wicLGRgxISBIXXnqVJWUX49DB0bNs6ljNZ49jhN1KNDwKj8F5EcWrl48s5hiuAErPar7kE3R/aFyyXC9SDbk7XWCNulrezxnNpOGeoRkAvx7qcm6bWCJ3qmFr/XwNM4QgFt2KSFh9xtjwE0qpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717097; c=relaxed/simple;
	bh=85qsFmALYx0XgSn1U2PCyouY2SHFzBxGYNNNftneUAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rycIH/oSwjtgpl6nuzqF/7o+yH0R6NoTfgvl/KiBLOeYgyIsLhNV8I0dobcoO8vI8QX75zQHw3/URmx24h9gmXM/ZdJfWEMck0u7myYSA573biq4iJIIkEZCtMLmdck8ixYmOqu+aFvCrFGvU1rz4go01oErvOo3QXr96OBk4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b2Qbivzg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b2Qbivzg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rVc/1WiG5+2xwUrmVt7kAUJxHNr1G9W8pSEB42oZO98=; b=b2Qbivzg+rUo1riqRxNontWbfn
	xulOUhUT7ch+t+zfAbRtlEYAFfcz/zsbl/I7ZR4TXKJJ4XFgIzAh7pyPdhvu83pDAOnvgvjtibAGS
	j5VILfWxHJ9mjsvMuocvytJfDXMQ/4aeeaxL6NF3mBePiJiaSatC3ZslhdIKnvh8duAs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wusjU-00Haqi-41; Fri, 14 Aug 2026 16:18:04 +0200
Date: Fri, 14 Aug 2026 16:18:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Avoid uninitialized value on
 MDIO read error
Message-ID: <131ce445-605c-4408-aa25-fcd32f53c301@lunn.ch>
References: <20260814134006.1386372-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814134006.1386372-1-ruoyuw560@gmail.com>

On Fri, Aug 14, 2026 at 09:40:06PM +0800, Ruoyu Wang wrote:
> An SMI timeout or PPU access failure can make a Clause 22 PHY read
> return without initializing its output value. When reading MII_PHYSID2,
> mv88e6xxx_mdio_read() still passes that value through the internal PHY
> model-number workaround before returning the error, causing an
> uninitialized stack read.
> 
> Run the workaround only after a successful PHY read. This preserves the
> original error and leaves successful PHY ID reads unchanged.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: da9f33018e2c ("net: dsa: mv88e6xxx: Workaround missing PHY ID on mv88e6390")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 80b877c74513d..e71707ce71cbc 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3770,7 +3770,7 @@ static int mv88e6xxx_mdio_read(struct mii_bus *bus, int phy, int reg)
>  	mv88e6xxx_reg_unlock(chip);
>  
>  	/* Some internal PHYs don't have a model number. */
> -	if (reg == MII_PHYSID2 && !(val & 0x3f0) &&
> +	if (!err && reg == MII_PHYSID2 && !(val & 0x3f0) &&
>  	    chip->info->family < ARRAY_SIZE(family_prod_id_table)) {
>  		prod_id = family_prod_id_table[chip->info->family];
>  		if (prod_id)

Ugly.

Please do the usual for checking for errors and returning.

Also, this is not worthy of stable, please drop the Fixes tag, and
post to net-next.

       Andrew
