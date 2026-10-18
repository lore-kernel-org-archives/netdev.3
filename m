Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBD3822B7;
	Sun, 18 Oct 2026 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350849; cv=none; b=Fqqq6zEllXcx75rTvj6IbNTcPOaQYRnKQyuGk7snN+bbs1GdoHStRkTiH4kul8CaHb9V+WRqfxt1JpipQvHEcU57XoWgHVTS8w79oI/V94uBnzy5DwLEgSbmT6+QYVZ59kgQnlOSUC5tq5A1eRG2g/dOK61GsLl0HYC5YGwkClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350849; c=relaxed/simple;
	bh=ZZ4Jr6igQloVs1kOy3pHxivzGlidTY6Iphg3SZY0OEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX6BtsXmBd7i10MSuyqMuaG6R3R8yJSfUfEXtM1DO/uHmRaJ6ayT0wtyFW5pbSXPRKXBUV9Kl7hNKCQkwwMCrELOwbO49sUKRrEd7GHCDea+DFZ19LsPH17EeG7dHu3SYtpaC+XVr7foMauTP5ywV5VArIzpjc+8f2gX3irv34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yPYY2r0i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yPYY2r0i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qHbV8LAtUSWSGGDa0h86rBDpCNFJieHVVQNqm9YZ5qo=; b=yPYY2r0i/4SBAk3Wp2l0SNL8ht
	UhECU/Z+YTPeuUAGG4bK05uHGVaL9zmDZqEXfQpSxbMN8xQ53XZ/VsSLCh/3gbNaBOqCucVd18NNh
	Odoib4cVuTRL0P2imPCAQ79rahZeX1PMcn30hXj9SuRp/KcfqjRUCi8YpdJmjnXyFHsA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIWKI-00BWKf-O9; Sun, 18 Oct 2026 21:13:46 +0200
Date: Sun, 18 Oct 2026 21:13:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: air_en8811h: use firmware loaded by
 the bootloader
Message-ID: <2d6df47b-2cc3-4003-85db-f72b878427d9@lunn.ch>
References: <20261017180251.3618606-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017180251.3618606-1-f@lex.la>

On Sat, Oct 17, 2026 at 09:02:51PM +0300, Aleksei Sviridkin wrote:
> On a Keenetic KN-1012 (MT7981) the EN8811H sits behind a port of an
> MT7531 switch. The driver has to be built in there: as a module it loads
> after DSA has validated the port against the generic PHY driver and
> failed to set it up. Built in, it probes when the Ethernet MDIO bus is
> registered, before the root filesystem is mounted, so
> request_firmware_direct() fails with -ENOENT, the PHY stays without a
> driver and the port never comes up, although the bootloader has already
> loaded and started the MD32 firmware.
> 
> When the firmware files cannot be read and the MCU reports ready, keep
> the running firmware and let the first .config_init() restart it, so the
> PHY starts from a freshly started MCU as after a download rather than
> from whatever state the bootloader left. Nothing changes when the files
> are there. A board that relies on this must not give phylib a
> reset-gpios line, as the pulse at registration stops the MCU. The
> AN8811HB path is unchanged.
> 
> Tested on the KN-1012: with the bootloader load the PHY binds and links;
> without it 0x8009 reads 0x0 and the probe fails as before; a rebind with
> the files present downloads them as before.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> This replaces "net: phylink: wait for a PHY that probes after the MAC"
> https://lore.kernel.org/netdev/20261006124731.1528963-1-f@lex.la/
> following Andrew's suggestion in
> https://lore.kernel.org/netdev/b175c750-104a-4859-a137-09de78a6d8bb@lunn.ch/
> 
>  drivers/net/phy/air_en8811h.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index a03d63dd4ac9..efe4e64d213a 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c
> @@ -518,6 +518,17 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
>  	return en8811h_wait_mcu_ready(phydev);
>  }
>  
> +/* No firmware files, but the bootloader may have started the MCU */
> +static int en8811h_use_running_fw(struct phy_device *phydev, int err)
> +{
> +	if (phy_read_mmd(phydev, MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS) !=
> +	    EN8811H_PHY_READY)
> +		return err;
> +
> +	en8811h_print_fw_version(phydev);
> +	return 1;
> +}
> +
>  static int en8811h_load_firmware(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
> @@ -526,11 +537,13 @@ static int en8811h_load_firmware(struct phy_device *phydev)
>  
>  	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
>  	if (ret < 0)
> -		return ret;
> +		return en8811h_use_running_fw(phydev, ret);
>  
>  	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		ret = en8811h_use_running_fw(phydev, ret);
>  		goto en8811h_load_firmware_rel1;
> +	}

Is it possible to figure out from the firmware blob what version it
is?

There is no point spending time downloading firmware from the
filesystem if it is the same or older than what is already in the
device.

	Andrew
